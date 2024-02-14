Return-Path: <linux-kernel+bounces-64915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E285449B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC66328E05E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE0BA27;
	Wed, 14 Feb 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XclyHH4a"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732479C1;
	Wed, 14 Feb 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901606; cv=none; b=dzphth3d5q6gUJ2cIBwt4fT46GrN52aADtLGp7QcTltsEW+k65a5vpg/FnKl8EQS6RuoUJjJhHDzinc+teOZKUMa7TBsPhTaB+8YKNhdjDhoDNBazrOp0I5BC977Z6k6wpPUEtXDVEeY2fPfiuaEJXTjPvZnE+1zkyA80ywwPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901606; c=relaxed/simple;
	bh=v6CF3BpTrGUSsgCmaynr7UBo5yv7YVghDCP+UV+GZsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpzqy4c94K2i9kvc9DR9pGv0Yntg4XCcITSRFGqUm5QU/CtgszzZ1I3snz2MXhwOp6HyeEYTQ36n5hYicryCwEHzdRM7/uqtugr+Hqh2MQY+kFcBLGVmDtwNazv32YRT21IVmpn8kFwv1rkB2sJzAyyOOkUNsvIO7imr6e1oz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XclyHH4a; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A944C40E01BB;
	Wed, 14 Feb 2024 09:06:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WFAoqrekk6z2; Wed, 14 Feb 2024 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707901600; bh=m7qXSDcgmKwDzQ9ywIS8Bb1m1pgaTfQpmMCfQ6RiYx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XclyHH4aPI1KEmd1TVMVzGEP8EApT4AdR6k/NesU9eOU3wL6XilL50DOXf72R1zNb
	 GgIRm+qGQn6COMc3C6lLh7u3IyWWphq7nAqJjEMEXAOIVF08/lJxJ6axHNsPpFduAM
	 +WyT9ddCTq81SbYNXqWEtVEOYXv9/vsim+0CJe8ZmWhjwIOLvPrLCnW1gkOptDYKpV
	 2qLCtvTJilO3TStR13ok21+KvKCf6fBk44tI/4I5k2QMe2b9WXIS3TTBPIzUy1mmoi
	 7IRb8lSfzWBVnVhl2BunjOIBAxMDzJBAAJmmW/wiMnbFPombxLAF97F9y1A9iPChSE
	 HZTucAWZVVKO8I7K4NlLWL6ldcs/fpacpksfKVwqfqzgH5bf7I/QnZA+ZajE388z5I
	 ZXiclSj3F5bIYzqZDZU+AH66haNOa5NbgKcUk4KZxZGdGjo4HdbLBtLcfwp9ECTm+6
	 dZ2ONOpzVOvQ74KFgkEwNgtnW5rQiyVeVWTwhV8PwTlkdRyzM5Ykl3jN7BjuqC64iQ
	 28aPzVNUbXQRbdcANd4vdPSJDbmRoUY2C70ZLh5l+VDVOPW7tFUZADK8V2cKjwYluJ
	 PKvqYSJ6oq9uh3F40YkU6CNBI2S8FRXlo+1uVtwW4tb8xHIRZ/24EdP+UMqwNTOAHd
	 u4WsWVL/msrdYOlxG+FOurMM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 613B940E0192;
	Wed, 14 Feb 2024 09:06:31 +0000 (UTC)
Date: Wed, 14 Feb 2024 10:06:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214090630.GAZcyClhFloQfHEqrC@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-3-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
> Memory errors are an expected occurrence on systems with high memory
> density. Generally, errors within a small number of unique physical
> locations is acceptable, based on manufacturer and/or admin policy.
> During run time, memory with errors may be retired so it is no longer
> used by the system. This is done in the kernel memory manager, and the
> effect will remain until the system is restarted.
> 
> If a memory location is consistently faulty, then the same run time
> error handling may occur in the next reboot cycle. Running jobs may be
> terminated due to previously known bad memory. This could be prevented
> if information from the previous boot was not lost.
> 
> Some add-in cards with driver-managed memory have on-board persistent
> storage. Their driver may save memory error information to the
> persistent storage during run time. The information may then be restored
> after reset, and known bad memory may be retired before use. A running
> log of bad memory locations is kept across multiple resets.

Too many "may"s above, please tone them down.

> A similar solution is desirable for CPUs. However, this solution should

GPUs you mean?

> leverage industry-standard components, as much as possible, rather than
> a bespoke platform driver.
> 
> Two components are needed: a record format and a persistent storage
> interface.
> 
> A UEFI CPER "FRU Memory Poison Section" is being proposed, along with a
> "Memory Poison Descriptor", to use for this purpose. These new structures
> are minimal, saving space on limited non-volatile memory, and extensible.
> 
> CPER-aware persistent storage interfaces, like ACPI ERST and EFI Runtime
> Variables, can be used. A new interface is not required.

I don't think stuff which is being proposed belongs here.

> Implement a new module to manage the record formats on persistent
> storage. Use the requirements for an AMD MI300-based system to start.
> Vendor- and platform-specific details can be abstracted later as needed.

This is a big diff so I'm splitting mails.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

