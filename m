Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232917DCE00
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbjJaNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbjJaNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:39:15 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D34E6;
        Tue, 31 Oct 2023 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=E/yUX/f4ZCe3DyW2zI4fL8vzPIun1wWgfcaAJyJfsSA=; b=K6C6qQbMSnrXsvrXDh8sNCgaUe
        EHjQ50sGgULoNbjtSR7S8tzUutGq/zji5Iiq74+KyaChkfPgTX1Qb5oN/RE7jAtkJJJrQZMas1r+y
        cyETvV7KrlgMtpCPIOD3xc4Gl9F8PNrSY+5vrMKTTKJhU8Z/r2Zyec5xacPEOUFZXTM0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52896 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qxoxS-00067I-Kz; Tue, 31 Oct 2023 09:39:04 -0400
Date:   Tue, 31 Oct 2023 09:39:01 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
Message-Id: <20231031093901.aa085ec1316ab0d008cb0080@hugovil.com>
In-Reply-To: <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
        <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
        <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
        <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 10:35:29 +0100
Th=E9o Lebrun <theo.lebrun@bootlin.com> wrote:

> Hello,
>=20
> On Thu Oct 26, 2023 at 4:53 PM CEST, Hugo Villeneuve wrote:
> > On Thu, 26 Oct 2023 12:41:23 +0200
> > Th=E9o Lebrun <theo.lebrun@bootlin.com> wrote:
> >
> > Hi,
> > I would change the commit title to better indicate that you add support
> > for bits 5 and 6, which was missing.
> >
> > Maybe "Add support for 5 and 6 bits in..." ?
> >
> > > pl011_console_get_options() gets called to retrieve currently configu=
red
> > > options from the registers. Previously, LCRH_TX.WLEN was being parsed
> >
> > It took me some time to understand your explanation :) Maybe change
> > to:
> >
> > "Previously, only 7 or 8 bits were supported."
> >
> > > as either 7 or 8 (fallback). Hardware supports values from 5 to 8
> >
> > Add bits:
> >
> > "5 to 8 bits..."
> >
> > And indicate that this patch adds support for 5 and 6 bits.
>=20
> I agree the whole commit message is unclear. Let's rewrite it. What do
> you think of the following:
>=20
>    tty: serial: amba-pl011: Allow parsing word length of 5/6 bits at cons=
ole setup
>=20
>    If no options are given at console setup, we parse hardware register
>    LCRH_TX.WLEN for bits per word. We compare the value to the 7 bits
>    value (UART01x_LCRH_WLEN_7). If the hardware is configured for 5, 6
>    or 8 bits per word, we fallback to 8 bits.
>=20
>    Change that behavior to parse the whole range available: from 5 to 8
>    bits per word.
>=20
> Note that we don't add support for 5/6 bits, we only update the parsing
> of the regs (if no options are passed at setup) to reflect the current
> hardware config. The behavior will be different only if the inherited
> value (from reset/bootloader) is 5 or 6: previously we guessed 8 bits
> word length, now we guess the right value.
>=20
> What's your opinion on this new commit message?

Hi,
that's fine with me.

Hugo.
