Return-Path: <linux-kernel+bounces-69879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94092858FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69961C21237
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3EE7AE62;
	Sat, 17 Feb 2024 13:44:58 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045B657B6;
	Sat, 17 Feb 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177497; cv=none; b=uC2S7DyMuoWXF4zcvVG4l3pX8ZY47Qqe/69igyzUNrcXCn6EsipqnESGnMEm19P+7YiQi+e1+pfypbHd3NsgtTjWzMF/sxgZvm2YlnLya5PV2/I7vpqhyEN9+XTvF8VEPAOW7KEdP7J9DKk5LI88uuMDUUO9xsTnvnFyXs/xiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177497; c=relaxed/simple;
	bh=wt2LLaYXCk03zm2XSKQGJSBwd6IfnznINPWT5GRSu7A=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=P3NNXOcfKEyBN1z8usankLysjskq6hsvhlqUFaW8spPEKXiMYnz6pQQwqcSNUuHGo1exLf6VAJshcEHrsJhiAZSF7pZwcYkowcKSIsNIHCWTmI7eJVT7z3LOmsZw/R5r79+eLNHkyNQ1SyDksJ9YpiWJawKEyWhNC9ZzDNA3JtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rbKzr-0002oJ-VV; Sat, 17 Feb 2024 14:44:52 +0100
Message-ID: <307eb8d1-2fde-4e12-b48f-9632510b469e@leemhuis.info>
Date: Sat, 17 Feb 2024 14:44:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Yang Shi <shy828301@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: please pick up 4ef9ad19e17676 ("mm: huge_memory: don't force huge
 page alignment on 32 bit") in linux-6.7.y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708177495;a602e319;
X-HE-SMSGID: 1rbKzr-0002oJ-VV

Hi Greg! It seems to me that two of my mails to you[1] fell through the
cracks during the last two weeks, so I'm trying again with this main
that is not a reply to the earlier thread:

Could you please pick up 4ef9ad19e17676 ("mm: huge_memory: don't force
huge page alignment on 32 bit") in linux-6.7.y? The author ACKed that[2].

And btw: you might also want to pick up c4608d1bf7c653 ("mm: mmap:
map MAP_STACK to VM_NOHUGEPAGE") as well. Its stable tag contains a
typo, hence I guess your scripts have missed it (I only noticed that by
chance).

Ciao, Thorsten

[1]
https://lore.kernel.org/all/dc9f8eab-ec5c-46f1-a168-c510650d1cac@leemhuis.info/
https://lore.kernel.org/all/1354c5d5-99b7-4178-bcf5-9ddb776de946@leemhuis.info/

[2]
https://lore.kernel.org/all/CAHbLzkp7s1CcSE0rc-CpfcCrNtMdepAA5-K+0P4wz11x4SK6=g@mail.gmail.com/

