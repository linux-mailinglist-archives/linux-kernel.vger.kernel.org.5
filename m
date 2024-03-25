Return-Path: <linux-kernel+bounces-117802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB6488B5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34537B3E6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED71798C;
	Mon, 25 Mar 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCsjd5/l"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260C1C6A6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394385; cv=none; b=h2WgUwJqcSkJeSfgR5OK7pXLmZap+0VooIRLJLn4LPjQspc75cdsniuNIariBD5TTQi57XaUclAmF+RoSchse2HrrRhLK+QIHMb9XH1c5dmOAcaTdGm18QUqgjspN4ZMMDe/1qIjI0LzVaLP8h3IzWuxy8C26xu3nmLNrFM4f5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394385; c=relaxed/simple;
	bh=xEMxiJB0c6G9z0DMbm7e5y0kwjrYVcpjBOXOzjtHEAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHnnuOSk0o+pFp2b17qkfF4NKKZO9zFlnMC2YcXN/Qrc5oFHHFBUMKiAehGKizon5PV/nMKjb8kbYCMBRjEpZFbMBjrWGI4Ux9zGJjMNXhcyJHfdn6nSHKccrQ4g8XM4bTe28xI6ORS0jBPTxtBpA5lNpcYLVYoloSCxergMCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCsjd5/l; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56a2bb1d84eso8383511a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711394382; x=1711999182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ugZz785W8pMDPhpwfMM+nuUMqogsJD2dq6g02eauybE=;
        b=iCsjd5/lWV67rNMya7uouqwFYfrH+11sTrQjp5VODK8fhlyvpuE1uEpP92rCkA8AIJ
         7gFVkx570SHOI/Ul9y3z1g6r46LPSkEPHIq5BXSf8ar44diMoEDWXZg6kt7NtiwEGkzD
         JsNhWHN8xhW5p7uLZ9AXK++La1DDDBFD6eQRQ4ep2ljm9b+txluQvLA4rHWSdhWWzYG/
         E15gYkOz2BhEm3DNukIfXdSACJ+nxdMeTaZEHq76T8ie/vQOjBwC4W/SOL/9OwLtHi6m
         PODJ22yQ7p9zr7cNV+lbIQ82AEmcK1g5qkg5zAWHYnMsO3QLvM7BJmClEq1Yyfn9rZ2O
         1pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394382; x=1711999182;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugZz785W8pMDPhpwfMM+nuUMqogsJD2dq6g02eauybE=;
        b=ApQa/3B0iJGXpgK+crMTif9TUTJ9yB89qMUN4pd9Wh0XIyvxiuCa05/BF+mrcTIBdt
         Qi8yhPWGxVznVqXBupL69cdAVfCz0izd3iEUk7jwY2aUOlnooHEZxPs/C835/UfqRxPr
         MLDZytmUhGkIUEz1ICwEwS6qo2QuCmCGtk2vJiCSYawG4aIzRx0tuYapMJTwfZVUkfOr
         Lp5poHHuuvZ5VLIlg10gwNxCpVmFqdHX3f61zegOFVv6DmvvskPJyKSyh6zC8vL+IecR
         CQ1RlHDp2GPUL0TiKFtREq1v8fCbm/PCxIryQDjBkxGvRiRn1SvpHa3tqRk7PTyrIrKU
         UYAA==
X-Forwarded-Encrypted: i=1; AJvYcCWyaSwZqW6ZERaed1kaqCVpR36v1hZbrLR9dEE5pePSb/2c2I0VHABPEHBDtVxQz5MhaVAMOq/sJ+yFBbLo70jNItOjajQ1rGh58ZXz
X-Gm-Message-State: AOJu0Yx9o6zkY0TZKw0ZoyhsLyHbrqzoVveHy7IRgcXDqQv24oMvM/SK
	1PsE2AcMk0REudjG13dVlaVKbBqH3j1E49dX9ip8HF+1/3y7PW9P2pB9rM22MlwzDVEjfF/2/YB
	C
X-Google-Smtp-Source: AGHT+IHpyNyOQRHz+kI0k7EHDSauGOF7bPHup2aMlbQZYZT2xJ/E/g1kriz8PbOzRAytkBellvwTjw==
X-Received: by 2002:a50:9b4d:0:b0:568:b43f:e2a8 with SMTP id a13-20020a509b4d000000b00568b43fe2a8mr5605054edj.13.1711394381892;
        Mon, 25 Mar 2024 12:19:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7d493000000b0056a2b87787dsm3272093edr.37.2024.03.25.12.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:19:41 -0700 (PDT)
Message-ID: <17d40ec9-ee7d-4ff0-800d-d3da678d6b57@linaro.org>
Date: Mon, 25 Mar 2024 20:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
To: Paolo Abeni <pabeni@redhat.com>, Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syoshida@redhat.com,
 syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
References: <20240312145658.417288-1-ryasuoka@redhat.com>
 <413249a5-13b0-4a06-9819-650eb4e82b37@linaro.org> <ZfLKjD6aMrGPEgHh@zeus>
 <498dc99d25965877f7d15592dcbb340f97d803b4.camel@redhat.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <498dc99d25965877f7d15592dcbb340f97d803b4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 12:58, Paolo Abeni wrote:
> On Thu, 2024-03-14 at 18:59 +0900, Ryosuke Yasuoka wrote:
>> On Wed, Mar 13, 2024 at 10:01:27AM +0100, Krzysztof Kozlowski wrote:
>>> On 12/03/2024 15:56, Ryosuke Yasuoka wrote:
>>>
>>>> CPU: 1 PID: 5012 Comm: syz-executor935 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>>>
>>> These two lines are not really relevant, it's a virtual platform, so
>>> whether this is Google or Amazon it does not matter, and your log paste
>>> is already quite long. If there is going to be any resend, I propose to
>>> drop.
>>
>> OK. Do you mean all these log messages that syzbot reported should be
>> dropped or I should leave only relavant messages?

No, I proposed to drop "these two lines". Please look at where people
put their comments and what do they trim from the response.

> 
> It's not a big deal either way, but there is a quite established
> practice of including the whole splat.

Yeah, splat was fine in general.


Best regards,
Krzysztof


