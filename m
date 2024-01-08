Return-Path: <linux-kernel+bounces-19257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F0D826A70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228A7B218B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B2F11711;
	Mon,  8 Jan 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZHEv9Zj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E184111BD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a271a28aeb4so145869366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704705337; x=1705310137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2yeQMptxxMuTcnH9ibzCQxO7swjSIFRDv8RJtb5wdE=;
        b=DZHEv9ZjK/OLkkuQRvxe+dQYI3r2+jBUMhAUr7pLXG6wRVF4qUinMLYx/+QBKe6zV0
         xcg65jSlMxdsjftAJwRdRLUyvKiRucN0FKsIxtGlVvdZ0z5Eaa6juaQw+/13CshLYufe
         kETsA1rRAoduvEVuO5HR//JHRVLO9sNjGSv0yJvLF/pwUiLo+dZPCiQbL8KHnvMzmmXn
         6zhQQ+HvwTYzvh7ZFNi44VSjd7AVlFhw3MdAjQ1OykCDB158mMPp6upSKItYf6Cm89Ph
         wPaz/b3eiqT+zV6XquCIg1EBpRwYP7tnlkDe9J9R0z1UTPy8ZqfWgBtkuPb5UywzErnU
         /iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705337; x=1705310137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2yeQMptxxMuTcnH9ibzCQxO7swjSIFRDv8RJtb5wdE=;
        b=TPvDpGI0dW7zRyqMf05dyNWgIBncPZ+AyFbmehXqirUm7OU3rpjRUPfy0jLQaNz9fF
         R3M8vZyZ5ji6yY78/otmMnSemy+UKx4TDrme/QBuYRRXkcSYViX4xR5wuzcoVoCN2Kw6
         qpVUrR0B+qR2ad89t/sD+5N8l//oHvT5lcsy77QCi388SM8EWBnGSAvxKyenRJAV4yU5
         hILp+LrXY1N6+QqGBmpjmp7fW0H5flUJdaBcW5LpQLq0AmkRfxT/LiBpXT8Ym7piZ+OI
         f/YDoiC0FGig0rd17I2xu+V/u9uS1NLpPCYYO/ZdGGfqiRMUJJ/4JoLGbZPW6Ir2er0o
         Aczw==
X-Gm-Message-State: AOJu0YwQgcBFKESNoeDJCrbjRGaAbFo02Bx92NZasIuyNB1uMckaZGMh
	E5479WK0G+FF7CuqZWNP1bk=
X-Google-Smtp-Source: AGHT+IE+aA2ItComx3U3KQl7+pzCZ5ezGLkSTOCi1x3hz2ykg0yDT6gznKvkJTQ89c4QJPBaLJ8gKg==
X-Received: by 2002:a17:906:2802:b0:a28:c148:e457 with SMTP id r2-20020a170906280200b00a28c148e457mr1257622ejc.47.1704705337303;
        Mon, 08 Jan 2024 01:15:37 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906704300b00a27e4d34455sm3718542ejj.183.2024.01.08.01.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:15:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 10:15:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] objtool: Make objtool check actually fatal upon
 fatal errors
Message-ID: <ZZu9Nvkp3PdSeLHQ@gmail.com>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
 <20231213134303.2302285-2-dimitri.ledkov@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213134303.2302285-2-dimitri.ledkov@canonical.com>


* Dimitri John Ledkov <dimitri.ledkov@canonical.com> wrote:

> Currently function calls within check() are sensitive to fatal errors
> (negative return codes) and abort execution prematurely. However, in
> all such cases the check() function still returns 0, and thus
> resulting in a successful kernel build.
> 
> The only correct code paths were the ones that escpae the control flow
> with `return ret`.
> 
> Make the check() function return `ret` status code, and make all
> negative return codes goto that instruction. This makes fatal errors
> (not warnings) from various function calls actually fail the
> build. E.g. if create_retpoline_sites_sections() fails to create elf
> section pair retpoline_sites the tool now exits with an error code.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

So, is this not expected to be the case anymore:

>  out:
> -	/*
> -	 *  For now, don't fail the kernel build on fatal warnings.  These
> -	 *  errors are still fairly common due to the growing matrix of
> -	 *  supported toolchains and their recent pace of change.
> -	 */
> -	return 0;

?

How about making it only fatal if CONFIG_WERROR=y, ie. an analogue to our 
treatment of compiler warnings?

Thanks,

	Ingo 

