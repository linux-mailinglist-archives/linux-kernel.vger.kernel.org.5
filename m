Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2646D810F31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378217AbjLMLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378337AbjLMLA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:00:56 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56AAF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:01:00 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231213110059epoutp02726d84ed0717353e6528c48558cd1d2c~gXyIfanVT0120001200epoutp02F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:00:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231213110059epoutp02726d84ed0717353e6528c48558cd1d2c~gXyIfanVT0120001200epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465259;
        bh=BuzCw9s44y8vOCjVUfZWEiQy85UK4HFZlEIF9gRnXwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d96nmvKcNgoKUcqL5+I3GagC4f8+dL+GJtoiXlWZfoRM4aQAkjNPwPAm2A4O7Yd+i
         euZlv7s8yDa7dfYrT3G/7HIBCEm9AhD67ARKFFxqjHIFA2dNQkzWI/2RodMOEBnpGF
         tYCNQ7+hJU/cjfKN2YDInVkBcNLascJz+WqGToCY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231213110058epcas5p344be0b5ac6e731b27635838e3562362b~gXyH422sM0879108791epcas5p3L;
        Wed, 13 Dec 2023 11:00:58 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SqswS71xbz4x9Pw; Wed, 13 Dec
        2023 11:00:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.FF.19369.8EE89756; Wed, 13 Dec 2023 20:00:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231213081131epcas5p181e1178375a69d021e138b4c16f8da67~gVeLBD1wI0225002250epcas5p1W;
        Wed, 13 Dec 2023 08:11:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213081131epsmtrp102ee6bb28eed07ee52e81905ea8e4f7d~gVeLAGzxZ2318823188epsmtrp1w;
        Wed, 13 Dec 2023 08:11:31 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-ea-65798ee869d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.96.18939.33769756; Wed, 13 Dec 2023 17:11:31 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081127epsmtip2fd2029a643c56e25faaabcde40a581ef~gVeHVMmum1420914209epsmtip2W;
        Wed, 13 Dec 2023 08:11:27 +0000 (GMT)
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
Subject: [Patch v6 05/10] media: s5p-mfc: Add support for rate controls in
 MFCv12
Date:   Wed, 13 Dec 2023 13:41:00 +0530
Message-Id: <20231213081105.25817-6-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xbVRTHc99r+woZyxsDvKlzkmeGYUtL6wpcyKhOUV+iyXBMUSPiC1wL
        obRdfwxRzAABZye/FBQYIAHErPzqCoyC4LoW3IaDMViYbhBARhwMZMJIMNQppWz+9znf+z33
        nHN/CEnfPoFImKI2YJ2aUzECb955Z3Cw+G5hBpY6rsjRnK2Cj+zLF3louua8ANWv/0GgqfpV
        HnK0d1KouW+YQN/1D/PRb/ZuAl2vmOShwrszJLLOjvPRzEIcGuupEqAvLZ18VH7tJwK19E9S
        qNHqIlBd5wMK5fX1Uyg3u4H/gj97s2GFZLsrJym2vneeYK3mLwTsxHivgG1vOMkWdpgB+zCn
        mmJXrXvZwbVVKsb73dRDyZhLwrpArE7UJKWolVHMa7EJLyWEhkllYlkECmcC1VwajmKiX48R
        v5Ki2pyRCTzBqYybUgyn1zMhikM6jdGAA5M1ekMUg7VJKq1cK9FzaXqjWilRY0OkTCp9LnTT
        +EFq8vrSOKX9m/6ozjUgyAKlO03ASwhpOcydrOGbgLfQl+4F0H7/MuUJVgA8M9RBPA6udjl5
        JiDcSrlc/rJH7wZw0Tm1bcoj4OeNc4TbJKDFcKhL5S7hR2cDOHvK4PaQ9CUS1hZX8NwLu+lY
        eG3ARLqZR++DzS25fHeuDx0FS9f9Pe09DZss9i2LF62Af+ZcAO59ID0ihMvOQb7HFA3PZZ8F
        Ht4NFy51UB4Wwfmi/G1OhLN186SHVbCtt5Tn4eeh/UbV1mAkHQzbekI88lOwbLCVcDNJ74QF
        G3cIj+4DbTWPOAhWTaxvt7AHOpu+326BhR1Z57ZPsQTAvh9GiWKwt/L/ErUAmIEIa/VpSpwY
        qpWJ1Tj98a0latKsYOsd74+xgSbLPxIHIITAAaCQZPx8rtjSsa9PEpfxMdZpEnRGFdY7QOjm
        AZaQIv9EzeZHUBsSZPIIqTwsLEwecTBMxjzhcy+vOsmXVnIGnIqxFuse5RFCL1EW8a05J9hY
        /+mx4icDApgPD8cdv91cK/UabTE9/Nm0Iq2Oj1eeXPydqhCv1+TNRkrGxo5eMN5eWJ2zfR1y
        upX3zls7HI3D2fnVu27FuqaDXnXa3/vLckv1hk1WUPljvI1pST94I325JLKq7PgeP73k2cxR
        aY6/4ATRdkdyUaHwj5gJqWvP27f02X38ifmBIrx2JJ8oKuNSZyStliM2S1xM1b/VXcMTmQu5
        xyqSewfK14rKon+5mTFnb98IKXmzx3X4euvI24qj9xbfDw/adToTj56iR61NmWPfmL3lO17M
        GFxdY6cPLDcNxdeeFSoKAn796hnXUttUF19ZabmaJRa55g9spDA8fTIn20/q9Nx/Md9S61AE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvK5xemWqQds9UYunO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdkMf/IOVaLmwd2MllcnHmXxaLvxUNmi02Pr7Fa
        PHwVbnF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWSza+oXdonXvEXaLlsYlrA6iHteXfGL2
        2DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R59W1Yxevxrmsvu8XmTnMepr5/ZA7iiuGxSUnMy
        y1KL9O0SuDJ+vL3GXvBToGLRn6NsDYxT+LoYOTgkBEwkTsxw7WLk4hAS2M4ocXXfEZYuRk6g
        uIzE/7Zj7BC2sMTKf8/BbCGBZiaJF1d9QHrZBHQlzm7PAekVEWhllLi+spMJxGEWuM0ssWnC
        Q7AGYYFAibUnz4INZRFQlViztoUVpJlXwFZiyg9RiPnyEqs3HGAGsTkF7CTeNe1nhNhlK7F8
        923mCYx8CxgZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIER4lW0A7GZev/6h1iZOJgPMQo
        wcGsJMJ7ckd5qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwen
        VANT5uPyoBKPrYUxrFZ7SvkFmTt5poU8XfxppeEmUauTi6IFqqJfcYm+zH+3+FjEY71Nzsfj
        WE4pNPQe+i52parS5UDPE9cVXx1XLXvQwWSdLK2S+93a4FnAkkMz6rRMFOsf7Hz6UcylVdlu
        WvWh6ccZmiTXlvHcNFzheND6Weo8oYMiRlNmmm+YcnH12pSowp1/fD6/fKdwoT+4RyVw2uNF
        umI/5rjdKdim/D+cSywnz6JfoWPB1nefFjKuerHoacOpbdalIoHZOY8MtDsWKdya8ibh0P+Y
        rY/S69orQvzdJlQYf1/DKtZidjRI+Jji02n/S9dl5H6blTb39BKjSRt8TgiF2r0Qy2KNm1YU
        cWCBEktxRqKhFnNRcSIAOlTbSwEDAAA=
X-CMS-MailID: 20231213081131epcas5p181e1178375a69d021e138b4c16f8da67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081131epcas5p181e1178375a69d021e138b4c16f8da67
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081131epcas5p181e1178375a69d021e138b4c16f8da67@epcas5p1.samsung.com>
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

