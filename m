Return-Path: <linux-kernel+bounces-101467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F987A77B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DCE1C21AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7793405C7;
	Wed, 13 Mar 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD8VgH5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F03FE5B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332510; cv=none; b=ZtNwEKehABPaKz+1GBETVlpJL5TzW7duFw4JpwPvkJ7F3QOmPUJvYXGpYT15Wa2D5TNlk/ZCx5O5X62q77h96V+R9MtFuFNWw2o5vIJCaf3/42e7YerXcwwkatNYYHkypQ/9rwzwCl1ZFZYN9Sox1Tm6OCJjzwP4JNJQ8goLzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332510; c=relaxed/simple;
	bh=Fb3rj7gE/RiwbNWbqCnRjzqmXxJGi3L4HQ8qGvyMCAo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=W0cFmwwqLjxqCoZ3I0c7uUJfxJ+09PO1buGC3vIi2mvsKm8ZeVKozjnyMHTTtnniceJRiNwok6iqXXud8Z9isZSuveb9titN48l2eB4khB2IXqVasCYdjWlSpGUDK6e/5KA0wjgTYjUoZkuh/RiTt49RPQwN0Ev5paPM+ddb7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD8VgH5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDF1C433C7;
	Wed, 13 Mar 2024 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710332509;
	bh=Fb3rj7gE/RiwbNWbqCnRjzqmXxJGi3L4HQ8qGvyMCAo=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=hD8VgH5hMQ7/x4I6LAIU9kcCxVCEBraQaJ6oGFmQNOrmZ93bZA6oKiuBIEyHpxF9C
	 RikZUvAFDewKqTSbcbI+roz3eaOtaXJzLY6mSoGVCf8IGOZd/gffJotW/s4lxMjOkD
	 6mb9LkwB3gM01LZSd/lMSIIcNEL2OuWgySZCYni1Mx2bo2SJyDEaiW1oYj6ytVm7yZ
	 d/4e5WUQpvkZBlTLGe1neAgziHpZDJz+pA82qzK2xhNL+ZqO01AOUIai0o2r4T+6WA
	 OogJWVYL0DclxMfdCfwO2y+rsb17hl3xfgCDvyA20rmN8Pi/XuFzcCxm4jGBpZaf4H
	 JqutKLV+yt05g==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0267F1200043;
	Wed, 13 Mar 2024 08:21:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 08:21:48 -0400
X-ME-Sender: <xms:W5rxZYdujilJopBxo_U8erkStv9MsW3mBsNFC6cc9FPZe0sQzDqg2Q>
    <xme:W5rxZaN1XOeeoHx9wn_hkaOEcrK9s6xmB6rIV7kxUVigByL_tYGytoNs_SQRN2wiL
    AwyRGPcg1qPlvQkro8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveevtefh
    feejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:W5rxZZjgsledSFp4BWJ8srG6hxxLuHiLW-AKCtSUyu3DmRV_CRb7Zg>
    <xmx:W5rxZd-c9S1sVOQDQy4iT307G8W3XW1iYR6PIkc7QHq64uXijy4wrw>
    <xmx:W5rxZUvpW3gwBKXlDVPb5Id8EeybqGaTHc136jR9XjsGjh7rI1GBUg>
    <xmx:W5rxZUFTxm47qKkFa0pWWd_fae_1qcn0IlQ41vhxgvYe8yC5UqnwMA>
    <xmx:W5rxZZ-uqtdG6Ek-hCcOdw157QXAheX2sp8NK39kuMIEqXrEgqI1G6avpy0>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5260EB6008D; Wed, 13 Mar 2024 08:21:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b08aaae4-8c69-47eb-9658-5f3f5c8e4056@app.fastmail.com>
In-Reply-To: <1a12c8ed-0cb5-5650-24a2-84b021c444c3@huawei.com>
References: <20240313084707.3292300-1-arnd@kernel.org>
 <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
 <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
 <1a12c8ed-0cb5-5650-24a2-84b021c444c3@huawei.com>
Date: Wed, 13 Mar 2024 13:21:26 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Zhihao Cheng" <chengzhihao1@huawei.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Richard Weinberger" <richard@nod.at>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Daniel Golle" <daniel@makrotopia.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, at 13:10, Zhihao Cheng wrote:
> =E5=9C=A8 2024/3/13 19:53, Arnd Bergmann =E5=86=99=E9=81=93:
>> On Wed, Mar 13, 2024, at 12:29, Zhihao Cheng wrote:
>>=20
>> The way it usually goes is that someone adds an open-coded
>> 64-bit division that causes a link failure, which prompts
> I'm a little confused, what kind of link failure? Could you show an ex=
ample?

The open-coded 64-bit division without using do_div() shows up as

x86_64-linux-ld: drivers/mtd/ubi/nvmem.o: in function `ubi_nvmem_reg_rea=
d':
nvmem.c:(.text+0x10a): undefined reference to `__umoddi3'
x86_64-linux-ld: nvmem.c:(.text+0x11f): undefined reference to `__udivdi=
3'
x86_64-linux-ld: drivers/mtd/ubi/nvmem.o: in function `ubi_nvmem_reg_rea=
d.cold':
nvmem.c:(.text.unlikely+0x2d): undefined reference to `__umoddi3'

The idea is that gcc expects __umoddi3 to be provided by libgcc,
but Linux intentionally leaves it out in order to catch accidental
64-bit divisions.

     Arnd

