Return-Path: <linux-kernel+bounces-119866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A68188CDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE541C65C20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD113DB87;
	Tue, 26 Mar 2024 20:08:32 +0000 (UTC)
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424E113D530;
	Tue, 26 Mar 2024 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483712; cv=none; b=SQCpjNCwfbcXyuCikenzu26u5pw9hYb8TA7GAWmso9sL/rYUZ2IqLMTZ0c/PVPxysKUGQ8USMcK212Sc6VCmPjT9g63H1DYvThYO9j+WTAG7HgQUCEBEpwIKsZoYt3F4WHZHjTLmjGCJbuWGAl7p1JckzscwvuPi1FyII7UqQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483712; c=relaxed/simple;
	bh=lW5hOyGlFN+yd+Ab/TlrPz895EMMK8mpatTkc5voeUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV/yDYmcIP/1IanpCXtv1q8MNGlTaG5sIw4Uzi8c0liwolEvpyeBXPWHpWprSCxEI4Fip3+Hc9JGGWm6iemNMmie/Lmw2+9ygKnvzAcI9GDALkRmWMdeJIWSWqb4hTR9YOYPhDv9vd50l0cVIq8Ond8j87nlU4DXKyJZMUqnRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=53888 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rpCtP-0005Dt-Fy;
	Tue, 26 Mar 2024 22:55:32 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1rpCtP-00DRyg-2r;
	Tue, 26 Mar 2024 22:55:31 +0300
Message-ID: <4b3e239d-ab87-4a37-ac1d-af49e1f8f3ee@ancud.ru>
Date: Tue, 26 Mar 2024 22:55:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu-tasks: Update show_rcu_tasks_trace_gp_kthread buffer
 size
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240326174839.487582-1-kiryushin@ancud.ru>
 <20240326152230.3e692d83@gandalf.local.home>
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <20240326152230.3e692d83@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1



On 3/26/24 22:22, Steven Rostedt wrote:
> Why 87? as it's not even word size, and this is on the stack.
>
Got 87 as maximal used buffer length (result of
sprintf(buf, "N%lu h:%lu/%lu/%lu",
         (unsigned long int) -1,
         (unsigned long int) -1,
         (unsigned long int) -1,
         (unsigned long int) -1);
+1 for terminator.

Is word-size alignment a thing in this case? I thought that char buffers
are ok to be aligned by 1?
> Better yet, why not just use snprintf()?
>
Seems like a better idea indeed, as if fixes overflows for unpractical cases,
without added overhead to common cases. The only concern is possible truncation
of data, that may break some automation (if output is parsed by someone,
without accounting on it being cut, who knows). But again, it is for pretty unpractical
values.

Will make a v2 patch with snprintf() with buffer length.

Genuinely look forward to being educated about aspects of aligning array sizes, as
I do not really understand the limitations.

Thanks!

