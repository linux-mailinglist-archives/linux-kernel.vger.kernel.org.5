Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DFA7CF753
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjJSLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbjJSLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:46:23 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E913D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:46:18 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231019114616epoutp02a37d9ba98a00a6025fc560601f455fdc~Pf6_jl8Kg0817808178epoutp02j
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:46:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231019114616epoutp02a37d9ba98a00a6025fc560601f455fdc~Pf6_jl8Kg0817808178epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697715976;
        bh=mSBfvOFoNFPkM09tCwPxZBHUPhJ7xD9mMbi8iLkam00=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=TnMPcaCC0QVsqLAt2dxeHKLkD3gaIj9myQXVMWysZmXNuIS2SX4wPOf8LQ2oeIBHu
         Q/6BbPVtiZKoREz/xAnGbVI96UZUpDoS+2tA9vvh2GfrLNwRHZfqWwns7ayjNtYYyj
         7mfX45XEBFc7iAkE2/FKUlgBlSNrUpkqBoq3PKOY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231019114616epcas1p1fa5aff3c1ce6986dea09eaa32f41ded2~Pf69zmdSd1293912939epcas1p1E;
        Thu, 19 Oct 2023 11:46:16 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SB5X71h5fz4x9Pr; Thu, 19 Oct
        2023 11:46:15 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.CD.09739.70711356; Thu, 19 Oct 2023 20:46:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231019114614epcas1p1693c864aa78ae3cce36346ebba2a44e4~Pf68Xd7Jo3242732427epcas1p1p;
        Thu, 19 Oct 2023 11:46:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019114614epsmtrp1c2ef939fbe63033b549351bec1cd256f~Pf68U9DNG1588115881epsmtrp1b;
        Thu, 19 Oct 2023 11:46:14 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-48-653117070a03
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.B9.08817.60711356; Thu, 19 Oct 2023 20:46:14 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019114614epsmtip1cc0e706eaf625030cc89da7398a01c8d~Pf68B5Esd2936029360epsmtip1G;
        Thu, 19 Oct 2023 11:46:14 +0000 (GMT)
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
In-Reply-To: <20231018061714.3553817-11-s.hauer@pengutronix.de>
Subject: RE: [PATCH v8 10/26] PM / devfreq: rockchip-dfi: Add RK3568 support
Date:   Thu, 19 Oct 2023 20:46:14 +0900
Message-ID: <001101da0281$dd10bf70$97323e50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwHOb9+0Asqp8o6xL9aZQA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjl9r2+FrHsrXTjQibCY8RgoLZC4WLEEUaWt8gIU8kS3QYNPCgD
        2trXmjmz6QiCdCIIY5GuAg5ZWFcgVMKv0RELGRIjkSFMJ0ydyMQOZLABjrGO53Mb/53v5Jzv
        fue794ox6WMiUJyrNTIGrTqfIjbhHf3h8kiRv5JR1FtF6OzNGziyO4cFqG5gWIg8P7uFyFbd
        jaMzD+9h6FrhryLkuD8uRKM9VgItlg0AtHDXg6HGH0YE6PKFl9Htj5sIdNI5IEKX56eEaK3T
        gaNJdwoabJ4mUNGEKkFG22vtgO6avAjobsukiHbYSgl6YryXoC9dPE6XrynoM+02QHeO12L0
        oiOIrlu9D1J9Dubt1jDqLMYQzGgzdVm52px4au/+9FfTVTEKZaQyDsVSwVp1ARNPJSWnRr6W
        m78ekAo+os43rVOpapalduzZbdCZjEywRsca4ylGn5WvV+nlrLqANWlz5FrGuEupUOxUrQsz
        8jS/OGYJfWPQ+5Njo4IToDPADLzFkIyGoy3fi8xgk1hKdgE4V1EG+GIBQHNhC8YXSwAueppw
        MxA/tTxoSeV5J4DDvX8BrpWUnAHw1mIEpyHICFi/ksbRMjINll/pEnAYI5eEcN7zOoe9yVdg
        xXwtzmE/MhlaOk4JOYyTYdBZfR1wbSRkHJwuSuZoCfk8HKqZwvk2W2HnrBXjAwTDJw++FPK8
        DH5eWoxxVhmZCAdHtnFTQrLOG65O3XqmT4Kda5eEPPaDjwbbRTwOhDPlxSLeUAXgiNuN8UUr
        gG1fFT1zR8G+xioBdwJGhsPWnh08HQK7V88DfghfOPfHaSG/Kgk8VSzlJaFw9O6kgMcBsKGk
        lKgAlGVDNMuGaJYNcSz/H1YPcBt4kdGzBTkMq9RH/XfVmboCB3j68rfHdoHPZuflLiAQAxeA
        YoySScJoBSOVZKmPfsAYdOkGUz7DuoBqfddnscAXMnXrX0drTFdGxymiY3ZGRSNljJLyl/w4
        XZYlJXPURiaPYfSM4V+fQOwdeEJQ0m/L23Kt470qn6D06u4jilav3Ju+XtbfCsvCJqZZuywJ
        3980tjk89OCyc2Zo21JUw5O39jn735xn8JRD2cf/1HxT39PnZ/Yx9cV9tHpnn+/JoXNDn5Z5
        2h2KlEeL1cyxtm83B3ndO22bIK4eHYqveDvWnLeQUt5c+d0NndPbdAB+LVi+2hJRdWCZCimp
        8W+rPJfw0/nffVbtodn1h1OsKz7qwBD/6k/SOnJuh2c8rHm3OcMFu4+F26v2XomM6viw3Nbu
        9ox90UzAw8LntrgGVIzGHH+oqFLee2HFamh45/rjmYDs/gjR0h5RsT2xyd3fmzA695Jfw661
        rS65YeXvxDtvUDirUSu3YwZW/Q9PVDauggQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTcRTH+e3e3d1NRlc386eF5aZoknOGj1/SG4xbSFhhlBW59KqRzrlZ
        mlGZWJQ1NcLKFWr5KMYKXOKmblmboT00xXxgSplPmoJlRBLLvI3I/w6f8zlfzuGQmMcg7kOe
        UGYzaqUiXUII8Ea7xDeE8Apj5LaHEN0YfI8jg7WLgyrburho8bODi/RlTTgqnh7FUGfBDA8Z
        x/q5qLf5HoHmtW0Affu0iKHagR4OenHfH324+IhAl6xtPPRibpyLnCYjjkYce1D740kCFQ5H
        bBPThgoDoM0jNYBu0o3waKP+KkEP91sI+mnNBbrEKaeLG/SANvVXYPS80Zeu/DUG4twSBJuS
        mfQTpxl16JZEQdqUcZZQ1frmjvT1cvKBybsIkCSkwuHEk7giICA9qBYAp7uHeUWAv8S94a2e
        l5jLEUG7XeNypgBceFDMYTlBrYdVP+NZXUzFw5IOM4d1MKqQgM1184RrwAbgzLd8jLX41FZY
        OleBs7WIioW6xitctsapAGgt6wZsqJDaCCcLY1kspNzhq/JxnMUYJYOX6wGLMWoNNM3ew1xr
        roULE3VcFxfDu1cv/11ZTO2A7T2BpUCkWxak+x+kWxakWzZcBXA98GZUmozUDE2YaoOSyZFp
        FBmaU8pUWVJmhhH8fX5wsBlY9HMyG+CQYOlAEpOIhQG0nPEQJivO5DHqzGPqU+mMxgZWkbjE
        S/jDoU32oFIV2cxJhlEx6n9dDsn3yedsTrn5Ru48WRieeMHN2PluMW/IVC4+kikd+D193pR0
        2rNuxV5nkWUd33xbK38SFCVyHhTzYqQRhxOCdubnur8ty7HxbZH6hneBx0uSoifdD7ZuaXB7
        Wf0x5/hzpApvWkPaqsccX4e6r2vxwJ+ExefQmY6koJSClY0Nq65hdktrU1juUYUZ1b/PMu+L
        z1Ebs/x2CSqlDsPchO9FJ7k1ylq5PTvBlt3X6ydt6aqVqQSRBkV5R6ksyl+r2jh44FzygZjv
        raLx3nAMq/eOafmy297v+fVZqFL5GqU08+L3LFp9okf9W+vOFwhh19nEsyFtfitnbwRMRDz2
        KlmddyduvwTXpCnCgjG1RvEHUF5fpWsDAAA=
X-CMS-MailID: 20231019114614epcas1p1693c864aa78ae3cce36346ebba2a44e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018061911epcas1p37a7bedf255e61c583dc933f8f0bc5f08
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <CGME20231018061911epcas1p37a7bedf255e61c583dc933f8f0bc5f08@epcas1p3.samsung.com>
        <20231018061714.3553817-11-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
> <sebastian.reichel@collabora.com>; Sascha Hauer <s.hauer@pengutronix.de>
> Subject: [PATCH v8 10/26] PM / devfreq: rockchip-dfi: Add RK3568 support
> 
> This adds RK3568 support to the DFI driver.  Only iniitialization differs
> from the currently supported RK3399.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v7:
>      - Add comment to explain << 3
> 
>  drivers/devfreq/event/rockchip-dfi.c | 27 +++++++++++++++++++++++++++
>  include/soc/rockchip/rk3568_grf.h    | 12 ++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/soc/rockchip/rk3568_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c
> b/drivers/devfreq/event/rockchip-dfi.c
> index 12f9096879235..571d72d1abd1c 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -23,6 +23,7 @@
> 
>  #include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
> +#include <soc/rockchip/rk3568_grf.h>
> 
>  #define DMC_MAX_CHANNELS	2
> 
> @@ -211,10 +212,36 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
>  	return 0;
>  };
> 
> +static int rk3568_dfi_init(struct rockchip_dfi *dfi) {
> +	struct regmap *regmap_pmu = dfi->regmap_pmu;
> +	u32 reg2, reg3;
> +
> +	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG2, &reg2);
> +	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG3, &reg3);
> +
> +	/* lower 3 bits of the DDR type */
> +	dfi->ddr_type = FIELD_GET(RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO,
> reg2);
> +
> +	/*
> +	 * For version three and higher the upper two bits of the DDR type
> are
> +	 * in RK3568_PMUGRF_OS_REG3
> +	 */
> +	if (FIELD_GET(RK3568_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
> +		dfi->ddr_type |=
> FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3,
> +reg3) << 3;
> +
> +	dfi->channel_mask = BIT(0);
> +	dfi->max_channels = 1;
> +
> +	return 0;
> +};
> +
>  static const struct of_device_id rockchip_dfi_id_match[] = {
>  	{ .compatible = "rockchip,rk3399-dfi", .data = rk3399_dfi_init },
> +	{ .compatible = "rockchip,rk3568-dfi", .data = rk3568_dfi_init },
>  	{ },
>  };
> +
>  MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
> 
>  static int rockchip_dfi_probe(struct platform_device *pdev) diff --git
> a/include/soc/rockchip/rk3568_grf.h b/include/soc/rockchip/rk3568_grf.h
> new file mode 100644
> index 0000000000000..575584e9d8834
> --- /dev/null
> +++ b/include/soc/rockchip/rk3568_grf.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */ #ifndef __SOC_RK3568_GRF_H
> +#define __SOC_RK3568_GRF_H
> +
> +#define RK3568_PMUGRF_OS_REG2		0x208
> +#define RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
> +
> +#define RK3568_PMUGRF_OS_REG3		0x20c
> +#define RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13,
12)
> +#define RK3568_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
> +
> +#endif /* __SOC_RK3568_GRF_H */
> --
> 2.39.2



Applied it. Thanks

Best Regards,
Chanwoo Choi


