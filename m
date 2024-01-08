Return-Path: <linux-kernel+bounces-19745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721618272CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EFDB22AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A484F893;
	Mon,  8 Jan 2024 15:17:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25545101B;
	Mon,  8 Jan 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso1858084e87.2;
        Mon, 08 Jan 2024 07:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727060; x=1705331860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hD+83XjWM51MBXcvcVONIs4WX38iaQlxtxjozUZeF8=;
        b=Qxa9avzAY+bdMveQxWAfUzLv0Ph88A8vKQ61NSHkQA/rgsd02W5brzib3CB41d/EJy
         snWHn6MyrTs4HF/q6xxRnghqY1tMc2IDJatREwennQMIjeNUkqdZxGwvP6tkJgrbHGtX
         OsI40WFw469ed/b3AfrMTmnkz+//K3efp2z6HPLKUxNN8UXbjBN0BIjkDqAE0LyX7kkv
         OznS//v7DBQ9zEXHuIQuZJaWkJXD6tVIZ/teXPLN9sHncSsci4bzzR5NLWV9/HvUTe/m
         WFgm8FJYZQmll4HYzVhnscWGABKGbKfrVf0IkaejgFJUq4BsDdv/kJBJl0CbURKlbQiX
         pdlw==
X-Gm-Message-State: AOJu0YzOYQzwc/xS4ZMtjJotvY1lnIKhBJi6PxckZ7EF5qdPh5GW6Bsj
	lh7ZoHD/G47JuNmOMvogrnJbMSLQA0o=
X-Google-Smtp-Source: AGHT+IFlQqoTpWvtut3H4+mxdlx9PyKTqsw6HBj5lIMxXtqYXPaF1/zPZl9+ASSlBDaCP31Few51+Q==
X-Received: by 2002:a05:6512:31c7:b0:50e:7de4:863f with SMTP id j7-20020a05651231c700b0050e7de4863fmr1741960lfe.86.1704727059567;
        Mon, 08 Jan 2024 07:17:39 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090632c100b00a28fa7838a1sm4061425ejk.172.2024.01.08.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:17:39 -0800 (PST)
Date: Mon, 8 Jan 2024 07:17:36 -0800
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, leit@meta.com,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>,
	Wei Wang <weiwan@google.com>
Subject: Re: [PATCH net-next] net/ipv6: resolve warning in ip6_fib.c
Message-ID: <ZZwSEJv2HgI0cD4J@gmail.com>
References: <20240105173920.1041474-1-leitao@debian.org>
 <8ae4f9b0-1917-448d-a89b-11597549f89b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae4f9b0-1917-448d-a89b-11597549f89b@kernel.org>

On Sat, Jan 06, 2024 at 09:13:53AM -0700, David Ahern wrote:
> On 1/5/24 10:39 AM, Breno Leitao wrote:

> > -#if RT6_DEBUG >= 3
> > -#define RT6_TRACE(x...) pr_debug(x)
> > -#else
> > -#define RT6_TRACE(x...) do { ; } while (0)
> > -#endif
> > +#define RT6_TRACE(x...) do { if (RT6_DEBUG > 3) pr_debug(x); } while (0)
> >  
> >  struct rt6_info;
> >  struct fib6_info;
> 
> I question the value of RT6_TRACE vs just using pr_debug; pr_debug has
> zero cost until enabled and can be enabled by file or line. Not
> requiring a kernel build is actual better.
> 
> [cc'ed Wei who added the macro]

I also questioned it.

Anyway, if we don't hear any strong opinion in favor of RT6_TRACE(), I
will replace it by pr_debug() in a v2.

