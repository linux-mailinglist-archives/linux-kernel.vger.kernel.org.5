Return-Path: <linux-kernel+bounces-54559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A984B0AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F79B281A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87357130AED;
	Tue,  6 Feb 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BOpuCh4h"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B612E1FF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210087; cv=none; b=BiN8G3k3fdCudq5oIc3g1q1m5krGNcmVKaD6kNHfF2v1kEGwMsHhmL9Mmv+BndUL/tssS8ZeGMdaMMnZHzXt2rg+4K8SrRnJ+POVazjecrrHj1Qwsazy1iBwyposKADqaGqBH0fiSdUmB7Jw0Pnbr7IYsxAs89XU4pkTdy0NGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210087; c=relaxed/simple;
	bh=quQ5u1nidg/xTSCc4eiJEK0LTpVOsRry+rj1E2LYKsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc4jzBvC54P9Lem1RumhkCRGFxrjcalGXN4BXKIBVpNO5nKmhYa74jFE3kJKyA0hKCV0EjbkDYQjl0R5yetbshLKyLy8L3eRaBbcDt+wgLwK0mS4By3da+9txfMft/FDjcLoxSa16VSF/UYfqx7Q/z26X73DrTx13cCb7rLrqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BOpuCh4h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a38291dbe65so35342166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707210083; x=1707814883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YDXZa34a8Tn2GI/Io/UPgHGAi1ZYTZqfLaqpPxg+uZ0=;
        b=BOpuCh4hc1OhNJsF+tUB4//wJ7JRP7+hfZCOIYnwx0AkYzIP9U4xi/9M5KzDW9cibF
         UXKFocUkY+URFGzVxS7AUR0+MHiFRjDMzqKQYRRkhgX2xQKJAfeqi1vRhyM+QKq3ny4C
         iomoXvSYu8L3AN+716am/Tdeyp2rd1gliuQZLS+nOmwa/nvvtRb5ejLNfK0ywHQLZQMv
         WpxcpbeT+BdQZecqVJeeqGD92l1tcx6OO5DpJeGPx2EciqxwDz4yHcTHxvlu3mFOFVaS
         mxtaLnfHuAYoOxvZqtZpV3TAilZkOXfRWZJM2tsLPsUbTDpt7M2FgGUAfxB2YXzwMgaP
         f3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210083; x=1707814883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDXZa34a8Tn2GI/Io/UPgHGAi1ZYTZqfLaqpPxg+uZ0=;
        b=KCKDMbevxQondVO3zDx6Eb7m5qBSl+cecogaUSHy3fMtY6VjEValaQKd7zVl69t3Bf
         e291B3ath95ADZcSOCt04iw+t6YhbGu5xAnAsmmLfP7si4NkutszQix/F5+Y9ZNUhU99
         60V7wVnQ5l4h00sitWirbG1oKSvpvicPNBgbNmiBFQnzAi0s5dYfbcgjwBiA45cd0wFk
         OyUbzsYzkGEweTYxefW5FBguI037tsOm56QBIp2uSNPcela/x/fL9PHFvNU9/pLX5M24
         oaICv6+oA3y9Iff+ftkL9UUmvzCWQ7PYq4/0Y0k6dWAnnb+5U1wBOuErLMXqSIpESHEJ
         suOQ==
X-Gm-Message-State: AOJu0YzlUCVbAc8ngc2iEeOEtHwAfwqq2bCmc1fhiDwdqwKoF0KraRLi
	mwxbetzozow19WgeT7xFezp+VPwuj09bR+d/ON+d4Lfm3fYxX2SG2t9c/KnYWZ4=
X-Google-Smtp-Source: AGHT+IG9JUi+5IktGIG5tqEgZJOoZGAq/7lRMLCLehPiOVpCvTdNDxomqWr0Mcyzdk8qlnsNfyT4VQ==
X-Received: by 2002:a17:907:9255:b0:a37:e980:5945 with SMTP id kb21-20020a170907925500b00a37e9805945mr743785ejb.60.1707210083598;
        Tue, 06 Feb 2024 01:01:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWW7hqxsoaL16/Gy6fn4z3Q/EAd8zG+9r0X20HuS+qff/+Sh4p87Fev7M6WUDgf3HiORSSYTamMBkwYmrmlMI+9YIUjcTu59io0D0UjPO1nmbVO3D8N8zxCNxcp9gAi2uYhIR0SHT7q2OjezrtjVzeq6Vj4GAcQT7TyT+P8Ue1P1Gi0DIkeThM6lUnlGz4FYGqGj4WdRJxPW3G5YWTQxmSq0pt6SPRPrqrVMDMxmK3OoCvSliEQzUz+oqMon8uHvF4z2eL/6/BazQM8zb+iIf2zvklEC459KRExvuZQaznMM98b6vcJZaBxJfG+L1GsINR9RUzz7mtWXKUzq5F66Uk4wr775eWGZrmCsZOugj4xyJfm+hH3bo/fYszBd9vEAgfByKetlvQD5Jh3fq4491VJMN+flnJYXL6jIrQnvpFsKmB2VhSWkaSktej6XVkHBuGNuNlFC9yKpI5fxjNGPoTWIssZMFnt0mG/nnGbGUrthmioM1K969W8dJoaAd+ff8bPOhpulyO2jKpQh6Eu/5aR7Hu00TM5HPlwPbU1RSFCZ0M7kBpN8dVKROvjdUgUE7Y4jnny66lTPEsoeKLmWppYZzM7+wYwjj/6Y6EBfZX4bbLEKkRZbOqbmIwj/p5bunlLFPn0jNGPFsjCIKnYJs0yyCiYZqyMDjVEpm+t+LI6HYZCJU9k5s6k9lwOfgADd6huDdu/meuSBjmxNgtLFxdOrHMkfRutPf3VEWsfsakcaQA2iJj0HEXNpa1AG//0b1sIZFfI
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id bl24-20020a170906c25800b00a376758a0e9sm896042ejb.81.2024.02.06.01.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:01:23 -0800 (PST)
Date: Tue, 6 Feb 2024 10:01:21 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
Message-ID: <ZcH1YewEqWsjTaMJ@alley>
References: <20240206001333.1710070-1-yoann.congal@smile.fr>
 <20240206001333.1710070-3-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206001333.1710070-3-yoann.congal@smile.fr>

On Tue 2024-02-06 01:13:32, Yoann Congal wrote:
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean.
> 
> So, change its type to bool and adapt all usages:
> CONFIG_BASE_SMALL == 0 becomes !IS_ENABLED(CONFIG_BASE_SMALL) and
> CONFIG_BASE_SMALL != 0 becomes  IS_ENABLED(CONFIG_BASE_SMALL).
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

