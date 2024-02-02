Return-Path: <linux-kernel+bounces-50470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851F84798B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2064DB2C4F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E880633;
	Fri,  2 Feb 2024 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IB3/3JT6"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3B80618;
	Fri,  2 Feb 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901191; cv=none; b=E+2IM199/cFzR2mIksM5wjDPMi07QH7sG7uOTptsuZ9MGKKGtRtVGo46CMQE+vQ2mbSWF0txe4I177ewR2RlIl8I5QNpQ6pZDotHPVgj8QSU4x/oQ1I0Pe6+uYoELUvS27ljukdpcBcUXuTi1tpYxD1NEFxL5wZ/BJPUx+ogVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901191; c=relaxed/simple;
	bh=zS2ruA8tqKW4S6ZfvZ5YkkvA9o8UBqCZlA+Oud/kXL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzoRCAWACvtLjTA47bbezs03Lhq1LD+kzLIcaaDSJIVNgIuT6KFlMAdxyNbjtb6r1Vxo5Yepf35N2fEiXjMVhpcqkAyfMBMzLIVh+l/w9zdFprbjHkcApWxYu0PGTFtjxUhLxu6dRQySoO3z0hpyqDi7n6sc/eJuD+jdtKw8nu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IB3/3JT6; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id VyxArgRG8LHvUVyxBrSZHA; Fri, 02 Feb 2024 20:12:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706901120;
	bh=hgM+sL1lI70tjST9OWNADLTm22CNrbWKCKWuKXAi1Wc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IB3/3JT6Z9JwTQHO8O1IuAxpknm9XSa6vRNk/mJMGNMxeIHLklWEuuRA3HZHXbKCH
	 SIEacC8FD7VjBhbe2LtIsw/fUEespg7qsk02Is9GRLYAYHKpBAXRGGhUufgPYdDY3A
	 2k6OMW8d6JhRk0HaKA3QKz7BX/DXExTJoTja9xyZaQMsYCSt8Qj9F21o8cGcNsMpaE
	 773tUqCOZEgA8YEkKadnR0k0zs2o+4siRxG5vPS0l3xalOMxHQJhORRZABjtFQqugg
	 Qn2cLA+CzmSPs01iJnYwLHNLg0ziVOB9yWJfpVkvXjn6VBNnZHiQqVsZdW4wM4DtJB
	 T/X7JTTdd4/KQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 02 Feb 2024 20:12:00 +0100
X-ME-IP: 92.140.202.140
Message-ID: <30e5c9c2-b13a-4b7e-a266-1e03e654f1d3@wanadoo.fr>
Date: Fri, 2 Feb 2024 20:11:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nfc: hci: Save a few bytes of memory when
 registering a 'nfc_llc' engine
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
References: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
 <20240131150803.2fec5a5c@kernel.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240131150803.2fec5a5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/02/2024 à 00:08, Jakub Kicinski a écrit :
> On Sat, 27 Jan 2024 10:58:29 +0100 Christophe JAILLET wrote:
>> nfc_llc_register() calls pass a string literal as the 'name' parameter.
>>
>> So kstrdup_const() can be used instead of kfree() to avoid a memory
>> allocation in such cases.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> There is a kfree() call in nfc_llc_exit() that looks suspiciously
> like it may also free the name.
> 
> 

Hi,

you are right.


Should we have something like:

void nfc_llc_exit(void)
{
	struct nfc_llc_engine *llc_engine, *n;

	list_for_each_entry_safe(llc_engine, n, &llc_engines, entry)
		nfc_llc_unregister(&llc_engine->name);
}


It would be slower, but it would reduce code duplication as well.
This is just an _exit() function, so it shouldn't be called that often 
anyway, if called at all.

Or, add another function with the list_del()+kfree_const()+kfree(), that 
would be called from nfc_llc_exit() and nfc_llc_unregister(), to have 
the best of the 2 worlds?

CJ

