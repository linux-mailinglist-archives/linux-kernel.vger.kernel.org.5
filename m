Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA27573F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGRGUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGRGUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247EB5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72C6613CA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3520C433C9;
        Tue, 18 Jul 2023 06:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689661205;
        bh=s3/iQuhgSYfy1+JjML0H0p/t+NfvmlRk8Z5WWqYfGA4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ldit87PAmPbM8W98FjAJgQRjHMFdWvmwgger/x0e14VfB5LTy92JKXCGEJ7zLc2rF
         aYs0osRaBmC1SSptqg6Le3kRQ9gT/uIvIyR1dxug51LwIa4qHnc2lqdXf8ePZptLAX
         j6y5btldLhl/sg49v4I27Xib7hy+83K9Gy68LAMb45tICJLK0eywb5rui2Xnm12QrF
         8t8CVZXnNtSPKA0TYa9KwJDkcGRzGEmLFeRkG7KD+d30ysKCQ15hFB9phkeGZ28JJQ
         I1nxCq/3tB4BXZn5C2rq+jXTPbjcuyFLPAx3tuHFoRXVkVZJDYgie9hApFuQaJbXzW
         cFsBQG0AdRe9Q==
Message-ID: <de9ebb36-d0e9-3ec1-92ff-d9b3d4b2fedc@kernel.org>
Date:   Tue, 18 Jul 2023 08:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 17/17] arm64: dts: ti: k3-am62-main: Add GPU device
 node [DO NOT MERGE]
To:     Sarah Walker <sarah.walker@imgtec.com>,
        dri-devel@lists.freedesktop.org
Cc:     matthew.brost@intel.com, luben.tuikov@amd.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
References: <20230714143033.112624-1-sarah.walker@imgtec.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230714143033.112624-1-sarah.walker@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 16:30, Sarah Walker wrote:
> Add the Series AXE GPU node to the AM62 device tree.
> 
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index b3e4857bbbe4..ad13414acf18 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -892,4 +892,17 @@ mcasp2: audio-controller@2b20000 {
>  		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
>  		status = "disabled";
>  	};
> +
> +        gpu: gpu@fd00000 {
> +                compatible = "ti,am62-gpu", "img,powervr-seriesaxe";
> +                reg = <0 0x0fd00000 0 0x20000>;
> +                power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
> +                clocks = <&k3_clks 187 0>;
> +                clock-names = "core";
> +                interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +                interrupt-names = "gpu";
> +                #cooling-cells = <2>;
> +                #cooling-min-level = <0>;
> +                #cooling-max-level = <3>;

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

