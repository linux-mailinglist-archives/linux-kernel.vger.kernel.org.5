Return-Path: <linux-kernel+bounces-21379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B244828E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE401C20DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FDB3D968;
	Tue,  9 Jan 2024 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3xm4NDU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E63D960
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d40eec5e12so27301505ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704830709; x=1705435509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ezCSlrIoJxqfy1Xr8Ro9H9xwusIwZZHRkXvQ8oqxxo=;
        b=t3xm4NDUxC20PGhIaYaes93kc8FkKs4XSSmuwHdZN70fZx7kspPc2cWtmPFS3MhM1t
         u2G6POFbk8lR1TzkPj9Qgs6mHfdEvJNbOFosuHEwuhobteKK/E/niJ3PxVBXU9QJovX5
         oPSIVljLO/D/ohZdlQNzRokF6UY+A3fTQeGhr3D2zaf5dJ2qOqpjDlkr9q0GCrYucmjJ
         w+qEq7s89qF49rXsdYguYwwkqBJVhh70xr1waqPKC7enVGIRnSvcok/1uwCuNg7a2V94
         WRidtgWGwoje3RZiehijb88zmQ4vNEilBxIvxFu1iduy48i80Sc9YupwAr8NqcLffrBf
         6nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830709; x=1705435509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ezCSlrIoJxqfy1Xr8Ro9H9xwusIwZZHRkXvQ8oqxxo=;
        b=UJgXGsOprx1q6dZF2SWfmdSJFcSaVC+pIr27ce/QQ6Wb3FMJJ37rE63vKwC7CBYsNO
         i7tJO8k8pFq5TvkbXycrj5jreFsZwduy6xkLP+5TVUHCLXoJW3lyFHSC+aVQ6oT+rTRV
         uhLz6O0bSbeil+KyE5mqswf/g4YXkdp363AybosJS5kdrmWajNxnuL6/SjdpvP8Oq+eE
         edVFyLBRf9XqD6+Po3Grq1ugKAAvzRgyz8s6JFolQndBuswMlOxzLrJ/CfjpgaVD0G9Q
         blt0w8izFh6LLj5kH5M0gL9ayQTPzLfWpHo/vd7tXovD89Rg0e/3VeDwUngv6RdMUhuK
         9EFA==
X-Gm-Message-State: AOJu0Yyj6YSosSKDsf1U3dcubqP521Hipi3PqKCbLTgjlvLiBehEoBue
	AjCCnn4afz1vhsgz2LyjROdR/HofjGds
X-Google-Smtp-Source: AGHT+IH/9sACcx8rtCH/5NKxeAsuLQr48cMbufYI+Fk/blHLimYLpyQ1dZT9d+BnGaqlyMv6ZkZeVA==
X-Received: by 2002:a17:903:32c4:b0:1d4:ef61:2407 with SMTP id i4-20020a17090332c400b001d4ef612407mr7193791plr.74.1704830708626;
        Tue, 09 Jan 2024 12:05:08 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902ba8a00b001d3c27e00f2sm2175500pls.284.2024.01.09.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:05:08 -0800 (PST)
Date: Tue, 9 Jan 2024 20:05:04 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Will Deacon <will@kernel.org>, John Stultz <jstultz@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: optionally use LLVM
 utilities
Message-ID: <ZZ2m8PO92oCF-uO-@google.com>
References: <20230929034836.403735-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929034836.403735-1-cmllamas@google.com>

On Fri, Sep 29, 2023 at 03:48:17AM +0000, Carlos Llamas wrote:
> GNU's addr2line can have problems parsing a vmlinux built with LLVM,
> particularly when LTO was used. In order to decode the traces correctly
> this patch adds the ability to switch to LLVM's utilities readelf and
> addr2line. The same approach is followed by Will in [1].
> 
> Before:
>   $ scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (??:?)
>   [17716.240654] esp6_input (ld-temp.o:?)
>   [17716.240666] xfrm_input (ld-temp.o:?)
>   [17716.240674] xfrm6_rcv (??:?)
>   [...]
> 
> After:
>   $ LLVM=1 scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (include/linux/skbuff.h:2172 net/core/skbuff.c:4503)
>   [17716.240654] esp6_input (net/ipv6/esp6.c:977)
>   [17716.240666] xfrm_input (net/xfrm/xfrm_input.c:659)
>   [17716.240674] xfrm6_rcv (net/ipv6/xfrm6_input.c:172)
>   [...]
> 
> Note that one could set CROSS_COMPILE=llvm- instead to hack around this
> issue. However, doing so can break the decodecode routine as it will
> force the selection of other LLVM utilities down the line e.g. llvm-as.
> 
> [1] https://lore.kernel.org/all/20230914131225.13415-3-will@kernel.org/
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

There is no clear maintainer for this script. However, I had a look at
git history and it seems this might need to be picked up by Andrew.

Cc: Andrew Morton <akpm@linux-foundation.org>

Andrew can you please pick this up?

--
Carlos Llamas

