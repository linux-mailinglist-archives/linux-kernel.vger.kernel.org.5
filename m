Return-Path: <linux-kernel+bounces-65352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A9854BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63F0286C57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7795A7B6;
	Wed, 14 Feb 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPQ83hme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799A5A785;
	Wed, 14 Feb 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921532; cv=none; b=uzt2kvpJPchsxfImi+fzVQVu8DHRFGVdCi3wTw+b7eBClF6H1qipPEQ2TA07zHh8rdvSl0IxJO7FHi+kzkEi+j+cSWIZjKCkHM0SnLOrU2a5u5TAa45Sqpj5UeEqA979uwhp+rrcMLcvSzXwlkA1e7C1sv+xFCkEfHr0OFpiiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921532; c=relaxed/simple;
	bh=S6Fhlyr3vl3t8eUwo3i08OkSMViPLX7U1fbJ4aaU4mo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VvgrK1LvRjY6GL9xMECAwyNUfpVJzpsISZtZex0dx8Dzx6DcR0d6gYpxXSSc3KgnqfSRZ7FGMtYCOt9vDnhAnPKpW2OlDZ4tslJvFDkAnzxvo+tzxPbwMTSr1NOylY9jdHxRCm/YRtpTVK0Y52uRk9RBoMLZCPJMlKpLdBB1gHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPQ83hme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E58C433C7;
	Wed, 14 Feb 2024 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707921532;
	bh=S6Fhlyr3vl3t8eUwo3i08OkSMViPLX7U1fbJ4aaU4mo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kPQ83hmeCkWWeW4CNrp5thqZd44u3GjKf9xqVcVMeEZzszWVdCW2Jod4D8muSZhWe
	 qI72JCQPYu8D/4t4Zta0ggVdE6aduXJeDhADboTV9+t20N9Sxo8KR/h3Mpk1blcWsH
	 DfqQtOpEPg9SIahtlQko9ydVd5YK9OTR0JIEdnHJyGfp7CY4HMauWnMBAdjrtEzPWi
	 A42Y0kTXyYtfkcgyhlGNL/eaaheOuOgdeoDdc9nNyN7/d/x8RBLZ0V/ZMPL7Kl9pcX
	 U27nL24rCUuJNSx1Lt5NfjOyDnZbxN6ajJRbaoz52U0afSjIdEkTOIipD57eXLXOY3
	 5i7v/lXuk2ULQ==
Date: Wed, 14 Feb 2024 15:38:52 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, security@kernel.org, 
    Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE
 process
In-Reply-To: <2024021459-trimness-bolt-7185@gregkh>
Message-ID: <nycvar.YFH.7.76.2402141535380.21798@cbobk.fhfr.pm>
References: <2024021430-blanching-spotter-c7c8@gregkh> <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm> <2024021459-trimness-bolt-7185@gregkh>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Greg Kroah-Hartman wrote:

> The people that make up the current team, Lee, Sasha, and I, have a LONG
> history of fixing and triaging and managing security bugs for the
> kernel, in the community and in corporate environments.  We know how to
> do this as we have been doing it for decades already.  

Thanks for clarifying. Maybe the wording could use some more verbosity 
then; one of my potential readings of it was "everything that gets picked 
for -stable will get a CVE assigned".

> If you or anyone else wishes to help us out with this classification, we 
> can gladly use the help.

Thanks, but no, thanks, I want to stay away from the CVE tragedy as far as 
possible :)

-- 
Jiri Kosina
SUSE Labs


