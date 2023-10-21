Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B496A7D2063
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJUXMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUXMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:12:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C8D78
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso29201891fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697929960; x=1698534760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58Eo+qEtvIjLh9UY6FY88GQO7Bn+aYS8BK4MYosjEHM=;
        b=PrzrapvtQJKHzSQVbp4IlxuUsw6HOb9V+YLsBOCuOUtqjSjoQkfXSAQLGtVuSPRUdD
         JYgSU8Ykmu7J168s/VfV89FyWR3rMHOUHMFZ0BIMt85KzaZXSK6r22CDUFt3hd3pXeHi
         vCPV68akeJKUczQVwMYhtiUvnlnhCrqYTXV/aK7AWd5JYxqZ7SEKlF1ux06N4uZVwi1w
         NLmYazPbcWCJak3rX4b8kWo4aWu5QpU1Cz0cic1bu17z1BMvKU/Y3v7Xj3J0BorgggxN
         24B3RcqxwRQW9nn+krVr2oeicJ7OMXiXCYM1MBH+uFhEwQGctJ3CQzwxOfMHlh9Ei6T7
         DdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697929960; x=1698534760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58Eo+qEtvIjLh9UY6FY88GQO7Bn+aYS8BK4MYosjEHM=;
        b=W8pbPfQ37BOYd0D3LdsoDw1tP5SjxE5o0mrzVLL+du/a63/eQ3NZG3e904ihGOr6sj
         sb6R1y4SsoFovlMXXS68RUXxwag7zy4oleiRMLe3lhMGvY03jR9KxCSaaqh2BPY/HRRy
         yTuG5CDqfStnBPJ+Xsuq1a8TIr/gFkTw4UFxpYujhghgYKDjUUkdvsWNfdKs9OWq892U
         kFXIcepBbcQE50Nq8n1rGyyQmvt0p/NHfMREk+G3+v6XWPGJy/n47H6w8oS0i3iDdJ75
         3H9JA1UkY4Uc9LEl4dYnFlhUkwmDTm8qSgxuwTf3210E+MNdcAHqsf5QO3U0s3g5sPUz
         npAA==
X-Gm-Message-State: AOJu0Yz/pwFGbcpVrnSZxzp/nnHUTO+DlXIrSEBriSsjhLVqyT2EHEmu
        tFPF0RNodZ2qOh3ffOdVXtFoyXM8tS29o0Ri
X-Google-Smtp-Source: AGHT+IH22DnBv5tZD7jH7UBvDltokJlxy/V9phy9m0A1YU0bNsyZdfWEg/MZ1/OXJEAOhtD+UlDl8g==
X-Received: by 2002:a2e:2c09:0:b0:2c5:578:f998 with SMTP id s9-20020a2e2c09000000b002c50578f998mr3515600ljs.26.1697929959985;
        Sat, 21 Oct 2023 16:12:39 -0700 (PDT)
Received: from gilbert-PC ([105.113.89.119])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0040641a9d49bsm5573827wmq.17.2023.10.21.16.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 16:12:39 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 0/5] staging: vt6655: Rename variables byCWMaxMin, bySlot, bySIFS, byDIFS and byEIFS
Date:   Sun, 22 Oct 2023 00:12:26 +0100
Message-Id: <cover.1697927812.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the variable names adhere to Linux kernel coding style and fix
checkpatch.pl errors.

Gilbert Adikankwu (5):
  staging: vt6655: Rename variable byCWMaxMin
  staging: vt6655: Rename variable bySlot
  staging: vt6655: Rename variable bySIFS
  staging: vt6655: Rename variable byDIFS
  staging: vt6655: Rename variable byEIFS

 drivers/staging/vt6655/card.c   | 72 ++++++++++++++++-----------------
 drivers/staging/vt6655/device.h | 10 ++---
 2 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.34.1

