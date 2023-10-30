Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B97DB971
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJ3MFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJ3MFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:05:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59947C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:41 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 389F23FD39
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698667539;
        bh=7WB8+dzA+A9FwbTE3H0wb8DTd4y1xgyz1TXm5BpP+xY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=j9ChfkXyj1heNBolzRqdOdcD+JYH/xOVTzZuqBUyT0hEXatJMcg7bUMhpPUlgb+9K
         bNiaD/3Dgww9/BjcL5AqoCfHHhKUiFQoAdEL6QZQ8ngP2ROakHqUcsWIQdJRLYj641
         PCPfY3NtaojmI7BWJGq/x0pO+hDTAQYGTO8sS/dlbJL8f5vCkthrd8b3O1xIoiRIff
         iyJJAQh/Yeo4Qmv4Otk3H2WQ9MzkTdAkpC2WztPNjE/Ek6RQynFECpOOGdY+r/Gsrq
         g3zWdBmb+6KilX/noUUID5U4Ldi4eAHySwJU9uMIQWM1aEEvmksz0OuE1HcZD7fGPZ
         j7OBE83rvO4Vg==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c503804667so47163351fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698667538; x=1699272338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WB8+dzA+A9FwbTE3H0wb8DTd4y1xgyz1TXm5BpP+xY=;
        b=bg5PS2yks8nGjlAUPjeeaa0AkL9ZXWu59F9RF/w9S57cLLLAJnuolL3Xbno7VhWNir
         +d3q7uqhxspR6iMEP9JoV8hT1W8Sdfv1KggtyroLLkgMOerbXyrQMw2CQMAD7gUYMbgX
         x9flNPkp6EpedO4iVtgevhfpZKhfjsV8jUszfipgvJlq/Fb6yuR/+gGAQ8jpFSlB+An7
         uPyhiQCXKlnAJM4qPEzcf62PbWC4JYLzyopgly2vq1wlrqr6gmbJVU0pt51zXFjjP+8w
         EDxMHOBldDvxH7bwDuiWQZsWGTgr+pcVQCFGN0W7AIk9y2p3zjI0CXNAdAdyul2Ch/RB
         tvZQ==
X-Gm-Message-State: AOJu0YwnqYQ20cuOICapvGnvzT7mfkPu7jbjxTi4Hjf41mZOAh/iFU42
        WZRWrJXXJZkfdI7DTDRiqkQQQz7DBX1xNXEWODu4WqtkEWT25UFgRvvBvZPuYD22oCGfxfddgeU
        lEUPY6iASAfN0Juk5v54fVVR5PqSCJnz8w2hsLMs5fKkx/XwT1iYsz30=
X-Received: by 2002:ac2:44c4:0:b0:509:dd0:9414 with SMTP id d4-20020ac244c4000000b005090dd09414mr3826079lfm.24.1698667538073;
        Mon, 30 Oct 2023 05:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHsT8rkWtZkhjznGWEjGRHTYYV0lbpkqqzlBl/OJ07Ds5/1iMxxgqafP2qYC8sQC6/xf/vdg==
X-Received: by 2002:ac2:44c4:0:b0:509:dd0:9414 with SMTP id d4-20020ac244c4000000b005090dd09414mr3826063lfm.24.1698667537725;
        Mon, 30 Oct 2023 05:05:37 -0700 (PDT)
Received: from localhost ([159.148.223.140])
        by smtp.gmail.com with ESMTPSA id f18-20020ac25332000000b00507f0d2b32bsm1420458lfh.249.2023.10.30.05.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:05:37 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     smueller@chronox.de, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drbg small fixes
Date:   Mon, 30 Oct 2023 14:05:12 +0200
Message-Id: <20231030120517.39424-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 update of the
https://lore.kernel.org/linux-crypto/5821221.9qqs2JS0CK@tauon.chronox.de/T/#u
patch series.

Added Review-by Stephan, and changed patch descriptions to drop Fixes:
metadata and explicitely mention that backporting this patches to
stable series will not bring any benefits per se (as they patch dead
code, fips_enabled only code, that doesn't affect certification).

Dimitri John Ledkov (4):
  crypto: drbg - ensure most preferred type is FIPS health checked
  crypto: drbg - update FIPS CTR self-checks to aes256
  crypto: drbg - ensure drbg hmac sha512 is used in FIPS selftests
  crypto: drbg - Remove SHA1 from drbg

 crypto/drbg.c    | 40 +++++++++++++---------------------------
 crypto/testmgr.c | 25 ++++---------------------
 2 files changed, 17 insertions(+), 48 deletions(-)

-- 
2.34.1

