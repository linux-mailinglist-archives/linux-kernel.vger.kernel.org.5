Return-Path: <linux-kernel+bounces-60847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C787E850A1F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBA1B21C20
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389215C604;
	Sun, 11 Feb 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5UFN1JD"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8AE5C5EE
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666318; cv=none; b=nFxxV3YcYW5xR7ycaJC8HDAwbWMwJFW1ezrKA2H9jTM83CQ86vvFBSNW2jQ6vTwaO2lI8C49PGTYZR8zWcWDQwQnZzXSpSFxjDjDtzZ1T7tqx4LZ+yI2n/FpNMfPWkqAXy4WClMcUp1nWRwMRNaZRhqr5ZfMdoIEJA4yxGJo2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666318; c=relaxed/simple;
	bh=J3VHrNI6yvu9s7wb/lbUu2fKIA6CGAMVkWF7BQi7R+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQU7RqCjBAOQCmc7N4JQ69HwCqQ8nhOtxdshVix2wvxUI6ES4W72pvT/xkjvUzbnusM0GDKVdR5crY0vJ3u9EmMEgLSUnpAy7E02AFzn4mdrauKFAnNYmdzlP8efv40dcj5Sgqem0JiCaOZWeAZXhkjcGGgHLPhv2lxkloKERQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5UFN1JD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so1671843f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707666315; x=1708271115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3VHrNI6yvu9s7wb/lbUu2fKIA6CGAMVkWF7BQi7R+Q=;
        b=l5UFN1JDTPbYOI9hhfeartI6hauIXKhADKzimQSxjwec91L9a84Y/LbpKxVAIKz2QL
         1uLsa6QRrfjHAj4xB+Y43PubzKQPaWMS0VYCuiqBZlSuhrkvhxOJZ/UDkJfd9kE2AT7K
         DsEVWgwrYlF59gUeOm8HbSHasjt7n9mfEoPnU4AzaHFgZYME13D5Yl6bAZwo45VmBui6
         552GimqE9mMj5YxmDkF9cXxEzMcMoOuAYNdWQCMdLftfDFBfOPsHM+2DtKoDM8HO0UB1
         0a8u/Re2uw2DgTnoMKJEq3B4E7F6mlC2yz2fbZU8/7QhwEa/QFiBMgCRuyrdNeWEWvYx
         a9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666315; x=1708271115;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3VHrNI6yvu9s7wb/lbUu2fKIA6CGAMVkWF7BQi7R+Q=;
        b=CyyZ/u/QwYkQ+zJMU0kPjkpQmY0NWM0ZBJj+TJKj+WSKNaLgkBwM5021bNC3IGsGa0
         7sFY084LD5J8fjDnfYD7XRUq8+2Pk8zKIufg34bzmOeKjbuu3ZfOH+kH+cSpQJJ0wGSt
         eoK7U6Eb8WFNFdLJb2HNdNM6oGKXgXVo69OT0tQ5dABUesG9BSRcxZ1ytuRCBH3CBsc1
         4vwpyheUhZuCcnPRaTzM2KkSn8pcvBabi832aRaXw8bAffmN0XAXJj8pg+Imlx2g2INP
         LWfFN5TfarTFvak8EweJF8rMS86IUkT9Y9OZaFZo165m89jOTFTGWYQWAcdXIlTqIxuH
         /iFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOA6i/c7FzHbW/wfDXbTbqhoSWgr2I7FSejf7XeEDgQ4Y5nDSBOqczyXdkLsheDHs0KPV1n9Kkd8jXk8/mQ6g0VnyBEkbvVZu2qFQS
X-Gm-Message-State: AOJu0YySnq+cGenLEI44czPcj/HngWLjWc+Ei2dsS4ckB6NdaqE6ZJCV
	pBWudCT8SsWSqnxo8oNAO9PoYgTTMMb1oNkcKN8PQMkWrM/z7FtQfwl0qrdcxlc=
X-Google-Smtp-Source: AGHT+IG//CCGZTbsIR11qv4QGayQqc0b2KUMqCR6hUlo+b0LKlb0pQ49mwH1/hUkfjoeTeFRp+nm1Q==
X-Received: by 2002:a05:6000:118b:b0:33b:38ce:9e13 with SMTP id g11-20020a056000118b00b0033b38ce9e13mr3301728wrx.41.1707666314813;
        Sun, 11 Feb 2024 07:45:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPoKgtPgEo7+SEt9sJHMThg8iRPkRDg7CqKpiQghWZuIatjPqizZCxrbveHGN/L/S4InV5ufoi1fVHm+oISUDCr5ehSjPNoThu28K/bI9PAjJtT+NpV6DoWcR8eS8OBgAo0rKOwRrLe9n3kz01zxve7+3R0mu6cS116FfWWsqUlxRGJiUZB3yh3c4FI7C4hxpYGqKO2dZvl1UTCyRF6dhzbtWFzaUMiHu7RzPY38Hv8Bd77uCVBNlUxdEJ
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id l21-20020adfa395000000b0033b3ceda5dbsm4544166wrb.44.2024.02.11.07.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 07:45:14 -0800 (PST)
Message-ID: <a51701ca-1b64-4716-b51d-59dafaec62de@linaro.org>
Date: Sun, 11 Feb 2024 16:45:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: s3c64xx: make s3c6410_subsys const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240211-bus_cleanup-arm-v1-1-5c0102bda0bd@marliere.net>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240211-bus_cleanup-arm-v1-1-5c0102bda0bd@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2024 16:41, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,

This "Now" was confusing last time and is still... There is often no
"Now" in multi-tree-repo-approach. If the patch allows it went through
different tree, this is still false. If this was already merged into
mainline, just say since which commit or which release.

I raised my concerns last time, so please fix all your future patches
after receiving such feedback.



Best regards,
Krzysztof


