Return-Path: <linux-kernel+bounces-28451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2382FEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D25283667
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF90BA2D;
	Wed, 17 Jan 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdaRLlq7"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB412B658;
	Wed, 17 Jan 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456762; cv=none; b=F9nuR1qxYp0BzrbXyKPSbfvYFB6b7YYhy9wPC+yOMkWAynMxrUK1MBlww7SQaVkD0D2a0VaqeisOMrTJURWhD5HI2qaBAPuEugyje2YayA7bGaNkFSlAO5RsE+8I5r/PxuUximlfA5cFh1jGg2U+wwgMccQltK4cEWX0T5T+F0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456762; c=relaxed/simple;
	bh=Q7ZAXq45jDLN9Qa5cpxzsBvnQmAbmuhAz4R/pS1S7Tc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Hk3k7ZREvjhb/EEggJcMlR160ryf0HY6+Aqu6gDQbEyXACrDeS8kJrAiQp6fTPBxd3foaBv5mL8PKt69fOMfiUyDMNyV5quPMdaVXdtULdLG5l+SJKZw2DIZEsZT2sZ+Fk3bGXaU0DM63RtIv4RTT4n7WqUJmLe3RG4eBqeOONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdaRLlq7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd6581bca0so2358572b6e.0;
        Tue, 16 Jan 2024 17:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705456760; x=1706061560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRKV7zkrl5aMjYceZld1VkQyBEeoC8GABh+p6k8LCpc=;
        b=DdaRLlq7TG7yG+euPIxlWh39Ju+MnI8BwcFGSLgWGkW/teMckJT09p6a1kCtGr0CXs
         xthMrJv5+Imddhwu6vjEpxihwPMhCFvI8iWsrUhqcYR4gQmgvISnD0UNDA5A4f1nh3AK
         ypxiUnR70Jwp4pFkXpmrjSmvh0e1kUhI6uZ//d2ZWogvrzSai0XGdT8mcOSEx8lBAcTI
         zuQew772OP2N6M0gIDZK6RAwsVwM5jvSEd4TLwojPbWLadPPkRvrS6CFuB7KaN3Q3ocv
         a8P36t+Tw5plUD0WHazCbyKoZyDODIxIW1TZL1aC9Lm7os7Kb/kTPCaWCCdaKjSIhGTZ
         UVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705456760; x=1706061560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKV7zkrl5aMjYceZld1VkQyBEeoC8GABh+p6k8LCpc=;
        b=F8fni12oKDFOWFOe+MoJGSax6Lu2XMew6X66fEz2i06KejnWrMS1CTUzVm0AnNXZpW
         x/Yq+cFmlB9fJJeKhY/hBeptVinK+/1Eu/7SEOgk7jvmeFFLz/RgPIFTCQaU3jnkQXJP
         W8+aeuFJL8JxjIn8uVg1ekjTf7KEihtgi9/J+Y46fWARQzwR4oFZfl1Yq6EdCBztk3VQ
         5Am5WmhJj5MvqXsUiB4ACdb5Jt28+H4ehA4dyiFVDLbszPcZmpczLjFacivG9cfMaFZh
         zB5zZn3zWp4Ny6D5lSa5SirL8X6ukoCfv3iarUOgNBCZ07XJ4Ad3qiFX3I/Qn2rtB0z+
         p/lA==
X-Gm-Message-State: AOJu0YyUYNPUUcmiFGeGM+qo43BKh0IQrhy7QMhAguXvF6Y22ECOqqrM
	92pTvcAECVkWkepGqTYRQ14=
X-Google-Smtp-Source: AGHT+IEN0a7WRH0HIYyrpMNf9WfGQ+M40O13rxZPDT20TboEI5ZEw6B74hIjaARDAcbE8tiV4Orkzw==
X-Received: by 2002:a05:6808:2e9b:b0:3bd:7227:745 with SMTP id gt27-20020a0568082e9b00b003bd72270745mr7576546oib.82.1705456759832;
        Tue, 16 Jan 2024 17:59:19 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b006da105deedesm237836pfm.197.2024.01.16.17.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 17:59:19 -0800 (PST)
Message-ID: <a3856ffc-ddb9-4066-8e1d-999c8f7790e8@gmail.com>
Date: Tue, 16 Jan 2024 22:47:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] rust: kernel: add doclinks with html tags
Content-Language: en-US
To: Valentin Obst <kernel@valentinobst.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240116160141.165951-1-kernel@valentinobst.de>
 <20240116231118.168882-1-kernel@valentinobst.de>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240116231118.168882-1-kernel@valentinobst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 20:11, Valentin Obst wrote:
> Add doclinks to existing documentation. Use html 'code' tags to add
> links to items that cannot be linked with the normal syntax.
> 
> The use of html tags is a tradeoff between the readability of the
> documentation's source code and the ergonomics of the generated content.
> 
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
> [...]
> @@ -14,7 +14,8 @@
>   
>   /// Byte string without UTF-8 validity guarantee.
>   ///
> -/// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
> +/// `BStr` is simply an alias to <code>[[u8]]</code>, but has a more evident
> +/// semantical meaning.

Isn't there a way to escape square brackets with backslashes with
mbBook? Like `\[qux\]` or something? I ask this because this affects the
readability of the doc comment so if that could be omitted it'll be
really good.

>   pub type BStr = [u8];
>   
>   /// Creates a new [`BStr`] from a string literal.
> [...]

