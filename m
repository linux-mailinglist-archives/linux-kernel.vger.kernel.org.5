Return-Path: <linux-kernel+bounces-103772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB80B87C44A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C616B2215F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D1762E8;
	Thu, 14 Mar 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC4TESjg"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC486FE0B;
	Thu, 14 Mar 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448132; cv=none; b=KCc0M9Z3+7ynYMrnOh10HjPbYmhD7aOiknAp9e8ePBReAO+PAF0Et8KQsqsyyoRfUtR77NmfZiWlBZj1WrTkBD/ySve4wG617yriFG20dysY/51N07hreaN6c7KTM4rSzFEyx9+NsCGm5Ob4cVLoQCwtoGvAjq8vio8Mb1lfN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448132; c=relaxed/simple;
	bh=CSLuRo45oS25PsjTaTFl3smBFMW61nQHF4/uB1uvbfY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O03mh7d2i18EqP/XufisSYDlEnYreRdYZlc3FD74gJBkRu8/EiyCZniWL5yy1aMRYkWBSUIvB5ISWdhT4A/fA6B6RgwaEjHeS66EZUL3M1fOta6TWDl5q+Z9moqo/ICQew5hKnEs57ZwEtp0F2dUOurJT1in+6nXzTKSogIl2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC4TESjg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-788455430easo120568785a.0;
        Thu, 14 Mar 2024 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710448129; x=1711052929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYqvlgz3fwOmk26mzvVlgzBO06xI1HS4SgqCSEg+b5c=;
        b=RC4TESjg+RNd+U9F+L9Ct6JX7nEGooNiGgcfVhghmLLOCRgo2j4OpQEcnNtMoXUu+5
         gZo5WM/2/TFaRZUyR9hrtkqcateGkAT7yaG6GkaCOaeBtt73OonIpQ/iXFSn7YVBhsK1
         aqUp0znJK2g1TTcabqxuY3VK84S8nXYGV5Y487ZyC7pH66PGwp1jnHgUzwXyHJ0gYjbz
         4ENu/n+4mAiJkrpjcBluG3UOkVo0znqadKdVBDGpKLZHF9WjihGnjeF2f+p40eXwVUP3
         yEr3uXltB54W8dI6DiDcAIUDdLZTWjJRGTsPuj9/L0OZ0rMt/V0gx9fjHWSRJlVGsm9u
         22qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710448129; x=1711052929;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CYqvlgz3fwOmk26mzvVlgzBO06xI1HS4SgqCSEg+b5c=;
        b=LhFEHZxbJL/WUAVr/mQcfw7IGElZSeioz+TD8DFYuLqYMAcXyzdLGXXmOrT/uvvINn
         vhqyRZ66Dc/SArewK67IilmjA1BG4iCNgF6Zaz8gaY9NO67ySOJdxqtM8xeIiKMO6Wpp
         AzSRLWC3ijEPErBouGnpBNrtmJZ9Ttjg3e28TD0+lnrlkF8UwRI6TPEX2QS0Wmtujgto
         y89UxCB7s5EjqcCU/bcPjkd/R/cwHHVjSvpvC6nQDQGyn+aVWtHqwqKgiZ1ATkXNsxIs
         If3EOiaPvsCMZhu4Ozla5AUEeMbBp137YmIjHhfu6VYUtMmmvaiuYO+QqVoR7a9fBqgR
         WVZg==
X-Forwarded-Encrypted: i=1; AJvYcCUWnfKPGwlW9vgjIuAhymb2webG3tdSoCDH+2TrD+Qm3ZI1I2E7ensqgDpfn2o6IojfI9BDezF0yLa01vI0I3lYc3kRtthtY1yJ7w6KT5lkMq2ZjPD8hl3BpLGvfqr4/0HnG4tBLMNYym1idDcWQ6f0vLPtECSrzPGO
X-Gm-Message-State: AOJu0Yxa8esFFpgmSQmU215SnHH/gNxcsz4Clqo69DBrZEzbNypGqPYP
	EW1K34zRWvwCsZJ3MQqLv2iGqrFmICAlhnARQfhCmN4T2CkJ9uF2
X-Google-Smtp-Source: AGHT+IGUaNsIDJgU+eM5eb/wJkOEMlfh0za8eNyWdhZM8yhCLEQBESeVxfmkTFMxD2J+HIvCbDcDtg==
X-Received: by 2002:a05:620a:29cb:b0:789:cfca:f59 with SMTP id s11-20020a05620a29cb00b00789cfca0f59mr7081354qkp.14.1710448129467;
        Thu, 14 Mar 2024 13:28:49 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d2-20020a05620a158200b00789cd996cbcsm1201344qkk.134.2024.03.14.13.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:28:48 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:28:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 bpf <bpf@vger.kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>
Message-ID: <65f35e00a83c0_2132294f5@willemb.c.googlers.com.notmuch>
In-Reply-To: <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
 <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
 <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 3/14/24 2:49 AM, Willem de Bruijn wrote:
> >> The two bits could potentially only encode the delivery time that is allowed to
> >> be forwarded without reset. 0 could mean refering back to sk_clockid and don't
> >> forward. The final consumer of the forwarded skb->tstamp is the qdisc which
> >> currently only has mono and tai.
> > 
> > So the followinng meaning of bit pair
> > { skb->mono_delivery_time, skb->user_delivery_time } ?
> >   
> > - { 0, 0 } legacy skb->tstamp: realtime on rx
> > - { 1, 0 } skb->tstamp is mono: existing behavior of mono_delivery_time bit
> > - { 0, 1 } skb->tstamp is tai: analogous to mono case
> > - { 1, 1 } skb->tstamp defined by skb->sk->sk_clockid
> 
> I was thinking only forward mono and tai until it is clearer how other clocks 
> will be useful for forwarding between e/ingress. By resetting all skb->tstamp 
> other than mono and tai, { 0, 0 } at ingress will mean realtime on rx and { 0, 0 
> } at egress will mean go look skb->sk->sk_clockid.
> 
> I do like your scheme such that it is much clearer what is in skb->tstamp 
> without depending on other bits like tc_at_ingress or not.
> 
> "{ 0, 1 } skb->tstamp is tai: analogous to mono case" can probably be dropped 
> for now until bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_TAI) is needed.
> Otherwise, it is mostly a duplicate of "{ 1, 1 } skb->tstamp defined by 
> skb->sk->sk_clockid".
> 
> The bpf_convert_tstamp_{read,write} and the helper bpf_skb_set_tstamp need to be 
> changed to handle the new "user_delivery_time" bit anyway, e.g. 
> bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_MONO) needs to clear the 
> "user_delivery_time" bit.
> 
> I think the "struct inet_frag_queue" also needs a new "user_delivery_time" 
> field. "mono_delivery_time" is already in there.
> 
> It may as well be cleaner to combine mono_delivery_time and user_delivery_time 
> into a 2 bits field like:
> 
> struct sk_buff {
> 	__u8 tstamp_type:2;
> };
> 
> enum {
> 	SKB_TSTAMP_TYPE_RX_REAL = 0, /* A RX (receive) time in real */
> 	SKB_TSTAMP_TYPE_TX_MONO = 1, /* A TX (delivery) time in mono */
> 
> 	/* A TX (delivery) time and its clock is in skb->sk->sk_clockid.
> 	 *
> 	 * BPF_SKB_TSTAMP_DELIVERY_USER should be added
> 	 * such that reading __sk_buff->tstamp_type will match the
> 	 * SKB_TSTAMP_TYPE_TX_USER.
> 	 *
> 	 * The bpf program can learn the clockid by
> 	 * reading skb->sk->sk_clockid.
> 	 *
> 	 * bpf_skb_set_tstamp(BPF_SKB_TSTAMP_DELIVERY_USER)
> 	 * should be disallowed for now until the use case
> 	 * is more clear. Potentially, we could allow it
> 	 * in the future as long as
> 	 * the sock_flag(sk, SOCK_TXTIME) is true at that moment.
> 	 */
> 	SKB_TSTAMP_TYPE_TX_USER = 2,
> 
> 	/* UNUSED_FOR_FUTURE = 3, */
> };
> 
> It will have more code churns in the first patch to rename 
> s/mono_delivery_time/tstamp_type/.
> 
> wdyt?

I asked for such code churn in the original patch. We then decided to
leave the variable name as is, as the churn was significant.

Long term, it is obviously cleaner.

I don't have a strong opinion. If doing this, let's at least make it
two separate patches, one that is a NOOP rename only.



