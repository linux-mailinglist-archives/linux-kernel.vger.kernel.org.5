Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87067D2D52
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjJWI4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjJWI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:56:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC8D79
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:55:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3af64a4c97eso1730565b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698051358; x=1698656158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+X2xkuC2sNDVYH+eBpxyEkTF5MdtA/DFvlrj3oX7LY4=;
        b=jeoVmLxdjj3VZzTgk0H1rJcwt9lXOp83dgruTCWNrlZ6w5cdiMwCalEYWAsjQGJLcg
         k+bI7NUiKdhpIKNRf2ymq3wT5AC0ZdzdXzMLPYNaLVQXCewrdea1umlocJaMHlGogUp0
         NxnHuKrtX6Kqq6rIYWnHftQ6e4JWvo8SzaaD0fpJQ13R/GAA8mfdCRnASLuHavd8IpaY
         1vlG4Cnb94JoAWWNKqXED+AjpfA3Ef70CeKa9Gri5c8KSnge7U+m2KOB2IRo/DLmbjvA
         AfdOcHQhO0GRJIM79uJiSxSvLEAdwOT3TvdpZAIGvmkRFAT75xRsji1wjBgfWVduqZNU
         dqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051358; x=1698656158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X2xkuC2sNDVYH+eBpxyEkTF5MdtA/DFvlrj3oX7LY4=;
        b=YlpfF973hDpDusOlRN9SlKXpgGwP8zrWR/Fvi4eHuwoOYTy5HMOQRBdli1L4Md2Bhy
         kNZ0ZvOm9qADpv0/+IxwzY9hbYHF9JJZoBHDUuk2zr1k5EuUoVhF36vQrpu0D/rUz6bQ
         KOfbqB0uOcFxhzt80wo8b6s+4y8V6LX+XkGT315EJUCUbsh+CVlWLTMbNUZOCZ3X3C6t
         r8dHAurktCS2rbutMb4vXjRN73bj8rhozAKSZbyzNpzEXL2U4AJ24AR1HntHGucdKXVy
         cGhDmQT9jSBnGDtH4oFMS5Ju4Ss+XIrdoXAAa6d53r93kDajr9bgUH6K/LDwjCkebaJv
         7j4g==
X-Gm-Message-State: AOJu0YzdgxSplsV+UEp5zvedXCbMbdJVIVuh7fCezXe3UldKWEdMvbrO
        HwqyidGKsWiqSk435GdojEukwkfH2T0=
X-Google-Smtp-Source: AGHT+IGK5M3I1XBkXULHYZYJQIHmqj5zw0tR2Y5mLKSDTUXVgsjSEuijh8CEl4ZF0RXPYmXUoJoCcQ==
X-Received: by 2002:a54:4104:0:b0:3ae:e79d:79a0 with SMTP id l4-20020a544104000000b003aee79d79a0mr6968044oic.30.1698051358304;
        Mon, 23 Oct 2023 01:55:58 -0700 (PDT)
Received: from brag-vm.. ([59.182.192.60])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b006be2f4105d0sm5771083pfw.175.2023.10.23.01.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:55:57 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     jgg@ziepe.ca, kevin.tian@intel.com
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd: fixing build warnings after merging the iommufd tree
Date:   Mon, 23 Oct 2023 14:25:51 +0530
Message-Id: <20231023085552.5139-1-bragathemanick0908@gmail.com>
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

After merging the iommufd tree, today's linux-next build (htmldocs)
produced these warnings:

include/uapi/linux/iommufd.h:433: warning: expecting prototype for enum iommufd_hw_info_capabilities. Prototype was for enum iommufd_hw_capabilities instead
include/uapi/linux/iommufd.h:497: warning: Function parameter or member '__reserved' not described in 'iommu_hwpt_set_dirty_tracking'
include/uapi/linux/iommufd.h:512: warning: expecting prototype for enum iommufd_get_dirty_bitmap_flags. Prototype was for enum iommufd_hwpt_get_dirty_bitmap_flags instead
include/uapi/linux/iommufd.h:542: warning: Function parameter or member '__reserved' not described in 'iommu_hwpt_get_dirty_bitmap'

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 include/uapi/linux/iommufd.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 50f98f01fe10..5585df5b393e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -419,7 +419,7 @@ enum iommu_hw_info_type {
 };
 
 /**
- * enum iommufd_hw_info_capabilities
+ * enum iommufd_hw_capabilities
  * @IOMMU_HW_CAP_DIRTY_TRACKING: IOMMU hardware support for dirty tracking
  *                               If available, it means the following APIs
  *                               are supported:
@@ -486,6 +486,7 @@ enum iommufd_hwpt_set_dirty_tracking_flags {
  * @size: sizeof(struct iommu_hwpt_set_dirty_tracking)
  * @flags: Combination of enum iommufd_hwpt_set_dirty_tracking_flags
  * @hwpt_id: HW pagetable ID that represents the IOMMU domain
+ * @__reserved: Must be 0
  *
  * Toggle dirty tracking on an HW pagetable.
  */
@@ -499,8 +500,8 @@ struct iommu_hwpt_set_dirty_tracking {
 					  IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING)
 
 /**
- * enum iommufd_get_dirty_bitmap_flags - Flags for getting dirty bits
- * @IOMMU_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
+ * enum iommufd_hwpt_get_dirty_bitmap_flags - Flags for getting dirty bits
+ * @IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
  *                                   dirty bits metadata. This flag can be
  *                                   passed in the expectation where the next
  *                                   operation is an unmap of the same IOVA
@@ -517,6 +518,7 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
  * @hwpt_id: HW pagetable ID that represents the IOMMU domain
  * @flags: Combination of enum iommufd_hwpt_get_dirty_bitmap_flags
  * @iova: base IOVA of the bitmap first bit
+ * @__reserved: Must be 0
  * @length: IOVA range size
  * @page_size: page size granularity of each bit in the bitmap
  * @data: bitmap where to set the dirty bits. The bitmap bits each
-- 
2.34.1

