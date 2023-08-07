Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B772771F41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjHGLFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHGLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:05:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6258710EF;
        Mon,  7 Aug 2023 04:05:42 -0700 (PDT)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47F7966071C7;
        Mon,  7 Aug 2023 12:05:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691406340;
        bh=5YZT2Ezwe663qvbFpPpMjH+Ew5+w9TA+lbeL02sFIH4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PqnXPwe27tmgzJ/9eJPCGfRFEWlwIVmjykHR/a8JuqJVr5orHWac7Bt7j3HI/UQD6
         bScMtv0xOeakR53Cm43plg2SnKUy5AvGLSig4JyGbwt1qtarHiIGAv0sBdZVSFMUjZ
         fGAo6CkcObnixHCWDRv0y1vNRPe7zfdhMv3whGb+LZhdUOeGfbQHv8ifqZemtxTOye
         memHGt2MQgztxy1zkdBQIAo2mQKoJ2g9zq4z9sgceDGL4Txh6wWgmyyXaWsYwuXWJ/
         Vu6CjVfqpuMQdkACXl/gc6oHO6qObC5aHe+4M3w45213DPpentP4N4NrRxJlNYafUc
         C2u1to8BEK8Eg==
Message-ID: <f9ed06cb-2c9b-6b82-0bb4-2189a05218a1@collabora.com>
Date:   Mon, 7 Aug 2023 14:05:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: mt8195: change watchdog reset boot flow
Content-Language: en-US
To:     Hsin-Te Yuan <yuanhsinte@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@google.com>
References: <20230807085811.1.I7d08b8323531c59c0ec247570b2d05a790bfd3d4@changeid>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230807085811.1.I7d08b8323531c59c0ec247570b2d05a790bfd3d4@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hsin-Te,

On 8/7/23 11:58, Hsin-Te Yuan wrote:
> The external output reset signal was originally disabled and sent from
> firmware. However, an unfixed bug in the firmware prevents the signal
> from being sent, causing the device to fail to boot. To fix this, enable
> external output reset signal to allow the device to reboot normally.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@google.com>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 37a3e9de90ff7..5dc4214e1840b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -1147,6 +1147,10 @@ &uart0 {
>   	status = "okay";
>   };
>   
> +&watchdog {
> +	/delete-property/ mediatek,disable-extrst;
> +};
> +

Does this affect only the mt8195-cherry or all mt8195 boards ?

Judging by this commit , I think only mt8195-cherry, but your commit 
message somehow suggests otherwise.

Eugen

>   &xhci0 {
>   	status = "okay";
>   

