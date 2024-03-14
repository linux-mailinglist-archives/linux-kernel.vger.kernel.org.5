Return-Path: <linux-kernel+bounces-103796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F387C4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FA4B219FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBD768E4;
	Thu, 14 Mar 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="O/Sud1ey"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450A5C61C;
	Thu, 14 Mar 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450858; cv=none; b=Ta19hV3z16WiWdbwPDTsO78PvgX/L+sMIZdLtebCFfzuqOJFvqt3qEYXsQY+3RZjbQ6eOzMhHb7QePiU3hsT+GCvb42fBPnvymmIYkGmyRByHyS7V2YXWUqzRivDdDGf0gieKI6mwoCk4fGjnEg/MuaIIb4qTrMUd+/t+scSA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450858; c=relaxed/simple;
	bh=NqUxaKorBKFrsVCBM5oPO2MgNVrkppgV+OylEpqNesY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kFVn9UmXFaGN4UKfDChWeqHCJBJ3KjERBx+WmEhNoXfEMT8zfuHN2+m55VBNl3fpGC8AvbttYEGuGbaOin+xwpjmBkGFxGyML0Hwglt88OVWKYB8m5q6uKAWygpKszFMJwprmiPfBOFcM2L1P5rCmhNd8CFG7nBJXGUSqDXKAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=O/Sud1ey; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qJVyiIR9i0hx/lkhDbRUXWeAnQ5APdwZD/eQGeT1viQ=; b=O/Sud1eyEbLu66iFmKrtf07UqF
	v1626CR9sSLWkneoww9pzJ/DzC/Gu/xXEn9dSFpuGUdC0zEQIF8quK42+wNY47OanmEzxv9xz22za
	MhS+i45LFKl0E88MjuPFPcesBRjHST2erj/3+sXJP9lQjfZ/2cA302fZKGKKPa53EiLUhJxHZ8mIo
	ZFsLyAGd0LwEC5M69YguTWQ0Q3pPvbFjlH40Jp2zpkULnS6jAk8xp4mqiGuCWdrG5UsSsEz0XgJxC
	dK9edqJGpljuVnTSuVdevhDB23pAivJCOwo28PqPVg9+9LQ5bEANyQJ9MUqvD3B7DqJDX5J5QygIw
	G3SBtBVQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rksOp-000N7z-Ts; Thu, 14 Mar 2024 22:14:03 +0100
Received: from [178.197.249.11] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rksOo-00D9Ea-2y;
	Thu, 14 Mar 2024 22:14:02 +0100
Subject: Re: [PATCH net-next v3] Revert "net: Re-use and set
 mono_delivery_time bit for userspace tstamp packets"
To: Abhishek Chauhan <quic_abchauha@quicinc.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com, bpf@vger.kernel.org
References: <20240314192404.1867189-1-quic_abchauha@quicinc.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <695f3ef3-7b30-7806-60d0-bd3d27130361@iogearbox.net>
Date: Thu, 14 Mar 2024 22:14:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240314192404.1867189-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27214/Thu Mar 14 09:25:48 2024)

On 3/14/24 8:24 PM, Abhishek Chauhan wrote:
> This reverts commit 885c36e59f46375c138de18ff1692f18eff67b7f.
> 
> The patch currently broke the bpf selftest test_tc_dtime because
> uapi field __sk_buff->tstamp_type depends on skb->mono_delivery_time which
> does not necessarily mean mono with the original fix as the bit was re-used
> for userspace timestamp as well to avoid tstamp reset in the forwarding
> path. To solve this we need to keep mono_delivery_time as is and
> introduce another bit called user_delivery_time and fall back to the
> initial proposal of setting the user_delivery_time bit based on
> sk_clockid set from userspace.
> 
> Fixes: 885c36e59f46 ("net: Re-use and set mono_delivery_time bit for userspace tstamp packets")
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

[ Side note: target tree for this fix is net not net-next, the follow-up
   work would be net-next then. ]

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

