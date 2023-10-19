Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5567CF6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345357AbjJSLeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjJSLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:34:07 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E829F115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:34:04 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231019113403epoutp04dcd54be426496c973f71b6606f22eb99~PfwTban3u2080620806epoutp04d
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:34:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231019113403epoutp04dcd54be426496c973f71b6606f22eb99~PfwTban3u2080620806epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697715243;
        bh=GO7U/Y3gJ2W4NmmzLGqtUQGK4N0wvIPDqGmyBGqW7d0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CQslOgaFNtl7KbZw7g5yhiyk7GaDpDKf/zUWtoCjuvX7sGaHgnVUmn37ST27mo2GH
         RbmEszvUQuj1uATSoyWkhvsaJUrJtOgsCh/S0n/R2bgKm1vX3VkjYrqG4wXc9JezYS
         ff/n/nGBqhORFS0BsGTInGmDVKxWSZ2QqxVSk79c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20231019113402epcas1p300516b190a7722f6b1cb755dca9664a1~PfwSU1eCl2725027250epcas1p3F;
        Thu, 19 Oct 2023 11:34:02 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.144]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SB5G12004z4x9Q1; Thu, 19 Oct
        2023 11:34:01 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.AC.09739.92411356; Thu, 19 Oct 2023 20:34:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231019113400epcas1p2456ee4741edeab34bcb66f810bc05df4~PfwQ5zkOD1223512235epcas1p2S;
        Thu, 19 Oct 2023 11:34:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019113400epsmtrp23cc208bc6d9fccaabb993a83ab2bded9~PfwQ36vpm3052330523epsmtrp2J;
        Thu, 19 Oct 2023 11:34:00 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-4f-6531142998d2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.59.08817.82411356; Thu, 19 Oct 2023 20:34:00 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019113400epsmtip1c95d8d40bd97ae902ececc6ebbadae12~PfwQhMBCi1544415444epsmtip10;
        Thu, 19 Oct 2023 11:34:00 +0000 (GMT)
From:   =?ks_c_5601-1987?B?w9bC+b/sL1RpemVuIFBsYXRmb3JtIExhYihTUikvu++8usD8wNo=?= 
        <cw00.choi@samsung.com>
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
In-Reply-To: <20231018061714.3553817-7-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 06/26] PM / devfreq: rockchip-dfi: Use free running
 counter
Date:   Thu, 19 Oct 2023 20:34:00 +0900
Message-ID: <000801da0280$279d4a60$76d7df20$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwFQnOhhAVY8IF6xP2UUwA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH+e559rDhTR/GyC9w5VxyhQFu/PwCImSYTyfhSsgr7HDBcwwZ
        29pGSVcBgQw4ET1+iJP4DcGiqwbywyBigkB3UYQRJpTGjxNJHJB2HYe08cyO/16fz/fz/n4+
        7+8PDsZfJdw5KUodrVHKFCLCCe+45rXPx0sgocU5D53QhckbOGrtHWWh6oFRNtr4c5GNjGXd
        ODp39w6GfvjkL0dkmplgo/GrlQRaLRoAaOX2BoYafx1jof7aPehWdjOBzvQOOKJ+yywbrXea
        cDS9GIOGvpgnUO5UYKSAaq1qBVTXdAOgug3TjpTJWEBQUxM9BNXWkEkVr4upc+1GQHVOVGHU
        qukZqnptBki3vZW6X07LkmiNkFYmqpJSlMnhoiPHEl5KCAwSS3wkIShYJFTK0uhwUVS01Ofl
        FIXVoEj4nkyRbk1JZVqtaN+B/RpVuo4WylVaXbiIVicp1IFqX60sTZuuTPZV0rpQiVjsF2gt
        PJkq199pItSD3qen8oawLFCzpxBwOZAMgKP148DGfLILwLmxEwyvAHjzl4hC4GTlRwBm/2Qh
        nghy1gcwZqEXwNr6acAECwBWZhswWxVBpsBmfeEmC8g4WDzcxbIxRj5iQ8vGKzbmkgdgW91Z
        vBBwOC5kLLx4PcaWxklP+F3VxGYzHhkCf1814gw7w5FLszizjR9s+LzavuUu2Hm/EmOGE8J/
        55rYTF4ALxfk2Uc4CHN+XCNsc0LyMhd+M9+OM4IoeGkmn8WwC7w31O7IsDtcXeq1C0oAHFtc
        xJjgSwC/bsm1t/OHfY0ldvVu2L32KWBab4dLD8+ybc4gyYP5eXym5Fk4fnvaXu4G6/UFxHkg
        MmwxZ9hizrDFnGGLoRqAG8FTtFqblkxrJWr//687UZVmApuvf29wFyi/b/E1AxYHmAHkYCIB
        z5MS03xekizjA1qjStCkK2itGQRaz/sC5u6aqLJ+H6UuQRIQIg4I8vMPQJIgiWgn77f5oiQ+
        mSzT0ak0raY1T3QsDtc9izUckV/+1VCmoG8EjEXoxa+6eD/9UU/j85xQbl0VcTQmPJ4rjxrJ
        8L4Za/g7uunxROn2bc75VLHi9XePm4NRLX46S8r6p3x56ehCghmYK5ZhWuiDtv7ijV2o/GBU
        nce4rmy4vazb4uEZfebQYMUhh8GS3X+UHtuRx2maPF8o9Klx23kidCTKtaPG+bjbx1e8Wktv
        hJUYIu9V8C6+9mHYlVtv5n7fYnzh1Ny3n4HoWn3z24K7akvZHGp68KJH5kml3mCqeYf/fszh
        MMXy4581ousZJuHhssirDu1xrqeEC0fye97wnYyf5a/pVjgrHZGxDvHxnB1x10al9S1988/J
        FzAvaZEI18plkr2YRiv7D6KXnUqGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSnK6GiGGqwaR7shYTb1xhsViz9xyT
        xfwj51gt/j96zWqxaupOFou+Fw+ZLc42vWG32PT4GqvF5V1z2Cw+9x5htPj04D+zxdLrF5ks
        Di5UsbjduILNonXvEXaLgx+esFr83b6JxeLuaz+L42ufsVm03DF1EPFYM28No8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n36P9r4NG3ZRWjx/Zr85g9Pm+S85j/+zFjAHcUl01Kak5mWWqR
        vl0CV0b7w2VsBUd1Ku60HWduYFyg0sXIySEhYCLR/PcIcxcjF4eQwG5GiU3/VzFDJCQlpl08
        CmRzANnCEocPF0PUPGeU+LdmEVgNm0C6xPTd85lAbBGBUIn+EzuYQIqYBVrYJHYt+8wG0XGQ
        UWLCo0usIFWcAnYSmxf1sIDYwgJBEieufgGLswioShyYd40NxOYVsJS493kVC4QtKHFy5hMw
        mxno1MbD3VC2vMT2t3OgLlWQ+Pl0GStEXERidmcbM8RFThLN53+zTWAUnoVk1Cwko2YhGTUL
        SfsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBSUBLawfjnlUf9A4xMnEwHmKU
        4GBWEuFV9TBIFeJNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNT
        qoHJ14KxR2PZ94K5Zk/8Gzaa+UZqzr6xLn72592nd6zMMboxT1SxqvUfT8NsP3Yf5x0y95+L
        cguls7FlCV1y0bz/+vkT//+Zqj/UTE/qPLlwwEP85K538swfWXryRVqXXfrhzWhU8fDSc0Xb
        BR0LI1YEzdw78bBuyaG7RtlNRbHaJyccmuEWvmfdcuVz0untO3coBbH6vkmoX6sqUXssxb+q
        QVnhG8ezK32bShuyPfeKaT19dIxD5ETV3tuLzyaeu64sf6bcz7q7bLPysnt7nZ+nbvqW8MDy
        hI6j+YQXW9laZZ55TJ23eX3GvCerSw9eF3ASMspNFItddepPVxz/hlgp0wvlHt4xHIHNpqbV
        M34osRRnJBpqMRcVJwIAMarVcnEDAAA=
X-CMS-MailID: 20231019113400epcas1p2456ee4741edeab34bcb66f810bc05df4
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018063801epcas1p28653f8f54cf8d722eaba951eaf4de850
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018063801epcas1p28653f8f54cf8d722eaba951eaf4de850@epcas1p2.samsung.com>
        <20231018061714.3553817-7-s.hauer@pengutronix.de>
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
> Subject: [PATCH v8 06/26] PM / devfreq: rockchip-dfi: Use free running
> counter
> 
> The DDR_MON counters are free running counters. These are resetted to 0
> when starting them over like currently done when reading the current
> counter values.
> 
> Resetting the counters becomes a problem with perf support we want to add
> later, because perf needs counters that are not modified elsewhere.
> 
> This patch removes resetting the counters and keeps them running instead.
> That means we no longer use the absolute counter values but instead
> compare them with the counter values we read last time. Not stopping the
> counters also has the impact that they are running while we are reading
> them. We cannot read multiple timers atomically, so the values do not
> exactly fit together. The effect should be negligible though as the time
> between two measurements is some orders of magnitude bigger than the time
> we need to read multiple registers.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v4:
>      - rephrase commit message
>      - Drop unused variable
> 
>  drivers/devfreq/event/rockchip-dfi.c | 52 ++++++++++++++++------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c
> b/drivers/devfreq/event/rockchip-dfi.c
> index 680f629da64fc..126bb744645b6 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -38,11 +38,15 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
> 
> -struct dmc_usage {
> +struct dmc_count_channel {
>  	u32 access;
>  	u32 total;
>  };
> 
> +struct dmc_count {
> +	struct dmc_count_channel c[RK3399_DMC_NUM_CH]; };
> +
>  /*
>   * The dfi controller can monitor DDR load. It has an upper and lower
> threshold
>   * for the operating points. Whenever the usage leaves these bounds an
> event is @@ -51,7 +55,7 @@ struct dmc_usage {  struct rockchip_dfi {
>  	struct devfreq_event_dev *edev;
>  	struct devfreq_event_desc desc;
> -	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
> +	struct dmc_count last_event_count;
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
> @@ -85,30 +89,18 @@ static void rockchip_dfi_stop_hardware_counter(struct
> devfreq_event_dev *edev)
>  	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);  }
> 
> -static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
> +static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev,
> +struct dmc_count *count)
>  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> -	u32 tmp, max = 0;
> -	u32 i, busier_ch = 0;
> +	u32 i;
>  	void __iomem *dfi_regs = dfi->regs;
> 
> -	rockchip_dfi_stop_hardware_counter(edev);
> -
> -	/* Find out which channel is busier */
>  	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> -		dfi->ch_usage[i].access = readl_relaxed(dfi_regs +
> +		count->c[i].access = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> -		dfi->ch_usage[i].total = readl_relaxed(dfi_regs +
> +		count->c[i].total = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
> -		tmp = dfi->ch_usage[i].access;
> -		if (tmp > max) {
> -			busier_ch = i;
> -			max = tmp;
> -		}
>  	}
> -	rockchip_dfi_start_hardware_counter(edev);
> -
> -	return busier_ch;
>  }
> 
>  static int rockchip_dfi_disable(struct devfreq_event_dev *edev) @@ -
> 145,12 +137,28 @@ static int rockchip_dfi_get_event(struct
> devfreq_event_dev *edev,
>  				  struct devfreq_event_data *edata)  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> -	int busier_ch;
> +	struct dmc_count count;
> +	struct dmc_count *last = &dfi->last_event_count;
> +	u32 access = 0, total = 0;
> +	int i;
> +
> +	rockchip_dfi_read_counters(edev, &count);
> +
> +	/* We can only report one channel, so find the busiest one */
> +	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> +		u32 a = count.c[i].access - last->c[i].access;
> +		u32 t = count.c[i].total - last->c[i].total;
> +
> +		if (a > access) {
> +			access = a;
> +			total = t;
> +		}
> +	}
> 
> -	busier_ch = rockchip_dfi_get_busier_ch(edev);
> +	edata->load_count = access * 4;
> +	edata->total_count = total;
> 
> -	edata->load_count = dfi->ch_usage[busier_ch].access * 4;
> -	edata->total_count = dfi->ch_usage[busier_ch].total;
> +	dfi->last_event_count = count;
> 
>  	return 0;
>  }
> --
> 2.39.2


Applied it. Thanks.

Best Regards,
Chanwoo Choi


