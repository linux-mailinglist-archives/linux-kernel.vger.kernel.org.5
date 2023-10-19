Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E4F7CF90C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjJSMe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbjJSMeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:34:25 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C380BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:34:22 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231019123420epoutp032c7d90887382edd90a1980fe497b216d~Pgk8Aff8o2024520245epoutp03M
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:34:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231019123420epoutp032c7d90887382edd90a1980fe497b216d~Pgk8Aff8o2024520245epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697718860;
        bh=TDOo3bhcjq1V1M/NiUKjoKU/btNbYwTzVuBWaGqt1jA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rpDuKZu0qUxG1BuD5FxyxxjD4Yi7ewHHujr+c0DgpZfE4J4deDZnAJoiuqsIcgPJB
         qJQcH0j+BUSxAFh0tbPj32ZFfXlSbDtPPGkLWGV8yP17sQF5LfWuoVXGMeqL0rbtc4
         onTA8BsNbKf5bFrG6LcJa49waBvnESVy6oWpt7Vo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231019123419epcas1p266cc01c048793aeb28ad566c7f0b97c6~Pgk7LgH3a3075930759epcas1p2t;
        Thu, 19 Oct 2023 12:34:19 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.136]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SB6bZ4HjXz4x9Pv; Thu, 19 Oct
        2023 12:34:18 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.31.09739.A4221356; Thu, 19 Oct 2023 21:34:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231019123417epcas1p4e9848b4eb0c174f8765f8154703c463d~Pgk5ykCov2224822248epcas1p4J;
        Thu, 19 Oct 2023 12:34:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019123417epsmtrp1c0f155fb521cd0d75209e38a7a7a25df~Pgk5woGVR0993009930epsmtrp1d;
        Thu, 19 Oct 2023 12:34:17 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-74-6531224a7d92
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.3A.07368.94221356; Thu, 19 Oct 2023 21:34:17 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019123417epsmtip256da5cd81b2449a687062668b50d02d5~Pgk5XLG8o2707827078epsmtip2V;
        Thu, 19 Oct 2023 12:34:17 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Heiko Stuebner'" <heiko@sntech.de>,
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
In-Reply-To: <ffcf4521-5bf0-4933-a25c-22574035f774@kernel.org>
Subject: RE: [PATCH v8 19/26] PM / devfreq: rockchip-dfi: add support for
 RK3588
Date:   Thu, 19 Oct 2023 21:34:17 +0900
Message-ID: <004401da0288$93af2db0$bb0d8910$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwGxyFXuAqDH4QoCVt350rEfYV9w
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxj39Pb2gZZdajePTEe9UzfMgBYoHFDQBUPuBCbTuGRbBG7oDe+2
        tGXZFphKEK1KnStCKMjDIbNdUQQnD2GbSGALGc6gyFN5uG4ILAhjgzDi2l7d+O/3fd/vd77v
        951zBJh4jucpSFHpGa2KTid5btwbt719ffaRckZmb/VC5/rvcZGtrYeDKjp6cPRsfApH1vPN
        XGT8fQxDP+dO81H9RB+OelvKeGi+oAOgudFnGLr04C4H3araioaOXeah420dfHRr9jGOVhrr
        uWhk6l3UVWvnobxhxR4JZSu3AapppBpQzeYRPlVvNfCo4b5WHtVQfYQ6uyKjjNetgGrsK8eo
        +frXqIrlCRC79sO0XckMrWS0UkaVqFamqJLCyKiD8RHxiiCZ3EcegoJJqYrOYMLIvdGxPpEp
        6Q6DpPRjOj3LkYqldTrSL3yXVp2lZ6TJap0+jGQ0ynSNQuOrozN0WaokXxWjD5XLZP4KBzEh
        LdlkLMQ0fd6fPD29xD0KLpOngFAAiUDYuVyLnQJuAjHRBGCxoYjHBnMAjs/e57PBXwD2L5Vz
        X0guLBoBW2gDsMbU+Fw/CeCP3XMOvUDAI96ClYuHnAIJkQ1/O/0Id3Iw4g4Oq6arcGdBSITD
        mtvFrlPXEwdg62wD5sRcYhts7BhzYRERAqurBgGLPeBPJY9dfIzwgo0zZRg7kRQu/VqDs3kJ
        LDXkY84ZJEQkHDhzkKWUCmGuIZvFe2Hh/DGcxevhk67rfBZ7wsmz+S7HkDABeHdqCmODqwBe
        s+Q9bxYAv79k4jgbYIQ3vNrix6a3wOblC4CdwR3+sXAGd1IgIYIn88Us5XXYOzrCYfFG+NUJ
        A+8LQJpXOTOvcmZe5cb8f7NKwLWCVxiNLiOJ0ck1Af/ddqI6ox64Hv+O4CZQNDPr2w44AtAO
        oAAjJaJtlIwRi5T0p58xWnW8Niud0bUDhWPX5zDPlxPVjt+j0sfLA0NkgUH+AYFIHiQnN4gG
        7QVKMZFE65k0htEw2hc6jkDoeZSDWWYO5bQoVriisNmn1x5d+XbjpoKJw8MNsrr+iAbPktzB
        0khtcO7MJo77DxctD+czd25/u9BgLY+zF+dlRlLrrojDH7yaNLF7T7doZWxddNH+wZYbdSZi
        36jvmnfu7F6TOvANGPJzz24d3JywqDRveejV1GvP0dbyk/d7PFF9J0m7p++JqIsB8EvyoxhJ
        atykf+bhadqYczOzZIMmOmuhNO5kRVRwqhwojwyHdvpz/O9/YH0JDz5vW+javvaXbr50eIA/
        9KbxYotiIeaNKEuZBYQs9ka6lY0nbta4H3//n7EDn2dWhv5dXtspDLipjzphGxGpPfKw/tqE
        P7/eadv6Xk8+ydUl0/IdmFZH/wtdf5D3hQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSvK6nkmGqwbznehYTb1xhsViz9xyT
        xfwj51gt/j96zWqxaupOFou+Fw+ZLc42vWG32PT4GqvF5V1z2Cw+9x5htPj04D+zxdLrF5ks
        Di5UsbjduILNonXvEXaLgx+esFr83b6JxeLuaz+L42ufsVm03DF1EPFYM28No8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n36P9r4NG3ZRWjx/Zr85g9Pm+S85j/+zFjAHcUl01Kak5mWWqR
        vl0CV8bkvinMBdc0Kz52/2RpYFyh1MXIySEhYCIx90cfYxcjF4eQwG5Gid3PvjJDJCQlpl08
        CmRzANnCEocPF0PUPGeU6G68xAgSZxPQkVjwIxSkXESgTmJy9y42kBpmgdusEgun/2KGaPjC
        KDG39QMjSBWngJ3EssPTWUBsYYEAiedNp8CWsQioSmw/8hDM5hWwlFiy8BYjhC0ocXLmE7B6
        ZgFtiac3n0LZ8hLb386BOlRB4ufTZawQcRGJ2Z1tYEeLCLhJ3OwJnsAoPAvJpFlIJs1CMmkW
        ku4FjCyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCE4CWxg7Ge/P/6R1iZOJgPMQo
        wcGsJMKr6mGQKsSbklhZlVqUH19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwen
        VANTfUqX4TdVox/PnarORl3Ksj3qevX3XVXhz98tti0Nu3JoC9+tOT7aK1L3cpef37ToqenD
        nwVTypTvHmfN2SWqWMfx17DllmDJ4jAl7cINsTvdvvR/Wmng22AXLeU7rU4xq3sn/7klXJtY
        gq3ipoSd1rO1dWj6x6vDqv3hs7Pk1J6rrQLKlrqJxzTnJl6d0/Zh7cMLnpL+b9feYo6TsdC7
        ptp39cz63TY68ozse18fTg80M69dnjNhR4uY3l0RHmW2QIW6D9kvlsxe/MA9kU1R48uazN0L
        Mvae+vRFuWHKXrUfOrNLNXx8tST+PNHNTz59NO+yRGgRT8fdPapWkkmLcr+F5168pvmNcf6O
        9UuVWIozEg21mIuKEwFH5QBJbwMAAA==
X-CMS-MailID: 20231019123417epcas1p4e9848b4eb0c174f8765f8154703c463d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018151237epcas1p343048db94d5678e0dd8ab865f7cad8a1
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
        <20231018061714.3553817-20-s.hauer@pengutronix.de>
        <CGME20231018151237epcas1p343048db94d5678e0dd8ab865f7cad8a1@epcas1p3.samsung.com>
        <ffcf4521-5bf0-4933-a25c-22574035f774@kernel.org>
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
> From: Chanwoo Choi <chanwoo@kernel.org>
> Sent: Thursday, October 19, 2023 12:12 AM
> To: Sascha Hauer <s.hauer@pengutronix.de>; linux-
> rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org; Heiko Stuebner <heiko@sntech.de>; Kyungmin Park
> <kyungmin.park@samsung.com>; MyungJoo Ham <myungjoo.ham@samsung.com>; Will
> Deacon <will@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> kernel@pengutronix.de; Michael Riesch <michael.riesch@wolfvision.net>;
> Robin Murphy <robin.murphy@arm.com>; Vincent Legoll
> <vincent.legoll@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; devicetree@vger.kernel.org; Sebastian Reichel
> <sebastian.reichel@collabora.com>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>
> Subject: Re: [PATCH v8 19/26] PM / devfreq: rockchip-dfi: add support for
> RK3588
> 
> On 23. 10. 18. 15:17, Sascha Hauer wrote:
> > Add support for the RK3588 to the driver. The RK3588 has four DDR
> > channels with a register stride of 0x4000 between the channel
> > registers, also it has a DDRMON_CTRL register per channel.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/devfreq/event/rockchip-dfi.c | 36 +++++++++++++++++++++++++++-
> >  include/soc/rockchip/rk3588_grf.h    | 18 ++++++++++++++
> >  2 files changed, 53 insertions(+), 1 deletion(-)  create mode 100644
> > include/soc/rockchip/rk3588_grf.h
> >
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c
> > b/drivers/devfreq/event/rockchip-dfi.c
> > index bf38829a2a4af..794f36e7eebd1 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -26,8 +26,9 @@
> >  #include <soc/rockchip/rockchip_grf.h>  #include
> > <soc/rockchip/rk3399_grf.h>  #include <soc/rockchip/rk3568_grf.h>
> > +#include <soc/rockchip/rk3588_grf.h>
> >
> > -#define DMC_MAX_CHANNELS	2
> > +#define DMC_MAX_CHANNELS	4
> >
> >  #define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
> >
> > @@ -723,9 +724,42 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
> >  	return 0;
> >  };
> >
> > +static int rk3588_dfi_init(struct rockchip_dfi *dfi) {
> > +	struct regmap *regmap_pmu = dfi->regmap_pmu;
> > +	u32 reg2, reg3, reg4;
> > +
> > +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG2, &reg2);
> > +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG3, &reg3);
> > +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG4, &reg4);
> > +
> > +	/* lower 3 bits of the DDR type */
> > +	dfi->ddr_type = FIELD_GET(RK3588_PMUGRF_OS_REG2_DRAMTYPE_INFO,
> > +reg2);
> > +
> > +	/*
> > +	 * For version three and higher the upper two bits of the DDR type
> are
> > +	 * in RK3588_PMUGRF_OS_REG3
> > +	 */
> > +	if (FIELD_GET(RK3588_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
> > +		dfi->ddr_type |=
> FIELD_GET(RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3,
> > +reg3) << 3;
> > +
> > +	dfi->buswidth[0] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH0, reg2) ==
> 0 ? 4 : 2;
> > +	dfi->buswidth[1] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg2) ==
> 0 ? 4 : 2;
> > +	dfi->buswidth[2] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg4) ==
> 0 ? 4 : 2;
> > +	dfi->buswidth[3] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg4) ==
> 0 ? 4 : 2;
> > +	dfi->channel_mask = FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg2)
> |
> > +			    FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg4) << 2;
> > +	dfi->max_channels = 4;
> > +
> > +	dfi->ddrmon_stride = 0x4000;
> > +
> > +	return 0;
> > +};
> > +
> >  static const struct of_device_id rockchip_dfi_id_match[] = {
> >  	{ .compatible = "rockchip,rk3399-dfi", .data = rk3399_dfi_init },
> >  	{ .compatible = "rockchip,rk3568-dfi", .data = rk3568_dfi_init },
> > +	{ .compatible = "rockchip,rk3588-dfi", .data = rk3588_dfi_init },
> >  	{ },
> >  };
> >
> > diff --git a/include/soc/rockchip/rk3588_grf.h
> > b/include/soc/rockchip/rk3588_grf.h
> > new file mode 100644
> > index 0000000000000..630b35a550640
> > --- /dev/null
> > +++ b/include/soc/rockchip/rk3588_grf.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */ #ifndef __SOC_RK3588_GRF_H
> > +#define __SOC_RK3588_GRF_H
> > +
> > +#define RK3588_PMUGRF_OS_REG2		0x208
> > +#define RK3588_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
> > +#define RK3588_PMUGRF_OS_REG2_BW_CH0			GENMASK(3, 2)
> > +#define RK3588_PMUGRF_OS_REG2_BW_CH1                    GENMASK(19, 18)
> > +#define RK3588_PMUGRF_OS_REG2_CH_INFO                   GENMASK(29, 28)
> > +
> > +#define RK3588_PMUGRF_OS_REG3		0x20c
> > +#define RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
> > +#define RK3588_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
> > +
> > +#define RK3588_PMUGRF_OS_REG4           0x210
> > +#define RK3588_PMUGRF_OS_REG5           0x214
> > +
> > +#endif /* __SOC_RK3588_GRF_H */
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi


Applied it. Thanks

Best Regards,
Chanwoo Choi

