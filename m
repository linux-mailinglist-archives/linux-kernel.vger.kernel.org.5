Return-Path: <linux-kernel+bounces-88461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD486E1EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DA41F23085
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4D6BFAB;
	Fri,  1 Mar 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="qd3500ft"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4810E9;
	Fri,  1 Mar 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299359; cv=none; b=EtYtwRO9ZqYiLMb2qS/Y5dutrkcZ2jnFyGSSATVl6jUUCONxJcfvRDD3DheBhRxVnpe/tasbxHipLhYyEa5GTSEbfCX4RxOCiRfqQCOyuxb7AJdIxOl1IQNklGekJIXrVQOpDakugz7AI56+nf0/DYK6d0wztJ1r0eIPPYjcNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299359; c=relaxed/simple;
	bh=cr2xzVzhBgRlA4qOBy83c8kVVYBBeoVu7rnkvJ5fZzo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sN8wL/eJbCsbtBDCMwoEWczIiin0Mvotpayz5EVauUlOR+xhL3KseoFzu9D80EUJT0//9SZgbnxXkbH9V18kPWa+SZhIncCxlIQZgFZXMktdcryCu0kWGiEB3nyiStKh9PB5yzA3QbZdog3Soqb+9E2Z8Y/JNrfgYxWZ9Zxzkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=qd3500ft; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=gO2dxyiql6R0pRnjLVBTDL+/qu9DBW5s7IS4Px0iE6A=;
	t=1709299357; x=1709731357; b=qd3500ftlQtxDys+gdpqs+bx9idBlgirBoRBC8NsiYYFE1a
	DJxe/b6P5XkFPihvhHP3YWDhEJiXEISpG3TF1vmrhG5/iIvZg5rqFIj3Kx9ma2p2QrkBOwdqjaz2d
	uYKftZySDMwFJ9q0+D+uwi5zAc0xF0BhbnkhaMz++OwF842SMB4r5thVMsSkH1aKt3d6Ybv/ToKyl
	8b43AVNgx7+hWWld/01T54w3Z5MZvK51qA6V25emBZ1xzcpji+fOohsWMgXbu4qDeoEpzrm5rN2Vc
	N4IJyjYLBA9G0nkVbUEQScm+eC6aqEHEXqwD0KMg9qavntP05EMX3klRKT0c1ebA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rg2qK-0006R6-HH; Fri, 01 Mar 2024 14:22:28 +0100
Message-ID: <6d282271-25fa-4ed9-9748-df3705f9d5fb@leemhuis.info>
Date: Fri, 1 Mar 2024 14:22:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: new text on bisecting which also covers bug
 validation
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>, Vegard Nossum <vegard.nossum@oracle.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <02b084a06de4ad61ac4ecd92b9265d4df4d03d71.1709282441.git.linux@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <02b084a06de4ad61ac4ecd92b9265d4df4d03d71.1709282441.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709299357;39e0a914;
X-HE-SMSGID: 1rg2qK-0006R6-HH

On 01.03.24 09:41, Thorsten Leemhuis wrote:
> Add a second document on bisecting regressions explaining the whole
> process from beginning to end -- while also describing how to validate
> if a problem is still present in mainline.  This "two in one" approach
> is possible, as checking whenever a bug is in mainline is one of the
> first steps before performing a bisection anyway and thus needs to be
> described. Due to this approach the text also works quite nicely in
> conjunction with Documentation/admin-guide/reporting-issues.rst, as it
> covers all typical cases where users will need to build a kernel in
> exactly the same order.
> [...]
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index ed8a629e59c86a..c53bb6e36291b8 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -1,4 +1,3 @@
> -=================================================

Just saw that, that line obviously was not meant to be removed. Sorry.

Jonathan, in case you consider merging this "soon", as suggested
yesterday by  Vegard, could you please fix this up? Otherwise I'll fix
this with v3.

Ciao, Thorsten

