Return-Path: <linux-kernel+bounces-86859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F5C86CBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74961F2499D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F62E137751;
	Thu, 29 Feb 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k58fXegZ"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9E47F79;
	Thu, 29 Feb 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217881; cv=none; b=Md/CDt06zBDOCjtPBKlhCwhzg3mnnef3EjWxBjKud5Sxg5zXxuOdAhzx/VcnHnd/NqxF1mKZZnc2/SAsNJq6RrggdLpnbSmxndshn+/aERzpdkFO0qCIUe4IVxl7ky9FO7jh2/0OqlRSZndWsej4HBTXtgLizH1xeu9Yn0Kn+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217881; c=relaxed/simple;
	bh=dXtDhlsf7pQPfK6ufrBS9a6McdcVUQKs8DBa7MJUAEg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XFqTqkqz6XO2WaN2FbX33RpWTOrMBsg4CF+KsZEQX0s5YELxhhybhVbbwjwICrPaBQUJaJ3+isvHqVbD2ujgfncSVSMnvQPGjrWtGJzOgKAEoYV9zgmbi3tokgHZxmDHvFzTjpnpbaabm4xc3wzQzmMk8IpjYLwxnKPbqv3N9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k58fXegZ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a0cf64bafbso499805eaf.2;
        Thu, 29 Feb 2024 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709217879; x=1709822679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0CAiLHud0nDRyjF930+lZrMaqZL4tMe8/fznj4yCQ0=;
        b=k58fXegZuLiJOL6/KWumrQ1LskwiIh5AN93A1BKpTPHEEREXHVv0Kocf5P1ZS5GntQ
         dfKWDe5JfSHJ5ghWwa7l8CXiwjuXsX9exOxRPVR+WNPUfuOfgRslKVjwQ+8j+1Vyk3vd
         QVsGYfl8bBG1RUqJ3mrSPjsC8wFoZizZjtbMidI4HqyALKeYS93ZQD64+3H8uZKl43ll
         6e9Q+lA3uBJ/ZSGdYYFxh9ol5+hh1s87FQxTVmi4CjI8hOkVmoixDxzo6+2c32qSx+Rn
         1leVUE9sBa4BqlPLYGhPDflZ2uxatNQYKQo3ZlasD4MKraNqJPKNUb/LEaYQT0mLQhoA
         9sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217879; x=1709822679;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l0CAiLHud0nDRyjF930+lZrMaqZL4tMe8/fznj4yCQ0=;
        b=Yy2e8K6gF7Xbe6yCt9eX/K9DPEDQbYyNQ5KlRn3uQwHqsBuP/TU4/1NEfFWk/hnUAp
         Mmd1UuZ/H8+xDFGd+TpK5BBpm2cRF9hglYTg7EIZ3FBRzDQPWc0UqGfI7+gd1s61Xky/
         UK09QIkxU4MRZECJJdVX408HPF1v2jDCrpJ2zbbk7BiQouoPIE057FAYL9UPfCkVgtYE
         CQq0/ziY7ZtO8m0gV/pD8LPdFPnPODgDZnqrgB7Y4UUIsmUEHb/bTnF8XnSLzVod/uor
         WJjlAWM24a8DhZOQK80yhn56FEd6XzemM0WNRNJ3FeuK2O4M7e5iDU9lapQY269bmK/J
         bjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3CtFxNXiZuX4PvgVZZnNESN2emm556hSOtdhygVHzToNJsdEWEcb4ycxAUThD+1ge+wwEwoulDEzcq2bayn9ZLY4HaKQ/tJ9n6ek/aTqwhpnjyS1e0gi6IikK1U8raAhuEnm4
X-Gm-Message-State: AOJu0YzWryHsAuIM/qdEdVreoxCwObYHCxoImx0QmCinsNqRCS17uBJK
	mVcW/nU+orgyHdmSgCSNCYuLv2+1NVfhnVRNFR3uG8QIj+lgkS+L
X-Google-Smtp-Source: AGHT+IHuo8YHYpTYpW/u80P7K6hdSbg1sDALDZSK3H+Kyv6nIOziJEuCvxOy1LL3bqFCIPdUvm2CaQ==
X-Received: by 2002:a05:6358:578f:b0:176:b2af:9bf2 with SMTP id m15-20020a056358578f00b00176b2af9bf2mr3347798rwf.15.1709217879154;
        Thu, 29 Feb 2024 06:44:39 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id op8-20020a056214458800b0068fc5887c9fsm796522qvb.97.2024.02.29.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:44:38 -0800 (PST)
Date: Thu, 29 Feb 2024 09:44:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <65e098566b4c3_d40e329486@willemb.c.googlers.com.notmuch>
In-Reply-To: <cfd6d590-2bf0-45df-97a4-f9359b5d454b@linux.dev>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
 <cfd6d590-2bf0-45df-97a4-f9359b5d454b@linux.dev>
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

Martin KaFai Lau wrote:
> On 2/28/24 7:53 AM, Willem de Bruijn wrote:
> > Sidenote: with sk_clockid, FQ could detect when skb->tstamp is not
> > set in monotonic (i.e., set by SO_TXTIME) and drop the packet or
> > ignore the embedded timestamp, warn, etc.
> 
> Thanks for cc-ing me. Sorry for the late reply. I just catch up to this thread 
> and the v1.
> 
> I think it is needed to detect if skb->tstamp is monotonic or not in fq. The 
> container (with the veth setup) may use sch_etf while the host usually uses fq 
> at the physical NIC and expects monotonic skb->tstamp.
> 
> During forward (e.g. by bpf_redirect / ip[6]_forward from a veth to a physical 
> NIC), skb_clear_tstamp() only forwards the monotonic skb->tstamp now. While 
> sch_etf does check sk_clockid first before using skb->tstamp, fq does not check 
> that now.
> or fq_packet_beyond_horizon() is enough to catch this clock discrepancy?

Before your patch, I believe FQ had no such guard rails. An skb with
any clockid from SO_TXTIME can arrive at FQ.

With the new clockid field, we could add guard rails in fq_enqueue.
If the bit is set, look up sk_clockid.




