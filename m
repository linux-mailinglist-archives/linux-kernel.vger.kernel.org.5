Return-Path: <linux-kernel+bounces-57981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A384DFE8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B059FB279C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFE371B2E;
	Thu,  8 Feb 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUh8YOkj"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D36F513;
	Thu,  8 Feb 2024 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392544; cv=none; b=K9arlzFN/IifpopyRz5wez1Pgq4u/FX73/phkAL/tLkIy9wYcYBQW9xLnfZwjuu0lM/D87rVeTGJZIemLquKCEA311JLzPtpejIOIvIVzGRUGYUCknS9RyhDUbB/Y5h2KRVqoy1ZWm9PcVTgOd+NQtMJ3CS5f4LQKP/RYJhWa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392544; c=relaxed/simple;
	bh=aEQ478SuaY6VmhEfhHXJw2WnDBxJM3W5d9Q2bW0sw+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCIVEBkyF6gc7cRdnOaiz4aa5egPLyLkSpthSc9QAO2tORdFDqPar+zGR+jEbf5ic7XAdJaTeWNmAvN9Ti/guBrT+QyOn/4SH/BYJwvCSiC1kdrBUv+8bUafx4BE9SqqJpmP7edGFo27c7FhwM88PGBHL9FlNNHcTxkop/iaV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUh8YOkj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a389ea940f1so137484966b.3;
        Thu, 08 Feb 2024 03:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707392541; x=1707997341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJx67bcvbAo9zHf0ymAdxOGvHwHm6HIalhNV9TyZktU=;
        b=KUh8YOkjcg2BhgaCu24iNDqUNjQPM1vPLVc6prWRUhCIimEvq99LTwbQpYWQM1Cd2i
         WvIaWjWISh1sr/e2w4/bVnBqZr4M20wncCFCH7McS8ShIOn3a5tBQpdw5dcQDLQWi+Wg
         EimMbcfIi0fdr68lFBpbMPViWJq8CUzns9JmQ4fwyORapXaMdv/OmCA5a3skHCqFja6k
         hZWQFtHIrS2oPp8GZ7doiFvKaJ4OtfH2BjHyz+O/iIPyab/bKZ/t9jXJ1MwJTTrfzGA4
         JQlY5fTWxuOXtOU0MS+byO2p39JQ5VeodxB7VodQYeVO4nJgCUaMwNOEYsw/ueoevojs
         KHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707392541; x=1707997341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJx67bcvbAo9zHf0ymAdxOGvHwHm6HIalhNV9TyZktU=;
        b=YuPErl8f19A8/yEG5b03eGygR5lNYz1xY/Q5xSrBqXpdizmB5g/BE45esMW0Bn/RET
         x0pQJv8MK/NZ2CSik/kgm7z6bgXSuC6y/C51hRYWDSrmXdWYKTZo0ETfYrzMuozM9OTe
         AKKVcsTdxZtSXdnOgpOppCiEL4sE15VoCpauaikLZz0mYSjFC2lOPdMKINCF/hxyF0iA
         O+umrTFSHcHPbti878o0v5YFidL+PJh2/QsS4VdNEem3joHLop7HxgsT4yD+DSYykhLN
         vbfWov3pWalVg/WEfJXcwvuuH69aS4yBmL87a5WqoHzxuGOv7XlKLw5jA1OkfGxWtbYa
         O4yA==
X-Forwarded-Encrypted: i=1; AJvYcCVTij1mvMDrFIdiEjbmkzw93CwoGcH8dx0h/U/V7ggv8pltNT5I/7zb21+dTemJGK2pUZvxRMZWHm/QtfS07tySAmRdtIsiLX+3e3r3w0Ik9YDRVTnmCjEiaxv7GUngfsnxmHmSNsTLmJbqNVgH6eqe
X-Gm-Message-State: AOJu0YwHMIRhVH0TgPcAmWx6EwIFH9jPGKFpxEDcb0YvSWTNBn1hFAxN
	WhS+QioHAjmYir0gNsyGuUmyYYGSgN8fSywRaUEoleqEEkRZwm03
X-Google-Smtp-Source: AGHT+IEiPm4u84iqFSB/UQg6ibdfUKzGrLkfL1m3NTh0SS5++/aHuKt3pBw9YrhOY1kilrXZeG6DMg==
X-Received: by 2002:a17:906:d10d:b0:a38:948e:85d3 with SMTP id b13-20020a170906d10d00b00a38948e85d3mr2932904ejz.71.1707392541302;
        Thu, 08 Feb 2024 03:42:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVISQGNJhcgRfbCljEvw7EzsND50WXxUpC4wFphSMcBvdzRIwbL7Ryz518AMPWPM8jSxRs0KB7Ropazpm8LjMrbZ8JFStTaDPeC1LQt2v8Ut06vT2nk2yiRzB5u5BwQ6VPecfYcJUZUnj3snDHe3u9fyFsYjU5QawLERsKuJF3YAWRNgL06iSOJ8SPb2oNBunViYzVACgOdN48RvE7Hab7wmi+qh1B5Nbs2VlDSJozNfZ03T/pWq1SaHNkIxG5Q1zGeZjK0WpttiduQo/fpQFRK/Y9Xow6QVEftEVQPw0jypU8d5Z2nQ9sWPbOADDjT9FKF4/yr8KIWAAGqCvHzPUSg1bgl+GaQv2Y+z41S38/k3qowiSDXHmU5a4279KlMRbSCw/LNpg==
Received: from andrea ([31.189.46.254])
        by smtp.gmail.com with ESMTPSA id qc12-20020a170906d8ac00b00a28f6294233sm1784541ejb.76.2024.02.08.03.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 03:42:20 -0800 (PST)
Date: Thu, 8 Feb 2024 12:42:16 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH] riscv: Fix text patching when icache flushes use IPIs
Message-ID: <ZcS+GAaM25LXsBOl@andrea>
References: <20240206204607.527195-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206204607.527195-1-alexghiti@rivosinc.com>

> +static int __ftrace_modify_code(void *data)
> +{
> +	struct ftrace_modify_param *param = data;
> +
> +	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
> +		ftrace_modify_all_code(param->command);
> +		atomic_inc(&param->cpu_count);

I stared at ftrace_modify_all_code() for a bit but honestly I don't see
what prevents the ->cpu_count increment from being reordered before the
insn write(s) (architecturally) now that you have removed the IPI dance:
perhaps add an smp_wmb() right before the atomic_inc() (or promote this
latter to a (void)atomic_inc_return_release()) and/or an inline comment
saying why such reordering is not possible?


> +	} else {
> +		while (atomic_read(&param->cpu_count) <= num_online_cpus())
> +			cpu_relax();
> +		smp_mb();

I see that you've lifted/copied the memory barrier from patch_text_cb():
what's its point?  AFAIU, the barrier has no ordering effect on program
order later insn fetches; perhaps the code was based on some legacy/old
version of Zifencei?  IAC, comments, comments, ... or maybe just remove
that memory barrier?


> +	}
> +
> +	local_flush_icache_all();
> +
> +	return 0;
> +}

[...]


> @@ -232,8 +230,7 @@ static int patch_text_cb(void *data)
>  	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>  		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
>  			len = GET_INSN_LENGTH(patch->insns[i]);
> -			ret = patch_text_nosync(patch->addr + i * len,
> -						&patch->insns[i], len);
> +			ret = patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
>  		}
>  		atomic_inc(&patch->cpu_count);
>  	} else {
> @@ -242,6 +239,8 @@ static int patch_text_cb(void *data)
>  		smp_mb();
>  	}
>  
> +	local_flush_icache_all();
> +
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_cb);

My above remarks/questions also apply to this function.


On a last topic, although somehow orthogonal to the scope of this patch,
I'm not sure the patch_{map,unmap}() dance in our patch_insn_write() is
correct: I can see why we may want (need to do) the local TLB flush be-
fore returning from patch_{map,unmap}(), but does a local flush suffice?
For comparison, arm64 seems to go through a complete dsb-tlbi-dsb(-isb)
sequence in their unmapping stage (and apparently relying on "no caching
of invalid ptes" in their mapping stage).  Of course, "broadcasting" our
(riscv's) TLB invalidations will necessary introduce some complexity...

Thoughts?

  Andrea

