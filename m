Return-Path: <linux-kernel+bounces-62389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A788F851F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654812815A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375524CB51;
	Mon, 12 Feb 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hf+6DOBZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB41DDC5;
	Mon, 12 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773283; cv=none; b=RYK/dn7uGogRPwbMRSWjZTWH8hAP8avlZ762GQHXI/9G7Gqyw3KQtPKJLjhymVAt0Ur8zIl7MsmzkJHMGF0enOalzBY0ZcCzo8fZaeYYAyNHqBFByDv2PgPG09D2YAyJ2AQJOA4eez8Qk5mhtJU9wMRxagO6TaEsSlRVlJ8V8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773283; c=relaxed/simple;
	bh=YZ61mZF1bLjrVmSJ2CG1mBsGDRT77xZa5jGT7hzxP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGfKO0MUMSqQEWn0H02iN+pjriU87m63OmNIvHnxCAVGAyBsOA1AjvtKAq+PhLncoavncre1dmJ9GSBOHZOW4j1mtRyW+x6X7Ph0d0diyOt7xH/biT0ZgqAETEPzZ+gYI3NSsU+ESW1XXobZF8NXHz2AcQzn0BaI1By4bs6AKf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hf+6DOBZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D00CD40E01F7;
	Mon, 12 Feb 2024 21:27:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z0DJA0e8CGyn; Mon, 12 Feb 2024 21:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707773275; bh=tV41PkOi77BQFnFr1wJW0H9Ckl+9yDY0EbtAyYtf1Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hf+6DOBZzTaQ3ZhX3SjZcByUdotf9YaR4x+7FZM9rfKzAqvoG7j9xbQBIsq6cswwu
	 JuDRf0fRDEMICT1EMQC0Qx9ls11wUNDgCfP/BDkqtk+XRjKkX6OBnjtks7VlfnFZY6
	 mXiIdL/GLOuZbJu+LZQb9jQMWnbXyVCdYuYvEm3T9TTcpAMWbk8TUy5QMt1BHJPWxL
	 L3+1+T6UII6opfqSBmVzSXSV4wDFczrc7sERZvP6szkUEO1sMDH8RGgbRM7EY89vMX
	 5beizSU2az/3T/pl1adQ+M7TqRh//ty+mP6dvyYsTPymJ8wyK6t16juRztsXUvRrXR
	 XBRQkVILzv2S1jzhgUN1WBwxeRp7io+kxKQzwcIEj8jMDef4gn6e85mp5HHlxWA9k2
	 4JU98g0+u99CQY2OQGEuOVrHWxhXLYmLMhOiyfdFIzsFe+7ug/vlc6/2fApMCclPdx
	 BzqucckzhTXlfxAzyvzbnjefXVW9KeTKD0boG5RWYLmT+hcANFMdAYYS1z73eRBbQq
	 6xXzB5Jz+X9iK087jMueZGRAhCSfAy6ZlhbY9bA6bKoEPSYbhKnhe052gR0nFxNIQt
	 +1kPrb0VthQB8KJTR9sE69XbWDEXahwCfoesM1YvnSLclC/d4HWUJGRuwI94lfS1XA
	 NATXatAKpbJZyb38RIrjds9I=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54D3340E0192;
	Mon, 12 Feb 2024 21:27:46 +0000 (UTC)
Date: Mon, 12 Feb 2024 22:27:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212212741.GPZcqNTXfU2OX7uRtx@fat_crate.local>
References: <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
 <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>

On Mon, Feb 12, 2024 at 12:44:06PM -0800, Paul E. McKenney wrote:
> If it is the #MC adding new memory, agreed.
> 
> If the #MC is simply traversing the list, and the interrupted context
> was in the midst of adding a new element, this should be no worse than
> some other CPU traversing the list while this CPU is in the midst of
> adding a new element.

Right, Tony answered which context is doing what.

What I'm still scratching my head over is, why grab a spinlock around

	list_add_rcu(&chunk->next_chunk, &pool->chunks);

?

That's the part that looks really weird.

And that's the interrupted context, yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

