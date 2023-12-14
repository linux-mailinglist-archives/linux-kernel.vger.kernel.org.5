Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C84813273
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573407AbjLNOE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjLNOEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:04:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078889C;
        Thu, 14 Dec 2023 06:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702562668; x=1703167468; i=linosanfilippo@gmx.de;
        bh=dAalFO3VhKWZpswc6qLS4x3nxxwLUEFecgralPeJfrM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=LtUR21Xi3ZppYxgG9lAv3k1I71ROCcABzxj2puBQD8p31R2i16YWbznbJiz8WACl
         xyRBk1f5dWADpByLCMNDYMMPNO2yPsg8BXEK3MU2LNadIK0QzsS6shyLAR5/5XLEt
         30fiH4i4dg+XQKavrcD+nhmAkO1UiyZ8N1jtKReVGELQeeAf1o7cRI/5V0ui4hRsU
         aIHRa+e8PpiquiGdpuHoduTQL+xmn6DpIS5ueGlU0pvXdbLaJ4/mDyYBKUY0cl76/
         3ZOg0b8nmnN7nP69TqJivJiXgBEeF3bkTPy93ioVpDS/1TXvhxG4fqpP11q/gk0ka
         PKH7o6dfxULJD8x/lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.26.138]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1rnwUQ4BhF-00am5W; Thu, 14
 Dec 2023 15:04:28 +0100
Message-ID: <ed087928-43ac-42bc-8e4d-d1632db451b9@gmx.de>
Date:   Thu, 14 Dec 2023 15:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
        Tomas Paukrt <tomaspaukrt@email.cz>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
 <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
 <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XajtO+TgFw3w4zcM4aW2nykJ72BrrtZqlxyDwiW0z1F4eFBF0ms
 3WOaMLOaiaKV5w6o3fsxiAcgOuAKoEA/gXx1YWP+l3BdbRV6b5XrgGcAASPYYnyry1zU6zr
 mq1Btvko2CJJVv3yEyjOG/zn0bjxKT5YAaG4D+GTxQn2GdE5faF6n9pIabnSsKzSSyU+Y9U
 zvONFtH43A42I//brEZbQ==
UI-OutboundReport: notjunk:1;M01:P0:8PC0DGuaGXc=;UDjHXQiHIwzAHNyRQxmBwsl+uhv
 6kOPjT1rl3JIOjFSWKuNaI2g/F7p6couwsZzqyckVF+vdco1fYSHNmg1pPNa5GE0EX/lYNGx+
 r+KXEE3wkH1FmcRlRD3lOXLIFclWuUWHkgv+cLWFKMEGNdC7+VRsU+LgB/gJsHCED1m/jUjM8
 Ofwg4fdmqvFJM8kcijI9EtLPCSGcb6QBZNKADPnUbFJ+njaKcD8cTQt5C+a62Wr+PR2qtN2Rq
 rH7LPb4Ar2SmpuVSIT0DJa4FOqk0C3VlGTTMleBogkY9TgwtUE2CnF16nWJEXV5XExMCoI1Zq
 kcf8skhBJfdvw6wesonZUWqs36+A/nV1XrYTOqDfCGPx83+2bjYr7Mj77iuPCSKX5ZC3PVef9
 ISw04F6uf2sm4SjXK8Jgx1OJzdQ1y76rbO6Ra2R5hqDCXgEyrOaIlU4JEDL5uaOTlgoM0VWhj
 rUOpX6Uf6J8jLUQiz+85zxKA/1s4iVe4yvuwhIkcaug8PtaEcpyXD1BdicNmiwW3rQwGFWsMR
 /DTSIW5iAAzLd5C2vQUfD0pqpodlSi2AZ3g3YUeUuzMquilDZaGJ+0vJia0xWsUc2yhqeahp0
 i6nx6nkHE8STd4oow6MMHPF0cW11j55Jre8inGrmc9balOd/JAMBLL/lcPK3PlUzUONETJYOz
 NWavm5HNMH/X7RHLM1Sax6uF1R/2uwsNDWdQ1W0tT+LJpZ14BcZdI2XJnGQ2ZvyltHa/2JVeG
 VKlrVYgirwQlKGLVR8DKl5Cv9nxvE2jnaxOk/5yW9WzXP1f5nteMDlofLFQWF4o/BRLR8eUOs
 E3zqkxy2yT00IRA/PqnswulBvWC+r+PjXyqEc4ghDE3gcFxga1f2WzMfB8B3LnPEzEFGO10BV
 SznzdzlE14g90UscnrWD+Hf+p5/2WTEaTW7FK+yla8UJ5+zOPMRJj2h5TGl47cqpdJedLopyy
 hgziSQ==
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

On 14.12.23 14:41, Christoph Niedermaier wrote:
> From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Sent: Thursday, December 14, 2023 11:25 AM
>> On Mon, Dec 11, 2023 at 03:07:59PM +0200, Andy Shevchenko wrote:
>>> On Sat, Dec 09, 2023 at 12:47:47PM +0100, Lino Sanfilippo wrote:
>>>> On 06.12.23 16:42, Lino Sanfilippo wrote:
>>>
>>>>>>>> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mo=
de bit
>>>>>>>> to struct serial_rs485:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsi=
eh@moxa.com/
>>>>>>>>
>>>>>>>
>>>>>>> That new flag was suggested by me instead of using SER_RS422_ENABL=
ED, which
>>>>>>> would mostly be redundant to SER_RS485_ENABLED.
>>>>
>>>> A cleaner solution would probably be to not handle RS422 with the RS4=
85 settings at
>>>> all, but to introduce another set of ioctls to set and read it.
>>>>
>>>> An own RS422 structure like
>>>>
>>>> struct serial_rs422 {
>>>>     __u32   flags;
>>>> #define SER_RS422_ENABLED           (1 << 0)
>>>> #define SER_RS422_TERMINATE_BUS             (1 << 1)
>>>> };
>>>>
>>>>
>>>> could be used as the parameter for these new ioctls.
>>>>
>>>> Any comments on this?
>>>
>>> I have (maybe not so constructive) a comment. Please, at all means try=
 to not
>>> extend the existing serial data structures, we have too many ones with=
 too many
>>> fields already. For user space, though, one may use unions and flags, =
but for
>>> internal ones it might be better ways, I think.
>>
>> How about revising the name of 'TIOCSRS485' and 'serial_rs485' to a
>> general one, and put RS422 and RS485 configuration flags into that
>> structure?
>>
>> So that in userspace it could set RS422 or RS485 configurations using a
>> single ioctl command and one structure.
>>
>> In this way, it won't be confused in userspace and won't add new data
>> structure internally as well.
>>
>
> I will summarize the current situation from my point of view, maybe it h=
elps:
>
> RS-232:
>   - Full Duplex Point-to-Point connection
>   - No transceiver control with RTS
>   - No termination
>   - No extra struct in use
>
> RS-422:
>   - Full Duplex Point-to-Point connection
>   - No transceiver control with RTS needed
>   - Termination possible
>   - Extra struct serial_rs485 needed if termination is used
>  =3D> RS-422 can be used in RS-232 operation, but if a termination shoul=
d be
>     switchable the RS485 flag has to be enabled. But then also transceiv=
er
>     control will be enabled. Not a very satisfying situation.
>

Thats why I vote for a  RS422 mode.

> RS-485 (2-wire) very common:
>   - Half Duplex RS-485 bus
>   - Transceiver control with RTS is needed
>   - Termination possible
>   - Extra struct serial_rs485 is needed
>  =3D> RS-485 has to be enabled and configured:
>     - Set SER_RS485_ENABLED
>     - Set SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND
>     - Set/clear SER_RS485_RX_DURING_TX depending on whether
>       the receiver path should be on or off during sending.
>       If it's set it allows to monitor the sending on the bus
>       and detect whether another bus device is transmitting
>       at the same time.
>     - Set/clear SER_RS485_TERMINATE_BUS for bus termination.
>
> RS-485 (4-wire) little used:
>   - Full Duplex RS-485 bus
>   - Transceiver control with RTS is needed
>   - Termination possible
>   - Extra struct serial_rs485 is needed
>  =3D> RS-485 has to be enabled and configured:
>     - Set SER_RS485_ENABLED
>     - Set SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND
>     - Set SER_RS485_RX_DURING_TX, as the receiver should always
>       be enabled independently of TX, because TX and RX are
>       separated from each other by their own wires.
>     - Set/clear SER_RS485_TERMINATE_BUS for bus termination.

How can the driver distinguish between RS485 full duplex and half duplex t=
hen?
In full duplex RTS control is not needed AFAIU.

>
> I think the GPIOs reflect the flag states and are meaningful:
> - SER_RS485_TERMINATE_BUS: Switch bus termination on/off by GPIO
> - SER_RS485_RX_DURING_TX:  Used to enable/disable RX during TX
>                            in hardware by GPIO (for 2-wire)
> - SER_RS485_ENABLED:       Muxing between RS-232 and RS-485 by GPIO
>
> Switching RS-485 on during boot could also be handled by a devicetree
> overlay. Evaluate the GPIO and load a DTO accordingly before booting.
>
> Please correct me if I have misrepresented something...
>
> If I looked at it in this new way, I would discard my idea with the
> FULL_DUPLEX and HALF_DUPLEX. For a better use of RS-422 it would be
> good to disable transceiver control via RTS. It can be done by clearing
> the existing flags SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND
> at the same time, but I think it is confusing. Better would be a flag
> for RS-422:
>
> RS-422:                     Set SER_RS422_MODE for disabling
>                             transceiver control via RTS.
> RS-485 (2-wire and 4-wire): Clear SER_RS422_MODE for enabling
>                             transceiver control via RTS.
>
> Finally, at present it is also not possible to distinguish between RS485
> 2-wire and 4-wire operation. I think it isn't necessary, as different
> hardware has to be used anyway. The hardware then determines the
> configuration, see above.

But the driver should somehow be informed that there exists a full
duplex hardware setup, so that it does not need to control the RTS line.
Maybe by means of a device tree property?

Regards,
Lino


>
>
> Regards
> Christoph
