Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6359A7776EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjHJL1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHJL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:27:16 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A5C2696
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:27:16 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230810112714epoutp04f5f65e27be80d1ae7dfe98bdf7c8805f~6AgXh7Yui1241312413epoutp04-
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:27:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230810112714epoutp04f5f65e27be80d1ae7dfe98bdf7c8805f~6AgXh7Yui1241312413epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691666834;
        bh=ZHapb8gslJs/CBhAQb2fM9fKay/7+IzUS29GF359B6g=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=SowB7rQHOOGBISf7pH1CFf+ULFkCGh1pxQ2banP1JoVCMAVnLWfW40vQ2+8KIvWAa
         kcnRgYqwVuoZ4w5AiNEOH6I3M3gO4Ir1a14EPD4KDdp6qSHI4D6Sl18d8LXuv7IQCh
         VkSa5eugkJgGW4XSlZVxs3mwWMdx39TBHFg/J89w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230810112713epcas5p1ee1e078efecedbc60231f65c687a1e7d~6AgW2A-6M2904929049epcas5p1J;
        Thu, 10 Aug 2023 11:27:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RM4QS2XSfz4x9Q0; Thu, 10 Aug
        2023 11:27:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.90.55522.099C4D46; Thu, 10 Aug 2023 20:27:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230810112711epcas5p37ff084dd3ff3f1fbf8ef3077b2533571~6AgVPoqXO0931709317epcas5p3-;
        Thu, 10 Aug 2023 11:27:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230810112711epsmtrp171c75f95cbc83bd6aca5ccdd9ac10db4~6AgVO1yBE0816508165epsmtrp1T;
        Thu, 10 Aug 2023 11:27:11 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-bd-64d4c99044d3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.EA.30535.F89C4D46; Thu, 10 Aug 2023 20:27:11 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230810112709epsmtip11a4b6e5a60ea344a33dfe0bb211d35f1~6AgTIA9K43190131901epsmtip1W;
        Thu, 10 Aug 2023 11:27:09 +0000 (GMT)
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
In-Reply-To: <20230808082738.122804-6-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 05/11] clk: samsung: exynos5410: do not define number of
 clocks in bindings
Date:   Thu, 10 Aug 2023 16:57:08 +0530
Message-ID: <004801d9cb7d$9af02440$d0d06cc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKdkXeLsq2DobfMxxfuGwY9MCDG5gH4wWnRAhrydSOuOzqXgA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmlu6Ek1dSDE5eELRYs/cck8X1L89Z
        LeYfOcdqsff1VnaLTY+vsVp87LnHanF51xw2ixnn9zFZXDzlatG69wi7xeE37awW/65tZLFY
        tesPowOvx/sbreweO2fdZffYtKqTzePOtT1sHpuX1Hv0bVnF6PF5k1wAe1S2TUZqYkpqkUJq
        XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
        O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyJ3c9YC6YIVny8
        OIG1gXEFXxcjB4eEgInE/mVlXYxcHEICuxklXl6axQbhfGKUmHalhwXC+cYo0Xu9m72LkROs
        4+WCG4wQib2MEkvm7WYBSQgJvGSUeH7XFcRmE9CV2LG4DWyUiMAsFonfh1czgiQ4BVwlnu1/
        wQRiCwskSuxb8RhsKouAqsSL3uusIDavgKXE0/f9zBC2oMTJmU/AFjALyEtsfzuHGeIKBYmf
        T5exgvwgIuAkMWkFN0SJuMTLo0fYQfZKCJzhkHj3u5ERot5F4v2WmWwQtrDEq+NboL6RknjZ
        38YOCQsPiUV/pCDCGRJvl6+HarWXOHBlDgtICbOApsT6XfoQq/gken8/YYLo5JXoaBOCqFaV
        aH53lQXClpaY2N3NCmF7SLz7d4UVEmyXGSWOdvSxTmBUmIXkyVlInpyF5JtZCJsXMLKsYpRM
        LSjOTU8tNi0wzEsth0d3cn7uJkZwStby3MF498EHvUOMTByMhxglOJiVRHhtgy+lCPGmJFZW
        pRblxxeV5qQWH2I0BYb8RGYp0eR8YFbIK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7
        NbUgtQimj4mDU6qBqbpz/TKZAy0Zc6UvvdwSry7BrLXzXf/6NqWolfumODrv6fL7GbPkEVc8
        k7HbvBivXSLGzOGH3J/Xsu818r6xJtRc6uKp2kuHC+XulP9UWal4Lu1n7uR5M2ulC8wnXuSN
        DH/0Xvbt/Ig/Klbnfj0LmssrlBxQpT2z7cnSKdMapn/d8jL32st3d6dMlN/hpC2YUnb29oH7
        uiebSkRVUk792ffoUdemAu31L9i2TEjt4VESOFZUX+u3r/Zah8bqU9OqY4UidszcsOWtlan4
        aw377vJvP7frr3nytK5fccWGqBVFgY8MFXoDLBTb9M7Mm+L37eMZcXtedQt/g7Rc2zVdDkpL
        Ngnb/60zmrx4xp7pv5RYijMSDbWYi4oTAXb7JwBSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnG7/ySspBsvv6lus2XuOyeL6l+es
        FvOPnGO12Pt6K7vFpsfXWC0+9txjtbi8aw6bxYzz+5gsLp5ytWjde4Td4vCbdlaLf9c2slis
        2vWH0YHX4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8SS6APYrLJiU1J7MstUjf
        LoErY2L3M9aCKYIVHy9OYG1gXMHXxcjJISFgIvFywQ3GLkYuDiGB3YwSey6/Y4RISEtc3ziB
        HcIWllj57zk7RNFzRolVn8+xgCTYBHQldixuYwNJiAgsYZE493gbM0TVeUaJU9c6WEGqOAVc
        JZ7tf8EEYgsLxEss/NMMNpZFQFXiRe91sBpeAUuJp+/7mSFsQYmTM58AbeDgYBbQk2jbCHYR
        s4C8xPa3c5ghLlKQ+Pl0GStIiYiAk8SkFdwQJeISL48eYZ/AKDQLyaBZCINmIRk0C0nHAkaW
        VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwRGopbWDcc+qD3qHGJk4GA8xSnAwK4nw
        2gZfShHiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpiSWp2ampBahFMlomDU6qB6aLR
        p7MsV88qb58pumbuvKjIhQF79ZJLv1QV2Od4Zc054fGV5f06y/qTR05zbHl0VDg+2lBlutDB
        fz/vy6vGVRW9CXQ5JXTl8o+T2VynlNdkX3OasyDjovd/jYzfvCuuHtR9/9KDw+Djeb6bEcuc
        dPRvvlh/PvKXBetbb30228s5XW+6o2Rnr+2fE75FeNVijgUrOJpXKDGslHpatkxhasXDK00X
        p5+QOdalealKmYd1qbLGr43H6k3enXj4QKHEUGKtReHzsy8Db/ttOXZgXRXX9PKwA5dDThy9
        de7I0oAF8kyWdoL/Dtq9urv09umi5f6fRVhnqsW8+v1iWiwjc3REW+OGM4mLleV3JcpOFihT
        YinOSDTUYi4qTgQAcpLKJC8DAAA=
X-CMS-MailID: 20230810112711epcas5p37ff084dd3ff3f1fbf8ef3077b2533571
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230808082756epcas5p2bdb8e972e300abeda5a484b56810236a
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
        <CGME20230808082756epcas5p2bdb8e972e300abeda5a484b56810236a@epcas5p2.samsung.com>
        <20230808082738.122804-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
> Subject: [PATCH 05/11] clk: samsung: exynos5410: do not define number of
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

>  drivers/clk/samsung/clk-exynos5410.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5410.c
b/drivers/clk/samsung/clk-
> exynos5410.c
> index d67d67a519a4..2654077211e7 100644
> --- a/drivers/clk/samsung/clk-exynos5410.c
> +++ b/drivers/clk/samsung/clk-exynos5410.c
> @@ -56,6 +56,9 @@
>  #define SRC_KFC			0x28200
>  #define DIV_KFC0		0x28500
> 
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR			512
> +
>  /* list of PLLs */
>  enum exynos5410_plls {
>  	apll, cpll, epll, mpll,
> @@ -260,7 +263,7 @@ static const struct samsung_cmu_info cmu __initconst
> = {
>  	.nr_div_clks	= ARRAY_SIZE(exynos5410_div_clks),
>  	.gate_clks	= exynos5410_gate_clks,
>  	.nr_gate_clks	= ARRAY_SIZE(exynos5410_gate_clks),
> -	.nr_clk_ids	= CLK_NR_CLKS,
> +	.nr_clk_ids	= CLKS_NR,
>  };
> 
>  /* register exynos5410 clocks */
> --
> 2.34.1


