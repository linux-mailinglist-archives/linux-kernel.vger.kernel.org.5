Return-Path: <linux-kernel+bounces-16957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD0824682
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B651F25807
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1461A286AD;
	Thu,  4 Jan 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XGR0rUuH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2124B56
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so599315f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1704386534; x=1704991334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpXENXwhmXYod+f5UTB49xNrxA0qxmUQQJ2I+RzT7Zo=;
        b=XGR0rUuHFCASrSGF8qSNVwc6X37goqnxtHX5Vs1bBlipfe8LAQHC8ia+kjDhRUBgN2
         iNUIxnVq+niwmGRV58fhxu/YRSXTsNfG33CXNBoBnJGTlUVd77xEyhtW4EqCnULyjamC
         2EbxSJpSO06je6C5OeNVylkhWAreQ6gLwjwp3CPbxEdEdLvESnHfFMKduedHYLPDpATe
         RZ6ntWmwfq+dr/My8m1VOZ/N5Gfy94Xg31fOya6bGMa+w9XnIulmebdJZc0txOUTdt7h
         S6rSdz/tIl89PM3yE5hJpD8cywQA1/7o0T4B49ovIcloYN25qAu8p6Wz0dX5C8j4BC/5
         3TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386534; x=1704991334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpXENXwhmXYod+f5UTB49xNrxA0qxmUQQJ2I+RzT7Zo=;
        b=uWa1T5/ZqrgYyMw8S4dm5Pvxo/dRw78CGnKUKy4Qw7WMg5O64eUQlFjiyMkirX0dIW
         CPaQfpbgdD3j1rB+IVXyALG5/Y/KC7mFB4ULaDOVBp29cwXGwrBolc4oNjXO2C2/v1Tl
         B+4xHHXSKkqEfo+xT2TjAE8Yp1qQHLpNdHVCWy2N8/l/NI/Y4dDKyhKyeUVf2k03FIf/
         UWTJMLrdC062OVrqLKvibtSbcUwSt7xHcsJyx6oDJvxF5RNxADr1QwymU4msv4L+0Uv2
         JaRRzRwQ6rwPbPWW4IorLPVsk1uTO/NRyALKiszYUJmEQIpOTLjygtgHQH23bG+iU0jA
         eOtA==
X-Gm-Message-State: AOJu0YwjvN7C53iyUXMKor/PF41QiorOnRGKmqc96lKIp56T2tpLampO
	WsAjKvdq4R38IPoM41pXDTQkNrnK6POl
X-Google-Smtp-Source: AGHT+IHP8yGPFDYtpi4C1LZERI45Ly0u07BpJhTMkZQnGAVERrx3lCAIpVaRtN3O+qq9Iysqw40XTg==
X-Received: by 2002:adf:ea8f:0:b0:336:c963:25ee with SMTP id s15-20020adfea8f000000b00336c96325eemr305083wrm.166.1704386533844;
        Thu, 04 Jan 2024 08:42:13 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id cg13-20020a5d5ccd000000b00336e6014263sm21815296wrb.98.2024.01.04.08.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:42:13 -0800 (PST)
Message-ID: <335a2669-6902-4f57-bf48-5650cbf55406@arista.com>
Date: Thu, 4 Jan 2024 16:42:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Christian Kujau <lists@nerdbynature.de>,
 Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
References: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
 <20240104075742.71e4399f@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240104075742.71e4399f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 1/4/24 15:57, Jakub Kicinski wrote:
> On Thu,  4 Jan 2024 13:42:39 +0000 Dmitry Safonov wrote:
>> User won't care about inproper hash options in the TCP header if they
>> don't use neither TCP-AO nor TCP-MD5. Yet, those logs can add up in
>> syslog, while not being a real concern to the host admin:
>>> kernel: TCP: TCP segment has incorrect auth options set for XX.20.239.12.54681->XX.XX.90.103.80 [S]  
>>
>> Keep silent and avoid logging when there aren't any keys in the system.
>>
>> Side-note: I also defined static_branch_tcp_*() helpers to avoid more
>> ifdeffery, going to remove more ifdeffery further with their help.
> 
> Wouldn't we be better off converting the prints to trace points. 
> The chances for hitting them due to malicious packets feels much
> higher than dealing with a buggy implementation in the wild.

Do you mean a proper stuff like in net/core/net-traces.c or just
lowering the loglevel to net_dbg_ratelimited() [like Christian
originally proposed], which in turns becomes runtime enabled/disabled?

Both seem fine to me, albeit I was a bit reluctant to change it without
a good reason as even pre- 2717b5adea9e TCP-MD5 messages were logged and
some userspace may expect them. I guess we can try and see if anyone
notices/complains over changes to these messages changes or not.

Thanks,
             Dmitry


