Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF77F41B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjKVJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjKVJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:32:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D975BD;
        Wed, 22 Nov 2023 01:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700645514; x=1701250314; i=eberhard.stoll@gmx.de;
        bh=uT3DiWkYEoghSYBnj8WpEqr9P/dHXYjlSbrLs5e+oE4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=TWRd0vfyuYd2jSITc+E6A4Bjav6lNPOHup/oMQ+Qr2YdakjGJLhq6FNJ8HEJiyZe
         +njO2CRANJLEAjnHhEIB6jGiVQRkYBtDoASmySE4Acso7vFVU86n0y8JfCuSgMX2W
         /noA+ZPGsB0E0R9q4qKDYejOOG+CkfrLHsL6IjJxe5OQKIrsjaXYbC3GWr/ff7iuL
         Is2VSaDJJY/bgBbTEcjDLQHrPtnYo4rIfu312un6AMqAon4UbZ2Jv3xRCszOLMerW
         oHCkereCcFzL8rF8pM9gN4kqGebgKRRMpOPdQPb9VMKOPxKXlfZv2E8NUtsUHLcto
         pwe07YW9R0TecMFSqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.6] ([77.246.119.226]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1rJ1BJ03Fb-00wBcq; Wed, 22
 Nov 2023 10:31:54 +0100
Message-ID: <1e9ac484-5764-496d-ab00-9690d9042c91@gmx.de>
Date:   Wed, 22 Nov 2023 10:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>, sherry.sun@nxp.com
Cc:     festevam@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        eberhard.stoll@kontron.de
References: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <dbe5959d-2b68-4f16-89ee-32538aab4f34@gmx.de>
 <5ad44085-c90b-4a88-bb7b-8ddc2b612793@prevas.dk>
Content-Language: en-US
From:   Eberhard Stoll <eberhard.stoll@gmx.de>
In-Reply-To: <5ad44085-c90b-4a88-bb7b-8ddc2b612793@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:urUipIHyWMNiNkozepuEn0gj24xVRoz68Bw0r3vm3ItKmKIcEyx
 RFPnhakqYTySES2PeacPlo0pJ4e1tF/PFSb9B5toU5BWGMYcPNRz6o/ZgY1REqxPfnVum/x
 iZvONmE5clELydTltLybodcPe6lenRP/+74G/OVImtGZLT2j3Hy6yXKuhHfudVHN3A80vII
 IcZw84D0lTOJqWOHWIeOQ==
UI-OutboundReport: notjunk:1;M01:P0:Xok3tUOxw2c=;3lXZGwwkRvCGRTyJEdEPP0+gM7G
 W4N+ft0emvZQMWVag/hBsaeuiovcL7FBRwrnWCi50LwWPi/tWAMhop46aCwnuUdPfFWK3tNGA
 Ql2AiICpN3cWF9grab30mgvq80Hed/23DFMJl5SqsRsW10GOTNsGmxF3mZF2PCp/3efq4ja2A
 V/4ckNgjH4XkS6P18oBa90BpitLNnqocraA9LxnO+8qJ8l2bDJOu/XZPBzJrYw+2vaYGtQLQv
 jsF5W/a425xSzBixFgtCQlSGyn3VejVUW/S6557DzQdDb7i/vNwO+wfDvGcxVx/h8THIjAs7e
 Ssv9+VgyBaJ2BCVSVkydcctt5v3VsIaR3ce0r+yKwGkVoZG+xxbmcMqT2MNGHWeKVzxSRXkm7
 Cynb6vrHByLC2uk8wdoSfLLhMg+mN50PLS2VTTLtJiSn0ZjZVlqowSem3G9mWJqW+nWEVOiWZ
 yvOYTRm2jRSkcWNWZ7tPRjCyxxb0qx8tbBWyjVVvlo7qEV1h6u0wmzo0D8w11FNDnqDqQY/oC
 mSlw7X5TLUg6rS466p5A9tgptVxwBD7Adva+Wbaq/vhMa/O2GpjwuaFgWipkfBqLWd7YxvW4E
 ncTF7bLcQSl13axaBP15+dgEmDCc99Y0xQQJA+QIeI/8wyxHIxXOu46T9aCo5Z8xqKakcilhX
 hAT5rhDJYfKwtrznixn3nVKLB+eMZa797FLWMhDPm3ostKh5b+Uz2h94wDkQ6RoA1WzSfjwqh
 TjawZxr+mSS4byC1sGmORxL0Bhnw1TQZry1KZXqhbfhenDXvPRm2U3DHWwwOobqMZ3kR91ejA
 rZNoQ7Oi11kexeUfkI97hG0ryPJZrjEEC0Um6Rp9rERmqOSO1cfJ3cfGCSKtRB2ODWV2ejsuR
 AFQeUwOHDOijaFhUXuNsBj885IO6cUdcLPkXTiCZo25qytZ1DfH+5XKw9PvC0m8QO+z2yS1/N
 qMRjl3y7PA1UyUl3ghS2Shcj+jQ=
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


>> i can observe a very similar situation, but with a litte different
>> configuration. This is how i can trigger the situation very quickly:
>>
>>  =C2=A0 1) open the port
>>  =C2=A0 2) send 1 byte out
>>  =C2=A0 3) close the port
>
> Hi Eberhard
>
> Thanks for chiming in. I assume this is all in rs485 mode, no switching
> to rs232 and back involved?

Yes, no mode switching is involved here. Only rs485 mode.

>> Setting ->tx_state =3D SEND in imx_uart_shutdown() helps for my issue
>> (and should be ok IMHO).
>
> [I assume you mean tx_state =3D OFF]. Yes, I suppose doing that would be=
 > ok, but I'm not sure it's a complete fix. In my simple test cast, I hav=
e

Oh, yes, sorry my mistake!
I really meant ->tx_state =3D OFF as you expected in your comment

> separate programs invoked to do the I/O and do the mode switch, but in a
> real scenario, I'd expect the application itself to just open the device
> once, and then do I/O and mode switching as appropriate for the
> application logic, and I don't think uart_shutdown would then ever get
> called.

Switching between rs232 mode and rs485 mode on an open port is a special
use case in my experience. But it's valid and introduces some extra
complexity. As you stated, for this use case setting ->tx_state =3D OFF in
imx_uart_shutdown() does not really help.

> Indeed, that's an extra complication. Adding two hrtimer_try_to_cancel()
> in shutdown would probably not hurt, along with setting tx_state OFF.
>
> I wonder if at least mode switching should simply be disallowed (-EBUSY)
> if tx_state is anything but OFF.

Seems there are various issues in ->tx_state handling and transmitter
timing in this driver!

Best Regards
Eberhard
