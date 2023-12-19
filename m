Return-Path: <linux-kernel+bounces-4550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E9817F33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A010D285722
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4115C4;
	Tue, 19 Dec 2023 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OT/EOIYv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB910E6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9344f30caso80924b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702948612; x=1703553412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/NXaF2lkQkA4iaZhFz9EGGgGx4EqVeSe9KT2hTARxc=;
        b=OT/EOIYvFJ4OJKFxIbgkimMCqyijyFqYrby8rOA++jE3GWJARb1+bab28IGC2lnBgB
         bn6zAEGAY7PmvDYyaCp8nbebuLX/xNJo9Gaz/9cmElIXblk1PdT6jiRjCN4STjE84jCo
         Hh8JVpwfKlhSrLuqr6BxxU6NTLfOejvs0O14tg11SGt64sB+HsrHUzOyQ6RCRRWt85K2
         9gncoLZLnObp9ypVOCfMQgcJUarQslhm5DhNQHZTZcUIVJwl1G5B3ezw1elU/lYhpgjj
         ybRmDa9D/89EWjrwSCSVO5onGYGWzIzEXWwrHyxVHszTcggxneG9gJ6lYMGYmKjb1WWg
         k6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948612; x=1703553412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/NXaF2lkQkA4iaZhFz9EGGgGx4EqVeSe9KT2hTARxc=;
        b=KTR3XfDX3K8F1UmVYQxgs4BQt3135wnQT6za+SSuBAbP8mF1UdqmQ2oJvFUatFPXUo
         th4PXtxJ+zxwpA6rzs8+Uxc7FRQ8d0z89DC+ScEbVUAWssAVubH+gkfylLzdyI+mVKjK
         gQvos+M3ND6TEwaxyJTJG+AgWoTsMo40ygisHeNK+QZuGhCqKiMZqfqv6R6AhAUTADtm
         ZYWTP8XiQR7kV1bgr2U1jtlKvjkF7n3C3kE5c1nbeRP4dqSx5mc+/7PZ4o6cW9cPq7EX
         MHpg2ZDbNOuulkMnQfzL66c/RhXB0snu74vtvlgZg64SxamDKCIWD3sXAFgN0wjQ2HkY
         43tA==
X-Gm-Message-State: AOJu0YxzdZqWs5AgbwCgEHi6NZAGNMhNRKkiCose7taLDLYJrpDqmaxy
	EjBTMk8lGXzAc0Zpui616ZsrdQ==
X-Google-Smtp-Source: AGHT+IEQ4bWWLrUQgcR+o6U+K4BEc5OG87UEe+UUxd2VPz1i1lmZ5iOiAipmJ9k6pgYjHPcIXJ3srw==
X-Received: by 2002:a05:6a00:1d0a:b0:6d8:8506:9c06 with SMTP id a10-20020a056a001d0a00b006d885069c06mr352310pfx.24.1702948611746;
        Mon, 18 Dec 2023 17:16:51 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id j4-20020a63ec04000000b0050f85ef50d1sm17951019pgh.26.2023.12.18.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 17:16:50 -0800 (PST)
Date: Tue, 19 Dec 2023 01:16:46 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Will Deacon <will@kernel.org>,
	John Stultz <jstultz@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: optionally use LLVM
 utilities
Message-ID: <ZYDu_ulZkxKg0I4x@google.com>
References: <20230929034836.403735-1-cmllamas@google.com>
 <20231219002318.p7yciyr4ld62l4ad@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219002318.p7yciyr4ld62l4ad@google.com>

On Tue, Dec 19, 2023 at 12:23:18AM +0000, Justin Stitt wrote:
> Hi,
> 
> On Fri, Sep 29, 2023 at 03:48:17AM +0000, Carlos Llamas wrote:
> > GNU's addr2line can have problems parsing a vmlinux built with LLVM,
> > particularly when LTO was used. In order to decode the traces correctly
> > this patch adds the ability to switch to LLVM's utilities readelf and
> > addr2line. The same approach is followed by Will in [1].
> >
> > Before:
> >   $ scripts/decode_stacktrace.sh vmlinux < kernel.log
> >   [17716.240635] Call trace:
> >   [17716.240646] skb_cow_data (??:?)
> >   [17716.240654] esp6_input (ld-temp.o:?)
> >   [17716.240666] xfrm_input (ld-temp.o:?)
> >   [17716.240674] xfrm6_rcv (??:?)
> >   [...]
> 
> Perhaps it is due to where I am dumping the stack, but I am getting good
> stack traces on mainline (with a LLVM-built kernel) without this patch.

Maybe you have set CROSS_COMPILE=llvm- in your environment? This is an
alternative workaround. I write more about this in the commit log.

> 
> With that being said, applying this patch still has good stack traces
> and it makes sense if it helps others.
> 
> >
> > After:
> >   $ LLVM=1 scripts/decode_stacktrace.sh vmlinux < kernel.log
> >   [17716.240635] Call trace:
> >   [17716.240646] skb_cow_data (include/linux/skbuff.h:2172 net/core/skbuff.c:4503)
> >   [17716.240654] esp6_input (net/ipv6/esp6.c:977)
> >   [17716.240666] xfrm_input (net/xfrm/xfrm_input.c:659)
> >   [17716.240674] xfrm6_rcv (net/ipv6/xfrm6_input.c:172)
> >   [...]
> >
> > Note that one could set CROSS_COMPILE=llvm- instead to hack around this
> > issue. However, doing so can break the decodecode routine as it will
> > force the selection of other LLVM utilities down the line e.g. llvm-as.
> >
> > [1] https://lore.kernel.org/all/20230914131225.13415-3-will@kernel.org/
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> Tested-by: Justin Stitt <justinstitt@google.com>
> 
> Note that this patch is similar: https://lore.kernel.org/all/20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com/

Ha, I see. Elliot's patch help revive this thread. Cool!

--
Thanks,
Carlos Llamas

