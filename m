Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5327751C16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjGMIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjGMIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:47:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D010E2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:47:17 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qJryd-0001kt-QA; Thu, 13 Jul 2023 10:47:08 +0200
Message-ID: <d72b2806-c4b0-50ef-98ea-7f06c47b1c6a@pengutronix.de>
Date:   Thu, 13 Jul 2023 10:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: net: fsl,fec: Add TX clock controls
Content-Language: en-US
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, Wei Fang <wei.fang@nxp.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
References: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
 <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
 <006f9599-6aa4-52ac-068a-831893ec6bf8@linaro.org>
 <49bf4392-299f-cb4b-ef4b-f920faa65866@vaisala.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <49bf4392-299f-cb4b-ef4b-f920faa65866@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vesa,

On 13.07.23 10:29, Vesa Jääskeläinen wrote:
> Hi Krzysztof,
> 
> On 12.7.2023 23.36, Krzysztof Kozlowski wrote:
>> On 11/07/2023 17:08, Vesa Jääskeläinen wrote:
>>> With fsl,fec-tx-clock-output one can control if TX clock is routed outside
>>> of the chip.
>>>
>>> With fsl,fec-tx-clk-as-ref-clock one can select if external TX clock is as
>>> reference clock.
>>>
>>> Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
>>> ---
>>>   .../devicetree/bindings/net/fsl,fec.yaml          | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
>>> index b494e009326e..c09105878bc6 100644
>>> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
>>> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
>>> @@ -166,6 +166,21 @@ properties:
>>>       description:
>>>         If present, indicates that the hardware supports waking up via magic packet.
>>>   +  fsl,fec-tx-clock-output:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description:
>>> +      If present, ENETx_TX_CLK output driver is enabled.
>>> +      If not present, ENETx_TX_CLK output driver is disabled.
>> Here...
>>
>>> +
>>> +  fsl,fec-tx-clk-as-ref-clock:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description:
>>> +      If present, gets ENETx TX reference clk from the ENETx_TX_CLK pin. In
>>> +      this use case, an external OSC provides the clock for both the external
>>> +      PHY and the internal controller.
>>> +      If not present, ENETx TX reference clock is driven by ref_enetpllx. This
>>> +      clock is also output to pins via the IOMUX.ENET_REF_CLKx function.
>> and here:
>> In general, Common Clock Framework and its bindings should be used for
>> handling clock providers and consumers. Why it cannot be used for these
>> two cases?
> 
> Did you have something specific in mind on how it could be modeled?
> 
> I tried to look at:
> Documentation/devicetree/bindings/clock/
> 
> But didn't spot anything for this.

This has been implemented for i.MX6Q/DL using CCF. Please follow suit
for SoloX. See series at:
https://lore.kernel.org/all/20230131084642.709385-1-o.rempel@pengutronix.de/

Thanks,
Ahmad



> 
> In net bindings:
> Documentation/devicetree/bindings/net
> 
> We have some similarities:
> 
> - adi,phy-output-clock
> - adi,phy-output-reference-clock
> - nxp,rmii-refclk-in
> - clock_in_out
> - ti,clk-output-sel
> - ti,sgmii-ref-clock-output-enable
> 
> In here clock output generator would be the i.MX not the PHY as what was in ADI's.
> 
> xMII variants are close but very specific for specific MII interface type.
> 
> clock_in_out seems a bit out of place.
> 
> Thanks,
> Vesa Jääskeläinen
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

