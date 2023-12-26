Return-Path: <linux-kernel+bounces-11595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EB81E8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C5282B78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB704F89A;
	Tue, 26 Dec 2023 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f6UTDfbs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE14F88A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	In-Reply-To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qvwULKpW9AEQXDAvZ1gmJ02oIqJTvUgecJ2rclE5OwM=; b=f6UTDfbsqtgs1Ev0cLQUG2TDxK
	8K61gLHlVnKoRueYgujdK5JQvXiO6W6VmhDutsaPiTxS1aT74V81/5ufK4Bd/hHxeYq2cAGo/mu/r
	5bvRSESR3xqB979V4tz48V1XhWXQE6tJVEIM91ywz/XH6HhomxiZBTTMVXfJPQr/O95YL+EFDIsqo
	Ym2HJIINWhEqEGkZIbhHvl7hr5W0eExqv5H0b5i5CjB8+o1IjDwmTq+Gg8mmxsH2KiG+1X7l/44MP
	l4I+fpx2CZCkT0ExSMG889TXcROTl5xjXd9vuXxs3XUFpgVrd+DW4aNm5zVyCCBIOn7XA/9JpTX6H
	fO71d3Qw==;
Received: from [177.68.247.242] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rIAkK-000cMN-T4; Tue, 26 Dec 2023 17:57:37 +0100
Message-ID: <1c54063e-8ad2-5be3-85fe-519f5a944d20@igalia.com>
Date: Tue, 26 Dec 2023 13:57:30 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
In-Reply-To: <9bfb4c4bd1415a8ce527a913730672508a8e8330.camel@perches.com>
To: Steven Rostedt <rostedt@goodmis.org>, joe@perches.com,
 vincent.whitchurch@axis.com
Cc: jbaron@akamai.com, Ingo Molnar <mingo@redhat.com>, drinkcat@chromium.org,
 kernel@axis.com, "corbet@lwn.net" <corbet@lwn.net>,
 Petr Mladek <pmladek@suse.com>, sergey.senozhatsky@gmail.com,
 john.ogness@linutronix.de, linux-kernel <linux-kernel@vger.kernel.org>,
 gpiccoli@igalia.com
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[First of all, apologies for necro'ing this thread - for those that
somehow deleted the full thread of their clients, here is the link:
https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/]

So, I would like to reopen this discussion. Is there any reason this
feature wasn't merged Joe? Can we improve something in order to get it
into mainline?

I'm saying that 'cause I almost implemented this myself here, I have the
same use case as Vicent's - but thankfully, I searched before and he
already implemented that. As per my understanding, there was no
objection from Steven, right?

Thanks in advance! And happy holidays =)
Cheers,


Guilherme

