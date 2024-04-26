Return-Path: <linux-kernel+bounces-159608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0D8B30ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88F21F23DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0313AD09;
	Fri, 26 Apr 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UK7FKijJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CD567F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114777; cv=none; b=mKkWmO+7H0uXlCroh5AV3O4faXCHnyyW2mXuiDAoqpry6S2pVNOHOy15lojDWRNU9W7q/yM5BtD1wtK1j0ek1XgUUOYxeLwTv28ZAcA60lw113/N0zOWh5V3SvXJQe/1JAAIcvbxOOpXb3r5I2Y6xn8LPvQo5QzRywLBhK/IKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114777; c=relaxed/simple;
	bh=G7vXm9ah7dP5SqmGJRXf6C33wHqAfZxN47t8q4zER0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPse7rMhDJeOJMhDWYIGvw2HD9Akl4iRp/T7bk2bOqkqbcFkp8jQZh5Ubod93S9wxsmfSap4AXeBfQuOKjYkMC/Kqi05RBQhMAf8QmkQymGixNBzDEkuQ9Nwrn3BrRSObGZOufuqYhf7Eg3dO+SkmWz3W67+x0UyyORi3Rh/LcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UK7FKijJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so2195564a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714114773; x=1714719573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJi2B9HW02fkMYGbO8TVAET6hHBVhmmZVgISXMQ1fkk=;
        b=UK7FKijJ5KsbEi7f2h8gqZ+I0eBa776J6F/MNIEqNFIto/s8ZvcMOAhaTu8rZFdoYM
         odFdPY0Wl6fGVynCWA415VcF7ukR5/PdKruw6FjrPxCaqQ88vWnsMXAE8cjQw+yc8m8l
         8uVphq1VUUhckZ36DeuLqZ5IPrS0w1B0KEExIb395vC8B1X/N/2FFsRQ26WhnIPI3Fqd
         V3LrADD3KMWVbFh3aHx+CkL0QcUShS3SHqQDEznDAv7DOdB2xsKJ8REdySGngkD3+2X+
         ozzcZ8mnd3RaiwQW8JxQmfjXx5rVnHzYpp+AngsgSdOEkHOPL2aiQd/HV3YLLpUJREmJ
         zouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714114773; x=1714719573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJi2B9HW02fkMYGbO8TVAET6hHBVhmmZVgISXMQ1fkk=;
        b=i9Vqa/ECwhyoaPBWTejI8enq3YwZF91picJpOv6RrZLBFb2sFO6Xs8fvruT831bvUD
         CDGXO4PQagRzJO5D4jfzijFiYZf3h2rUeojBQ/Jw9abEKLNp5TsauO/K7UMDaplIYsjL
         SM1Rf4BM/497d+8wTvNnOKtZ5ixxB7ZpZBGA6sfmlEAOvP31M05Pmvc5MornUuso321S
         AG3WNrd/nuObTUSHR/xGSZBoeNo8/xP2pNmFVCf436HDmBcvrusJN6FKLY1F2gcdzWnR
         ehFyCcz7BcxNgNAZ+eRmLRzbcx2R8hr32JmwdjDWV8GNog2eKotVMf+pPXCylA+xjPqj
         GmQg==
X-Forwarded-Encrypted: i=1; AJvYcCV3ya1XauYvw8wKcMLAyRRdKDS/Bawxpzt5iXc+AzbSsGDkyN1FIIQxAdWaCx6VJIEsIq/gXIlC/H21SOgSrEX5xKhA2gxvkJrWF5kG
X-Gm-Message-State: AOJu0YxeG23X07aC8Hokw5fXamLHp7zgwpXeOpe9kDx1lvO72YMcNFVZ
	qgHSungtDycUCYqcRH7nnJjhFOZ5+XPlLu3uPdFKkXbd2H8BorRluGeUcLKycdk=
X-Google-Smtp-Source: AGHT+IHUnMU8CxhFO5e0ybUeTeletpTSN8CoDzy9n/qhvKWDBbmouw24d1LdHfZWIXo2JhywDqhFJw==
X-Received: by 2002:a17:906:3614:b0:a51:de95:f592 with SMTP id q20-20020a170906361400b00a51de95f592mr1758675ejb.63.1714114773338;
        Thu, 25 Apr 2024 23:59:33 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062b8c00b00a58d438ed2esm183306ejg.139.2024.04.25.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 23:59:32 -0700 (PDT)
Date: Fri, 26 Apr 2024 08:59:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: selftests: Add hwprobe binaries to .gitignore
Message-ID: <20240426-ffd635ae77cff1868ae99206@orel>
References: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>

On Thu, Apr 25, 2024 at 12:58:03PM GMT, Charlie Jenkins wrote:
> The cbo and which-cpu hwprobe selftests leave their artifacts in the
> kernel tree and end up being tracked by git. Add the binaries to the
> hwprobe selftest .gitignore so this no longer happens.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
> Fixes: ef7d6abb2cf5 ("RISC-V: selftests: Add which-cpus hwprobe test")
> ---
>  tools/testing/selftests/riscv/hwprobe/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/.gitignore b/tools/testing/selftests/riscv/hwprobe/.gitignore
> index 8113dc3bdd03..6e384e80ea1a 100644
> --- a/tools/testing/selftests/riscv/hwprobe/.gitignore
> +++ b/tools/testing/selftests/riscv/hwprobe/.gitignore
> @@ -1 +1,3 @@
>  hwprobe
> +cbo
> +which-cpus
> 
> ---
> base-commit: ed30a4a51bb196781c8058073ea720133a65596f
> change-id: 20240425-gitignore_hwprobe_artifacts-fb0f2cd3509c
> -- 
> - Charlie
>

We can also consider doing what kvm selftests does, which is to just have
the top-level .gitignore which ignores everything except the code. See
tools/testing/selftests/kvm/.gitignore

But, until (if at all) we go that way, we can do what this patch does,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

