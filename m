Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021687CF8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJSMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjJSM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:29:55 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7790D7C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:29:46 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231019122944epoutp04b4a5f0c235f415be601af58f244e47a1~Pgg7Yzqsu3056030560epoutp04_
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:29:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231019122944epoutp04b4a5f0c235f415be601af58f244e47a1~Pgg7Yzqsu3056030560epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697718584;
        bh=TDOo3bhcjq1V1M/NiUKjoKU/btNbYwTzVuBWaGqt1jA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cl/2Eu7eVWSTruIkRdW9+FxDst3qASL4DHoh8/P4QdrM78qM69lPUJ0ME8I/eiGCw
         1wih8B2vhZjdgOgBBWj6HHOBMVS0ghOiOuRsHn5dF0Qb6qgt75EZv8L7bUx6gZCN3s
         bHKaxz68guR4GgJcZzw51EhRcMXSl0ADgtq7sTak=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20231019122943epcas1p3a7aaf6b7d57a12d30e0823eed1168a5d~Pgg56k4hP0139501395epcas1p3b;
        Thu, 19 Oct 2023 12:29:43 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SB6VG20VKz4x9Ps; Thu, 19 Oct
        2023 12:29:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.01.09731.63121356; Thu, 19 Oct 2023 21:29:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231019122941epcas1p1f094121c91f61fea36f4b02fa9c219b5~Pgg4YTgsV1912419124epcas1p1a;
        Thu, 19 Oct 2023 12:29:41 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231019122157epsmtrp166d30538f20c5191acf82727c5059119~PgaIHUUbd0316803168epsmtrp1M;
        Thu, 19 Oct 2023 12:21:57 +0000 (GMT)
X-AuditID: b6c32a36-a7dff70000002603-f0-65312136c29f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.99.18939.56F11356; Thu, 19 Oct 2023 21:21:57 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019122157epsmtip2c2dc2144b509f4fa568996ea3089c182~PgaH1ozco1190911909epsmtip2T;
        Thu, 19 Oct 2023 12:21:57 +0000 (GMT)
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
Date:   Thu, 19 Oct 2023 21:21:57 +0900
Message-ID: <002c01da0286$da5fde00$8f1f9a00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFYMiMsP3soeW2GlDsie1R9CxInBwGxyFXuAqDH4QoCVt350rEfXexA
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxTP7Xt9LTr0Wdi8EDfKQx0QPlps4bIA0+jgJTMLUTGREfGFvgGh
        tF1bFrbIxofA+BYBxVoUMsCOoMTKBAz4ARjG4iAORJ2QMQtOKBCEMfmYYS0PJ//9zu/8zj3n
        d+69Qkw0R7gKE1V6VqtilBSxCb/R5eXrG+guZSUV/Q6o9PEgjho7+njoUncfH60+s/JRQ0Ub
        jopf/ImhXzOnBMhsGeKjgZtGAs0XdQM0N7qKobpHD3jobs1O9DTDRKDsjm4Bujs7xkevW8w4
        GrF+hnquPCfQqWH5Xme68WIjoFtHagHdZhgR0OaGPIIeHmon6Ou139ElryV0cXMDoFuGLmL0
        vPkD+tKKBURujk4KSWAZBasVs6o4tSJRFR9KfXo4dn+sPFAi9ZUGoyBKrGKS2VDqwMFI3/BE
        pc0gJf6KUabYqEhGp6P8w0K06hQ9K05Q6/ShFKtRKDVyjZ+OSdalqOL9VKz+I6lEEiC3CU8k
        JZQVl2OaIa/UlwVLeDowUfnAQQhJGawbM4F8sEkoIlsBTLf0EFwwB2BT5vDb4GFjFvGm5Mlg
        hoBLtAFYMLEssCdE5ASAU5nR+UAoJEgfWL0YZaedyZPwr4I/+HY9RvbzYc1UDd+ecCDDYH3X
        OdyOnchDsH32OmbHOLkLzvcOrJ3pSAbDFyXLBIe3wd7zY2t6jHSDLdNGjBtIDJfG6/kc7wwv
        5OVgXONwmFH++/rQFxygaTCOwwfgrdP167wTnOxpFnDYFU6U5KwZg2QZgA+sVowLmgC89uOp
        9W574O26Mp7dJUZ6waab/hztDttWqgA3xBY4s1DIt0sg6Qi/zxFxEg84MDrC47AL/CE3jzgN
        KMMGa4YN1gwb7BjeNqsGeAN4j9XokuNZnVQT8P9tx6mTzWDt8XsHtoIz07N+nYAnBJ0ACjHK
        2XEXLWFFjgrm629YrTpWm6JkdZ1Ablt2Keb6bpza9ntU+lipLFgiCwzYI0PSQCm13dFoKVKI
        yHhGzyaxrIbVvqnjCR1c03lh0zt+c+r7cvynbGl/2/19vTP5nildioo7qzHN59yijRkLz8yU
        T2UfiBAWqPW12/HK7H8KrYrew+HyiMw0tzuxvcA96PLZEMJw1rkzu/BVYn/3QRdmufJ82ecR
        k3XYsajloQ5TUPUV7RHfX5TH82YMRYsdgg6LvPzGoTT9nPWLe1mG8v3d21Y9d7TjJ0+kPvow
        a1+MOmJvasCM+NoMLrOoswuXPl7M/TfC+Gpgy0OXfrfb94q9/ibSco5UeUzmlvoYE66+kx/f
        GVm8Nf3bqlvhMZt3/uw97q8wTpk+2f20yWB9WV+reHL0vmfF1mNBHqrjCz6j77uvXB09qp5q
        eiwWPQ+PonBdAiP1xrQ65j8LiMUjhQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSvG6qvGGqwfljYhYTb1xhsViz9xyT
        xfwj51gt/j96zWqxaupOFou+Fw+ZLc42vWG32PT4GqvF5V1z2Cw+9x5htPj04D+zxdLrF5ks
        Di5UsbjduILNonXvEXaLgx+esFr83b6JxeLuaz+L42ufsVm03DF1EPFYM28No8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n36P9r4NG3ZRWjx/Zr85g9Pm+S85j/+zFjAHcUl01Kak5mWWqR
        vl0CV8bkvinMBdc0Kz52/2RpYFyh1MXIySEhYCJx80ojexcjF4eQwHZGic5L35khEpIS0y4e
        BbI5gGxhicOHiyFqnjNK7Ns+iw0kziagI7HgRyhIuYhAncTk7l1sIDXMArdZJRZO/8UM0fCF
        UWJu6wdGkCpOATuJZYens4DYwgIBEs+bToEtYxFQlfh88jI7iM0rYCnxov8XG4QtKHFy5hOw
        emYBbYmnN59C2fIS29/OgTpUQeLn02WsEHERidmdbcwQF7lJNE65xTaBUXgWklGzkIyahWTU
        LCTtCxhZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIEx75W0A7GZev/6h1iZOJgPMQowcGs
        JMKr6mGQKsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cCU
        9q/c5OqhiafqJ7iWTFBYGvcwcq6I1ox31ZeabjyeuElj0urcPskvOX+LUhQ+6b18nzD33dMO
        0Y7L0l+2nzp3ZivvcXvRGyUSp+/uqrgbe+PXjeg1z5WFuWXDlWMfJZ+OvRLl6OLxWH/7b9b3
        +rM3f7C7qbftbWf51o5A8Scq92Wi97QnrjcUm/+xce2L6dfnyEWL6GmUck5dzXplV1+kzc73
        B7k9zy5U279vGkNXkUVqwregxR7KHKtW36+NEXNzODJrWtHBvheFrxa1/17atPX/q4KqSazH
        /p3zju+bttw36MpWxX1tqTyObw7M26g0q1GtbIbNhAkXVCYvmW6Qkv9uwb5KGfmYAw82b/5z
        8b8SS3FGoqEWc1FxIgDz1POobAMAAA==
X-CMS-MailID: 20231019122941epcas1p1f094121c91f61fea36f4b02fa9c219b5
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

