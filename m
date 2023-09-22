Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD437AB838
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjIVRwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjIVRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:51:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064761732
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d9cda925so2253156b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405064; x=1696009864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AS3G4n4TBFZWhDodrFk3+wfFKjlDza+m4CiwBMh4z08=;
        b=d+2RKER55W5nufMg71buhJolDsS2gCKDAcGqF4zJ3Pe0Z2jqLG7gZ5IlGJbK9ppX/D
         1x8IBxHP3w+hJ+Y7MfRERAxWTzfOe/kTFHa76d/4rbZgQ8vI+FGn0CVtbrFUm8AGcaCO
         EDHBzGuU9UekK3CSKXQMjA+VzElujTGJ+Y9G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405064; x=1696009864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS3G4n4TBFZWhDodrFk3+wfFKjlDza+m4CiwBMh4z08=;
        b=T/inegf28wVTQwwnpUW+G3Pal4YLoZcx4zTOsdbYna/5dLlIOCmcBCNF+fLvXeGhNK
         rxe7WQxjltccV3bNrgR2sTlEVijFdIFNFQ3R/OjiILVk1my3yO1cPvgTAIAMwRFUy18P
         SdJAkdYCgZbT0eYA9gQkoF90MKNb66uhJ7KHWYV5D04u1PGeTAnRP9fED90K6oOw7tfo
         5s/tUdcp66N0qXsjBJVbtCYNR7AN23puC1TqEU2Ail4XYqd2jzbKHFT0GPzmdTv9e4cQ
         UKqgmrVXarjZyE76buYXzr1j+oETQFOtcGmj8jQKUomPzwRHntuxcCZeycvnue56uDyv
         WlgA==
X-Gm-Message-State: AOJu0Yy09PWtYdKSH5uKsvEZrYP0tFd0YBx9xcBCg+5XrgaKwKi32CQ9
        NjKsEDbv3UZVwIvJiuNOAlQKSl9xoGlYxzUV7OY=
X-Google-Smtp-Source: AGHT+IGLDAq3MUcFFuNLeebQrEVNYfC4hyT+uym98wqR6tkiiL0SzvbhaluyWujG5by309PhCugq0g==
X-Received: by 2002:a05:6a00:b8a:b0:68f:c1e0:a2a2 with SMTP id g10-20020a056a000b8a00b0068fc1e0a2a2mr140611pfj.2.1695405064282;
        Fri, 22 Sep 2023 10:51:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c5-20020aa781c5000000b0068883728c16sm3578344pfn.144.2023.09.22.10.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] virt: acrn: Annotate struct vm_memory_region_batch with __counted_by
Date:   Fri, 22 Sep 2023 10:51:02 -0700
Message-Id: <20230922175102.work.020-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=keescook@chromium.org;
 h=from:subject:message-id; bh=WaY2kTn1yazHmHr2C26ITAqyjQkyOX3EcAXSRAFMvEA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQGkCer3a+lUOaX41nf4FcmcDwvJGoS1PC2Z
 Iea3hnu5/OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UBgAKCRCJcvTf3G3A
 JmrtD/9ts1iJRTn7bBnCOgTmeuo7qoznjoC5NTZ4ik9kMqawaTuBpBZ1WS8SBzYaVsI8OhxmZZc
 xtx8FWQrwBaVz/uohBSxVolrfYlB3eF7ma2LKObYd83wqZL+ZThz6qTZCl+sqMOAKge7u/sF+3p
 EoGtoBiTriiCo0zWetez0Y6CcfC17sACn59R8WwX3XMqF9Hx7/zU2nPtRnRPH1B001HUKJnRyQP
 fNjZ6HITNFGyWZNMZeybw5era6sVgjqAwpvJbRMhO6R87FF4lZ2DdWlgx5bhZppw5goxZ+wctbO
 5fAg7ymNors8GOvDWnQwKhUlXn4LUQAeqMf6+kRZz9mY4Y7XsP0QAq6V4DDdpgRa8FEL3HPW4Rq
 SAeVc4p5ZFsdUH+HeNbYcQVETfjeXCbUPrNdv7gE/uzPmROo6wBUTB+CG7YFUDudDyLm86Hus7n
 3fAgTATbG/IiEgghWm2cZ5TI4mqw0jD3x+f9KnSR1/EClerCP31Mo5zp6XhCyf+9Xr4oJ3Th4dn
 uPSG0PiTPvnM//nEhcYelWoyHfOieXsssjSmglLpV74yncScIy2fWA7UqXuxTJuqgbwS+/XKQZ2
 IklKbqDIGO2aoyPmqUhGyrUI2MtNGJshZ71rWLeQMXHQ0rwRe3D2MFerE7eOYH+eHbd2dNILfjP
 mxMYluz dDRVsfCg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct vm_memory_region_batch.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Fei Li <fei1.li@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/virt/acrn/acrn_drv.h | 2 +-
 drivers/virt/acrn/mm.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 5663c17ad37c..fb8438094f6f 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -60,7 +60,7 @@ struct vm_memory_region_batch {
 	u16			   reserved[3];
 	u32			   regions_num;
 	u64			   regions_gpa;
-	struct vm_memory_region_op regions_op[];
+	struct vm_memory_region_op regions_op[] __counted_by(regions_num);
 };
 
 /**
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index b4ad8d452e9a..fa5d9ca6be57 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -250,11 +250,11 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 		ret = -ENOMEM;
 		goto unmap_kernel_map;
 	}
+	regions_info->regions_num = nr_regions;
 
 	/* Fill each vm_memory_region_op */
 	vm_region = regions_info->regions_op;
 	regions_info->vmid = vm->vmid;
-	regions_info->regions_num = nr_regions;
 	regions_info->regions_gpa = virt_to_phys(vm_region);
 	user_vm_pa = memmap->user_vm_pa;
 	i = 0;
-- 
2.34.1

