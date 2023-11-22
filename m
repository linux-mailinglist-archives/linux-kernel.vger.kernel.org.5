Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21997F41D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbjKVJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjKVJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:42:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0DB10C;
        Wed, 22 Nov 2023 01:42:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so4246358a12.0;
        Wed, 22 Nov 2023 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700646125; x=1701250925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abM4W7xPRLNxSr6XVpDl8XekNAlf56sZOpqa2J1fPeA=;
        b=PZyJh801bN8aZubpXbYXUNIAKBkJDSc0EqwLd0cGoLT19sHEPEU1Fk2ubJzYHY268x
         R3mzqkuwj+Ov5jsmagT7ySIuRfpmx0wJ9n3jpc+TppUwLkOrXV8nrF77/rPLyaW9hWLb
         nX9k4UGIyECjp2axANWstw9xvYkFQs9H5GSRzldExmQ648gx9fLDVOdEi2svkuJDgAOu
         ST7a+v8qUt86O8hSuCi5YoZTkQvYc/xrDJEWAeGJa2wVPNj3E3meID95VVPZTJlZKf1+
         /a97whNOeB2jif//wB3rm31DrtZ6qViU87simbPnvnzNBAHdwFR++/CKBWXqVxumQWQi
         pZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646125; x=1701250925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abM4W7xPRLNxSr6XVpDl8XekNAlf56sZOpqa2J1fPeA=;
        b=afMsjM9I/Z/GMKW8VigBiURuRTohZDmL48eZk3qqAQqo0IVcL/EjbehcaenU22Cqwf
         TcJ6suCKSjAkPqBMIc6SbwG87nEjfMmdn9Y/Gv+Ko3Wj57BAisoXDTeDpG0AqPD3lGvu
         HmqOc5fG4362jc1b4LRLIqfonvne+p4hwkTpYck3V4b0xWlt6IRZ79Kp9PVFvakucuE4
         RNU39rXMwuxbj7p9aSIrKRmGMNR8V+5SilAFOPZkJdAehzRaF6X2cWOfCGbcrH9o3jJZ
         JPdwdraPuSP8k/zvC2akaC/+ero0Dzw2mU7zh1cDtqlLbhC2bTnU99Oy9bTkAaEcEm3N
         49CA==
X-Gm-Message-State: AOJu0YzIYog+ryWntC4nwnlxgDcT7oK+vP8L/N71dHtciPQpz1A26azf
        yNwjsEDeNpYzpgyGRlRfLUg=
X-Google-Smtp-Source: AGHT+IHqeWNO23DIW2lYuAdRhp6TKZ+eKAtoCVKFyJQdL7W+3OHe2cC/WMjkijKCBJRvRfwDqiTwfA==
X-Received: by 2002:a05:6a20:2c91:b0:187:ce9f:e198 with SMTP id g17-20020a056a202c9100b00187ce9fe198mr1422428pzj.5.1700646124816;
        Wed, 22 Nov 2023 01:42:04 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a488e00b002851466f471sm937659pjh.31.2023.11.22.01.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:42:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 5B10110210547; Wed, 22 Nov 2023 16:42:00 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] MAINTAINERS update for VME subsystems
Date:   Wed, 22 Nov 2023 16:41:54 +0700
Message-ID: <20231122094156.30642-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=bagasdotme@gmail.com; h=from:subject; bh=2Jh5t3H6agB2YlqKVyZOWg3kjv4ysogPOLg7wiXeDUc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmxpx/vc4r/zffF9Mi7w+4/1SZPCBAQnq/Vtqp14lyV5 bFTuKZFdpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAi5/8w/Gabr/jL4GbTtDhl YRXmEI4lp0RnbOp+u2GKcONyFy1udTtGhsklKo7i22cs5VrgefKDJOsLZtZZd6unf5z19qJxUY2 TMj8A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Martyn's last VME subsystem review [1], VME maintainers are inactive
with respect to the subsystem. While Martyn is now working for Collabora,
Manohar is AFAIK MIA (his last email about 9 years ago).

Update MAINTAINERS to reflect above situation.

[1]: https://lore.kernel.org/all/3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk/

---

This series is based on v6.7-rc2 (same as current staging-next HEAD).
Greg, you can pick this series up via driver-core tree if you want.

Bagas Sanjaya (2):
  MAINTAINERS: Update Martyn Welch's address
  MAINTAINERS: Move Manohar Vanga to CREDITS

 .mailmap    | 1 +
 CREDITS     | 4 ++++
 MAINTAINERS | 3 +--
 3 files changed, 6 insertions(+), 2 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
An old man doll... just what I always wanted! - Clara

