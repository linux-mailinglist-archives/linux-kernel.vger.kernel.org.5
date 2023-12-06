Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3BB80677A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376841AbjLFGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376829AbjLFGgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:36:41 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9B1B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:36:47 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231206063645epoutp01ba402956e95a14e3c8090e87e91afd8d~eKqbpsxnd2442024420epoutp01K
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:36:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231206063645epoutp01ba402956e95a14e3c8090e87e91afd8d~eKqbpsxnd2442024420epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844605;
        bh=BuzCw9s44y8vOCjVUfZWEiQy85UK4HFZlEIF9gRnXwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KSo4AeoMrB1FRJNkfmglzzVBaPXYkVcVFHVdREHpi8+7aFs7Qnh4sPYMnITqQeA4G
         Q/0pXFexhqVCYRbf+7m19KLe+nsN87pnJTKsQhMjsZ94lqV3DNdste5wKL/Tn60PSV
         bGqyWTn2euvMiurzCadV0G1BGIfCC9aiubnkz0JY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231206063644epcas5p1a01f89836d3531cfa002fa80c141f057~eKqbBw_F20519405194epcas5p1i;
        Wed,  6 Dec 2023 06:36:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SlSNq0Mdjz4x9Pt; Wed,  6 Dec
        2023 06:36:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.F5.09672.A7610756; Wed,  6 Dec 2023 15:36:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231206063121epcas5p17a110abeea781dcb8760b4da4c8e4074~eKluRWSjj1697916979epcas5p1_;
        Wed,  6 Dec 2023 06:31:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206063121epsmtrp29cce8d0cf74c69e8c00eef230f33c898~eKluQedM81483514835epsmtrp2M;
        Wed,  6 Dec 2023 06:31:21 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-5a-6570167a889b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.5C.08755.93510756; Wed,  6 Dec 2023 15:31:21 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063117epsmtip25945e5393b6f324d0a4c47eeda35fcb9~eKlqkB1Wy3211232112epsmtip2Z;
        Wed,  6 Dec 2023 06:31:17 +0000 (GMT)
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
Subject: [Patch v5 05/11] media: s5p-mfc: Add support for rate controls in
 MFCv12
Date:   Wed,  6 Dec 2023 12:00:39 +0530
Message-Id: <20231206063045.97234-6-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmum6VWEGqQUOftcXTHTNZLQ68P8hi
        8WDeNjaLxT+eM1ncX/yZxeLQ5q3sFmv2nmOymH/kHKvFzQM7mSwuzrzLYtH34iGzxabH11gt
        Hr4Kt7i8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLBZt/cJu0br3CLtFS+MSVgdRj+tLPjF7
        7Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo++LasYPf41zWX3+LxJzuPU18/sAVxR2TYZqYkp
        qUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QD8qKZQl5pQChQIS
        i4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izfry9xl7w
        U6Bi0Z+jbA2MU/i6GDk5JARMJI5eucbUxcjFISSwm1Fix6UHjBDOJ0aJzs+97BDON0aJlbsW
        scG0zN2zlBnEFhLYyyhxe3s9RFErk8SmuTeAOjg42AR0Jc5uzwGpERFoZJR43FECUsMscJxZ
        YsGEmSwgCWGBYIkPK6eDDWURUJVYeWYhE4jNK2ArseHOFHaIZfISqzccAFvGKWAnMWXNAlaQ
        QRICVzgkLlyZA1XkIrF6wgpGCFtY4tXxLVBxKYnP7/ZCXZ0s8XjRS2YIO0di/Z4pLBC2vcSB
        K3NYQI5mFtCUWL9LHyIsKzH11Dqwe5gF+CR6fz9hgojzSuyYB2OrScy584MVwpaROLx6KdQJ
        HhKNzV9ZIQE0kVFiw9GyCYxysxA2LGBkXMUomVpQnJueWmxaYJyXWg6PtOT83E2M4GSs5b2D
        8dGDD3qHGJk4GA8xSnAwK4nw5pzPTxXiTUmsrEotyo8vKs1JLT7EaAoMv4nMUqLJ+cB8kFcS
        b2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA9PqIytPvPTczM22iuGn
        yseHanucz3pJtkYuiro7c6rXyusS8/dUrnn85qmaCFf58VP7v1/QWX4q1+Gtoo3RwlW6mirh
        RqXCPzRj+g2XxgrbOM6ff+LZ/AdqL86pnf+cGbpATM9GZsnViNVfdBQ32hUZ7H85y+kil3LY
        XPGEqtQXMXtm8rIt9RAX8XQ8bbpqXk7WRqvJD7MKvu9kZ2vKKElb2KPNsV3tXKaU9/ozkybr
        zfr6oqVsud93lvo9pwODOFMTdLo6JvpPmJfQu0A16t9N7pLPu4I072XP5Cws0jvKoV93WoFN
        pP040zLBf+rvePftaDI/V55iP0nYirfMMe6zRFWrpsmCKd72PNkTA5RYijMSDbWYi4oTAbLJ
        1qtPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK6laEGqwaydJhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGX8eHuNveCnQMWiP0fZGhin8HUxcnJICJhIzN2zlLmLkYtDSGA3o8Tr1ZtZIBIy
        Ev/bjrFD2MISK/89B7OFBJqZJKZ/1+li5OBgE9CVOLs9B6RXRKCVUeL6yk4mEIdZ4DazxKYJ
        D8EahAUCJS6tPsEMYrMIqEqsPLOQCcTmFbCV2HBnCtQCeYnVGw6A1XAK2ElMWbOAFWSBEFDN
        ypOOExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4XLc0djNtXfdA7xMjE
        wXiIUYKDWUmEN+d8fqoQb0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUw
        WSYOTqkGJnOpY7Hy532NeHXt2iaoC09pn/dyqjHPPyahyXU5CzvZ9Jui52zh44kUWi+UrfIp
        81fZ5uPJqY9LjlZ/WD219qxH7AFNjk/ffmRdct1j0HbZ+k1G3ZONahaLVzOudtpWFG7+dUN7
        V9Hr3qcGR5k27le6eVFv6fmfE5Z7Oc7UqWuT4Zrb1qTwW3Ny5dk7PAx5ru3vkm5oLz4zO0Nx
        bpjyrK8BaRUPaq8fWeggWrf8TuzT298+Sp8If7O7YTl70OG/kzqFi9xXr3zQfyg0x+HMM6WY
        GPmf9Q/DlgsZ57CKHzx4zGPXinfZUrPrLp66yP2b3bjgX25E7n3/X5dT85y0duvZO7+MmhyV
        MWONOr/IYSWW4oxEQy3mouJEACApMQcGAwAA
X-CMS-MailID: 20231206063121epcas5p17a110abeea781dcb8760b4da4c8e4074
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063121epcas5p17a110abeea781dcb8760b4da4c8e4074
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063121epcas5p17a110abeea781dcb8760b4da4c8e4074@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MFCv12, the rc configs are changed with support for CBR loose,
CBR tight and Variable Bitrate (VBR) added.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 22 +++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 36aebca11313..4a0d0e228e78 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -992,10 +992,24 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 
 	/* reaction coefficient */
 	if (p->rc_frame) {
-		if (p->rc_reaction_coeff < TIGHT_CBR_MAX) /* tight CBR */
-			writel(1, mfc_regs->e_rc_mode);
-		else					  /* loose CBR */
-			writel(2, mfc_regs->e_rc_mode);
+		if (IS_MFCV12(dev)) {
+			/* loose CBR */
+			if (p->rc_reaction_coeff < LOOSE_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* tight CBR */
+			else if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(0, mfc_regs->e_rc_mode);
+			/* VBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		} else {
+			/* tight CBR */
+			if (p->rc_reaction_coeff < TIGHT_CBR_MAX)
+				writel(1, mfc_regs->e_rc_mode);
+			/* loose CBR */
+			else
+				writel(2, mfc_regs->e_rc_mode);
+		}
 	}
 
 	/* seq header ctrl */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index ff582eea4217..94ecb0e6e7c7 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -40,6 +40,7 @@
 #define ENC_H264_LEVEL_MAX		42
 #define ENC_MPEG4_VOP_TIME_RES_MAX	((1 << 16) - 1)
 #define FRAME_DELTA_H264_H263		1
+#define LOOSE_CBR_MAX			5
 #define TIGHT_CBR_MAX			10
 #define ENC_HEVC_RC_FRAME_RATE_MAX	((1 << 16) - 1)
 #define ENC_HEVC_QP_INDEX_MIN		-12
-- 
2.17.1

