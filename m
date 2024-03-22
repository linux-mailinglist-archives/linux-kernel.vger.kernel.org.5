Return-Path: <linux-kernel+bounces-111622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F7886ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B1D1F2403D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFE482DD;
	Fri, 22 Mar 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVkvVjCc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF1481BF;
	Fri, 22 Mar 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117956; cv=none; b=CTZesDNh26y7zsCQTYr5/Bhyp8AmOWbHynj9HyGxgLw4CFjL/Z8c2aEJ70+5E+4j5YT3TOpN1fpuENjPKwn3L8ITNVma+GaHo4RE7GG+uPpaNQNXd1Im/bQXCpYzJaAktlNq1ZkzDR9YQOSfWvCWnJi+atMh4REykx/XE9Yi6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117956; c=relaxed/simple;
	bh=vKaOIZF4DLEl90/ANtY5rrdDzHHEDzzZztBT8HWHpT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWvUUm8s4gK8cG2RazW3N71ifFFX1b4X9rpxu8/P0Y+8nT+7x3m1UsWtJMatrRxcb8lhTjeS+AwFnh8vAYe7EyFEFdneXlfcLjZL7/xH+/nviSdtpMBKJC/neSdPtsb4n4yJ9TBg8EfWUWAl3j+/UW/nb7MGpQxZ/wdHzbz1Cbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVkvVjCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78399C43390;
	Fri, 22 Mar 2024 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117955;
	bh=vKaOIZF4DLEl90/ANtY5rrdDzHHEDzzZztBT8HWHpT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVkvVjCcN8h/a/CLqv6uRnImpgCT84UQm2XJBJvhBhePq9kXmJhOpWkrqf6yxQRuO
	 vMHEuVBs5DnrFmtpXG+n6sdezxEGDINDesEmRBFP3p0YWZi+LEQDryhifyAbXZEH9a
	 PVaFHgczzoC69H8YLMSXp20ug/T5aYm/WvcXHFMcYNv96Xy5y9OGh2+uOOlbe8mZqa
	 NIsiIvua6VWE/xcOunp5Wkd25tTA9X/9EVJJpKa1CRq2iikJsAdfb4DSZZBTG8v4Y0
	 OA8IA7u9UOHE4ANpp6sEung1Y4DdDjDCvWfOwJgIxq2zaz3cMhuZguFDwlvYfeegM9
	 WqB+MqX1dWEiw==
Date: Fri, 22 Mar 2024 11:32:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <Zf2WgB9JNqVuw9LR@x1>
References: <20240322084131.2316eb8f@canb.auug.org.au>
 <ZfzAKMlYY7IkWXUg@x1>
 <ZfzAZJmrBwVi5e28@x1>
 <20240322103229.28d823b8@canb.auug.org.au>
 <20240322131338.4ef08fe1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322131338.4ef08fe1@canb.auug.org.au>

On Fri, Mar 22, 2024 at 01:13:38PM +1100, Stephen Rothwell wrote:
> Hi Arnaldo,
> 
> On Fri, 22 Mar 2024 10:32:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Thu, 21 Mar 2024 20:19:00 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>  > 
> > > About this specific problem, was this done on over a previous build? Can
> > > you try after a 'make -C tools/perf clean' ?  
> > 
> > It was done over a previous build.  I can try a clean build later
> > today.  We have had this problem before with different include files
> > and I think it came down to a missing dependency.
> 
> It builds OK if I do the clean first.

Thanks for checking, I'll try and have this noticed by make so that it
works even when doing it on a previous build.

- Arnaldo

