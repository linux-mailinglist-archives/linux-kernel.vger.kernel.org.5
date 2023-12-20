Return-Path: <linux-kernel+bounces-6652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B81C819BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09351F247E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1B22033A;
	Wed, 20 Dec 2023 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+dGwwv3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B52032E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c3fe6c1b5so59573695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703065875; x=1703670675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4O1Vy1vHCRC70ciScQudqstl6X1E6fGag3h0cOzBg3A=;
        b=h+dGwwv3LC2zptpTj+sThF323qPFAlZw254Ur9cIWZ9C7K6zi59PXNZjH231mhcGpN
         9XUEmPiQb/QL5TeAEl044BbB7uACNYbIkj2UolTmej2BRtwSux3NSZvtlB9qhb2WkFWf
         +p/eOPq/E+9Yxtc/m0ugqIRbwUi/NFKDO7jWHnMao8/c/0D8aSabBvn1UQXCuP3GvOMN
         hKI4QrLNUFyBt7nmBuxbr1aQv4jJmfZT/Qze2Yv/mTShG1qMXvQV1PcHu3XlV19jaEek
         Z4CBsvzqJCsFX64VRafZQ89DgN7yIblQMRD3ErcDSmmMhYB39r19315jmHFRt2VbhAEp
         eazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703065875; x=1703670675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4O1Vy1vHCRC70ciScQudqstl6X1E6fGag3h0cOzBg3A=;
        b=Ag7qhwi4Jjx66Q5HTGVudbwJXO68MtasyczrsdRRKBB7cKa/w+GeK6swMANvAPGmI/
         NV5VAZ5ckglGbxKT971oFyuOErY1rTIt6vyaVwAQwkidK7qNDlPJyI1l2sS5WfoECVfT
         v2KrL4vta798xlRsa/yrAslTxTauBUlvuJrCav1UuRbzYJfZYpF5BB8iOxjwYMb6t2sn
         s7VbNmx4uGDsPctW7oF9hFbm6PA5fBb95u97zUYQsprIHS56xi5WbPFqkxk5WwkWUDM1
         olLmdGtoY8arT0YAb4sJOVgI49bAU/R19qAhSuIsn3DWM/bGnjVaoAmzbfnNxOe9oqXE
         MNFw==
X-Gm-Message-State: AOJu0YwW0ODJ8dj2ncGLkpNjdmcIRbrUaz2ZzBB47AzsJt2aWAPa0WA2
	SEdOC/9XS9wrYq2iX8s/aEo=
X-Google-Smtp-Source: AGHT+IEz5xdUqNpfh5ziQk8ZolcoEYnaE8u7uZQffRR28OEvbLXBW03RAz/K8gm3vO9Jl3fPf70blw==
X-Received: by 2002:a7b:c44b:0:b0:40c:3751:b661 with SMTP id l11-20020a7bc44b000000b0040c3751b661mr9974969wmi.61.1703065874939;
        Wed, 20 Dec 2023 01:51:14 -0800 (PST)
Received: from gmail.com (84-236-112-232.pool.digikabel.hu. [84.236.112.232])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b0040b2b38a1fasm6604079wms.4.2023.12.20.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:51:13 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 20 Dec 2023 10:51:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH 1/5] x86: provide new infrastructure for GDT descriptors
Message-ID: <ZYK5D/KfzpEjQr+8@gmail.com>
References: <20231219151200.2878271-1-vegard.nossum@oracle.com>
 <20231219151200.2878271-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219151200.2878271-2-vegard.nossum@oracle.com>


* Vegard Nossum <vegard.nossum@oracle.com> wrote:

> @@ -27,14 +77,14 @@ struct desc_struct {
>  		.base0		= (u16) (base),			\
>  		.base1		= ((base) >> 16) & 0xFF,	\
>  		.base2		= ((base) >> 24) & 0xFF,	\
> -		.type		= (flags & 0x0f),		\
> -		.s		= (flags >> 4) & 0x01,		\
> -		.dpl		= (flags >> 5) & 0x03,		\
> -		.p		= (flags >> 7) & 0x01,		\
> -		.avl		= (flags >> 12) & 0x01,		\
> -		.l		= (flags >> 13) & 0x01,		\
> -		.d		= (flags >> 14) & 0x01,		\
> -		.g		= (flags >> 15) & 0x01,		\
> +		.type		= ((flags) & 0x0f),		\
> +		.s		= ((flags) >> 4) & 0x01,	\
> +		.dpl		= ((flags) >> 5) & 0x03,	\
> +		.p		= ((flags) >> 7) & 0x01,	\
> +		.avl		= ((flags) >> 12) & 0x01,	\
> +		.l		= ((flags) >> 13) & 0x01,	\
> +		.d		= ((flags) >> 14) & 0x01,	\
> +		.g		= ((flags) >> 15) & 0x01,	\

Yeah, so how about writing it like this:

 #define GDT_ENTRY_INIT(flags, base, limit)			\
	{							\
		.limit0		= ((limit) >>  0) & 0xFFFF,	\
		.limit1		= ((limit) >> 16) & 0x000F,	\
		.base0		= ((base)  >>  0) & 0xFFFF,	\
		.base1		= ((base)  >> 16) & 0x00FF,	\
		.base2		= ((base)  >> 24) & 0x00FF,	\
		.type		= ((flags) >>  0) & 0x000F,	\
		.s		= ((flags) >>  4) & 0x0001,	\
		.dpl		= ((flags) >>  5) & 0x0003,	\
		.p		= ((flags) >>  7) & 0x0001,	\
		.avl		= ((flags) >> 12) & 0x0001,	\
		.l		= ((flags) >> 13) & 0x0001,	\
		.d		= ((flags) >> 14) & 0x0001,	\
		.g		= ((flags) >> 15) & 0x0001,	\
	}

This encodes it all in a very simple format, without C syntactic
variations: bit position and mask.

Thanks,

	Ingo

