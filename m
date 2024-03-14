Return-Path: <linux-kernel+bounces-103715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F187C351
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C055B22166
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B1757F5;
	Thu, 14 Mar 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="YLCJfRNw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XG8uDL+y"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BC6F07E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710443206; cv=none; b=Zmp1HFVcPoUr0Oe+PLc9WRfXj0gBnBC5qzNOhUGlOx4hl8NrJMQ25vG7DKtyt5C5WJ/j3p3sXQ4VkfnXm7lXPVQU71cRZbeVcqL4dt9Mzc0ehsnY07CUFsvXfS2Cgpw+/7ykUiHsRsfeHqCwEnvPazxicJRHfssGAgkllcrBzRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710443206; c=relaxed/simple;
	bh=6u41PBoWA/dHSyhaL4eR+nAg2BC9TcZOlGX4UYE8FGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsMXGNvhZqWbU+ylI5EN19Od6BqUdCqOik2V5Xv1zm6ma5hw1wOyJVMxOrQWlqFYkBCQY1k5TzRWfU+2k7wUJsR35ZUxHyis2oOs+Lgw6n+XAuh39CwMAKo9vxC5ZND/VbzDMSAEXRvxMoCObrwK+51uWsja7SIQj/XdxF9SO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=YLCJfRNw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XG8uDL+y; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EF3E513800C5;
	Thu, 14 Mar 2024 15:06:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Mar 2024 15:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710443203; x=1710529603; bh=RCQmlGp3k6
	bvYN0RNI3MYCaArrm2bXBnNGldMBKv0+M=; b=YLCJfRNw4qk13Tk78J9I9IIvgz
	rKpSA5JCPdGaFpSiMuOt6mw/mYgvhqQsvgDDWbTMa7LrZGxa2Wp5NWfu1cqJ31nL
	GNNGe+zOhA6IaVfKOE2DxwWusgnaU8jHP+IDzf3K8qx6+zTyXa3VEV4FyQxE5Mue
	2x553yNefdBa+QG61GP0r+E6Z8R/WBuPTJoKxDPs9SXIG0olBBzueVSAxw/KQlPv
	pjUr4jhqSRxGirNbfGV+1itvpe8KpWxBTy2lBRJk0IFC8QDSkcNAZDbsnZEA3Bny
	+CbwragPCCtsQ5bz/CLXSum1zQ2gpxbiTv+VScgALJeUoI4AyzKWYLM8ElMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710443203; x=1710529603; bh=RCQmlGp3k6bvYN0RNI3MYCaArrm2
	bXBnNGldMBKv0+M=; b=XG8uDL+ylScJRiGrCkiVidUj4YLfN+EQNZKm7bLCAnxG
	Vt+n8L8Th2tykaWeNv8xbaZiyyYEMf/DWv0EFzOiPaflx32XJjQm58S4XEt179MS
	bJvAViFIko7XxKv3unGw3BCr9+88IseWiN9/pdyymPtu1j6O2WGy8FVKtY7uj8j2
	V0a6RpL/OG/8aU9b9ZZCySn0BXMyFD9+SV4z8D3XFZy7QjhmW3MpkVIFgUJ4bU/v
	QV9edp2cYZakyFIP0e+eRXTiE587rB1XJAODraG8p8yyGlfB44dCJRQEUaezii46
	zrqUFkYhIhF99pCzORwXWbOh4D31Kf9nylDMVQp05g==
X-ME-Sender: <xms:wkrzZTm3X2z1kPOEM0VN_ST1bY5HEk37rQlxy3QpS49AUbhU85_Egg>
    <xme:wkrzZW1V4MFhAkHFqRRFrpgwGECPtVe7ZYKhnTiIQq7atW3ZlKo9zcJ3-lRr1ss9h
    ms6Ju4YAu77uQYFW8Y>
X-ME-Received: <xmr:wkrzZZqlIFep2D75EhXrfV0zsd-6gadufwc-hY5lw21glxgzeLufu-GPv-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihlhgv
    rhcujfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvg
    hrnhepgfegkeeiffethefgteffudfhfeejhedvjefhjeekudelffdulefhfeekieeludej
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:wkrzZblKiuiTM8ni1rpAIXxmUXEmITqwifQj1TYv4Lj-tM1z8Rt0Rg>
    <xmx:wkrzZR3L085MQGYgcRz-Om_p-QxoKEpxLFYF7N-pvsQRYyoeShE9ug>
    <xmx:wkrzZaslTD7QpwoiG0ZHiJJFdh5Vhr5Y_z2m6LR-auw1IFRyXFy6aA>
    <xmx:wkrzZVU9hWbNGbtchumdcYlPSUd5shXgkdIUC-mimrk4VI4eF69Klg>
    <xmx:w0rzZate56TlPuywl8bA1AqPowO_2puZpr4eFIAhICEr-x4lSOGnXQ>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 15:06:41 -0400 (EDT)
Date: Thu, 14 Mar 2024 14:06:39 -0500
From: Tyler Hicks <code@tyhicks.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <ZfNKv70oqqwMwIeS@sequoia>
References: <ZfKsAIt8RY/JcL/V@sequoia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfKsAIt8RY/JcL/V@sequoia>

On 2024-03-14 09:55:46, Tyler Hicks wrote:
> Given that drivers are only optionally asked to implement the .shutdown
> hook, which is required to properly quiesce devices before a kexec, why
> is it that we put the ARM SMMU v1/v2 into bypass mode in the arm-smmu
> driver's own .shutdown hook?
> 
>  arm_smmu_device_shutdown() -> set SMMU_sCR0.CLIENTPD bit to 1
> 
> Driver authors often forget to even implement a .shutdown hook, which
> results in some hard-to-debug memory corruption issues in the kexec'ed
> target kernel due to pending DMA operations happening on untranslated
> addresses. Why not leave the SMMU in translate mode but clear the stream
> mapping table (or maybe even call arm_smmu_device_reset()) in the SMMU's
> .shutdown hook to prevent the memory corruption from happening in the
> first place?
> 
> Fully acknowledging that the proper fix is to quiesce the devices, I
> feel like resetting the SMMU and leaving it in translate mode across
> kexec would be more consistent with the intent behind v5.2 commit
> 954a03be033c ("iommu/arm-smmu: Break insecure users by disabling bypass
> by default"). The incoming transactions of devices, that weren't
> properly quiesced during a kexec, would be blocked until their drivers
> have a chance to reinitialize the devices in the new kernel.
> 
> I appreciate any help understanding why bypass mode is utilized here as
> I'm sure there are nuances that I haven't considered. Thank you!

I now see that Will has previously mentioned that he'd be open to such a
change:

 One thing I would be in favour of is changing the ->shutdown() code to
 honour disable_bypass=1 so that we put the SMMU in an aborting state
 instead of passthrough. Would that help at all? It would at least
 avoid the memory corruption on missing shutdown callback.

 - https://lore.kernel.org/linux-arm-kernel/20200608113852.GA3108@willie-the-truck/

Robin mentions the need to support kexec into a non-SMMU-aware OS. I
hadn't considered that bit of complexity:

 ... consider if the first kernel *did* leave it enabled with whatever
 left-over translations in place, and kexec'ed into another OS that
 wasn't SMMU-aware...

 - https://lore.kernel.org/linux-arm-kernel/e072f61a-d6cf-2e34-efd5-c1db38c5c622@arm.com/

Now that we're 3-4 years removed from that conversation, has anything
changed? Will, is there anything we'd need to watch out for if we were
to prototype this sort of change? For example, would it be wise to
disable fault interrupts when putting the SMMU in an aborting state
before kexec'ing?

Thanks again!

Tyler

