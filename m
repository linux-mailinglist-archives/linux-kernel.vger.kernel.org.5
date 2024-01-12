Return-Path: <linux-kernel+bounces-24415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8FF82BC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2671284214
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9135D753;
	Fri, 12 Jan 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctU6Cqpe"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DA59B67;
	Fri, 12 Jan 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e759ece35so6947703e87.3;
        Fri, 12 Jan 2024 00:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705047171; x=1705651971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWtunZGiLl6cWBGqo46zVKuFT9uezI1y9KmXw7dm9gg=;
        b=ctU6CqpeLEQ/z4gPoBs37Cb/b96aPspspKGOHJ+revjs4B4ykwkkCHe/EfnCP9lhXN
         cjGJFkG4HXLgHVK8HDuoCWD+oW4XBRYlUe1cm+YZy+C8qvCCQkDEsO9mZsiCYUAMeqJF
         vwQDQKdtx9Nn/l2PjVR3IgLEaWWYGeqcZc2OJSaj7HCVcNkUuQtRUyp0jk/sqEzA1OFv
         dZRT0e9/jXx1wfyC36+Pao1NCGwX7F1CqGnZTZAx1LlxaMhNTy5QoDVM1Q24pxc/IOeb
         6MJPJYByLsFFr5Fft6GO/hJopxZdLYHFSfnYuLXnfolusl0huApQ58vmgRksK5Wdjb+o
         gjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705047171; x=1705651971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWtunZGiLl6cWBGqo46zVKuFT9uezI1y9KmXw7dm9gg=;
        b=sK+eJgWRpezu/YuD7fDZRB7hIxB3QWLuj4fsLgwuZc82jpT4n++yP3qE6wjSz0tbLu
         1vWLIj8UqEtWv8A33mOgTySIkvcgt6sqI7UL7b9oyzn4LDR1+ywhwQBoq+ZOPahYxxX7
         9xIBM/0L1p6IvOFuq+XuD3sD57JrHtbK4AzAiGvN2CPDz7vzPAclD10Et70tcf8DEDey
         iKVD4K1RgmtsX2NYOoZAZA/Q2Mn/btyDp/u6uLD1qwY819Q7OFba2/yMuBBlwsuhXZz8
         0DtDgAHtfGiPbLqkwrjfWbvkY2AmPzFcIpF4pQbHTmUnYjjhslmywKyTqhdrIh13znFz
         QAbg==
X-Gm-Message-State: AOJu0YwZ6RI4Dfb8POwnXrLeztYKF62z2tpA/t2zUPiZJKz8XMaAqkyF
	NcbnglXC55rwPKvxw5lPICvqvQNlGtZi7g==
X-Google-Smtp-Source: AGHT+IGs/APEDiVvLgMVU3j1NPALyrgAOMz356h8X4RaWnpyjqYDts3lKDtvvy/16i7LIjyX85d5xw==
X-Received: by 2002:ac2:4643:0:b0:50e:7437:163c with SMTP id s3-20020ac24643000000b0050e7437163cmr373551lfo.119.1705047170671;
        Fri, 12 Jan 2024 00:12:50 -0800 (PST)
Received: from pc636 (host-90-233-192-22.mobileonline.telia.com. [90.233.192.22])
        by smtp.gmail.com with ESMTPSA id y20-20020ac255b4000000b0050e7ee56355sm431117lfg.23.2024.01.12.00.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 00:12:50 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 12 Jan 2024 09:12:47 +0100
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, urezki@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Jan 11 (mm/vmalloc.c)
Message-ID: <ZaD0f7dDz4GCKh-v@pc636>
References: <20240111144846.74e443a7@canb.auug.org.au>
 <74388269-0a03-4c10-8408-fc204c843fd7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74388269-0a03-4c10-8408-fc204c843fd7@infradead.org>

On Thu, Jan 11, 2024 at 03:51:50PM -0800, Randy Dunlap wrote:
> 
> 
> On 1/10/24 19:48, Stephen Rothwell wrote:
> > Hi all,
> > 
> > News: the merge window has opened, so please do not add any material
> > intended for v6.9 to your linux-next included branches until asfter
> > v6.8-rc1 has been released.
> > 
> > Changes since 20240110:
> > 
> 
> on riscv 64-bit, i386, and UML:
> 
> ../mm/vmalloc.c: In function 'vmalloc_dump_obj':
> ../mm/vmalloc.c:4691:22: warning: 'addr' is used uninitialized [-Wuninitialized]
>  4691 |                 va = __find_vmap_area(addr, &vn->busy.root);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../mm/vmalloc.c:4684:23: note: 'addr' was declared here
>  4684 |         unsigned long addr;
>       |                       ^~~~
> 
> 
Yesterday i sent out the fix.

https://lore.kernel.org/linux-mm/ZaARXdbigD1hWuOS@pc638.lan/T/

--
Uladzislau Rezki

