Return-Path: <linux-kernel+bounces-118514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123088BBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D982D2E3AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78419133420;
	Tue, 26 Mar 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KA2F9VCI"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1250132811
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440477; cv=none; b=KBpn+1gY4OMCjQu5s00MDVHLZ98GkWsXjeDDFcjtKIdFMJhs8ihclZ2nFTO8z0TiYT1fvY2r0TZZe7Ql2L7OFWht0+nKRIvZ1LAzuRMk8c1U1/N0VzS3j08opod6f6zCOXrwOyh1yE51w15/DOjGKkeCZTOGATtd8OEdtYdLUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440477; c=relaxed/simple;
	bh=t5BeQK3czFNvrHAWYqBZRmkHu/JxdynbrnMYkSBRzeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SX8SaJvOvpXuefPR1z+u3isK/j5KjpqtTNIlPa44tEZBXdwWl/h+jCalJFJ4Kd+FQHK92EVUyOQu9cFSVTWOdpa+tOAnxkru0MN+UwnRo4JPoAIiyzAQ6o3pqiP1zh15MkztG7I8rfejcNwv8jCOsQu3hrgg9VO6ty2Zj3yjIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KA2F9VCI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so10416336a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711440474; x=1712045274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7TS6OxALLsfHvGB/rBwhY7IdmTwAHEVypcQoah0/XJY=;
        b=KA2F9VCItqP2jdi4HbE8UaMLk3U+ceXJqCiNmiKTfzjkd60yOrcOsz6BPF1+sNZHW4
         DKoqfCH4Lb/wXsfjsljV4UROwiIQnu7olTuQVSILWTVJu18RU03Aw/lTg3rBq46jtBBz
         SKM8BNaH4wIc6Mt25Dx0YGBF06qbLbLAq0dur14YOiJpHCctfuwO5Z0ikqywigff+Nlc
         sZua/CNTEYhV3weFMpmofKzMnJSMl4GnLF0dt5aLkIwdm9JHGjjme/a6XV9BggYG3FSK
         pNgeToMlh9cLXyhU2TWdtJL5bXKXQ7ZxpSQozo4OPolOWcbzCZR1rX24+YNqupWGcRlX
         1XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440474; x=1712045274;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TS6OxALLsfHvGB/rBwhY7IdmTwAHEVypcQoah0/XJY=;
        b=TNSDzTLUm0LGD1Bg9JCX1jySlGwa6QamxZIKQuXeaYzKN4IerBVOLw9wJ8FFtYbtQJ
         SQKndzOqexsQRa0vBXJIIxlJ06tbHV2qG2DMba+AEWfh32tf1iXUrYMcHwulyiciZIuS
         9Ql/CibaJ6g1ffoZnzzpqPyU+gp2XMr0/pQMuuFt0PmIlM9xM+Du1fNYSrAF1BQ8P1vy
         RPWrMSnGtee7LGZSJKOjh523AzJcCgvuS/ZNduHa+CEkF4WUhNGqRU+B0og69xDcTmLf
         aSPhnpNxs6ryrjcj68BUQ2VqCU7O4CmSkczgYfbChsCOl8m3VeXNg3EStwCysz6K/ncs
         ncsw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zwm9LXvLXP/Y2/15/MASgfuq6KRV9ql6ZJdWC7ffH9YsxvE8118dtjFGZCHcN1hGkI8rbpcZRajuIkDjJ4Ptw8QSWTHA+i2eAzdM
X-Gm-Message-State: AOJu0Ywpqkne0CrUadcFrhA05gWJHRaYUZtmuV3JovUPKkENwZTAAkw1
	ZBZp1TV/D4/tptd5eJd0+sNmvl6UfmOL8C20VXTeFP4M93EwwYz3w8H/oU1OqEc=
X-Google-Smtp-Source: AGHT+IE7u8DAN8lAbhcT9gouEWdrspKY2DojCy8527/C9FLkNsBbKkK6Bab3017xD7ZHewW7wfVIxg==
X-Received: by 2002:a17:906:139a:b0:a46:fb47:7752 with SMTP id f26-20020a170906139a00b00a46fb477752mr598291ejc.23.1711440474195;
        Tue, 26 Mar 2024 01:07:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id bu24-20020a170906a15800b00a46a2779475sm3946095ejb.101.2024.03.26.01.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:07:53 -0700 (PDT)
Message-ID: <461a8c3d-460b-4ca4-aa90-b70685958f6f@linaro.org>
Date: Tue, 26 Mar 2024 09:07:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virt: vmgenid: drop redundant .owner
To: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org
References: <20240326075337.55377-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240326075337.55377-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 08:53, Krzysztof Kozlowski wrote:
> Core already sets .owner in acpi_bus_register_driver().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/virt/vmgenid.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index b67a28da4702..8f6880c3a87f 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -88,7 +88,6 @@ static const struct acpi_device_id vmgenid_ids[] = {
>  static struct acpi_driver vmgenid_driver = {
>  	.name = "vmgenid",
>  	.ids = vmgenid_ids,
> -	.owner = THIS_MODULE,

This does not make sense and is not correct.  I need to fix
acpi_bus_register_driver first(). Please ignore.

Best regards,
Krzysztof


