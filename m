Return-Path: <linux-kernel+bounces-102692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF4687B5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E1BB20A71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC608BF6;
	Thu, 14 Mar 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7ikHPDX"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D56110;
	Thu, 14 Mar 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377981; cv=none; b=WqHcvg97PhVqYVnBVpBKEQJFd/t/niS2UkqbcP/vplsRplTAlkjHxu9P7RYGUig4aWvVFhsvOkX/ZmcAadIRLR+2i0v3y95k+kWg2/M9grzNgyLr458Sm8EGnNIG6PjC4tfNHAmteZ9QbOOCc5y6O1+8ruH1/UcJ5qNnrjfvaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377981; c=relaxed/simple;
	bh=Mpe+EKij231+2bRJa3fS0rGIHp+mvwK0Qgxgn1T1qZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlldeKK0kRFVXgu2pc5eerHu45YXQzsxBi8EeiTPM/9n6GXhdAY38PhVsXVSyOu7q4ddijyGEhwxG785s5ALoEWymbghXeKWTNiyFeLShhNYcdgmce4UJ8pmTVe3xppHyEYpSaCmTi7QjS++G/0WM0jsCzxn9tkm+hJNcpAzohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7ikHPDX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a461c50deccso49352366b.0;
        Wed, 13 Mar 2024 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710377978; x=1710982778; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAE2QFV7Vga1Iu4j7WKP5punOUXpLOUNadClgdVRKIE=;
        b=X7ikHPDX9/DHe8soNOE5aeHkQh/Wp78PwyWbwIL4AGQRsTnYPLn012RV5nYjXkYRLn
         tkg7Bt8fE4/TxQtYdGGYC0S2JZWg+XCaVqSWvBsHLlJPIxFcmklZ28dWixKfJudaKVU7
         5/svR8Ar0wqS5zALT4Dw3Ea+vq66B+42tGwQNoq50FnP6qfWLOUh2JoE4ulH247fiExX
         yUwVTOZLY/qiL9bVEQxEYAryTZnOlGfrDm4QrN2THWSgMP9ZIVDig9HqGuN3ANAtKVNH
         bHzU1++Jxd+xkDGLx573iAnQYrqAOFPzGVvQZzMfNOk8rBdHj8jx5vegnER68/23+ugM
         QzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710377978; x=1710982778;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAE2QFV7Vga1Iu4j7WKP5punOUXpLOUNadClgdVRKIE=;
        b=EdCNFfvEhLKc+zBkfa/YfhwQT3jP+6rMOk62jftY/uZuWYJz5BqeFPKWKicmAHEcRy
         iXIWYLRGDa7YNEV/2Bp31L2jMhPT+YzLJBOgXzxSnD5F4TkLRi7T3Rb3R6fQn40a5t44
         Bac8z3dOppTC04kOpjQjWCNHshl1QDnCck4Ou1uaMfB14wtRK12OI/7fpLwaIp7ulEX1
         /pLz63PWK9z2nQp6uZae6aSb0uySPYnglDOzqFn98hKAPdJi/89C5/ycQ/IMLqMs9+88
         yE/NL84lsfzDL/4L8S6N2WumagmpTj2+in2qHwhNI9YK5Qs4YPnFGg9umOEeijMvCh3p
         IvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpTSi9Kv6Cg32O3kyH0dKBGsIIxJFhEyEwof9tqAYGp5NbJZ131XnoIcDqNtsShYennj5Ojzi1poWJ+rKYhlTdEuc7w0DbJkAIenyFA/ICf/w=
X-Gm-Message-State: AOJu0Yyd7z03jFkgCLtJppDVzWSh946rp4YF6jVrZ2bKPvRprRLfaLam
	4x/EEKDHetlegylithqWSxyWuPb243JJbjmT5zOlJWm5MphyQIibUMT6gx55YAA=
X-Google-Smtp-Source: AGHT+IGHxum4OdKHPvR+1uY4RvNfEkkQslXtBxFtiZ7EGJfHnk9khamXpmgFmh4Th4KKTBlyRwy4Tw==
X-Received: by 2002:a17:906:3414:b0:a46:29ad:5b0d with SMTP id c20-20020a170906341400b00a4629ad5b0dmr129500ejb.18.1710377977867;
        Wed, 13 Mar 2024 17:59:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a465ee3d2cesm149028ejc.218.2024.03.13.17.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 17:59:37 -0700 (PDT)
Date: Thu, 14 Mar 2024 00:59:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/build] x86/vmlinux.lds.S: Remove conditional
 definition of LOAD_OFFSET
Message-ID: <20240314005936.5j2jtl32ukzi77si@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240313075839.8321-4-richard.weiyang@gmail.com>
 <171032639869.398.16886435468084846590.tip-bot2@tip-bot2>
 <20240313131833.GBZfGnqTwdhcw6twQd@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313131833.GBZfGnqTwdhcw6twQd@fat_crate.local>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Mar 13, 2024 at 02:18:33PM +0100, Borislav Petkov wrote:
>On Wed, Mar 13, 2024 at 10:39:58AM -0000, tip-bot2 for Wei Yang wrote:
>> -#ifdef CONFIG_X86_32
>> -#define LOAD_OFFSET __PAGE_OFFSET
>> -#else
>>  #define LOAD_OFFSET __START_KERNEL_map
>> -#endif
>
>And, as a next step, you can get rid of LOAD_OFFSET completely and use
>__START_KERNEL_map everywhere.
>
>Even less ifdeffery.

You mean remove the definition of LOAD_OFFSET?

I have tried this, but I found this is used in vmlinux.lds.h. So I don't
figure out a way to get rid of it.

>
>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

-- 
Wei Yang
Help you, Help me

