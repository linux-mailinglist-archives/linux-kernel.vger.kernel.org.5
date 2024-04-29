Return-Path: <linux-kernel+bounces-162382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5AD8B5A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CA91C2142D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762D74400;
	Mon, 29 Apr 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DfRbfJuL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FCE67A14;
	Mon, 29 Apr 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398064; cv=none; b=AyhjHB/t8I9PEZR5rbiTZ7jwm7wYb4g/dvg3aCAC1AtSMsxff3IW3EIVhsV80IT4e8uCcessZspVxd3DZHPQCVQB50+9G2CNnw3oHRZ9gK7wPs/jhTIw20e0Zoq5GMv1YcYZKPiHmCNvIgkdoO1SFvs+ZF71dempyp6Nh6gL1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398064; c=relaxed/simple;
	bh=bIzuncCJWuFwI1tLDyWgj3dBUdDGyPkPoIV/F4VmW6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxffo2OtBjm01BANTbEQnpbjp0uLsFFZ3AQM3o8pTo+lkauyV9LRQnGeJ9NtuM1DB8erDMSX/Uqd0jSn0ar2YcWK8S/CqoWJXf/2TNF+CTo8cYCBTxQHyosoY7HkF4N2ffv1Ph588GPKMGbdpUu9svUGMTI0h6asAWu71QlRQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DfRbfJuL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D97B340E00B2;
	Mon, 29 Apr 2024 13:41:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5ceRWLvfS6N8; Mon, 29 Apr 2024 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714398057; bh=IgTwEgoVLTxVnhKia7yqyeRvlCapEMfMpdHcKg2TsnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfRbfJuLsUBtvIH64BtEvZd/CQgaCSKfmLgubL+WI+ML9rawZP3UwkSofhxYQaCJ1
	 iTRHWNDVc+hHg3Dm3OtkMYnBB/12iVxW7h3O6n6W9dG8LP0HQVC4r9ld+ndhRYI23P
	 NW/IQte9ECaDh1LrfC3qssXsr0dDy4C0T28aHAH1hPH6pZDkkqaY0vAiP7OwA+dNiG
	 HM8Y2scz6osA3BuK32nL5fpV0lARCTQzE98vzWkTSCM+w1ToS3NcqnS2kGgC00Cl3R
	 ezA7AY4iZcoMPoL5SNBYbPo5TeXaaYzWrFlidzzyYCi5cHRCsxmVpl/1jHk3Mv5iXy
	 /4MD6Pv3A63GoHk4HY7T4EE5JR50miMHyCE2MAxEYfKdWnSvRZdukfKO/z3UVgkhwX
	 k69z+Fk91jY27AEokXBdmJDBTkvtivakQHvt2Hl0PlALJ2l4Y//BFpv4mLGEHrFlLg
	 HLuVi771YBQtEXd7NgU2vUziWe+93WrV/OWFbphivWYUxY8ffAwd30UT8cSwdFKcsB
	 hJwMZkiJXW9b8a0WohskmzxhiO0qOlH0IgbM89BGB54vQl14PCXyjkBxaDtyG8duUx
	 CVEEzajVFQiR6AuSKNrHhp2nkkqmkvMctAOoy2SAPQfSUsV4+lAPWV022FmFxJMBzZ
	 EAv/JRUHRooOSQrD9YZ3AhW4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 049EF40E0187;
	Mon, 29 Apr 2024 13:40:49 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:40:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 09/16] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20240429134043.GPZi-jWzoVe3bJkyYX@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-10-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404151359.47970-10-yazen.ghannam@amd.com>

On Thu, Apr 04, 2024 at 10:13:52AM -0500, Yazen Ghannam wrote:
> @@ -787,6 +793,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  			mce_log(&m);
>  
>  clear_it:
> +		vendor_handle_error(&m);

Wait, whaaat?

The normal polling happens periodically (each 5 mins) and you want to
reset the thresholding blocks each 5 mins?

And the code has there now:

static void reset_block(struct threshold_block *block)
{

..

        /* Reset threshold block after logging error. */
        memset(&tr, 0, sizeof(tr));
        tr.b = block;
        threshold_restart_bank(&tr);
}

but no error has been logged.

Frankly, I don't see the point for this part: polling all banks on
a thresholding interrupt makes sense. But this resetting from within the
polling doesn't make any sense.

Especially if that polling interval is user-controllable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

