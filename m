Return-Path: <linux-kernel+bounces-109148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9ED881553
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B92F1F251B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421854BF7;
	Wed, 20 Mar 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9PJ4h2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CA54BDB;
	Wed, 20 Mar 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951334; cv=none; b=UMU8Cnzfg/n2b6rDvzNpNUjoJvGUdZpnNCJef1sm86DdmbNCKDUZG9hyhxeIT3HaamJYllT9NkG0YMbT3gZO9yl09b81xKEmw+M2BOS8yQPuEEzJUX4VSaFEuyclr1lPdS1TIJ2hCjInvKOlaghhM8+ZoAM/Ly6vU7y/E1EaHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951334; c=relaxed/simple;
	bh=ieuHVkiJ3mvxSTBYRy2oxHanwhxgK3q2OFoG5+yAQVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K95mmpF46yt9OzKCjdg+j0Oni9L92ieOwrlkSgGfoe23aRG6584ecqTspT5rXvr0g8elefCo5+xyPbaQmsRSi+aN6F71XrzDRITh34PnkHbQzmzHJudvORpJkWLdZYtI9tRXODNx/wOTXoyDQQwWYpm7O6w/YOTgCqHs4PajHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9PJ4h2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611FAC433C7;
	Wed, 20 Mar 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710951333;
	bh=ieuHVkiJ3mvxSTBYRy2oxHanwhxgK3q2OFoG5+yAQVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9PJ4h2RY6P99YTLQRRGAgHBuOSWlMhblYdFowfc+El6TXbIXtyDUKTGqG6OBwVCe
	 Vcpb7I7GcpZKqZiujvrtk5NBa39AL6WCJVugX5zE1LHScxqtqQHlsx96fBG6qYd3VF
	 a9aymwRdPN226FPrZqYAe2WhXFnfQMzz4SuZig7LigRlOy0BYdY6EuxoTPW3CHCc/0
	 QfGBTg39m+l+Tkuh7uL7+xyCk7/mqFITmZPRBZl63Q3H+YomUXfQFa9qPd+htiEuiN
	 /omcOBrFLrozCxhAqRzn0QwtnrSXhYLxT9EIOza3K8S4U9udr8EGm6ouoX/6A6rNZR
	 jNfMsiYd3GtWg==
Date: Wed, 20 Mar 2024 11:15:31 -0500
From: Rob Herring <robh@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
	dan.j.williams@intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, graf@amazon.de, bchalios@amazon.es,
	xmarcalx@amazon.co.uk, ardb@kernel.org,
	benh <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
Message-ID: <20240320161531.GA1810860-robh@kernel.org>
References: <20240319143253.22317-1-sudanl@amazon.com>
 <23692c07-98bd-477d-b244-bba14c50352c@linaro.org>
 <38aad6c0e698c8e804694276d1762d61f2068ce8.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38aad6c0e698c8e804694276d1762d61f2068ce8.camel@infradead.org>

On Wed, Mar 20, 2024 at 01:50:43PM +0000, David Woodhouse wrote:
> On Tue, 2024-03-19 at 16:24 +0100, Krzysztof Kozlowski wrote:
> > On 19/03/2024 15:32, Sudan Landge wrote:
> > > This small series of patches aims to add devicetree bindings support for
> > > the Virtual Machine Generation ID (vmgenid) driver.
> > > 
> > > Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
> > > ("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
> > > ACPI only device.
> > > We would like to extend vmgenid to support devicetree bindings because:
> > > 1. A device should not be defined as an ACPI or DT only device.

This (and the binding patch) tells me nothing about what "Virtual 
Machine Generation ID driver" is and isn't really justification for 
"why".

> > 
> > Virtual stuff is not a device, so your first assumption or rationale is
> > not correct.
> > 
> > Virtual stuff can be ACPI only, because DT is not for Virtual stuff.
> 
> I strongly disagree with this.
> 
> Discovering things is what the device-tree is *for*.

DT/ACPI is for discovering what hardware folks failed to make 
discoverable. But here, both sides are software. Can't the software 
folks do better?

This is just the latest in $hypervisor bindings[1][2][3]. The value add 
must be hypervisors because every SoC vendor seems to be creating their 
own with their own interfaces.


> We don't want to add extra complexity and overhead on both host and
> guest side to make things discoverable in a *less* efficient way.
> 
> The device-tree isn't just a last-resort for when we can't possibly do
> things differently in a discoverable way. The device-tree is a first-
> class citizen and perfectly valid choice as a way to discover things.
> 
> We shouldn't be forcing people to turn things into PCI devices just to
> avoid adding DT bindings for them.
> 
> And we *certainly* shouldn't be directing people towards all the
> awfulness of ACPI, and in-kernel bytecode interpreters, and all that
> horridness, just because we don't want to use DT to... describe things.

I assume you have other calls into the hypervisor and notifications from 
the hypervisor? Are you going to add DT nodes for each one? I'd be more 
comfortable with DT describing THE communication channel with the 
hypervisor than what sounds like a singular function. Otherwise, what's 
the next binding?

Rob

[1] https://lore.kernel.org/all/20240222-gunyah-v17-2-1e9da6763d38@quicinc.com/
[2] https://lore.kernel.org/all/20240129083302.26044-4-yi-de.wu@mediatek.com/
[3] https://lore.kernel.org/all/20240127004321.1902477-2-davidai@google.com/

