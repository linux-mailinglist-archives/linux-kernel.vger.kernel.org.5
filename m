Return-Path: <linux-kernel+bounces-80095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C7862AB0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF3C281A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5914A89;
	Sun, 25 Feb 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CGN+DXPw"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B714012;
	Sun, 25 Feb 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708870911; cv=none; b=QxHfHXFy7QJkwudRTf5HaWfI18QJXx0FP5vWj5ZSIR/iorbyuIfc6gnaJiiixLFs1EOyg9GYE26E+qjE3Q9J9iGXPw1qROCiIhjyPREvnMvOg5PrcddHmpWl5Wqe7jhYDQRB7YEqGFBYME+hWbHtxWX13CyEFSvXqe1u2Ci+Ejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708870911; c=relaxed/simple;
	bh=RCSh2ROZ/iFeMJsDJRaRk0vcrWxy8Y3mHcAABJnhl5A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=ERwXjnv8Ka+uaG7vPtZJAQdVqoxnE+rXlntMX8udIygUrhxq1pENVi7BaamT2Q43WmATpJuKQmtlFHy5OAgEpSw/ANSZk8b8rMZc9Zvpe3f2eITMJDO6gMn5nZKJ72PhDo2UjG2DlQXr4PnF28DGp6//wevgsTOtlu3HiazC2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CGN+DXPw; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=5zcxi1j2bz9y7GX419P/KFYBN93Ly9pm3MHmLrZHkIA=;
	t=1708870909; x=1709302909; b=CGN+DXPwpjp7tELQUqJ237fTJraF2a62JvOi3sYTDkieDHr
	LbVBJquOZaZ6L+uftuZtCXlEEQrQpmRvL4Gxu8+TppKie+jBmVskIaIgtrQftnf3C2KoiN7YbBYSY
	s9KhyB+7dTDp6hkDN+aXoHllFiN7TXvlWL8VHuQrX2XqltuG+eHIv6M3Sw4WeYFOsBg4DGG1PGgKW
	T+p3t05v7rBKtlceC9GMR++lPSX5L5767N9QK+Y5Fm0ytOCt2aUpmFH8o7Vqkjf+M61Hwtr3cEGBk
	4b2H/DJsE4zcTTpM3RfdR6hg1prfL+fDMr8aufsflE0gCAEAEUodTIUvKV1YJ0EA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1reFNz-0003Ps-2p; Sun, 25 Feb 2024 15:21:47 +0100
Message-ID: <5ffb73e0-4b00-4bbb-857a-30a48945758d@leemhuis.info>
Date: Sun, 25 Feb 2024 15:21:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux regressions report for mainline [2024-02-25]
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <170886726066.1516351.14377022830495300698@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 ntfs3@lists.linux.dev,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <170886726066.1516351.14377022830495300698@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708870909;c050b0ec;
X-HE-SMSGID: 1reFNz-0003Ps-2p

On 25.02.24 14:21, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> Hi Linus, things look mostly normal from my point of view and a few
> fixes for tracked issues are heading your way today or next week.
> Nevertheless let me mention one issue where I fear that they might not
> be fixed before the release:
> 
> * Decreased network outgoing speed due to irq sharing that started with
> [...]

Sorry, forgot something: there is a patch to fix a ntfs3 build problem
that was posted 10+ days ago[1] that didn't get any reaction from the
ntfs3 maintainer at all. Given the history of occasional slow responses
for that subsystem I thought I'd let you know in case you want to pick
the fix up directly; but if you do, consider using v2 of the patch[2].

[1] https://lore.kernel.org/all/20240214224500.811609-1-shiftee@posteo.net/
[2] https://lore.kernel.org/all/20240221104358.2290969-1-shiftee@posteo.net/

Ciao, Thorsten

