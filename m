Return-Path: <linux-kernel+bounces-70929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD1859E22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C433A1C21F45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449F1210F0;
	Mon, 19 Feb 2024 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5ikqlRi"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506321105
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331019; cv=none; b=aaNwuAVy+YC9Dces5e/2eevikdY1D+9uxEjrXAPHu3Umtrp6baMiPP7w4LRzU+xxzkJKUaue8giLyrSqK60ohsic6TT3p5yzXabf2t17TS0XrYFNl0hF1cToFOJTVDJ07VIZhVYB/xBucWXPUcPsL6r5qeSFmvuYys/LiVG+/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331019; c=relaxed/simple;
	bh=9MLnOX9RiJxt9rkstmn++zs1e5a07xKy2T5HvnHxuUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eh7jSOs6HaYvB1JkVRuEaoA++lxMMN7URaAcGGt9Jfk0nOHRahOrqZS54wJVWFK81mN5UGKhaBdChdD1ZLvHeT0HqOVEp7Zzu3FAQkU756UNhXdXsrZbaOMaRv0MKXDBVSvXgeFxgJKIBgdBkJKi+0eWnJvSXjjVzftvMwXidNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C5ikqlRi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0f7585d89so31329681fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708331003; x=1708935803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VWhTgeoFtU+E6jLcXoTHSsFSQBjtF0ipusEZZicCdw=;
        b=C5ikqlRizSDMfaLXG6z2hMau9FaMboDSXZmN/cTw5C8ffOf+IWIMY3YLHY4pdtndbR
         N20Lh9J0whKsYgSFyYAzSlqSTgGgm3jJaklBKyuIxyxosUxjIuXe1XL3+wFHIDy6P2aM
         34kmErwdTyyIEpEt7Bh50acQqfLHXyf0Uy3/UNlku/iQ8JHVUVWuqwU/HlnqqQ0pOGjb
         aFwRTZbla2iN+G7CGeIh43vxynJcahmz36iMIwS5OOIXT/XvHdkurjvw9Lehl0Ghx1sQ
         DKvwwuJuFq6UKfUfmwsi/yd6XEIHNBYVQM4c0ElK/StnmvdDmstsZoNqsxuqA4oWtOfk
         M9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331003; x=1708935803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VWhTgeoFtU+E6jLcXoTHSsFSQBjtF0ipusEZZicCdw=;
        b=Km6B+pA4Ry+MqdV/QT3Rr1XFgGqMn65RW193CxLI4uf09W0r9kWk80hjvq3zlpQLtW
         fJr3VL/Z+1L4zpg8JIGt4Zg0dA1kvHKToSK2yY8o9J/Zmwxv5pPvYAoF6u/t4irV1wIJ
         Yu2wDFK0Se8Fyn7un9EZ84dyZ1MwXQjgC+kk85OdwrJt4CS8KuTo42lSoZdhxR09Y7Az
         lQ43E0KbDoLJKCq0sOJUKZacxQbbvJ1LVPIMHStrBE4YLd3qWrAxI5bHOcXnm4g2/lmW
         5KaHZAOn3Cgnqj4Xs2+mNpzHDNTfXXXAc8PJ9r+QhEq+o9HYWQfkxCZvV4iN7zH58tRe
         ms+w==
X-Gm-Message-State: AOJu0YzTkfuerW//PKOt9SMpUoLEb/ce/LPnj2zgYugsZKIOgremfnO0
	Jq83cI5Gre679e6Prqvnh9YrfxnjVVJE4sgztZB4F6EOh6z6e0CTpzhYJwSAVAj5CdEpkulIhOT
	Q
X-Google-Smtp-Source: AGHT+IGjbrsQEADA0NlkwAy86um0bc2+e5A79Sc7gEFiOqRvlx4CQs/A9lGC7TS9zIO50E4fJeTPSQ==
X-Received: by 2002:a05:651c:b12:b0:2d2:3978:a14 with SMTP id b18-20020a05651c0b1200b002d239780a14mr1813901ljr.34.1708331003270;
        Mon, 19 Feb 2024 00:23:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id c5-20020adfe745000000b0033b46b1b6adsm9587734wrn.21.2024.02.19.00.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:23:22 -0800 (PST)
Message-ID: <d0b3146f-994c-4034-bda2-a78015a24cfe@linaro.org>
Date: Mon, 19 Feb 2024 09:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: MAINTAINERS: add "Profile" keyword entry name
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20240219082212.13676-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240219082212.13676-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 09:22, Krzysztof Kozlowski wrote:
> The HTML output of MAINTAINERS file prints "P:" for subsystem profile,
> e.g.:
> 	Status:   Maintained
> 	P:        process/maintainer-soc-clean-dts
> 
> Use "Profile" as this entry name.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9c3100ef587..35933bd320cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24,7 +24,7 @@ Descriptions of section entries and preferred order
>  	   filing info, a direct bug tracker link, or a mailto: URI.
>  	C: URI for *chat* protocol, server and channel where developers
>  	   usually hang out, for example irc://server/channel.
> -	P: Subsystem Profile document for more details submitting
> +	P: *Profile* Subsystem Profile document for more details submitting

Eh, I am sorry, did not check the final diff. I duplicated "Profile". v2
coming.

Best regards,
Krzysztof


