Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D397CF745
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345399AbjJSLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjJSLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:44:54 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4913A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:44:50 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019114449epoutp010f80a28e251036f1547c1719ee4f4eb8~Pf5s61ZgT0905009050epoutp01T
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:44:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019114449epoutp010f80a28e251036f1547c1719ee4f4eb8~Pf5s61ZgT0905009050epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697715889;
        bh=63ihKBSu3G/vqK4eE3j6mAFoN2L9Sl4C+4eOviUKPPo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cA28BYfCVhmM7bxmD5xPsQ/sVf1k1aOSlqnjQGqDCXLAYvTrQPd5Go+2ZlW0KxI7W
         +P+OVdO1TNWfkZPFYZed4ldbJ+VM8QxuFxpqcSf3NgqX2CmOT3fk9S/uyRGh38wp7b
         AsAew7PEEZOTP9DRStJ643uql3gv5TOECMsWzvGA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20231019114448epcas1p366f78a1bb07e8c4cf92ce22c3a311a1b~Pf5sL97dt3194231942epcas1p3A;
        Thu, 19 Oct 2023 11:44:48 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.236]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SB5VR0rPkz4x9Pt; Thu, 19 Oct
        2023 11:44:47 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.6D.08572.EA611356; Thu, 19 Oct 2023 20:44:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231019114446epcas1p1d101a7ff9d9f5f3997e5fab119e4003e~Pf5qU98Ha3129131291epcas1p1X;
        Thu, 19 Oct 2023 11:44:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019114446epsmtrp2c2eb1e568beeef2038b9041c18e796c7~Pf5qT-Brc0385703857epsmtrp2L;
        Thu, 19 Oct 2023 11:44:46 +0000 (GMT)
X-AuditID: b6c32a33-cefff7000000217c-70-653116ae95f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.88.07368.EA611356; Thu, 19 Oct 2023 20:44:46 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019114446epsmtip197211385f5e777c8100f3e6579ddd765~Pf5p-tXKT1545115451epsmtip1H;
        Thu, 19 Oct 2023 11:44:46 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Heiko Stuebner'" <heiko@sntech.de>,
        "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Will Deacon'" <will@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>, <kernel@pengutronix.de>,
        "'Michael Riesch'" <michael.riesch@wolfvision.net>,
        "'Robin Murphy'" <robin.murphy@arm.com>,
        "'Vincent Legoll'" <vincent.legoll@gmail.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        "'Sebastian Reichel'" <sebastian.reichel@collabora.com>
In-Reply-To: <20231018061714.3553817-10-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 09/26] PM / devfreq: rockchip-dfi: Clean up DDR type
 register defines
Date:   Thu, 19 Oct 2023 20:44:45 +0900
Message-ID: <001001da0281$a88dc130$f9a94390$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwGXi04MAravXYaxMi0lUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+7tvbSwkksBd+icYjf+kADeAsWDwtRJ5MKcI5liIotwpXeA
        QNu0ZWPoMlBwg/AUcVBQcDzcGFpgjTyUOToy2BJxiEHHw4GoEToNghAIr7Ve3Pjv8/ud3/f8
        ft/zEOKSGVIqTFDpOa2KTZKR9oJrv2719jZukHN0RQGGiu7fFaCGjl4MVXb1Emj1oYVA9SVt
        ApT/dAxHt079Y4eaxwcI1N9eQaKZvC6ApkdXcVR7rw9DnZfeRUMZ35Moq6PLDnVOPSLQckuz
        AI1YDqDuK09IlDms2O3CNFxsAEzrSA1g2gwjdkxzfTbJDA/cIJmfar5iCpZpJt9UD5iWgYs4
        M9O8ialcHAcRDkcSg+I5Vslp3TlVrFqZoIoLln3wcfTeaEUALfeWB6LtMncVm8wFy0L2R3jv
        S0iyGpS5f8YmpVhTEaxOJ9v2XpBWnaLn3OPVOn2wjNMokzQKjY+OTdalqOJ8VJx+h5ymfRXW
        wpjE+L96ikjNhEdqruUOkQ7+3pwDREJI+cPiGRORA+yFEqoVwKlv60g+mAbwjrEJ44M5AGsW
        ssBryXBGJs4vdAB4/2z+mn4CwO4Vg1UvFJKUF6yaP2QTuFCHYEFPK2ZjnJoj4NRqmI1F1C7Y
        U1VN2tiZOgp/KZvFbSygPGDheKnAxmIqEP44fpng2Qn+XvZIwO+zGbY8q8D5gdzhwuM6gs+7
        wPLsMzjf9314/er8q0EhVS2Ci0t31xyEwMaaW2vsDCe7TXY8S+HM8w6SFxQD2GexrKmNADb9
        kLnWzg/erC3GbC5xais0tm/j01tg2+IFwE/hCJ/P5hK2EkiJ4TdnJHzJO7B/dATj2Q1Wf51N
        FgKZYZ03wzpvhnV+DP83qwKCerCB0+iS47hYuUb+33XHqpObwavX7+nXCvorV3zMABMCM4BC
        XOYi9mBoTiJWsl+kcVp1tDYlidOZgcJ62kW41DVWbf0+Kn203D+Q9g/w9fNH8gC57E3xlsJy
        pYSKY/VcIsdpOO1rHSYUSdOxo/azuTGOk2ElpeHarPKNG19cvaE7OBSidXRqvODwiSjn9nG3
        Ez/XdZweTXe1k4buijoeM/ClR1+QWb1D9OLa2MtjB/Y+CD0YUzM96HqbPjn98J7waWQpdbip
        KzjsJRNZG1D0JPVSk+V8Zvhg5OLNk6Y+L6/kvgXLn2+kd72VsVI+Ydm5J5T+MG23p9nf6Jh9
        YhK1EytRIec6z9o3Ls3jvznNfp56GTcv5V2JIKKlp5e3Hx4cbYsMKpvNM3639Gzf/vA/Is/f
        6d2zHJpV0bPwwNnNYQ7D3jb5iZVpmC9tqhprZD5lQoajpj66fkqyaafGiD3OOuJzjJ0uGRJ0
        01JFcJx9tkygi2flnrhWx/4L/6xgzYYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCSnO46McNUg5NLhSwm3rjCYrFm7zkm
        i/lHzrFa/H/0mtVi1dSdLBZ9Lx4yW5xtesNusenxNVaLy7vmsFl87j3CaPHpwX9mi6XXLzJZ
        HFyoYnG7cQWbReveI+wWBz88YbX4u30Ti8Xd134Wx9c+Y7NouWPqIOKxZt4aRo8dd5cweuyc
        dZfdY9OqTjaPO9f2sHlsXlLv0f/XwKNvyypGj+3X5jF7fN4k5zH/92PGAO4oLpuU1JzMstQi
        fbsEroybJyayFbxUreh5fYm1gfG+fBcjJ4eEgInEncYW5i5GLg4hgd2MEg9P/GCESEhKTLt4
        FCjBAWQLSxw+XAxR85xRYtPU7YwgcTYBHYkFP0JBykUEQiX6T+xgAqlhFmhhk9i17DMbRMMh
        RolXV56xg1RxCthLnFiwmA2kWVggRuLaeg2QMIuAqsSExzNYQGxeAUuJ1Y+Xs0LYghInZz5h
        ASlnFtCTaNsIdhqzgLzE9rdzmCHOVJD4+XQZK0RcRGJ2ZxszxD1OErvX/WCewCg8C8mkWQiT
        ZiGZNAtJ9wJGllWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMHRr6Wxg/He/H96hxiZ
        OBiBPuRgVhLhVfUwSBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFM
        lomDU6qBSd35+sXVup5yT8P2umheXmzY6OBy/095V8Y3/6MWJ/fZKc+7K2N3Z+MFH/0s6TWt
        +fEZB2UEOXZqbJSa+ERrl82Wd1YdiiGr/j0VZk81XjonuOvxfaOlbuUTC7dzn5o+Kz+6cMm9
        xY9+uOwIqtWTnW8b/TDsprbvkY+/tesnNS4SsQn79Mr6TfKfRXP7rpyfwn7llSH/YpdH/ifL
        tplMuZ3+Lc7s2ze1xIy1J1gfrt21+b3zXIHspz1S904uDok4/fiatZP3nzWrn3NO/FBbU6rH
        NSfhpeetugk9egcKvJ8unfNPbV9dXJ3aNJW/fybXr2e5+yXyId8X3YDgdnYDn0Pbl4UqGut6
        pJv1/3xYrqjEUpyRaKjFXFScCABq2KtMbQMAAA==
X-CMS-MailID: 20231019114446epcas1p1d101a7ff9d9f5f3997e5fab119e4003e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063811epcas1p218e4ddfbd99e2135ddb77facd9197207
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063811epcas1p218e4ddfbd99e2135ddb77facd9197207@epcas1p2.samsung.com>
        <20231018061714.3553817-10-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Wednesday, October 18, 2023 3:17 PM
> To: linux-rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org; Heiko Stuebner <heiko@sntech.de>; Chanwoo Choi
> <chanwoo@kernel.org>; Kyungmin Park <kyungmin.park@samsung.com>; MyungJoo
> Ham <myungjoo.ham@samsung.com>; Will Deacon <will@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; kernel@pengutronix.de; Michael Riesch
> <michael.riesch@wolfvision.net>; Robin Murphy <robin.murphy@arm.com>;
> Vincent Legoll <vincent.legoll@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> devicetree@vger.kernel.org; Sebastian Reichel
> <sebastian.reichel@collabora.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Chanwoo Choi <cw00.choi@samsung.com>
> Subject: [PATCH v8 09/26] PM / devfreq: rockchip-dfi: Clean up DDR type
> register defines
> 
> Use the HIWORD_UPDATE() define known from other rockchip drivers to make
> the defines look less odd to the readers who've seen other rockchip
> drivers.
> 
> The HIWORD registers have their functional bits in the lower 16 bits
> whereas the upper 16 bits contain a mask. Only the functional bits that
> have the corresponding mask bit set are modified during a write. Although
> the register writes look different, the end result should be the same, at
> least there's no functional change intended with this patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 33 ++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c
> b/drivers/devfreq/event/rockchip-dfi.c
> index 82d18c60538a5..12f9096879235 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,15 +26,19 @@
> 
>  #define DMC_MAX_CHANNELS	2
> 
> +#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
> +
>  /* DDRMON_CTRL */
>  #define DDRMON_CTRL	0x04
> -#define CLR_DDRMON_CTRL	(0x1f0000 << 0)
> -#define LPDDR4_EN	(0x10001 << 4)
> -#define HARDWARE_EN	(0x10001 << 3)
> -#define LPDDR3_EN	(0x10001 << 2)
> -#define SOFTWARE_EN	(0x10001 << 1)
> -#define SOFTWARE_DIS	(0x10000 << 1)
> -#define TIME_CNT_EN	(0x10001 << 0)
> +#define DDRMON_CTRL_DDR4		BIT(5)
> +#define DDRMON_CTRL_LPDDR4		BIT(4)
> +#define DDRMON_CTRL_HARDWARE_EN		BIT(3)
> +#define DDRMON_CTRL_LPDDR23		BIT(2)
> +#define DDRMON_CTRL_SOFTWARE_EN		BIT(1)
> +#define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
> +#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_DDR4 | \
> +					 DDRMON_CTRL_LPDDR4 | \
> +					 DDRMON_CTRL_LPDDR23)
> 
>  #define DDRMON_CH0_COUNT_NUM		0x28
>  #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
> @@ -74,16 +78,20 @@ static void rockchip_dfi_start_hardware_counter(struct
> devfreq_event_dev *edev)
>  	void __iomem *dfi_regs = dfi->regs;
> 
>  	/* clear DDRMON_CTRL setting */
> -	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
> +	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
> DDRMON_CTRL_SOFTWARE_EN |
> +		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
> 
>  	/* set ddr type to dfi */
>  	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
> -		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> +		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23,
> DDRMON_CTRL_DDR_TYPE_MASK),
> +			       dfi_regs + DDRMON_CTRL);
>  	else if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR4)
> -		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
> +		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4,
> DDRMON_CTRL_DDR_TYPE_MASK),
> +			       dfi_regs + DDRMON_CTRL);
> 
>  	/* enable count, use software mode */
> -	writel_relaxed(SOFTWARE_EN, dfi_regs + DDRMON_CTRL);
> +	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN,
> DDRMON_CTRL_SOFTWARE_EN),
> +		       dfi_regs + DDRMON_CTRL);
>  }
> 
>  static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev
> *edev) @@ -91,7 +99,8 @@ static void
> rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev *edev)
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
>  	void __iomem *dfi_regs = dfi->regs;
> 
> -	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);
> +	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
> +		       dfi_regs + DDRMON_CTRL);
>  }
> 
>  static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev,
> struct dmc_count *count)
> --
> 2.39.2


Applied it. Thanks

Best Regards,
Chanwoo Choi


