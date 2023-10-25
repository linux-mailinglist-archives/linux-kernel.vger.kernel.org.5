Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1E27D68FD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJYKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjJYKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:36:10 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54119A9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:35:20 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231025103518epoutp02dd493960de866d76f303c8108fad2d0b~RU0uQxdqo0470004700epoutp02T
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:35:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231025103518epoutp02dd493960de866d76f303c8108fad2d0b~RU0uQxdqo0470004700epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230118;
        bh=9GpUiOqgpaKnK/kt4FXCA/fW7cvkvm7nRH/fpn+snG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ibubbp6IfWwMPntT8N7UReZe/3qzSoN/hByEZKrHAuJfQc7RDEoHXbY/eUk+Mwh4n
         tQoGSoGt9oXK1B+dn0/0vdnF/hh4jjToLaRRV3q9w9N5dV3CC/nfvGXE8v7cWitb6x
         IWCmIVRB+9+6tB4LjDsQM3UBUXpr4+bsCX8MbCWo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231025103517epcas5p17763402a4b1ac8faa3eee9f79362a8ab~RU0try1qR1904419044epcas5p1W;
        Wed, 25 Oct 2023 10:35:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SFlgR4ltrz4x9Pr; Wed, 25 Oct
        2023 10:35:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.1C.10009.36FE8356; Wed, 25 Oct 2023 19:35:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231025102250epcas5p375603c0f150fd508f0c0aa3ec6305517~RUp1rWPd61181411814epcas5p3q;
        Wed, 25 Oct 2023 10:22:50 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025102250epsmtrp2af06661f42d6497db2de54ef3cc0015c~RUp1qdt2a0882508825epsmtrp2L;
        Wed, 25 Oct 2023 10:22:50 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-57-6538ef637724
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.70.07368.A7CE8356; Wed, 25 Oct 2023 19:22:50 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102247epsmtip1ac3813ce37c72c5dcd07a91526f6e1a4~RUpymxxfS0719907199epsmtip1w;
        Wed, 25 Oct 2023 10:22:47 +0000 (GMT)
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
Subject: [Patch v4 06/11] media: s5p-mfc: Add support for UHD encoding.
Date:   Wed, 25 Oct 2023 15:52:11 +0530
Message-Id: <20231025102216.50480-7-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxjGd+697S3Esiu47EA2JM0kYAZSKXgQypbw4VVJBnGLsGXDu/au
        JZS2a8s2+GfC7KZ1KBJkg0B10OKGCFgoH0q1fBhUWBecwgigfKpQh44yZV8ySmH773ee87x5
        zvuec3i4721uAC9LqWM1SkYh4HoTrT2hIWGSx4iNuNsfiGbbyznI/riLQBPGVi6qWX6AoXs1
        LgJ1N1tJVG9zYOhcn52DzvQ6OKita4pAI/YODA2WjxPoxMNJHFmmhzhocv4g+vlSJRd93WTl
        oG9/uoKhC73jJDIPD2Ko1vI3hqqtSyTS23pJdKTAxHkT0vXGekAPmxZxuqNinKRrOucw2lJ3
        jEuPDXVy6WbT57T+2p8EfaKlDtDPC6tI2mUJpG/+7iJTN72bHSdnGSmrCWKVEpU0SykTC/Yf
        yEzIjIqOEIYJY9AuQZCSyWHFgsSU1LDkLMVq84KgTxhF7qqUymi1gh3xcRpVro4Nkqu0OrGA
        VUsVapE6XMvkaHOVsnAlq9stjIjYGbVqPJQtb6t6QKj7N3921DrAOQymfAzAiwcpERy2WDkG
        4M3zpS4DeHHmJO5ZLALYs6IHnsVTAEsKm4mNktGCpTX2pWwANpaJPSY9Bh9Z2kgD4PG4VBj8
        sU3h9myhCgCcPqpze3DqGwJON7hI94YftQc2DIxibiaobbB+ZAW4a/mUGN4tjfFkbYXnm+y4
        m72oeHj2aSHp0Zd5sMmU4OFEWPy8muNhPzjf17LuCYCuBRvXwxI4XT2He1gBGztL13t5A9pv
        VxLuWJwKhY2XdnjkV+Hpmw1rJ8MpH1j01wzm0fmw3bjBwbBybHk99hXYc94MPEzDlXrT+hBP
        AWi9NUYUg8CK/yPOAlAH/Fm1NkfGaqPUO5Xsp//dmUSVYwFrz3v7vnYwOfEkvBtgPNANIA8X
        bOFnpCDWly9l8vJZjSpTk6tgtd0ganV8p/CAlySq1f+h1GUKRTERoujoaFFMZLRQ8DLfqa+S
        +lIyRsdms6ya1WzUYTyvgMMYN8ThKJ51xF7Ly3fKDKJO8j3DzEkf8E+tf8mQVN93ldt0h3z/
        Y3NtU1rK9HE2MkFnyr+xz+R0jXvH3nfG3Z9May3fPGx85/KB0R86vkzq1aaOEgbK1l+Qt7t8
        PHDbHv8yZ8Yvorgy2W/H5+VXepQKuff15oEXHs3fEnf1VZYG9z5ZnJhL+26wca+Pqijki9Lk
        bmiULWa09C/OpicNbr3uXIo/9Gu6d9qI1xR6y0/yeuRE0K7UgYcBCx+VFAluvBgYbD5j9uPn
        JF84+Pam2at3GHjaqEnHBpGD88dQ0kps4ofB5nN7mflnIf6u2WcL39uaP6j56jXdvdCL/uyx
        iiNe++0CQitnhNtxjZb5F4DcqjFnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTrfqjUWqQfsiSYunO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdksfz4AVaL+UfOsVpsP/iIxeLmgZ1MFhdn3mWx
        6HvxkNli0+NrrBYPX4VbXN41h82iZ8NWVosZ5/cxWaw9cpfdYun1i0wWyzb9YbJYtPULu0Xr
        3iPsFi2NS1gdJDzWzFvD6HF9ySdmj52z7rJ7LN7zkslj06pONo871/aweWxeUu/RevQXi0ff
        llWMHv+a5rJ7fN4k53Hq62f2AJ4oLpuU1JzMstQifbsEroztc5+zFJwWrOjYeoa1gfERXxcj
        J4eEgInE7cYvLF2MXBxCArsZJa7MOskGkZCR+N92jB3CFpZY+e85O0RRM5PElZatjF2MHBxs
        AroSZ7fngMRFBFoZJa6v7GQCcZgF1rNIHNmwBKxbWMBdYt2Z20wgNouAqsSam//BmnkFbCXu
        TbGEWCAvsXrDAWYQm1PATmLBtyawViGgkvv3fzBOYORbwMiwilEytaA4Nz032bDAMC+1XK84
        Mbe4NC9dLzk/dxMjOMa0NHYw3pv/T+8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqYepn1+S8pxr9dsl4her9q10trVQMn
        RoO/YjIXvy64+b9bkevMgSnN9TmdVy9fmT/VOfdRs4J16FWzvOBAd4vsHTuClVedVTAs46+Y
        kW1xXu696XTD4ye28rv8yd4ovkbvwkKZHrkte2rZJ2ivO9E4/eWF8h1sB7e/2//r0feUGc5X
        7ug9Xx/gxLKZqXSprssqlnjjgqBDDIvYZgQ5zm4/dJ2thLnj+aPp69rfWclcPv20+taDhIyP
        R5p7f7G63gm+F/+mde3r7s5473nahfo7thyR+fN8M18c8zyOinz7msuWUnnfd64tfutd7Pnw
        me+J2zzHjzHPPD5rz5VpuhHts6fcKf50rvp0hplVlM58fSWW4oxEQy3mouJEAD45mC8gAwAA
X-CMS-MailID: 20231025102250epcas5p375603c0f150fd508f0c0aa3ec6305517
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102250epcas5p375603c0f150fd508f0c0aa3ec6305517
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102250epcas5p375603c0f150fd508f0c0aa3ec6305517@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index 0eec04eb3ef3..0afa8426ca4e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1460,9 +1460,12 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 			mfc_err("Unsupported format by this MFC version.\n");
 			return -EINVAL;
 		}
-
-		v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
-			&pix_fmt_mp->height, 4, 1080, 1, 0);
+		if (IS_MFCV12(dev))
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 3840, 1,
+					&pix_fmt_mp->height, 4, 2160, 1, 0);
+		else
+			v4l_bound_align_image(&pix_fmt_mp->width, 8, 1920, 1,
+					&pix_fmt_mp->height, 4, 1080, 1, 0);
 	} else {
 		mfc_err("invalid buf type\n");
 		return -EINVAL;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index bed45857bd6c..290d82e99940 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1104,6 +1104,18 @@ static int s5p_mfc_set_enc_params_h264(struct s5p_mfc_ctx *ctx)
 	reg |= ((p->num_b_frame & 0x3) << 16);
 	writel(reg, mfc_regs->e_gop_config);
 
+	/* UHD encoding case */
+	if ((ctx->img_width == 3840) && ctx->img_height == 2160) {
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

