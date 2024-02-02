Return-Path: <linux-kernel+bounces-50025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80726847342
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E48E283DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38C1468F6;
	Fri,  2 Feb 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPW9S0ZP"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB61468E8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888056; cv=none; b=eFZxgpvLI/qdHGVFnzFk4IUZgwQ/fX8KB2/nVX8qTacWW4DVwoDab+wk+jLXJqydM/kG3zxU9KPH9HE6N+AfAs0fmwQSL2G2Vgy1+oZdkfE57a0xtl3DrZZTcO7xueQCRhkEd+ryu+g8YPQ0hO7TybMqZ5bEAA7XxTxfVLYxAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888056; c=relaxed/simple;
	bh=KqT9cw82PFNW8xRp6Aw6Po5STwZZRiozAqTL3kcaFNU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fLPug1M9HK2YQYOnTmUpdgCzC7VUVXhh6vjAGwPUM5paU0wKWoOLdHvMmWr/nnbDWCI/c9F3uUCvi0nokqVLFXnNC1k+Zpq6kTo35JST1RIu24MtWpGIiinEm5imrk2HPGXo34jL+63XNJ0XxXNBNe3uvxLgKAuSLHzuqrlBz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gPW9S0ZP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so3134392a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706888053; x=1707492853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=szWLfoxlPAUSn0504mfDdaB+kOZ0s+e4Alhan+vtln0=;
        b=gPW9S0ZP89ai4zJSDgfjWtzlAq2ocxRTL7iYtBAqDd+fetKYmA8MhAOYry6Z9tK47b
         QAVTv9Acq4eiwkfNJoxMkv6svPbl80vsLqTwy4batvxRcVr6X0XC2mgfF9QFelT3Vpkk
         Q7rwhAWf7pzudEX3IZkgETDT6qTTagdmiE/YUwXwIAZAjI8FHCbaX+JjwJqU/5/6ZPq+
         Q/w06tNaIAhTkvzEb6H+YjcbKD2QCI0BNw4HDy4U6mlesO0fqG8nvAltoXnFxGqIZjLo
         aX/AVgTxHp7a4oUsKAKdTMGB4hhQd/Jm+Oid7ZCKODCJoT6CyViQfEsbOr+R3zyI+hBX
         JPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888053; x=1707492853;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szWLfoxlPAUSn0504mfDdaB+kOZ0s+e4Alhan+vtln0=;
        b=euhiB34WYaCa5pwcqV3mx48LbCqxx+MaBMU4OmecWw2PvA0HPjbcJ6Tg/7J6qkNN9n
         mSYh1Bjhl77ECDDr+ygofwSLhslQ6d57BhgqYRg4f76dJ1mjemRJ/twFFoPl+yQ9xpFh
         VXByQNDiqnK20JVIN3Zjal5Mb+1p/xd0txM4yhBk60E3mgUKGHBbp9D6ZazT6IOLrVdb
         McvQU6sVt6pEnKktFI5kKQmfHaqKENMO4gArZJQY5Wl1Qj7fw+H9XjqJaFPXQ9+zo25W
         bMnBt38TCyePAMzkoHQWAbr8R2DiW9duBmKfR1o+MSHuV25GrifS3PBEXeUexAYN1fMT
         1hsw==
X-Gm-Message-State: AOJu0YztK1B88Mz+AbzzDV+k9dndF7diPqCWHxFH7Lt9rpPHjibfquxu
	oMEJmxKZGFSVtCCZay8IobrQIAUSIRMJ/nnAIXZXDIjlnRs956Oh3vmL0DGxFpo=
X-Google-Smtp-Source: AGHT+IHkaZVnfbLloahmByS5j1oN6tVvdTIddymwuurl2t41ba3UJ0RFs7j0kX1mOLnRi2wEjBV5dw==
X-Received: by 2002:a17:907:77d2:b0:a36:fc15:d724 with SMTP id kz18-20020a17090777d200b00a36fc15d724mr1996871ejc.18.1706888053199;
        Fri, 02 Feb 2024 07:34:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7jUS3LS4ZtJ3NabIYDFTgSTfBHT8/QzUr+abKfeJiCtcD0w9+WS1KyemjhsVWVki8OG0zRuDAgg8APrAMuEIkhYBH5i8Dk665Vl1f4+fK5xP71ZW90zg67BM/4mBSzTK1xfM17wc8+bdGmG+lnqMW9nPIbR8ywX2AbvN6wmFwHKkHn1weR7EU9LwLTQgbPwABuuP9pf86RAPX36QsTO7OUmIs1/qoSNV+5UQeQQabRLCGv+IPYp2zeCapNAlyhR7zVeXwiUPT6Kq1cnfdrU2221xtoGsWgmfy3LbLWFJ21CEcjNdV
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id m18-20020a170906235200b00a36802ac18fsm983580eja.30.2024.02.02.07.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 07:34:12 -0800 (PST)
Message-ID: <94111a8b-8fef-41b5-b65f-9d5c7f618794@linaro.org>
Date: Fri, 2 Feb 2024 16:34:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: samsung: Remove superfluous braces in macro
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240202010507.22638-1-semen.protsenko@linaro.org>
 <bed3d775-2d80-445f-bf28-b28a17a6370c@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <bed3d775-2d80-445f-bf28-b28a17a6370c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 08:49, Krzysztof Kozlowski wrote:
> On 02/02/2024 02:05, Sam Protsenko wrote:
>> Commit 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
>> removes parameters from EXYNOS_COMMON_SERIAL_DRV_DATA() macro, but
>> leaves unnecessary empty braces. Remove those to fix the style. No
>> functional change.
>>
>> Fixes: 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 8 ++++----
> 
> I am pretty sure you did the patch on some old tree, not mainline rc1.
> Please work on maintainers tree (or linux-next).

My bad, Tudor's patchset changed it few days ago and I missed that it
was applied.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


