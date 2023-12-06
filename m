Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF580679B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377004AbjLFGiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376844AbjLFGiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:38:07 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8BED53
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:37:49 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231206063747epoutp02738bc298441ebc986296d4233c736943~eKrVc7Dty1170211702epoutp02X
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:37:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231206063747epoutp02738bc298441ebc986296d4233c736943~eKrVc7Dty1170211702epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844667;
        bh=3PdiVk1hZZAha44ZtvOl7j4nSUlSo/pICcOYGKhfamU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=satHb7R+STC61f79Mku7v7aXYBJqC1Ol9LvW4GbBCPdnrdIp5cMAnb9Ef54pXBS9z
         n14lQZlzae3DuIB7LpdAi7ydmZ1BPGN/NIgzpbfx09eCewwfszqSwzZMeEz1uD9kQF
         yiMCzDKFT5ednT55XO6x25UHde4G1rKjGwWN4m2I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231206063747epcas5p26b0e1f66bc2a673324ef4bc4684f4145~eKrU699ip1851818518epcas5p27;
        Wed,  6 Dec 2023 06:37:47 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SlSQ130Rdz4x9Q1; Wed,  6 Dec
        2023 06:37:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.C6.09634.9B610756; Wed,  6 Dec 2023 15:37:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231206063137epcas5p3450b1c70bdf7461afeeb6a3db341818c~eKl8yG-Yc2502325023epcas5p3o;
        Wed,  6 Dec 2023 06:31:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206063137epsmtrp245439704aa598b42d0491759c3fb9280~eKl8uIbkf1483414834epsmtrp2j;
        Wed,  6 Dec 2023 06:31:37 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-5e-657016b94bf9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.5C.08755.94510756; Wed,  6 Dec 2023 15:31:37 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063134epsmtip25fc8e1a2411b7a54cbc35277e3b17e96~eKl6ACk1b3211232112epsmtip2h;
        Wed,  6 Dec 2023 06:31:34 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com, Smitha T Murthy <smithatmurthy@gmail.com>
Subject: [Patch v5 10/11] media: s5p-mfc: DPB Count Independent of
 VIDIOC_REQBUF
Date:   Wed,  6 Dec 2023 12:00:44 +0530
Message-Id: <20231206063045.97234-11-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxbVRjGPff2C5aSmw7wyGBAs6GQFVpWyoEMRJ16FxbXMBWdRmzotRDK
        bddbhk5UZmQi4qDKhyxsIu2Yg24QoB8wcAwwxBlhbIhuA8dSUT4GTCoMpgNbWvS/533ye895
        znvO4eGCi5wgXjatp3S0Qi3k+LKsfZFRoo5ALSV+uOqPJu01bNSzcJmFJk5bOci48geGbhud
        LNTbZuEic/cghr7qH2SjGz0dGBquGWehE1N3cNTqGGWjOzPp6HpnLQeVtljY6MuhbzF0vn+c
        ixpa/8FQveUvLirq7ueij46Z2CkB5M+mRZzsODnOJY1d0xjZ2vgJhxwb7eKQbaYPyBPtjYBc
        +/AUl3S2bievLDm5ct9DOXuyKIWS0oVRdKZGmU2rkoSpBzOeyYiTiSUiSQKKF4bRilwqSbh3
        v1z0XLbadUZh2BGFOs9lyRUMI4xJ3qPT5OmpsCwNo08SUlqlWivVRjOKXCaPVkXTlD5RIhbH
        xrnAN3Oyfhld4GgHtr19/vcXCsHDwBLgw4OEFF4dGMZLgC9PQFwE0HZznuspFgGcW6gFbkpA
        LANov8fa7Lh77jrLA3UDaDj+g7ejCIO/PrjvKng8DiGCP9rU7gZ/4hiAjmK9m8GJARzWldew
        3MxWIg2WFRe4GRaxE14rGsfcmk8kw/XvqoFns1DY1NKDu7WPy68w17Hd60BihAc/nbiEe6C9
        cHXO5k23Fc4MtHM9Ogg657s5Hp0JHfXTXl4Nm7sqvPyTsGekdiMPTkTC5s4Yjx0CK69c2MiD
        E37ws79/wzw+H9pPb+oIWDu2wvboYNjXdMabmYST9w3emRgAvGVdw8vB9pP/b1EHQCN4jNIy
        uSqKidNKaCr/vzvL1OS2go1XHLXPDsYn7kX3AowHegHk4UJ/vnpIQwn4SsU7RymdJkOXp6aY
        XhDnGqABDwrI1Li+Aa3PkEgTxFKZTCZN2C2TCB/lzxadUgoIlUJP5VCUltJt9mE8n6BCTNTp
        2FUsinacLTjCLBU2CAatU4+E7QiJl/T5zB631+5UXW64avYLbWhON34xaFHp82W3DE+tLTR/
        bTtwI1j97OupcwmX+DlVsaF+saqAieEXS00xL5s/tt5tX3z1pabADksECnn37HSf87Xyt1Ki
        lhvTg9nifOW2LU0pY09EGOS91QdM7xlVr+BVkc4y+qi8st4uOVg1HJ6YXZxmWvp8MvVaPxaf
        v6XQvL5+k6mun0yueFyTWNnyvNPRWVBakdYmWTEdXtZ32UamZmC4LW+32VrW3P5g/+FD4Z1D
        yW8kkqM/hZ9z3m4Tz+5yxAb/OfR+eug3T5/pKln9XjrqGJn3uWChhSwmSyGJwnWM4l+Qr0+v
        TgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK6naEGqwd4X4hZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGXcuPaereC4dMXaZ34NjH/Fuhg5OSQETCTerLzM0sXIxSEksJtRYvXJZ0wQCRmJ
        /23H2CFsYYmV/56zQxQ1M0n0H53L2sXIwcEmoCtxdnsOSFxEoJVR4vrKTiYQh1ngNrPEpgkP
        wbqFBQIk2vfNYwGxWQRUJS613gXbwCtgJ/H/6HRGiA3yEqs3HGAGsTmB4lPWLABbICRgK7Hy
        pOMERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC40VLcwfj9lUf9A4xMnEw
        HmKU4GBWEuHNOZ+fKsSbklhZlVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyW
        iYNTqoFpk+pMC0vpnVJfzyR21znvP8/6ojuZ83psWrHHKeZChrc/dT+lvXq63yL1jXCerueS
        1RFzMzQ+Cv6pMli9zWPGfdG+1KdKHAtUrW8GT6//bL3hllV2ypycmISD1loqTOrik9nfNDc/
        nCblv2hxZ2V33RVVsQcplzvzUp9ue3v8yROLZr5lZ9hOJs9kWfho4vO881/3CWafVp5ypvY0
        e/9ek7dR87gWVnYvMgjvn5QgtDgqcgK3up7Fk5Q/mRkzD5teXtr/65j/u6iJ3dMkrHo+FLYY
        lpjNvjXF/vGX08+ub/BYF8d38C+/VFbA0aUyPxkPV4R0BNUuT5x87PyRWVfmHD358MUzR825
        +c7uRr0nlFiKMxINtZiLihMBnhKHNwYDAAA=
X-CMS-MailID: 20231206063137epcas5p3450b1c70bdf7461afeeb6a3db341818c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063137epcas5p3450b1c70bdf7461afeeb6a3db341818c
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063137epcas5p3450b1c70bdf7461afeeb6a3db341818c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add allocation of DPB buffers based on MFC requirement so,
codec buffers allocations has been moved after state
MFCINST_HEAD_PRODUCED. It is taken care that codec buffer allocation
is performed in process context from userspace IOCTL call.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c     | 18 ++----------------
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  |  7 +++++++
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index a5df0759ccf0..a50df888c7c5 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1164,7 +1164,6 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	struct s5p_mfc_enc_params *p = &ctx->enc_params;
 	struct s5p_mfc_buf *dst_mb;
-	unsigned int enc_pb_count;
 
 	if (p->seq_hdr_mode == V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) {
 		if (!list_empty(&ctx->dst_queue)) {
@@ -1186,10 +1185,7 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 			set_work_bit_irqsave(ctx);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
-		enc_pb_count = s5p_mfc_hw_call(dev->mfc_ops,
-				get_enc_dpb_count, dev);
-		if (ctx->pb_count < enc_pb_count)
-			ctx->pb_count = enc_pb_count;
+		ctx->pb_count = s5p_mfc_hw_call(dev->mfc_ops, get_enc_dpb_count, dev);
 		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
 			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
 					get_e_min_scratch_buf_size, dev);
@@ -1564,14 +1560,6 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 		}
 		ctx->capture_state = QUEUE_BUFS_REQUESTED;
 
-		ret = s5p_mfc_hw_call(ctx->dev->mfc_ops,
-				alloc_codec_buffers, ctx);
-		if (ret) {
-			mfc_err("Failed to allocate encoding buffers\n");
-			reqbufs->count = 0;
-			ret = vb2_reqbufs(&ctx->vq_dst, reqbufs);
-			return -ENOMEM;
-		}
 	} else if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		if (reqbufs->count == 0) {
 			mfc_debug(2, "Freeing buffers\n");
@@ -1587,15 +1575,13 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 			return -EINVAL;
 		}
 
-		if (IS_MFCV6_PLUS(dev)) {
+		if (IS_MFCV6_PLUS(dev) && (!IS_MFCV12(dev))) {
 			/* Check for min encoder buffers */
 			if (ctx->pb_count &&
 				(reqbufs->count < ctx->pb_count)) {
 				reqbufs->count = ctx->pb_count;
 				mfc_debug(2, "Minimum %d output buffers needed\n",
 						ctx->pb_count);
-			} else {
-				ctx->pb_count = reqbufs->count;
 			}
 		}
 
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 572293f3b190..fd945211d28e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -2110,6 +2110,13 @@ static inline int s5p_mfc_run_init_enc_buffers(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	int ret;
 
+	ret = s5p_mfc_hw_call(ctx->dev->mfc_ops, alloc_codec_buffers, ctx);
+	if (ret) {
+		mfc_err("Failed to allocate encoding buffers\n");
+		return -ENOMEM;
+	}
+	mfc_debug(2, "Allocated Internal Encoding Buffers\n");
+
 	dev->curr_ctx = ctx->num;
 	ret = s5p_mfc_set_enc_ref_buffer_v6(ctx);
 	if (ret) {
-- 
2.17.1

