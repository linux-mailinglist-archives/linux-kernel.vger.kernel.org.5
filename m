Return-Path: <linux-kernel+bounces-95203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D8874A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FE11F22597
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925483CC3;
	Thu,  7 Mar 2024 09:19:31 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EC839F4;
	Thu,  7 Mar 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803171; cv=none; b=UZt+PSwBKxk9QALJ7RQ+E2HTGpGhaPjcAHCNllUorh9jvQghtel/XJFt5G9JYXueWuhwekTaT25FJwIAvcKeb2AsTcyqdADJGzK+1Rx3+FWZvYrmScw5LhYfeQGbL8SzaIt4zjGm3LlXyn5l9Z4uCTcgRW0oTy6GfHgj0Ce7Dr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803171; c=relaxed/simple;
	bh=eQ4YiS6NQgEI0/5JNHw57o9eklne/wPcEXGDdoUR0P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLriM/G69/e0JUyla5AAarHH+vlQfKR1iozwHRGhdue0F+D0sJ8iS8T+Gc0QsX5MkmF8F4Vfyi+ib2ORbZYNSvBOvDiuYF7b+3t70QWUoP6laHMVEVurtStSYAU/5H7B2eUm4RC47wmkmU5mx7i7aW2Vh5zdZ0tdAFYFiZuZoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45606c8444so77816266b.3;
        Thu, 07 Mar 2024 01:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803168; x=1710407968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcMYRCTYmBdwjjxBMVHv7nDqpJkI2KJP97kVGpj1vF0=;
        b=FlLTLbOQ9IOuDl5hYvIzBMR8/bFVO7imEnPTXVpj8C6uPZLt7Em3M9AE381C61EK/F
         Gl2cp5KWbgVqqWJxCnNRJC92F3K/q170Kbw3mDocPQBnfnJL5zh9TYgHWVklEj4lao+z
         f+8MAq5VFWX7wlPCppzPE9l67ytSV/kCcxEfx4igLbqGIzmfjdKG6QtBYZ3OK6Td+VqX
         4NgDJ5G0Z5Dd4Y/lG7IlWLiawdI0Z/f2Nn7kdBmlnDcsVoBO8aN9yvW2NYiITytuvpKt
         ExTS8/mb2Jr5yzzFroK3UjUeznm63Knr0StdQ4OcEwad14HNIzq3FKSrM4s7t7PFZ3ZP
         6xvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC+9a3BNmOz21iz8LVkMDFKyRhb5nGIIERiavvfkRnT4raqGP59RURSA0lWRvqOYdeNl9mBB09OoS4nW9t2p7R4yx6IZ2vjkXBM0It6+qfiA8I7uQJHh0OSeIZqZwCjnmtsAU9
X-Gm-Message-State: AOJu0Yx/9kUoNjMZUAITvXOHhbyFIMvsTArYOULbZC5q8moRohVUNq7o
	P6fg/qw7/KjttU2S1yk7oxEbZqaT/vOrenx+/X8eJJ2i6zwLs4zGl2Erv6Oj
X-Google-Smtp-Source: AGHT+IE9e4KtBH24njgLcbSzNO6CmSzT4l/PaSKJ92fkeR+rlUv1HhUa6y0xJT9HU92eG2mrCEZfng==
X-Received: by 2002:a17:907:76fa:b0:a43:b472:9a57 with SMTP id kg26-20020a17090776fa00b00a43b4729a57mr12388945ejc.62.1709803167754;
        Thu, 07 Mar 2024 01:19:27 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a4452ed413asm7884686ejc.16.2024.03.07.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:19:27 -0800 (PST)
Date: Thu, 7 Mar 2024 01:19:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: gaoxingwang <gaoxingwang1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	liaichun@huawei.com, yanan@huawei.com
Subject: Re: [PATCH] net: fix print in skb_panic()
Message-ID: <ZemGnXjAbkG02NTg@gmail.com>
References: <20240307061143.989505-1-gaoxingwang1@huawei.com>
 <CANn89iKJSGek0vKtH-0QhFgZ9S4Cb1jTmpTq1ZmUFd0G0+b3ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKJSGek0vKtH-0QhFgZ9S4Cb1jTmpTq1ZmUFd0G0+b3ng@mail.gmail.com>

On Thu, Mar 07, 2024 at 07:29:47AM +0100, Eric Dumazet wrote:
> On Thu, Mar 7, 2024 at 7:12 AM gaoxingwang <gaoxingwang1@huawei.com> wrote:
> >
> > skb->len and sz are printed as negative numbers during the panic:
> > skbuff: skb_under_panic: text:ffffffff8e2d3eac len:-1961180312 put:-1961180408 head:ffff88800b6ac000 data:ffff887f804ffe78 tail:0x1e0 end:0xec0 dev:team0
> >
> 
> This was on purpose.
> 
> I prefer the negative values, I find this more useful to immediately
> spot the issue.

I missed this reply, sorry. Please ignore my previous reviewed-by. I
didn't have this context.

