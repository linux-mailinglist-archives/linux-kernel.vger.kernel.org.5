Return-Path: <linux-kernel+bounces-12028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D045C81EF10
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A43282B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0C44C7E;
	Wed, 27 Dec 2023 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XzhVJM5W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2344C62
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zWNoCeBPuwrufndIlawKoVxLIqDRCnllnUjaGLSIpMw=; b=XzhVJM5W+HadtWx290P4Dkbe+0
	8YICpI22zv7ouGsPGQ0QufsNPYx95tou5xX4xVtC5zwgu3A2ZpoGLcEhOWiWuB4vxKmulBxBu1kJx
	TF3/yRBQYUwGErrgoYf3DOYj8QUCJ7fPksOZ9bLJzQJwAXcMv0wUdC9tnLR1uCYyerxFqTD9vSK6B
	sSKhJEAwXO1l6fhnGhtwGPQeUfaOnom+gFByNjnFpP+/Hx9DZMxkHrMsm2uWM9iipyp9uPg9spbD9
	WFc9inEb1T6dq2EjNmzjN9JO0JrqZJDA7vJchtUHef5bBaHvEpYL76Nk/NmVaHWTrYQ6lvi2CI6Sb
	540+SIew==;
Received: from [177.68.247.242] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rITcT-000qo0-FU; Wed, 27 Dec 2023 14:06:45 +0100
Message-ID: <e555a194-e1c6-544c-218b-6b82f3ab5f41@igalia.com>
Date: Wed, 27 Dec 2023 10:06:37 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "joe@perches.com" <joe@perches.com>,
 "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
 "jbaron@akamai.com" <jbaron@akamai.com>,
 "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
 "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
 kernel <kernel@axis.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "drinkcat@chromium.org" <drinkcat@chromium.org>,
 "lb@semihalf.com" <lb@semihalf.com>
References: <1c54063e-8ad2-5be3-85fe-519f5a944d20@igalia.com>
 <8e0f337c0dde3fe81fc71620275852c4d42beeaf.camel@axis.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <8e0f337c0dde3fe81fc71620275852c4d42beeaf.camel@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/12/2023 05:29, Vincent Whitchurch wrote:
> On Tue, 2023-12-26 at 13:57 -0300, Guilherme G. Piccoli wrote:
>> [First of all, apologies for necro'ing this thread - for those that
>> somehow deleted the full thread of their clients, here is the link:
>> https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/]
>>
>> So, I would like to reopen this discussion. Is there any reason this
>> feature wasn't merged Joe? Can we improve something in order to get it
>> into mainline?
>>
>> I'm saying that 'cause I almost implemented this myself here, I have the
>> same use case as Vicent's - but thankfully, I searched before and he
>> already implemented that. As per my understanding, there was no
>> objection from Steven, right?
> 
> Jim and Łukasz (CC'd) are actively working on getting this feature
> merged:
> 
>  https://lore.kernel.org/lkml/20231223015131.2836090-1-lb@semihalf.com/

This is great, thank you!

