Return-Path: <linux-kernel+bounces-151648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B98AB18A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3D81C21D42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274D12F5B2;
	Fri, 19 Apr 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEBEk0/N"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6B7C08E;
	Fri, 19 Apr 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539860; cv=none; b=sWyzZHOapMQMdOIpsgG9bxutCfE/U2qHV5spE8FO1pRi8Xbf3BNkuLT2wswqNwv4D2Aobo6e5PTA7zs4AXq7lGm+RZnkDNzuD8YirYABLaYNa51mhmNlibFkBcG2KfxFc1CIthoT8jvQdGai9y4moxG33S+NtGJCp7AJoDTiDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539860; c=relaxed/simple;
	bh=8eAxUlOkvwg3GRQ9COq8rJRS1cyeYy6Yb3xG9Tf+NCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ht+AvpjxfwCWfB3wnc6PhgT9L6qYTKqwu+J6RI88EKsKNSHnWQvD9zxnO5ISZYloOaIsygoVUceiisPL7cOpzt3yL+P4rypifQR4dY2RSvnEdzumUFZCVFtrbPc+Rx0nMcZIFPFpABbQUwQHJjYWBQHT2zXxEgFtRuuC+rAOhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEBEk0/N; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-347e635b1fcso1556804f8f.1;
        Fri, 19 Apr 2024 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713539857; x=1714144657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqULfoOhZuuxztxgLWRuwa7kKzhFZefstobmFvvrEPE=;
        b=bEBEk0/NvDQ8/wg2eRf5rLeTC4BlzZYgSWgjbOWEwBg2nyjAH3tp2WeQuaaRMcqXg/
         QK4TxXmWzUlrGHVV/dft6QQCOXAy2fI+77eDXqkus58VfC4ZUHGTulmS3WeNSO5zQ5oF
         iQDE1Qawf+4aPv6UegMI3nvtnYMQP3f1Uj0ZM+uDQyPJbZ+PgyFT2xRIQ+tJhDfYe/IG
         aNZ2aKE0qfse7k95kfuhJbg0qt3PwGx+VTf8IP/z97nKqNqne3pXGCyyAV3BqiMQBHGy
         Rw7cLW7mCg8ZZVX4/PJgTuTwrEushi0N+MWVrLKAPcGfWUAMEYCKepUBNrAOi0oqA5kz
         BMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539857; x=1714144657;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OqULfoOhZuuxztxgLWRuwa7kKzhFZefstobmFvvrEPE=;
        b=MTlI5t6bef9oF0fdUGgM6vdRRrsKezv783Xc4XYmloqI+LUsowpJRAWg+EqpXoWl8p
         lCTPUVW6o+lQMTNVQXuY03RBAuSuNKWG5YnyMoYcxo7KTJDvfHSeUa/qmiRYqHUxGex5
         OTxjMMaV9+ZSrIaw/nhBstgQbE+4GqRFOOn1k7QFmM2bJ5mJxfM+7pyhjdgthVJJ8BP0
         YO0/+KC3ZB9wAOuVjCq6y5uiiMeh5y8fQO30xLOA+BVIhIVy4G98Bg8GyPacz9+WF7ce
         w3Bcxbp0IyTz/U2Ig+5lTZm8E74mAb21cSYtiZVjvANhEglTiniRWQ5PnBRt0y8Wzc4l
         LRDA==
X-Forwarded-Encrypted: i=1; AJvYcCWGffSgr/V5dY//2TCj9nFa7pkYPDVhXui+8zAY0NfsNhNRLvdEkPMFIaevu69QMsuA3X7XsEg3W4cRA6nA3f5fVMh1JrQ96nyzDo8rNHa13+JAUtuaq+E+GAOZmhCsaSovR0Sb
X-Gm-Message-State: AOJu0YyXQySdyu6GEgjCfVu84spYRxT8/TVTIWsSuuWgnzbJJsrTnjgl
	2vXmvLfPVmSZ2T6n7zT+OjwIdBa6eJFdK2rriR5X8jPl1AOlP2A4
X-Google-Smtp-Source: AGHT+IEh9+eY8tlpiyAnEgrOzi2LDGYsOVitaOFOiHxfv79r+ymJuwDlKEAylmhS4Gg6WfcBC3BWNA==
X-Received: by 2002:a5d:5310:0:b0:346:41a8:2b4e with SMTP id e16-20020a5d5310000000b0034641a82b4emr1899731wrv.49.1713539856630;
        Fri, 19 Apr 2024 08:17:36 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bd27-20020a05600c1f1b00b00419d47edc51sm197367wmb.47.2024.04.19.08.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:17:36 -0700 (PDT)
Message-ID: <d59a08c3-eaec-4d19-83bf-b085b4c56b04@gmail.com>
Date: Fri, 19 Apr 2024 17:17:21 +0200
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
 <6736050b-1410-453e-8afa-55e4c8f34033@gmail.com>
 <6621692cbedd1_f648a29469@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6621692cbedd1_f648a29469@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Willem de Bruijn wrote:> Since this INDIRECT_CALL_INET needs to know about the definitions of
>>> udp4_lib_lookup_skb and udp6_lib_lookup_skb anyway, we can just get
>>> rid of the whole udp_lookup_t type and function pointer passing?
>>>
>>> Or move the entire lookup to udp4_gro_complete/udp6_gro_complete and
>>> pass the sk to udp_gro_complete.
>>
>> This sounds like a really good idea, I like it. Although I think it may be
>> more relevant to net-next instead of this bug fix. I can post a
>> complementing patch to net-next later if that's OK with you
> 
> That's fine.
> 
> This patch as is is already very intrusive for a net patch. For a fix,
> could we do something smaller? Like add the network offset into
> NAPI_GRO_CB in inet_gro_callback and use that in udp4_lib_lookup_skb? 
> (and same for IPv6 of course).
> 

Yes, I think that's a good idea. I also think a smaller patch for net will
turn out to be more reliable.

I'll take the first commit in the net-next patch series and use it to fix
the UDP bug discussed here. I tested that version thoroughly for all
protocols supported in GRO, and it doesn't add any overhead for the TCP
common case.

