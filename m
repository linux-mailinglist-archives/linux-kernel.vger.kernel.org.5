Return-Path: <linux-kernel+bounces-148764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0848A8718
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC21282401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9C146A6D;
	Wed, 17 Apr 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SujSoTJq"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC31411E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366590; cv=none; b=C4jeM7KCoyXTPzomusQ7zfXRczilU1hZvZue7Z8SOfHPXKeddihvNguf1iT78NSJACcbW9WxJOe7+Hup2s8yanTFYR/iU6X/CBNG1PgSs84xgjtTqWugwJfjQ7Q1RCuEatbHX9mSGsEh2CLAh4U4s244h4HByVrBSHhcGcSrP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366590; c=relaxed/simple;
	bh=8/ndKsyDdPbYJxhCPt8qWb8eVYwJzOrjbW6CzpMtHzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpUSyrslyioPjQemyvWQhzY9GA/yET5htyGHrAm/dc3YC8Dk1B9qEYZvMI9JnnfNb7GErdQ8kJV81aeNLy+kEUZbLjD+48PlG5Yho/e1M9+m64Uy0ngw3YQR4yc0VFquSMOMYc8EPNr1bDhQ2P2mvExg6tMtTviRqlXzeP25RWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (0-bit key) header.d=zytor.com header.i=@zytor.com header.b=SujSoTJq reason="key not found in DNS"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HF9Od44070556
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Apr 2024 08:09:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HF9Od44070556
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713366565;
	bh=eKE4+4ivVtTiOvgUyiFTI7AGJYe+HiykDs2LXrZq41U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SujSoTJqfMyMGuVRLhvAR+kcVmYbXZXq9wg0am/lkIM1pupOAqJAE7384D0MNGoDX
	 LTcpXHYjSm3ecNy551ETobSqnlFy8cv502Jk8oWX7PgrKO7JXCc0SZY/PXBdAzOFEv
	 gRo9QvOhjv+HAdCmwPlMuOZ+yQtz1bsQt/2rNGSDKQtwdblQhFV0crkXC0/rUJcJXF
	 6QH8ne5Lg9kqkIlQVQNfQdaSzOkH7fNm6NtTv55vRvM9YwTGv1NSYy61vfcpdsNTPg
	 KC2Bx6Kg1+G/JOYl4WdZ1IhWin2QQZfujypsKQTgLhY7nJJsk9POUcgeMe+rQGtxgZ
	 Afo6GTwBTFqJA==
Message-ID: <af0d21eb-c31c-4a3d-99ac-45abf3bdaabd@zytor.com>
Date: Wed, 17 Apr 2024 08:09:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
Content-Language: en-US
To: Xin Li <xin@zytor.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org
References: <20240417063001.3773507-1-xin@zytor.com>
 <20240417093813.GBZh-YhSQCXgy3OxFI@fat_crate.local>
 <e8180be8-b108-4047-ab49-2cfc532a2b52@zytor.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <e8180be8-b108-4047-ab49-2cfc532a2b52@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/24 08:06, Xin Li wrote:
> On 4/17/2024 2:38 AM, Borislav Petkov wrote:
>> On Tue, Apr 16, 2024 at 11:30:01PM -0700, Xin Li (Intel) wrote:
>>> 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
>>>     which is of event type EVENT_TYPE_SWINT, so compared with
>>>     do_int80_emulation(), there is no need to do any user mode check.
>>
>> What does that mean?
>>
>> An event handler doesn't dispatch INT insns?
>>
>> /me is confused.
>>
> 
> Maybe better to say?
> 
> The FRED kernel entry handler fred_entry_from_kernel() calls 
> fred_bad_type() if an event is of type EVENT_TYPE_SWINT because Kernel 
> does not use INT insns! So if the kernel is handling an INT insn, it can 
> only be from a user level application.
> 

(Note: if we at some point in the future we may end up adding INT calls 
from the kernel, at least on FRED it would *still* not share the same 
code paths and so int $0x80 would not get dispatched.)

	-hpa

