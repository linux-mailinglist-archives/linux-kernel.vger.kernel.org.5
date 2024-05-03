Return-Path: <linux-kernel+bounces-167663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD48BACEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C171C21C13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A715357D;
	Fri,  3 May 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lueoNTY3"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893457CAF
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741274; cv=none; b=rCsYVOlJ1g6CUKRvmbN/TmjvAfZZ3jFBokPnxQLY1ntYbJN9IyqcBMvv/UrrnbnVD3KzruFKgDJgmBsWoX4xmFgkrpRKnDiLs2kNKdlO045HM15NPZ03M+9ybImnzM/PsDB7BT1W8zbt0Evem52PsrANWgBdIVYcVnJ6bbM2uDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741274; c=relaxed/simple;
	bh=Do5NaWPJRdTJS4p6Fav8hWLBi76YtLLBb0d9D3r76fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivy5/3Q0AvbXlN4uuI61zQeXl315+G9gU7c3/bjNqVWgHVOosnzOUG/6H7kgcZP7abf5p2BS4SGEz8X9O0fFYfL7+URMOPaY2o+dKCPrIJIExTNDva7FHZmFjqbpusRC/IpBk3GJVJKJQCAvbT935dWvFNbzJfGYwjuIr+Z6oB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lueoNTY3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b27e960016so1034345a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714741272; x=1715346072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGe9iHk592FnREABAAmLC2RGIJEqDWrEFBPZ0kIuDqc=;
        b=lueoNTY3D4Fl8Kn4KaTz1jOJboL+CSHBJjZ02BLnysc44Aomgts295U+8FhserpXcG
         48yms9U6PaHiYIB1kS4jbahivcmPcsCHiVk+mbcW4LlJ7rSFgxXafq1m538ks6R+buQH
         f82saqSfFLivUuWIXphKEDQDOnDwLXWgsThAQVLuTHaYDjz0Q3l4n8QB9YBOdYb96xA3
         UqMwODJTkjG613GzLfBJg9uA4iY1UONT6RFrum0jwyLQKcmtaYcfBwA75Vf+eXsBfIGR
         b7RiroITPDlb2N4HxyA4nEwf4hEGfg0wIUdcaCUjZUp3vB/VHXt0Mxr99oRBDFn1Zw+q
         74hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714741272; x=1715346072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGe9iHk592FnREABAAmLC2RGIJEqDWrEFBPZ0kIuDqc=;
        b=XE8BU9lATyY9Hnx0O06ze6YeHJR0tMjGwzoM9K+IWse2Jt+iS0Rqp1Hulb2bf6sW8A
         zGC7WQJMvB32nyzDOEzNssMooVj1DBiX4vSw/1tndXuprDUBlOKGlWrALfkA7fKufNkP
         ciOcTGF9HDwHNj+UdK+Qlw/L1SXeNTLTxspshuauVZU5rpb84dH3aRblD9fdAe/KYkrv
         JfMcwmJ4Tvg4uplUVSAGziqBNokUlMf0qQ6XNSM/Dyg1wzfruC3He42GPbZ3/xg4deum
         +bjXzJSO08i51MGo8MaGN0Sl30PU1OgoqtDY8aNA9R8nbE0OxbenwM3+ix/kBKMmSG3/
         MUMw==
X-Forwarded-Encrypted: i=1; AJvYcCXXlc+bjnwl4LsdR//XxBIs4znmN7WoeUri1R0BmZHIw9wHV5wyh4GmYbAQPwuhPMfKRZ1jSizS0Fo6npPvfA/Eam7cGjiHhapT1wCK
X-Gm-Message-State: AOJu0YwP1rEEkMnwCWE6mmDHgz8DOg8TdUUfA57xKnaywBKVDeAX5Pz9
	8NSSV2+WjDR3yQM3gE/5otpqVwbAURL9Get+u3lxkXSeIYefNRdxquHTZfa9
X-Google-Smtp-Source: AGHT+IEsBnMnJhN3w5igllmtU7fDy8IT8a3k2wVDA9oBp97xEamhRB7O7IF2D1f5oPfQ/z9AT2ta7Q==
X-Received: by 2002:a17:90a:9b09:b0:2b2:b080:dd35 with SMTP id f9-20020a17090a9b0900b002b2b080dd35mr2533129pjp.0.1714741270628;
        Fri, 03 May 2024 06:01:10 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id sz15-20020a17090b2d4f00b002aff85b97dfsm4977761pjb.27.2024.05.03.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:01:10 -0700 (PDT)
Date: Fri, 3 May 2024 21:01:06 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, llvm@lists.linux.dev, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] maple_tree: Fix build failure with W=1 and LLVM=1
Message-ID: <ZjTgEsuxYF29AVFJ@visitorckw-System-Product-Name>
References: <20240503095027.747838-1-visitorckw@gmail.com>
 <ZjTWkM9hTnoIhzqV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjTWkM9hTnoIhzqV@casper.infradead.org>

On Fri, May 03, 2024 at 01:20:32PM +0100, Matthew Wilcox wrote:
> On Fri, May 03, 2024 at 05:50:27PM +0800, Kuan-Wei Chiu wrote:
> > When compiling library code using "make W=1 LLVM=1 lib/", clang
> > generated the following compilation errors:
> > 
> > lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> > static inline void *mte_set_full(const struct maple_enode *node)
> 
> Uh, clang is wrong to flag these as an error.  They're just not used
> yet.

I think it's because the kernel defaults to treating all compilation
warnings as errors. If you turn off the option to treat compilation
warnings as errors, they will be treated as warnings instead. Should I
update my commit message to change compilation errors to compilation
warnings?

Regards,
Kuan-Wei

