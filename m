Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD77CF73D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjJSLnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjJSLnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:43:43 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE412F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:43:40 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019114338epoutp011faf8e201c5f697019a13a4ebda0da42~Pf4q_hy7F0692206922epoutp016
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:43:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019114338epoutp011faf8e201c5f697019a13a4ebda0da42~Pf4q_hy7F0692206922epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697715818;
        bh=K1ITzz+sTFe6DaFJgr1p3d9Rn4oprGlq4PJl8l40mZQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=auFC0JBM9Zm/6kBYhdRRp2ocsK6OeCfkqUdsWkYaTrGk0VZ1W/QYvbBgDsDjKu7zQ
         ZjKpK/CWHIHpjkheZQkbTwKYPgoMcy3u3A114yfl9lVtXz0NIPnXCCXcMKZqxY+q6P
         BRUi5s9tdBV3s51BPdUnE6km5OfwVsUZxkpFphq0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231019114337epcas1p49dcfa98fbe54331e5ca2ffc9f652b543~Pf4qWSjxt1956119561epcas1p4S;
        Thu, 19 Oct 2023 11:43:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.235]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SB5T45k8sz4x9Px; Thu, 19 Oct
        2023 11:43:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.AC.10211.86611356; Thu, 19 Oct 2023 20:43:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231019114336epcas1p3f095e27fc7963b81600827776bcd46da~Pf4o2eh-p0809508095epcas1p3-;
        Thu, 19 Oct 2023 11:43:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019114336epsmtrp167c58f9a220bb591f15e5399838662ad~Pf4o1d5Eq1431314313epsmtrp1j;
        Thu, 19 Oct 2023 11:43:36 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-85-65311668a211
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.78.07368.76611356; Thu, 19 Oct 2023 20:43:36 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019114335epsmtip21801ba4e2c8672366111816f39abca46~Pf4oiWFYt2627126271epsmtip2H;
        Thu, 19 Oct 2023 11:43:35 +0000 (GMT)
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
In-Reply-To: <20231018061714.3553817-9-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 08/26] PM / devfreq: rk3399_dmc,dfi: generalize
 DDRTYPE defines
Date:   Thu, 19 Oct 2023 20:43:35 +0900
Message-ID: <000f01da0281$7ea9b9a0$7bfd2ce0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwFnqumWAgXv2VuxOTGwQA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxze6W1vC4ztWl4HsrBylUQZjxZadljALKLuOmUSCZkzS1hHrxSB
        tmuLzz0AeQhTHmFkWuQhgo6GDawohYgM6EDYMBpeRmkG8hilsjCIAkPGWi5u/Pf9vt/5zvf7
        zoOH8edxL16iQkurFdJkEndk3+7cERggdxfRwrTOd1DRowE2qmu9z0IVpvsctPbUykH6kmY2
        yp8ew1BfxjMuMowPcVB/y2UcLVwwATQ/uoahmuGHLNR+ZRt6kv4DjrJaTVzUPjfBQatNBjYy
        Wz9C3T9O4ShzRPK+K1VXXgcoo7kaUM06M5cy6HNxamToDk7drP6GKlgVUvmNekA1DZVj1ILB
        m6pYGQfRTkeSwuW0VEarBbQiXilLVCREkPtj4iLjJKFCUYAoDL1LChTSFDqC3H0gOmBvYrIt
        ICk4Lk1OtVHRUo2GDNoZrlamammBXKnRRpC0SpaskqgCNdIUTaoiIVBBa98TCYXBEtvCz5Lk
        BbX/sFU9QSdXjWWcNFCyPQ848CAhhgO1Rk4ecOTxCSOAtyw3WUwxD6Dh2xwuU7wAsL2oCH8l
        GRus2Wi0Avi9+SnH3uATFgCH7x7PAzweTvjDyqVYO+1KxMKCe0aWHWPECw6cW9tnxw7ETmio
        Gl2XuhCHYf6jv4Adswlf2DxZvO7lTIRBXZ9lA2+BPZcm2Mw+b8Om2csYM48ALk9e4zC8KyzN
        zcYY313wZ3Mh2z4nJEodYN+dTg4j2A1Nc+c3sAuc6W7kMtgLWgqyuYygGMCHVivGFPUA3qjN
        3LALgW01xSx7SozYAetbghjaBzavlAFmijfgn8/tBjwb7wzPZfOZJVth/6iZxWBPeDUnFy8E
        pG5TNt2mbLpNeXT/m1UCth640ypNSgKtEanE/912vDLFANYfvx8ygrLZucAOwOKBDgB5GOnq
        7EsJab6zTHrqNK1WxqlTk2lNB5DYTrsI83KLV9p+j0IbJxKHCcWhwSFiJAoVkR7OXTMXZHwi
        Qaqlk2haRatf6Vg8B680FqlaESxhavEfJb95x3R0NUWcOLR2tzFm+dzCkVJFuF/e0kHZ8Lz/
        57q38C9ZZdqMsfrCzIb6wWNRlV8v6Y9mBhUPf3dtyupR+tqpk/KK8vTcL0Ials8MrJw++nJx
        b8Zjr98jfXqjXZ49Ca4cyj7RO2lwW1ZlV4kO74v0bsl5s+LK9oVAz4Pjh0YMU78uso/5W7+q
        HmzonTmzGO+wyykq82W6hTWe+NPfe9p8bo1azvpNP451m+bfiLpXdRsFq8L8Z7Y9aPE3mWaW
        B6IbPHw/1F/smtVuvdRdo3/+QNcT3l/ndj5rbouw+uwHTvsPXOdTw/X4L59+0vax+8U9aUOe
        jlkdEZLXJ+pItkYuFflhao30XxC4HKKFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSvG6GmGGqwfpFjBYTb1xhsViz9xyT
        xfwj51gt/j96zWqxaupOFou+Fw+ZLc42vWG32PT4GqvF5V1z2Cw+9x5htPj04D+zxdLrF5ks
        Di5UsbjduILNonXvEXaLgx+esFr83b6JxeLuaz+L42ufsVm03DF1EPFYM28No8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n36P9r4NG3ZRWjx/Zr85g9Pm+S85j/+zFjAHcUl01Kak5mWWqR
        vl0CV0b/yn8sBSf1K/7umMvawDhVo4uRk0NCwETi4dWl7F2MXBxCArsZJTpuLmaGSEhKTLt4
        FMjmALKFJQ4fLoaoec4ocfr9OrA4m4COxIIfoSDlIgKhEv0ndjCB1DALtLBJ7Fr2mQ2i4SCj
        xNr9n1hAqjgF7CQ2LXrACmILC4RJ7Py0EsxmEVCV2Pl0MhuIzStgKTHr7EsoW1Di5MwnLCDL
        mAX0JNo2MoKEmQXkJba/nQN1p4LEz6fLWCHiIhKzO9uYIQ5ykjhwdwLLBEbhWUgmzUKYNAvJ
        pFlIuhcwsqxilEwtKM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAiOfy2NHYz35v/TO8TIxMF4
        iFGCg1lJhFfVwyBViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkm
        Dk6pBqbG2oT2XQqeLHWH5s+aef7ToWmXJb36/Ga/XVA02VpJOisoVUIgMlQspZW95OfO7zMf
        bUjgPrXpq9tczqvvNu5n5PprG6fh9/Gz2GKV7UemlmrnloR8WZ6bPzU/2fIli9UHlnr2HkNh
        ZdVSx+2yW40KOrmrY0XEzNdwxR1Mf5o1+eptxxmvJKvnHTrHGWT+5ldog32VkJGpVfn8DxGn
        30/LPZCb8mF/GufXpsd2Qgpb4uVl1R6XnfNUen6g3WGd89YtaZcWNRawncn+fsBxc3jblZdm
        vx5viFqnGNNz3j3Wj1/n5d0wxTcGNoFBcw6GBCav7dmZWHqPSzndcu6a/R8up/86duHem4js
        NVx/0pRYijMSDbWYi4oTAS5nc6xuAwAA
X-CMS-MailID: 20231019114336epcas1p3f095e27fc7963b81600827776bcd46da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063650epcas1p1e1d5a928d4dd4b205cc9e2b71b35e23a
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063650epcas1p1e1d5a928d4dd4b205cc9e2b71b35e23a@epcas1p1.samsung.com>
        <20231018061714.3553817-9-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> Subject: [PATCH v8 08/26] PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE
> defines
> 
> The DDRTYPE defines are named to be RK3399 specific, but they can be used
> for other Rockchip SoCs as well, so replace the RK3399_PMUGRF_ prefix with
> ROCKCHIP_. They are defined in a SoC specific header file, so when
> generalizing the prefix also move the new defines to a SoC agnostic header
> file. While at it use GENMASK to define the DDRTYPE bitfield and give it a
> name including the full register name.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c |  9 +++++----
>  drivers/devfreq/rk3399_dmc.c         | 10 +++++-----
>  include/soc/rockchip/rk3399_grf.h    |  7 +------
>  include/soc/rockchip/rockchip_grf.h  | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+), 15 deletions(-)  create mode 100644
> include/soc/rockchip/rockchip_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c
> b/drivers/devfreq/event/rockchip-dfi.c
> index 28c18bbf6baa5..82d18c60538a5 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -18,8 +18,10 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
> 
> +#include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
> 
>  #define DMC_MAX_CHANNELS	2
> @@ -75,9 +77,9 @@ static void rockchip_dfi_start_hardware_counter(struct
> devfreq_event_dev *edev)
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
> 
>  	/* set ddr type to dfi */
> -	if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
> +	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
> +	else if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
> 
>  	/* enable count, use software mode */
> @@ -192,8 +194,7 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
> 
>  	/* get ddr type */
>  	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> -	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> -			RK3399_PMUGRF_DDRTYPE_MASK;
> +	dfi->ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
> 
>  	dfi->channel_mask = GENMASK(1, 0);
>  	dfi->max_channels = 2;
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index daff407026157..fd2c5ffedf41e 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -22,6 +22,7 @@
>  #include <linux/suspend.h>
> 
>  #include <soc/rockchip/pm_domains.h>
> +#include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rockchip_sip.h>
> 
> @@ -381,17 +382,16 @@ static int rk3399_dmcfreq_probe(struct
> platform_device *pdev)
>  	}
> 
>  	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> -		    RK3399_PMUGRF_DDRTYPE_MASK;
> +	ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
> 
>  	switch (ddr_type) {
> -	case RK3399_PMUGRF_DDRTYPE_DDR3:
> +	case ROCKCHIP_DDRTYPE_DDR3:
>  		data->odt_dis_freq = data->ddr3_odt_dis_freq;
>  		break;
> -	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
> +	case ROCKCHIP_DDRTYPE_LPDDR3:
>  		data->odt_dis_freq = data->lpddr3_odt_dis_freq;
>  		break;
> -	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
> +	case ROCKCHIP_DDRTYPE_LPDDR4:
>  		data->odt_dis_freq = data->lpddr4_odt_dis_freq;
>  		break;
>  	default:
> diff --git a/include/soc/rockchip/rk3399_grf.h
> b/include/soc/rockchip/rk3399_grf.h
> index 3eebabcb28123..775f8444bea8d 100644
> --- a/include/soc/rockchip/rk3399_grf.h
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -11,11 +11,6 @@
> 
>  /* PMU GRF Registers */
>  #define RK3399_PMUGRF_OS_REG2		0x308
> -#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> -#define RK3399_PMUGRF_DDRTYPE_MASK	7
> -#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> -#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> -#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> -#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +#define RK3399_PMUGRF_OS_REG2_DDRTYPE		GENMASK(15, 13)
> 
>  #endif
> diff --git a/include/soc/rockchip/rockchip_grf.h
> b/include/soc/rockchip/rockchip_grf.h
> new file mode 100644
> index 0000000000000..dde1a9796ccb5
> --- /dev/null
> +++ b/include/soc/rockchip/rockchip_grf.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip General Register Files definitions  */
> +
> +#ifndef __SOC_ROCKCHIP_GRF_H
> +#define __SOC_ROCKCHIP_GRF_H
> +
> +/* Rockchip DDRTYPE defines */
> +enum {
> +	ROCKCHIP_DDRTYPE_DDR3	= 3,
> +	ROCKCHIP_DDRTYPE_LPDDR2	= 5,
> +	ROCKCHIP_DDRTYPE_LPDDR3	= 6,
> +	ROCKCHIP_DDRTYPE_LPDDR4	= 7,
> +};
> +
> +#endif /* __SOC_ROCKCHIP_GRF_H */
> --
> 2.39.2


Applied it. Thanks

Best Regards,
Chanwoo Choi


