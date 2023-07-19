Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA987597D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGSOM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjGSOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:12:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725818E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:12:54 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qM7v0-0003wX-PC; Wed, 19 Jul 2023 16:12:42 +0200
Message-ID: <6ecf92b7-32a2-efdf-74f2-a737a44cb05c@pengutronix.de>
Date:   Wed, 19 Jul 2023 16:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: imx8mp: use correct clock for eqos
 timestamping counter
Content-Language: en-US, de-DE
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        patchwork-jzi@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230719-imx8mp_enet_qos_use_125mhz_clock-v1-1-782c9ac6e121@pengutronix.de>
 <CAOMZO5AP1zDQPGnctq+UbPSiv+7Rg=DGABb7-mZV__HZ4qpMBQ@mail.gmail.com>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <CAOMZO5AP1zDQPGnctq+UbPSiv+7Rg=DGABb7-mZV__HZ4qpMBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 7/19/23 16:03, Fabio Estevam wrote:
> Hi Johannes,
> 
> On Wed, Jul 19, 2023 at 10:59 AM Johannes Zink <j.zink@pengutronix.de> wrote:
>>
>> The i.MX8MP Reference Manual rev 1 06/2021, section 11.7.2.5 "Timestamp
>> Support" indicates the PTP timestamp clock expects a typical frequency
>> of 125MHz.
>>
>> As this also improves the precision of the measured timestamps: assign
>> appropriate 125MHz Clock parent. As no one except the timestamping
>> counter uses this clock, there are no side-effects of this change in
>> other peripherals.
>>
>> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index 6f2f50e1639c..7f80dff914c2 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -1334,7 +1334,7 @@ eqos: ethernet@30bf0000 {
>>                                                    <&clk IMX8MP_CLK_ENET_QOS_TIMER>,
>>                                                    <&clk IMX8MP_CLK_ENET_QOS>;
>>                                  assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
>> -                                                        <&clk IMX8MP_SYS_PLL2_100M>,
>> +                                                        <&clk IMX8MP_SYS_PLL2_125M>,
>>                                                           <&clk IMX8MP_SYS_PLL2_125M>;
>>                                  assigned-clock-rates = <0>, <100000000>, <125000000>;
> 
> Shouldn't this also be changed to:
> 
> assigned-clock-rates = <0>, <125000000>, <125000000>;
> 

good catch, thanks! Gonna fix it in v2.

Best regards
Johannes

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

