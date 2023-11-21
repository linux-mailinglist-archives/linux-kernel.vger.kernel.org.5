Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60507F37B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjKUUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:49:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FD188;
        Tue, 21 Nov 2023 12:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700599742; x=1701204542; i=eberhard.stoll@gmx.de;
        bh=8aPOGl19QCVqTRibBIYihLBxePif4DIGtlLN/m0HxrU=;
        h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
         In-Reply-To;
        b=LvxxKD3uSx6gX6/FnPZDVBw1dfYLHpTH9s14qB3t0Ui+dp/8Css/+OhsnTiApgIU
         Oj3moNN9RRVjZ9JIK6I91JGY8+TR3iIVlrpW0m3gKW6j6DLDxlOv7ie7UvPYaXWEp
         LzihxGU4oRWSUAQGLE/xSEYhDtDXDkUAk4QAq27/BZZvVxUnWz0iweDBT1ybl7o9+
         JPtwTqi2J4d63kw0YYIyHaQTfgEgdyDYzMdm/A5x1OHKiPJqDKIwMolGTgkuSAZcU
         MTRfeMXrsXuUoI5vcAOOD5qMvAvVW2DKFefCb/RFTg0z6lAJqgojohIdL+KO8fQuo
         iZ9GEqR+S/SC4WCqNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.6] ([77.246.119.226]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1qpgIq0iWE-00YePW; Tue, 21
 Nov 2023 21:49:02 +0100
Message-ID: <dbe5959d-2b68-4f16-89ee-32538aab4f34@gmx.de>
Date:   Tue, 21 Nov 2023 21:49:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     sherry.sun@nxp.com
Cc:     festevam@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        rasmus.villemoes@prevas.dk, s.hauer@pengutronix.de,
        shawnguo@kernel.org, eberhard.stoll@kontron.de
References: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
Subject: RE: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
Content-Language: en-US
From:   Eberhard Stoll <eberhard.stoll@gmx.de>
In-Reply-To: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qGWan7ZoV8MP1GoTYr8Lcgg3mF3VmtF05afc6cL52D/ASAQAstL
 8ekD1YdoWzSSo53mqxF3yTz2WFPJnFJqo9Hbjm6TUXyDGUggaOqixnno8f4n+OQhwpVAHlm
 HMBCLFbr0XyL9WRPrMwvx+5TVTmbo0yW48bhuDGtybl5mqGwkMZ7f8bZbTZ7Ze83S42NwtZ
 8mnpLVPqeb4VbbZubAHsg==
UI-OutboundReport: notjunk:1;M01:P0:dcBJgA+KZ6s=;vXF1LbhEFjHoTELQPVDO66apRJD
 bQrbbjT4Sxdy/iWw51b6t5HjZj2HGYUpgZt0ywoDdlSizwKspTPRdXZ7ITibbHfPKv6sVmsaY
 Fg/GOhUuO9zJiaVJl+jM7PgexGXCdBJocWXNvQeBrk8+u7L3dyPkPn6TyB5khM7m9pWolspXW
 MaV9TCH7dGYKXj+9RjTYnjtduV9hlp+sbctzUTCovxQ7oDyBrxzCNufgaK8jR5JmECwcF1svM
 FpmTCMo8CYJmVpMxOB46jTTqYK1LKh7DBUL1mqYGaDwcSbsQaQOxN0SnwLT8J2s5t/ycl5Kwt
 Je3d3cDyE998KgvhcfSoStFBe3LzRUoZIgG736pcybRxrZpQZL+WHX5TSpw/7YmfczjjhN07x
 7ZO9jOOAREWel+xnHwBfQVpj2Eh2mPrfsoEytzJRvW8Jh0VuI7QrnIa03zfGiS2QvnbqoKsa8
 9N965MRQVw6PtfdViDCmlVjtO2/3nxHkwB46+mfp2mgyR5XbXTmaZdhZCmX5jy3Y1OHYnWl4+
 zyL79EVJXM9ZunCzKn4mDs3HFziF4h+BY3NBeBHtzHcUrTLTOUx0E+aUH067FnGvyE+K4r1uR
 6rdIpfZcA0AdsycWYKfYi9yEgRFSsVyFRyj6s/VxB1uGMSDz2lSuJ6blTfXVAMY5CDWYztbZS
 UWBjE8CB/hLOmjzxYRN9ISalJcQWjURWMIa702KNNfqmheSqcyn7mTP5UnHSXJ5BAkxgr3wlk
 eLG6orNVjtjP1F7CUIUfEIzRR1ZIIJ4ikbrk43DxK1vSHZ9AVkQcPzMXqbP4QMb0sLwIrR5jr
 PJm4DaictPdsy7nfgn0NvniJIBQOSXAd7J2Dph9XmGRMP7WuOS+M68ps4YHSlso32BZraPno3
 og3MwdV6mpcPl/qV9K4zv8umUSuzvZ+e1fkho8JU3GUctfIH6ELUYR0XqZYXObDYS8rsZZJzl
 F8Z4ASLfMhwXW69rPtsELnlMQXo=
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

> Currently, if one switches to rs232 mode, writes something to the
> device, and then switches to rs485 mode, the imx_port's ->tx_state is
> left as SEND. This then prevents a subsequent write in rs485 mode from
> properly asserting the rts pin (i.e. enabling the transceiver),
> because imx_uart_start_rx() does not enter the "if (sport->tx_state =3D=
=3D
> OFF)" branch. Hence nothing is actually transmitted.
>
> The problem is that in rs232 mode, ->tx_state never gets set to OFF,
> due to
>
> 	usr2 =3D imx_uart_readl(sport, USR2);
> 	if (!(usr2 & USR2_TXDC)) {
> 		/* The shifter is still busy, so retry once TC triggers */
> 		return;
> 	}
>
> in imx_uart_stop_tx(), and TC never triggers because the Transmit
> Complete interrupt is not enabled for rs232.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> I'm not sure this is the best fix.
>
> At first I considered doing something much more targeted, but
> definitely also more hacky: In imx_uart_rs485_config(), if switching
> on rs485 mode, simply add "sport->tx_state =3D OFF;".
>
> If someone has a better suggestion, I'm all ears.


Hello Rasmus,

i can observe a very similar situation, but with a litte different
configuration. This is how i can trigger the situation very quickly:

   1) open the port
   2) send 1 byte out
   3) close the port

Do it in a loop. As faster, the lockup may occur earlier (but not
mandatory, 100ms is sufficient in my setup at 115200 Baud on an
i.mx8mm board).
With this configuration i get the lockup in around 1 minute.

For my setup it's clear what happens:

   - when the tty is closed imx_uart_shutdown() is called. This calls
     imx_uart_stop_tx()
   - for a lockup, the shifter is still busy and imx_uart_stop_tx()
     returns early (as you explained) without modifying ->tx_state.
   - imx_uart_shutdown() proceeds and finally closes the port. Due to
     imx_uart_stop_tx() is not executed completely tx_state is left in
     state ->tx_state =3D=3D SEND.
   - When the port is opened again, tx_state is SEND and nothing can
     be transmitted any more. The tx path has locked up!

Setting ->tx_state =3D SEND in imx_uart_shutdown() helps for my issue
(and should be ok IMHO).

But IMHO there is one next issue with this situation: When the port
operates with WAIT_AFTER_RTS and WAIT_AFTER_SEND then some timers
for callback functions might be active. I did not discover where they
are stopped for the case when the serial port is closed. Maybe stopping
is not required ...

I'd appreciate someone with more experience could review or revise it

Best Regards
Eberhard
