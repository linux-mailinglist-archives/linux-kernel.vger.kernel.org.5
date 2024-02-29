Return-Path: <linux-kernel+bounces-85869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD06786BC89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92752288550
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6B15C3;
	Thu, 29 Feb 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUKVRfDI"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790D15B1;
	Thu, 29 Feb 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165370; cv=none; b=TrK8ao/QKZEKgiIh8CfZObv87StrPA4eDaKh9lMsSp+sLKHUHaMueQUBhS9aOm90E8zq+b/oZ+WR3qCKPoZVOF46hSmL3ciGMnj/Re3cUNIld+U0JH6qO03pJ+zkpSDs42wk7BU5tNbB8motJUqu12BUlZk+8GRAuNdOHwkc8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165370; c=relaxed/simple;
	bh=seqE3IRTxOa9rGWSrW9njLPFS5pp+9aUSjm3QnHvA98=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oywgd6gQifWQ9YXPYE5BVGvsAbuOkjtjgflnk1ZcMhxcaYhKwDaoJN7gHMNHtWuFwl8jhGwiODS9somkBkh8noZonm86DNZd/NzF0GN35G867i6xOkjIURjWlj3o17daOYqMv5bgtgTjNsnMP9IDevqqd9vOzKuCW4TQw0L3zBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUKVRfDI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-787be5d999aso21531285a.1;
        Wed, 28 Feb 2024 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709165368; x=1709770168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlZbWtFQ25Kp2GG+441sodxbcOQTs6oEvrKzY4Td3ik=;
        b=fUKVRfDIR7dT+djSjW8qS7dEbJykiIAXlkew0aqR7bYEKiIrL3iSMefEqwjFoBOUGO
         GHO98lmULUgOgJpKo/nKoRevIG6ZTNSs5ChiErMw3sFYM/JzFXX4JsSFfEglbw5xmAhT
         FlrDJP9PMX+Nj2SEr1Aql49o/hh0O8mPv3JIrQWxTe5N12FVsdRQANvui12KVKd/kuTe
         DI4sPvQaMXxF1dZ+7zkgraOA8+WuRCmdHzkZfktJbSWvTV5BJ03fBEqSilhIbWT56gB0
         pqvlrKmoTw3oVqcsBGejJEpSEZtLfRwP1IY0IEGFpl2r36i0sdEyoJwCpnPJbTWrEHQI
         Dgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165368; x=1709770168;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XlZbWtFQ25Kp2GG+441sodxbcOQTs6oEvrKzY4Td3ik=;
        b=wM+b0NQZdy9v4dGo0/yz5qPmOdtUlxWzfLkGMO7An5sMXMC4eYAdpwvFzHm2VqZPoT
         LDhWVpAVccA0/gefJIsGhONjnkejEBYRl2NbPFVzz/sHHRVLP4cQZkMAbfzkK8YtYChc
         vaB6Kp6iHNl5s3j6YmJ5/qafpjJcBs0BGIYvx0nCUY7VV15jhTt4uRW3Bj42tfmQD5az
         8B4OzZaaZOMr+n3LiIpY3EaedMvttTNS8GbMtVpPPqeriC/sHdblwr1NpCpmqvLuMkl7
         wjbsQlRbLtiqsAXQPaWBV+tTOgQdSRVkq11jxas9RH9OFLtoTuiLHGjp9NIvZf9O2z31
         iDnA==
X-Forwarded-Encrypted: i=1; AJvYcCX7bHlGBlb/3ahCofHBRY9jVb8cguwR9rmxCr6Ea9AT+vKZqblqRKtXiOjbx1K9H9bo7f9H0Gws6iG1fwkQQvvMln2IhVSyRGEVRwRIx75WylxsfRtIJpjcsr5MmIVaUmIB/izB
X-Gm-Message-State: AOJu0Yz67G1jwg/oMz2TaIfuVNTNZs6GQFHF4Sc8U1H4rEm+lnc3Q1LT
	gtdAHhwecUug9Xp84O3V6EgddXVUF36SazzFm1TUUcAgUL1yj6Aq
X-Google-Smtp-Source: AGHT+IGUV18LYdfVhda+3OBmFkU0yaylZa1GOV0hjAMNuuW43CNfc5R0vBvavoPhrUBncDK6CaoUVw==
X-Received: by 2002:a05:620a:8112:b0:787:b5e7:6c72 with SMTP id os18-20020a05620a811200b00787b5e76c72mr615335qkn.66.1709165368081;
        Wed, 28 Feb 2024 16:09:28 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a091600b00787b8e49d9fsm138710qkv.14.2024.02.28.16.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:09:27 -0800 (PST)
Date: Wed, 28 Feb 2024 19:09:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: kernel@quicinc.com
Message-ID: <65dfcb37844e0_ba1f8294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <8a5d15aa-96e2-4d9c-9479-bf2ba8fb2a79@quicinc.com>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
 <f38efc6d-20af-4cc1-9b8a-5fcb676b2845@quicinc.com>
 <65df94185a2c1_b2ad829442@willemb.c.googlers.com.notmuch>
 <8a5d15aa-96e2-4d9c-9479-bf2ba8fb2a79@quicinc.com>
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan (ABC) wrote:
> 
> 
> On 2/28/2024 12:14 PM, Willem de Bruijn wrote:
> > Abhishek Chauhan (ABC) wrote:
> >>
> >>
> >> On 2/28/2024 7:53 AM, Willem de Bruijn wrote:
> >>> Abhishek Chauhan wrote:
> >>>> Bridge driver today has no support to forward the userspace timestamp
> >>>> packets and ends up resetting the timestamp. ETF qdisc checks the
> >>>> packet coming from userspace and encounters to be 0 thereby dropping
> >>>> time sensitive packets. These changes will allow userspace timestamps
> >>>> packets to be forwarded from the bridge to NIC drivers.
> >>>>
> >>>> Existing functionality of mono_delivery_time is not altered here
> >>>> instead just extended with userspace tstamp support for bridge
> >>>> forwarding path.
> >>>>
> >>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >>>> ---
> >>>> Changes since v1 
> >>>> - Changed the commit subject as i am modifying the mono_delivery_time 
> >>>>   bit with clockid_delivery_time.
> >>>> - Took care of suggestion mentioned by Willem to use the same bit for 
> >>>>   userspace delivery time as there are no conflicts between TCP and 
> >>>>   SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
> >>>>   RAW and DGRAM sockets interprets it.
> >>>
> >>> The variable rename churn makes it hard to spot the functional
> >>> changes. Perhaps it makes sense just keep the variable name as is,
> >>> even though the "mono" is not always technically correct anymore.
> >>>
> >>   
> >>
> >> I think a better approach would be to keep the variable as ease and add
> >> comments and documentation in the header file of skbuff.h like 
> >> how i have done in this patch. The reason why i say this is
> >> a. We can avoid alot of code churn just to solve this basic problem of 
> >> propagating timestamp through forwarding bridge path 
> >> b. Re-use the same variable name and have better documentation 
> >> c. Complexity will be as minimal as possible.
> >>
> >> Let me know what you think. 
> > 
> > Agreed
> > 
> 
> Okay i will make the changes accordingly. 
> >>> Or else to split into two patches. One that renames the field.
> >>> And one that adds the new behavior of setting the bit for SO_TXTIME.
> >>>
> >>
> >> Regarding the sidenote. I dont see how they are using clock_id to determine 
> >> if the skb->tstamp is set in monotonic. Please correct me or point me to 
> >> the piece of code which is doing so.
> > 
> > That's really out of scope of this series anyway
> > 
> 
> Sounds good. Really appreciate your review and discussion on this topic. 
>  
> >>
> >> I hope the check against sock_flag is a better implementation as 
> >> it clearly stats and is inline with the implementation that the tstamp is 
> >> coming from userspace. 
> >> skb->mono_delivery_time = sock_flag(sk, SOCK_TXTIME);
> > 
> > Enabling the socket flag is not sufficient to configure a delivery
> > time on a packet. A transmit time must be communicated per packet
> > with cork->transmit_time. And on top of that, it is cheaper to test.
> 
> 
> So to re-use the same bit of mono_delivery_time. I want to set this bit 
> when user-space sets the timestamps using SCM_TXTIME. 
> Is it okay if i do the below when we make skb in ipv4/ipv6 and raw packets
> to ensure that bridge doesn't reset the packet tstamp or do you have a better 
> suggestion to set the bit so br_forward_finish does not reset the timestamp. 
> 
> skb->mono_delivery_time = sock_flag(sk, SOCK_TXTIME);

I already gave my suggestion.

The timestamp is passed using sockcm_cookie field transmit_time, which
is set from a control message of type SCM_TXTIME passed to sendmsg.

Right above where you wanted to add this check is where skb->tstamp is
initialized from cork->transmit_time, which got it from this field. So
clearly that is the indication that a transmit time is set. And the
field is hot in the cache.

