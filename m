Return-Path: <linux-kernel+bounces-103820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B97F87C4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAF61F22586
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A236768FE;
	Thu, 14 Mar 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y7r6v3Ue"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BF76416
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453557; cv=none; b=CCGcdkhFwDqsFGyHabsF3pjFSkniLxXL/zco5IdVA3HDnX3z3cJN1aSvFjEhKj5KGzIbPmJ/GWSr2dq1gTTZ9DCexm86HikjAuzeoteHdXKkEW31RJ327uXe7nfd3BSHxD94umZkSopep3Yd5JwW1G7N0io2l33nqvpMs7qOxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453557; c=relaxed/simple;
	bh=Gm5h7ocQGBzgSGVHEHZGDunuEGCq2v7EHj6bhjfuCFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDSnbkKoNMLj5O6WnWtMC88edM8psAqWWK5pqQH86FEtgR3q634sNuHxHyeTxItEO2Ue/fvpY8N8aFw+HuXkFsD/08KBECCosPnlPYe6ivFUeDH2OVzo5demuEPJG38yaNXP5r8CFzwZFaZ79x2t6U/RD+YsuMV1FGQ4kTeTZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y7r6v3Ue; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e610aa25-0340-4934-a588-10d5ffa512a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710453553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pb2TyShn5cGzp+TKV3K1QflBfbCiucgnS6X7KCZOU18=;
	b=Y7r6v3Uek51lhUcMekOlWmQi5IEWPXOWW2O4/ePZLoIFYbMRrqgyMTpJpZxHTqWDTcEY5R
	mEkiTmAPG0a0pUTHNLCgjow7/ldir8hE/DS3mMlLMAVEyBV6REI2uxYZZaJH2EQciII7l1
	F4WnbO+CEap7qeoAEBa8W7rfMfGOECI=
Date: Thu, 14 Mar 2024 14:59:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] Revert "net: Re-use and set
 mono_delivery_time bit for userspace tstamp packets"
Content-Language: en-US
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20240314192404.1867189-1-quic_abchauha@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240314192404.1867189-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/14/24 12:24 PM, Abhishek Chauhan wrote:
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

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


