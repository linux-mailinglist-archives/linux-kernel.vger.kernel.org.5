Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A027E275B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjKFOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjKFOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:44:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96869B6;
        Mon,  6 Nov 2023 06:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699281830; x=1699886630; i=linosanfilippo@gmx.de;
        bh=hEXmBjzYmq+iyTpBkbCwl1Phma6+Z7uaRav85K2TYII=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Wa1jJXjCpBAzAHhS65MjWQJmAzReYR+wfA6o6bDKak17EWsN2DQetWOHkmklSPoe
         l39oZ9ovBlxNlBfONw2e65BwNgUiiBWFZCYug7kusXSqj8XfbJYP9tFu1faM9s3Gl
         BRGvHV4avTPJAMjhwmCzCAIPDTcGqvwsazWdH1ViLx0sLQs0pcDEpLcqVw2B5F6Bb
         m+OgLgqnHm+mbryMblL/dJuCsEGBiqTvHGngRtvONfouFNRNGCAVTA9bgfdzcJFum
         1fphMALn8qnZagm6VMHZ38fuXDGXDylk8E0uAak8uc5QhBGuaREkmLWYOMWY9IITo
         /aMvqkin2+c0K7Nx5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1qyLs41MRm-002lUq; Mon, 06
 Nov 2023 15:43:50 +0100
Message-ID: <3fc18b13-fef0-439e-abf0-1fe4e46b224a@gmx.de>
Date:   Mon, 6 Nov 2023 15:43:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Content-Language: en-US
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
 <0d203024-ba5c-4258-b549-b9304622978b@gmx.de>
 <ZUiTkyZSbbmTUGYQ@moxa-ThinkCentre-M90t>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <ZUiTkyZSbbmTUGYQ@moxa-ThinkCentre-M90t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DJf+fGVHnv4vAYJP+DKZ9MaNmbBkIQbu7i1QwzdmM725Oc6M4jP
 6a3Pz4/Oh78eImtiHPw4OqVQRTBNQtFS9SARTbrkREGKoF2vJr+n0P2dw96UgFf5UpAsBwp
 iR3zsdpAYQKxmxlcazr9d2j8/6DjQayXELYQfpgtUtfqV2QwHdmXgNCRIqEGGiSHz4HpwwP
 KxsUOx1giGJs6MDWYFLkQ==
UI-OutboundReport: notjunk:1;M01:P0:a6hp+FgPuPc=;zNAvda4tm4/qzcEdzNqKn7OrzHP
 TNL3MTY5/bhIj7weNVx6nutq2npUNjczo8RMSkyGydmdFCIHmkVHTUaC1ujzdrbRqENtHXgyT
 ennODDzwDjhIepwMJbX193egpyZnki8Z6ArV76LuEt19iPKNJekntbQ1r6rWEnhpd1Slx1lKZ
 XxKj1JSd8gcMnfo2oaThbmcaXoPr/g56y+uQF+lyE60nP3umprQ3aSPh/oISYFJAp/F1wBUmE
 +kwaS0B95FKsmh43bAki/B/FWnK7QC/nBIKIlPXzwcbmcY7f8AfIiiRWq6FnKLnwuDlfd+6fv
 3p0oV58+U2HAkEMxu9AWh3wIi6niLcnRTgHhFex17AWItCrlq1uT5fqDcA893oA/dbKBvY3fx
 39eG0RItmxAcCAxC7ev0M842Rf62MnGYjg38vwlNQ8cyahp1xp+WXz+VtPZceZQ/vmc+DulvK
 Qp44UKCVjz0aDKTYwAR7+jxH0VBryys5by9ys8BAPlFH0b0b/4y7mU87EqHFPEvmhY1rLldGh
 Su5Bv9ssSUAyrnLBJSGm4kgfipl/Z2dswywaIk490tBKhtSQ1NvTDTHepYND5BfHFWEsllcyR
 uimtPYGNqr1bxBWLZ8Om0wx02Fb/x6CMhMc2DdC0npnWnm4iTjjMItMiZSM5pazoPkOVnsWMg
 ek30GxiKQgdlzYNYrjuH/RZEhq+PL+6yY3VS7zG+5g1lgQyvoEwLBefFHO1CgU/hs+ZodKu+L
 te7y3I4kFMk2wkMvN+VyRacvCDjeQazjr2XTELFYUzJyY0qVMIzWPYDRynCgXFa3H/5im6bA0
 rzUBafxVIGMhcmqJaVz+2aK1/jTnGuWiZFI2MndVu8Xmw9O9Yx7Ne/8/bD8BynKTFw53qJ4Th
 Pr+WCMzDLAVI6GwAz2gedHkgQECqMFVgdi7cp0eX/R9D3F1kJnriYKjnJptZ4t7gs+q372Ej7
 8g6SCA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06.11.23 08:19, Crescent CY Hsieh wrote:
> On Sat, Nov 04, 2023 at 08:53:18PM +0100, Lino Sanfilippo wrote:
>> On 01.11.23 07:44, Crescent CY Hsieh wrote:
>>> @@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct =
uart_port *port, struct serial_rs4
>>>  {
>>>  	u32 supported_flags =3D port->rs485_supported.flags;
>>>
>>> -	if (!(rs485->flags & SER_RS485_ENABLED)) {
>>> +	if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {
>>>  		memset(rs485, 0, sizeof(*rs485));
>>>  		return;
>>>  	}
>>>
>>> +	/* Pick sane setting if the user enables both interfaces */
>>> +	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENA=
BLED) {
>>> +		dev_warn_ratelimited(port->dev,
>>> +			"%s (%d): Invalid serial interface setting, using RS485 instead\n"=
,
>>> +			port->name, port->line);
>>> +		rs485->flags &=3D ~SER_RS422_ENABLED;
>>> +	}
>>> +
>>> +	/* Clear other bits and return if RS422 is enabled */
>>> +	if (rs485->flags & SER_RS422_ENABLED) {
>>> +		memset(rs485, 0, sizeof(*rs485));
>>
>> Why are all flags cleared but SER_RS422_ENABLED?
>
> IMO, RS422 and RS485 are distinct serial interfaces. Therefore, when
> RS422 is enabled, the other RS485 flags should be cleared, and vice
> versa.
>
>>> +		rs485->flags |=3D SER_RS422_ENABLED;
>>> +		return;
>>> +	}
>>
>> What about all the other code places that check for SER_RS485_ENABLED?
>> For example uart_update_mctrl(), uart_suspend_port() and uart_resume_po=
rt() check this flag
>> to decide whether to set the modem control lines or not. Should this no=
t also apply to
>> SER_RS422_ENABLED?
>
> After reviewing the code in serial_core.c, there are actually some codes
> that check for "SER_RS485_ENABLED" flag before setting the modem control
> lines.
>
> It also appears that these codes can only be done when disabling RS485.
>
> So yes, I will apply "SER_RS422_ENABLED" flag to these locations in the
> next patch.
>
>>
>> Maybe it would be better to change the meaning of the flag: Instead of =
being a substitution for
>> SER_RS485_ENABLED, it could be used to mark a special mode.
>> So if both SER_RS485_ENABLED and SER_RS485_MODE_RS422 are set it would =
mean that we have RS422.
>
> RS422 is not a mode of RS485, so I think using two flags to represent
> them is much more reasonable, even though they are both included in the
> "struct serial_rs485".

Yes, RS422 is not a mode of RS485, but you are already using the rs485 (an=
d not a rs422) structure.
And treating RS422 as a different mode in the existing code would make thi=
ngs much easier and keep the code
clean. For example you would not have to alter all the code places that ch=
eck for SER_RS485_ENABLED.
Also SER_RS485_ENABLED and SER_RS422_ENABLED would have the exact same eff=
ect, so why use two
different flags, when the effect is the same?

Regards,
Lino

