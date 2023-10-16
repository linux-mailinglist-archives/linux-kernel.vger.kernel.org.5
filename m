Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC87CA4DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjJPKKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjJPKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:10:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78883;
        Mon, 16 Oct 2023 03:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697451004; x=1698055804; i=linosanfilippo@gmx.de;
 bh=L341XeVnPnSSuucfm8gEM6lOvZc0P3FGdj7nOTjmjP0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eXaOxyLFxAGAmIPbSlWvS9Bv1nAhEXirTAfedxV0wnRi8P7xz8AaPmqM71ycA1GCnrju3xpGwM1
 rbL+eKHVbeHqGyrbhHCkeAiyALJIzNV7e9td5PuaEq6P6tkL/oTlFXkz1jCHIsnpnElfZbULS2Usl
 jnDvZOcdKkb5mzmTyfuTKGMegpieifthwDQ9u91tvy/6i2NRLdvx0/HoeiY/sMAkBXJMIalDtbdRj
 dYBX/MHBUSp6lSCw0cCpfsGXXFOcAfuUdw8sJEXNt4oL7JYIQ7DFptpSsmn5CrYQMglMu25bTbyKU
 k6WHs73nVAFK+RWL9yf6Wa75msyGPzqbZa7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1rB6uW2DoS-00PLxj; Mon, 16
 Oct 2023 12:10:04 +0200
Message-ID: <ac48dd6e-5f08-4372-ba2e-2f161978f1f3@gmx.de>
Date:   Mon, 16 Oct 2023 12:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] serial: core: fix sanitizing check for RTS
 settings
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
 <20231011181544.7893-4-l.sanfilippo@kunbus.com>
 <40e4c6b1-e217-2926-a351-bf685a5b775f@linux.intel.com>
 <da9a9d10-2568-4960-b9f8-9d43cbc1b295@kunbus.com>
 <63b62f6c-d97d-8d45-1612-968ef74b6365@linux.intel.com>
 <b06c2fcd-02c0-464b-a7e8-4dfbf9e2befc@gmx.de>
 <fe473887-3aa0-9a32-53d2-a39ce5247ccb@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <fe473887-3aa0-9a32-53d2-a39ce5247ccb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORhRzJZg8wY+08udyEK6cZ6i8r27p6VIpt3xbEERnKIeMBztY8t
 2IRl3nfjg12x/y5MYwmyHa4vksWyfUl3cye0ErrBEp3sdPB6NDCZ+EwdBWebzB9ztzxr7SF
 sWAhHJSKVxnwL58cIp7AmH0LLp4t3E/hb8v5L0Ohg1b+APxLhEhOsR0sYH2Pl29U72xMsMM
 WtYnEgZ7RANqv/02t2HKw==
UI-OutboundReport: notjunk:1;M01:P0:7z5GCjWqsrQ=;IT40LDxHrpLISXGcwLqXM+1rw3F
 oIWc9qwWf9NG4KWL6mgxjs+h0Kx4r5J+LYOeHG978EJ4BHXNMRZisrFFfFIcYTK59mgGhQkv8
 L1pxDFYXztFR7qBJW4l7ZYSSAAnU2iM4EbWsTSTJfliifcOaaNToBcChAUUS9MA280WiP+GMr
 ZE5H5iuRqsmA5q5Z/SxIsMbPlkXaC/7KwXBMNbnFgmI90uk4pVBwhcOe1OlEEiqlKhYHPFv+D
 BTK2YG5jC+XQ2z/fOuGsKNZu3mvDkVb3pUvuyraQzFtvRLmCI3U5Nzn1G+ulyQjLyrjMjs3f8
 RU04us6qxlhULwhgTU7vRbDgkx7hpPMlaAi3/lx4nzccEL4rj+dDNgsaDVLWL4DR5ghV1Dh9X
 ZcxVIKe6N9+wPbbp8KB/w6tvJQ8tr5WqZtcSuPHaTlA4ClEaGpNMy/girVtKLXU0UzVMHVlVd
 UK6PtagIynUd2ppiG2o5qttRthMhCUu9PQxOABBigk9PdwOVNg9gBFD4N49EHhr+tWb45JAPQ
 XAatuoCPe3DgO9GisMC9EDeBPi2fw8TWEUtqfg1NWvO+ohHWI0lFuU/1SdjYHDuxLbLpUdcCT
 FpB5G+MDogLBwqNwwcWjlmmhZ7eODOfW53sh04OiWD0PIkD+gdMGtv52YQA+xgVXrzmHKyRFP
 pw7ks3uUE5K4/RD6ymEKQu12rpcRS8Tq3rqh8PowvhsCUGTQTCJh0Xf3JEJAgSo60/OpW7MOD
 kSaTIP4R6zJhQQalfgAcoa+iAfwzRO9+36KjGN9z7VMBtiOUsb2OCh6dneCcqU7aPIk//J4dw
 FEBeqxkdHW7KkpDvIEIcCA2hFy3awasbi/8ZBIh7dEELcB1ZzEMQfowR8HODD0oOWIrjsjHmP
 2vyIUTw1cFgc9ZJu4hh2SHb1cQdPnS+zW/d41xAdZDTONekVJPReMbB4lw9nC2MkajsYebazP
 K6gvvA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.10.23 12:05, Ilpo J=C3=A4rvinen wrote:
> On Sat, 14 Oct 2023, Lino Sanfilippo wrote:
>> On 13.10.23 12:24, Ilpo J=C3=A4rvinen wrote:
>>> On Thu, 12 Oct 2023, Lino Sanfilippo wrote:
>>>> On 12.10.23 15:10, Ilpo J=C3=A4rvinen wrote:
>>>>> On Wed, 11 Oct 2023, Lino Sanfilippo wrote:
>>>>>
>>>>>> Among other things uart_sanitize_serial_rs485() tests the sanity of=
 the RTS
>>>>>> settings in a RS485 configuration that has been passed by userspace=
.
>>>>>> If RTS-on-send and RTS-after-send are both set or unset the configu=
ration
>>>>>> is adjusted and RTS-after-send is disabled and RTS-on-send enabled.
>>>>>>
>>>>>> This however makes only sense if both RTS modes are actually suppor=
ted by
>>>>>> the driver.
>>>>>>
>>>>>> With commit be2e2cb1d281 ("serial: Sanitize rs485_struct") the code=
 does
>>>>>> take the driver support into account but only checks if one of both=
 RTS
>>>>>> modes are supported. This may lead to the errorneous result of RTS-=
on-send
>>>>>> being set even if only RTS-after-send is supported.
>>>>>>
>>>>>> Fix this by changing the implemented logic: First clear all unsuppo=
rted
>>>>>> flags in the RS485 configuration, then adjust an invalid RTS settin=
g by
>>>>>> taking into account which RTS mode is supported.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Fixes: be2e2cb1d281 ("serial: Sanitize rs485_struct")
>>>>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>>>> ---
>>>>>>  drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++----------
>>>>>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/=
serial_core.c
>>>>>> index 697c36dc7ec8..f4feebf8200f 100644
>>>>>> --- a/drivers/tty/serial/serial_core.c
>>>>>> +++ b/drivers/tty/serial/serial_core.c
>>>>>> @@ -1370,19 +1370,27 @@ static void uart_sanitize_serial_rs485(stru=
ct uart_port *port, struct serial_rs4
>>>>>>               return;
>>>>>>       }
>>>>>>
>>>>>> +     rs485->flags &=3D supported_flags;
>>>>>> +
>>>>>>       /* Pick sane settings if the user hasn't */
>>>>>> -     if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_A=
FTER_SEND)) &&
>>>>>> -         !(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
>>>>>> +     if (!(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
>>>>>>           !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
>>>>>> -             dev_warn_ratelimited(port->dev,
>>>>>> -                     "%s (%d): invalid RTS setting, using RTS_ON_S=
END instead\n",
>>>>>> -                     port->name, port->line);
>>>>>> -             rs485->flags |=3D SER_RS485_RTS_ON_SEND;
>>>>>> -             rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
>>>>>> -             supported_flags |=3D SER_RS485_RTS_ON_SEND|SER_RS485_=
RTS_AFTER_SEND;
>>>>>> -     }
>>>>>> +             if (supported_flags & SER_RS485_RTS_ON_SEND) {
>>>>>> +                     rs485->flags |=3D SER_RS485_RTS_ON_SEND;
>>>>>> +                     rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
>>>>>>
>>>>>> -     rs485->flags &=3D supported_flags;
>>>>>> +                     dev_warn_ratelimited(port->dev,
>>>>>> +                             "%s (%d): invalid RTS setting, using =
RTS_ON_SEND instead\n",
>>>>>> +                             port->name, port->line);
>>>>>> +             } else {
>>>>>> +                     rs485->flags |=3D SER_RS485_RTS_AFTER_SEND;
>>>>>> +                     rs485->flags &=3D ~SER_RS485_RTS_ON_SEND;
>>>>>
>>>>> So if neither of the flags is supported, what will happen? You might=
 want
>>>>> add if after that else?
>>>>>
>>>>
>>>> I would consider this a bug in the driver, as at least one of both mo=
des
>>>> has to be supported. If the driver does not have at least one of both=
 flags
>>>> set in rs485_supported.flags we could print a warning though. Would y=
ou prefer that?
>>>
>>> 8250_exar.c needs to fixed then?
>> I was taking these as things one can
>>> "configure" even if when there's support only for a one of them there'=
s
>>> not that much to configure. As there was neither in 8250_exar's code, =
I
>>> didn't add either flag.
>>
>>> But I suppose your interpretation of those flag makes more sense.
>>
>> IMHO this is consistent with what we have in uart_get_rs485_mode(). Thi=
s function
>> ensures that we have at least one RTS mode set (with default to RTS_ON_=
SEND). So
>> concerning 8250_exar.c, I think it should be fixed (havent noticed the =
missing
>> RTS mode though until you mentioned it). Would you like to provide a fi=
x for this
>> or shall I include one into the next version of this series?
>
> Just create that fix yourself thank you and include it into your series,
> I'm busy with other stuff currently.
>
>

Sure, will do.

BR,
Lino
