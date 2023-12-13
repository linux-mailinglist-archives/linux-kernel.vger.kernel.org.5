Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB6810F36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378337AbjLMLBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378486AbjLMLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:01:11 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8143A112
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:01:15 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231213110114epoutp01be14afabe8f5e5b86c28440ef8eacf8a~gXyWOz5yu1005610056epoutp01Y
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231213110114epoutp01be14afabe8f5e5b86c28440ef8eacf8a~gXyWOz5yu1005610056epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465274;
        bh=jJOiJAOqUxw+8lfnjEPGdmszClcTNpX1R54Qh3u+3n4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n84PAUaI4yE0NwP+/MFeEVwoCI5SUTxx/FKN8KXNO6PWd18tUisgKUdP+hORkDrxV
         tEpn2qJIDKvS+gmimZGpV87w/mFSINgpME0vOABgk5eul8ixkcbT85ZE/RW1m47RpW
         MYg1x4YIzY/ZZViteXgEQDPXbsOlLuUmtECaCctQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231213110113epcas5p2f9e4708ddad5bac4de66fcded37c9802~gXyVsZlKv0140701407epcas5p2n;
        Wed, 13 Dec 2023 11:01:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Sqswl5pPgz4x9Px; Wed, 13 Dec
        2023 11:01:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.CB.09634.7FE89756; Wed, 13 Dec 2023 20:01:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081134epcas5p2fdbd2577fe46b848c87ea5d89cbb96f5~gVeN8TZwS1902319023epcas5p2M;
        Wed, 13 Dec 2023 08:11:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231213081134epsmtrp261701888e93dfa0492b9a960185aa747~gVeN1KWmM2150821508epsmtrp2Z;
        Wed, 13 Dec 2023 08:11:34 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-fa-65798ef7a089
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.E2.08817.63769756; Wed, 13 Dec 2023 17:11:34 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081131epsmtip2e566b3614165bf4d6ea63c67f2ac5475~gVeLCGAi41539415394epsmtip2x;
        Wed, 13 Dec 2023 08:11:31 +0000 (GMT)
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
Subject: [Patch v6 06/10] media: s5p-mfc: Add support for UHD encoding.
Date:   Wed, 13 Dec 2023 13:41:01 +0530
Message-Id: <20231213081105.25817-7-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHc+5tb0uX4hWpOxZhzY1j0VhsWdsdDFUXmFy2sZCQPYJ/wE17
        A4zSdn0M2eaGBDLXOCI6QmEVCA8T8cFLWJWHpbAQcQKGDefaBgg+QCMwQCHZRtZycfvvc36/
        7+/7O+d3zhHiET2EVJhntLEWI2OgCBGve3DvG/K18iJWsXB3P3roruYjz+IAD03XdhOocf0x
        hqYaV3jI29klQJf7RjFUNzTKR/c91zF0tzrAQ+VzMzjqmJ3ko5knH6OJGy4CnW7r4iPnWD+G
        rgwFBOhCx98YauhaFaCyviEBKj3ZxD8ioe81LeP09ZqAgG7sncfojpbvCNo/2UvQnU3f0OXX
        WgC9UXJeQK90xNAjz1cE6aLM/MRcltGzFhlr1Jn0ecYcLfVeRlZSllqjUMqVCegtSmZkClgt
        lfx+uvxoniF4Rkr2OWOwB0PpjNVKHTiUaDHZbaws12S1aSnWrDeYVeY4K1NgtRtz4oys7aBS
        oYhXB4XZ+bmBm2N88+3tx1dHavjFYDrcAYRCSKrg2CrjAGHCCLIHwOo2uQOIgrwM4LCzWMAt
        XgDY1lIGQqpQQePQzxiX6ANw+tG3BLcow6Brql0QsiVIObzzkyFUEEmeBHD2lC2kwclhHNaf
        qeaFEjvIFOion8NDzCNfh21zzzdZTGph+2w/znV7DV5q82xyGHkILpTcBCEjSI4LocdXJeBE
        yfDOwDzG8Q74ZPjaVlwKVxb6CI51cLZhfsvUAFt7f+BxfBh6fnXxQpvGyb2w9cYBLhwNK0eu
        blriZDj8/q8HW/Zi6K59ybHQ5V/nc7wbDl5qBtxIabh+cWuMFQCe3viHOANiav7vUA9AC9jF
        mq0FOaxVbVYa2cL/7kxnKugAm694X6obBKaX4rwAEwIvgEKcihTfcheyEWI9U/QFazFlWewG
        1uoF6uD8KnCpRGcKfgOjLUupSlCoNBqNKuFNjZJ6Vfy07Lw+gsxhbGw+y5pZy8s6TBgmLcY+
        TYscWNuQpVuY/e8c+yClXvo0c/tSNHtsqTIqtc776KoqSZ8saz1u8mU6T1G/1D1z+yRd0ytL
        J7LHzz2ui5OdjUv7uh55Mj5599lwrGPCoFb0pPgnbYen3naWtESlWV7EF2ZVpeT/mKhz7+qf
        kaqSJa17PsSqWYl3t/hgVaVIVdo8WNfubNKFT/n7XlH+Uer7Xcsf9a0FUocawvtFy+b5Zs+I
        T34uZpE5m2p/qOk6cbQo26f2L9aOXx5wOczxzZ9d/Eii7Sm9TVzInVSSFVExS52uxK8yj5Tf
        vxLNbAO3HiQl7dGTX96byvjzN5tdUyTaifdsTER4/OXbdnZHxVI8ay6j3IdbrMy/MFcYEU4E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK5ZemWqwekr4hZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGXc3X+eteC0YMWXU7NYGxgf8HUxcnJICJhILD5ylAnEFhLYzSixZaEqRFxG4n/b
        MXYIW1hi5b/nQDYXUE0zk8SN9/3MXYwcHGwCuhJnt+eAxEUEWhklrq/sZAJxmAVuM0tsmvAQ
        rFtYwF2ia8ELZhCbRUBVYsOLr2A2r4CtxMbH+5ghNshLrN5wAMzmFLCTeNe0nxHiIluJ5btv
        M09g5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4YrS0djDuWfVB7xAjEwfj
        IUYJDmYlEd6TO8pThXhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl
        4uCUamDivlhc5vND9b1B8hWp47ohOXdMi36+KgrR2ijQkeX7oPPXfNFDnw+2d2aZP0qoWvzf
        p+zK4UO9i/dWhV29ErPBc4cXQ+G9NV8zou9cVpidrLtw05dZkq+WrKzJYnwioM7y9fnny/Mf
        XNevmligV1lgm5C146n3GXsOi6JzFgccjb0Lt4jEmjRbc9m7Zytwdsp+Wr5trdh2/iKVpQYc
        3AphK8PLWI58tVQQ8tFxZlYOnKBwr3tz3/yD+Ty8b8MW2lgoasUc9nv6JaVY8v/zA6kCZc5P
        rs02dZBM4eS9cOhgt9m/4yyXWTwVdtsd1DdkaVhrWOAbXcFSaW1xM3NZRdFnxbMPsjnYHhmx
        hfnoKbEUZyQaajEXFScCACiPNpsHAwAA
X-CMS-MailID: 20231213081134epcas5p2fdbd2577fe46b848c87ea5d89cbb96f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081134epcas5p2fdbd2577fe46b848c87ea5d89cbb96f5
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081134epcas5p2fdbd2577fe46b848c87ea5d89cbb96f5@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 2f11a1e861e1..67fe0302464f 100644
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

