Return-Path: <linux-kernel+bounces-76394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF385F69E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E014B284446
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91541212;
	Thu, 22 Feb 2024 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3jx2u1R"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90C405D4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600663; cv=none; b=f93fU5OlQe0UiJCPCK4hF9FaxGCwrb7V0+W0Q2xl7qoaC6g7HDVmDE9tURiMhKfKlch9I6exafVx0pBbIqfzDLOBICIz5/X0ym9s45tSYSsQFxD9+laymAgf51d5NH9KyxqyPGR/P2N+9NpFdJWMJ2kgIotrzlNiv0/7Ec5axhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600663; c=relaxed/simple;
	bh=oQi7mFU359Cj/AscSSppxr83g0fECUJdXnTaapLmzGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaahjCdn8xkqvVeK85eSPu7iC89wKkYdc1W0VmsHZHcwFtQqEZNGl3/av2nNeMEy5sqV7ISDUd5f9zzfsv/vnUY2m8keZ7tDcb+uD4+LE8Z3HAUVaCg0T/c+kDV23mm1ApVydRRX8GeL5Voik5PCbf/MzdQntIMNeicPmlDe4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y3jx2u1R; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565468bec51so498178a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708600659; x=1709205459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbVJb0/ymFFg/j1VC5pxEFJqxz2k+KUc15LR//wkgfg=;
        b=y3jx2u1RkZYx7/+qBFuUsdF+I2zKYnTN+Yi0H0pqUYvPN6ylBo6RKneu74HPqNUoVG
         2CjN5lIzdkKyADLHQrGC152MLKW+9MU+b7Y2djW9GY9gtjccTV0fmZYv+D5qZ1AJsu8m
         FHOjjkY1DNYsmGCfSoRRoHhr0JQHAWjObfZIKYRIIQXJtTYgRclaTdankkGViIPuMvCi
         iEOaLhgzJ1Zrmb29XqufTgKHKuBu51t4kAmgypRV3J96tVERAhwa9N9nJwoO/V63GeZZ
         RtGm1fB5y7TezdZEGzMGddbRDezMtABWXH2R1RpMwgM4kS4z3xI8uxjKmCCD5vkpQjmH
         dhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600659; x=1709205459;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbVJb0/ymFFg/j1VC5pxEFJqxz2k+KUc15LR//wkgfg=;
        b=Cn3D0mLDRajdLrMvUwoSZ3DSDzvNkPcJumMkzRoIP/O5YKzIZNmWC5M2CcRL3QCp26
         ubSspzHMwdVl1A/g+JHWJzM1fAWMQJZjRd1kuBPT9mh+JvEH+4BuP6zJAlzZPm6hcJGv
         3xhgx5Pi7UHUl6gYEDtm2AMrCSOosaclTw0XzXfj1/aGSfOAPO1DyACQJs6oUXr3nDSa
         mvzcE+dX6ON7D8EODboUqbXBkRUsqqZsDwBynS+hTLslyb2CCYkfNfLw+Tr5xEuETdUD
         WBR40oEkWC52d7IGkAc64DO5eieIC102EIXnf6SW7DECAVCemwZsA53I9PH7VjDOrPF6
         oz6g==
X-Gm-Message-State: AOJu0YyurdMlNLTWvkP8cUaQCAyT7qlWKANompOB6LPTTABzoHlfdRyz
	KAneDz33Qpoau7aLYIr/FlA6F7FbJjYFtFnpMQuxSgUQ04imCA7cSUO1p/6/Aa0=
X-Google-Smtp-Source: AGHT+IHF3zFe/1HV80R/9k3MHR+Wc47MVm/PMny0d7Rxy/HLNxqODFJiaGRHITB3zpmgBAuLdlqsBw==
X-Received: by 2002:aa7:df87:0:b0:563:c951:838c with SMTP id b7-20020aa7df87000000b00563c951838cmr2109211edy.18.1708600659362;
        Thu, 22 Feb 2024 03:17:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id cf28-20020a0564020b9c00b00564761ca19fsm3750725edb.29.2024.02.22.03.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 03:17:38 -0800 (PST)
Message-ID: <87f2c94b-fbda-4a7d-8570-2c5a15964546@linaro.org>
Date: Thu, 22 Feb 2024 12:17:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Content-Language: en-US
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Enric Balletbo i Serra <eballetbo@redhat.com>,
 Erico Nunes <nunes.erico@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <9083c414-62f2-4bff-93ee-13f8ff60eb34@linaro.org>
 <874je1ipb4.fsf@minerva.mail-host-address-is-not-set>
 <bd071521-7f7b-41e8-8786-ad2eeb58b03e@linaro.org>
 <87r0h47tlp.fsf@minerva.mail-host-address-is-not-set>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <87r0h47tlp.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 10:09, Javier Martinez Canillas wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 21/02/2024 20:34, Javier Martinez Canillas wrote:
> 
> [...]
> 
>>>>
>>>> Any explanation what ZRAM is necessary for Fedora to boot.
>>>>
>>>
>>> I mentioned already in another email, Fedora is enabling the systemd
>>> zram-generator and not having a /dev/zram0 slows down the boot to the
>>> point of being unusable. One could disable that service but then is yet
>>
>> That one sentence would be enough for me.
>>
> 
> I'll add that then to the commit message when proposing a config fragment.
> 
> [...]

Thanks.

> 
>>>
>>> So that means that for aarch64, some filesystems have more precedence over
>>> others? It's OK to have ext4 or btrfs but no xfs? Honestly it seems quite
>>> arbitrary and subjective for me.
>>
>> Yes, subjective, but to be honest: I would drop Btrfs. I was thinking
> 
> Fair. If the agreegment is to minimize defconfig (which AFAIU is your
> point), then I'm on board with it. We can start splitting in separate
> fragments, people can then mix and match for their specific use cases.
> 
>> about it, but since Arnd agrees on XFS I won't fight that battle.
>>
> 
> Yeah, it was a strange hill for me to die on and is true that fragments
> seems to be the best compromise, as Maxime said before in this thread.
> 
> By the way, I want to apologize for my harsh/rude comments yesterday. I
> wasn't in the best mood and I got too emotional...

No worries, I did not notice. Everything seemed fine for me.

Best regards,
Krzysztof


