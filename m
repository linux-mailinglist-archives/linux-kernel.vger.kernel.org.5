Return-Path: <linux-kernel+bounces-95073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E38748F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D574B281D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9796311D;
	Thu,  7 Mar 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2Yao/2k"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE938DEF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797411; cv=none; b=FsXUe4S/ztKBmEqfGQmgUc3xidpuEayd0hU8SlLW8a0PngAi8Ag521M8Bzple8L3b20NK/DRI4zR/mlcHCqgv7MojewUa6BwlU3bGXJV3NPrlcFtw5ZySFc5nB42VvVrojOcDKCUDw0dlcqpnWFk4Us2tDT5tN7Its0Oa/MPdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797411; c=relaxed/simple;
	bh=V+MJLmINeJZYOj13WgXTOX9YS6a8nVtlDR+xat9y+lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZREEqxOx8Sikaej6SgJuux1e5UjIUR1Blz/R0c6IvX9Ri84ZxjpdaO+8wyXqEOunEdUtoyjHrpPWYKjW2qvYImNRAR/jmIva6mQB5yzShPFbWxKOByu9RclvO7GgW9rANWZzioNl4N5RzKyWjYzD6sIse9Mc1gnDvzsoRp4400Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2Yao/2k; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44e3176120so79318966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709797408; x=1710402208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oOBdSHX2AlhED0D3jVxb7OLEag3yRxss4h5rOJfqNuc=;
        b=c2Yao/2kKAPeO/keVXhW0hRjNEnXw4lUwBAbOE42r4F5VSHbyar+ePm3n8nHVeS28L
         LiAT55dzWVo4j3i/QZ5apvS/Ogh2b6Qdqeo7avWaocRVZCdtytiw19wkRE1vWbSYWyrP
         GJ7urOZy97TEIyKOnFzb8bPPIr9PSCu5ekMTRTbhqa3zz2bfdDIMTjE5IZW9T/kwZfYc
         0zCNmfDAvosaHbPrNNYc+906FTKW71EcLAh36f3ZHV2/NP+cTup9quqLAZiXmiU1JhXX
         R9dAewJA0I26518GrMgekaeD4Xjk7ts+oqjXXN92w+e/8e0V2XUINq75hK+4eAhbD7xl
         ihXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709797408; x=1710402208;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOBdSHX2AlhED0D3jVxb7OLEag3yRxss4h5rOJfqNuc=;
        b=oOX1RG6UmdZCOfOln/+1v4fpx4pAvtfbMXTS/bbZDu/4GSchjTq9UNr7wMEsIDpgfG
         PkkpIH+t/qdFLcKjQECQlJ7kjmrC38TLCmaUQS9rYq4NQRKtADFMz05HqbYBiVC7W9sm
         8TUbM4k5Uvl9uK/fKYzcldkExSzTk8yaHJo6VRnBW3SUonenjXMz55OyG1gAsF9qeqI2
         pw9gxsT/3sMYp9s9G1XHL8MYRoLXloDOXi2lDWLrpogPtyipw7cazuDP50C2l2uX4fIr
         onzZmtQotFVfeXjtF47bbWw89AEwf9bYUaFfB4z1ndtEisWaoMlFyzGlfd+LIu6l4NQ+
         iUSA==
X-Gm-Message-State: AOJu0YwnsRUeqrT02yAAQ9QShCOPdBkx8a+q9i4VVmQJGG15zdMs8cKo
	wZn+xbjWfwKN77Wqre96gKQwDwLKr6nEiIVOh9PexW4aXOwOooOiWCbcXn1nFcdi99dSQnQ7i2v
	C
X-Google-Smtp-Source: AGHT+IGisS9aF8en2zq9+oauwdvGw9TjFLCEPp/RLyYeKIVFTfbB7ZbrZ6yhiSXdypoHVHtNdg3SoA==
X-Received: by 2002:a17:906:d8c9:b0:a45:a7e1:62c3 with SMTP id re9-20020a170906d8c900b00a45a7e162c3mr4516845ejb.70.1709797407691;
        Wed, 06 Mar 2024 23:43:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id an19-20020a17090656d300b00a4536b32ae0sm4450055ejc.30.2024.03.06.23.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:43:27 -0800 (PST)
Message-ID: <d1369ede-06f5-4307-bd93-86b00ef08701@linaro.org>
Date: Thu, 7 Mar 2024 08:43:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: w1: Remove w1_gpio_platform_data
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20240306194629.356001-1-ayushdevel1325@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240306194629.356001-1-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 20:46, Ayush Singh wrote:
> `linux/w1-gpio.h` was removed in a previous patch and should no longer be
> needed for using w1 gpio.
> 
> - Removal Patch: https://lore.kernel.org/all/cover.1701727212.git.u.kleine-koenig@pengutronix.de/

Do not refer to lore patches for commits which were accepted. Refer to
commits (see submitting patches).



Best regards,
Krzysztof


