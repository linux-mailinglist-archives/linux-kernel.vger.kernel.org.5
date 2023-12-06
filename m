Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC39806783
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376856AbjLFGg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376845AbjLFGgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:36:51 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82510C4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:36:56 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231206063654epoutp011a0d1ad97381be60ba2bbf653ab29b3c~eKqkDNd6a2441024410epoutp01j
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:36:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231206063654epoutp011a0d1ad97381be60ba2bbf653ab29b3c~eKqkDNd6a2441024410epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844614;
        bh=ZBAl/HNYuuxGQfLFUXbfQ7Rq5dNJRy0YKnMEv/Z9Bfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUddpJYX6ixng9xfs5PmwsxVXzSTwG1oiBepfMPbo38jhaSlLbYzQ0m5qV9CN/c+/
         pTibMQTAlJDhJPQe96XATuGIKhGHW8QimAnImy9GWNlBOo++R7pSk9g8ssR4EXMe6c
         ftgNPNZLq6Ts48rdItHNcQ1ke39M1/aC6hc1GRCI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231206063654epcas5p19de7ba8aeeca03c4bd9e34590b9f94b7~eKqjuRbzI1242012420epcas5p1E;
        Wed,  6 Dec 2023 06:36:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SlSP01pvdz4x9Pt; Wed,  6 Dec
        2023 06:36:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.1B.10009.48610756; Wed,  6 Dec 2023 15:36:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063125epcas5p2c5d07f51ba83198ccb8fbab005bab8f6~eKlxY58sy0993309933epcas5p2N;
        Wed,  6 Dec 2023 06:31:25 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231206063125epsmtrp188308a3c077d98679037f971adc42b64~eKlxYEJHn1597215972epsmtrp1v;
        Wed,  6 Dec 2023 06:31:25 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-77-65701684aa20
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.A6.18939.D3510756; Wed,  6 Dec 2023 15:31:25 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063122epsmtip25788e1272f6e3a4361e5745c1c3065a9~eKluZl3r_0453504535epsmtip26;
        Wed,  6 Dec 2023 06:31:21 +0000 (GMT)
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
Subject: [Patch v5 06/11] media: s5p-mfc: Add support for UHD encoding.
Date:   Wed,  6 Dec 2023 12:00:40 +0530
Message-Id: <20231206063045.97234-7-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbZRjG951z2h5IiocC87PRjTXChAxoZ8EPBXSTwGFbYrdlTp2GVTih
        hN7sacHLorANZCAFZJswua7sknJdgQ0QWCkojIWLShgSUEingxl2ATELIrG0Zf73ey9P3uf9
        LiQu6OIKyVS1ntGp5UoR15O43hcUFHJ6q5YR3+nzRL+3l3GQ9WEvgWYrr3OR6ck9DP1mWiaQ
        raWNh+q7RzBU1T/CQb9YOzD0Y9kMgYzzcziy2Cc4aO7+UfRzZzkXfdXcxkGloz0Yauif4aHL
        ljUMXWz7i4eyu/t56HRWLecNP/pO7RJOd1yY4dGmrgWMtpjPcOnpiS4u3VL7BW1sNQN6/WQF
        j162bKOHVpZ5Ms/30qIUjDyZ0fkz6iRNcqo6JVq0/3Dim4nhEWJJiCQSvSLyV8tVTLQo9oAs
        JC5V6dhR5J8uVxocKZmcZUVhMVE6jUHP+Cs0rD5axGiTlVqpNpSVq1iDOiVUzehflYjFu8Md
        jcfTFCudY7j2tvfHN79eJzLBrFce8CAhJYVX2qs4ecCTFFDfATh5agC4giUAr+bPE08D49VF
        fFMy2mXiugodANZMT7ol2Rhsq6hySEiSS4XA4RvKDYEvlQWgPVe/0YNTAzisLiojNgo+VDy8
        MmXCN/oJKgCWtry2keZT0dBWvIa5hm2Hdc1W52APKgaera92eoXUGAmXWxp4rqZYeKuv3M0+
        8P5Aq5uFcKEwx81J0H5xwb2BEjZ1nSVc/Dq0jpc7PeNUEGzqDHOlX4DnhhqdHnDKCxb8c9ft
        hw/bKzc5EJZPP+G4+HnYV3cJuJiGM8VfOllAFQPYUx9TBLZd+H9CNQBm8ByjZVUpDBuu3a1m
        Mp5eWpJGZQHOZxy8rx3MzT4KtQGMBDYASVzky1eOahgBP1n+yaeMTpOoMygZ1gbCHcdXjAv9
        kjSOf6DWJ0qkkWJpRESENPLlCInoWf6f2RXJAipFrmfSGEbL6DZ1GOkhzMQa5g6N/3viyKBR
        N6bJ2jvIVi/hTMlk/4F37wUc3PGDLGrlA+MUnRD3bc9bPvGFq58tIbvw2t+07VfDyXUPRabn
        jZHBU8Tj+GzsmcP+t72nyPzCjImEgm9W++137Zlru3Y9qB24VW42rgaaGhevfWT3GU5IP3g8
        cgbMT5E7Ot//Y4vHvuhcFaesuuZcrK8scnQ5YelYZYDppaPpzQ9HvS2kVGb43CbEc/K63z5j
        3WP1qyrZ/05MjLD30vkTuTfNlamXa37KTPg+Q1lUd4TbVJcjVpx/Mb9K3jBWsnVcUqMaHsot
        aA9trRQ3Lh4zBwZrevv2Dn342Kv0wR7JzkT+lrA4waPtIoJVyCXBuI6V/wfuC3VtTwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK6taEGqwYmVvBZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGV83XWBueC0YMX+Sf9YGhgf8HUxcnJICJhInN+zmK2LkYtDSGA7o8ShZ1eZIRIy
        Ev/bjrFD2MISK/89Z4coamaSmHBnLVMXIwcHm4CuxNntOSBxEYFWRonrKzuZQBxmgdvMEpsm
        PATrFhZwl1h+azEzSAOLgKrEjM3WIGFeAVuJQxP/MEEskJdYveEA2GJOATuJKWsWsIKUCwHV
        rDzpOIGRbwEjwypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4DjRCtrBuGz9X71DjEwcjIcY
        JTiYlUR4c87npwrxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFw
        SjUwSTPv+/4wSEpB2zPW5p2UbcCeBemL5JniDlXPWXJsepZWW93vU8HPNJ72ZcRfENr1w6zt
        3rYjem3zahi/9p24c/TksnRbJXOe3Rdblv17Xnz3yMsvq2ffnMfbF+v3WdNkBf+lzI+vzz0L
        3HW89OBRNvEkmzXh+ZPZ1T1+HlwVVcnMbCiz0NRwTkx9gjcjU/5UnoD6RsPNc0QsPOvM5367
        c2G7qUtPx8Xa+rdJmk/5G+emu/xO8dumPD/WWk7vIJOJ1+RJlW0GkqZqltzrny5T4ZVrkLMI
        LcpxL3ywVO2VwZygKhHV2ieXHm/g3BZUo+7U9sq688SRjdM5X88x/+n/uc3Ab8OXH/f3TS8K
        9i9TYinOSDTUYi4qTgQAeA263AIDAAA=
X-CMS-MailID: 20231206063125epcas5p2c5d07f51ba83198ccb8fbab005bab8f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063125epcas5p2c5d07f51ba83198ccb8fbab005bab8f6
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063125epcas5p2c5d07f51ba83198ccb8fbab005bab8f6@epcas5p2.samsung.com>
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

MFC driver had restriction on max resolution of 1080p, updated it for
UHD. Added corresponding support to set recommended profile and level
for H264 in UHD scenario.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c |  9 ++++++---
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  | 12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 6b495a738291..b01b9511e50c 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1461,9 +1461,12 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			mfc_err("Unsupported format by this MFC version.\n");
 			return -EINVAL;
 		}
-
-		v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
-			&pix_fmt_mp->height, 4, 1080, 1, 0);
+		if (IS_MFCV12(dev))
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 3840, 1, &pix_fmt_mp
+					->height, 4, 2160, 1, 0);
+		else
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1, &pix_fmt_mp
+					->height, 4, 1080, 1, 0);
 	} else {
 		mfc_err("invalid buf type\n");
 		return -EINVAL;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 4a0d0e228e78..572293f3b190 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1071,6 +1071,18 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 	reg |= ((p->num_b_frame & 0x3) << 16);
 	writel(reg, mfc_regs->e_gop_config);
 
+	/* UHD encoding case */
+	if (ctx->img_width == 3840 && ctx->img_height == 2160) {
+		if (p_h264->level < 51) {
+			mfc_debug(2, "Set Level 5.1 for UHD\n");
+			p_h264->level = 51;
+		}
+		if (p_h264->profile != 0x2) {
+			mfc_debug(2, "Set High profile for UHD\n");
+			p_h264->profile = 0x2;
+		}
+	}
+
 	/* profile & level */
 	reg = 0;
 	/** level */
-- 
2.17.1

