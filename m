Return-Path: <linux-kernel+bounces-93681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FEB873331
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238251C25D35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37095F467;
	Wed,  6 Mar 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InADAXEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008885DF06;
	Wed,  6 Mar 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718948; cv=none; b=S7/aTpYpIvdpZOrUgq8rxKtu8hbzuSGz4gqDndatZJuaXkvFzIb77XTz5332f4yXDKxTvp/+7N2oSKwrefglyxUMURkhnIlg2BsBPJpVOpmWJR+cf7uLQahpjGbRTsN/dF7N/BB1v8hmT+uwIA4JkXw+xaSGm4lbIJVGzmDO4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718948; c=relaxed/simple;
	bh=dup48kaib2L/bKU8uwW0nwMt//arxlDgChz0V2ZGaSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFUZ5YNxk130wrXHEqwi4WCmEXR/bjeHVw72aRCyGz48h4LecopRXqE0yAeoajwxSZbpDvieK+7rTZN720RjK/HDft0ivIMAE2HMSFsMCAfakddCY0gWuTMNAwYCzBMugnU9niwXGGPEHxQKJEjT6Vg6FEeoeVGw9y8e4lMBO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InADAXEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F008DC433C7;
	Wed,  6 Mar 2024 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718947;
	bh=dup48kaib2L/bKU8uwW0nwMt//arxlDgChz0V2ZGaSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InADAXEi2JGdmVGpom2KWFDDXLD42EPDneT2/ujqkJFpAyi5FqzMhg4V37dSmdb8C
	 KylWKvqgm2Dk1LZZtt615nz+8E4o8P2Qk685RuoFUI1ABy8kFMWAFrBTSNgDCKbMIt
	 QP1El4MMpbd1OzLNEJzJnJV+N9rCspDPRT6vOBMwEdl9TL2/PSKR+wbDSVSZJRukrO
	 l6Keq/SHq/FoUKGlafu2yUV9emWIfdaSKb1IEgZK9j4qJdvWhAliXleMoxm1Qm2w+L
	 hCF8O54wR0s5yWSDxelyE846fBFh4KynEWFgFBURVTzGEvg9Uzb2bCJ2fYjzcTjVCL
	 kTNvyhEawzZJw==
Date: Wed, 6 Mar 2024 10:55:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Tong Tiangen <tongtiangen@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20240306-staufer-parklandschaft-0b0c0532ac91@brauner>
References: <20240306105150.06a456da@canb.auug.org.au>
 <CAHk-=whdTCEDaUPTMHUQXPQHuM8dhBi8yWbNAL11yE_ODqR_uA@mail.gmail.com>
 <20240306153703.499661d2@canb.auug.org.au>
 <CAHk-=wiJLeR6tPcEmiRndhVtrPex0WavrFZ0UZHGjABVc=Tq1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJLeR6tPcEmiRndhVtrPex0WavrFZ0UZHGjABVc=Tq1w@mail.gmail.com>

On Tue, Mar 05, 2024 at 08:47:40PM -0800, Linus Torvalds wrote:
> On Tue, 5 Mar 2024 at 20:37, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > +static struct page *dump_page_copy(struct page *src, struct page *dst)
> > +{
> > +        return NULL;
> > +}
> 
> No, it needs to be "return src;" not NULL.
> 
> That
> 
>   #define dump_page_copy(src, dst) ((dst), (src))
> 
> was supposed to be a "use 'dst', return 'src'" macro, and is correct
> as that. The problem - as you noticed - is that it causes that "left
> side of comma expression has no effect" warning.
> 
> (Technically it *does* have an effect - exactly the "argument is used"
> one - but the compiler warning does make sense).
> 
> Actually, the simplest thing to do is probably just
> 
>   #define dump_page_free(x) ((void)(x))
>   #define dump_page_copy(src, dst) (src)
> 
> where the "use" of the 'dump_page' argument is that dump_page_free()
> void cast, and dump_page_copy() simply doesn't need to use it at all.
> 
> Christian?

I would just do it like Stephen did (but returning src ofc) because it's
symmetric to the #ifdef copy_mc_to_kernel definition of dump_page_copy()
and seems easier to read to me.

But I honestly don't care too much. So I'd pick Stephen's change and if
you prefer to do it differently just change it when I send you the pr.

+/*
+ * If we might get machine checks from kernel accesses during the
+ * core dump, let's get those errors early rather than during the
+ * IO. This is not performance-critical enough to warrant having
+ * all the machine check logic in the iovec paths.
+ */
+#ifdef copy_mc_to_kernel
+
+#define dump_page_alloc() alloc_page(GFP_KERNEL)
+#define dump_page_free(x) __free_page(x)
+static struct page *dump_page_copy(struct page *src, struct page *dst)
+{
+       void *buf = kmap_local_page(src);
+       size_t left = copy_mc_to_kernel(page_address(dst), buf, PAGE_SIZE);
+       kunmap_local(buf);
+       return left ? NULL : dst;
+}
+
+#else
+
+/* We just want to return non-NULL; it's never used. */
+#define dump_page_alloc() ERR_PTR(-EINVAL)
+#define dump_page_free(x) ((void)(x))
+static inline struct page *dump_page_copy(struct page *src, struct page *dst)
+{
+       return src;
+}
+#endif

