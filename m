Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D2760C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGYHpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjGYHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C03DB;
        Tue, 25 Jul 2023 00:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85FEA612BF;
        Tue, 25 Jul 2023 07:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6960C433C9;
        Tue, 25 Jul 2023 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690270992;
        bh=C79oRJdKDgbX+Aim3ZSqIUlOwH5qfGIJsUWSdBmA2dw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XUbElce4oGgSg0gzhnR5ZYQCFOf+EUxO/rPAhY5LCtYUUeuz+jvUPZhNQRrQrAK9Y
         OnSFHRs3nFfIFUBc3gVWKB3SKHMg4gkyNSeKAeYui1MTfUazeEsCGDFGoTtsReBcS2
         jOzH+iCfDyvca2ZgEE/7Zhp6RJ1i3P0mq4lyQuiby86YIPQQC+g7FLZJfIwt++ui+v
         7pmu7QcXvW46dYudDCMWyaCNlF43DlbHxR5/LUZgIXyIUT66yEfr7WF/GlUtnWPcJD
         AuP4OSza7nPPBmJBHCvs+7IRWRywx1QEyCtp8PXl6l/dbmdvomqyxLYFZDw/tUPY6n
         6ljvRNjpJWKsA==
Message-ID: <dd800ec2-684a-d6fc-2fb3-d146b95a8370@kernel.org>
Date:   Tue, 25 Jul 2023 10:43:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Enable dual role support
 for Type-C port
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230724115133.2226-1-r-gunasekaran@ti.com>
 <c907c3aa-84b8-c667-e8ea-dd7e5bd4a54b@linaro.org>
 <1fed3f09-75e4-bb44-71d7-f7319f1b0c3c@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1fed3f09-75e4-bb44-71d7-f7319f1b0c3c@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2023 07:19, Ravi Gunasekaran wrote:
> 
> 
> On 7/24/2023 7:27 PM, Krzysztof Kozlowski wrote:
>> On 24/07/2023 13:51, Ravi Gunasekaran wrote:
>>> USB0 is interfaced with a Type-C DRP connector and is managed via a
>>> USB PD controller. Add support for the Type-C port with dual data
>>> and power sink role.
>>>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 33 +++++++++++++++++++++++++
>>>  1 file changed, 33 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>> index d2cca6182738..b478b794de00 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>> @@ -226,6 +226,24 @@
>>>  	pinctrl-names = "default";
>>>  	pinctrl-0 = <&main_i2c0_pins_default>;
>>>  	clock-frequency = <400000>;
>>> +
>>> +	typec_pd0:tps6598x@3f {
> 
> Thanks for reviewing the patch.
> 
>> Missing space after:
> 
> I will fix this in v2.
> 
>>
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Thanks for pointing to the section. I checked it and also few other node names
> in the existing DTs.
> TPS6598 is a USB Type C and Power Delivery Controller. So does a node name
> "type-c-pd-controller" sound fine?

Type-c is irrelevant in node name.
The name needs to indicate it has something to do with USB, Power Control and Role control.

e.g.
usb-power-controller
or
usb-role-controller
?

> 
>>
>> Best regards,
>> Krzysztof
>>
> 
> Regards,
> Ravi

-- 
cheers,
-roger
