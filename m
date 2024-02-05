Return-Path: <linux-kernel+bounces-53146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95284A13D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF61F231ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33985487B4;
	Mon,  5 Feb 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zts68Pc8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA88487AF;
	Mon,  5 Feb 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155212; cv=none; b=ngaplSrr3FIb4NzQRNn5fvE0Nx7YfRfE0m5NcuxQAGHnsN+uPf7xtg/B7G5eH5KCbXjR8x2LZG4m/4T4bjCjkLhi9z4Y4RXf8wJIAceGzymg9ExhdaNL1XOzWft22B2tMy55SGBl1Q8db69NXTrFMw8s0qtGF9nAzB5aiGrmrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155212; c=relaxed/simple;
	bh=NRazMgyQ4t8OFF9RlH51U+itralrR/W0ayR/8MnO3GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcRs80xeK/nuLkq5bvk/vSHQ6TJuR8F6ACw7jvp/t51ccJILep5HXpTb/yWHnLBIlfYrkV+xe1YGiv8bAKJEm8PkbZvcH6nQsn04opSFRp83AynqoWLQYvg7NTZWohXTpDsJbayhLJ0l7ivBDMFqWGMhcvSlSnrUQNHYA4pIJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zts68Pc8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d73066880eso40624755ad.3;
        Mon, 05 Feb 2024 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155210; x=1707760010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8dxd/+p8XXEG70kVGenn9HQTa5uVrn13k8Fv40UvsE=;
        b=Zts68Pc88s+dtzDU9gcXcQj/TCb4t0EfBcCazty0ZKrETlrYUHXyircJuhopf22WFX
         a3WelGDfHPRB8wvYZETwoj3Pmau4OAW2eQ7tt2OAxc30k93c5GXNqpnfGAw7rj61v+AS
         av7LwL+vHR9MEBXPruaz1AKJCx3mEYK72mdNjc1YAjTJh6g75sKjnUdrbrZ/3xqLCwwA
         jfJx2fSNICu52o+WFP8Ny+qIFATvBXeNWkY6FUxxy1a0Ssj44Lyp2cqVzZ8fYnYeVYON
         3+gmKTkWuOM+VEdAAB0gOQZsIx1i/TbnO2M8Y5FFVoPbUvt4uo9Bop45BVv7Lned6gaj
         GH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155210; x=1707760010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8dxd/+p8XXEG70kVGenn9HQTa5uVrn13k8Fv40UvsE=;
        b=r57mTK0HydrpfxGLTY+Pp+VW1u09DSu9INSjcotPlFZd9rOymUWaW9zr015af45gwk
         6qLwImh8qgxGoUOJE+C/l22JB/cCBUmJEflzBCz1Ck4ITiyRGS+VQDUUfQJftp2yg3nl
         ARK48haHOORuPEpE78Y8NcHaoZaUNj5PRCxuS1FPtROVbzI/EwYiZIk4tGa8PDOU6/UD
         NS2wJnU9j1EC2/x95nCGrBtIqenDhaTO4ZajcO6969awrBZ34lQTjQFhaAkhnz0pi/Ne
         6T4w3O5fWci6sfkcpTrGcU5D5nAqSTGnDMofm7QHs6PPzq99L/IdX70Sb2+fyCXgKGvr
         qU0Q==
X-Gm-Message-State: AOJu0YwaSvJbr/HtJsoSlL4DO5WbVwcte+VMZ1Ro+WF6qf1ZbK9QW6tz
	0zQ9D0QY3etyv+Wime7kO8ldRvDCAPLGp5dIBGEzsyJgo+CWtUUY
X-Google-Smtp-Source: AGHT+IGEI0V1evXvNb59DL0yWAZaAj3DbDoAu+2MRlEsA/I1OoEstOuj8xuskROtziadQ7OQ/2afPA==
X-Received: by 2002:a17:90a:ac14:b0:296:4177:eec8 with SMTP id o20-20020a17090aac1400b002964177eec8mr117794pjq.33.1707155210435;
        Mon, 05 Feb 2024 09:46:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxM4QUTfTfZEb32H6gvQcbzs4Krpa6IbT5HNDfTWrb8upjKgCqBJeQ9t4aJc1U7fj2RAAPdnfwUhC0XrLtki4KbM1tQXozqYqIMOXRLtxQyfW0KolaIUyEF+p3oxVhU4qpHZw9G+DQE2OAncKAa6l8BQXYEk+qwapcRhJDnrNnwOpTGHxOCOMYuEEcNn+YoJa06YUA7fqOTlsc9Am1tZyDxQXZKoHRT2SI8aSv6BRssMXbCkikVvS50gwPF7JLBItHfop1UZkOJuulsCY8Ms51jyR8O86iCrQtvtPXcDfuFnf5IqHs2lrOE6nqzC3RjsetkrU6flpQgq8jQBdExF/eiquINSg=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090a854100b002964ce7d420sm5275963pjw.42.2024.02.05.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:46:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 07:46:48 -1000
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <ZcEfCM160K5cnzHx@slm.duckdns.org>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
 <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
 <ZcDdlRzpofn2cAuO@alley>
 <20240205132515.GF69174@google.com>
 <a6762ad5-62f2-41d4-bba7-c2d9dcb12498@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6762ad5-62f2-41d4-bba7-c2d9dcb12498@paulmck-laptop>

On Mon, Feb 05, 2024 at 09:45:53AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 05, 2024 at 10:25:15PM +0900, Sergey Senozhatsky wrote:
> > On (24/02/05 14:07), Petr Mladek wrote:
> > > > Good point, if it does recur, I could try it on bare metal.
> > > 
> > > Please, me, John, and Sergey know if anyone see this again. I do not
> > > feel comfortable when there is problem which might make consoles calm.
> > 
> > Agreed.
> > 
> > > Bisection identified this commit:
> > > 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> > 
> > That commit triggered early boot use-after-free (per kasan) on
> > my system, which probably could derail some things.
> 
> And enabling KASAN on next-20240130 got me that same KASAN report and
> also suppressed the misbehavior, which is not surprising given that
> KASAN quarantines free memory for some time.  Plus enabling KASAN
> on recent -next does not trigger that KASAN report.
> 
> So my guess is that we can attribute my oddball test failures to
> that use after free.  But I will of course continue testing.

Can someone paste the KASAN report?

Thanks.

-- 
tejun

