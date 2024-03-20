Return-Path: <linux-kernel+bounces-108978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B2F8812CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1709B24F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01E4207A;
	Wed, 20 Mar 2024 13:59:29 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E441C84
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943169; cv=none; b=hdABD3UZx0OdCsF4J5tgbHcRUpYElyRQS1xLNmGwErSHdAsn2X2se34AFBUZKX/iWyCtBitXSjdDWLz+NGbcKHeRHN9DGPDDjlwlYqC4i52XXqa8dphm874RyH668sBtDFJWdpYLob+S+iGvLavbQKrv7hzXrORIadbbLU3JBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943169; c=relaxed/simple;
	bh=G85gk8kULJgYCpj1nfjaHJfgZ9BRlMYZWeSKjrAIvqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUF0m0l6sM5QNv3sKQhVOgC89uoFoHn0kwGKFVNUvgAUJ/PbyGCRt+bpv/eot9CD+1ok80x34oP1n4QNLNuCCblLFGi6r79VfyVkAofiAdsRgtHX0+CiNoKPYmRtw2jKvZDvhOZDknH/IGsfYPgI8L7UqC/FvAHEf3DO67v9XVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V08tY56f9z9xGYb
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:43:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AD19D140890
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:59:10 +0800 (CST)
Received: from [10.221.99.91] (unknown [10.221.99.91])
	by APP1 (Coremail) with SMTP id LxC2BwCHehOm6_plBBWtBA--.47981S2;
	Wed, 20 Mar 2024 14:59:10 +0100 (CET)
Message-ID: <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
Date: Wed, 20 Mar 2024 14:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
To: Richard Weinberger <richard@nod.at>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, petr <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
 <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
 <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCHehOm6_plBBWtBA--.47981S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1xZr13KFy8tFW3XF17Awb_yoW8Ar43pr
	ZxGa1DJrs2qw1Sya1j93y2y3W8KayfJr13Jrn8t3s5Zr1q93WxtrW3Kw4kGa4qvr4xuFyY
	krW7GF9Fva4Yy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

On 3/19/2024 11:18 PM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
>> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
>> <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
>> CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "petr" <petr@tesarici.cz>
>> Gesendet: Montag, 18. März 2024 14:09:07
>> Betreff: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in the vmalloc area
> 
>> On 3/12/2024 4:07 PM, Petr Tesarik wrote:
>>> On 2/23/2024 3:04 PM, Petr Tesarik wrote:
>>>> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>>>
>>>> If a segmentation fault is caused by accessing an address in the vmalloc
>>>> area, check that the target page is present.
>>>>
>>>> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
>>>> assumes that the fault is caused by a stale mapping and will be fixed by
>>>> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
>>>> a guard page, no mapping is created, and when the faulting instruction is
>>>> restarted, it will cause exactly the same fault again, effectively creating
>>>> an infinite loop.
>>>
>>> Ping. Any comment on this fix?
>>
>> I don't think I have seen a reply from you. If you did comment, then
>> your email has not reached me.
>>
>> Please, can you confirm you have seen my patch?
> 
> Yes. I'm just way behind my maintainer schedule. :-/

Understood. Thank you for your reply.

By the way, are you looking for more people to help with the amount of work?

Petr T


