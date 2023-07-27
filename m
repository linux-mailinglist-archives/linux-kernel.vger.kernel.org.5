Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4147764928
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjG0Hom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjG0HnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:18 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2576F6A40;
        Thu, 27 Jul 2023 00:37:22 -0700 (PDT)
Received: from [2001:a61:6209:7f40:c80a:ff:fe00:4098] (helo=cs-office3.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qOvXT-0001KS-Ho; Thu, 27 Jul 2023 09:35:59 +0200
Date:   Thu, 27 Jul 2023 09:35:48 +0200
From:   Carsten =?UTF-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (isl28022) new driver for ISL28022 power
 monitor
Message-ID: <20230727093548.0cb0d6e8.mail@carsten-spiess.de>
In-Reply-To: <bbf1aba4-48ce-289d-aaa9-bc861effaffd@roeck-us.net>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-2-mail@carsten-spiess.de>
 <bbf1aba4-48ce-289d-aaa9-bc861effaffd@roeck-us.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Lp+eURiMW8MUrBzpr8v_GGg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690443444;f83c0e10;
X-HE-SMSGID: 1qOvXT-0001KS-Ho
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Lp+eURiMW8MUrBzpr8v_GGg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

 On 7/26/23 18:19, Guenter Roeck wrote:
> Please provide a register dump (using i2cdump) for this chip.=20

# i2cdump -y -r 0-9 1 0x40 w
     0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
00: ff67 ca00 a25d c803 5006 0080 817f 00ff=20
08: 0000 0000 =20

Please note that due to big vs.- little endian bytes are swapped,
should be read as:
00: 67ff 00ca 5da2 03c8 0650 8000 7f81 ff00
08: 0000 0000 =20

corresponding sensor values are about (not read at same time):
in0:           1.99 V =20
in1:          23.97 V =20
power1:        6.10 W =20
curr1:       248.00 mA=20

in0 should be read as mV

Regards, Carsten

--Sig_/Lp+eURiMW8MUrBzpr8v_GGg
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWM+MlUpz/bWsZllTM1JQzV9LKSwFAmTCHlQACgkQM1JQzV9L
KSzWMg/+Mp/CNQhmKivVvjjhWPjXYqNHF0t2T6dOh8hVJA6JaMfiGML0OmIFeLtj
SmXBWHTi8ZE8OotBAx4yMIJPxnGa9pxCkvZ33WJsq9w4aUmVqymu1TbMcXkWuKPJ
U+jGl7ZhSycI8r+wOjgm59hybz9KU+aDi8uibvFxXUo0PflIufO2ZbqTEPkmaYjc
mUUOtkgcN/WbZ0CkG0Fdzj6lsCNzLRITHqOE7aTfa0ju8JJQgqSdxVSSFgN8/8gF
Lsf3WgU7EOtBRarz0H/AW1Cp0nNYRQT+mnbqU544aUC+FC7BNh706ROIKiji6vE2
Vsrn32o3cyYOK6xG2z/kJy3T3UAWHdMBgmpmB48spAdMjM3J2dRxP/cUNVAOUd24
dEw40bPZ5qrvDTyGzdqCTqacZtBlnhLEjB8rq7zaLNMvJ0Ytb49B4npsLHQDi7c0
e70FKnY6t5jMyEtPCQqCKM+WtJu2ac4E6S+T3LQSt9CVs4nY/qpz2g6hrXiqD55+
tuYltPTVyimPlSOzw9Uxd3JGwPUdFSlFDJmb2D6pskCwHzSx1KRf8LmhrzA/AhNr
trRFVGz9CIQjDfDu1+TMmnt/kTXuOqRZ8pLPlLlMH/S2G/V+6kF58LrmjovVguwy
LcxnkEd+a9Eg5OLLc/csEBDNTLF5n8QXSkjEpJbBIyZUTLEYsrg=
=RTpb
-----END PGP SIGNATURE-----

--Sig_/Lp+eURiMW8MUrBzpr8v_GGg--
