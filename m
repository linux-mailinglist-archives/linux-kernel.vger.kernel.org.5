Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5907F01E9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKRSHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjKRSHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:07:03 -0500
X-Greylist: delayed 13259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Nov 2023 10:06:53 PST
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB8D5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:06:53 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SXhP732z6zMq1p3;
        Sat, 18 Nov 2023 17:59:39 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SXhP62MGlzMpnPg;
        Sat, 18 Nov 2023 18:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
        s=20200409; t=1700330379;
        bh=4ft/Gs2FgEsC8ctTIzR/sKmm2sBGVKXbikEUXVTIiPc=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=4nuwgCBO/krp+w5+vZhS7K3aJCFpShbKMVnbJ0dbF+nuwHGPS0Waxj0k05ivxrkIk
         QyFRwfrwdICxFdc0LP/bFl2swlIXlshKIjcEU00vf7aW9ntcXqrF5yLCn4bfuKlFu2
         ggswq1sOw+UPyMDaHN3chcs6S1hiVK/H7JouMzkE=
Message-ID: <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
Date:   Sat, 18 Nov 2023 18:59:38 +0100
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   linux@bigler.io
Reply-To: linux@bigler.io
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IjFaRW83ZGpKQWd6MDIwYWM0TWdRSVE9PSIsInZhbHVlIjoiY1NQbnN0Vm1CNmNXMEt0dWRvd3JQUT09IiwibWFjIjoiMGY4YThiNTdjYzNiMTIwNzllODc3YmFkZDgwNWNkNWQ0NTQ5NDdiMjQ5MmQxZDExZjNmYzBjZmY4ZTE5OWY0YSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6Ikk3WWg0QUlxaExzckl6ZFR4YWN6YWc9PSIsInZhbHVlIjoiT0NUUTM2WDZESG8rK2YyOFVEYjAzdz09IiwibWFjIjoiOGUxMDEwYmYxOWJjNjJkMWE5NTY3MDMxY2FhYTJiNDQyOTdmNTlmOTUwZWQ0MDgzZjE5ODA3ZWJiNGViNDRjOSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.595)
References: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
 <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
In-Reply-To: <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=20

I checked the code an printed the used parameters, the =E2=80=98bits_per_wo=
rd=E2=80=99 is set to 8.

Best Regards
Stefan Bigler

Am 2023-11-18T17:54:26.000+01:00 hat Stefan Moring <stefan.moring@technolut=
ion.nl> geschrieben:
>  Hi Thorsten,
>=20
> Looking at the data of your test, it appears as if your =E2=80=98bits_per=
_word=E2=80=99 are
> set to 32, where you would want 8.
>=20
> Can you verify this?
>=20
> Kind regards,
>=20
> Stefan Moring
>=20
> Op za 18 nov. 2023 om 16:15 schreef Thorsten Leemhuis <
> regressions@leemhuis.info>
>=20
>=20
> >    On 18.11.23 16:13, Linux regression tracking (Thorsten Leemhuis) wro=
te:
> >=20
> > >     [CCing people that worked on the relevant commits as well as the
> > >   regression list, as it should be in the loop for regressions:
> > >   https://docs.kernel.org/admin-guide/reporting-regressions.html]
> > =20
> >  Sorry for the spam, hit "send" before actually adding Stefan and Mark,
> >  which now are among the recipients.
> >=20
> >=20
> > >     On 18.11.23 15:25, linux@bigler.io wrote:
> > >=20
> > > >     After upgrade from kernel 6.5.11 to 6.6.1 the spi-devices on my=
 hw
> > > >   colibri-imx6dl and verdin-imx8mm are not working anymore (TPM2 an=
d
> > >   SPI-SRAM).
> > >=20
> > > > =20
> > > > >   =20
> > > > >   Analyzing the problem showed that the 2 commits introduced the =
problem:
> > > > > =20
> > > > >   spi: Increase imx51 ecspi burst length based on transfer length
> > > > >   15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
> > > > > =20
> > > > >   spi: imx: Take in account bits per word instead of assuming 8-b=
its
> > > > >   5f66db08cbd3ca471c66bacb0282902c79db9274
> > > > > =20
> > > > >   Reverting the commits solved the problem.
> > > > > =20
> > > > >   The analyse with the logic-analyser showed a wrong number of
> > > >   transmitted
> > > >=20
> > > > > =20
> > > > > >     bytes and wrong data.
> > > > > >   When I try to send 127 Byte with a incrementing pattern
> > > > >   (0x01,0x02,0x03,..),
> > > > >=20
> > > > > > =20
> > > > > > >     504 Bytes are sent (0x00,0x00,0x01 0x00,0x00,0x00,0x02,
> > > > > >   0x00,0x00,0x00,0x03).
> > > > > >=20
> > > > > > > =20
> > > > > > > >     We tested with different sizes and patterns, all are no=
t ok.
> > > > > > > >   While analysing the configuration and code I was not able=
 to see any
> > > > > > >   obvious
> > > > > > >=20
> > > > > > > > =20
> > > > > > > > >     mistake.
> > > > > > > > > =20
> > > > > > > > >   Has someone else discovered such misbehaviour or has an=
y idea what is
> > > > > > > >   wrong?
> > > > > > > >=20
> > > > > > > > > =20
> > > > > > > > > >     Best Regards
> > > > > > > > >  =20
> > > > > > > > >   Thx for the report!
> > > > > > > > > =20
> > > > > > > > >   [TLDR: I'm adding this report to the list of tracked Li=
nux kernel
> > > > > > > > >   regressions; the text you find below is based on a few =
templates
> > > > > > > > >   paragraphs you might have encountered already in simila=
r form.
> > > > > > > > >   See link in footer if these mails annoy you.]
> > > > > > > > > =20
> > > > > > > > >   To ensure the issue doesn't fall through the cracks unn=
oticed, I'm
> > > > > > > > >   adding it to regzbot, the Linux kernel regression track=
ing bot:
> > > > > > > > > =20
> > > > > > > > >   #regzbot ^introduced 15a6af94a27
> > > > > > > > >   #regzbot title spi: spi-devices on colibri-imx6dl and v=
erdin-imx8mm are
> > > > > > > > >   not working anymore
> > > > > > > > >   #regzbot ignore-activity
> > > > > > > > > =20
> > > > > > > > >   This isn't a regression? This issue or a fix for it are=
 already
> > > > > > > > >   discussed somewhere else? It was fixed already? You wan=
t to clarify when
> > > > > > > > >   the regression started to happen? Or point out I got th=
e title or
> > > > > > > > >   something else totally wrong? Then just reply and tell =
me -- ideally
> > > > > > > > >   while also telling regzbot about it, as explained by th=
e page listed in
> > > > > > > > >   the footer of this mail.
> > > > > > > > > =20
> > > > > > > > >   Developers: When fixing the issue, remember to add 'Lin=
k:' tags pointing
> > > > > > > > >   to the report (the parent of this mail). See page linke=
d in footer for
> > > > > > > > >   details.
> > > > > > > > > =20
> > > > > > > > >   Ciao, Thorsten (wearing his 'the Linux kernel's regress=
ion tracker' hat)
> > > > > > > > >   --
> > > > > > > > >   Everything you wanna know about Linux kernel regression=
 tracking:
> > > > > > > > >   https://linux-regtracking.leemhuis.info/about/#tldr
> > > > > > > > >   That page also explains what to do if mails like this a=
nnoy you.
> > > > > > > > =20
> > > > > > > >=20
> > > > > > > >
