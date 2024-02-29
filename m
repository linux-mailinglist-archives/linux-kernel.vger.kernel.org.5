Return-Path: <linux-kernel+bounces-85934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3586BCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5508F1F24C20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296925765;
	Thu, 29 Feb 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1m9EYo9"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA49249ED;
	Thu, 29 Feb 2024 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167381; cv=none; b=j6V0uTxUsrkcAyFaXg7zBppi/BKkH3xv2d2TP1ILqR0FaSv3GQSiedN+QLgpuoJaV1FQ1uCIEmp94u6B0Wgz79thw8b9vTqu56J8Xm8nO0YS6vZLW6wHMXn0UGE0jXWK+bxFjZnjfqUwYlzTATUqiFBiUaQFmLTqyFpOqykJzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167381; c=relaxed/simple;
	bh=n4Tb5ua0L8EebpFdtEUvj5UmxXNuiua3ipJgiQdU48g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td32P6si7yOxqG6U/6aWFbQGAEKdPU20FG028xF7EjH8smq0coWvTDCz5cFYzzDa6IdJIkajQFipobCnQlMJESaWF9N3wlsU0VRN+579th5heEfNIiKJ6hWhnIXzjQof+LXJhnOncaOiP4Kzoogdpe5rYuUIoHZK4a8/qvrS5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1m9EYo9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5669bf9013eso147174a12.1;
        Wed, 28 Feb 2024 16:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167378; x=1709772178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZmS4IRRjqluuahGyeQvOvUbUjo8O7pcJJoCmMytKQ98=;
        b=I1m9EYo95nk9Rw75ArU5yrzTFVld24zxVvb1yjSJO1NecJglvxvGFlu9haaSimKrdo
         yXjas5ZuzFuHAkJyPjyKY9KpuOzGu92bKmwhFtcgdJeB1ifvC5+ej55O8lCDVphw3v62
         9fvFpRCaxc6P+koQ3lehbQMd0+H8yGQgd+tBQbqxt6FRwkHFreq74QMp06s/oiCoHXKf
         uRb2O1SkQQ4WAByzCbWs4zxdwf46Q6h+rw9TYeocDeW3+IAgToxxiDJSmxZNTXqN5mpC
         sdskjNhrgDOqdPo/ZaFDm1LSRrDp7Z4/2UukkAQ8+bZPmwb5eJgYznJeNJP+p9iRI7PB
         53yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167378; x=1709772178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmS4IRRjqluuahGyeQvOvUbUjo8O7pcJJoCmMytKQ98=;
        b=eznj2uTqS5RkBUDLecCV748yXteNIIO2m0OWVvOOvhcrJQAJ7BLvH68mMDNmfFmT+4
         HE1q6f9wnR3QHQrFLOYoHaor26midkGGFuaQhLnEfGtJx3DLk6DSOfqMvirV305jzxOy
         9u/pUVbI+m7SW4f6gpZWoWDPZpUSw3J+eay85eQ1AufAahyOoPL/ItVo42tmdrPgzC2p
         RJ5FyoyC9ioG4CXhpOYRi3I1OgD/g5OifQuCHeCRjkD7Pwi/IZuXSoFNE/EGcv9lpJRq
         x5/zQMFuAlurxhjn6ovxH3gbKWJ6Q21tcmI8pbJCxFUXOaETEe2NiIFNPCHxJJEqFFmm
         exYA==
X-Forwarded-Encrypted: i=1; AJvYcCVeuThzUeTOVZqeYjLzoQMiLZTX0pBwL7xnYXNmQxEP4LgB5FpPOgpGq20ygbsbo4/IM30xOxAT+poL/rxLCRWWJoOGKeRXOevnetQpbRmcAlHr8sfwIxZH6B63X0AHYWHQydCycwoj3L8+eoewLNuG
X-Gm-Message-State: AOJu0YxhyUf/csJ3kXePCXIcmMYjISEvABwXM9oYKHy6mSV0ICnkk+Uy
	uaQA42txPiFWXW1FcZ/5hKhXge57/92YpZV+KHOnAlf9pmODcM/0
X-Google-Smtp-Source: AGHT+IEdA/lIroyr34aN4pYdmsq1xe9ghJmBWdnL6YBNd1En/M75YkACZP1NP7ZEJ0WAd80er8iU0w==
X-Received: by 2002:a05:6402:268d:b0:564:d715:1d67 with SMTP id w13-20020a056402268d00b00564d7151d67mr400310edd.17.1709167377835;
        Wed, 28 Feb 2024 16:42:57 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id i16-20020a50d750000000b005667b411c38sm74791edj.65.2024.02.28.16.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:42:57 -0800 (PST)
Date: Thu, 29 Feb 2024 01:42:55 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH 2/2] riscv: Fix text patching when IPI are used
Message-ID: <Zd/TDyyG/5sxrPWx@andrea>
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
 <20240228175149.162646-3-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228175149.162646-3-alexghiti@rivosinc.com>

On Wed, Feb 28, 2024 at 06:51:49PM +0100, Alexandre Ghiti wrote:
> For now, we use stop_machine() to patch the text and when we use IPIs for
> remote icache flushes (which is emitted in patch_text_nosync()), the system
> hangs.
> 
> So instead, make sure every cpu executes the stop_machine() patching
> function and emit a local icache flush there.
> 
> Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Modulo the removal of the hunk discussed with Samuel,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

Some nits / amendments to the inline comments below:


> +		/*
> +		 * Make sure the patching store is effective *before* we
> +		 * increment the counter which releases all waiting cpus
> +		 * by using the release version of atomic increment.
> +		 */

s/cpus/CPUs
s/release version/release variant

The comment could be amended with a description of the matching barrier(s), say,
"The release pairs with the call to local_flush_icache_all() on the waiting CPU".

(Same for the comment in patch_text_cb().)

  Andrea

