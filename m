Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9C76F749
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjHDB4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjHDB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:56:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02ED1FF3;
        Thu,  3 Aug 2023 18:56:52 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RH7zy2jlXzJrQJ;
        Fri,  4 Aug 2023 09:54:06 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 09:56:50 +0800
Message-ID: <64CC5AE1.4000108@hisilicon.com>
Date:   Fri, 4 Aug 2023 09:56:49 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     David Yang <mmyangfl@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: hi3798cv200: Fix clocks order of sd0
References: <20230514122533.382910-1-mmyangfl@gmail.com>
In-Reply-To: <20230514122533.382910-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David，

On 2023/5/14 20:25, David Yang wrote:
> "ciu" and "biu" were incorrectly swapped. Fix their order.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> index a83b9d4f172e..ed1b5a7a6067 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> @@ -302,8 +302,8 @@ sd0: mmc@9820000 {
>  			compatible = "snps,dw-mshc";
>  			reg = <0x9820000 0x10000>;
>  			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&crg HISTB_SDIO0_CIU_CLK>,
> -				 <&crg HISTB_SDIO0_BIU_CLK>;
> +			clocks = <&crg HISTB_SDIO0_BIU_CLK>,
> +				 <&crg HISTB_SDIO0_CIU_CLK>;
>  			clock-names = "biu", "ciu";
>  			resets = <&crg 0x9c 4>;
>  			reset-names = "reset";
> 

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei
