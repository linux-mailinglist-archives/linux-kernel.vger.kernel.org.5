Return-Path: <linux-kernel+bounces-74980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0185E0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C425D1F2683E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96B80023;
	Wed, 21 Feb 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJtFlzEz"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286D7FBB9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528467; cv=none; b=hkvZXcTtV6EZgflu/dzzqj25g3ukKKRNnPPQKvtJnTksxPryHl/1HpBAgbouFfahZu32IsceV7/WCgUGiH5UUxTy7Mn6PX1GSpBuf05vTreveYHEBGMnC6wsDlPmLzSHzAQBI5PWD5eueRP/2McPSz2WO9JvaHA7ts9BtIjkVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528467; c=relaxed/simple;
	bh=/cA+LQsDFb8C2ULCpmHwc259mCn851OpIto1ONF9EmQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vud2oIFGJ800ButqxEmooSPkkgwZ0w71LFnTP9KwF40e6UZCo5TWqCWiWmDoFlc4QvOpt+oPLCs/4MUHJULAJF0jLWSf8n48C587zp5+Euka+Xh9CQaMjpdfob+y9LjJ7uPm8nKBRrW26Cn+ThRFVdrSUKj407oVTwpXPwUrEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJtFlzEz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512b3b04995so838832e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708528464; x=1709133264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AffuHo1J/Cv5TQTXKKaTUFqeM2kx/KegGNmtkezQ54A=;
        b=SJtFlzEzuFzM7QHEwAcJFmVggkCSYbN+u8/voQjQQ37COeHBx6u4MG7ZNSQHHXl7I+
         jTZ/imXm0HXs0V4HJ6S78q2+sxe8xQ+l5wX2yEMajDdZb/LqSAmPCVNUFfS2rJTX8gsn
         u7VVVDbnmRxVmFCvJrygWU3W+V22TGIqs8ZNSWgxoOWjsDOnmoRP8GVu1Fm2ZEwsJUVr
         jZK/puIF4xVX8cdVKeg/VZjxx1yzy9TwZkyt94rIn6iQllnQoslfTgcsuiv6LJcmgiou
         s4E1u80TtPLRzQns3v12pTypp6zkf8dimtUI958rIiT7XCg/4xG/LL2jZlpBmVvknlV5
         0o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528464; x=1709133264;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AffuHo1J/Cv5TQTXKKaTUFqeM2kx/KegGNmtkezQ54A=;
        b=hyeLkKMCKneyz1avU5ibq13/X51dnLgvWppWNJr3NFqWI7MWLq6cH307L+MS/PtLuu
         cZEcDcVKte36TcJ0gFdzB9Pz1vg1NDn28H+lba4SahkFi7mh/n/fsiPgzDog3qTt3tcM
         J3BiazJAc91C9sOz1pn5vkmik5nulNnsuyPsHbkFFXAY2tiijb5FC58733QlAjtXSBDE
         ztPGGx5B11Yh0oBOHT1QaFDwiHdYeUehEojty8oIgDjQhFpvbA5UiW4aTtt/ZHuYmVH1
         maPHeHc0+EaGMphNHjKpcGbdmdxsBYD9YuafUXZEnDlTo+sH3uDLd5vBqeSRKuw/SAmz
         XEMw==
X-Forwarded-Encrypted: i=1; AJvYcCXBqz5OceI+8NQjB531wkRfv7QQdjwINkF1ZgKMpQlmB8oAlyz3xHVuJp3Azhsqfy2VjgeWgnpk09gQuJOF030YavontyPN9M3KhzrT
X-Gm-Message-State: AOJu0YyVHUyG6bo2x68xQWv5tHQNhwMtqKeOZtI9SJymwUUVjPS4/Xij
	p3oDoIyolMS3yk2j3sPXpqsC0x6xdPeTXiMWiEDH86nv2z8aOi+ZEeZdOlujHrI=
X-Google-Smtp-Source: AGHT+IGYgo1Sdd0mg0IVrJ5wf531kygISfWSktojLHCwTMp8VAzlFdNcEKDi5S2duiV8d8OKQ7VmDg==
X-Received: by 2002:ac2:5e6f:0:b0:512:b297:286f with SMTP id a15-20020ac25e6f000000b00512b297286fmr5476967lfr.52.1708528464184;
        Wed, 21 Feb 2024 07:14:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402014100b00564c7454bf3sm1601349edu.8.2024.02.21.07.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:14:23 -0800 (PST)
Message-ID: <743c9df6-3a19-4204-9812-3c47e4cd8536@linaro.org>
Date: Wed, 21 Feb 2024 16:14:21 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Maxime Ripard <mripard@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org, Enric Balletbo i Serra <eballetbo@redhat.com>,
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
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 16:10, Krzysztof Kozlowski wrote:
> On 21/02/2024 15:48, Maxime Ripard wrote:
>> On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
>>>> These options are needed by some Linux distributions (e.g: Fedora), so
>>>
>>> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
>>> use on my arm64 boards, does not have any problem.
>>
>> Is it relevant in any way?
> 
> Yes, because it is justification why we are doing it. Each commit is
> supposed to explain "why" and the explanation here is not enough.
> 
>>
>> I'm sure Debian can boot without MEMORY_HOTREMOVE, or BRIDGE, or
>> NUMA_BALANCING, or BPF_JIT, or NFS_FS, yet all of them are enabled. Let
>> me know if you want hundreds more examples.

BTW, each commit adding such options is supposed to explain why there
are needed, so please go to the git log and answer yourself why there
are there. I am pretty sure I will ack/review removal of every option
added without answering "why".

Don't twist the discussion of necessity of Kconfig options, because each
commit should stand on its own.

Best regards,
Krzysztof


