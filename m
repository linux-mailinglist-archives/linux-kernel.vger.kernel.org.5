Return-Path: <linux-kernel+bounces-134103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A289ADAA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C489A281D69
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CEF58104;
	Sat,  6 Apr 2024 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZXyAR67V"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306294E1BC;
	Sat,  6 Apr 2024 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712445974; cv=none; b=jzjd8G5A4FPqbPNsD6G8jScen5tXKqFXwWPmlXIj07GBdiJTLiHfzO5TQMo3qT+xCb0UW5gP2YYcsvW3Q2DE1M0V+0SICtsRosKhsvNFrmsJorgN72R+b4Cr1MUc9LZkYyijmubGmeuq+yREc35IeXoTKmfsxLaXqRFXFT4+AQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712445974; c=relaxed/simple;
	bh=qQomKcUd0m0bw86I9Yt/kYDQhwEx2KajxU9noPNj6Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiDbHppeUi4Cm9FGSFrJhOqFFgk57pc9x4raBKFjfQPCM6PLfDx1f2EnCBL2l2VEVqMi4xIJ5q5GZTqbehjmfW4lxlXdZtnchGGQy0fmbQFUDEO2d7E8CGCxzYH3wbry7fhXMVT3s2gGCKlc+863KFO431Stc2wvoUwa6KtZYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZXyAR67V; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=bh6VNfKRQ4UjAps7PEzIFr6/ZADT41T5JC8GOQiImPI=;
	t=1712445970; x=1712877970; b=ZXyAR67VGRyWw6uP78knK7T8/lg86PxWnSiXzj2TrsKHtKr
	Akbaa6LceZ9MMC/C0W5U7vPkOH21Nw4JuslEXb+nTkv+IgiMRuAhTUl/nPZd16h2ORJQBFREWZeKQ
	Ni4uWUPk4lDljF0tBKU7mKoQn4jz7rBgwijEkNSdyiOT9m7iXjYEWipPAl5zFihjozPndnM7883Tu
	7B3YQWPokkn19n104qtAcdW7FbcmVWbWCUQBlgMyQLpcOBKDfMeVtJgmeIugw7e34NhnGVtB5uO5h
	V4YUWQSsnTDtHioP9m63dE23JNJOWkX0/g5QKYeQfAr0fWu0ohHMyU9HevcXGWkA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rtFQ9-00006C-Pt; Sun, 07 Apr 2024 01:26:01 +0200
Message-ID: <f5144b9a-c7f5-4617-a1f2-5cc7549dc085@leemhuis.info>
Date: Sun, 7 Apr 2024 01:26:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>
Cc: linux-kernel@vger.kernel.org, Norbert Preining <norbert@preining.info>,
 stable@vger.kernel.org
References: <ZgvkIZFN23rkYhtS@burischnitzel>
 <6139700.lOV4Wx5bFT@natalenko.name> <20240406182943.GG1099@reaktio.net>
 <2724514.mvXUDI8C0e@natalenko.name>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2724514.mvXUDI8C0e@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712445970;8509c14a;
X-HE-SMSGID: 1rtFQ9-00006C-Pt

On 07.04.24 00:04, Oleksandr Natalenko wrote:
> On sobota 6. dubna 2024 20:29:43, CEST Pasi Kärkkäinen wrote:
>> On Wed, Apr 03, 2024 at 09:02:21PM +0200, Oleksandr Natalenko wrote:
>>> On úterý 2. dubna 2024 12:55:29, CEST Norbert Preining wrote:

>> I noticed possible related USB problem/regression also with Linux
>> 6.7.11, eg. my USB headset is not detected at all anymore when
>> running Linux 6.7.11. USB headset works OK with Linux 6.7.9, so the
>> regression is included/backported to also either in 6.7.10 or in
>> 6.7.11.
> 
> It wound be nice to narrow this range down even further with
> bisection because there are too many changes between v6.7.9 and
> v6.7.11 that could cause this.

*Only* if 6.8.y (or mainline) is affected as well, as 6.7.y is EOL and
won't be fixed anyway. And then it's likely better to bisect 6.8.y
directly. This might be of help:

https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Ciao, Thorsten

