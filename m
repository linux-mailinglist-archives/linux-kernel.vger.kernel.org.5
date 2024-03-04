Return-Path: <linux-kernel+bounces-90645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B08702AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA34285271
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5C3D996;
	Mon,  4 Mar 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0tlxS6qV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0733D579;
	Mon,  4 Mar 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558852; cv=none; b=AebEmkeLPx3NsJJagoE2zWiqQysUssXK7pTykxblb0tmaJX0t8JNyc43ockhmL6spcLJosLpqA4Ynd0TBK8BVnjtkL/EB10hdnQSRvEcq2snz4OtDlUzUsKD6ufZYgaz9t30vTCUTSZU1sKl4CPu/HIwJZ3M7LdnZGi2/l8A2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558852; c=relaxed/simple;
	bh=AXT83CsKS04YlrnMU/ETXsCuo5f4Okc9c/ART/JBAD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxdMeKGwGcEU8+P1IctlF0+ynVolL77j9sn0xjSLGroohDAHZ4siajpNTJNaoSKAeFtZEFFQtFoVAn2m1+BziDqS7wXN7JwZRVL7KAq1lHq5h0PpZVofTw/FlGaDVvy8R808Q0CSOFoNmLFEaBbcI47Ub11Rn9a4zf0oeQluWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0tlxS6qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBC1C43390;
	Mon,  4 Mar 2024 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709558851;
	bh=AXT83CsKS04YlrnMU/ETXsCuo5f4Okc9c/ART/JBAD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0tlxS6qVrdvzqApIqQuYs8I3eEuFgwlc+COKdoQ3ERDdpxCGpc/DDeGYuETJNPzI7
	 xb6dqhGYn770z46p21tEFvimEoKrscjPCGydoEdmXSoiVChbwYjFByr4tEDYJxPFS/
	 Ze2YUvOwkH0CQ+xedYdNgA8t3C8VnCVnlpuuIWLw=
Date: Mon, 4 Mar 2024 14:27:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	Ben Hutchings <ben@decadent.org.uk>,
	Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aditya Srivastava <yashsri421@gmail.com>, 1064035@bugs.debian.org
Subject: Re: [regression 5.10.y] linux-doc builds: Global symbol "$args"
 requires explicit package name (did you forget to declare "my $args"?) at
 ./scripts/kernel-doc line 1236.
Message-ID: <2024030412-street-phoenix-882e@gregkh>
References: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeHKjjPGoyv_b2Tg@eldamar.lan>

On Fri, Mar 01, 2024 at 01:31:10PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> Ben Hutchings reported in https://bugs.debian.org/1064035 a problem
> with the kernel-doc builds once 3080ea5553cc ("stddef: Introduce
> DECLARE_FLEX_ARRAY() helper") got applied in 5.10.210 (as
> prerequisite of another fix in 5.10.y):
> 
> > The backport of commit 3080ea5553cc "stddef: Introduce
> > DECLARE_FLEX_ARRAY() helper" modified scripts/kernel-doc and
> > introduced a syntax error:
> > 
> > Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
> > Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
> > Execution of ./scripts/kernel-doc aborted due to compilation errors.
> > 
> > This doesn't stop the documentation build process, but causes the
> > documentation that should be extracted by kernel-doc to be missing
> > from linux-doc-5.10.
> > 
> > We should be able to fix this by eithering backport commit
> > e86bdb24375a "scripts: kernel-doc: reduce repeated regex expressions
> > into variables" or replacing /$args/ with /([^,)]+)/.
> > 
> > Ben.
> 
> What would be prefered here from stable maintainers point of view?
> AFAICS e86bdb24375a ("scripts: kernel-doc: reduce repeated regex
> expressions into variables") won't apply cleanly and needs some
> refactoring. The alternative pointed out by Ben would be to replace
> the /$args/ with  /([^,)]+)/.

I'll take a patch that does either, your call :)

thanks,

greg k-h

