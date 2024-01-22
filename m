Return-Path: <linux-kernel+bounces-33609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C55836C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE63E1F267C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB99481B2;
	Mon, 22 Jan 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1l6Ffkh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6347F7B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937768; cv=none; b=nbIOURJDojlu0BiUSd07EHrg1iwW6N9J4+RSU2HOdxB5unl9FvJFeZmvZ4dHu5AS8IpjeWb2OUHlP4JQth8f8Qa44O6baGnSyyNLMm2BMXwSnC3uGUmg9x8o18Kx3Jsc/GsjFmZbBUg/WcN8Cxs78G3OpB9OPvUJGTF38n+P5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937768; c=relaxed/simple;
	bh=HAgIWyhtdhJVsNQO4GdYk2+zw/yMtp7ITnbhJzTY1Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEMVHfDpMCg9Uj/5el/6ZkfkY0YxUEB7sJSXpupZG/roZul+W+9wdY2DZA6T3uGj5dldDtnyasRPuNrshZ5DL+L44B2CqYBJU8n8cHsIdU1tG/KuTVv4/UGSJS5u5yTgnxiKHHYoZpCOjXMbO58gRoISEFTedNQyv0lHt+feISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1l6Ffkh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2dc7827a97so354395166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705937765; x=1706542565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCDPVOv0172L4ZkN8LFuem5/OBYW+jKR6BeqqGh8r/g=;
        b=w1l6FfkhL70orty6/pqaSJnJK8p2knMuciZD6y6kce5uxMJqdkCJnRTjKXOPHCSFk0
         b50y/ZoHzaP0/2Rua6KLS7TcOkTrQpQZlkJnpycYna8cspHl4PBHBOQvBmMjDtRQPsf9
         RQhW9aBJ4qYaVzNEoL0kBhiECF1b2R5cQ906e/6uNMCZmYQ0sp5PcIJLj8XHOi3beU+Q
         dCbeD5PMrMyEmNTg4VJMFtpt5uYHWagLf7cS8s3tPtxpSprFfrY8B1xxPHcsI1O7LsjS
         WIzObo9DfehEkcTbOB4hHdPWQqkVVP2chQ7PRN9SFO50TtDvTKJGw9m74R65MgTtdu9O
         qhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937765; x=1706542565;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCDPVOv0172L4ZkN8LFuem5/OBYW+jKR6BeqqGh8r/g=;
        b=JtFZ1iwr/byVUzjzI2tq7KfxAydnAEOMNaE8zn8wupPuZsx2g1jsFP6jvagwM5Fu+Z
         lhcVWrejAsYz7zSNRa0t8Ob2ZoXvDWRia68/uKVZ99otS5Zp0bgvoGJD8Ywk997M7Zrr
         AOaKvNaaLfnxrWO66EYdQHGnc/asJYlEc5jKt/IkCFAv0lLt0EVcVfoZHQLYj0uUhQgv
         /ZPz1WkDxsmGt6qdpaHxcyCwNMtFfITqtTRFnKPvlBngPG01YaUqKAeleWjP5Pb7f1kr
         kyzAE+pKWZCJIjga5eNmLTo00lKXl65r+mIGJGLu9zasiyK0ks+DfIq2Is8br0ei9hvr
         9hxw==
X-Gm-Message-State: AOJu0YziURw1Iim2Z5eKG4n/tzgDb9U0LKiF1O0LXWmqyXM+wOIlvV24
	Lwn47lz2sVP0ciFThH/AYxChyVo0cZXhWItenlmgxVQMToslQ0s43StEsM+i870=
X-Google-Smtp-Source: AGHT+IFUyQuQrxrHjLEfYyD8sDLwhFMSjF3NIU2s6+Gl7veB1QtJf456RxZTyEd4+/ZNyyguGlbVKA==
X-Received: by 2002:a17:907:cb85:b0:a2f:c5b1:4963 with SMTP id un5-20020a170907cb8500b00a2fc5b14963mr2367918ejc.24.1705937765431;
        Mon, 22 Jan 2024 07:36:05 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090699d600b00a3076ed99fdsm629263ejn.41.2024.01.22.07.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:36:03 -0800 (PST)
Message-ID: <88a6314b-f780-4511-85a5-839115beeff5@linaro.org>
Date: Mon, 22 Jan 2024 16:36:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
Content-Language: en-US
To: Denis Kirjanov <dkirjanov@suse.de>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
 <ce1b41a4-a9bc-4dbc-ae85-5187b3cab10b@suse.de>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ce1b41a4-a9bc-4dbc-ae85-5187b3cab10b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.01.2024 13:25, Denis Kirjanov wrote:
> 
> 
> On 1/22/24 15:02, Konrad Dybcio wrote:
>> This SoC family was destined for server use, featuring Qualcomm's very
>> interesting Kryo cores (before "Kryo" became a marketing term for Arm
>> cores with small modifications). It did however not leave the labs of
>> Qualcomm and presumably some partners, nor was it ever productized.
> 
> You forgot the net-next prefix

Right. Should I resend, or just leave it now?

Konrad

