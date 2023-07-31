Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE52769688
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGaMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGaMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:42:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B12E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:42:27 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qQSE5-0006f4-5g; Mon, 31 Jul 2023 14:42:17 +0200
Message-ID: <a29cf254-80c9-50e6-c723-71a8f03e6e35@pengutronix.de>
Date:   Mon, 31 Jul 2023 14:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: switch to vqmmc-supply
Content-Language: en-US
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <guido.gunther@puri.sm>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernel@puri.sm
References: <20230730121047.43115-1-david@ixit.cz>
 <ZMebuXJKFMpjCuul@qwark.sigxcpu.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <ZMebuXJKFMpjCuul@qwark.sigxcpu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,
Hello Guido,

On 31.07.23 13:32, Guido Günther wrote:
> Hi,
> On Sun, Jul 30, 2023 at 03:10:46PM +0300, David Heidelberg wrote:
>> Resolves following warning:
>> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: mmc@30b50000: Unevaluated properties are not allowed ('power-supply' was unexpected)
>> 	from schema $id: http://devicetree.org/schemas/mmc/fsl-imx-esdhc.yaml#
>>
>> Cc: kernel@puri.sm
>> Cc: Guido Günther <agx@sigxcpu.org>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> index b3549eae6278..a8b5da3ca08f 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> @@ -1031,7 +1031,7 @@ &usdhc2 {
>>  	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>>  	bus-width = <4>;
>>  	vmmc-supply = <&reg_usdhc2_vmmc>;
>> -	power-supply = <&wifi_pwr_en>;
>> +	vqmmc-supply = <&wifi_pwr_en>;
> 
> From the schematics WIFI_PWR_EN connects to the Wifi card's `W_DISABLE`
> so I don't think vqmmc is correct here. I wonder if there's a better way
> to model that in DT? Any suggestions would be welcome.

I think mmc-pwrseq is what you are after.

Cheers,
Ahmad

> 
> Cheers,
>  -- Guido
> 
>>  	broken-cd;
>>  	disable-wp;
>>  	cap-sdio-irq;
>> -- 
>> 2.40.1
>>
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

