Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208D5782CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjHUPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjHUPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:04:20 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAB5E8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:04:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a812843f0fso2047800b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692630258; x=1693235058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nsDNl9d4lshcExFhxOmfvT78+yT9J12bXqiEl8z3Wk=;
        b=Nsqjc+xPmg9p6wrzEXmKeYc+RXEIVfrxs6JTs/wnImB8BHukr5xyEHkwYJFuXv7hFW
         XzRcJumjO7r3YPqNwzsVd9JeY63M2FZixYGmD04Dzz/WvUSF8bQI23Ob9tsS+cEH/Kyb
         5zXlnkTKokCbvjME5SwTPRdZCiCYXKoEojY56VfZncFa4MOqkcqnFUbSWAZW29XddIy/
         KMJjSIC698zTe8H8TqeFsyvM1Ou9Wg76bq/twCq/6k7uAFxO+lLizVj+p9nPO6K2JOHQ
         J0xaH+sqNFv2s2FTCgdYL7QroY1qGz8gzakmhotueEOQdsqrEzBhHfIu3ph74Y9Seipp
         RT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630258; x=1693235058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nsDNl9d4lshcExFhxOmfvT78+yT9J12bXqiEl8z3Wk=;
        b=YufOJ3n9XP5COX10N/8dLwRk+q7+DqNsSW3sMv2o/uod6iX249Jsk0SN86m0Maxm8m
         dujHLFr4BcfFzdsxSZIt6wr5N0azdX6tVuKTXgsbcLNFRv+AqHkkbV5kaRtUJeR9HSw3
         WC1uawFxPmrBTCVxaeIMrk/7VBgB/owArM0D6Mekbf8lT06mFxQErs9HC3ICbB3RpnrD
         dONYXHKXZaSWRGjiMIkuPIOyDRGqhoOjkoUTD1gCql8/MmNaKNni9nL1G80bzZTEeljQ
         hvVf2s+179BwEHyC3Glx24q05ZqTi/hfDUO98PPBWRrxN8gcr7OK9hirfGxwlPqCwIMu
         gnKg==
X-Gm-Message-State: AOJu0Yz1200XYaTeArgSnSG/iPyYLc8Y1QbaBDU1TT4d/0mQsUGfTpZD
        Tve5I11b4cYUEBk8Oqvg59s=
X-Google-Smtp-Source: AGHT+IEAyShw7iDgkxpkmRqpOp+aVd74/ixWDlZbrKwshzv0+M8osDNdld8yOX26K6C1jLh/G0bLNw==
X-Received: by 2002:a05:6808:219d:b0:3a7:543d:9102 with SMTP id be29-20020a056808219d00b003a7543d9102mr8171406oib.39.1692630257879;
        Mon, 21 Aug 2023 08:04:17 -0700 (PDT)
Received: from debian.lan ([168.227.196.240])
        by smtp.gmail.com with ESMTPSA id bg12-20020a056808178c00b003a7a34a4ed8sm3650000oib.33.2023.08.21.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 08:04:17 -0700 (PDT)
From:   "Ricardo B. Marliere" <rbmarliere@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        daniele.ceraolospurio@intel.com, John.C.Harrison@Intel.com,
        alan.previn.teres.alexis@intel.com,
        harshit.m.mogalapalli@oracle.com, michal.wajdeczko@intel.com,
        gregkh@linuxfoundation.org
Cc:     "Ricardo B. Marliere" <rbmarliere@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] gpu: drm: i915: fix documentation style
Date:   Mon, 21 Aug 2023 15:02:42 +0000
Message-Id: <20230821150241.40047-1-rbmarliere@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sphinx warnings in the htmldocs make target:

Documentation/gpu/i915:546: ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:29: ERROR: Unexpected indentation.
Documentation/gpu/i915:546: ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:30: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/gpu/i915:546: ./drivers/gpu/drm/i915/gt/uc/intel_huc.c:35: WARNING: Bullet list ends without a blank line; unexpected unindent.

Signed-off-by: Ricardo B. Marliere <rbmarliere@gmail.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_huc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
index ddd146265beb..fa70defcb5b2 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
@@ -26,6 +26,7 @@
  * The kernel driver is only responsible for loading the HuC firmware and
  * triggering its security authentication. This is done differently depending
  * on the platform:
+ *
  * - older platforms (from Gen9 to most Gen12s): the load is performed via DMA
  *   and the authentication via GuC
  * - DG2: load and authentication are both performed via GSC.
@@ -33,6 +34,7 @@
  *   not-DG2 older platforms), while the authentication is done in 2-steps,
  *   a first auth for clear-media workloads via GuC and a second one for all
  *   workloads via GSC.
+ *
  * On platforms where the GuC does the authentication, to correctly do so the
  * HuC binary must be loaded before the GuC one.
  * Loading the HuC is optional; however, not using the HuC might negatively
-- 
2.40.1

