Return-Path: <linux-kernel+bounces-105567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D887E075
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BAF1C2160F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E220B0E;
	Sun, 17 Mar 2024 21:43:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B3208B0;
	Sun, 17 Mar 2024 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711832; cv=none; b=p6QAwUtho/uTnvQEDPm0hJGfhEm9/w8tyWr1NfbjLFT/nFKE2TXL+DO+/slzwdvmbWt1Qy4GgYGoey6hrY406mvrYTzF2qDduLvHCchEtnhmksmQmxKKV4rxpX/lPEARZ+ugOp8stYjpaSyY+Zxl0EayqHZGjjciLUTMjChPY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711832; c=relaxed/simple;
	bh=7Jwl9nHvhm8HIB5irkCQPgz2F16uv8z96D2pMKbVPB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZmttClrCYabtkHoU/2leujjIFqPvlu5Zc5cKmYExQp9hEK8qalK+yzKCmwAKyinVbbSoyA3rCfudSj6p0y+wyH0q4gk493hDr6RklpIhVjA2YqZM26BjnkBVauktkbBMUfWHSnnMm2mKOWHZrWXAjCmHIUtlAyEBLXEvx1ysvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63347C433F1;
	Sun, 17 Mar 2024 21:43:51 +0000 (UTC)
Date: Sun, 17 Mar 2024 17:46:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the ftrace tree
Message-ID: <20240317174609.7740c777@gandalf.local.home>
In-Reply-To: <20240318083535.79501c6e@canb.auug.org.au>
References: <20240318083535.79501c6e@canb.auug.org.au>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 08:35:35 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   2fd814ad5713 ("ring-buffer: Make wake once of ring_buffer_wait() more robust")
> 
> Fixes tag
> 
>   Fixes: 5b37b7eb98a19 ("ring-buffer: Make wake once of ring_buffer_wait() more robust")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> The Fixes tag seems to be referring to the commit that contains the
> Fixes tag :-(
> 
> Also, pleas keep all the commit message tags together at the end of the
> commit message.
> 

Bah, that looks to me to be a cut and paste error. Anyway, I'm rebasing all
of it as one of the commits was nacked by Linus. :-(

-- Steve

