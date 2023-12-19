Return-Path: <linux-kernel+bounces-5854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C8081902F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DC7B24B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C041739AE2;
	Tue, 19 Dec 2023 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv515pWY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389639AD2;
	Tue, 19 Dec 2023 18:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94953C433C8;
	Tue, 19 Dec 2023 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703012257;
	bh=eC1iCLRUMlrRVEuTQ0Z8WI2H/bl8AGvzCCbdTBZoMlQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rv515pWYnAwrqyFQBoqGubfb0KGLwSU0FToLJyBsdvikIBUj137Swzf2+J78PcKut
	 rAQmeEKpq+ZvII4NamrwqdB7sfNvVwSudDhgw9fBAURxW4SBWtxxWUiJlXt3EwudQo
	 Hgqak37+LE8YHBgbjjqwFegFCOa63QQRFyK6fIEmnkoC6lx2UPvdk5tnURVXujfnkW
	 TGHUbsS8T8/qe5WH+vQ8pwpdy1DDUaRaRwUMK6aXCHDzwSsw/z1Uy2I65CDGvi7Rze
	 /nug/SSu6krxXfCBGxy/PoYv9fgKMoXlpAVbBy2M5ZU3c1LzNfU2J0gwFPDL9AYeDt
	 AKhkTvZSMgntA==
Date: Tue, 19 Dec 2023 18:57:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor.dooley@microchip.com>,
 "prabhakar.csengg@gmail.com" <prabhakar.csengg@gmail.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 Atish Patra <atishp@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
 "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
 Bjorn Topel <bjorn@rivosinc.com>,
 "suagrfillet@gmail.com" <suagrfillet@gmail.com>,
 "jeeheng.sia@starfivetech.com" <jeeheng.sia@starfivetech.com>,
 "petrtesarik@huaweicloud.com" <petrtesarik@huaweicloud.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: =?US-ASCII?Q?RE=3A_=5BRFT_1/2=5D_RISC-V=3A_handle_missing_=22no-map=22_?= =?US-ASCII?Q?properties_for_OpenSBI=27s_PMP_protected_regions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <OSZPR01MB7019F6BECABB1C57BBC8FAE0AA97A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <OSZPR01MB70195C6084CF2CDA5EE13D68AA97A@OSZPR01MB7019.jpnprd01.prod.outlook.com> <mhng-378700ef-2f59-431a-bba6-2c70e0584738@palmer-ri-x1c9a> <OSZPR01MB7019F6BECABB1C57BBC8FAE0AA97A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Message-ID: <870F0819-2354-4359-B474-F0C0BE1587B2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19 December 2023 18:38:30 GMT, Prabhakar Mahadev Lad <prabhakar=2Emahad=
ev-lad=2Erj@bp=2Erenesas=2Ecom> wrote:
>Hi Palmer,
>
>> -----Original Message-----
>> From: Palmer Dabbelt <palmer@dabbelt=2Ecom>
>> Sent: Tuesday, December 19, 2023 6:07 PM
>> To: Prabhakar Mahadev Lad <prabhakar=2Emahadev-lad=2Erj@bp=2Erenesas=2E=
com>
>> Cc: Conor Dooley <conor@kernel=2Eorg>; Conor Dooley <conor=2Edooley@mic=
rochip=2Ecom>;
>> prabhakar=2Ecsengg@gmail=2Ecom; geert+renesas@glider=2Ebe; Atish Patra =
<atishp@rivosinc=2Ecom>; Paul Walmsley
>> <paul=2Ewalmsley@sifive=2Ecom>; apatel@ventanamicro=2Ecom; alexghiti@ri=
vosinc=2Ecom; Bjorn Topel
>> <bjorn@rivosinc=2Ecom>; suagrfillet@gmail=2Ecom; jeeheng=2Esia@starfive=
tech=2Ecom;
>> petrtesarik@huaweicloud=2Ecom; linux-riscv@lists=2Einfradead=2Eorg; lin=
ux-kernel@vger=2Ekernel=2Eorg;
>> stable@vger=2Ekernel=2Eorg
>> Subject: RE: [RFT 1/2] RISC-V: handle missing "no-map" properties for O=
penSBI's PMP protected regions
>>=20
>> On Tue, 19 Dec 2023 09:27:42 PST (-0800), prabhakar=2Emahadev-lad=2Erj@=
bp=2Erenesas=2Ecom wrote:
>> > Hi Conor,
>> >
>> >> -----Original Message-----
>> >> From: Conor Dooley <conor@kernel=2Eorg>
>> >> Sent: Tuesday, December 19, 2023 5:18 PM
>> >> To: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>> >> Cc: Lad, Prabhakar <prabhakar=2Ecsengg@gmail=2Ecom>; Palmer Dabbelt
>> >> <palmer@dabbelt=2Ecom>;
>> >> geert+renesas@glider=2Ebe; Atish Patra <atishp@rivosinc=2Ecom>; Paul
>> >> geert+Walmsley <paul=2Ewalmsley@sifive=2Ecom>;
>> >> apatel@ventanamicro=2Ecom; alexghiti@rivosinc=2Ecom; Bjorn Topel
>> >> <bjorn@rivosinc=2Ecom>; suagrfillet@gmail=2Ecom;
>> >> jeeheng=2Esia@starfivetech=2Ecom; petrtesarik@huaweicloud=2Ecom; lin=
ux-
>> >> riscv@lists=2Einfradead=2Eorg; linux-kernel@vger=2Ekernel=2Eorg;
>> >> stable@vger=2Ekernel=2Eorg; Prabhakar Mahadev Lad
>> >> <prabhakar=2Emahadev-lad=2Erj@bp=2Erenesas=2Ecom>
>> >> Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties fo=
r
>> >> OpenSBI's PMP protected regions
>> >>
>> >> Hey,
>> >>
>> >> On Thu, Dec 07, 2023 at 01:11:23PM +0000, Conor Dooley wrote:
>> >> > On Thu, Dec 07, 2023 at 01:02:00PM +0000, Lad, Prabhakar wrote:
>> >> > > On Wed, Dec 6, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor@kerne=
l=2Eorg> wrote:
>> >> > > > On Wed, Dec 06, 2023 at 04:52:11AM -0800, Palmer Dabbelt wrote=
:
>> >> > > > > On Thu, 10 Aug 2023 02:07:10 PDT (-0700), Conor Dooley wrote=
:
>> >> >
>> >> > > > > > I'm perfectly happy to drop this series though, if people
>> >> > > > > > generally are of the opinion that this sort of firmware wo=
rkaround is ill-advised=2E
>> >> > > > > > We are unaffected by it, so I certainly have no pressure t=
o
>> >> > > > > > have something working here=2E It's my desire not to be
>> >> > > > > > user-hostile that motivated this patch=2E
>> >> > > > >
>> >> > > > > IIUC you guys and Reneas are the only ones who have hardware
>> >> > > > > that might be in a spot where users aren't able to update th=
e
>> >> > > > > firmware (ie, it's out in production somewhere)=2E
>> >> > > >
>> >> > > > I dunno if we can really keep thinking like that though=2E In
>> >> > > > terms of people who have devicetrees in the kernel and stuff
>> >> > > > available in western catalog distribution, sure=2E
>> >> > > > I don't think we can assume that that covers all users though,
>> >> > > > certainly the syntacore folks pop up every now and then, and I
>> >> > > > sure hope that Andes etc have larger customer bases than the
>> >> > > > in-kernel users would suggest=2E
>> >> > > >
>> >> > > > > So I'm adding Geert, though he probably saw this months ago=
=2E=2E=2E
>> >> > > >
>> >> > > > Prabhakar might be a good call on that front=2E I'm not sure i=
f
>> >> > > > the Renesas stuff works on affected versions of OpenSBI though=
,
>> >> > > > guess it depends on the sequencing of the support for the
>> >> > > > non-coherent stuff and when this bug was fixed=2E
>> >> > > >
>> >> > > ATM, I dont think there are any users who are using the upstream
>> >> > > kernel + OpenSBI (apart from me and Geert!)=2E Currently the
>> >> > > customers are using the BSP releases=2E
>> >> >
>> >> > That doesn't really answer whether or not you (and your customers)
>> >> > are using an affected version of the vendor OpenSBI?
>> >> > The affected range for OpenSBI itself is [v0=2E8 to v1=2E3)=2E
>> >>
>> >> Did you perhaps miss this mail Prabhakar?
>> >>
>> > Oops sorry for that=2E
>> >
>> > I can confirm the BSP version used by the customers is v1=2E0 [0]=2E
>> >
>> > [0]
>> > https://jpn01=2Esafelinks=2Eprotection=2Eoutlook=2Ecom/?url=3Dhttps%3=
A%2F%2Fgith
>> > ub=2Ecom%2Frenesas-rz%2Frz_opensbi%2Fcommits%2Fwork%2FOpenSBI-PMA%2F&=
dat
>> > a=3D05%7C02%7Cprabhakar=2Emahadev-lad=2Erj%40bp=2Erenesas=2Ecom%7C014=
cf4ddfd1e48
>> > 1ff5bc08dc00bd467f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63838=
6
>> > 060130410731%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
M
>> > zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Da0tcsXY4EQl=
ODi
>> > I34QygXS9QpJnVBqL8bNkxE8N5J2g%3D&reserved=3D0
>>=20
>> OK, so sounds like would end up with broken systems from this bug, then=
?
>>=20
>> IIRC we still have the Renesas systems as NONPORTABLE due to that DMA p=
ool Kconfig conflict=2E  So if
>> it's really only these Renesas systems that have the bug, maybe we can =
still remove hibernation from
>> NONPORTABLE and just add in some sort of Kconfig to disable the
>> Renesas+hibernation combinations that would break?
>>=20
>Well customers using BSP uses v1=2E0 for OpenSBI and kernel 5=2E10-cip, a=
nd people wanting to run upstream kernel will have to only use the upstream=
 OpenSBI as the OpenSBI used in BSP is not compatible with upstream kernel(=
Linux doesn=E2=80=99t bootup)=2E
>
>ATM I can say that its only me and Geert using upstream OpenBSI and upstr=
eam kernel=2E
>
>With that in mind would we still require that change?

5=2E10 doesn't have hibernation support in it, although I'm not sure why a=
nyone would really want to use a kernel that old with a RISC-V system=2E

The upstream versions of opensbi that support the renesas stuff have the n=
o-map fix, right?
If that's the case, then nothing special config wise is likely required=2E

I'm still wary of other systems though, we are acting as if it is only Mic=
rochip and Renesas are the "real" users=2E

