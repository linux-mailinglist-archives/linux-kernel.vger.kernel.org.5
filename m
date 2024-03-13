Return-Path: <linux-kernel+bounces-102544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99B87B3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF5D1F216BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBB56740;
	Wed, 13 Mar 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lBtZkWGT"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D58482D3;
	Wed, 13 Mar 2024 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366134; cv=none; b=er8oVcucqiTfZLiB7Px65CDmr2xAlV0lXLEG2mR9sOTNpUYWmzNDSouqeLOaaFVzHvJEUw1ajEBBKCy+aaeFoUqd0bk5H0lzxKsVqltFxeVtg+E13TvQ+7GO36hToVhHff+OIqhylhmDivF4r+XbHgmvpj88x8U86bvxXbwQAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366134; c=relaxed/simple;
	bh=UDD6nJy5LKVxEcx74mHkfaNIhdaXsDmXdSdoWYD3tQk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QDrf3FBkMJLi0RdWyuYSUQlllBNTdJBngtW9kbeHvjXgEM0Heuo5otaZ27EbT8pz/QS29igcjXmfRIlhJko8zCRcGetStpsl64A6BZD86UNeLlJWT+vYJB7GrZEbLR0eEwIpb01WNy+wAJbioLRcEEbkty+rX23lFSDGdTH/cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lBtZkWGT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7GE8YcmRLknEbeV60EceEz8pJp5RGK6eT1a+sdWBOZA=; b=lBtZkWGTjFJERjPGsFBpoaPh+F
	BezITbLRclMtDthJovP31Wd3yn2B4ehPO+oUBCp0Ok6HVlvi72fSsTBgAEzu/l0kcc/qKj10PvR8h
	KN/7XpKUJzKGBLSQAuJ0XVcl93XTwRuwIJQUEkFoZefN6sp29TQIjU6CYUOFQtsmc+AWYKt1b+Blx
	DVySp3cHDnCUyDP7LvhQqNxAEreimMhEPuBJZhzmd5E9yFYF3UlhPRIs2hjnJV9uolbPHl1/L04Bx
	miB6gDD5jDbDblBwArZ/2KIEM9g/0+ilng/1ooqyf7mWhul1U+5wbS8wDBzjneuVjFdLRM1qeq289
	g0cArwwg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rkWM6-0006Pa-4U; Wed, 13 Mar 2024 22:41:46 +0100
Received: from [178.197.249.11] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rkWM5-000FqN-3u; Wed, 13 Mar 2024 22:41:45 +0100
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
To: Martin KaFai Lau <martin.lau@linux.dev>,
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <02363fef-0b5e-4b6c-bad9-db924db230b9@quicinc.com>
 <0a0f948a-ca0e-4241-8a21-e7c7fc2ea471@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1e419a00-41cf-c760-7912-68b34b74f8d1@iogearbox.net>
Date: Wed, 13 Mar 2024 22:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0a0f948a-ca0e-4241-8a21-e7c7fc2ea471@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27213/Wed Mar 13 09:26:34 2024)

On 3/13/24 10:19 PM, Martin KaFai Lau wrote:
> On 3/13/24 1:59 PM, Abhishek Chauhan (ABC) wrote:
>>>> I think all this is crying for another bit in skb to mean user_delivery_time
>>>> (skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the
>>>> mono time either set by kernel-tcp or bpf.
>>>
>>> It does sound like the approach with least side effects.
>>>
>> Martin and Willem , while we are discussing to use seperate bit per skb to check if its
>> SO_TXTIME from userspace or (rcv) timestamp . I came across two flags used in skbuff
>> called in filter framework
>> @tc_at_ingress: used within tc_classify to distinguish in/egress
>> @from_ingress: packet was redirected from the ingress path
>>
>> Since i believe the above testcase is based on redirecting from ingress to egress part
>> why cant we use these already existing flags ? Please advice
>>
>> I am not completely sure if we can use these flags to solve the bpf problem or not.
> 
> I don't see how they are related. It can tell where a skb is at. It cannot tell what is in skb->tstamp.

+1, if we go that route as per discussion, I'd also prefer clearly encoding delivery
time clock base in skb to avoid ambiguity.

