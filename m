Return-Path: <linux-kernel+bounces-153322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F279A8ACC8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4920FB23F40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E73146D75;
	Mon, 22 Apr 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iRaGRCnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NctAszhT"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC87524A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787890; cv=none; b=YjQqbzF+o5D+syhQHih43b1nOjbNuvBPbG1qRovRZ1CE3wCyqzdISY4ivJGq6G7fJc6zyMDDqrzL5z4+GWyKVRordtI4P6xVPLoDTQdgqtpnfT5XYpY6mcFXI7yllqMYATRm6JUKCOD8beoHUUQFKz9atgncj62BLmE87/HaCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787890; c=relaxed/simple;
	bh=dC5ZHd6Ky5vV2tsL7oXY8FeusJcsi4Qa/hgIGs3LA54=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YlN1YocqkeLGXSPxiJRevbngw6tzhHg3C4m0pkd7SZ77QY8idyP8R5ko6TzFwaUWa0XMH3IV1Hmb9vZ9DdEp+0M1TSJHbjTO+CxUQDKn0EXYLwyVYupYx8CrCxr/mhMh0pIc6b/tRKkzn3BaCuFYP5Uoc1sLVyaV631GLxpJArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iRaGRCnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NctAszhT; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D477618000F4;
	Mon, 22 Apr 2024 08:11:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 08:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713787886; x=1713874286; bh=KRP2elrmum
	xH8cocnCA8ROfbtX6U7yx5lVj+wpAn/3U=; b=iRaGRCnfyLCk8nPe1wdbVCJHaJ
	AfoHsMJGRPizCPI7ebQcmNjfh0Zdm2mAEhc2GsOposVkn9UGMQYCMoLCCjV8JQmi
	CXH2t70iGdJTslbh/MEdXbbMpygD7vgAYotST7KP1rz/EV0P8kMtT6aiMkC7wGs/
	igpQyEcoQOVu0XA1X/cN1LRqfezAsoylcxgy1G/p/NxnhaLhzwoLYg4V7ROMmSqB
	zKwjn0xIa3lFC+CNdfcBydjDSl+yD/i6B34B0KBVRFx5vDv8BghH5JR+5G5imKb7
	4E3RaNf6GWpH7dPSVa2LnkreSNO8Iv9BZUhYGVBelUQoagQ+4ZpbQ3udtNbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713787886; x=1713874286; bh=KRP2elrmumxH8cocnCA8ROfbtX6U
	7yx5lVj+wpAn/3U=; b=NctAszhT/BSUcWRrsLUXj9jx+ADe4Wveh+7L8/vLnk4u
	mDzYVuDcBGoZJ37mqcPm5OlOLn5A6+a3W5jZGDKOprWsuMFxUkfpO/bB19/A6AwX
	vS4gXbYztBEWVyiAS0ojUD1NOx031uvlr8AMHUYrZmX0sdSdaIRLE2GospL3aC/M
	azdrJQf4bAAQrmu1YnNDezEJOoRRa7MCRw3UyIb9oX6pXekTcfZs/V7Ty0gis4A7
	uePT1ISot3KAoLKvFfZYZCyvX/fMd5fpx6UlZ8ZPHtOjSYwel48tqugQ/SKqS3xK
	4NqoXwLUXRIRFP3bqUxs8Zj+t5oVk7sektctWuBp0A==
X-ME-Sender: <xms:7VMmZpxHI4e3nfaqSzK_VLo7pSuy4vhzpGT1NM8pG8F_Xthrs61O7w>
    <xme:7VMmZpTBIdCzEvlcnyNChRV0jYYGVjrmEhwyz4oB396MWhX9O4ZAvgEmztuCvCGc4
    LNyt7L8o_AGJwzZGyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7lMmZjW8Grb-3NXHtMadwtAI8w8tcRBTUCbov2hOQxG8VuUr_fogxg>
    <xmx:7lMmZrgsOUpMy8PJywH4FfMtSSCm-SHkwVzhJqP-oFvKmhDIWovKpg>
    <xmx:7lMmZrAeaf5Q0P2IDwadXuF9pBNghAyBAZTyL3GwX7vVUHlc5kI8jQ>
    <xmx:7lMmZkLNei8_f1c4vS6AAeI-cUTFSt-IA7tDruhR1ruQCefDPieV9w>
    <xmx:7lMmZnvrUqvRiqaaeXLdbCyTPxDF5RZSuEePwy8PtDZkvReBrR6Ih4Q_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DC779B6008D; Mon, 22 Apr 2024 08:11:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <df782e40-95bf-4f8e-96c8-355ff0109e3a@app.fastmail.com>
In-Reply-To: <ZiYwkKLRVgvrQrnK@FVFF77S0Q05N>
References: 
 <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>
 <ZiYqV-5BWmPwgqbU@FVFF77S0Q05N>
 <cd172d05-15f6-427c-b6e3-d68fc746b940@app.fastmail.com>
 <ZiYwkKLRVgvrQrnK@FVFF77S0Q05N>
Date: Mon, 22 Apr 2024 14:11:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Anders Roxell" <anders.roxell@linaro.org>, "Marc Zyngier" <maz@kernel.org>,
 joey.gouly@arm.com, "Oliver Upton" <oliver.upton@linux.dev>
Subject: Re: gcc-8: arm64/kvm/pauth.: Error: unknown architectural extension `pauth'
Content-Type: text/plain

On Mon, Apr 22, 2024, at 11:40, Mark Rutland wrote:
> On Mon, Apr 22, 2024 at 11:25:25AM +0200, Arnd Bergmann wrote:
>> On Mon, Apr 22, 2024, at 11:13, Mark Rutland wrote:
>> > On Mon, Apr 22, 2024 at 02:04:43PM +0530, Naresh Kamboju wrote:
>> > Given the minimum supported toolchain comes with an assembler that doesn't
>> > necessarily support ARMv8.3, I reckon we'll either have to make NV pauth
>> > support depend upon AS_HAS_ARMV8_3, or manually assemble the PACGA instruction.
>> >
>> > I suspect the latter is the better option.
>> 
>> The .config linked from the report shows
>> 
>> CONFIG_AS_VERSION=23101
>> CONFIG_ARM64_PTR_AUTH_KERNEL=y
>> CONFIG_AS_HAS_ARMV8_3=y
>> 
>> So it gets detected as supporting ARMv8.3. Is this the wrong
>> conditional to check, or does it get misdetected for an unsupported
>> assembler?
>
> I suspect that means the 'pauth' arch extension was added after armv8.3
> support, and the assembler supports `-march=armv8.3-a` but does not support
> `.arch_extension pauth`. So for this code, it'd be wrong to check for
> AS_HAS_ARMV8_3, unless we used `.march armv8.3-a`, but even then that'd still
> mean configurations where we couldn't support this code.
>
> I reckon manually assembing the PACGA is the best thing to do; that sidesteps
> the need for either `.arch_extension pauth` or `.march armv8.3-a`, and aligns
> with what we do for CONFIG_ARM64_PTR_AUTH=y generally.
>
> Elsewhere in the kernel where we check for CONFIG_AS_HAS_ARMV8_3, we rely on
> ARM64_ASM_PREAMBLE containing `.arch armv8.3-a` or a later version that implies
> the presence of ARMv8.3-A instructions, and so pauth usage elsewhere is fine.

I tested with the old binutils versions I have here and found
that anything that supports v8.3 also understands pacga, but
'.arch_extension pauth' only works in binutils-2.35 and higher,
presumably because it started out as a v8.3+ feature but was
later turned into an optional extension for all versions.

Since there is a Kconfig check for armv8.3-a support already, I think
it's safe to just drop the .arch_extension pauth.

      Arnd

