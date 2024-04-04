Return-Path: <linux-kernel+bounces-131827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA7898C41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEC71C22E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1451010;
	Thu,  4 Apr 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JrMIpjKD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013F1BDC8;
	Thu,  4 Apr 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248596; cv=none; b=IUbJXtBVHnjkA66uhZ9KXHZkhLujdD7QLHMI2L5KWwlBq3+3+NUl89mf6hZYQojcb1PHyO5PCmhYuWSMOgh3CwZ/Gd2SgKAZe/9aI7B+0DLuzouSDt+cAERzXHewD5NEjD8fVsD5jKbFWfAq264cgoV/ITlgZy8a/l40vAal3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248596; c=relaxed/simple;
	bh=Dh3cRkMTiRudMMG7cHzZOisAQ/Yalp2K8TTsTMFLfvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eng5K+0Xug4xyjvbw7SU9vEa8k45Mfmt5jh7xkClYu2RZLJ4/nlQjn6vq90/GEwO/8EZoBgCyd8PJy41860hKGIhMwaAVHe05XAjV71j9yyrT1NnKLQxDeE5Lnc7RIT0ZMMMOthijEVXucGGGfPn0Alm6jtNeNtyCOb6AaX4uqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JrMIpjKD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1AC7240E019C;
	Thu,  4 Apr 2024 16:36:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TfPF_F9SbhmA; Thu,  4 Apr 2024 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712248584; bh=KueuMthQyFuh1EUtl71hsDsrfCIfV7rRzPJCe1tTIII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrMIpjKDyHyQBdBzuGGFh3O5qgBWadAjSU3MwaI32SFrS6h38tCMESdnSTs4ITKNx
	 G/gMkKvf8044Js6qF60TuL7Qih51pDlfaCmwEF6cB9xwbALE8YOf09chbEZKwm6wji
	 b2jgMXmcgfyKdRdspRCgRvkULSXLAk22sbz/3oZqR5ssaARGTC1ijLuD05TW1cKXFo
	 2GWp03UPSGgd1CUTK2rp3+0FOhjLRaJMr8/lKPCvJfmo3jqh59nGh36lGn1LG3SMtS
	 uD2j5KMtVSxR/9NvUXr0mOZMz07Q+vejlm7ryyFWvFkmN7kWXdYU9z8wCLw0y8HhxO
	 XfWBU4CHITg/5g6zUX3yPHNnJhJMVSiSgpeRUuZHxpakyfpU8Zk+jG3miLSSCTAW6h
	 29IaelmZLag8Cwx7o9CJ+olPrM9sGTce8qjxOjtFyBICVskq0gB1piRjM43qy/1LNL
	 vziI7vEHtQ6RZmkkH0/xJQGR7YKawSmo9umMRU4UUyLb+7pLlHEdk8H0Rx5oRUIVMl
	 D7RSUfKnev0C7f66BACl/BmlEV/ntwWfQP62JzZRgT+LctNov/5VPdH8LRDn0iJZsi
	 u9lvxC8r65cbLZibTU8ec9ClJkoUGYijIvw7uyoSgw46matbm5qwlRkGyDiaNwraPn
	 EnS4mGep9DhzSRtkn4epliIQ=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B281240E0192;
	Thu,  4 Apr 2024 16:36:17 +0000 (UTC)
Date: Thu, 4 Apr 2024 18:36:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/mc_sysfs: Convert sprintf/snprintf to sysfs_emit
Message-ID: <20240404163612.GFZg7W_EN-JrPwnrSx@fat_crate.local>
References: <20240314084628.1322006-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240314084628.1322006-1-lizhijian@fujitsu.com>

On Thu, Mar 14, 2024 at 04:46:28PM +0800, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() will be converted as weel if they have.
> 
> Generally, this patch is generated by
> make coccicheck M=<path/to/file> MODE=patch \
> COCCI=scripts/coccinelle/api/device_attr_show.cocci
> 
> No functional change intended
> 
> CC: Borislav Petkov <bp@alien8.de>
> CC: Tony Luck <tony.luck@intel.com>
> CC: James Morse <james.morse@arm.com>
> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> CC: Robert Richter <rric@kernel.org>
> CC: linux-edac@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  drivers/edac/edac_mc_sysfs.c | 48 ++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

