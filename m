Return-Path: <linux-kernel+bounces-1533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEB814FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718A9285489
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12DD3E49F;
	Fri, 15 Dec 2023 18:31:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8334CF6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id CCCC3120533;
	Fri, 15 Dec 2023 18:30:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 4C7F06000F;
	Fri, 15 Dec 2023 18:30:53 +0000 (UTC)
Message-ID: <0173e76a36b3a9b4e7f324dd3a36fd4a9757f302.camel@perches.com>
Subject: Re: [PATCH v2] get_maintainer: correctly parse UTF-8 encoded names
 in files
From: Joe Perches <joe@perches.com>
To: Alvin =?UTF-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Alvin =?UTF-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>, Linus Torvalds
 <torvalds@linux-foundation.org>, Duje =?UTF-8?Q?Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>
Date: Fri, 15 Dec 2023 10:30:52 -0800
In-Reply-To: <45x65lwhzefxfe7muha6myfqb53ooxvhjpgeqadeiikl5nriws@ekwlxybd6ybp>
References: 
	<20231214-get-maintainers-utf8-v2-1-b188dc7042a4@bang-olufsen.dk>
	 <f7510474a007223811da8b04efabf13376e53728.camel@perches.com>
	 <45x65lwhzefxfe7muha6myfqb53ooxvhjpgeqadeiikl5nriws@ekwlxybd6ybp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4C7F06000F
X-Rspamd-Server: rspamout06
X-Stat-Signature: undfxqwx3mfedzwfx71pedjzrm7nkyp9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/IryiKmxkpKMkUA2YFpz6Jsvdymem2loQ=
X-HE-Tag: 1702665053-690716
X-HE-Meta: U2FsdGVkX1/CIY4lCzZGArFJsUbPo3LYtGZZTKeZnmJXswkREBARJhXkoqTXXtUIt4SSbAaNzUxK+yXT2U8Q6MXx6ukSMp/i8Exc3MCx2xH8+NnRI14wPhMRXmIduKaM0JEp4Ae3ycn6lblmOw7/VKNjTg+nY77v7aeB7oiJV4VkIoh7JC5MmpzCdpxeRNU+KcJdgkY8GBQwpwUgDNJnFi3mBg+Z7Q24yGlKhUYhp+MeBKDHgNQSrcDg43SZjcf4sOe2FfbkcQ2gqkIiVd4gshxREwK1a9foW9xEq0unStfhmMeUoGg2BefeTbFTutFGsJRXGPK6h85IMtcVM6vstaUqHGzSIJ6CudP9xWgflVwspXGKxA8Z0/5p+XkcDmR6bQbbuZU6rWqUMxUyTOhjqQExdrgVeVajVlj7wShnz8QOT43NFnxO8/KJ4lldAF0Q7b+CSn9d21ouV4LTw8cybauoB/UDAAZOsutMBznVcdcquHAODUSDUm+i0AXhdnkL3QMHQx2VPKALfJHWHNVpaUJLkXA5aeKkujItjkS96ssK0LbmKo3VgA==

On Fri, 2023-12-15 at 10:30 +0000, Alvin =C5=A0ipraga wrote:
> On Thu, Dec 14, 2023 at 07:57:54AM -0800, Joe Perches wrote:
> > On Thu, 2023-12-14 at 16:06 +0100, Alvin =C5=A0ipraga wrote:
> > > @@ -442,7 +443,7 @@ sub maintainers_in_file {
> > >  	my $text =3D do { local($/) ; <$f> };
> > >  	close($f);
> > > =20
> > > -	my @poss_addr =3D $text =3D~ m$[A-Za-z=C3=80-=C3=BF\"\' \,\.\+-]*\s=
*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\=
>\}]{0,1}$g;
> > > +	my @poss_addr =3D $text =3D~ m$[\p{L}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<=
\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> > >  	push(@file_emails, clean_file_emails(@poss_addr));

Hi again Alvin.

Separate issue, but on the one .yaml file I tried:

$ ./scripts/get_maintainer.pl Documentation/devicetree/bindings/serial/8250=
.yaml
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:TTY LAYER AND SE=
RIAL DRIVERS)
Jiri Slaby <jirislaby@kernel.org> (supporter:TTY LAYER AND SERIAL DRIVERS)
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DE=
VICE TREE BINDINGS)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FI=
RMWARE AND FLATTENED DEVICE TREE BINDINGS)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED =
DEVICE TREE BINDINGS)
Lubomir Rintel <lkundrak@v3.sk> (in file)
- <devicetree@vger.kernel.org> (in file)
linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TR=
EE BINDINGS)

Note the single '-' in the "name" portion of devicetree@vger.kernel.org

Maybe clean_file_emails needs some better name cleansing code.

> > Rather than open _all_ files in utf-8, perhaps the block
> > that opens a specific file to find maintainers
> >=20
> > sub maintainers_in_file {
> >     my ($file) =3D @_;
> >=20
> >     return if ($file =3D~ m@\bMAINTAINERS$@);
> >=20
> >     if (-f $file && ($email_file_emails || $file =3D~ /\.yaml$/)) {
> > 	open(my $f, '<', $file)
> > 	    or die "$P: Can't open $file: $!\n";
> > 	my $text =3D do { local($/) ; <$f> };
> > 	close($f);
> > 	...
> >=20
> > should change the
> >=20
> > 	open(my $f...
> > to
> > 	use open qw(:std :encoding(UTF-8));
> > 	open(my $f...
>=20
> Yes, this also works for parsing the name in an arbitrary file. But with =
the
> change you suggest above, the script then corrupts my name when it is lif=
ted
> from MAINTAINERS (!?):
>=20
> $ ./scripts/get_maintainer.pl -f drivers/net/dsa/realtek/ | grep alsi
> "Alvin =C3=85=C2=A0ipraga" <alsi@bang-olufsen.dk> (maintainer:REALTEK RTL=
83xx SMI DSA ROUTER CHIPS)

Curious.  Let me see if I can figure out why that happens.


> If you are still unconvinced then I will gladly send a v3 patching the tw=
o cases
> we have discussed (read_maintainer_file() and maintainers_in_file()).

No rush.

> > And unrelated and secondarily, perhaps the
> > 	$file =3D~ /\.yaml$/
> > test should be
> > 	$file =3D~ /\.(?:yaml|dtsi?)$/
> >=20
> > to also find any maintainer address in the dts* files
> >=20
> > https://lore.kernel.org/lkml/20231028174656.GA3310672@bill-the-cat/T/
>=20
> Is this supposed to parse the "Copyright (c) 20xx John Doe <foo@bar.toto>=
" in
> the .dts* files?

Yes, just as it would and does for .yaml files.

$ git grep -P -i 'copy.*\<\w+\@\w+\.\w+\>' -- '*.yaml'
Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.yaml:# Cop=
yright (C) 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml:# Copyright =
2019,2020 Lubomir Rintel <lkundrak@v3.sk>
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml:# Copyright (C) =
2019,2020 Lubomir Rintel <lkundrak@v3.sk>
Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml:# C=
opyright 2019 Ondrej Jirman <megous@megous.com>
Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml:# Copyrigh=
t 2019 Lubomir Rintel <lkundrak@v3.sk>
Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml:# Copyright=
 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.yaml:# Copyrig=
ht 2019 Manivannan Sadhasivam <mani@kernel.org>
Documentation/devicetree/bindings/reset/marvell,berlin2-reset.yaml:# Copyri=
ght 2015 Antoine Tenart <atenart@kernel.org>
Documentation/devicetree/bindings/reset/qca,ar7100-reset.yaml:# Copyright 2=
015 Alban Bedel <albeu@free.fr>
Documentation/devicetree/bindings/serial/8250.yaml:# Copyright 2020 Lubomir=
 Rintel <lkundrak@v3.sk>
Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml:# Copyright 201=
9,2020 Lubomir Rintel <lkundrak@v3.sk>
Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.yaml:# Copyright =
2019,2020 Lubomir Rintel <lkundrak@v3.sk>

> But sure, I can do a resend of Shawn's original patch
> separately if you like.

Yes please. Make sure to cc Andrew Morton.


