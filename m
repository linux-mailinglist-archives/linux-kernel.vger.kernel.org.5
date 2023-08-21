Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3278315C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjHUT1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHUT1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:27:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF6189
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:27:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-986d8332f50so496691166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692646049; x=1693250849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y3MozoZGtBbDDuuXCdo2NbhyEnfa2l4nz+CxEl5tKU=;
        b=LiU0lF4mhSeShjnAD+Fe+tJIr+fJCaOBkT1pkyCyKvaa1CR5whsESZgTheC87/kX1y
         y/tfEtnh02qZCslfGD+1bi2Kgb1nm3xxBhmJo1RN3Pf04sD7IgQ06ukLUATFEZm2UFtf
         3d1wuzW6A1Nn9lhSDHxa8W6Vge21/hq2Yug6kbbt55eTcma6CD1yRuInCEpPTthZo69m
         lRntszLDecYDBUWpfscoeDMrbie1fhZD0NEKpCY4R2xhzR1EkB6PLpb62o+X75xI76RT
         J7Zui6ItOmd2SQHYJ/5uaAf0HDHs56xnpRdChGkcAM/weIIADeZKOS+illhrerZ0SU/2
         Ytrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692646049; x=1693250849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Y3MozoZGtBbDDuuXCdo2NbhyEnfa2l4nz+CxEl5tKU=;
        b=IJbZZBWKiMYrr4HZnJdlPiOYxeRnUkbDadxNHP643zAkaXFJHQpE+HMUbleTzKhC2W
         93QdS96eRR6f8WwbsOhq62/x+aY9rr/CAKByRqvpGZ5UJsEvfErtNCXzgcZ36UHf8Tr3
         r2ZOE9+BMv3wKkTwBFL85shV20iyRzp4mF31li6KYht8NU/2nZee/xJYNV/79mUpOzpX
         cbmaNQFVvoiSGjUidBXkXt1qRZXaIn9mLBkNhAmhB7VLFQEWhNbNXHJvDbl+IkmMXBeE
         ulW0WT9BfAzyyn0yn2JVfjtum2b8WR0Kfr5VzgCG7Ql8HZ2Dq+rx4TstGXcXwg4wyWpf
         JI6A==
X-Gm-Message-State: AOJu0YwwuMS7h+XPUimpwUIu5qR5RzjGtNAQ1RUiWFQeOk/ZRFIBTvep
        vT8SYfRCzklPQWBEwgA39XY=
X-Google-Smtp-Source: AGHT+IHE2rVNNbzoz4XXpvUQ0H4g3J7n/mk+iOWWcRGkUeoprZP7ne5rfjceTvp4nKIkM75OozQLhg==
X-Received: by 2002:a17:907:7818:b0:9a1:6d6d:f259 with SMTP id la24-20020a170907781800b009a16d6df259mr5527742ejc.53.1692646049307;
        Mon, 21 Aug 2023 12:27:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:d1d3:c208:e70b:4429])
        by smtp.gmail.com with ESMTPSA id d8-20020a1709067f0800b00992c92af6easm6930814ejr.161.2023.08.21.12.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 12:27:28 -0700 (PDT)
From:   Nikita B <n2h9z4@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        daniele.ceraolospurio@intel.com, John.C.Harrison@Intel.com,
        alan.previn.teres.alexis@intel.com, gregkh@linuxfoundation.org,
        harshit.m.mogalapalli@oracle.com, michal.wajdeczko@intel.com,
        skhan@linuxfoundation.org
Cc:     Nikita B <n2h9z4@gmail.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drivers: gpu: drm: i915: intel_huc: fix formatting warnings
Date:   Mon, 21 Aug 2023 21:27:18 +0200
Message-Id: <20230821192718.504357-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix formatting warnings when run "make htmldocs":
./drivers/gpu/drm/i915/gt/uc/intel_huc.c:29: WARNING: Unexpected indentation.
./drivers/gpu/drm/i915/gt/uc/intel_huc.c:30: WARNING: Block quote ends without a blank line; unexpected unindent.
./drivers/gpu/drm/i915/gt/uc/intel_huc.c:35: WARNING: Bullet list ends without a blank line; unexpected unindent.

Signed-off-by: Nikita B <n2h9z4@gmail.com>
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
2.34.1

