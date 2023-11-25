Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4137F905A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 00:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYXkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 18:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKYXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 18:40:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A622A6;
        Sat, 25 Nov 2023 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700955609; x=1701560409; i=linosanfilippo@gmx.de;
        bh=SP2ucH5r5Gk6l2j+5rFElVMMInW0SpnmPF4xI/IwDj0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:
         In-Reply-To;
        b=V6p4UK7gc83syEEOnBaGBw9lFADuk+sWQohChmEK6WvkDETUiRSQaZ5KSCsIZocR
         MK23vO7gJdBzSfWsEq3GGTr9DdBCSVtp6+G7RDWlYhXkc1Q03yTVdWDhFhBVMB2DO
         DLv5/hVIREd7eIcG+SmuvxHXs/6E3QKTfGHVgVAZrLxKSk4i7gHXA1iZQ2A7/d1cx
         0x0cCw60xJTN43cRFHlnik97/fUqiAu778DvfjswGEVDPO0fEKNTvT7aVElXA14iG
         n58Tx5qvVtC44Wckii8PBfLMoALnXdCuRO6GM/VTNsZX3PX4qMucW95pjV94eDpeF
         52dyLqJonZb5Nr0KBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.180.3.177]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1rlbjR1zNM-00exK7; Sun, 26
 Nov 2023 00:40:09 +0100
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
To:     Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        brenda.streiff@ni.com, cniedermaier@dh-electronics.com,
        Tomas Paukrt <tomaspaukrt@email.cz>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
Date:   Sun, 26 Nov 2023 00:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20231122145344.GA18949@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:07zHm1TyCdV/+MnqDviThy3OX1Ef71ZtfO7wE5IGH7Hq4oN7q+t
 2lKYbOsDocv7AfpDI3evugvWmaMTGi04fYGqZ/7leh7DmDYTkcP57crLET5UfQvzylA1QmS
 RounC16PHjjcMwRi+q5altMwuK7TGYLcIIoB3AEvEfLVF2SgybEp6okwxR5ICNd4hubeZeO
 kc4HMpQNxfWKxMmvG77yg==
UI-OutboundReport: notjunk:1;M01:P0:ZInMyQRO+3o=;dTF6cGcRKSxrqhzmrjwN9Ahblyj
 37gS6WPx7o94qtr6i0w7Cacqcyt7J9YMXgNQutM0Wl5k3vuy1drPTFrGzsvTWFNxxsUuSOl5g
 r4PDepomjUsUw0STwz78iIUMOij2QWB/bhZ5f88l7awbzudXGqi/P12P2b9HGO229b5oxMKF5
 lC75SZ2VvyZCUiXXXgDGFcG8NwuxeS9dXE+MAP5L5K/bt+6VsXFO/1/fRg+OqOeLwX4OuGcPv
 cw/uxi700jQsW/chl68+CwL0iVBEJWn+treuXaDghxU/U1jYj7weLZPx2mDwUU5DQhPniSv5v
 9IjtM/rdAm3BSRE+Xeid4oAzK8ieEmK2iBwDeD6TbUU9TJ1owY9QSKmqgqjnOSoHprWyIaiWN
 sZf5hkPqY+4iMBxbw5OzN1lr1AI6ZdQn66asD177epJ8tSdSdDKSkXm31mP8ZT7Y03qQ1aBRM
 BJ+DcYi3RiHWAKvkCulrUXOki7lygIqGYcwwO/MfhPRoRO3WmiDsaki4CTEp61fQn+PgdFXXP
 vYQJ12sfAlSB27L+yNYVkobwZvlrCmdqomr8zY9e/lLaYKlmLm8YzJk2bPAkSPyOSjANG1G3x
 tYJ975ZzU2JW9KnwuvbC3B4z5zOq92gzEgwMmlMeb9OJ9k0YuuiY8OIJB9Tz/bgPEcMwN4qYV
 Fc+WiBgF7HV7o2+gROAigPQh2fUOLe6+vdckPlZbesW2NUazkk52o54VylUmG/V2rJeCuotYO
 LEdnx/PmRx61D7Et3K6/Gs5oJDWDWRF1US43h8DmVmhwEpGIWPaxmCHPK4DYzxVFCHQfJMmFX
 Hkcy5cz2T3k4ucwtybxT8rDqDt665pwCkoy/hVx9AynQ46ZD8deZ7SKAOTaQZUxYRr/kn2F2T
 aicbcef84LXnpSRoOFNIBEp5OmRiPJkUwyb93eqaLTMeTo+YXKOc2Z/YJl4Y359BWhhO8A2OF
 BTVjn2FlSo1HPqVPPx2GMr4/3u0=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22.11.23 at 15:53, Lukas Wunner wrote:
> On Mon, Nov 20, 2023 at 04:10:54PM +0100, Rasmus Villemoes wrote:
>> Some boards are capable of both rs232 and rs485, and control which
>> external terminals are active via a gpio-controlled mux. Allow
>> describing that gpio in DT so that the kernel can transparently handle
>> the proper setting when the uart is switched between rs232 and rs485
>> modes.
>
> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode bit
> to struct serial_rs485:
>
> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@moxa=
.com/
>

That new flag was suggested by me instead of using SER_RS422_ENABLED, whic=
h
would mostly be redundant to SER_RS485_ENABLED.
I dont know if it is a good choice in the long term to handle both modes w=
ithin
the RS485 configuration. It would be cleaner to have an own RS422 structur=
e with
its own flags and properties. And until now the only flag that seems to ma=
ke sense
for both RS422 and RS485 is AFAICS SER_RS485_TERMINATE_BUS.

On the other hand the bus termination is at least a property that both mod=
es have
in common. And handling RS422 in its own structure would require another i=
octl
to set and get the the RS422 settings.

But maybe there are more or better possibilities to handle RS4822 support.=
 I would like to
hear other ideas.



> I don't know whether that makes sense at all (I had thought RS-422 is
> the same as RS-485 with full-duplex, i.e. SER_RS485_ENABLED plus
> SER_RS485_RX_DURING_TX)
>
> But if that patch gets accepted, we'd have *three* different modes:
> RS-232, RS-485, RS-422.

Actually we would have four (as Brenda already wrote,
see https://lore.kernel.org/all/c6ea912f-d5ab-4761-813d-3b6b6be141cb@ni.co=
m/),
and with the propose SER_RS485_MODE_RS422 flag these modes would be used l=
ike

RS-232:                       rs485->flags =3D 0
RS-422:                       rs485->flags =3D SER_RS485_ENABLED|SER_RS485=
_MODE_RS422
RS-485 (2-wire half-duplex):  rs485->flags =3D SER_RS485_ENABLED
RS-485 (4-wire full-duplex):  rs485->flags =3D SER_RS485_ENABLED|SER_RS485=
_RX_DURING_TX


>  A single GPIO seems insufficient to handle that.

GPIOs for RS485 is another thing.

I mean, currently we have a GPIO for RS485 termination (I introduced it wi=
th commit 44b27aec9d9680875).
Christoph introduced support for a rx-during-tx GPIO (see commit 163f080eb=
717). Tomas intends
to add a GPIO which enables RS485 if asserted
(see https://lore.kernel.org/all/3Za.ZZs%7D.ndXI8CMee4.1bN6eQ@seznam.cz/) =
and with Rasmus patches
we are about to add a MUX-GPIO which is to be asserted if RS485 is enabled=
.

I wonder where this will end and if we really have to support every possib=
le GPIO
in the serial core.

Regards,
Lino

