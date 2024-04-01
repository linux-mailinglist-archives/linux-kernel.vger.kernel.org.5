Return-Path: <linux-kernel+bounces-126680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF30893B60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13400B20EB6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA83F9D3;
	Mon,  1 Apr 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NHa0hk6s"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8A21A0A;
	Mon,  1 Apr 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977706; cv=none; b=F6Mqpqe/xj3uRHr6ud9ftOr1URXS+d91lc/fj79aSdIrU2e0SIi63cJfNqRU4qjdrpY8Lgj99TKjEfOx01BcbPBylQyDmNj9GJvUPL+iDUjhBmfxN06VMvDWgrxlphDBKBD8TKEe8Y6ukb4eojVp7/LE5fk15aYPBV4J5YSBKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977706; c=relaxed/simple;
	bh=Pvj3W9vMpYYXEBCVV8FYX9pJanbCNb8yW1Aw7jAJ0Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtjZqgJrAPV1R38u2w0gR1rikqDvoff45DdEBkDhuNcI+0dA+bq0MqbtFQbV47Q7EhzN5tolr4ALCpJ4/9SljIguODn1u2F4DdXn6moxJnLbqKZnaoOSGQh3C+Jh4UaXMhubYNP7JQZ7/9FXJSBZ2U18EacDxaK4b6eBEJxSTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NHa0hk6s; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0ztbKwxnOONze6uE5KAh6nif3N82SFeibbZIcAhXlYU=; b=NHa0hk6sMYXxr+xwUvnjlKQUnF
	MEqYyBd6WXe4P9ZmqgpFKFUvIBNOHaBie9S5C1YhSJv8Rs/O97U7tb1LxxqHskQdD1UlbinKsB+aB
	EktpoqosJWLm0tByrCD4QbzTiyNWz9U4N/Lz06EG+U+fHcpR6RTubhijoN4D12R1a3RbKhjqZzytW
	BkIacfu/lXSbvo+KO4MFTQKStY32m8k4CV+MStArowuITtWgTKdneNI3tp8JsNjLFZjrEcpdNHE19
	hhvZAfb+PsOkhrCrlY+7s1vWxZsBUXWOlsu967nT+FyNAomPB6W6ny8IGWR/HeEKvfcdFSlVpXgY8
	UuMW3vEw==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rrHbF-0001WQ-89; Mon, 01 Apr 2024 15:21:21 +0200
Message-ID: <4342d02c-a180-4a7e-8ef6-4ece51aba946@igalia.com>
Date: Mon, 1 Apr 2024 14:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Do not build debugfs related code when
 !CONFIG_DEBUG_FS
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, "T.J. Mercier"
 <tjmercier@google.com>, Tvrtko Ursulin <tursulin@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20240328145323.68872-1-tursulin@igalia.com>
 <CABdmKX3V3HGA4mNQvqHqhcLqyr-A5kJK8v9vmuDybRvV-KsiOg@mail.gmail.com>
 <9a063c39-6d2f-43c3-98b3-e4f8c3c6e9c4@ursulin.net>
 <1e94363a-b449-4efb-b2fe-c1dd710b57c9@amd.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <1e94363a-b449-4efb-b2fe-c1dd710b57c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01/04/2024 13:45, Christian König wrote:
> Am 01.04.24 um 14:39 schrieb Tvrtko Ursulin:
>>
>> On 29/03/2024 00:00, T.J. Mercier wrote:
>>> On Thu, Mar 28, 2024 at 7:53 AM Tvrtko Ursulin <tursulin@igalia.com> 
>>> wrote:
>>>>
>>>> From: Tvrtko Ursulin <tursulin@ursulin.net>
>>>>
>>>> There is no point in compiling in the list and mutex operations 
>>>> which are
>>>> only used from the dma-buf debugfs code, if debugfs is not compiled in.
>>>>
>>>> Put the code in questions behind some kconfig guards and so save 
>>>> some text
>>>> and maybe even a pointer per object at runtime when not enabled.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
>>>
>>> Reviewed-by: T.J. Mercier <tjmercier@google.com>
>>
>> Thanks!
>>
>> How would patches to dma-buf be typically landed? Via what tree I 
>> mean? drm-misc-next?
> 
> That should go through drm-misc-next.
> 
> And feel free to add Reviewed-by: Christian König 
> <christian.koenig@amd.com> as well.

Thanks!

Maarten if I got it right you are handling the next drm-misc-next pull - 
could you merge this one please?

Regards,

Tvrtko

