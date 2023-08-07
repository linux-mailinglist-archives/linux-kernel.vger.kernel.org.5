Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7C773095
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjHGUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHGUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:42:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67CE5F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:42:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76ce59842c1so278208085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691440951; x=1692045751;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEHOruhAQboL2IZJ4xKRfJd4y+GyHfL/ZFsRcNEA2Vk=;
        b=KjbOPy6364kVnkNLLbhSypPPT4hUPeGlb4+nC2Cv3qKrX4rtoH79JEHNeASJ02YspO
         6FFOGeQBi85L97fa7QFadFoFTZwXIA3yjD+M0Hl1uctzCKFfakXhorENt5Eby7oQ9uwk
         Xb/bUG6blF8LihInw9JezmeXY8X8S8qHdTEob+dbHmHrkhBW+qQK3jy5/Xp3x8X8B61W
         z0v9ODtpH3eiDCOQAbk3S/3BKrjjaa4pswpQ5F9LDhi8XCZ9MBX9svk6z2+ZmzLkH0j9
         cLtExscyiMbIepvZ7bySjrldOYQKwTm0mvWTmHPYlUQsM6ZMTjeLOiVq2pDM80kA+7EA
         jXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440951; x=1692045751;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEHOruhAQboL2IZJ4xKRfJd4y+GyHfL/ZFsRcNEA2Vk=;
        b=EidYIDgu99DS/NNeRvtipzmYw0KO/E0n3ySpbCEqSVHYyUlSxik+J/btDQyZ0F8JWo
         Ts0Jx3D+MUrwFYyiVDh7csRzaq+t1NglKy+uYKee7/DCZRdRU18lUrCnY18dcQDnA7It
         jbLkinbTAe2lHg2/0R7YOmY6g8Co9VUEjxwjsLeGYKbTAhd5t2VjeXarHEEfwHw3GDqP
         4W05EMjAjQrwrDQXidVgKOMk05Zz6PV6j2C5eRqVmTa4MWxrrPsMn/OB/LhvfjD/BT88
         IoHw+n2NMkBFi2W+XM7KakR/PGFC7+4vzm9H8jN5t3JcH8n4q2ZGbBV+t7z051VD73wh
         Siuw==
X-Gm-Message-State: AOJu0YyaKt0iD8oXFCAnzuGajXKIcIK5UQPyT9/jtD/aSCMyS2WLUo0I
        AmePxFAJdec3UZkjZP7EjNI=
X-Google-Smtp-Source: AGHT+IEKWDJGGHtAZv6CaRvXSdrnf4QParZ5Qg3oFCCDddiRT69ZRYhCWzUBhnxr9+5albbgelbzJQ==
X-Received: by 2002:a05:620a:370e:b0:76c:a010:259d with SMTP id de14-20020a05620a370e00b0076ca010259dmr11840301qkb.23.1691440951395;
        Mon, 07 Aug 2023 13:42:31 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id c28-20020a05620a135c00b007682697dcb0sm2835953qkl.76.2023.08.07.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 13:42:31 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:42:26 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: vme_user: fix alignment of open parenthesis and
 deleted trailing spaces
Message-ID: <ZNFXMrtqSWvZv+rl@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all CHECK: Alignment should match open parenthesis
and deleted the trailing whitespaces as reported by
checkpatch to adhere to the Linux kernel coding-style
guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v2:
- Fixed changelog, noted by Greg KH

 drivers/staging/vme_user/vme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 977c81e2f3c7..741593d75a63 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -563,7 +563,7 @@ EXPORT_SYMBOL(vme_master_request);
  *         returned.
  */
 int vme_master_set(struct vme_resource *resource, int enabled,
-		   unsigned long long vme_base, unsigned long long size, 
+		   unsigned long long vme_base, unsigned long long size,
 		   u32 aspace, u32 cycle, u32 dwidth)
 {
 	struct vme_bridge *bridge = find_bridge(resource);
@@ -614,7 +614,7 @@ EXPORT_SYMBOL(vme_master_set);
  *         device or if an invalid resource has been provided.
  */
 int vme_master_get(struct vme_resource *resource, int *enabled,
-		   unsigned long long *vme_base, unsigned long long *size, 
+		   unsigned long long *vme_base, unsigned long long *size,
 		   u32 *aspace, u32 *cycle, u32 *dwidth)
 {
 	struct vme_bridge *bridge = find_bridge(resource);
@@ -1045,7 +1045,7 @@ EXPORT_SYMBOL(vme_dma_pci_attribute);
  * Return: Pointer to VME DMA attribute, NULL on failure.
  */
 struct vme_dma_attr *vme_dma_vme_attribute(unsigned long long address,
-					   u32 aspace, u32 cycle, 
+					   u32 aspace, u32 cycle,
 					   u32 dwidth)
 {
 	struct vme_dma_attr *attributes;
@@ -1841,7 +1841,7 @@ EXPORT_SYMBOL(vme_unregister_bridge);
 /* - Driver Registration --------------------------------------------------- */
 
 static int __vme_register_driver_bus(struct vme_driver *drv,
-				     struct vme_bridge *bridge, 
+				     struct vme_bridge *bridge,
 				     unsigned int ndevs)
 {
 	int err;
-- 
2.41.0

