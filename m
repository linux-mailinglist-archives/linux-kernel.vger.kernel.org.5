Return-Path: <linux-kernel+bounces-153850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612C8AD426
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5AC1F21636
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4CC155306;
	Mon, 22 Apr 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LuHyid2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRu3qVFL"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C70154457
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811502; cv=none; b=Vul+M85P7HJW4E334YmE4IlXfonYhtqReViijKTag8PfoynHhkat8CVQ2n92Dtp9OzkhaA7cnFwHFllQM1xeCLc3ESg5cLIC38SXKxjmoyZn0vMeyFm+neDeA8O0/Th8C0bhMHWLR+dhtn06MGBq0I9qdIgVU4/Js/QdoMWVde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811502; c=relaxed/simple;
	bh=Zg08VAu8nauRpnIvDrJshr55IRiYbKhYfj6bJE3SDsA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=C7Or84xZWw3+ZE9bbWCFvlqJ8w1ndw6PEPRlQ1HRxios4/lwprNXAz20JoqmXuvV7M1nnkkT5PN6EKrk/X9XweRJ3CV54hYK+RGODzsPA/WkoUmD4pk+HYdTRa4sJrOe7UsojO6sO8Z1Sh6C3F6Kh980Q86pOuBaqtQ7Xra+WbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LuHyid2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRu3qVFL; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A23E11C00063;
	Mon, 22 Apr 2024 14:44:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 14:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713811499; x=1713897899; bh=mgft6jUidp
	z5CjRfMsllDHpy7KhXWOBMGIK16U9uPOY=; b=LuHyid2LIkWHT0mCJwc9WYSdxQ
	YGMmmIKdzCoY3gEmyqI1dNXzrPEftDl4FZWzvXPliN7TmV54MzY6TXw2w1Bsr8ex
	N2aeKCn60gxIJhlkg6CI8+na9MJ/oF5IMULpGuYjQwTHNaQk1b5OSAGfKXXqljvc
	ar+5ysi54MtFdGBs6GT11PyXa3m4aLJeIBFocB+Nq8h8UL4AmBWoVFJHqb2DtzBf
	HrxJOeZWECRhLYJeC06uxMw9vkjpqol1rIQYv07j95PpLPOGj7JiQUIi+LDdFCjk
	zgMGLORgCYXc41qtUQvIS1euirFr2zUN2EK7Ha0Qa7xvx40SzxtYzRYHf80A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713811499; x=1713897899; bh=mgft6jUidpz5CjRfMsllDHpy7KhX
	WOBMGIK16U9uPOY=; b=KRu3qVFLTAuHUE1zOb07/xhMC+3beUldNJrS6HjA/QFM
	ZXEJzUPlo1Jz1KX6Rw455uE1YnVrOIxm0IXZJSWYzZjJGXRnfzdtsLihuwH8Cvhd
	HECHwMAtpZ47myEM5YgOE34VMTrG/qf8bksjBuLAL3XX3CuJslEFAys4l8tW9eZr
	clV6EUPeNYOXBV7DMyQulSRyLk+aMBWdjmUqWAJTs8bf/dmEFKBgcCwuCiXVa+yh
	GYaU2cVUzRGN5ytm8h3H3L2H7lS3aws3MoQp0b3jCXBFmGXFr5zonkJuV5gbKpu9
	8vAxqB7MnNR5bm9mOvv9VQJdOOA/hG6mnVwIyuPiMg==
X-ME-Sender: <xms:KrAmZhHumwRg82-kFREhL7wbr7uJPl1AHuqFICMCDLV2W_ftX_9JDg>
    <xme:KrAmZmW_6Yv9YxSFtVh5l2Yg1treuyZn4pZdn6uJ4xAtDLubgrJ5QsBSsel0dTLCf
    Zw1Tm3tVZtZXUimPhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KrAmZjKU95KCUJ3ji46TssMCG3ORz-ezjiPJwtA3oqI2rdqRt8fW7w>
    <xmx:KrAmZnFxikEtwVA4o2Y-cRoIIFUK2mW1UMmdMxurgg0LYnOLwUviJw>
    <xmx:KrAmZnWXTRhHGGtzoUmjQwetE1XE0BYMDBhQ1_oPl2DeClY_rnZRWQ>
    <xmx:KrAmZiM336VRIFhL2GExtjrlM5SGfPu0zzW9ln0MsEgNO97VYTimXA>
    <xmx:K7AmZnTQUp18hxmoDRZbII8zjBzs3J-AXYX5Vb2Gr4jlh1KAMoD5ccxQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3EAADB6008D; Mon, 22 Apr 2024 14:44:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24db3769-9b50-4cf9-b5f6-a8cc068f064d@app.fastmail.com>
In-Reply-To: <ZiacX2iNP_bI884s@FVFF77S0Q05N>
References: 
 <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>
 <ZiYqV-5BWmPwgqbU@FVFF77S0Q05N>
 <cd172d05-15f6-427c-b6e3-d68fc746b940@app.fastmail.com>
 <ZiYwkKLRVgvrQrnK@FVFF77S0Q05N>
 <df782e40-95bf-4f8e-96c8-355ff0109e3a@app.fastmail.com>
 <ZiacX2iNP_bI884s@FVFF77S0Q05N>
Date: Mon, 22 Apr 2024 20:44:37 +0200
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

On Mon, Apr 22, 2024, at 19:20, Mark Rutland wrote:
> On Mon, Apr 22, 2024 at 02:11:05PM +0200, Arnd Bergmann wrote:
>> On Mon, Apr 22, 2024, at 11:40, Mark Rutland wrote:
>> > On Mon, Apr 22, 2024 at 11:25:25AM +0200, Arnd Bergmann wrote:
>> >> On Mon, Apr 22, 2024, at 11:13, Mark Rutland wrote:

>> > the presence of ARMv8.3-A instructions, and so pauth usage elsewhere is fine.
>> 
>> I tested with the old binutils versions I have here and found
>> that anything that supports v8.3 also understands pacga, but
>> '.arch_extension pauth' only works in binutils-2.35 and higher,
>> presumably because it started out as a v8.3+ feature but was
>> later turned into an optional extension for all versions.
>> 
>> Since there is a Kconfig check for armv8.3-a support already, I think
>> it's safe to just drop the .arch_extension pauth.
>
> That'll be safe, but it does mean that we'd need to *not* support pointer auth
> for nested virt when we have a toolchain for which CONFIG_AS_HAS_ARMV8_3=n,
> unless our minimum supported AS supports ARMv8.3.
>
> If our minimum supported AS *doesn't* support ARMv8.3, then we'd either need a
> new Kconfig symbol for NV_PAUTH support, or make CONFIG_ARM64_PTR_AUTH depend
> upon CONFIG_AS_HAS_ARMV8_3.
>
> AFAICT our options are:
>
> (a) Manually assembly PACGA
>
> (b) Change CONFIG_ARM64_PTR_AUTH to depend upon CONFIG_AS_HAS_ARMV8_3=y
>
> (c) Add and use new Kconfig symbol for NV PAUTH, dependent upon
>     CONFIG_AS_HAS_ARMV8_3=y
>
> (d) Bump the minimum supported version of AS so that we can depend upon ARMv8.3
>     support, and just open-code the ".arch armv8.3-a" in the NV pauth code.
>
> ... and maybe some variations on that.

Right, I misread the current Kconfig logic and assumed that
we already do b), but it's conly CONFIG_ARM64_PTR_AUTH_KERNEL
that depends on CONFIG_AS_HAS_ARMV8_3, not the
more global CONFIG_ARM64_PTR_AUTH.

I think any of the above would be fine. I see that binutils-2.28
was the first version to include armv8.3-a support back in 2016.
The only distros that are old enough to ship something older
than that (rhel 7, sles 12, debian 8) also ship with a gcc version
that no longer builds the kernel, so doing b) would be the minimum
effort fix and still have very little risk of anyone having to
turn it off.

     Arnd

