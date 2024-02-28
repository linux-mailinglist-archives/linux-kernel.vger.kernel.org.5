Return-Path: <linux-kernel+bounces-85610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5387B86B845
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FBC1C25177
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE87146015;
	Wed, 28 Feb 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmW+BrHs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50974413;
	Wed, 28 Feb 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148909; cv=none; b=WSJkSvjgwr/RsPbcwRiGrNAxoPuWYyHXmrnZNSx5eA2nDPbzfjpAcHqGxqbCxJjsoN9Gy0Ym2XfWjBmetTi4Q+ucfD7bQC1Ihznxm8L7jLfQ/h5OckWVLM8RhxKZQx9g87GBzuDrR/UPo2jAVGfdNiVjElhRXx6sBjmG1DDHpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148909; c=relaxed/simple;
	bh=Uym1km90jfZMuTJ+0Ntvz9OhbaTkbIPMPpk5s7b4d8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=niNuQ9ocVMAa5UhFavKjKReRXOPhKUfE3LFejrUCJzRSQPYW8/qUZaQ1xUTfoCazNX51B9Ok0zXipZjMC+Ipt1VopOfqz9t85xZZXnK0QqFRrL9VSlXHNVgItY5/fCa5Lp1UyFJvZA2RTFl0dug4jAFAlQ96HQvsZMKVZ5JOsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmW+BrHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB56C433C7;
	Wed, 28 Feb 2024 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709148908;
	bh=Uym1km90jfZMuTJ+0Ntvz9OhbaTkbIPMPpk5s7b4d8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EmW+BrHsD9Qz1QoqJkLpg3c6cM9Xojkg2ra11HYCoP/1LDDOWM4P8DU+MTdP3XuxO
	 Zt+ESIF1Ll5lJikG8jYq+TM/STBZR+jWSgyLX285aY8qjiuH0ADMGxly6E3mmLSwS5
	 VFUk9G7RlY91r45tWc1oU3XB6nK9IDobx+mC9bkDnt8runGn2qNup4/lIMI8QF72PX
	 aJPfZhd7mQIxjSUN43Gp4E3/YmP2eGwEN4OIulG8Jc9dHeqq30ySZ9KKBWnqtZoZAv
	 cIg9vBxBpvX+BsFqSu4LaqOPuRkZp14PZyNTU+ng+/uLoVA4siyX3hGxPvmTnzmjr1
	 yqeh0HaBE0oPA==
Date: Wed, 28 Feb 2024 19:34:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alex Soo <yuklin.soo@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v2_1/6=5D_dt-bindings=3A_?= =?US-ASCII?Q?pinctrl=3A_starfive=3A_Add_JH8100_pinctrl?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240228170338.GA239206-robh@kernel.org>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com> <20240220064246.467216-2-yuklin.soo@starfivetech.com> <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org> <20240220-bottling-reverence-e0ee08f48ccc@spud> <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org> <20240223002443.GA3877354-robh@kernel.org> <caea26e2-6598-4796-b199-4ee5b1b9cd30@linaro.org> <20240224-smudgy-eldercare-d5d8640d9961@spud> <20240228170338.GA239206-robh@kernel.org>
Message-ID: <6CB89570-8BBE-4323-AB75-4D0582AD1058@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28 February 2024 17:03:38 GMT, Rob Herring <robh@kernel=2Eorg> wrote:
>On Sat, Feb 24, 2024 at 07:20:30PM +0000, Conor Dooley wrote:
>> On Sat, Feb 24, 2024 at 09:46:53AM +0100, Krzysztof Kozlowski wrote:
>> > > I would like a solution though=2E The only idea I have is passing=
=20
>> > > SystemReady cert, but that's an Arm thing=2E
>>=20
>> I don't know jack about SystemReady
>
>AIUI, Risc-V is working on something similar=2E=2E=2E=20

Probably, but there's a few other things they need to ratify first w=2Er=
=2Et=2E booting before they're at the point of implementing something like =
SR=2E
They still seem to think they need to invent their own discovery mechanism=
, so my hopes aren't super high for what they produce=2E

>
>The primary intent of it is to enable installing off-the-shelf OSs=2E
>
>> - I had it in my head that it was a
>> system level certification=2E I am wondering how you think that
>> SystemReady certification would apply to a whole binding (I can see it
>> being a per-compatible thing, but that would be a mess I am sure)=2E
>
>There's a lot of pieces, but I'll stick to the DT aspects (which is=20
>SystemReady IR band)=2E Certification applies to a specific firmware buil=
d=20
>(which includes the DTB) on a specific board=2E The testing requirements=
=20
>at the moment (for 2=2Ex) are every binding (compatible) must have a=20
>schema, but warnings are allowed=2E=20
>
>So a "stable" tag would apply to a DTS as a whole=2E That of course=20
>implies that everything within the DTS is stable too=2E=20

Right, so it would be on a per-compatible basis then=2E I guess not altoge=
ther different from marking a compatible deprecated=2E

>One wrinkle is that SR has no direct requirement that the DTB come from=
=20
>anything upstream=2E Indirectly, the schemas must exist and be upstream=
=20
>(or acked on the lists) and various distro kernels have to actually=20
>boot=2E For that reason, if we had some tag, it would have to be=20
>distinct from SR=2E

And for the reason that other architectures may want to use it I suppose!

