Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00757D3024
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjJWKjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:39:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0AB6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:39:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-408382da7f0so26056995e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698057568; x=1698662368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iakAHPOxKqOQUih7Sm03E4bR3Ewi1OC5ktvGhIrAhSs=;
        b=bwVomIJuw1+eC9LO1Nkrae0p7VxZjZ7KIDdJIU89jN/YwCHCWtu02Il4N1lhimwUHp
         N4VVIyLmRms9SQAP4rSl7wdv7r+QV3wJvET6w6iANHyJK7Fdtgt2zwUCy/qxCaFWuxAd
         vS/uCwDZpjS+fPFKPN75TF9CLmMtOpHmvporhH1fpzsSCqLZ8sjKtWiZ498z0VHBqgdX
         TErzcn0I8nJ0MBI2BCZYFLpP/ARy84mmvHToDV3QfawWFa8ybETmgOGPnV8sT8N5HeHG
         83gIDB/yLCcA8/V5yJzQDwnLV+FKbcMFFf41kWStKBzO33nzWib1Ep+TseeCVeL+3onA
         Z+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698057568; x=1698662368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iakAHPOxKqOQUih7Sm03E4bR3Ewi1OC5ktvGhIrAhSs=;
        b=ixNa7SvPiqpLvkrja6e0p4eWlAFX/KioZ92oVYl1syew2tAXzR/XpzlISPNHi61+Vv
         QlST7tqBxtpsSOsjgY/id6BnGBA4fRc0DHhE3D87yaT/9Xp28Za58V4tv1gSiPbwOFr2
         HAIG9fFycl84Z/q8O13CwdhX/RHhSXLyl3IGxHhd2oEmyMp3fOm8OgVUVcjvEstB2+Ld
         QNyVaj02Zi/vDCRy0fZEIslZWxSlvxvojHDj+zFzANmmj7gd1Z9btI3DGF3lDDVSVDJp
         e0+mNoTnE0I9n1ZGS3eHUdhuWkl6BHhVAT1jKGZNCk8cTPkmSzVC/ENY3v5jiJqM6/tF
         d2Sg==
X-Gm-Message-State: AOJu0Yw0PRAg0a8gnO5qqiawDP4lacFMb1pPianZdMftDkv8itttuv/F
        66AUE/a7x0prqD3e25y0LOI=
X-Google-Smtp-Source: AGHT+IHRWM3CpLE2aqOB2UbRawGgAMD79RG8VeNjeyax+v5VAOCCiiqUMw54GbjoE5jOotpwNggSyQ==
X-Received: by 2002:a5d:4527:0:b0:32d:a042:3b49 with SMTP id j7-20020a5d4527000000b0032da0423b49mr6332488wra.56.1698057567711;
        Mon, 23 Oct 2023 03:39:27 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id w5-20020adfee45000000b00317a04131c5sm7506265wro.57.2023.10.23.03.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:39:27 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     jgg@ziepe.ca, kevin.tian@intel.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] include: uapi: linux: iommufd.h: fixed kernel-doc warnings
Date:   Mon, 23 Oct 2023 15:38:52 +0500
Message-Id: <20231023103852.28743-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Fixed multiple kernel-docs warnings

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 include/uapi/linux/iommufd.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 50f98f01fe10..2211f1b53d6e 100644
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
@@ -499,12 +500,12 @@ struct iommu_hwpt_set_dirty_tracking {
 					  IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING)
 
 /**
- * enum iommufd_get_dirty_bitmap_flags - Flags for getting dirty bits
- * @IOMMU_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
- *                                   dirty bits metadata. This flag can be
- *                                   passed in the expectation where the next
- *                                   operation is an unmap of the same IOVA
- *                                   range.
+ * enum iommufd_hwpt_get_dirty_bitmap_flags - Flags for getting dirty bits
+ * @IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
+ *                                        dirty bits metadata. This flag can be
+ *                                        passed in the expectation where the next
+ *                                        operation is an unmap of the same IOVA
+ *                                        range.
  *
  */
 enum iommufd_hwpt_get_dirty_bitmap_flags {
@@ -521,6 +522,7 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
  * @page_size: page size granularity of each bit in the bitmap
  * @data: bitmap where to set the dirty bits. The bitmap bits each
  *        represent a page_size which you deviate from an arbitrary iova.
+ * @__reserved: Must be 0
  *
  * Checking a given IOVA is dirty:
  *
-- 
2.27.0

