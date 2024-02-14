Return-Path: <linux-kernel+bounces-65455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEAB854D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164DD284798
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25575D90F;
	Wed, 14 Feb 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K7ESGCYk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC95D49E;
	Wed, 14 Feb 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925773; cv=none; b=QiXeMXIM45W9a0sik69K7k/DwEt7n0jJqyYs9qhHPmTbppi0rXU1WXu9LShLIMOTM/SG3O8/sE8gYi7QX54x4ppnfQIQRLgXXmGUdkjmBaAV3razhA5oULps5HFdM+YXxyh+GMaiOqPPzfdohUMCWzYttlbHZx5hC8N0ZwNcOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925773; c=relaxed/simple;
	bh=Gy3naTrTrkVQJBqZTKkNJV3VvsQTnwDJIhWikooQnEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB4CQ6Vv6PxLySw+2AClr6hhDxNQvz54dz24IEzlfBG+pVfOb5WO4kDE+7AdAMRnukyN/Jl+7Z5lhn55NqUDpXBohtVLkdPoDbMAykMxALlHBB4UiYkzZwrRkSDGUXkiRJoIfSMIdrPItrhxb93MRZ2wjIIa5gLwTI9noRUupME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K7ESGCYk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CBE1D40E00B2;
	Wed, 14 Feb 2024 15:49:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k0YDfKUfjBmh; Wed, 14 Feb 2024 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707925764; bh=zYa3btJgqbNBe3d7qFp0v1+RbM0bAczz4bEAIz7Hrd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7ESGCYkeSNVdBp6sZ9+SFcQBHrzCWO+/YjGGaEyRah3yWLdjJYP6vDjTaL2E6r6K
	 3hp/l95VKjxjHChd9I7YYGOf8uQE5lUKhqBLMkUko/sa38ejy31BSEZJyTx9LSy/Yb
	 ODIQf2nq+lqc2Enx4B8FI+P+vtOVcqTPPaKD0AG5es9prigfhgKHZRlR5WhiqFyml2
	 Y6ATbht+ANvGTqbfCVKxzzRgeBgRFKEe8+bsREnh4n5bczTXsyJadkhcRlmNdFE41V
	 UXLb15j6kvt5XowsAwf2bZzSG3nENTzcQHAGyOnvEz1JH7fRtvrdSM1meCJZqzU8RN
	 4Cum4Qe1ubIeiJNk7BY8c30rwlg9OLdAEYdrHS+nTy6maQDR1ypnF2HVPcIYw9nAsj
	 oEXx76MRwFZQJ+gCZKQVvVysvwZwPjlQy9BlSfz5AjaoawfP6csSr6SG4aR5EXpify
	 v9j2nV74yC8SPaKdZF0UKh4l2IamD0shTvWhNj37WIX5d+sucDZOuSstOX3m+A/wYa
	 9fMM2aSB1ro6jYtnVMncKjgY068+XBnXIebwFx/46FNssVSZw9nQ1IN6qYhTtMLNhL
	 ye+zrTYUA4Xq1v0S//AD3E3jNQhcWTop/bRtOox/LWDqZF2xf+s6j2suIKhfJiaudL
	 GRMQ4wR72RSkg6uC2LmUjd2Y=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5C7C40E01A9;
	Wed, 14 Feb 2024 15:49:14 +0000 (UTC)
Date: Wed, 14 Feb 2024 16:49:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214154909.GCZczg9Zfb_PXu2qV2@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214090630.GAZcyClhFloQfHEqrC@fat_crate.local>
 <9a82e9af-24c0-4277-b4d0-a708bba2cc88@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a82e9af-24c0-4277-b4d0-a708bba2cc88@amd.com>

On Wed, Feb 14, 2024 at 09:21:45AM -0500, Yazen Ghannam wrote:
> Do you mean this should be left out of the commit message?

Yes, the text should talk only about what the patch does. What can and
will and won't happen in the future doesn't matter.

IOW, here's what I have now:

RAS: Introduce a FRU memory poison manager

Memory errors are an expected occurrence on systems with high memory
density. Generally, errors within a small number of unique physical
locations are acceptable, based on manufacturer and/or admin policy.
During run time, memory with errors may be retired so it is no longer
used by the system. This is done in mm through page poisoning, and the
effect will remain until the system is restarted.

If a memory location is consistently faulty, then the same run time
error handling may occur in the next reboot cycle, leading to
terminating jobs due to that already known bad memory. This could be
prevented if information from the previous boot was not lost.

Some add-in cards with driver-managed memory have on-board persistent
storage. Their driver saves memory error information to the persistent
storage during run time. The information is then be restored after
reset, and known bad memory will be retired before the hardware is used.
A running log of bad memory locations is kept across multiple resets.

A similar solution is desirable for CPUs. However, this solution should
leverage industry-standard components as much as possible, rather than
a bespoke platform driver.

Two components are needed: a record format and a persistent storage
interface.

Implement a new module to manage the record formats on persistent
storage. Use the requirements for an AMD MI300-based system to start.
Vendor- and platform-specific details can be abstracted later as needed.

  [ bp: Massage commit message. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240214033516.1344948-3-yazen.ghannam@amd.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

