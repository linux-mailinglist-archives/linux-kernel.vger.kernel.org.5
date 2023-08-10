Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DED7776F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHJL1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjHJL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:27:38 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D926A9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:27:37 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230810112735epoutp046b0a143484ceafc8cc85ad9f39ded732~6AgrkTNi11241112411epoutp04T
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:27:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230810112735epoutp046b0a143484ceafc8cc85ad9f39ded732~6AgrkTNi11241112411epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691666855;
        bh=LbKSAH+guAP5EthZFGEfFquTdSJw7F8vhoo2LgrcSks=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=RHmS68j/Ky80qCywI/E8oM6ZR0Vp6PLTXHEpm373Xjq8CRepj/17g2SvAxCNVPuJL
         ds3Xfcm4hYZtFc8qADVzRZgJwLBlhJl5zfupYIY+yp5syAnKWE2DEjixTUAe6y+IPF
         DqNoeK5u/hLFJxKDBXY5pV5ZYZl1JpZLpt7Ve6dA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230810112735epcas5p2b15d366ee8874682ae06e67100fe97dd~6AgrJtSPp3115831158epcas5p2U;
        Thu, 10 Aug 2023 11:27:35 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RM4Qt1VGlz4x9Pq; Thu, 10 Aug
        2023 11:27:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.3A.57354.6A9C4D46; Thu, 10 Aug 2023 20:27:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230810112733epcas5p3e0b2fe83a73c96d4f9189014db83c5c2~6AgpqSa5M0904009040epcas5p3e;
        Thu, 10 Aug 2023 11:27:33 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230810112733epsmtrp2e9cddcfc09844055d8c77bd71405b012~6AgppdS260553505535epsmtrp2C;
        Thu, 10 Aug 2023 11:27:33 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-31-64d4c9a63bd2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.4C.14748.5A9C4D46; Thu, 10 Aug 2023 20:27:33 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810112731epsmtip2dac60f8350dc2f24bedb1d708d10ba77~6Agn4JqfT0234702347epsmtip28;
        Thu, 10 Aug 2023 11:27:31 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-7-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 06/11] clk: samsung: exynos5420: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 16:57:30 +0530
Message-ID: <004901d9cb7d$a8006910$f8013b30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gHua++GAfu2rheuPIdAEA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhu6yk1dSDNY2s1ms2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APSrbJiM1MSW1SCE1
        Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoWCWFssScUqBQQGJxsZK+
        nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaKJQIFqwQrHrVf
        YWxgPMDXxcjJISFgItH3/iNrFyMXh5DAbkaJX6evsEE4nxgl9m9eywjhfGOUWL7yHwtMy8a3
        fewQib2MEn/2PmSBcF4ySvyc2ARWxSagK7FjcRvYLBGBWSwSvw+vZgRJcAq4SpxfBjFKWCBR
        ovPOESYQm0VAVWLJ9DlANRwcvAKWEi+++4KEeQUEJU7OfAJWziwgL7H97RxmiCsUJH4+XcYK
        YosIOElcW30JqkZc4uXRI+wQNSc4JD7/84awXSQm7XvCBGELS7w6vgWqRkri87u9bCBrJQQ8
        JBb9kYIIZ0i8Xb6eEcK2lzhwZQ4LSAmzgKbE+l36EJv4JHp/g0wE6eSV6GgTgqhWlWh+dxUa
        VNISE7u7WSFsD4nL085CA/cyo8TaOxeZJzAqzELy5CwkT85C8swshM0LGFlWMUqmFhTnpqcm
        mxYY5qWWw6M7OT93EyM4JWu57GC8Mf+f3iFGJg7GQ4wSHMxKIry2wZdShHhTEiurUovy44tK
        c1KLDzGaAgN+IrOUaHI+MCvklcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTT
        x8TBKdXA5JL626z3ybSZIunbtjrz+5z+fjjM2JJJ8YyLcuEpJUVZ5sSXE3OCNiowyxfO+DlT
        3/+5+4/1V/6/PuH2W2N9TMvEaweehjz76/Jw/6P6C2o26m+mGE2ceH17aKrvxDWzFH89nbW1
        qfHpPBaTlf2CbSvu2x4K2OR+6dDK43mLbt0ylzuQ93RW+M+TTM/K7nAI6rDeFmjsjp3wqP2a
        zQHLlJRczinaJkcX3eSJ21QccK4g5L/4NluuQIF/ZRqS4qe2f7I68XPy9ab2i7fTc5bcnZ2/
        TtKcxf2tW6P0ep/SxXMmzz16VuqJUv5yhS0Ml86+2bnwl2+1W0fd09pT3/68KZ3wIzjR/86K
        FwzrNatSl6YrsRRnJBpqMRcVJwIASMgPPFIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvO7Sk1dSDJ4/17JYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAexSXTUpqTmZZapG+
        XQJXxoolAgWrBCsetV9hbGA8wNfFyMkhIWAisfFtH3sXIxeHkMBuRomVO4+wQCSkJa5vnMAO
        YQtLrPz3HKroOaPEl4dvwRJsAroSOxa3sYEkRASWsEice7yNGSQhJHCeUaJ/qzWIzSngKnF+
        2T+wqcIC8RKfXrWA2SwCqhJLps9h7GLk4OAVsJR48d0XJMwrIChxcuYTFpAws4CeRNtGRpAw
        s4C8xPa3c5gh7lGQ+Pl0GSuILSLgJHFt9SUWiBpxiZdHj7BPYBSahWTSLIRJs5BMmoWkYwEj
        yypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjODo09LYwXhv/j+9Q4xMHIyHGCU4mJVE
        eG2DL6UI8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvEwSnVwKRT
        cjHDzi5ELsqe9f7y5S/fLXt95oaxT1rGg5YN4uXLDGrVeJa8e/KVafnfLscDM7SeORu2GPFY
        RG/13pDW987+nezrDWHXuj/aLG4r/5q3oVVa4bds7cIVfyMzi8tP2m789CNCaNrex9kVZ+y+
        HjErTD2uLrroRP49gc8/LPLvzYvIT8wKVxAvN7b828eZkJdvHaqaXLp6/e38P6fn7/34RUrq
        leJSEYuPv1OWHZ3gsu3jAd6w1ezrW19lGbLsFKpasju2PzUsas+l/WXhuyfONdPs/B13NH8K
        n15KVXdvzlLTl0o7p+d2a37trX25481CnsNrpfzEbs7eom3detfJK7Wmd8cDe/Wdki385kos
        xRmJhlrMRcWJAM1o3agtAwAA
X-CMS-MailID: 20230810112733epcas5p3e0b2fe83a73c96d4f9189014db83c5c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082756epcas5p3b233061078a2406aa63119531228c6a7
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082756epcas5p3b233061078a2406aa63119531228c6a7@epcas5p3.samsung.com>
        <20230808082738.122804-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> Subject: [PATCH 06/11] clk: samsung: exynos5420: do not define number of
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


>  drivers/clk/samsung/clk-exynos5420.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c
b/drivers/clk/samsung/clk-
> exynos5420.c
> index 1e0cbf762408..199843f12ae5 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -139,6 +139,9 @@
>  #define SRC_KFC			0x28200
>  #define DIV_KFC0		0x28500
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR			(CLK_DOUT_PCLK_DREX1 + 1)
> +
>  /* Exynos5x SoC type */
>  enum exynos5x_soc {
>  	EXYNOS5420,
> @@ -1587,7 +1590,7 @@ static void __init exynos5x_clk_init(struct
> device_node *np,
> 
>  	exynos5x_soc = soc;
> 
> -	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
> +	ctx = samsung_clk_init(NULL, reg_base, CLKS_NR);
>  	hws = ctx->clk_data.hws;
> 
>  	samsung_clk_of_register_fixed_ext(ctx,
> exynos5x_fixed_rate_ext_clks,
> --
> 2.34.1


