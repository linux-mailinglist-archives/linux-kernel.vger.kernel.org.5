Return-Path: <linux-kernel+bounces-93626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBFE8732A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1C8B24771
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E825DF2A;
	Wed,  6 Mar 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IU6gnfHS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203F5DF14;
	Wed,  6 Mar 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717409; cv=none; b=iNYJ0joM+EXuyI8hpgRGvaa4L+4QcK24Xyk5zpfRHAQE/3wlHde6IA77bmkJb49PRBi+kkIEa88W37C/wzn7Oh9dlCQYqb9psvzmF5A2zaB3Jjv+rZ+OAmN9sVfuraloVyz/bnUybxKCMQURdo9nNgykmEA7cP8p32LTB7yD0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717409; c=relaxed/simple;
	bh=Y3Lty5lImWF4AdPZOBki5RRdl2NHf3ZUczPC5/UTnF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y75lImGTKSth/tx4rEfUfEobchyixrvtbG07HM+zcEKhpvbQOY8wsGlRDi0JB5uO4KsjQg+sq9gchER4lCxAHNf2KwNowZpoZ2abNjM2xOEql/1xjMpu2Gt2b6hf5nxdS/wexlwvIBCGvoOOvxBI567GXjEBJeVzp9xBX0cfbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IU6gnfHS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1BCE540E0196;
	Wed,  6 Mar 2024 09:29:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bqkuGXKgdDpk; Wed,  6 Mar 2024 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709717393; bh=ULazbDSQsUMx2ImMe7sehWqqLLpe6QH805TY3SG+RIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IU6gnfHS48SjLW0YjSJT931n7oyiqhmm3FMoE0m7vZo6If6OvFt5UMriBF2VUB50g
	 djcTqjqZLlpM4xVI0J7PWyrkWLNO4Y69M4dH1zGtQJNlP4ogwOwikG7qNPfL9Oa/fW
	 fRb+ssMk2X0dl9STlKXyCD4o5X0Xp2+Hnjy5n3WhZ0IwYpzMLw/1j2q6Y3GaGaSc7x
	 HGoROG3FDCQ4yb0MhugEAeR7WUgrk2qc+DldbeuSuaBgxJxMXP4GdcAguWfZ9GiN07
	 +XTkF8dMFS9j/5/xd1NYPUf/Ufo8uRh0ARuiLMrO+doG3u6sKYiUqqqSMHZvwzqVbA
	 s91Piy6v32XpF9janId0nq9YGB/3qC5WNeUWDUCHhaYoKhmXUuqb35FsWmuEECa5/f
	 H9aIIQmhoqWhQNl5AbNNzeeZMtVqZaUS+q4OOv1OpDUX99s4iq89qrrhaUpCHWJk0x
	 dLtY65SiwAEjHBYFbOqmCaI8TWhzxpQ6d/S5UqIfzSPdItTXCN6tz5HilmfElSZC55
	 Q5SM+15bhEx66Kdetd2xV6NPfoTqNELLYPobVuQuQh1HA8vPgb6lpJISJ9iMHX6i1v
	 jiYDpKvpXHjhbO3dhfpBlcddB2iBOlBjGYNNCJIKwvSwR1R1pDmQgbd7/QXSAUyre1
	 OW6SAk79GLGRQ4O6lmDm0Kv0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2249B40E019B;
	Wed,  6 Mar 2024 09:29:45 +0000 (UTC)
Date: Wed, 6 Mar 2024 10:29:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	naveenkrishna.chatradhi@amd.com, muralidhara.mk@amd.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix off by one in error handling
Message-ID: <20240306092938.GAZeg3grpW-PMOqFz9@fat_crate.local>
References: <6fdec71a-846b-4cd0-af69-e5f6cd12f4f6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fdec71a-846b-4cd0-af69-e5f6cd12f4f6@moroto.mountain>

On Wed, Mar 06, 2024 at 08:30:46AM +0300, Dan Carpenter wrote:
> Decrement "i" before the first iteration.  Depending on where this fails
> it could free something from one element beyond the end of the
> fru_records[] array.
> 
> Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/ras/amd/fmpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 0963c9e7b853..2f4ac9591c8f 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -817,7 +817,7 @@ static int allocate_records(void)
>  	return ret;
>  
>  out_free:
> -	for (; i >= 0; i--)
> +	while (--i >= 0)
>  		kfree(fru_records[i]);
>  
>  	kfree(fru_records);
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

