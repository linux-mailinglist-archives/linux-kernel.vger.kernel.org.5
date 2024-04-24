Return-Path: <linux-kernel+bounces-157291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A583B8B0F60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516EB1F229EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF84161322;
	Wed, 24 Apr 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QWF3TD5D"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CA15E1EA;
	Wed, 24 Apr 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974811; cv=none; b=NOI0qQ83BBhGNZpzjQx0ypvnXsoSLoUNeLp5xhxgK96l7wCAkWvL7Qf/u+P41JeGBZ67XSiAf2+OpPgAjaPRkOBrqDBKOEBIE+T1hp7VaMOsFIERPWr18uw2790wTc7aXvKBheE85JQ4UUaPsLFZtO5pt+iRgc8lobXK1z2G/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974811; c=relaxed/simple;
	bh=pV+VrxGvpBc3cztS2k/grcbxt+d6cI6f1QkR7t0g/z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVPvVP8uAV1MgfmWujzQTQ/8O1TucS9Sjra3NCIhs95qJChoh0Hg4YDkc4hmlRm6s/3tb/CpmypVMJiFQtsPZwBFNCVObF9iabNVa10P0m8+sCcSR/4ZQvkjeKEu8z63pAFId8qod+YiKVo3rEgGJi7Ohlp+RI7DWI7H8tnkeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QWF3TD5D; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3C07440E0177;
	Wed, 24 Apr 2024 16:06:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a1whXnU_urG2; Wed, 24 Apr 2024 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713974800; bh=eT/sJrq6XNpXYldhLxOFeSR6n1DYq3NDJUftCdjBaNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWF3TD5DfjsDxjpmOqQmkDBvJqmy2ArfExGwOQxTl1ZUOlBsHM9dtYnlQhG69Fb/7
	 iE8KAkqTm0OoHa0sqEnqNWcuhISoAq6YJGJLh2CTI2HJoTz0gwL3sxig0eL2t+XY2M
	 7wcaIOfeHdUmZE9oVDfrIbgjpsMl6j0NStBevpmYsILuDiK2NinFpnprFt/Kj8uVA+
	 CgGjjZ6BKlhY91FWBu4lXYHoICXTM/XrlbZghwGMPwi39FaWBenySPfMaq7snqnjLK
	 DHGyOx9XcOjdHxhTvqrGTHO6iAOOp87i4FR5e4l8X/niXuR8947AHiBMYDsv+0p+ie
	 t5by9FFOxn4v6FEVb6CCDgwFRUmOGmr9k5AGdoH/POcu1MD+4/6NYOsUNYV5EDjOg5
	 PPfjXhZSgcHT6hAu1FyqGHmnFr86tOFQDX/vQ0hzX5nqQ/zkc40g+B1+8fLb8NhoeS
	 sgaTO3Iq/7BGdS5CLYN1eCV/iCM3MzN8rlDKiRcnn3IIlulziuBtI2Sv48bI4kC/Xl
	 AOXtU65xrJi/MHNBROsVykmeh3rLJlX0/ypKzomYRUxao3j+puNaybZVeElC4NGJWW
	 ciPuepgMBQQkbIYhb89WOO2YsKOgl5TanEh8YSI9J8FxddQFkWw/8nsJP1lF9kclVP
	 nGSR16o2/oCj2/GI5CzL2t9k=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C440840E0192;
	Wed, 24 Apr 2024 16:06:13 +0000 (UTC)
Date: Wed, 24 Apr 2024 18:06:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org,
	richardcochran@gmail.com, linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com, zackr@vmware.com,
	linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
	timothym@vmware.com, akaher@vmware.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, horms@kernel.org,
	kirill.shutemov@linux.intel.com, Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v8 1/7] x86/vmware: Move common macros to vmware.h
Message-ID: <20240424160608.GFZikt8JLrTN4M5PG2@fat_crate.local>
References: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
 <20240422225656.10309-2-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422225656.10309-2-alexey.makhalov@broadcom.com>

On Mon, Apr 22, 2024 at 03:56:50PM -0700, Alexey Makhalov wrote:
> Move VMware hypercall macros to vmware.h. This is a prerequisite for
> the introduction of vmware_hypercall API. No functional changes besides
> exporting vmware_hypercall_mode symbol.

Well, I see more.

So code movement patches should be done this way:

* first patch: sole code movement, no changes whatsoever

* follow-on patches: add changes and explain them

Because... (follow me down)...

> @@ -476,8 +431,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
> -		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
> +	return !(eax & BIT(VCPU_RESERVED)) &&
> +		(eax & BIT(VCPU_LEGACY_X2APIC));

.. what is that change for?

Those bit definitions are clearly vmware-specific. So why are you
changing them to something generic-ish?

In any case, this patch needs to be split as outlined above.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

