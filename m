Return-Path: <linux-kernel+bounces-56055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C584C56C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594232873AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A461F955;
	Wed,  7 Feb 2024 07:04:53 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262A1F933;
	Wed,  7 Feb 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289493; cv=none; b=ZPN+cTd+1Q2uGAS3gYh5hkPfYIq52ZmsLjFPdp6HvSnKd1/5Ay3sAhTFn+09qE16Lg1MqcmIPkWMyY8bSMVriGwQb40cPEoR4Ogdbg9jhQbDKMmZsMastmmHgxgut88cALQAZZ3ufLW/VKUbbCXEg0GtIpEGHIMWkz6vTN2NUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289493; c=relaxed/simple;
	bh=kRiuQOdL4BBOsZpUQoHkM684kud96KtUHWvGbmmCe8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjTDzc0SBO+Nf/iW2/PkLvZwolwmBt0+K8Wa2D3+Qu558GWy0XpFgrWHoj8TkXUaHdKqWtZQQoEkUWL6Gjr59gpcaPAWk+DqzSZf0CYwAbj1MwkaTDrhpzEohI/kEm/Nu915PBnZ6fA7mtsn6edNbcIV8+1raoBIoqlIPHYA6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rXbzF-0005db-P2; Wed, 07 Feb 2024 08:04:49 +0100
Message-ID: <e4305f3d-ede8-44fc-8bd4-eae899284f56@leemhuis.info>
Date: Wed, 7 Feb 2024 08:04:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707289491;864c9d9f;
X-HE-SMSGID: 1rXbzF-0005db-P2

On 04.02.24 05:43, Стас Ничипорович wrote:
> After trying again to create the ipset with timeout option I get a kernel panic
> # ipset create throttled-ips hash:ip family inet hashsize 1024 maxelem
> 100000 timeout 600 bucketsize 12 initval 0x22b96e3a
> ipset v7.20: Set cannot be created: set with the same name already exists

To be sure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced fdb8e12cc2cc
#regzbot title netfilter: WARNING when using ipset with timeout option
#regzbot fix: netfilter: ipset: Missing gc cancellations fixed
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

