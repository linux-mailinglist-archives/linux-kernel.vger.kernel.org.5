Return-Path: <linux-kernel+bounces-66716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761E856095
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8454281509
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F368212F38C;
	Thu, 15 Feb 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="oz1Vt0o5"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB543129A69
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994368; cv=none; b=IO0VOr2qQlElF+50Nrgi1chyWuBsckXVdz1Nl1ZEy7xCD3ncJd0zjT0kDZHGcM56njKC4YEgrKxh3f8FZd4XREBpk+VcR0O8uHaSHjPLPgT1YEjaW8iwYQJAVuiXMrQGS0+JClm0A0zWx2djKK6x30sni/mj3h9dE9Lh6hHdfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994368; c=relaxed/simple;
	bh=DrS69cbqai6YRkZOkha+qInzsRn3vy2Nx9Kf8zL2FDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2AX9QcSWdU3R9dN5kEqmH+25qazJ9E1czaH6yXWYIcMDGydmeiHsr7CMkbRBBLZqoI+vODrfKrqFxyOy2tbU94incAA6hinwBDXyImTDj7BOZEZ20p/yiNWd5PRiqXs8T8hHyq2dfi4DBcy0UobVwkXwYruT84dBg7yfUL87ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=oz1Vt0o5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3a09e96daso574703276.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707994364; x=1708599164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVJlypdB8EeG025OlVruBqkZML3RozZ3SqRoFlfo3os=;
        b=oz1Vt0o5HgvOetZMbPmc1EmSDgi6OMeTrk/C5F/cq05VC1vSRghiGrO4TzcjMw12Kt
         whmoIrF5g3WSjer4qLS5Yt/XCJL+Nvuo2Ue/6r/tJfsJCgNw7ZTYHC3aT3weiq8DMi6T
         ep7byMx25T9VxXopNCrGp9uBaZt9ad6BjHulrOdfGM3tlz5JBEDZcHnXbBzxE35q5ri2
         ClqqEHSG03dmfG89r02sHdpsCQYTWBlDKWWXjpM+Wv6No/4cVe218D7J+rk4M6FQjuv8
         N2ZV5cQYGXE4BZDtMEIL7+N1G9n6Klb/Z3acjyBsOFzbPiJjKeQ68yxwmSFi4de0GvvH
         ubcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994364; x=1708599164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVJlypdB8EeG025OlVruBqkZML3RozZ3SqRoFlfo3os=;
        b=G1Q6OmNd2PeQV82bsB/ohM8IMUIBxHLli+sr11UPjDXu45EbeLSFgdsw0OZTFD5mig
         8LvnkOhgPs6a49Om09ReHLPNcxWcTr4Vkptmagfi0L92WDsDiaXEUPIiC+k77sz+Xs/o
         eTHycCw2bHDT+8F/zO+pGcftCEdVosu5tI5cUmDTQYqMkl/W3gu6xrlo0QeWMWk1DZ2T
         gfX1f37LIXel51f+c1S0AoUpj3o3nAzUEWsGqbyfmHmJUnsQC6PWIh6+h9nGihPkfTIP
         LAmQvRwToMfl/Zf+KSgudHKNs2tqbOWPUaohRWKttdh2f6axddYUJ7YmnMRgcJqCxV4n
         5Ejg==
X-Forwarded-Encrypted: i=1; AJvYcCXc82eq5YsUIFIawa9W8RuTMtnMhZgEGNr2xaO701DRpH2t5Ps39o6fmqUUoGyKfSNu10rFxr/VlK5yCQO0a0ifdI4pQkZfZTJD3t5r
X-Gm-Message-State: AOJu0YzF2cM4G8yG6BNtgFb9ju06hBuin7DnbResjDMVNg0pxOF7z6YD
	k+22wfDLMYZksKA7FduwSEfV8GmjHDfhi8IFyjspGRKaGxG38c45J1sy95bKKbQ=
X-Google-Smtp-Source: AGHT+IGKdFSiqy84NLrVA30/4Kts6hwSkrE6XMGw/mKt98wEEGkyKykv5EX2wDueJiJJVPejLrF0lw==
X-Received: by 2002:a25:a049:0:b0:dcc:ae3:d8a0 with SMTP id x67-20020a25a049000000b00dcc0ae3d8a0mr1020389ybh.48.1707994364556;
        Thu, 15 Feb 2024 02:52:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:4922])
        by smtp.gmail.com with ESMTPSA id bk30-20020a05620a1a1e00b00785d7f634bcsm502508qkb.8.2024.02.15.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:52:43 -0800 (PST)
Date: Thu, 15 Feb 2024 05:52:42 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm: Fix spelling mistake "commdandline" ->
 "commandline"
Message-ID: <20240215105242.GA1282507@cmpxchg.org>
References: <20240215090544.1649201-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215090544.1649201-1-colin.i.king@gmail.com>

On Thu, Feb 15, 2024 at 09:05:44AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a pr_warn_once message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 94d1b278c458..95c3fccb321b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -8014,7 +8014,7 @@ static int __init setup_swap_account(char *s)
>  	bool res;
>  
>  	if (!kstrtobool(s, &res) && !res)
> -		pr_warn_once("The swapaccount=0 commdandline option is deprecated "
> +		pr_warn_once("The swapaccount=0 commandline option is deprecated "

Quality workmanship.

Thanks Colin ;)

