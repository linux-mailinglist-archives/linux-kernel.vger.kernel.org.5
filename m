Return-Path: <linux-kernel+bounces-98492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A737A877AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B867282546
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6443CA47;
	Mon, 11 Mar 2024 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQUBZumc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7C8F4A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710136988; cv=none; b=jr+Cp9tJasHQCAZFAiCNJOdBXT4RRx0dk64PEkZQBwhAz/Ru8YZYL2QKKBaWTZ3cKzySdbp71Lg7WctWcmC5T8IUUanstzO/KlQtmvs7DA+PuUJBjp1h95mk8kA1idPscLVzG9EBgQFRposjAXGAUOmiPJyP9H3a7jdW8xj6Wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710136988; c=relaxed/simple;
	bh=rHKHOs/CfioDRsDzlTyobjWIyq8en/YqyDBEXhad4Bs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gMJfcRngDL/9qzGHvILD3G3qabrjUbE/Cvt3ckFDRgsh82QgqLlt5mdbMCx2wUWKWXA/0Syit/OYgW5l3NAlhY9XeQv9z92szFFpYGM1majDti4JMqRQeZsEAn6rZqlJgX1uCHqwk477aN/VRwINxPi4/zez2UAGehNkxsPD9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQUBZumc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D270C433F1;
	Mon, 11 Mar 2024 06:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710136987;
	bh=rHKHOs/CfioDRsDzlTyobjWIyq8en/YqyDBEXhad4Bs=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=fQUBZumcdZeGJOZxYogFlDP8CxOy2NzhsptKPGEe9ceUUUZwKS5BSN0XRnqdv+mqK
	 FabhdP15mjigTh0eXo6u3lylbMuxPlA6gj1nPa/jX3Sc+FF95rkIvFwy1XHDuSt528
	 8zBU4+PN4cPg2bIq6lSJKN2QXu6ySluw0i64yKJ8N2wKlPA31pjRNPzMNGOn0Wlvm2
	 hOfPVHDcKXnAawrwqrtTyNEdybuVY3U1JY2h48ck8DOpZAEcoWmhFIEZPKg7ivJIqh
	 MzsFP34o2ZmjSiwo5Wi+eOfWyF/kUPYVrxZw81VGYwdGXiM+ITzkaWq7Czbdc5AAqu
	 S5aG3hDHULSkQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 514311200043;
	Mon, 11 Mar 2024 02:03:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 02:03:06 -0400
X-ME-Sender: <xms:mZ7uZTwhUKDoB3VvZpa1UHC5O9fNcVHw4GVHq20D6zOHHoPgk0dvIQ>
    <xme:mZ7uZbQqQDNYN6vaTIm2yGUB29_sR0kbzHOBjIuvCJv7P7hmtIQ8MdtDsvPf8YzJQ
    amta3JmMs90PbMTsgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedtgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveevtefh
    feejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:mZ7uZdU-AObKIuhhe9Uq4vZYd51S8os2D0kXu_POqxBSXouEnPPA-g>
    <xmx:mZ7uZdiKzQ3RJdJ6KwIQE9y5W0JZuUmZgUHbfBJPHYG1NOvsb1Lf_g>
    <xmx:mZ7uZVDypRaLIrBcqqlhf0wOaKoJc4pobTimAtyHAFIUHAnX1uF4hQ>
    <xmx:mp7uZdxl7jTfP9FPqWJRNdwPGicZ32KZg-G6VHqqtLMMTAOBGbP-I9B0xq0>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A32BCB6008D; Mon, 11 Mar 2024 02:03:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e90c2e69-17ea-4875-bb36-8a6d846f05e6@app.fastmail.com>
In-Reply-To: <6c3451ed-6346-45e2-940e-851cb99a1b63@alliedtelesis.co.nz>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
 <87edclgoon.fsf@BL-laptop>
 <CAHp75VfmSWH3FWEHU+bGYDuo-nt1DJhY5Fvs83A-RGrtrsgWTw@mail.gmail.com>
 <8177b94d-82c9-42b6-85eb-728dec762162@app.fastmail.com>
 <CAHp75VfiaWFricM4Or771P0LJVoFoEmQtoJo1hySo=BRS-59DQ@mail.gmail.com>
 <6c3451ed-6346-45e2-940e-851cb99a1b63@alliedtelesis.co.nz>
Date: Mon, 11 Mar 2024 07:02:35 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Chris Packham" <Chris.Packham@alliedtelesis.co.nz>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: "Gregory Clement" <gregory.clement@bootlin.com>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
 "Lee Jones" <lee@kernel.org>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on x530
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024, at 21:22, Chris Packham wrote:
> On 8/03/24 23:34, Andy Shevchenko wrote:
>> On Fri, Mar 8, 2024 at 12:19=E2=80=AFPM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>>> On Fri, Mar 8, 2024, at 10:56, Andy Shevchenko wrote:
>>>> On Fri, Mar 8, 2024 at 9:36=E2=80=AFAM Gregory CLEMENT <gregory.cle=
ment@bootlin.com> wrote:
>>>>>
>>>>> Normally, this patch should be taken in mvebu and then merged by
>>>>> arm-soc. However, I haven't seen any other patch touching this fil=
e (so
>>>>> no risk of merge conflict) and I think it's too late for me to mak=
e a
>>>>> new pull request to arm-soc. So I'm not against it being taken wit=
h the
>>>>> rest of the patches. However, I think it would be a good idea to s=
ee
>>>>> what Arnd thinks about it.
>
> FYI ./scripts/get_maintainer.pl -f arch/arm/boot/dts/marvell isn't=20
> picking up Arnd should it?

No, as Gregory writes, the intended way for platform specific
patches is to go through the maintainer for that platform,
in this case him, who then sends pull requests to me.

Since it was late in the merge window, he suggested skipping
this step as an exception, which is something we can always do
if there is an important reason, just like you skip can all
maintainers and go directly to Linus if necessary, but the
maintainers file only documents the normal case.

     Arnd

