Return-Path: <linux-kernel+bounces-33601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CFE836C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AEC1F23476
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9BA5F55B;
	Mon, 22 Jan 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gF22+h8Z"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77146539
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937398; cv=none; b=DsdvyngblJgt/kSFdl9/NKV8OplU0KPZi9T+JwQNQVXFSuor1SRWB9WTUvQoOFHXAI1pBJZUp+biUBE41J6tjZgFVq8df/MkPrf2R1jGm8z6tXtHHR+m/6wyiSDp2hXne5EVqZUHdcMaCVuH9PrRsjvYOLuJpcZ+YgfHzN4YWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937398; c=relaxed/simple;
	bh=92bGw/sdqkNXjPn8bN2lmF8HecPnbPE7/DcUY5IO+Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaR5H5FB6o4t1NY4C5MFuF0RmLYrXlJZtJm3aEmgLtj/Dfxq0Sm4tibAiufnT6dpLmnO0M10mrMw41EF0zonLsocl9roADwAPjP2sd9hbow5/12FzYJNK3PVdHgjWmGXfs2PpPVz71kIwzlFI1a91cv57qvXDWRM4QYEnHUKH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gF22+h8Z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so3362291a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705937395; x=1706542195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzAfe33+3mfzwcWLyjFGbA+RuoBZjOLLTMygi6+aB1U=;
        b=gF22+h8ZACYNXSxwFqOJqqhyuW7QbDvWvy+ZaIv5U0Orcaj+Ve+LWThn8n2AnUOemH
         gdGIJInvzjRtV3O5Fmfb9+4xP8gGS0DushaflhbfLfK7jvjcIXXh5uEsxgAJHNprkvXb
         4fGdquKKPa03E4VFafy3TGxHIHOKC27a47ltBi8hXWduwgI3PGuPUA6h/uK7JRJfTgqe
         fOf/DZKMARxvCSgQG3yI0YZ66peLpI/i/lOIqW8T3m6XxvCfw4Fj6nV+HvNlFtxWBAVq
         J3ds7ZbEEja1pJ1zwOf2pGrBWIi/u7aZIlpgx3BdTtezhh+RqizQwvq8PPhjH7+9DYyR
         Jcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937395; x=1706542195;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzAfe33+3mfzwcWLyjFGbA+RuoBZjOLLTMygi6+aB1U=;
        b=K+5dFy5QAFhEr7qUB29wph2HBSpWK0z25SAkUEY9kmkJXD//+6jN3zuJrvkmVZeuGG
         d6i69ZR+cU1UwGGNNqc2d1+hr5XrtWxDuPPX1OSYmA7+LsS/s7wa86h1l/DrYilPIXHs
         n/GdH8qjlBS2AEHBJ248VjiPhzSUoT2tXM+EtHFtTJ9golIam8ZtKa7zJ7q+4g3+wI1Q
         wCZY5/sgTGwEKgGCKJtvzPL5Ss5j7K3/HN4s62jdkBP1I5qoKtGaqS+9arj1LeS2p2FR
         lAatdjYRWR0xa5t5hi/FwStkpMf2QKDTLAG5MwIWW7TRa8ne3CRLXiyyVNFTWw++lPoB
         4c6A==
X-Gm-Message-State: AOJu0Yz5GcJ23G6+asFywcaie5ryFlwJgjmwpwQ7rEkBmHrrL+9aIKxq
	TM0OUHNzEA5WsuNJVJjfALVGodvYv7c7kETewBuu6KWBn2wUwZ/PDzcMGzOmLAc=
X-Google-Smtp-Source: AGHT+IHhcZm5eWzUgP1DZ9HmWCAaHLtN7Q+BnC5BgjxK8pStYpd4vrObS9/AH9uSeOuvgTl6387rTQ==
X-Received: by 2002:aa7:c914:0:b0:553:7a3f:3d63 with SMTP id b20-20020aa7c914000000b005537a3f3d63mr33224edt.18.1705937395182;
        Mon, 22 Jan 2024 07:29:55 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id j9-20020a508a89000000b00554930be765sm14754031edj.97.2024.01.22.07.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:29:54 -0800 (PST)
Message-ID: <08407f98-9d96-4682-8c80-5a6f79c11fb0@linaro.org>
Date: Mon, 22 Jan 2024 16:29:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: core: Move the unused cleanup to a _sync
 initcall
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
References: <20231227-topic-pmdomain_sync_cleanup-v1-1-5f36769d538b@linaro.org>
 <CAPDyKFoer83wwCYyXS5S5wM8HcezyUDdxcW3d4Z+za0XpykSAw@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAPDyKFoer83wwCYyXS5S5wM8HcezyUDdxcW3d4Z+za0XpykSAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.01.2024 16:21, Ulf Hansson wrote:
> On Wed, 27 Dec 2023 at 16:21, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> The unused clock cleanup uses the _sync initcall to give all users at
>> earlier initcalls time to probe. Do the same to avoid leaving some PDs
>> dangling at "on" (which actually happened on qcom!).
>>
>> Fixes: 2fe71dcdfd10 ("PM / domains: Add late_initcall to disable unused PM domains")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Applied for fixes and by adding a stable tag, thanks!

Right, this deserved a stable cc, thanks for taking care of this!

Konrad

