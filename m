Return-Path: <linux-kernel+bounces-77893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4E860BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AF91F2554D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB5171BC;
	Fri, 23 Feb 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="t5wfrjZC"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA4125AF;
	Fri, 23 Feb 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675666; cv=none; b=EIT3Qh3oSIc8clGSlDb0PgaApcRa1JJiTC/QC+2EKxXQaUK3MzjJiAIB0Aft/fWcZeqQnv9S4k2mcdxMJBHlr0wL6hiRf6THTHOn3+9mRtH8BEf5aIyKZtdcA0XWDNmlUSdtcfQjO/fRj2O7VSAMfELH5v63fGpEVocxWpyjQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675666; c=relaxed/simple;
	bh=ypenPyTF5ynt/pDgjgx+1rh7Y2dHoKZRn8wHfY2ebxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7mhWCnXyJ5ntvFo6dN5KxHMutNEwWTakNA4IVwSrInTbfXUPoDbZukPZi3YNt3b091zFw/i7Lm/XkE3JmwCANxGXCAyJvrjSQM4cS92yGFlrKSPrCAq0FwWfh9t7IrJrHZ64M11rvo5lPegtnfPRItcxdtPoOM/jCp02yScBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=t5wfrjZC; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ypenPyTF5ynt/pDgjgx+1rh7Y2dHoKZRn8wHfY2ebxo=;
	t=1708675664; x=1709107664; b=t5wfrjZCgikmySYj/9KBDxrZK6s2thCgvJl3Z74x/1veNCl
	0iXa4pm9sVFJwdXbqq4uGXQZqVJm51cjPkJS/T8BzVzvdhj0GuUIlvhPaNcOHUDUD/safcGnnCMVZ
	agGDm2tOkcG/AG6J5s7w7u6BhA+hv4r1zU3TYDWVEr7mtoBBjXdcG+OCnlCNzxJIm6zW3/2/xUcfm
	xZTqZ+tHLGWJyvf8s9cwuGpKcIExEIr3PLKjMbbEaFANdokrB+uzTROWmu0MiaK8H0UcGn+8AKKhX
	PA7ushcDk4JGo2OI8f2oep77VS6HZ6Bm0k9/FwSHTLrFfD2UdsNfPjCkSzBJm/Eg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rdQar-0007xw-Lf; Fri, 23 Feb 2024 09:07:41 +0100
Message-ID: <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info>
Date: Fri, 23 Feb 2024 09:07:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US, de-DE
To: song@kernel.org
Cc: gregkh@linuxfoundation.org, junxiao.bi@oracle.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 Dan Moulding <dan@danm.net>
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240220230658.11069-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708675664;98875bf2;
X-HE-SMSGID: 1rdQar-0007xw-Lf

On 21.02.24 00:06, Dan Moulding wrote:
> Just a friendly reminder that this regression still exists on the
> mainline. It has been reverted in 6.7 stable. But I upgraded a
> development system to 6.8-rc5 today and immediately hit this issue
> again. Then I saw that it hasn't yet been reverted in Linus' tree.

Song Liu, what's the status here? I aware that you fixed with quite a
few regressions recently, but it seems like resolving this one is
stalled. Or were you able to reproduce the issue or make some progress
and I just missed it?

And if not, what's the way forward here wrt to the release of 6.8?
Revert the culprit and try again later? Or is that not an option for one
reason or another?

Or do we assume that this is not a real issue? That it's caused by some
oddity (bit-flip in the metadata or something like that?) only to be
found in Dan's setup?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

