Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D260B7776CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjHJLW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjHJLWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:22:24 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531422686
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:22:23 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230810112221epoutp028f6cc0a03dea31aa49536b0378ff4b1d~6AcGXYEdW1916919169epoutp022
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230810112221epoutp028f6cc0a03dea31aa49536b0378ff4b1d~6AcGXYEdW1916919169epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691666541;
        bh=d//B7oykHJa8VCnNOgGBMc54jzNQf7SGuTL3qyiTWTc=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=P/IKpnV5RZcYjoDrRoBZq7f2R+O1A/YEkmgNKd7QO+0Vnq07J+rPqbxi/KMfV+qwB
         Pv+UCA/464qGVDUKXuIBmfXLAvb+z+ky3lRXNgOCgE4EdgDzpUNrKnmM1C6LwgNJPA
         WWnJOVyHNbN/ThfxIACreqnptAWL+OoWvzBNI1UA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230810112220epcas5p1ef54a977cab2e4e184e17e3ab7d7cb50~6AcFpiilU1040910409epcas5p1P;
        Thu, 10 Aug 2023 11:22:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RM4Jp4VWHz4x9Pr; Thu, 10 Aug
        2023 11:22:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.5C.44250.868C4D46; Thu, 10 Aug 2023 20:22:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230810112215epcas5p4a2e02d4f1d0ab5d707754f46378bd1a2~6AcBmVF5M2468924689epcas5p4x;
        Thu, 10 Aug 2023 11:22:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230810112215epsmtrp10b8685be142ca5491628d907814b97e4~6AcBk9xs10572305723epsmtrp1s;
        Thu, 10 Aug 2023 11:22:15 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-61-64d4c86821b1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.1C.14748.768C4D46; Thu, 10 Aug 2023 20:22:15 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810112213epsmtip232caf451a61ad5d7a8383f4720d6ea49~6Ab-qm7_J0224502245epsmtip2W;
        Thu, 10 Aug 2023 11:22:13 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
In-Reply-To: <20230808082738.122804-4-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 03/11] clk: samsung: exynos5250: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 16:52:12 +0530
Message-ID: <004601d9cb7c$ea7a7f20$bf6f7d60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gKES6YOAdKAHWyuOSBg4A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmlm7GiSspBlOOiFms2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsahD59YCmYIVRxt
        /MvcwDiPv4uRg0NCwETiwpGkLkYuDiGB3YwSq2d/YIJwPjFKTDv2gwXC+cYocXx1M1sXIydY
        x8HWbYwQib2MEh83f2GHcF4ySrT++8YIUsUmoCuxY3EbG0hCRGAWi8Tvw6vBEpwCrhLLvh8H
        GyUskChx8t9SdhCbRUBVovX/HrA4r4ClxLLrzVC2oMTJmU9YQGxmAXmJ7W/nMEOcoSDx8+ky
        VhBbRMBJYtbjf1A14hIvjx4Bu0hC4AiHxNRrPVANLhJP9+6B+kFY4tXxLewQtpTEy/42dkho
        eEgs+iMFEc6QeLt8PSOEbS9x4MocFpASZgFNifW79CFW8Un0/n7CBNHJK9HRJgRRrSrR/O4q
        C4QtLTGxu5sVwvaQeNj7BBpwlxklJs28zDaBUWEWki9nIflyFpJvZiFsXsDIsopRMrWgODc9
        tdi0wCgvtRwe4cn5uZsYwWlZy2sH48MHH/QOMTJxMB5ilOBgVhLhtQ2+lCLEm5JYWZValB9f
        VJqTWnyI0RQY9BOZpUST84GZIa8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQi
        mD4mDk6pBqbCstb5XV9lr80VuhzI7z+janHP8Yzi59bWesytChO1Hk3Pv7z1K3N/2Ya/ZS1P
        eg8Jlr8s/xDraN/2RDWl+uxfy7DOWa6XltUVVFnvPvfyzcFFJ/OlZkWGPK3t+jV7d3qsrtA7
        sydNltfnPWW3SNpwqN/P8OXhuUy5e7VqP0zdGWQ12/D2xoW6iwR0PWOdVL0SDv7knigT8SDf
        iNdwbZjBiugJc5rzJDqNpnw+ELZH6MNauZhKEZ3jpz7MbXu3Z11V7fX5Tr9UZ5zs3/NC8KvQ
        QpWajXnvNhhavfss+vYgo9HMOvkfbdZcpYo77iZItJk83vX6SP9F+axrK74cEl4gfEHOQfHX
        xYRl1Ye6WlmUWIozEg21mIuKEwHvyZdeVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvG76iSspBtcmGVis2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APYrLJiU1J7MstUjf
        LoEr49CHTywFM4Qqjjb+ZW5gnMffxcjJISFgInGwdRtjFyMXh5DAbkaJ9s372CES0hLXN06A
        soUlVv57zg5R9JxRordvJyNIgk1AV2LH4jY2kISIwBIWiXOPtzFDVJ1nlNj76ScLSBWngKvE
        su/H2UBsYYF4iY2v1oPFWQRUJVr/7wGL8wpYSiy73gxlC0qcnPkEqIaDg1lAT6JtI9gyZgF5
        ie1v5zBDXKQg8fPpMlYQW0TASWLW438sEDXiEi+PHmGfwCg0C8mkWQiTZiGZNAtJxwJGllWM
        kqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMExqKWxg/He/H96hxiZOBgPMUpwMCuJ8NoG
        X0oR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1OqgWnyqYdr
        HXV8pOVKJLdOPB8zMfWW4h2DsGMnHGufffeoCJ1XLyGdMMP+RKCGafTWNXN4S0rcL5c6cU8r
        qV7+Pmnzwnk7GZ4+3eSxP1E9Kfbuh4PyW54G+G2LWxSbsCZ5Tvru+AP/zTqu/P93VPzEKYGA
        b/t9xS5sat5v8aXdfQ7P7orTD/0358hvid5+silGzfbsCpmUqL2Mly/mKBi/OlS0ePt/aZkj
        jz2cHNJ15i2YIc3HpPH28h1R9nOHM2+vPaP6brOljmeGtaKa5tvWJalx7PIzLLTTyhOmHm1M
        3nPAq1ZUtFm+g/V2W6GefJg/H6fywctnJdM+TRfNuazactA6tp1bZk2eXDDTruMXuZVYijMS
        DbWYi4oTAc9aP0EwAwAA
X-CMS-MailID: 20230810112215epcas5p4a2e02d4f1d0ab5d707754f46378bd1a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082752epcas5p407778033694c59593cdbedabed2d875f
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082752epcas5p407778033694c59593cdbedabed2d875f@epcas5p4.samsung.com>
        <20230808082738.122804-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, August 8, 2023 1:58 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sylwester
> Nawrocki <s.nawrocki@samsung.com>; Tomasz Figa
> <tomasz.figa@gmail.com>; Chanwoo Choi <cw00.choi@samsung.com>; Alim
> Akhtar <alim.akhtar@samsung.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Rob
> Herring <robh+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: [PATCH 03/11] clk: samsung: exynos5250: do not define number of
> clocks in bindings
> 
> Number of clocks supported by Linux drivers might vary - sometimes we add
> new clocks, not exposed previously.  Therefore this number of clocks
should
> not be in the bindings, because otherwise we should not change it.
> 
> Define number of clocks per each clock controller inside the driver
directly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/clk/samsung/clk-exynos5250.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5250.c
b/drivers/clk/samsung/clk-
> exynos5250.c
> index 92fb09922f28..8ebe6155d8b7 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -100,6 +100,9 @@
>  #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
>  #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR
> 	(CLK_MOUT_VPLLSRC + 1)
> +
>  /* list of PLLs to be registered */
>  enum exynos5250_plls {
>  	apll, mpll, cpll, epll, vpll, gpll, bpll, @@ -797,7 +800,7 @@ static
void
> __init exynos5250_clk_init(struct device_node *np)
>  		panic("%s: unable to determine soc\n", __func__);
>  	}
> 
> -	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
> +	ctx = samsung_clk_init(NULL, reg_base, CLKS_NR);
>  	hws = ctx->clk_data.hws;
> 
>  	samsung_clk_of_register_fixed_ext(ctx,
> exynos5250_fixed_rate_ext_clks,
> --
> 2.34.1


