Return-Path: <linux-kernel+bounces-65377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76725854C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E37B2715B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224F5BAD9;
	Wed, 14 Feb 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="rfkPfXKF"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1A5A4CE;
	Wed, 14 Feb 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922916; cv=none; b=hJEuATabd04O8Ohj5WIS5zCKxnZFD5CdFjywPI2COKWkxCH06mT5rKXcWOjbF6xiHwL3Msx5Z3fi5Z8Thva/hz0oiP/9WZ0XWOMneqkUgxKqAARX/PR2ZHhuoPqWMcaWNM2WVuPXyYoI+w0YPveiPgQ1uzPtjOz+22D05hjQeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922916; c=relaxed/simple;
	bh=MA5CG8ZPxr9j61ieXNWQg0zI2IXSl8QLuVz7JxDklWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJ7AxJ2QJzkTwmd69k8ppknZDtNodST+mnY2t8DTxvyFc3SUFs8f/BXhw6i8iJDMrZzZF5BQ2gx7wlWYasGVdb+9JE/FkgtG4cKBE6wWsdug6yGFPXkGOp6A71QVsHeB93bKQFBvjEkl88pNftsk7Jppg4wlmkcLzbDxD2nM3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=rfkPfXKF; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id F23371A2C5A;
	Wed, 14 Feb 2024 15:55:39 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707922540; bh=V/LB2qopI6o0g1XHu1b29Ik8gPX5TgEGhvR0Q5GGVzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rfkPfXKF4zD9tEikgRhMIL7jn5TadE/e60ZNGiLbEq6GXy6UUJCTRyfq/6Vgxk41O
	 su435zOm7YiVhp33zlKa/OEP5Z3MA3F0XUteo3Hm1dMTkLXk6YX1azAY6/bYuABrTB
	 f7BHrFJaIO3hx0Sj17P02LiETWNlm1zJQ04wytp4f4KRlFub1oz5F3jGkvAH8U8qWI
	 GO8E9jHus4SYO/2liMinJBl5a8UF9t4jOzdIvEgS/YXy+D+DIoinDmNrGd9trXO4zT
	 Ey0Cc5O8eSlGLGsVnZ9jsaC6i2UCOVNdRh/VrihmIfWCJ/JwPZ/YtL2dC604WIF0Vg
	 exKxYgVxi93aA==
Date: Wed, 14 Feb 2024 15:55:24 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, David
 Kaplan <david.kaplan@amd.com>, Larry Dewey <larry.dewey@amd.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Carlos Bilbao
 <carlos.bilbao@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Eric DeVolder
 <eric.devolder@oracle.com>, Marc =?UTF-8?B?QXVyw6hsZQ==?= La France
 <tsi@tuyoix.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Guenter Roeck <groeck@chromium.org>, Mike Christie
 <michael.christie@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <20240214155524.719ffb15@meshulam.tesarici.cz>
In-Reply-To: <2024021425-audition-expand-2901@gregkh>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	<20240214113035.2117-6-petrtesarik@huaweicloud.com>
	<20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
	<2024021425-audition-expand-2901@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 15:01:25 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 14, 2024 at 05:30:53AM -0800, Andrew Morton wrote:
> > On Wed, 14 Feb 2024 12:30:35 +0100 Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> >   
> > > +Although data structures are not serialized and deserialized between kernel
> > > +mode and sandbox mode, all directly and indirectly referenced data structures
> > > +must be explicitly mapped into the sandbox, which requires some manual effort.  
> > 
> > Maybe I'm missing something here, but...
> > 
> > The requirement that the sandboxed function only ever touch two linear
> > blocks of memory (yes?) seems a tremendous limitation.  I mean, how can
> > the sandboxed function call kmalloc()?  How can it call any useful
> > kernel functions?  They'll all touch memory which lies outside the
> > sandbox areas?
> > 
> > Perhaps a simple but real-world example would help clarify.  
> 
> I agree, this looks like an "interesting" framework, but we don't add
> code to the kernel without a real, in-kernel user for it.
> 
> Without such a thing, we can't even consider it for inclusion as we
> don't know how it will actually work and how any subsystem would use it.
> 
> Petr, do you have an user for this today?

Hi Greg & Andrew,

your observations is correct. In this form, the framework is quite
limited, and exactly this objections was expected. You have even
spotted one of the first enhancements I tested on top of this framework
(dynamic memory allocation).

The intended use case is code that processes untrusted data that is not
properly sanitized, but where performance is not critical. Some
examples include decompressing initramfs, loading a kernel module. Or
decoding a boot logo; I think I've noticed a vulnerability in another
project recently... ;-)

Of course, even decompression needs dynamic memory. My plan is to
extend the mechanism. Right now I'm mapping all of kernel text into the
sandbox. Later, I'd like to decompose the text section too. The pages
which contain sandboxed code should be mapped, but rest of the kernel
should not. If the sandbox tries to call kmalloc(), vmalloc(), or
schedule(), the attempt will generate a page fault. Sandbox page faults
are already intercepted, so handle_sbm_call() can decide if the call
should be allowed or not. If the sandbox policy says ALLOW, the page
fault handler will perform the API call on behalf of the sandboxed code
and return results, possibly with some post-call action, e.g. map some
more pages to the address space.

The fact that all communication with the rest of the kernel happens
through CPU exceptions is the reason this mechanism is unsuitable for
performance-critical applications.

OK, so why didn't I send the whole thing?

Decomposition of the kernel requires many more changes, e.g. in linker
scripts. Some of them depend on this patch series. Before I go and
clean up my code into something that can be submitted, I want to get
feedback from guys like you, to know if the whole idea would be even
considered, aka "Fail Fast".

Petr T

