Return-Path: <linux-kernel+bounces-138546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C589F336
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3631C26C20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889E15B136;
	Wed, 10 Apr 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiKRZFQA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EB156F23
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753886; cv=none; b=e8POVtQAJ3aYEv0UgeGGCp5aC6yo1FqrQhac41kFTTbyXq5A3VtmrLRBUanP2iUXH+GoQoI/LV/vhcQIWP2UqmvRRqQEKy4B2pwIYtY+Ns1MlO/z5N+XjQ5Tn0lkAb9kAjR5Xxpy5tQQu9HATwvCwaHJFHAdF2/kaOPbQks8ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753886; c=relaxed/simple;
	bh=nJUi9rPZej+h44WRD6Xh/z4m8frw/jvIQlcyirl031g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIEbf+ca0UIV7N4vK5QMYlMCVU5xD+C4D/84m08Y3K9npnyFwXvCHSiO20KfT8I2onK7pFr62tlwuLF0l69UioChkVcd1uNXyrz68Db7Em+AmibYJx66fJdTl4EtlQItDh3CFnPtyp6Z3gZgZQ382/od0bh8V4V5vsxOBInMlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiKRZFQA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51c6e91793so613803566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712753883; x=1713358683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERc0Mc3295DMpduY6C379p9vkt2xRGs6pLrBozDiTnc=;
        b=MiKRZFQAfLCl2D9mmdJoMaWxpfVG1dfILPb3AaIfhZxHwVdbONiJN1wiuNnxtJJKH9
         0y38ozzdxCkQpNR/Cp3/nBKUzLCMicTxJfZIptit+L3placcTAee/hTFCFd82fh0JCbp
         Yz73HFlO5M9DouUmmNre89bk638qSkX92dUH/aGcw9qyZcqSa+XiAvKoxoYtcrOeKVYd
         9exJLDyqOJfhAW3VzA5S9xdU8P5vPlDy9czClTzrhUtSlBzkgNLqmmmcep5e+5CuBAd/
         SKNd2/dwYj0QUELXqYV7XUy8kkKB1NqTCQwlNe7t+W8Yzn/ANkFdKZdIQrX/jASltMrJ
         lFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753883; x=1713358683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERc0Mc3295DMpduY6C379p9vkt2xRGs6pLrBozDiTnc=;
        b=IRGbuJ/+GlHDoOc8bEeNItw4jRzvUra+9fEcFlirYGsC84xT5mdG9DnCzV/CM53FeE
         M5ESYnAkha5PcI+Js17A/f/CCXrFsZVhXaIOA0li59UlaKHihHpLzCOZxizRSZVNNEWJ
         OTbVAye0AAe65VyW0dZ/VNQap5I2MKyENKWgEyPi8O5m0+LXbBIcr9U7neXyPTnnGoXy
         oLA6GZj06mXUzPjHZZ/gb3TCKcEINClmmL5swKMIGQ1rtvIGwn2w4Owz8i4hUcC2+Kwo
         J8Lq/V6+rDC55vnfXZf9x4kzX+/dbTCppl73L//iowyI4Oy1KPN0ZrS5wddGw62Di18G
         JXlA==
X-Gm-Message-State: AOJu0YzkdUsTKf60gZ+dl1NbZUcniPkd4uDyFFskHWEqJsOTPGkxNoa/
	DwntrBmleRbPsUCOFMpuIX11+25beEuSszrKJZIEaqpFLDFGOd1ncKZwteqaUxtWGw==
X-Google-Smtp-Source: AGHT+IG0BPNBEFTKAfB0H0Zu/fSg3ECNuPRVpK4VhqxdwzkPz4eA4nBzPl2mnc36IMRVR/eE3FxPQA==
X-Received: by 2002:a17:907:86a7:b0:a52:176c:15f with SMTP id qa39-20020a17090786a700b00a52176c015fmr223791ejc.15.1712753882634;
        Wed, 10 Apr 2024 05:58:02 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7d452000000b0056e247de8e3sm6418852edr.1.2024.04.10.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:58:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 14:58:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Conrad Grobler <grobler@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH] x86/boot/64: Clear CR4.PGE to disable global 1:1 mappings
Message-ID: <ZhaM2N3EONa7tNgl@gmail.com>
References: <20240410102520.348017-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410102520.348017-2-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The early 64-bit boot code must be entered with a 1:1 mapping of the
> bootable image, but it cannot operate without a 1:1 mapping of all the
> assets in memory that it accesses, and therefore, it creates such
> mappings for all known assets upfront, and additional ones on demand
> when a page fault happens on a memory address.
> 
> These mappings are created with the global bit G set, as the flags used
> to create page table descriptors are based on __PAGE_KERNEL_LARGE_EXEC
> defined by the core kernel, even though the context where these mappings
> are used is very different.
> 
> This means that the TLB maintenance carried out by the decompressor is
> not sufficient if it is entered with CR4.PGE enabled, which has been
> observed to happen with the stage0 bootloader of project Oak. While this
> is a dubious practice if no global mappings are being used to begin
> with, the decompressor is clearly at fault here for creating global
> mappings and not performing the appropriate TLB maintenance.
> 
> Since commit
> 
>   f97b67a773cd84b ("x86/decompressor: Only call the trampoline when changing paging levels")
> 
> CR4 is no longer modified by the decompressor if no change in the number
> of paging levels is needed. Before that, CR4 would always be set to a
> known value with PGE cleared.

So if we do this for robustness & historical pre-f97b67a773cd84b 
quirk-reliance's sake, I'd prefer if we loaded a known CR4 value again, 
instead of just turning off the PGE bit.

It's probably also a tiny bit faster, as no CR4 read has to be performed.

Thanks,

	Ingo

