Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8997D68DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjJYKgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjJYKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:36:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4019BF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:35:32 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231025103530epoutp031adf67e0f2686de830a8fbc3643bbdf3~RU05paNW60550605506epoutp03c
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231025103530epoutp031adf67e0f2686de830a8fbc3643bbdf3~RU05paNW60550605506epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230130;
        bh=yaatIcLSDM4fvogeHxnoEVffNwFt6IcJr5IGOrt3w3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgE5+UCr5yIQ33peiMncx+dG3uII9hF5xnyoQZTIrOre/0mH2j61Sgsim2Tzy6qSQ
         Hwwyr+Rv46EFyubPfzQw/LWtq6Pa5KSRh6+mHVN9cCAYK2UX3TmJwQBwB6ZAPp90T+
         cxpkgWrCZOc3laFqCqPrUEgIRHf0KKmuakzZmpd4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231025103529epcas5p307413dafb1b064ac028126d20179cd1e~RU049YElM2625426254epcas5p3p;
        Wed, 25 Oct 2023 10:35:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SFlgh1djJz4x9Q0; Wed, 25 Oct
        2023 10:35:28 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.26.09672.F6FE8356; Wed, 25 Oct 2023 19:35:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231025102253epcas5p4e57ce0924392b879d8d296f66613a798~RUp4y2PXJ0069500695epcas5p40;
        Wed, 25 Oct 2023 10:22:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025102253epsmtrp2980746c585fb109334fa96a5252dc486~RUp4x9yKa0878508785epsmtrp2Z;
        Wed, 25 Oct 2023 10:22:53 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-07-6538ef6f2629
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.C0.08817.D7CE8356; Wed, 25 Oct 2023 19:22:53 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102250epsmtip1bd44c20e67f8666d662736566d7334ab~RUp1t6pHL0054300543epsmtip1E;
        Wed, 25 Oct 2023 10:22:50 +0000 (GMT)
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
Subject: [Patch v4 07/11] media: s5p-mfc: Add support for DMABUF for encoder
Date:   Wed, 25 Oct 2023 15:52:12 +0530
Message-Id: <20231025102216.50480-8-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfVDTdRzH+z3s99s84X4B6dcZtFsoDx0Pg7G+GDNSql8HdnTVeWkXLva7
        wTG23R4q7VJBhoWpUAjyKAFq8twQQYIaD8axQo/jsZKEIYgOhRhxcyDX5kb99/p8Pu/P9/Pw
        /X7ZmNcowWWnKrSMWiGR84lN+LWeoIAQ1QJkwot+xuBMWxELGhe6cDhZfo2AVbZ7KLxTZcVh
        d3MLCes6b6Lwcp+RBS/03mTB1i4zDn83XkfhYNEEDs/MTWHQMD3KglMP9sOh9lICft3UwoLn
        b/2EwvreCRJeHBtE4SXDGgorW5ZJqO/sJWFWRjUrFtB15XUIPVa9hNHXiydIuqrjPkobar4i
        6NujHQTdXH2M1t+w4/SZqzUIvZ5ZRtJWgx9t+sdKJm4+kBaTwkikjJrHKJKV0lSFTMyPfzdp
        b1KUKFwQIoiGL/N5Ckk6I+bHJSSGvJEqdwzP530ikescrkSJRsMP2x2jVuq0DC9FqdGK+YxK
        KlcJVaEaSbpGp5CFKhjtLkF4eESUQ3goLWXdtIqoTm37bLL0Dn4cMfnkIBw2oISgv68Zy0E2
        sb2oHxHww3AF6jKWEDBUtYq4jBUEZH6rxzZSDNYRd6ATAY/XLrgNPQqW9RaHis0mqBAw0Cp3
        JvhQGQiY/lLr1GBUIQ6mG6ykU+NNJYCCk684NTi1AwyU/EI42YMSA6vtMstV7AVQ22R8WphD
        7QYVK5mk8xxA2dhgtbXALYoDa6M9iIu9wYO+q6SLucD6qJNwcTKYrrzvnkAOGjvycRe/CozD
        pbizH4wKAo3tYS63LzhnakCdjFGe4PTqXdTl9wBt5Ru8E5TetrlbeB701F50t0CDR4Xz7p3k
        IaBvZZzMRfyK/y9RgSA1yDZGpUmXMZooVaSC+fS/W0tWphuQpw88OL4NMU8uhnYjKBvpRgAb
        4/t4fJAAGS8PqeTwEUatTFLr5IymG4lyLDAP4z6XrHT8EIU2SSCMDheKRCJhdKRIwN/qYdGX
        Sb0omUTLpDGMilFv5KFsDvc4avqmZEUcOMaZf7z/D7565NJ38dITp/fmR4nPz3L99XseRlJx
        Y2aeduyle7XDm9v2sX99j448EGyvA5+vn9S93k/wPH0l/dnP/ln/8HDmTHqIp79uoUB6dFE5
        r5a21/5lKZp764gqTzhhefNg9s6jS/YZ076hrTB2ynxFVCnP44wHlnclxgTUtTUSp/xmLV0z
        s9/nXXnmiWgII3IDiIriTFkDOXrw7ZnthxoX7QkNA094dp+w5VzfkpGPY2tPRGTf2m7cklX/
        hU02nMn1lFjk3n9rh4NmOVvuVn4UHfBh/7HCnLlxM2l7LaepzH/1HfseNGPXb+/vOJsf2Hhj
        0KzJOvdiBB/XpEgEwZhaI/kXK7i+pGkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTrf2jUWqwftFBhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYvnxA6wW84+cY7XYfvARi8XNAzuZLC7OvMti
        0ffiIbPFpsfXWC0evgq3uLxrDptFz4atrBYzzu9jslh75C67xdLrF5kslm36w2SxaOsXdovW
        vUfYLVoal7A6SHismbeG0eP6kk/MHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j9egvFo++
        LasYPf41zWX3+LxJzuPU18/sATxRXDYpqTmZZalF+nYJXBn/Tv1mLOiWrHgw5z5LA+MpkS5G
        Tg4JAROJTZ+vMnYxcnEICexmBHI6WSASMhL/246xQ9jCEiv/PWeHKGpmkmh5OY+ti5GDg01A
        V+Ls9hyQuIhAK6PE9ZWdTCAOs8B6FokjG5awgxQJC/hITGu3BhnEIqAqcXb2MTYQm1fAVuLz
        j+WsEAvkJVZvOMAMYnMK2Eks+NYEtlgIqOb+/R+MExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECI4xLa0djHtWfdA7xMjEwXiIUYKDWUmEN9LHIlWINyWxsiq1KD++qDQn
        tfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGptq6Hwfr75iXFTRY3Wj/YnrMcgrX
        5eqqV+7BJ/eZb36oyM8YvCQ2ecUilu8LP7uVT1jQtXHD8Ur26Zq7OQzrGmVC4/ivLCgSSvRf
        6P/Q7lTnm7sdWQl1xrUOZdPcQqU2ndI0yFh/XO3gu8YF0usXsq+a8kuSw+TGWoPdk40ySrcs
        KFdncr1r1S4hNaEyJ99866JL6w9mHL/Y3niRj51PxjvcI4EzXqR9QsaqBx6zNGasOxcfel6l
        4Onem7+V/TtduUzf7Dq0vsb/iiJTlvKHWRMeZi57zPk1/T1D/HG/Q1MmZWwT0vy6Q1PXRyPq
        yrpF+9a7CaZx7LTwi624xaHHerSgwthBTNnA5fukFD5XJZbijERDLeai4kQAw2qShiADAAA=
X-CMS-MailID: 20231025102253epcas5p4e57ce0924392b879d8d296f66613a798
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102253epcas5p4e57ce0924392b879d8d296f66613a798
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102253epcas5p4e57ce0924392b879d8d296f66613a798@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmabuf support for mfc encoder

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  4 ++--
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 21 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index dee9ef017997..bd055dea827e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -865,7 +865,7 @@ static int s5p_mfc_open(struct file *file)
 		q->io_modes = VB2_MMAP;
 		q->ops = get_dec_queue_ops();
 	} else if (vdev == dev->vfd_enc) {
-		q->io_modes = VB2_MMAP | VB2_USERPTR;
+		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 		q->ops = get_enc_queue_ops();
 	} else {
 		ret = -ENOENT;
@@ -892,7 +892,7 @@ static int s5p_mfc_open(struct file *file)
 		q->io_modes = VB2_MMAP;
 		q->ops = get_dec_queue_ops();
 	} else if (vdev == dev->vfd_enc) {
-		q->io_modes = VB2_MMAP | VB2_USERPTR;
+		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 		q->ops = get_enc_queue_ops();
 	} else {
 		ret = -ENOENT;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 0afa8426ca4e..80a97b86977e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1537,9 +1537,10 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 
-	/* if memory is not mmp or userptr return error */
+	/* if memory is not mmp or userptr or dmabuf return error */
 	if ((reqbufs->memory != V4L2_MEMORY_MMAP) &&
-		(reqbufs->memory != V4L2_MEMORY_USERPTR))
+		(reqbufs->memory != V4L2_MEMORY_USERPTR) &&
+		(reqbufs->memory != V4L2_MEMORY_DMABUF))
 		return -EINVAL;
 	if (reqbufs->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (reqbufs->count == 0) {
@@ -1616,9 +1617,10 @@ static int vidioc_querybuf(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 	int ret = 0;
 
-	/* if memory is not mmp or userptr return error */
+	/* if memory is not mmp or userptr or dmabuf return error */
 	if ((buf->memory != V4L2_MEMORY_MMAP) &&
-		(buf->memory != V4L2_MEMORY_USERPTR))
+		(buf->memory != V4L2_MEMORY_USERPTR) &&
+		(buf->memory != V4L2_MEMORY_DMABUF))
 		return -EINVAL;
 	if (buf->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		if (ctx->state != MFCINST_GOT_INST) {
@@ -2577,11 +2579,12 @@ static int s5p_mfc_start_streaming(struct vb2_queue *q, unsigned int count)
 						S5P_MFC_R2H_CMD_SEQ_DONE_RET,
 						0);
 		}
-
-		if (ctx->src_bufs_cnt < ctx->pb_count) {
-			mfc_err("Need minimum %d OUTPUT buffers\n",
-					ctx->pb_count);
-			return -ENOBUFS;
+		if (q->memory != V4L2_MEMORY_DMABUF) {
+			if (ctx->src_bufs_cnt < ctx->pb_count) {
+				mfc_err("Need minimum %d OUTPUT buffers\n",
+						ctx->pb_count);
+				return -ENOBUFS;
+			}
 		}
 	}
 
-- 
2.17.1

