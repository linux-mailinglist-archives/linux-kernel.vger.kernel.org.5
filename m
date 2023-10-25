Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2C7D68C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjJYKf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjJYKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:01 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2E9170B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:34:48 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231025103446epoutp04eeca6de90f9127d488bf67f1779f6689~RU0Qatd-e1961119611epoutp04h
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231025103446epoutp04eeca6de90f9127d488bf67f1779f6689~RU0Qatd-e1961119611epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230086;
        bh=Z+KKbPVPr965VdQGjwihOK7YJEPYhTFdKL7s8gr9R5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ch/SYzkM4DZHoJpdS1NHOIhnzgS0I3kBjXTYNv62tzCWZDAQqCIXF+m6ELNQrJj14
         lvFEyQv2aeY413HMp0Wysd0nmRuBrR/tUwOGco8rdPZ5cznyLGu5MhTOpOuJcOpZ28
         2HeURVU/ofdJAuIFCPXebvpGaBsZTQXWR/sKvJZQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231025103445epcas5p1e4dbabb8af54cd509b820ad7d25c0826~RU0P54RZj1501915019epcas5p1E;
        Wed, 25 Oct 2023 10:34:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SFlfr1YXFz4x9Py; Wed, 25 Oct
        2023 10:34:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.C5.09672.34FE8356; Wed, 25 Oct 2023 19:34:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102247epcas5p1103ae6d3194f2ffc354984e263ab7b4a~RUpyjUwAa2162221622epcas5p1G;
        Wed, 25 Oct 2023 10:22:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231025102247epsmtrp1b1aa4014eec5498ebd9a9f47c0acd370~RUpyg6Wk32140421404epsmtrp14;
        Wed, 25 Oct 2023 10:22:47 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-8a-6538ef439205
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.40.18939.77CE8356; Wed, 25 Oct 2023 19:22:47 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102243epsmtip1fe0e041b500a410447cf8821b871a749~RUpvbjkYQ0054700547epsmtip1O;
        Wed, 25 Oct 2023 10:22:43 +0000 (GMT)
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
Subject: [Patch v4 05/11] media: s5p-mfc: Add support for rate controls in
 MFCv12
Date:   Wed, 25 Oct 2023 15:52:10 +0530
Message-Id: <20231025102216.50480-6-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+697S3Gspsq4awRx5rIAhNope0Oi9WpnVyGbgRdmPIHa+gd
        EEp701s2BskGxhLHxsONobxKEZgOEEkRKAgOCo7oAgRFCUYmBckGPkA7CMyNraXo/vv8vuf7
        e5yXABeN8cWCVL2JMeo1Ogl/E9HeHxwcql5AjDS/Bkez9jIe6l3oI9CUpZ2Pald+x9D9WheB
        HK1tJGrqGcbQ+cFeHqoeGOahjr5pAk30dmJotGySQIV/OHFkm7nDQ875eHSrq5KPvm1p46Gz
        I1cxdHFgkkT146MY+tH2N4bOtf1JInPPAIlO5tbx3oV0k6UJ0ON1z3C6s3ySpGu75zDa1vA1
        n753p5tPt9Z9RZuv/UXQhZcbAL12ooqkXbbt9I0lFxm7+Xja7hRGo2WMgYw+yaBN1SerJDFH
        Eg8kKpRSWagsEr0tCdRr0hmVRH0oNvRgqs69eUngZxpdhluK1XCcJHzPbqMhw8QEphg4k0rC
        sFodK2fDOE06l6FPDtMzpndkUukuhdv4SVrKwtgIxj6nMqeLBvEcUOqbD3wEkJLDoopVMh9s
        EoioKwB2rD3GvMEzAEvsLv7LwFU14bYJ1lMK14569U4Aiy124A3MGGx/9JjnMfGpUDjUofO0
        2ErlAjhzyuTx4NQZAs40u0jPwhbqCCx1XCQ8TFA74FBd1ToLKRV8ODhLeOd7HTa29OIe9qH2
        QOvyifVZIbUogFPlZzYmUsOx6g+9/i1wfvAy6WUxnCvK2+AkOHNuDveyDl7qLtmovxf2jlUS
        njI4FQwvdYV75QD4w41mzMM45QsLnj/AvLoQ2i0vOAhW3lvheXkb7G+sB16mYenUGt/DIuo0
        gJXThmKwvfz/DlYAGsBrDMulJzOcgo3QM5+/vLMkQ7oNrD/vkBg7mJ5aDHMATAAcAApwyVbh
        sUOIEQm1mi+yGKMh0ZihYzgHULiP7zQu9ksyuP+H3pQok0dK5UqlUh4ZoZRJ/IUPzVVaEZWs
        MTFpDMMyxhd5mMBHnIMlfG/ItB4bUmtvZ7N399YUH+aN+M4ffiOi9tWY0kqUOZF2XbWkck5z
        FW9+15cl+udAMcssZC2F9Yjj6n/xb0koCDq7uTw86pQwpMxya6e5/+orK08eFA2I8ony+eyn
        2c3NCqvxt/05k2VjCfZ4Suxk/w2MEtzEaqJ71Lveu5nxVt43fnZHfAG13Bj9aX9Jq/BJXJf6
        Z8Xw4nXLT4vV+3cI4+e2DXzwcbSWtB3PNOU5/ZYv+CjuXmgbb6wIgKqDITH3Z0tti0eDgbTD
        uO/pSoJyLSr01xH20bVJ6svIvMIE8/nh0YPh73+0um+UzRXL4xihlS/fGWC90hZ0cpX2v73k
        lBBcikYWghs5zX+Oy30pZwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTrf8jUWqwY9uFounO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdksfz4AVaL+UfOsVpsP/iIxeLmgZ1MFhdn3mWx
        6HvxkNli0+NrrBYPX4VbXN41h82iZ8NWVosZ5/cxWaw9cpfdYun1i0wWyzb9YbJYtPULu0Xr
        3iPsFi2NS1gdJDzWzFvD6HF9ySdmj52z7rJ7LN7zkslj06pONo871/aweWxeUu/RevQXi0ff
        llWMHv+a5rJ7fN4k53Hq62f2AJ4oLpuU1JzMstQifbsEroz3V84zFfwWqHjUf5y5gXEaXxcj
        B4eEgIlE37+QLkYuDiGB7YwS17eeZepi5ASKy0j8bzvGDmELS6z895wdoqiZSWLPjHksIM1s
        AroSZ7fngMRFBFqBmld2MoE4zALrWSSObFgC1i0sECjxdeZRMJtFQFXi7JK5LCA2r4CtxOvj
        T1kgNshLrN5wgBnE5hSwk1jwrQmsXgio5v79H4wTGPkWMDKsYhRNLSjOTc9NLjDUK07MLS7N
        S9dLzs/dxAiOLa2gHYzL1v/VO8TIxMF4iFGCg1lJhDfSxyJViDclsbIqtSg/vqg0J7X4EKM0
        B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgcnD+kClUdYbh7R3IZtZJKenyrN/WnCC+b3T
        x6bk45d9dqScXXTLn7FWe7fNGXW5rS1ScqKxD7oNLnwV7DdT82nme797X86sufPDdNw2Jk/Y
        kPFK84zNobfinnw/PX22dede+KDG+OSIq3yRxvzOyg1buPz/7etg5u0672NjbXvCQnRG0gzb
        HV5LQwKOmnxVl+xIPpS2YKrFxUTZ270MSoHdRjma9lusOkwvTtErLrRx0F1duWPfSR/hsxGs
        c4wY3Oxs3J6ffb+i7M/08gXiwnELDdSi5xac+/FQfDFHgvb3n81lWv//2Ab6P6z34GG1KaqV
        fKl+9cSXYyrGPp05m+K2fbe8eCjwx6x/u/rKlFiKMxINtZiLihMBk9NIlhwDAAA=
X-CMS-MailID: 20231025102247epcas5p1103ae6d3194f2ffc354984e263ab7b4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102247epcas5p1103ae6d3194f2ffc354984e263ab7b4a
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102247epcas5p1103ae6d3194f2ffc354984e263ab7b4a@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index e579c765e902..bed45857bd6c 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1025,10 +1025,24 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
 
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
index 30269f3e68e8..24752a712fbf 100644
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

