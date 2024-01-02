Return-Path: <linux-kernel+bounces-14214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F3821931
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5449282E01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A25D262;
	Tue,  2 Jan 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEZ/iwjP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16460CA68
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33731db55d9so2241152f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 01:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704189269; x=1704794069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5fH/2DQvO/Vknv81zYHwP4l6yn/7Tm5ckvZigBomFQ=;
        b=JEZ/iwjPmA6HnksRyiFd0tPrCSLJYw68VDUJA+8mzSUMhAPHcZWgMnNph1GLjN6jxc
         Clk6xyU2EWAk8ZxLFmzi+BBf5OOW3kgKzM72kQlF0ECXA+YraGMcnHwhnxS9hmaz8ij9
         aZr0BwmJwoRwKOArbxLhlL+CLtRK770kYrH/rDkXvkErE9ATYMv7SmSlFWQLNkDi/rAI
         efFyfGd0Zp1JzqBtIvw6sP4OVjps2QgHi4DaQpY2jgeJdQRd6/aXBSA4z+ynG0+viaNW
         bVdLH0vdtASdQWqoQWKSRC3TZBuYAmDrWDgQR88wzr1Le0JQMFlWOt6pAYvfEFnOleoQ
         3qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189269; x=1704794069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5fH/2DQvO/Vknv81zYHwP4l6yn/7Tm5ckvZigBomFQ=;
        b=OaqQWpIFYXFfnv4b/abUpWjvXirHFsvZiBjogh0/+rtl7tobZWJGVRh/lYI9yySjr7
         ZwbLCHM/3Bv6Mr9kOf3p0sTkEvU2n+twG20Yx263t4vnysaniVu2Fx+aSYSVo82RLOOZ
         lGZi7RR43H779Au3CZSIyk+puLXcvVk/wCa5AMA2ne/eSe7Eg97rTjbb++IdJhiiGhaV
         +2ycO+vKOpxeLyARyxhy3jfCijQOjBhIzE1vdKrbV5N/k1LzexPw98cYwgFQSXAFjSuO
         C7uidGGXapz77fEVp9MdTl3NF2nu+SuPKIS9/984xnWypxpOZnPC5xMoxXa3RAmQkNSc
         Rzvw==
X-Gm-Message-State: AOJu0YxwoGjbfxXV/TbmPTbCUkeuoEisQ+FgICKhjCBwOOX5PvsrX1Vp
	iUQZfm+5ssJC01QVDCJGc+c=
X-Google-Smtp-Source: AGHT+IHy31iwxEy43w6fN/vNlkM0ir2q4MluKLushJVZYOoHKf25TxnAm+J0tCxuYFjtncIAyV3jxA==
X-Received: by 2002:a05:600c:4f91:b0:40d:5d89:7c37 with SMTP id n17-20020a05600c4f9100b0040d5d897c37mr5072603wmq.142.1704189269120;
        Tue, 02 Jan 2024 01:54:29 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b0040d4e1393dcsm36397862wmo.20.2024.01.02.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:54:28 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 2 Jan 2024 10:54:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'longman@redhat.com'" <longman@redhat.com>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Message-ID: <ZZPdUv6uRvqXlyYo@gmail.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>


* David Laight <David.Laight@ACULAB.COM> wrote:

> per_cpu_ptr() indexes __per_cpu_offset[] with the cpu number.
> This requires the cpu number be 64bit.
> However the value is osq_lock() comes from a 32bit xchg() and there
> isn't a way of telling gcc the high bits are zero (they are) so
> there will always be an instruction to clear the high bits.
> 
> The cpu number is also offset by one (to make the initialiser 0)
> It seems to be impossible to get gcc to convert __per_cpu_offset[cpu_p1 - 1]
> into (__per_cpu_offset - 1)[cpu_p1] (transferring the offset to the address).
> 
> Converting the cpu number to 32bit unsigned prior to the decrement means
> that gcc knows the decrement has set the high bits to zero and doesn't
> add a register-register move (or cltq) to zero/sign extend the value.
> 
> Not massive but saves two instructions.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>  kernel/locking/osq_lock.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 35bb99e96697..37a4fa872989 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -29,11 +29,9 @@ static inline int encode_cpu(int cpu_nr)
>  	return cpu_nr + 1;
>  }
>  
> -static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
> +static inline struct optimistic_spin_node *decode_cpu(unsigned int encoded_cpu_val)
>  {
> -	int cpu_nr = encoded_cpu_val - 1;
> -
> -	return per_cpu_ptr(&osq_node, cpu_nr);
> +	return per_cpu_ptr(&osq_node, encoded_cpu_val - 1);

So why do we 'encode' the CPU number to begin with?

Why not use -1 as the special value? Checks for negative values 
generates similarly fast machine code compared to checking for 0, if 
the value is also used (which it is in most cases here). What am I 
missing? We seem to be going through a lot of unnecessary hoops, and 
some of that is in the runtime path.

Thanks,

	Ingo

