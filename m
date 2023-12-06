Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906898073E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379402AbjLFPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379298AbjLFPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:43:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F49C;
        Wed,  6 Dec 2023 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701877375; x=1702482175; i=linosanfilippo@gmx.de;
        bh=+B+LxkQRG0FiOkqsDobn6wzE6xjaBL4vaAVQMw/RddI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Q4FCK93fitK8Hyfkx8TOehhJ5pV8TlRKVhBIMgIwhQL1AGndt//rTz+3yD2CjJ+W
         WANqw0j/g9fuiRvd2W8OOIKFufe+6HQ3UHyk9SDjBNAaZ+1qDQ8H1d+xaQE8letFI
         UkHPE+AiIH65NFawHjrSjoLSikYuY1BDtCHzUWCpDWQFYHGeOP/M0SW5/mDeif062
         YTPNcajqFGlRqWiBh2VDnrtO2XPWMWY0dXWkiyjJzLChFbYvRjgop1F1uPBkeG1/Q
         Hr0sGDJgS57GdfJ/8VATa3KpxlW+1+bR+1TsI9DnIcfqQSlVGY4ZADnjSnMzfQPij
         TppaIgo4vK9cF8s0YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1rULwO24W7-00ss2t; Wed, 06
 Dec 2023 16:42:55 +0100
Message-ID: <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
Date:   Wed, 6 Dec 2023 16:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WinMUwLcoT/5jSdBB4YJ422Zl+vb7oDmXwC2HQTaW998KaH9ihI
 sqP+B8DEZ0UDmlB+It0Z7Hc3W+yoMA6Hx/3VoHu9+/fk5+CU8jIAjuiKnI1N7V85nuQrm7n
 JeuvISeJHy/9p0ZSIRfr8lueE3F8FZ4NnR+2NxWiP5pgqLF+vgH+5uvQqOrWzNaAdF3c0Xz
 1wiDvwKU9gyimDawVvk+Q==
UI-OutboundReport: notjunk:1;M01:P0:sEeYN/Oia54=;/26vZ9Qjn3UrFVNZctFBkMinSKI
 8ppq/pqC0e8SCYG9ASwVlsd6TFjdJ87r/wUyEOsE9ksNRAGHNM8Rf4FXCKz53/cgYD03/KoJ2
 HcFx3nR/utvFZytrF7gN35yskria+AdMf2YtGQzqPNlHwvA4/qp84lfSi8p53ez/4JX5iriDb
 0bRfDsjR+jKtc9F6DzLzX2m8D0VQtdZucnVsIfkM7KVqkz4woZrihphykJ4TJOVwd9u4h6PuC
 P+Xg0qT8iTKTJy6SBP5DNw5wjugyyevaziPCzc0MJuLWlLDRLB9YdeK6ra9qGUJ+y77F0jTro
 UABxctUFFc0ByF7gDt7PbwCdFfEL+959UAu5KzIEuSo8/xOhvzhUa5G/bEaNLKRKHyRG9aFkt
 GDXGbFnKSJvbbcQjycGilMYBofedT6eEbAkl9sUUb8CXyO6+NR8/UqauqClmJjT4jz5FXhI1o
 iLBrhGR+L//ll+TKZ4JYIUBMKSXhxaJKPshppbiRCahb8BC8KIVHvfz4FAwrqR7Zd0XUHW0qn
 nM+cT+saBIPG8cH7v8FkJgye6JT4iezILmxnPb5DF79uylIn0r25c1rzBeg8szM0OrKkLJq6m
 kEx82cc4fZEqcfPtgEscJJ8cXH5tTsm/6RRqo5Pgw2mZTg5q8Mmy1lA8jA4iKDkMUGhNBVY4q
 WnCqbt8db78d1v+ytSlmnQvi4E4PdrC4QFYH4cMNkqu+bKhQMlKkHDDZP/+2DZzDVwCu8lVhz
 B+8mLxm/8CNcefNs7dPqzw6btYkwDpLKK/a9Sg5yeV5zPWVrApqDSqvsuYd2jaJQEp23CP4Wi
 qpEvlzIEPQ5tT16+ud9YgdvXyHANnT5xQROlU5g1guXwOJ9SQuoMO8ZphM66Zzy/uSCjF4TLV
 ONRycyyjosSGei2JQ0hRCStbZmohGYar/U3Yfi9nAKGznUcRfr9+ypV3j7ud7RQbp65U8Ul+n
 Mpa+M0Dd9RNNIX5I1NctNJ0RAsY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 27.11.23 13:14, Christoph Niedermaier wrote:
> From: Lino Sanfilippo [mailto:LinoSanfilippo@gmx.de]
> Sent: Sunday, November 26, 2023 12:40 AM
>
> Hi,
>
>> On 22.11.23 at 15:53, Lukas Wunner wrote:
>>> On Mon, Nov 20, 2023 at 04:10:54PM +0100, Rasmus Villemoes wrote:
>>>> Some boards are capable of both rs232 and rs485, and control which
>>>> external terminals are active via a gpio-controlled mux. Allow
>>>> describing that gpio in DT so that the kernel can transparently handl=
e
>>>> the proper setting when the uart is switched between rs232 and rs485
>>>> modes.
>>>
>>> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode bi=
t
>>> to struct serial_rs485:
>>>
>>> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@mo=
xa.com/
>>>
>>
>> That new flag was suggested by me instead of using SER_RS422_ENABLED, w=
hich
>> would mostly be redundant to SER_RS485_ENABLED.
>> I dont know if it is a good choice in the long term to handle both mode=
s within
>> the RS485 configuration. It would be cleaner to have an own RS422 struc=
ture with
>> its own flags and properties. And until now the only flag that seems to=
 make sense
>> for both RS422 and RS485 is AFAICS SER_RS485_TERMINATE_BUS.
>>
>> On the other hand the bus termination is at least a property that both =
modes have
>> in common. And handling RS422 in its own structure would require anothe=
r ioctl
>> to set and get the the RS422 settings.
>>
>> But maybe there are more or better possibilities to handle RS4822 suppo=
rt. I would like to
>> hear other ideas.
>>
>>
>>
>>> I don't know whether that makes sense at all (I had thought RS-422 is
>>> the same as RS-485 with full-duplex, i.e. SER_RS485_ENABLED plus
>>> SER_RS485_RX_DURING_TX)
>
> With RS-485 full duplex, SER_RS485_RX_DURING_TX makes no sense to me.
> See below.
>
>>>
>>> But if that patch gets accepted, we'd have *three* different modes:
>>> RS-232, RS-485, RS-422.
>>
>> Actually we would have four (as Brenda already wrote,
>> see https://lore.kernel.org/all/c6ea912f-d5ab-4761-813d-3b6b6be141cb@ni=
.com/),
>> and with the propose SER_RS485_MODE_RS422 flag these modes would be use=
d like
>>
>> RS-232:                       rs485->flags =3D 0
>> RS-422:                       rs485->flags =3D SER_RS485_ENABLED|SER_RS=
485_MODE_RS422
>> RS-485 (2-wire half-duplex):  rs485->flags =3D SER_RS485_ENABLED
>> RS-485 (4-wire full-duplex):  rs485->flags =3D SER_RS485_ENABLED|SER_RS=
485_RX_DURING_TX
>
> In my point of view there are also two different modes for the RS-485 2-=
wire
> half-duplex bus depending on the flag SER_RS485_RX_DURING_TX.
> - SER_RS485_RX_DURING_TX is not set: The device doesn't see the bus duri=
ng sending
>                                      (RX is off during sending).
> - SER_RS485_RX_DURING_TX is set:     The device see want is on bus durin=
g sending
>                                      (RX is also on during sending), so =
you can
>                                      see your transmission and also if a=
nother bus
>                                      device is transmitting at the same =
time.
>
> On RS-485 4-wire TX and RX are separated by wires. So the definition of
> SER_RS485_RX_DURING_TX above makes no sense, because you can receive all=
 the time
> without worrying about TX. On the software side RS-485 4-wire full duple=
x it behaves
> like RS-232. So we don't need transceiver controlling by the RTS pin.
>> Basically for me the SER_RS485_ENABLED flag is to enable the RTS contro=
l for the
> transceiver. Maybe on software side we can distinguish between half and =
full duplex
> mode and whether RX is enabled during sending by the flag SER_RS485_RX_D=
URING_TX:
> RS-232:                          rs485->flags =3D 0
> RS-422 / RS-485 (4-wire):        rs485->flags =3D SER_RS485_ENABLED|SER_=
RS485_MODE_FULL_DUPLEX

How can we switch between RS485 (4-wire) and RS422 then? AFAIU they are no=
t the same. And even
if a driver behaves the same in both modes it needs to know when to switch=
 from one mode to the
other.

> RS-485 (2-wire NO RX_DURING_TX): rs485->flags =3D SER_RS485_ENABLED|SER_=
RS485_MODE_HALF_DUPLEX
> RS-485 (2-wire RX_DURING_TX):    rs485->flags =3D SER_RS485_ENABLED|SER_=
RS485_MODE_HALF_DUPLEX|SER_RS485_RX_DURING_TX

I think we can omit the SER_RS485_MODE_HALF_DUPLEX flag if we assume that =
a missing
SER_RS485_MODE_FULL_DUPLEX means half duplex (i.e. controlling the RTS lin=
e).

> SER_RS485_MODE_FULL_DUPLEX and SER_RS485_MODE_HALF_DUPLEX can be defined=
 at the
> same bit. If SER_RS485_MODE_HALF_DUPLEX will be defined as 0 it breaks n=
othing.
> With SER_RS485_MODE_FULL_DUPLEX, the RTS pin does not need to be control=
led
>
>>
>>>  A single GPIO seems insufficient to handle that.
>>
>> GPIOs for RS485 is another thing.
>>
>> I mean, currently we have a GPIO for RS485 termination (I introduced it=
 with commit
>> 44b27aec9d9680875).
>> Christoph introduced support for a rx-during-tx GPIO (see commit 163f08=
0eb717). Tomas
>> intends
>> to add a GPIO which enables RS485 if asserted
>> (see https://lore.kernel.org/all/3Za.ZZs%7D.ndXI8CMee4.1bN6eQ@seznam.cz=
/) and with Rasmus
>> patches
>> we are about to add a MUX-GPIO which is to be asserted if RS485 is enab=
led.
>>
>> I wonder where this will end and if we really have to support every pos=
sible GPIO
>> in the serial core.
>
> I think the GPIOs reflect the flag states and are meaningful:
> - SER_RS485_TERMINATE_BUS: Switch bus termination on/off by GPIO
> - SER_RS485_RX_DURING_TX:  Used to stop RX during TX in hardware by GPIO=
 (for 2-wire)
> - SER_RS485_ENABLED:       Muxing between RS-232 and RS-485 by GPIO
>
> Switching RS-485 on during boot could also be handled by a devicetree ov=
erlay. Evaluate the
> GPIO and load a DTO accordingly before booting.
>

Regards,
Lino
