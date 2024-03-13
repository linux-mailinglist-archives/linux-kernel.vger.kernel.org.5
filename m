Return-Path: <linux-kernel+bounces-101352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21087A5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85BB1F2482F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75C39AE9;
	Wed, 13 Mar 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DniLVqzr"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B7225DF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325779; cv=none; b=HOAjiDwRquzj+T6g6Xc9iQz9MXY7imCk9s4Ikq6VkBbYRbWIPO7nSDMJQOLN9njfK9CSeo7xPw6B4/QwWI1TmNqMKtJx+6T415zSOOkTN2yyCzxqYxV9Vpu4wrS62kxSHminZvE3/Hebk98HyqkROFRWFGoBN0VKMclJfu9Uk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325779; c=relaxed/simple;
	bh=m3qsEjoHZVZae/FJXbdV0xVIbL7h4+G7nvMM5xyhcb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETPpxjpuOFUiWGOD68AgP0vWJRF6OYtml2S+CMDL8rg1NdTH6rIwjWUZjKw6GThzFoJrTf5muumvAe8bnOOMWEiZcMQ7ATbtM7lBRLhGuCpkBVjagX60jxLVZBcbP8Ht0eYH1e9VlnGGsUEUHPPy8gk75IZ8RYHaFR/S04XoooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DniLVqzr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413ea3219feso2540785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710325776; x=1710930576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQWsiCF2QjnYE9FiKBWb3DmvBqG0ZBw0xDIosoHssNQ=;
        b=DniLVqzrt4RABdJZbiTe435tdyi31dMj4IIHAlYlpDli0anQ1ClMUCvcKY3rMM3u2L
         AsGXCYOkgP2zMo03ov/hsYbjjApVNvwKaMwUhDT5u6vR4yQRuAYAVdffiqKs2tG7RZqY
         c4qDQjtBJzue3B4YChjnWQwIufNZuY+X18R/VmdgPx8F3runjEGRCvGoKqtHTr6tcMt7
         OdlA53AnyxfeQNFALQvuydTcGseM6Sp/bXwgh7Dcxkt2NzxnEUoji1wXGxnzKlVEZTRx
         e0y6V0dpehj0jY1V2p62dutDixynYQBEvjLHDRCI0wDQwzww06LWHu9F39CV1hKkdF9v
         vDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325776; x=1710930576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQWsiCF2QjnYE9FiKBWb3DmvBqG0ZBw0xDIosoHssNQ=;
        b=rCUJtzx4KoViuQpEyDJ/X9jQ2uFwAs7OVBi8Ca46gjb2a/5gNT/Tb1LTJo5/b839Wn
         5QpMqdztxswyF5jXH3mOmjaj2r86b9iDzAvh4ML9BrTGcUYwArelkgPsp+s3uCDQPwS3
         awafkg3pez0kOYoI9crNrsONwhuSvcBBYYcSMxIUK1OAIcEUbk4ZI3aAmdWyWSuKCFaj
         m362o18EV6iWWCg8vOI5T5fD6e8GknyPklMRMWL1QfpkNexwY+E1iTg8GZp2/4Rohzo8
         s8U4NDLjWMObLL1TlgSKsqKE17vtzf6lJXUBsq82LX6XkQcJ90/S2G+nuIT9qKee62nk
         w3hg==
X-Forwarded-Encrypted: i=1; AJvYcCU9eRuTaYx4I6DlbTp//yLAeUnig6UcqenyKUFdpvptMKt/T2HnbbJJ7J4fP/t4aq5f0+OZDea9FbKmKDus88dI96/YGJSf56XtJPLT
X-Gm-Message-State: AOJu0YxDnBK5kSYuzR/17yEJqH1Tm000UWWjnfeeia6fAGwkxqvLieQ3
	t8yyaFG2mV+qQ3vtzqZbKY13AvLy9YvEETMERxEbeqjOJjnBbFkG
X-Google-Smtp-Source: AGHT+IGgGU+TCXrH3d3W5gNTpq0sTP0iPUVqiQceTeIF/Rj1nHjkOnVF3JPtPvBcEXD8wXrxFnLpjA==
X-Received: by 2002:a05:600c:5253:b0:413:137f:49a2 with SMTP id fc19-20020a05600c525300b00413137f49a2mr9865995wmb.9.1710325775459;
        Wed, 13 Mar 2024 03:29:35 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id fm23-20020a05600c0c1700b00413e4cf0c42sm1869951wmb.25.2024.03.13.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:29:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 13 Mar 2024 11:29:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Message-ID: <ZfF/ekjP9R91dw2j@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313075839.8321-3-richard.weiyang@gmail.com>


* Wei Yang <richard.weiyang@gmail.com> wrote:

> Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
> CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
> LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
> which is only used to define __START_KERNEL.
> 
> Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
> <asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
> <asm/page_types.h>.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  arch/x86/include/asm/boot.h       | 5 -----
>  arch/x86/include/asm/page_types.h | 8 +++++---
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index a38cc0afc90a..12cbc57d0128 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -6,11 +6,6 @@
>  #include <asm/pgtable_types.h>
>  #include <uapi/asm/boot.h>
>  
> -/* Physical address where kernel should be loaded. */
> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
> -
>  /* Minimum kernel alignment, as a power of two */
>  #ifdef CONFIG_X86_64
>  # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> index 86bd4311daf8..acc1620fd121 100644
> --- a/arch/x86/include/asm/page_types.h
> +++ b/arch/x86/include/asm/page_types.h
> @@ -31,10 +31,12 @@
>  
>  #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
>  
> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
> -				      CONFIG_PHYSICAL_ALIGN)
> +/* Physical address where kernel should be loaded. */
> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))

I agree with this simplification, but the ALIGN() expression is far easier 
to read, so please keep that one instead of the open-coded version.

Thanks,

	Ingo

