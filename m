Return-Path: <linux-kernel+bounces-108190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC90C880744
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E091F23472
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630A58AAF;
	Tue, 19 Mar 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCIYzZLs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEA4F606;
	Tue, 19 Mar 2024 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887278; cv=none; b=SdOygk/roLoxvuh6Jc+ZnOUTNzzkeq+CllaYJB1exGewJ9p3KLSmRLwQZlNOwlDCdmvNLSKgun2YHSwvMBdjYxO6t64ljKuBSGDweAZ5PvKWL7TL/NuoXW3deiXJvUY4XANBYplVGxcc2O9No/eGbJMfsl4m1me9VJshTrHUHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887278; c=relaxed/simple;
	bh=3E4E8B7vm+Xxpff5SUOHKd788iBWU8C+tly9Ks6iqng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7+NrK0MSQJV1Ai0NHdc+6pLtlwStB6QTYgZ+IPt6qPGOS9TJJAyNLx3OX0YFEpWBUECLcJtfr0B9udCq0qUdJeZytHJ8BWx1KV5F8V9oJykDQv4A9g41ab37Pk/TSsrx/0/b+UBE2Kiu2cTP3J0cSiTPbhMUcP58+/93j/rheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCIYzZLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B96C433F1;
	Tue, 19 Mar 2024 22:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710887277;
	bh=3E4E8B7vm+Xxpff5SUOHKd788iBWU8C+tly9Ks6iqng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCIYzZLsEwiXAIUO83scjvMXK3REeSfhd8pwabkEDAAI3OxKGwblDsZnfhT8MOKd2
	 EcZSSWXcWh5GBlU2yNNynUXHPY2IBJYuQquJeu9yv68zMunPq1YqLJrrOITrEo34I2
	 y9M8jGInsTSr0Or4xiqWUbwbWPT+qOvMlY+rgrwwJ5ao/yky6TEyWXP0m2aT8jpjsS
	 NSRTQPmFtbaSiwSZwtZX235vKAgnnaNrSXXpjc09DFtm4v5xVWB8MEKMr9llmiPHlD
	 c1oQZZEdsbtZwb3liVaDq1kLSY+nAyC47R1vcgr25SFHNPSSbs3mEIZWAjXzCdkmop
	 cAWqaxITwX/kw==
Date: Tue, 19 Mar 2024 15:27:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH 0/2] tracing: Fully silence instance of -Wstring-compare
Message-ID: <20240319222755.GA2005262@dev-arch.thelio-3990X>
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
 <20240319181509.25bacdc5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319181509.25bacdc5@gandalf.local.home>

On Tue, Mar 19, 2024 at 06:15:09PM -0400, Steven Rostedt wrote:
> On Tue, 19 Mar 2024 09:07:51 -0700
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Hi all,
> > 
> > This series fully resolves the new instance of -Wstring-compare from
> > within the __assign_str() macro. The first patch resolves a build
> > failure with GCC that would be seen with just the second patch applied.
> > The second patch actually hides the warning.
> > 
> > NOTE: This is based on trace/for-next, which does not contain the
> > minimum LLVM version bump that occurred later in the current merge
> > window, so this uses
> > 
> >   __diag_ignore(clang, 11, ...
> > 
> > instead of
> > 
> >   __diag_ignore(clang, 13, ...
> > 
> > which will be required when this is merged into Linus's tree. If you can
> > base this series on a tree that has the merge commit e5eb28f6d1af ("Merge
> > tag 'mm-nonmm-stable-2024-03-14-09-36' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm") in it, then that
> > change can be done at application time, rather than merge time (or I can
> > send a v2). It would be really nice for this to make the merge window so
> > that this warning does not proliferate into other trees that base on
> > -rc1.
> > 
> 
> I'm guessing this isn't needed with the last update.

Correct, this is resolved in Linus's tree and should be in -next
tomorrow. The first patch may be worth sending standalone, I'll think
about sending it later but that can go in via some other tree, not
yours.

Cheers,
Nathan

