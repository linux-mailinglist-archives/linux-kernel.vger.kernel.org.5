Return-Path: <linux-kernel+bounces-122461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF4F88F7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5731C240D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951B4F5F2;
	Thu, 28 Mar 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdYeJAAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233CF503;
	Thu, 28 Mar 2024 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607317; cv=none; b=MlrrAVn4IO/lAMv6YxvWkZQEQ9IPevZJGVhddZDNN1Knh07YhNbnTm5mwEY96pkGw8sBhV6r1tlDNjeCb5ftEstm3ZELdnD+b0YyzsVt4UzTs5sPF6q3Da4sC3rh2uL9yej7WtLlrD/RqfiEvv2ub6tJ+dODAf9cxayFSQm8Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607317; c=relaxed/simple;
	bh=alkregifthNoKgf0knvmSztmwMl6qxa+qfrKKKmyuOY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IINmrbXjiW8tTEyU23aHPxuvbg3E6KNeVQFzwh5ymYyiKxA9LwCFP4jyCGnRrzWAOIVRSmLFe2jMVVWFFbh2a/Km/BeYG6DB8jFW7t7zCXwHDk3hJJFyJEQvBeT0gADN3X8BlcfXib6Qa/FSeam6NMYIuF6w3ITeMyLGaLaBEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdYeJAAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8414C433F1;
	Thu, 28 Mar 2024 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711607316;
	bh=alkregifthNoKgf0knvmSztmwMl6qxa+qfrKKKmyuOY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pdYeJAAPvle33p3XncMyP/d/A165zS0CTX+VwrnSAVDMgWuHaJWudMfJHD6qKcbql
	 AOd2aNGZstAVTuHPVChrrB90F3wcr7ruu3czVfVHXij/MJ6wgSoh3Ugz1cDDHGryCD
	 59Y3hjOMK4BfQ6/qN946LnUfViCeYC1cwtnT9/0Y1tUBe1lYQa8o2i3CshS82BtfjI
	 4R9xSLqXW/jX3JnUsTk2MIp3qR3Si1BD033rvl0Hhrq4bNZ2y5l6hSqSo/JWzZVg0N
	 ECwMNdRcINOFXUKSbTNQL6YPTFwBwqeELBjSVGbyvSlPahXavufap/O+M8QAInwjJd
	 E5e5ddZYZAKxA==
Date: Thu, 28 Mar 2024 06:28:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
CC: Conor Dooley <conor.dooley@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jack Zhu <jack.zhu@starfivetech.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_=E5=9B=9E=E5=A4=8D=3A_=E5=9B=9E=E5=A4=8D=3A_?=
 =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=3A_=5BPATCH_v?=
 =?UTF-8?Q?1_1/2=5D_dt-bindings=3A_medi?=
 =?UTF-8?Q?a=3A_starfive=3A_Match_driver_and_yaml_property_names?=
User-Agent: K-9 Mail for Android
In-Reply-To: <SHXPR01MB0671EA5AED87CE14113148E7F23BA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com> <20240119100639.84029-2-changhuang.liang@starfivetech.com> <20240119-despair-festival-59ab2d4d896b@wendy> <SHXPR01MB0671E2150D9A2707F12E0901F270A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn> <20240119-preamble-calm-7724e17fcebc@wendy> <BJXPR01MB0662E6EEEEF888BD90A1FCE5F275A@BJXPR01MB0662.CHNPR01.prod.partner.outlook.cn> <20240122-uncivil-almost-631137081fd9@spud> <20240327-unlucky-bulge-2bf99a8649be@spud> <SHXPR01MB0671EA5AED87CE14113148E7F23BA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Message-ID: <C3D2F0B5-CB35-488E-842E-D049CA067475@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28 March 2024 01:06:42 GMT, Changhuang Liang <changhuang=2Eliang@starfi=
vetech=2Ecom> wrote:
>Hi, Conor,
>
>> On Mon, Jan 22, 2024 at 08:24:51AM +0000, Conor Dooley wrote:
>[=2E=2E=2E]
>> > > > > > Do these clocks etc exist but are not used by the driver?
>> > > > > >
>> > > > > > Or do they not exist at all?
>> > > > > >
>> > > > > > The two are very different!
>> > > >
>> > > > > These clocks etc exist but are not used by the driver=2E
>> > > >
>> > > > That's not an acceptable reason for removing them from the
>> > > > binding=2E If they exist, they should be documented, regardless o=
f
>> > > > whether the driver makes use of them=2E NAK=2E
>> > >
>> > > If so, how to avoid the warning of dtbs_check=2E
>> >
>> > By also adding the clocks, resets and interrupts to the dts=2E
>>=20
>> Going through patchwork stuff now that the merge window is done=2E I'm =
gonna
>> mark the dts patch as changes requeted=2E The binding (and dts) should
>> describe all of the clocks the hardware has, whether or not you choose =
to use
>> them all in software does not matter=2E Can you please resend the dts p=
atch,
>> with all of the clocks, resets and interrupts present?
>>=20
>
>You have applied the dts patch=2E
>https://lore=2Ekernel=2Eorg/all/20240219032741=2E18387-1-changhuang=2Elia=
ng@starfivetech=2Ecom/

Oh, sorry for the noise then=2E I guess I was
mislead by patchwork marking this as new :)

