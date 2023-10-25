Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE217D68EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjJYKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjJYKhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:37:16 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC010D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:36:09 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231025103606epoutp010a7e36959144e8f9affd40efb7b9d7f6~RU1bIaN760370903709epoutp01P
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:36:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231025103606epoutp010a7e36959144e8f9affd40efb7b9d7f6~RU1bIaN760370903709epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230166;
        bh=UScJ5otXI9wPp2+aoHXkgXFlQfZzWdB3o4NaHFzjyCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+wRCc+0+PrW+QtlDizsjUlWpKUl8LzRaYzQF+IqqGuPD8+Ma6a+yXQJCtJjaZEor
         5wkmKrsj/Xa7wqtskOJ4Vai8OMehn/G0CHEwYKZRHayZG5htIulBlihC8HXLXHjIaT
         Jx7E1VS2/KDpZqb+RzcGwQlpDVgrBEAwvUNk1OHo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231025103606epcas5p2b86230c1f43e6a4741709c1d7605bb43~RU1aoW43Q0559405594epcas5p2K;
        Wed, 25 Oct 2023 10:36:06 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SFlhN2jnMz4x9Pw; Wed, 25 Oct
        2023 10:36:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.49.08567.49FE8356; Wed, 25 Oct 2023 19:36:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231025102304epcas5p2065f908cb77558ef5573fbaab82352bd~RUqCOrde50482304823epcas5p2n;
        Wed, 25 Oct 2023 10:23:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025102304epsmtrp2b8daa7407511081b6698576857a79f05~RUqCNnGNM0922409224epsmtrp2K;
        Wed, 25 Oct 2023 10:23:04 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-27-6538ef944b78
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.D0.08817.78CE8356; Wed, 25 Oct 2023 19:23:03 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102300epsmtip13edcd5cb3f7bc4766455675283366a59~RUp-KDUFm0054300543epsmtip1J;
        Wed, 25 Oct 2023 10:23:00 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com, Smitha T Murthy <smithatmurthy@gmail.com>
Subject: [Patch v4 10/11] media: s5p-mfc: DPB Count Independent of
 VIDIOC_REQBUF
Date:   Wed, 25 Oct 2023 15:52:15 +0530
Message-Id: <20231025102216.50480-11-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1CTdRzH7/s8z/YMdfY4Rb9MRW4eGl7gVtv8wgnVxeFz5eUus1K6aLc9
        MY7xbG0jtI5ECjMOCO4wxfglY+jxS2/8/jEbSJEcQh7CLCHAlQiUECsD9KCNB+u/1/vz4/t5
        f38JcNEQXyxIYC2MiVXrJfw1ROP1kGdD82cQI/1zVIR+ay7gIedMB4HGihv5yDo/gaFRq4dA
        nXUNJKp29GHoUreTh0q6+nioqeMegX5ytmDoVsEIgXIejOPI7h7iofGpt9FAayEfZV1t4KHz
        /dcwVNM1QiKb6xaGKuxPMFTW8BeJMhxdJPr8VDnvJUhXF1cD2lU+h9MtF0ZI2to+idH2yi/5
        9PBQO5+uKz9JZ3y3SNA59ZWAXkovImmPPZDu+dtDqtYdS9yvY9RaxhTEsBqDNoGNj5S8djju
        lTiFUioLlYWjfZIgVp3EREqiD6pCYxL03s1Lgj5S65O9IZXabJbsjdpvMiRbmCCdwWyJlDBG
        rd4oN4aZ1UnmZDY+jGUsETKp9HmFt/D9RN3kbIyxcevx3EuNZBqY2JwJ/ASQksNx1yQvE6wR
        iKg2ANNzfsA4MQfgqK0M58QjADOmzvKftpyeHiC4hAPAbOd5PicyMDi95BMCAZ8KhTeb9L6G
        TdQpAN1nLL4anDpHQHeth/QlNlJvQHupHfiYoIKhs6IX97GQioL9C1MYN20HrLrqXIn7eeOl
        j9JJ30KQmhfA8pu1PK4oGpbUzJEcb4RT3fWrLIaeh45V2xroLpvEOdbDK+35BMcvQuftQsJn
        GqdC4JXWvVx4OzzbU7viAafWw+zHv676EcLm4qe8CxYOz69a2AavV9kAxzQcu5ENuEPJA3D5
        8gyRCwIv/D+iFIBKEMAYzUnxjEZhlLFMyn+3pjEk2cHKA98T3QzulCyFdQJMADoBFOCSTcKj
        BxEjEmrVJz5mTIY4U7KeMXcChfcA83Cxv8bg/SGsJU4mD5fKlUqlPPwFpUyyRTidUaQVUfFq
        C5PIMEbG9LQPE/iJ0zCi7Zz4rR5iX8+1qIBttY7Mh4muQ7qOo5dPZud/o0ixVYl6Xc1d0Gr9
        eeg5TUSIP7tz7QFEuu8J4XLqO6/2Jx1W5vm3HRqzRTSpchcX3UWsm47ojN4x+Hjc9IXu4jIb
        XBnx5tepmxuB+GLagmf4jw+/eq/7x08eLI+qLbuPzOtfltt6b4t7Yhs+CJgtqOlfb1PEZDHO
        te9mLnx6Z05Ud2KDdlbcB4vPzGZJS8X5A/LAER2br2/f0rRu53zgXc9uInbr75MdvF2pbSpB
        m8N97Mbrx11p9b+o6kdivx3oG2vt//5IRfDyIJtz+n4WJn5SdJ/RPmP9Z/CzuxMp2+tbSg8k
        bpAQZp1atgc3mdX/AlknZZtpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTrf9jUWqweuZFhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYvnxA6wW84+cY7XYfvARi8XNAzuZLC7OvMti
        0ffiIbPFpsfXWC0evgq3uLxrDptFz4atrBYzzu9jslh75C67xdLrF5kslm36w2SxaOsXdovW
        vUfYLVoal7A6SHismbeG0eP6kk/MHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j9egvFo++
        LasYPf41zWX3+LxJzuPU18/sATxRXDYpqTmZZalF+nYJXBkvP7gVbJOumLB8G3sD43OxLkZO
        DgkBE4m215dZuhi5OIQEdjNK/P7TyAaRkJH433aMHcIWllj57zk7RFEzk8TlwzeYuhg5ONgE
        dCXObs8BiYsItDJKXF/ZyQTiMAusZ5E4smEJWLewQIDErFfzmEFsFgFViQPLzoDZvAJ2Eud/
        vmKC2CAvsXrDAbA4J1B8wbcmsF4hAVuJ+/d/ME5g5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgx
        t7g0L10vOT93EyM4xrS0djDuWfVB7xAjEwfjIUYJDmYlEd5IH4tUId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGphOeFmHN/1amFi3b41g7mWvPy++Xe66
        Y9qbmy3/z/RZ0cQ/fHULNuqyLHB03Go0I75E0/LyupJpx5NPvNse4CZpt7p3Tsl0nvMTcrau
        eW9uVxrbsG/7Hh7OOX9W9bwqL5H3mFbwpVUweWGaS5ZdhfyUmWdvbnSQEPy/UO193/p9O3ao
        yH2Kyiyz45xYeGDthPldYrtU5+e/bzZxua40VbnMcbvVL8Y1Tl2xUrpzfMOlCyvnP34UOZlz
        tZxqkm2WiInl858isRvyrz05enHH4saValc1ly91f9d9xf1zhGy58fTZhuw1q/qdu8+zT95c
        Is0QNHXtdq+dGl3Mn2I1QxN6mOf8nRj1x4qvTFjv4S8lluKMREMt5qLiRAAjOmEzIAMAAA==
X-CMS-MailID: 20231025102304epcas5p2065f908cb77558ef5573fbaab82352bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102304epcas5p2065f908cb77558ef5573fbaab82352bd
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102304epcas5p2065f908cb77558ef5573fbaab82352bd@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c      | 17 ++---------------
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c   |  8 ++++++++
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 80a97b86977e..fceceade979a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1164,7 +1164,6 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	struct s5p_mfc_enc_params *p = &ctx->enc_params;
 	struct s5p_mfc_buf *dst_mb;
-	unsigned int enc_pb_count;
 
 	if (p->seq_hdr_mode == V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) {
 		if (!list_empty(&ctx->dst_queue)) {
@@ -1186,10 +1185,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 			set_work_bit_irqsave(ctx);
 		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
 	} else {
-		enc_pb_count = s5p_mfc_hw_call(dev->mfc_ops,
+		ctx->pb_count = s5p_mfc_hw_call(dev->mfc_ops,
 				get_enc_dpb_count, dev);
-		if (ctx->pb_count < enc_pb_count)
-			ctx->pb_count = enc_pb_count;
 		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
 			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
 					get_e_min_scratch_buf_size, dev);
@@ -1563,14 +1560,6 @@ static int vidioc_reqbufs(struct file *file, void *priv,
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
@@ -1586,15 +1575,13 @@ static int vidioc_reqbufs(struct file *file, void *priv,
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
index 290d82e99940..7029a259157a 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -2145,6 +2145,14 @@ static inline int s5p_mfc_run_init_enc_buffers(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_dev *dev = ctx->dev;
 	int ret;
 
+	ret = s5p_mfc_hw_call(ctx->dev->mfc_ops,
+			alloc_codec_buffers, ctx);
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

