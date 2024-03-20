Return-Path: <linux-kernel+bounces-108976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE88812BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A542C286C06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82B44371;
	Wed, 20 Mar 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="154gHE8q"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1229CFD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942902; cv=none; b=scp8JVGC9JAwq0qDPbq8MCRWXWuTX8ZF2QIagNiyznNH/8d+X5oXHMLHEf6boYi4rXOBPwickkZZJnzp0uFfO0m/E9WhPPwO43Lx5cSYMtBxIUTIbMCTilpFFyka5yTiYlM3qgl/JTpYldgN1NhCPcCUmmt4VJJomHqjR4nSy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942902; c=relaxed/simple;
	bh=r4Ox4Fkb6OTqvzf3uywc2+X20ucxQSfPB6rzlahv6SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1DOxi/UwMgxeK/HrtV68EEV6LRVl5fTOtN8R4hHYU6UUxtadYfxY71SRlG26/RQvQRbwcFPkMIe4DmZ0ws/iIRK50ytENcIoiYaATNwRj4UUvYMQYe3UncBZeV70u1Ff/YRBz+1V24zBJm5h8SuOuGUtP67uSn4i9VgYccx3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=154gHE8q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41464711dc8so15541205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710942899; x=1711547699; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=etnN6SZNp2ppKiE78svR6WauCS8nWrn17DdW65QvDEA=;
        b=154gHE8qy7yOZCJJ1Xt/LeHIcIGT/hYh7JqT7waAlJKMVXBMbUbFpS7WJEUCUjy8jP
         xjNnQ7fizKDe/MvKfylyQ/dRZHF3d+k7jWRzxpSrTbmrjMnWmvo41vC+e93HLfLTqUNS
         fOGCoFpYCeFN63zrAwiBE/EsMNyrGO6XkkldNtyvzXXUoAlqdDVkUk1XqUskCfNAVNqv
         /jGIstUEvqSCgAlAuy8nPngV63TPslRtYTthqIaxlaIzW+26xBw+yp+RzOWAkwVTtqiz
         HLMEjGVzayyO9EYZ5nMc5myUTJoobuL1wNPoHcjN8NBp/T0Dm9/uRgMr5mPc/6037yHA
         K+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710942899; x=1711547699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etnN6SZNp2ppKiE78svR6WauCS8nWrn17DdW65QvDEA=;
        b=jLgclFXcBEb+dnirdN8rxYY09zzTJQKnPhp07VgSX1syof6Imc9p3y9eDHsX7QfUZl
         OiSBd8DuRiUr4E70pNRccpn795WadlAze2GC8isGKCWsicRo1adlCRJPHhh4hlrYULgI
         B4M3SiLJlWoQFuqQA1w5JOrCgPQb/envSaEza53tWmpE90QQPx1EqrPL4n1+pw263BfJ
         Horb6DS8/CBe5KXU9ELorj+z1dyqhzTfIE16u3cUu403QfmCwt3Pxhln2kx5o7FtaULW
         wo3FXgVthT1K2ltNje9b1Nyy1oodC6wb8y6l9nRctZu1EbUFYMul6BA0Rtqn7Zl5xHVK
         cqRw==
X-Forwarded-Encrypted: i=1; AJvYcCV/z9ytMumbOPQHgcp7H8FU43H1rbHi2CCHpOMWAxzzCrD46rVDZjDRuoZt1gUYBdrX3yoKE1Q/7oJXpYq/IcqOopQaV9fT75GBbRnP
X-Gm-Message-State: AOJu0YwLNSY8AN1grg97VB8gupgYjNmRdNgQYQGkIIea4JFkhirZdvZ/
	j+69jPAxnFKpRMU4laCYJkIT7yuuZCztnkCHIykbu0DXrA+ft1PEholaf33qogM=
X-Google-Smtp-Source: AGHT+IEpHJYPqFkm54qsQPALph+urmE6SbsV52Q/66EPFqFlXg1+XSmnIdO3q28cfq7EEso8Wo5/gQ==
X-Received: by 2002:a05:600c:3106:b0:414:846:4469 with SMTP id g6-20020a05600c310600b0041408464469mr1779197wmo.38.1710942899121;
        Wed, 20 Mar 2024 06:54:59 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b004146e58cc32sm1397539wmq.12.2024.03.20.06.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:54:58 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:54:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Message-ID: <ZfrqsQJtIliZDjQc@nanopsycho>
References: <20240320125635.1444-1-abelova@astralinux.ru>
 <Zfrmv4u0tVcYGS5n@nanopsycho>
 <CANn89iLz4ZesK23DQJmMdn5EA2akh_z+8ZLU-oEuRKy3JDEbAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLz4ZesK23DQJmMdn5EA2akh_z+8ZLU-oEuRKy3JDEbAw@mail.gmail.com>

Wed, Mar 20, 2024 at 02:43:22PM CET, edumazet@google.com wrote:
>On Wed, Mar 20, 2024 at 2:38 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>> >skb is an optional parameter, so it may be NULL.
>> >Add check defore dereference in eth_hdr.
>> >
>> >Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Either drop this line which provides no value, or attach a link to the
>> actual report.
>>
>>
>> >
>> >Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
>>
>> This looks incorrect. I believe that this is the offending commit:
>> commit 690e36e726d00d2528bc569809048adf61550d80
>> Author: David S. Miller <davem@davemloft.net>
>> Date:   Sat Aug 23 12:13:41 2014 -0700
>>
>>     net: Allow raw buffers to be passed into the flow dissector.
>>
>>
>>
>> >Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> >---
>> > net/core/flow_dissector.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> >index 272f09251343..05db3a8aa771 100644
>> >--- a/net/core/flow_dissector.c
>> >+++ b/net/core/flow_dissector.c
>> >@@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
>> >               rcu_read_unlock();
>> >       }
>> >
>> >-      if (dissector_uses_key(flow_dissector,
>> >+      if (skb && dissector_uses_key(flow_dissector,
>> >                              FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>> >               struct ethhdr *eth = eth_hdr(skb);
>> >               struct flow_dissector_key_eth_addrs *key_eth_addrs;
>>
>> Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
>> FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?
>>
>
>It would be nice knowing in which context we could have a NULL skb and
>FLOW_DISSECTOR_KEY_ETH_ADDRS
>at the same time.
>
>It seems this fix is based on some kind of static analysis, but no real bug.

Yeah, I agree. That's the main reason I asked for the link to the report.

