Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F3810F49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378609AbjLMLCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378598AbjLMLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:02:09 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF1189
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:02:09 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231213110208epoutp04015a850cd622685bf158290a27aa4849~gXzI5pbqq0794607946epoutp04a
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:02:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231213110208epoutp04015a850cd622685bf158290a27aa4849~gXzI5pbqq0794607946epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465328;
        bh=2lm3qEVBSJdxq4/4EUzCWV6QE445bHlIbiCqwVyw6Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMsfmIur42JVQIOh6hVFVeTsKPidfcITtpLzmTSmUG9u2JohfF2TgWAaE5eJsswD+
         iLns5YPln/481vK90lnZUFmBsMh+VUJCxQY4yQyaoziPpzr0zooJ2eVT5zQl8Aj3Nc
         YMoEsEb6f/FW3Ao/0uorv2uLy+/PuNZLbFzvCLzg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231213110207epcas5p3e33afff16ddcd8364be6b5fa84972da2~gXzIaq4C70873008730epcas5p3b;
        Wed, 13 Dec 2023 11:02:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Sqsxp2cn5z4x9Pt; Wed, 13 Dec
        2023 11:02:06 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.09.09672.E2F89756; Wed, 13 Dec 2023 20:02:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081148epcas5p215061f6452b43e00dd20e5db6b50bbb9~gVea1QCbK1902219022epcas5p2t;
        Wed, 13 Dec 2023 08:11:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213081148epsmtrp1ad214c600c06faf6999d54905457e3e5~gVeatpkwc2335123351epsmtrp1n;
        Wed, 13 Dec 2023 08:11:48 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-55-65798f2ec816
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.35.07368.44769756; Wed, 13 Dec 2023 17:11:48 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081143epsmtip2b7286351edc2ff3bd11978342dc54eab~gVeWYOpzH1538715387epsmtip2P;
        Wed, 13 Dec 2023 08:11:43 +0000 (GMT)
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
Subject: [Patch v6 10/10] media: s5p-mfc: DPB Count Independent of
 VIDIOC_REQBUF
Date:   Wed, 13 Dec 2023 13:41:05 +0530
Message-Id: <20231213081105.25817-11-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmhq5ef2WqwZsrAhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFZdtkpCam
        pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAP2opFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO+HJbreC4
        dMXK+b+YGhj/inUxcnJICJhITH44nb2LkYtDSGA3o8TC7RdZIJxPjBKn2w8xQjjfGCU+vPrF
        CtOyqGs5E0RiL6PEs67/rBBOK5PEsROHgfo5ONgEdCXObs8BaRARaGSUeNxRAlLDLHCcWWLB
        hJksIAlhgSCJz99usYHYLAKqEu83dILZvAJ2Ek+PH2aC2CYvsXrDAWYQmxMo/q5pP9hJEgI3
        OCT+P+1nhihykfh1aQ/UecISr45vYYewpSRe9rdB2ckSjxe9hKrPkVi/ZwoLhG0vceDKHLCj
        mQU0Jdbv0ocIy0pMPbUO7AZmAT6J3t9PoO7hldgxD8ZWk5hz5wfUWhmJw6uXMkLYHhIti7uY
        IYEykVFi5cHPzBMY5WYhrFjAyLiKUTK1oDg3PbXYtMA4L7UcHmvJ+bmbGMHpWMt7B+OjBx/0
        DjEycTAeYpTgYFYS4T25ozxViDclsbIqtSg/vqg0J7X4EKMpMAAnMkuJJucDM0JeSbyhiaWB
        iZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MfFM42xr5qmw+3JCfLP3gx4XJ
        i/csutOQts61K2blmvsB0ftW7/L3yLb9dKNllxfzgo23Foat5Ve7c2+HrM2P3P2KUyWmcL31
        P+vtoNb4lb/1pm4OT+z89i8qrzRUCmcfeOa5fS7H1Md1N7i8z0dJP1NVrzFemS4w1fSCpfE9
        i5VMO2aEbjvtbeXx8VBX7Z6NdZsFk47mLz05dyrv/Px5t+7d5v8psPvoYdtjx1POH8v66nFk
        lxbfkXc3j+29ynPofPnSCt0Yu9vT6qQ1e+/7Xd0XOSu2+NbSDclFS+39zXVU30xjEulsmrHj
        oN6SpYHL75q2i72N+OLsYquupVHVs6pkmtDtSr6Jf5Ue7Xl2ca4SS3FGoqEWc1FxIgCGKHVp
        UAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK5LemWqwaRLQhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGV8ua1WcFy6YuX8X0wNjH/Fuhg5OSQETCQWdS1n6mLk4hAS2M0oceVMFwtEQkbi
        f9sxdghbWGLlv+fsEEXNTBILjywBcjg42AR0Jc5uzwGJiwi0MkpcX9kJNolZ4DazxKYJD8G6
        hQUCJFbMeccMYrMIqEq839DJBmLzCthJPD1+mAlig7zE6g0HwGo4geLvmvYzgthCArYSy3ff
        Zp7AyLeAkWEVo2RqQXFuem6yYYFhXmq5XnFibnFpXrpecn7uJkZwxGhp7GC8N/+f3iFGJg7G
        Q4wSHMxKIrwnd5SnCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbL
        xMEp1cAk7njujs9Ktm1HDd9GhJ1tPDj7gX4wg/nZo5mqjO/cDpnYz5m34V/sy9l7PntHrHzg
        Vbb0aOH2fzHSwdNOrjl7IdZzqfv9eYyrXpo/Ws67q2LrlgOSUR6f/+868Hz34sc7xJZPOpV3
        d/HP4gmveKfEat/e3fzs6kn3lV+us8gs+trnWsc9q86UUcrw7us1j7RYP3q8v5vW1V1rd9DP
        jXWKf5Xo9X/sOqvlI7ucwspi+/1PGnHILzkveP35PpN3jm9e94TmVdmrXpn60zDmi/aXbcsj
        slZELFnZytdzbY3Zsy1Km22Ujp0/O185Ys0/uSsRf4Rvls7L+//BrmZm45vcrnrXyXuSo256
        bzAQzsm6eEiJpTgj0VCLuag4EQCl7SCPBwMAAA==
X-CMS-MailID: 20231213081148epcas5p215061f6452b43e00dd20e5db6b50bbb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081148epcas5p215061f6452b43e00dd20e5db6b50bbb9
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081148epcas5p215061f6452b43e00dd20e5db6b50bbb9@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c     | 18 ++----------------
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  |  7 +++++++
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index ae3764969473..ef8bb40b9712 100644
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

