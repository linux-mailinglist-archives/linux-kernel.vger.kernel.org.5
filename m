Return-Path: <linux-kernel+bounces-103079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03C187BAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB9228183D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9626D1B9;
	Thu, 14 Mar 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuoLLIWm"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E86BFCE;
	Thu, 14 Mar 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410057; cv=none; b=bvAAL9umdwzzgXFqcRx+a8JllNNKZhlThvvF3kaMmqTVsbscKCpn1GyBTZ21tlRPOsw42JDVK8fYnto1gv69969M+dcqx7W3safIGPkNrEg3vrpUG9wY3yZcCVC+58z4CdRXksJpTUv6bx1V2NKPfb0ekaQDNIB2CCT+S1Xgzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410057; c=relaxed/simple;
	bh=0Vfu7V7esPuIfKIcjN/ayWWfoqSx6MoTLkxLiDskW/M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=poNQHPBgcNfUxfBwCQNDWxWiZgbYAU3Q6iFsnopUXuuEu6zD6SNhICbUdrRVA9nY99Mle+y1l+N+B6fHqLIinktILfNmGlYOIkDTMRz4pHKFlNKMOL6DT0rIQo/cW2aK2AQXboQYfKsr7xpbc8DxP+LvYhjWljg3q+PAg30IcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuoLLIWm; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690cf6ecd3cso4386176d6.2;
        Thu, 14 Mar 2024 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710410054; x=1711014854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azAjOn0WkUuV+JbW4PMCkN4k69ejHae9GMrw/nk5KgY=;
        b=GuoLLIWmTl+7oGlEDKwLauyspLcKoOqLcPxqn2+yc0VL04GuVMf6vShgRnnzTxeYQY
         8SZLizbbQ/rUmZWmXYpHo5Jq37VRrMlKQUhiIYATVFfYu80y7QpD/oSPBhNJjSnsBw3v
         0o7AiVBxyCjM4/ZAZgctwJCTtdGMF6yymQ8EYka3mYYnggVE2Cy89vBtW46lCW4xAWE0
         aAz/bHszSxqcQGrIcSZVFSX4D2sPhQ9/t4z6XMc/df9Vb4UBbRsLyavrXZ3GhJ8F+qTj
         M2g7EwGp77HjvdM1JApvr6/FvD+OGiY4E5Y4DelzsG/Uv6cZLsaf9mNeTMpL/lesshBh
         lEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410055; x=1711014855;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=azAjOn0WkUuV+JbW4PMCkN4k69ejHae9GMrw/nk5KgY=;
        b=j8gcDWHpL6xKx8qqc9uQKCXZXerWjmwRI5tqBzW05gb9jbaWVulSe21RTFWJevjyeV
         G+wuLkvvN0C+8dmJIAPxhMiPYgPRhRWHnT3EHuPbYXSPWX5xGyvkJMsoQjWPo51rQDlh
         q5vhv+vPI0RRN6G89GVeukQn93Omwp8G1rBsgaO4ZpvJQLI8/EpC4Kr08d7OKI/TC8GK
         RGs93TMFEZ/nSQ/jOLvI6fUfr275+PHVRxqN8tYJL7IVlLemNLqrZ6iUNDi6mqna5zkd
         sAaWl5GEZHau4HpN0Tm+aoYRVN0PouDfmnnIETrpoRW/mQ1QYpOfAAOb5zWfPs4RaQa2
         AkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVUNY8yrqiCVVoO+cyzlwgRmZ1G5DkSSB7o2j8hTsMqVvx/YeuP//6T3rPkAoAipF1W2DWi3kjucZDnhoCNCY+7KH3aarwd1W5NQzOrvbK09meKsMGfSjp/Z/MjNZ9DLzTgyUX
X-Gm-Message-State: AOJu0YxFHA2XdscdsSm7svaaqeUxtTcvqxHMu8iCr7U1uZ9a5mDan/sp
	r/+QBCDMuuEjrwe0hdDWY7l7p+N61UvaZgljPrR8SghXiCT0Yyh0
X-Google-Smtp-Source: AGHT+IGfXjwWiRR/jJJm2uItc8omOA84Bnb+ff/g6BRHuwj1Q6BJaEs7HJtIvfXNHycmHGIAOUyEUw==
X-Received: by 2002:a05:6214:11aa:b0:690:bb9c:f0d6 with SMTP id u10-20020a05621411aa00b00690bb9cf0d6mr211288qvv.18.1710410054631;
        Thu, 14 Mar 2024 02:54:14 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id 8-20020ad45b88000000b006910b474f4asm207068qvp.71.2024.03.14.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:54:14 -0700 (PDT)
Date: Thu, 14 Mar 2024 05:54:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel@quicinc.com
Message-ID: <65f2c9468188_3ee617294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240314010813.1418521-1-quic_abchauha@quicinc.com>
References: <20240314010813.1418521-1-quic_abchauha@quicinc.com>
Subject: Re: [PATCH net-next v2] Revert "net: Re-use and set
 mono_delivery_time bit for userspace tstamp packets"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> This reverts commit 30bb896b98fce7d823a96fc02cd69be30384a5cc.

Upstream SHA1 is 885c36e59f46375c138de18ff1692f18eff67b7f ?

> The patch currently broke the bpf selftest test_tc_dtime because
> uapi field __sk_buff->tstamp_type depends on skb->mono_delivery_time which
> does not necessarily mean mono with the original fix as the bit was re-used
> for userspace timestamp as well to avoid tstamp reset in the forwarding 
> path. To solve this we need to keep mono_delivery_time as ease and 

minor typo: as ease -> as is

> introduce another bit called user_delivery_time and fall back to the 
> initial proposal of setting the user_delivery_time bit based on 
> sk_clockid set from userspace.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
once the SHA1 is verified/fixed.

