Return-Path: <linux-kernel+bounces-34024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F5837204
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1451C2AA73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A27405DD;
	Mon, 22 Jan 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EXRGo/dx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2EA405D0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949292; cv=none; b=TUtKw82FmHZbJV0DxmhojinBNuPQLq5dvHGANPkOYv6rtSZHE3hqrEzHQ3cKdz/+p7HJy3mG/NMyrnU6X0CQ+0gD7sUgIYWIlJ1tZi7RRoec20j6NhF98mL5xBdmSV7LiBFt2ONuWRfwww/Y9j/f34SqDKDWRReTjBngvVyjwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949292; c=relaxed/simple;
	bh=XSHpBvt2V7wCc/i4EefWOIw8hiJqZiIX+fFXsQb/5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u83Nd3k3zMFa2zkugkmNjeGz9+20xMQijNsyByKa0iPDbdW6yu0P7z2VkU/IBg6I9DVjr3PpjmH5nlULGcuSGr35ydblwHTKZYwWx9eYZEJJnQB4yvdA2e8oud8RZ5MBgfvugQ+dBHbrW+dU+JhyrWENU8upRLsl8uBKATg6kFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EXRGo/dx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2DE1640E01A9;
	Mon, 22 Jan 2024 18:48:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 06Jre4smaxfn; Mon, 22 Jan 2024 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705949287; bh=RyNDW7NZ0E73YW3daUqi9/kHUBRnzEMoHra0vLKJkZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXRGo/dxVX9aTdFGmY1aT1Mkn5CkQs4mPupCB4B7i7h/2OaMHc9u6KjebA3UqE4qX
	 sD8GTBtCscwTiYb6Ez/vbEV/CM/ITuGjZjrO/DDZnBgR58mD9lVszrZ5o587gY5TnB
	 iZvLy464feLvtg3b9nR71tXcTOb7LUGZ/w6YGJR/k06O/yqaGEFPpPDsFKEdL999RF
	 xHhwoEdJbKN8TBp2StAfqVd3KynA86Rw0m9x+k0mCzt9gfgSeS/7FbQ9lVTlfMRJFT
	 NThdaMlYiolg6snFzvLCNB14sG0e+95IQBVaDKXQYh9Sk5H1FH7JqyJ3aJHs0IJk6G
	 DXBjTfvHRTH4Tahu+1aFOvHvrBQXGGRzNZ++hnKkO+05f6/5Zth85xKAgcgQCG+674
	 bvy85qyodNQPotfUui6fG4whAKhE1jIO/Pg8/1sL1T4x3bhQziQheYss87hJSSlojj
	 wxfHYgVGIhUYszWgBIwagH+P/zVSSCHebaiDrBMlsYmE+Rw3KTsKmpjoztz6jz/c1e
	 6EtZ+TlNEWf9CDS74f/mAn5jy8R/KBZ+bYcdTD/dI1Amm0QQ3waXCu7QvAbM9DJslR
	 01IhNnLbUqs2C3HBrVwBXkzYeXT6auK++fNohu0IFkbwlDfttBfeX0m6R1EicOG3GV
	 i+bFZHTV6qvG3ok2iqb0bQ7w=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1171140E0196;
	Mon, 22 Jan 2024 18:47:56 +0000 (UTC)
Date: Mon, 22 Jan 2024 19:47:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	"Shen, Xiaochen" <xiaochen.shen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v2] x86/resctrl: Implement new mba_MBps throttling
 heuristic
Message-ID: <20240122184755.GCZa64W02KXyeaVXJg@fat_crate.local>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240118214213.59596-1-tony.luck@intel.com>
 <45d2891e-989a-45c9-a527-8b14ff5f8748@intel.com>
 <SJ1PR11MB60837D4884419BDC2DCAA2D2FC752@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <bfa5104f-b887-4cc4-a24c-0497b86d9dde@intel.com>
 <20240122182121.GBZa6yIYPtHQx44EU9@fat_crate.local>
 <11fc82e0-961f-4c8d-844f-ad4b99067eb3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11fc82e0-961f-4c8d-844f-ad4b99067eb3@intel.com>

On Mon, Jan 22, 2024 at 10:41:01AM -0800, Reinette Chatre wrote:
> Thank you for noting this exchange. Yes, this order applies cleanly.
> This is the list of pending resctrl fixes.

Ok, if some of the fixes need to go to Linus now, lemme know.

> There is also one pending resctrl feature, the SNC work [1], that Tony
> plans to rebase on these fixes.

Ack.

> As a side note: I did have a conversation with James about the
> MPAM work and his expectation is that the SNC work goes first.

Ok.

> I was working on a separate note to you but we can continue discussing
> the pending resctrl work here.

Separate note is fine too - however you prefer. I'll start going through
those in the coming days and we can take it from there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

