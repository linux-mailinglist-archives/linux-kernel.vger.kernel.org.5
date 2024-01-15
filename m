Return-Path: <linux-kernel+bounces-26184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C0482DC78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31116B20ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9A1798A;
	Mon, 15 Jan 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL38mFp7"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33C17980
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55790581457so10074355a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705333200; x=1705938000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZWeeMkSKDbBY1qxO0WKMfgjkDxXFPye7HRiYjT/Kk8=;
        b=OL38mFp7O0G+Ur8obMZt3NYurfukjZMqxcF2zW6wVfaTEP/OaYa4xS3N14CwYA+3Lm
         CScP4mUm7YgHY0KQe5f2QEmiy6zI4CXtxX9llJ7hCPzHuYBj7t3sVjiTg1OObbikV4Id
         0fNC7IZ8dSQF83SeNnf/phhlLFBQkK8nX/6zmCaLLbb1yCphzcYV3Aj4HIQlkjaZsHOM
         ibnZpZ57D2HYR0hS/TrSp/fkkposw4IDkTzUmv3lYgWH4nADk2u8w7CCbWFTBhOPI0mM
         MpFZX3WVO4qZCQHSZzxdp5qjdfsoUMYXFrBU0ZDNuS9VoDbnxQR1i9McbXseMdQC5F2M
         vCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333200; x=1705938000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZWeeMkSKDbBY1qxO0WKMfgjkDxXFPye7HRiYjT/Kk8=;
        b=JDI8Dxf1Bz7pYRtVUYAM5pyMdj1eT+sC2++KHjqQTRsSWggGewGKBbmKmbBizF007q
         w98y35YQbMZ5rCTFgQDUlYjC7OTLwqywq/8bCJ0Q8qgTstg2VJy0kwTWSsMXpUDixq/+
         ovafD5XF3/dTPVPj+O3+SWDYQaIUlM82OX9mQVtXRPHM7xFftDzP6WFMbSU5fB/4bwkt
         UXwEHzkug4LviqhY6GbUjmFX2SE0riQfW9MWSqgbpuk/J2Iqq/Si3JffAaSlD9Qr7PV9
         sFYqH8S9fSw7P4d4X/TR7jy1+qbwGpp45LlLtd88b6TALGzIZ5q6WTBygBKinfhXDt7c
         /bEg==
X-Gm-Message-State: AOJu0YwoOHPS+Y6E+C75rq8dRN0dyxhdsy0RgHC2AZCxtb5Dt1ErWigP
	ulIYu2KMShbB8twwjFl5hAA=
X-Google-Smtp-Source: AGHT+IF1VcAbumODZjATC3MlT9DwzPRqK5Zh0lqjrstbfTliSfrkRTpZc3S+lxi4ADyiU17Zs2MfOQ==
X-Received: by 2002:a17:906:c2c1:b0:a28:abfa:dac3 with SMTP id ch1-20020a170906c2c100b00a28abfadac3mr2638964ejb.153.1705333199694;
        Mon, 15 Jan 2024 07:39:59 -0800 (PST)
Received: from andrea ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id vs5-20020a170907a58500b00a2cbbebedc1sm4308824ejc.53.2024.01.15.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:39:59 -0800 (PST)
Date: Mon, 15 Jan 2024 16:39:55 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: enable lockless lockref implementation
Message-ID: <ZaVRy4y775bfcEUH@andrea>
References: <20231202140323.315-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202140323.315-1-jszhang@kernel.org>

On Sat, Dec 02, 2023 at 10:03:21PM +0800, Jisheng Zhang wrote:
> This series selects ARCH_USE_CMPXCHG_LOCKREF to enable the
> cmpxchg-based lockless lockref implementation for riscv. Then,
> implement arch_cmpxchg64_{relaxed|acquire|release}.
> 
> After patch1:
> Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
> On JH7110 platform, I see 12.0% improvement.
> 
> After patch2:
> on both TH1520 and JH7110 platforms, I didn't see obvious
> performance improvement with Linus' test case [1]. IMHO, this may
> be related with the fence and lr.d/sc.d hw implementations. In theory,
> lr/sc without fence could give performance improvement over lr/sc plus
> fence, so add the code here to leave performance improvement room on
> newer HW platforms.
> 
> Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]
> 
> Since v1:
>   - only select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> 
> Jisheng Zhang (2):
>   riscv: select ARCH_USE_CMPXCHG_LOCKREF
>   riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}

For the series,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>  # code audit, QEMU tests

  Andrea

