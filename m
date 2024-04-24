Return-Path: <linux-kernel+bounces-157346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EDA8B1024
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6581C245A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83416C69A;
	Wed, 24 Apr 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IBPHkcdb"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD7393
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977186; cv=none; b=uEXjlOR465AkcfDqU5CQKCfJNHN5zvSuM5tgk6wn6SAS3wfesaiFDyFLTrjp7/Zihgsh74PbXLkjK1dbVYQrzMLTIktJefg3thOamWX9Ji/UAxF9fzrh/tzehNg9LQ6qWrJPHXkjmjU35dlRvWyLBCKrQI7dO3B7pchoQdKhPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977186; c=relaxed/simple;
	bh=0gl8pqLkHh69onN4ComrekvSqNglUjxLzVsFszmR4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPnbq1w+jT3CSM3zk6JHgehd0DgFTlXpDLFwXxsyJE1BzkuHm3/jaiR76jT/k6DXmMcXQdkuDmtfnovGw9gnn1umxscUDzOe57syogZijBo3trMs6+fL3qFPzWm1X7zt3Rv+qw5r2LCw+4F/mgjLQO0x01YLVSMjXZGvE5S49ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IBPHkcdb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4702457ccbso8972666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713977183; x=1714581983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OR2ExOkbn5NhoJ3EHQ69fEuHqlCRe0lWGaAZLilHS5Y=;
        b=IBPHkcdb/URUsYVdzuksiMxmGoXiQ56bwOu1cD6w+wzQGWpDbYnGnTzSi8tHV/+4fb
         8zN6JmWNIx80DjuTaXU2tyt8ywOb3GPjNHBIDcQVZD75DuoX4cPao7K1kTrbGs92bbNX
         4GY7L5I8QfKrRKe2685OUm+ms2PwlMIhVvKl68n6P6HWn+xMnBq386ntW41+sDOpaJyI
         X1XDA6/Qkn2m4CVkefOzFLUCK1X0HFs9H+h0yGkJjTzVJcc5Q39C+cNKH1TZGCv/qYY6
         8T4OToFLGZCiyt2yK5iXg3e9/Gngp1rqRgdmr752GJHGprfqsnG5WYkkuCE4pO1Bb8dG
         FDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977183; x=1714581983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OR2ExOkbn5NhoJ3EHQ69fEuHqlCRe0lWGaAZLilHS5Y=;
        b=rAwZ5KN1edUak0VX4I69yR2UrTEBYw0NmoAN5SjJlONhoOE1t4IlLgwnWeSd/MyIDV
         B7TI+fzH4S0GFqrC3e+Eln6hWKEG0AwjOdFQ+4JlrNhD/azB0BLFXiloGr3EwIYFk7uT
         jAvndFRTxoGOuFY2jFPAqjec4EMjBZ3d5o79v6Y6nXbhzG8aCvHQNAHXlV6BYQtXOEwH
         1p5/YCIxrE78Hg6ygzGPMMdl6J9B0uy9+0VHh5bw1lYxgGbe/zzdA3NvB1le1nrPKyQU
         mPW3rrx5DqKvT1OmUq6+VxYtugMzOY9Hc8j22s8EDqoYLFG2gE9ovSVsLKmQdQJS5dW2
         kT4A==
X-Forwarded-Encrypted: i=1; AJvYcCX4MuoCxSwuXvu6no/gXIIVPV83q4qiT5dAQyX0JhYTzf5gHRVLQ256u2kuqum38BWwzKp+/tOniHYLQnI4hmRcw2XOxGGS1L55DwnB
X-Gm-Message-State: AOJu0YwTxW6WDgCrHRN1pO/q8V9YW538ry+6bQoERS4j4Km1o2oiA0hr
	s+U2IIgqkJW8oE2lQ+xin70oVlbtkh1cQ4A+lV9w59GuqUhpqceJN1bLFqtYxlY=
X-Google-Smtp-Source: AGHT+IEFGfcCTyr95j87C3m9QEcJHbWTs8ecvq8vgRfzfWoK9hZpODauOtNeyf9IWI85E+PeMJSnXA==
X-Received: by 2002:a17:907:1048:b0:a55:347e:7a89 with SMTP id oy8-20020a170907104800b00a55347e7a89mr1880894ejb.67.1713977182761;
        Wed, 24 Apr 2024 09:46:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906319000b00a5544063372sm8553551ejy.162.2024.04.24.09.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:46:22 -0700 (PDT)
Date: Wed, 24 Apr 2024 18:46:21 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Pu Lehui <pulehui@huaweicloud.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: clarify what some RISCV_ISA* config options do
Message-ID: <20240424-e62cefb761bd56b398ec9235@orel>
References: <20240424-tabby-plural-5f1d9fe44f47@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424-tabby-plural-5f1d9fe44f47@spud>

On Wed, Apr 24, 2024 at 05:25:21PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> During some discussion on IRC yesterday and on Pu's bpf patch [1]
> I noticed that these RISCV_ISA* Kconfig options are not really clear
> about their implications. Many of these options have no impact on what
> userspace is allowed to do, for example an application can use Zbb
> regardless of whether or not the kernel does. Change the help text to
> try and clarify whether or not an option affects just the kernel, or
> also userspace. None of these options actually control whether or not an
> extension is detected dynamically as that's done regardless of Kconfig
> options, so drop any text that implies the option is required for
> dynamic detection, rewording them as "do x when y is detected".
> 
> Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Since this is a commit entirely about wording, I dropped both R-bs for
> v2 as, while my intent hasn't changed, I've come up with a new set of
> wordings.
> v2 redoes some of the "detected by the kernel" wording to avoid stuff that
> Drew pointed out was redundant & adds a wee bit more wording to the C
> extension's stuff to be clear that it is a build time option.
> 
> CC: Samuel Holland <samuel.holland@sifive.com>
> CC: Pu Lehui <pulehui@huaweicloud.com>
> CC: Björn Töpel <bjorn@kernel.org>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

