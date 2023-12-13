Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAF810F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378555AbjLMLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378487AbjLMLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:01:27 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14523109
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:01:33 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231213110131epoutp021b8bd3b9ac3b9a26046c341365998f16~gXymZ_ztd0499804998epoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:01:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231213110131epoutp021b8bd3b9ac3b9a26046c341365998f16~gXymZ_ztd0499804998epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465291;
        bh=HKFsd5Jp8gHQwfs4RaCuZrcBXhPbGiu83l8haXmBs2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfMaLUxunozDeewh0KSTBTP3MyEHz1i8wEkNNv0uw8WlrxA4cBQvjlrQ5n4c4Jj9h
         nqd8cEq1rixm15LvENeO9eyT9YXmNJTOmtHBCmTxSHdnJhBkXAmLFjgTZt1QUG4A2F
         Rd+b+TegNGoiiQpTNpDBoVEpbIJN/hX3CFxP1RJQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231213110130epcas5p10385db06b44ac09a942023416f000990~gXyldyykn2229322293epcas5p1n;
        Wed, 13 Dec 2023 11:01:30 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Sqsx45CPhz4x9Pw; Wed, 13 Dec
        2023 11:01:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.00.19369.80F89756; Wed, 13 Dec 2023 20:01:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231213081137epcas5p132baeb4789897e3386b9357b55cc63c4~gVeQq93hZ0249502495epcas5p1t;
        Wed, 13 Dec 2023 08:11:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231213081137epsmtrp27935b007b8a1d83ac3801e4f5bf4cc15~gVeQpl2jq2160121601epsmtrp27;
        Wed, 13 Dec 2023 08:11:37 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-35-65798f083fc9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.4B.08755.93769756; Wed, 13 Dec 2023 17:11:37 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081134epsmtip24589ad762b4a63b3fba5aaca93315d30~gVeN2wJcV1539415394epsmtip2y;
        Wed, 13 Dec 2023 08:11:34 +0000 (GMT)
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
Subject: [Patch v6 07/10] media: s5p-mfc: Add support for DMABUF for encoder
Date:   Wed, 13 Dec 2023 13:41:02 +0530
Message-Id: <20231213081105.25817-8-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRzHPffethe0egNMD9Uhu0Ym05ZeaeGUAHOM6U22KYrZIn/QdfSm
        IO1t04dsw42Bq2G4TXAyBgNceCXAFCiDlUexQuXlhhI2FhXiJpsTjDNSUIwwpRT0v8/vdb6/
        3++cQ+JBLqGEzOKtnJnX6GlhINE5EBkpJT88zMnH27eiu85yAXL/9gWBblV3ClHt0j0M/VDr
        JVB/e4cIXXKNYegTz5gAfevuwtB4+TSBzvx8G0eOmUkBuj23H010VwrRqdYOATr/dR+GPvVM
        i1CDYxlDNR0LImR3eUToRH6d4KVN7M26eZztqpgWsbW9sxjraDopZKcme4Vse10ee+ZyE2Af
        FFSJWK8jjB1d9IpSAtOy4zM5jZYzh3N8hlGbxesS6N2p6p1qZYyckTIqFEuH8xoDl0An70mR
        vpylX52RDn9Ho7etulI0FgsdlRhvNtqsXHim0WJNoDmTVm9SmGQWjcFi43UynrPGMXL5i8rV
        xAPZmY01yyLTe6GH6rsWseNgJKQIBJCQUsDxigmsCASSQVQvgB+1VAv9xjyAPWUl68YfANrb
        /sQ3Sjoq7SJ/wAXg95ULhC8QRNkx+KU3rAiQpJCSwmtX9D53CJUP4Eyh1ZePU0M4vFhcvpYf
        TO2B+U0jQh8T1LPQ1V4h8LGYSoAOz1eYX+xp2NzqXhMOoBLh/YLPge8gSF0n4fSls4RPDFLJ
        cOraq/78YDg3dFnkZwn03ncJ/ZwBZ2pm1wfQw5bejwk/b4fu65Vrx+BUJGzpjvK7N8PS0c/W
        WsCpR+Hpv++styOGzuoNjoCVU0sCPz8FB5rrgZ9ZOF82sr64EgBXer4hikFYxf8SFwFoAhLO
        ZDHouAyliZHyXM5/t5ZhNDjA2jveluIEza0rsn6AkaAfQBKnQ8QjzhwuSKzVHD7CmY1qs03P
        WfqBcnWBJbhkU4Zx9SPwVjWjUMkVMTExClV0DEM/If7FXqUNonQaK5fNcSbOvFGHkQGS41jT
        veFZXrV/862Ro8Q/PUVvVIV6UBmflhzvjP7uXE4obovY0hdsOFage9dTz6xER6Gb7tyDnYf+
        2ndEpXxkKWVx7ws9vQ+n781rnB9c6WssVVSZD8reH3woOaw48e6ydLtS1ige2/I7I50ZnH2l
        UFD6YPhNrlt3Njb37Vbmjvaxo+64nVdrIh19W3+dkzecyz/wTFJ6Hz+anjqhyg6Y2r3LdaHj
        mPtku2pyNKdzMOlJT16s4fm3jG37CofFTP1PcdGT2eq8C1514HMLNywFbRFJO+wSR6EZ0rlp
        iV489fRyw487ZGlzr12JNXTbBsgbLnHq1bbXcx8/kbr0QaxzaBd7Po4mLJkaZhtutmj+Bexj
        2VxQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK5lemWqQecFaYunO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdkMf/IOVaLmwd2MllcnHmXxaLvxUNmi02Pr7Fa
        PHwVbnF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWSza+oXdonXvEXaLlsYlrA6iHteXfGL2
        2DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R59W1Yxevxrmsvu8XmTnMepr5/ZA7iiuGxSUnMy
        y1KL9O0SuDJWLvrDXtAsWbF051emBsaTIl2MnBwSAiYSW+e0soPYQgK7GSXeP4uBiMtI/G87
        xg5hC0us/PccyOYCqmlmkuj+MpWxi5GDg01AV+Ls9hyQuIhAK6PE9ZWdTCAOs8BtZolNEx6C
        dQsL+Eg0rjrJBmKzCKhK7N08ixXE5hWwldh05DQTxAZ5idUbDjCD2JwCdhLvmvYzQlxkK7F8
        923mCYx8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeMluYOxu2rPugdYmTi
        YDzEKMHBrCTCe3JHeaoQb0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUw
        WSYOTqkGpuy/pSmG7S842azePTAXqgje2vy1e5OK52Gb7NaKTyzsKdEdsxim/vn31Lk9XLWS
        a9XLSRcE1u31W+eddeRU6+2W0/xy5u/+1l3jibkeGrzTRJJL+RDXj/CaOecYiji67slZJd+f
        aMK/hl8+hbd0YZxaj9WM3m2lCTZ/qx1Ekifeac6Mqjlv6l0UFnzPImjC1mM7N6caPLWQulDN
        7718U+0jYYcwJu+01p3PL/zcUvJcMiwqIfhpyf6TPDeNTotvefB51wa7zg7bw+t2r3V4+rJ9
        rVmJ41nnDUKz3fWOWn0/vtysX+Wz9HeJ2KCePj+fH07FEwprbGWv3/Xcnjn5qUqM7KqHjWXS
        5YJKeTOVWIozEg21mIuKEwEfScjTBwMAAA==
X-CMS-MailID: 20231213081137epcas5p132baeb4789897e3386b9357b55cc63c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081137epcas5p132baeb4789897e3386b9357b55cc63c4
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081137epcas5p132baeb4789897e3386b9357b55cc63c4@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 20 ++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

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
index 67fe0302464f..ae3764969473 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1538,9 +1538,10 @@ static int vidioc_reqbufs(struct file *file, void *priv,
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
@@ -1617,9 +1618,10 @@ static int vidioc_querybuf(struct file *file, void *priv,
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
@@ -2581,11 +2583,11 @@ static int s5p_mfc_start_streaming(struct vb2_queue *q, unsigned int count)
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
+				mfc_err("Need minimum %d OUTPUT buffers\n", ctx->pb_count);
+				return -ENOBUFS;
+			}
 		}
 	}
 
-- 
2.17.1

