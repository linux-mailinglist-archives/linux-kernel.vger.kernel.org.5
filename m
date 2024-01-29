Return-Path: <linux-kernel+bounces-43571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42128415A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3317E28693B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240B115959B;
	Mon, 29 Jan 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c7kNFtGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D3158D99;
	Mon, 29 Jan 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567328; cv=none; b=JN4rmNgAtiSXt9R0G0EXbo/vLl3+8L5ihv3lK/VYtivnzDGlFZsfUsHZFt06x55d1MOSus1Yle+yVtyLwKowK2FshEXrIylA9KTxrMB01askTqM8xQie+bpSBe2gid7mbZzsOZxbgrU8czDF1Xjkaq12Ug3fDM8GqD10uuYFb8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567328; c=relaxed/simple;
	bh=VS7jdPcE6dSMT1373ZknanUVpgzFMGDZVxVspSuXTQs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CHP7aoYkn0uZrnK8VefD8u01D2i30+XaHCvm61S7T0+WLImaTKeL+ydBsLkOAllMvABqcMS2ylK4XLRjX3i7ImtYTUCzcSXpwWn83aGqsvtHZhx31WM0GyBpEgIUBVmGEPvWuEjmCjvCtRIwAhUayeDAKkS127HHvK5H2xNXhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c7kNFtGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013BCC433F1;
	Mon, 29 Jan 2024 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706567328;
	bh=VS7jdPcE6dSMT1373ZknanUVpgzFMGDZVxVspSuXTQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7kNFtGDC8IrzHJuqzmW0p4mCllRtTT5DEh9sAC+3gC6NyMmZN1m8ROrckGYh6yDK
	 vpgLju/+BiIK0ydhts00G7n1cmrsCIquZG+YsBHEg0ToCde6xb1cWSbmi4SBVNQe5T
	 LPvEslsHjMy6sKiT9uepp3jbb9uoogZniSk6Vh+U=
Date: Mon, 29 Jan 2024 14:28:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
 "Hu.Yadi" <hu.yadi@h3c.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>
Subject: Re: linux-next: manual merge of the kselftest-fixes tree with the
 mm-hotfixes tree
Message-Id: <20240129142843.982dd12d63dc2d86a1e415ec@linux-foundation.org>
In-Reply-To: <c29848d6-29ca-4338-bbdc-abdc71cdd5f4@linuxfoundation.org>
References: <20240129085301.5458880a@canb.auug.org.au>
	<c29848d6-29ca-4338-bbdc-abdc71cdd5f4@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 12:01:53 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 1/28/24 14:53, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the kselftest-fixes tree got a conflict in:
> > 
> >    tools/testing/selftests/core/close_range_test.c
> > 
> > between commit:
> > 
> >    27a593e3f13a ("selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros")
> > 
> > from the mm-hotfixes-unstable branch of the mm-hotfixes tree and commit:
> > 
> >    b5a8a6de69bc ("selftests/core: Fix build issue with CLOSE_RANGE_UNSHARE")
> > 
> > from the kselftest-fixes tree.
> > 
> > I fixed it up (basically the same patch, I used the former which kept
> > the blank line) and can carry the fix as necessary. This is now fixed
> > as far as linux-next is concerned, but any non trivial conflicts should
> > be mentioned to your upstream maintainer when your tree is submitted for
> > merging.  You may also want to consider cooperating with the maintainer
> > of the conflicting tree to minimise any particularly complex conflicts.
> > 
> 
> Thank you Stephen.
> 
> Andrew, would you like me to drop this commit? I was planning to send
> pull request with this in later on today, but if you prefer, I can
> drop this commit and the send the PR.

It was in the batch of hotfixes I sent to Linus yesterday.

