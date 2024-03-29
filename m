Return-Path: <linux-kernel+bounces-124454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D382589183A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2AEB21F59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809A7CF07;
	Fri, 29 Mar 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yXjSi+BS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538DA2A1A5;
	Fri, 29 Mar 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713410; cv=none; b=n/NBHZfsD1/yieaFyJfomWYDSNCVH7AxO0nxJ1vjzP1qcaNizgI9lSfoVh45bXmB7xlQP6bgliHkQqQ6cuAXO93k/JQ832m9rFMtziWykX43sRXQO/9/zWf+wlhyoZD49ksL/xUitoHBaNtEnQkHC79twICQqrGEc41CF45DY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713410; c=relaxed/simple;
	bh=N3vJLpKKCF66KRFxoWDNYIgz+O0iT8ojHf0tNeT60ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoVosm8cNXlo+UAuyHz6Q7m6vWVDH+L01xBRboxNLQBiPUbHqAAN4cLIaVxzbCZhMDAurF28vV6uKFq0K/qIU1X2kla3ozrtOdXz0vWoRU+nHDzpT0bOtZ13LN7nE/TIKSkTMw+iv5o6o1ykGNSt2FBA3cKSPTMJbyjQ7Rc9F8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yXjSi+BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E82DC433F1;
	Fri, 29 Mar 2024 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711713409;
	bh=N3vJLpKKCF66KRFxoWDNYIgz+O0iT8ojHf0tNeT60ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yXjSi+BSwuOzx9azE94oluhs2HbkaySjgvVzLNHynRDSzkO0EyZvMhiUt9YDwOA6t
	 ihA+/K4qfWt6oq4jMPDmhCHz/uqwB9AAAz94ESOIcafvoGfxj8abUvxBlywxQI6o4r
	 6HE6gmvINWym3jeFSud7+IdbwUNyEPZa0eQLaPIE=
Date: Fri, 29 Mar 2024 12:56:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Borislav Petkov <bp@alien8.de>, stable@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "x86/sev: Fix position dependent variable
 references in startup code" failed to apply to 6.8-stable tree
Message-ID: <2024032916-statue-skyrocket-af59@gregkh>
References: <20240327120810.2825990-1-sashal@kernel.org>
 <CAMj1kXGNneD2E=iGM18DMrAqKySi6JdDF-f-Sd+Vs036-_RL2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGNneD2E=iGM18DMrAqKySi6JdDF-f-Sd+Vs036-_RL2g@mail.gmail.com>

On Wed, Mar 27, 2024 at 04:39:20PM +0200, Ard Biesheuvel wrote:
> On Wed, 27 Mar 2024 at 14:08, Sasha Levin <sashal@kernel.org> wrote:
> >
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> 
> I will send the v6.8 backport separately right away.
> 
> v6.7 and v6.6 can take this patch unmodified but will need to take
> 29956748339aa8757a7e2f927a8679dd08f24bb6 as a prerequisite first.

Now done, thanks.

> (v6.8 no longer applies because of the way Linus fixed up a merge
> conflict in the 6.8 cycle)

I fixed this up by hand, hopefully got it right :)

> v6.1 and older need separate backports so i will send those out later.

Wonderful, thanks!

greg k-h

