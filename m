Return-Path: <linux-kernel+bounces-150371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC88A9E10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F55B22D75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CC16C685;
	Thu, 18 Apr 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWoYw6EB"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458016C444;
	Thu, 18 Apr 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453181; cv=none; b=uLTvimzH+JyBClUQ3rs7cb2/+RIlWYg+nyOzqcCTTIBOZwGCw5OYNLQD5RzPm51w8J3JYsryToYAtR6nwid8gTjr0y420BilMqW4G5cN6SZHw1USZs50Hu1IW4IQsirh0LWc4LHnuHreh8QaCZcjSvZro5qXIjjZFEF8AwjlHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453181; c=relaxed/simple;
	bh=S0j6r/kzcruhemR329aT+kBaDtVcwpoh0HHfyLsCHLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H8I1ovgSeqGc7iYRQfFG71n3b8W43Ffn31f3tYmcpD4G7pLCZIYr/tlYuM7zpKr+dca4hl4hWj76S/plvCDTA8/1jm/J3kNlrQegYn2L74j1TkEpIqFNUJgNHH9Si8t0x2LeVnAsJYgMIlK2SdNkLnbY3e67mjNZqc8Kw+eka+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWoYw6EB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41551500a7eso6918755e9.2;
        Thu, 18 Apr 2024 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713453178; x=1714057978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQVPvQGda+w06QQHpjA7eEaHw2QE6VxA3M3eBLIeGSg=;
        b=ZWoYw6EB7LW3oSL/9SG/EccZ62jg7soM8C+ulfs3L40CN89KUoIJGLbRWgzjJu1ljh
         V6TUCdy8p1uAnB+1FepDABCjGV+YdPrxUAYxBjP6GtpGafMH9pOqkbgMl7eaUY2xN2KS
         RG6uXnCdshZ7LBIoIasVpEee82Y9mz3Xz6jZ7cM6vg9i82Ww5/Y//5MRCcaUeWQS2ECG
         mPe8rPRBtvEar/o9Npb9y9/3nRGWdHu5g5PIHGyFJE+OkjCEr9PGZ5pDRUcKZwdOKqE5
         TDGZcRKcAPLhbGkqyDhRt1+luIKC2YYQ6RxAoAg9Q/zowKzZ1indiWyDHExVGSSoBNWA
         Rjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713453178; x=1714057978;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EQVPvQGda+w06QQHpjA7eEaHw2QE6VxA3M3eBLIeGSg=;
        b=tzMQ7fKK1ofb/3inc7H0/fBTpqpmT8SrWnyEm1dJ+PNrHA+mDLhF3MSbHrKgOylnig
         xrOtJ08omM0a6pmEoO/+LH7SK+9CCUaGoHCcY77lCYigUXvMwPZveG+d6HVL5imSjWjv
         mnAHGJz/QRHnOz1qd+8SE41t7dysDnLH46PO7GIWbNTUjYSSuUraOWOx/4/yYM2OKV0L
         rH9likjpCF/iWfgCtM8MztW2aaJHPdkvFxSKTTqxLN24bTjNJoal9kSAUpR9mmnhi7eA
         lk9ChZ8akpQtPOsrpCKgiZ2fpUhkkiHcJ/fVP/5RK8fLsvsfHa7bvl3amXK/s5tvXdqO
         fBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIOlyG22Gg4LIWV4Wh3UOReV6z5euKuav5rRwkPw1oCOtA0HH2piyUnU6xL8s1L6DtLQXwxfLD0YsXrMzuUj2DOZ02c+w+jUiR72nkFCt3pD642XDgZ7wWwiySgTZxuhbGceGH
X-Gm-Message-State: AOJu0Yygi0kcm5geH1PzE/FQF69Ta81TO7BsjPVRpZokE7JjfK/chkpO
	rcccsqLN8B78AUb1diqKSDRPIKEUphZBrL2GLw1FkJQ2dRLZPzHC
X-Google-Smtp-Source: AGHT+IGV6hnD+ktekzMTUV0X6jSrXRxddrCwn3Qf9CbT2CguIp4I0jJ1HMRtknqoUy50uXW6bT2RWQ==
X-Received: by 2002:a05:600c:3ac7:b0:418:f195:838b with SMTP id d7-20020a05600c3ac700b00418f195838bmr1010843wms.4.1713453178060;
        Thu, 18 Apr 2024 08:12:58 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b004148d7b889asm6921930wmq.8.2024.04.18.08.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:12:57 -0700 (PDT)
Message-ID: <6736050b-1410-453e-8afa-55e4c8f34033@gmail.com>
Date: Thu, 18 Apr 2024 17:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1 2/2] net: gro: add p_off param in *_gro_complete
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-3-richardbgobert@gmail.com>
 <661ad2e8a7e95_3be9a7294a5@willemb.c.googlers.com.notmuch>
 <97a01bf9-99d2-4368-9ebd-1e1194c1d7fd@gmail.com>
 <662025813539e_c86472944@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <662025813539e_c86472944@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:> Since this INDIRECT_CALL_INET needs to know about the definitions of
> udp4_lib_lookup_skb and udp6_lib_lookup_skb anyway, we can just get
> rid of the whole udp_lookup_t type and function pointer passing?
> 
> Or move the entire lookup to udp4_gro_complete/udp6_gro_complete and
> pass the sk to udp_gro_complete.

This sounds like a really good idea, I like it. Although I think it may be
more relevant to net-next instead of this bug fix. I can post a
complementing patch to net-next later if that's OK with you.


