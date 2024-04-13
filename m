Return-Path: <linux-kernel+bounces-143859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE438A3E60
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE88AB21149
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17054911;
	Sat, 13 Apr 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ir1RjVBh"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DD5644B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039193; cv=none; b=G1ENpB7fbsPy4fT7eUTSz/XzShGrY40ncxeyMEQJEAKX4hv+aJqAQyDsfWfj8Smj7k8MRxog+K7yw/wAbAHjQwOEfuPyUJN4w6vn+rrrA2zETp75i1TpGNXJxXFxFr0ierq5xlpk/YBw3j8G84T454MfXo3d0z55++nkm07N0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039193; c=relaxed/simple;
	bh=6An0L48kYFjflh8FlJpVAhC+mhCU5vKixogNl4dF0Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6kGLEWL93oj1zpvHk5Fcwu3CB01dbM4262ouGOpSlTfWUt1yIyDosA86QtjnGOvMQX1TFLY9s8oSuvN1EoaefQOt6bZH3l5RrkJJIcydthYNvkZYvPl12nXYOqculAtNfIMr8dWk9oQHn58kz89HSx73ZLDB6feoojel7nGYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ir1RjVBh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d8764656so720904e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713039190; x=1713643990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c21Lbybh5bmPv2qzfkq/dwgMQUd0Rl2nuEZhArPPfjE=;
        b=ir1RjVBhYTpya0sQyy7zJMTQJwnyQ+iZZyW4z39MvEansbjihvqYYBTix6lm1e7eIy
         BaIwCxyjSmb2nDJdnA8mqUFwhkbQpC1DKG+EF+UwdbXpO6VQDNX6Oir4+1kGQgsbJXFU
         AhPH3CMpMAuMaqovpQcGdpU+KOoYaqUWMjd/EM9MBnhV0gYEkdooUJJUu/vIHv+eb1nH
         R1EMPyjmWaIUEntXFRGJgt3LDPhEx9+uJbgV0wqIDybXk7mZEbaII3Soak1i24wupgOV
         Pq++HXyW2S/xb9FyThU7v2s9IpaQC0SmqCUP/gZJXWq/7rYNASpiq3aO8eqsZYFJ+WkG
         MZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713039190; x=1713643990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c21Lbybh5bmPv2qzfkq/dwgMQUd0Rl2nuEZhArPPfjE=;
        b=a1Hf36eG2eW2ezLjK4nnR8BECVsl1w4Zi1HHsLyuy5xQJeG6mo/71wi1kxfYTbh1+A
         armyvJvefQna5AqMcFI8BV2zFAOjJx+j+Gv5awS6M/Delk7gGYnklND9VHbXluQwQRqj
         8MdBPRAN+9d4RcBgMM63d4H3gFgOVGMptfgP/zV1jNAnWyNsN4k9ICyvvOG64oB4fWGN
         Gb70qjqzz19qMuiwliRB+p1HA1/R+RcGs9TrQdRVGZmmyyt/HGJshHNdZO44xrIijwWV
         0VPg2sRqjzNuWBxgjhtd8In7qQ8OwGty2SmNUr35N8D/XomY457gOtsrIS1BqGLZQRZj
         n1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWuMErOujOEIOXDmZDpi2G+1fN5J+zlhgCKnJYU2pGt0PTBnP3ggSCuRO5VOVr9ylD+W/k2imzJvI/D+uk3b8yvD4uXLqMIGqDaODPG
X-Gm-Message-State: AOJu0Yz7rTRIDhmGMDcn1xYatSCjJ9vaEfzESX9k293BsmTHl/WX5V4P
	ILuyn1PgXBSVLq9RRyjVvLjCqZcYomqcCKkfBAdeHDDVWD78uH3cno+LT/KZNgw=
X-Google-Smtp-Source: AGHT+IEJIzEdlJ2h1Ko7lKjyl2QgL2RSUc87dFSTgw5U3NIFfqQuNFJckIWYYM5uOg82JI6kCKNPWw==
X-Received: by 2002:a05:6512:3d1a:b0:513:ca5a:e9cb with SMTP id d26-20020a0565123d1a00b00513ca5ae9cbmr4541232lfv.4.1713039189663;
        Sat, 13 Apr 2024 13:13:09 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id b17-20020a0565120b9100b00516d1afe4f6sm362963lfv.290.2024.04.13.13.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 13:13:09 -0700 (PDT)
Message-ID: <d689cbf6-d7e1-4f8a-94d9-fa2e0b8ecee3@linaro.org>
Date: Sat, 13 Apr 2024 23:13:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: i2c: qcom-cci: Document sc8280xp compatible
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, wsa@kernel.org,
 Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240412-linux-next-24-04-11-sc8280xp-cci-compat-string-fix-v1-1-7dbafff36932@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240412-linux-next-24-04-11-sc8280xp-cci-compat-string-fix-v1-1-7dbafff36932@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryan,

On 4/12/24 16:53, Bryan O'Donoghue wrote:
> Add sc8280xp compatible consistent with recent CAMSS CCI interfaces.
> 
> sc8280xp has the following clock list and so requires its own compat
> string and sc8280xp specific clock definition in the yaml.
> 
> - const: camnoc_axi
> - const: slow_ahb_src
> - const: cpas_ahb
> - const: cci
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
> Initially I added a compat string to yaml and driver for sc8280xp but, it
> was incomplete and wrong so I asked for a revert.
> 
> Subsequent to posting the compat string I had posted dtsi changes to
> sc8280xp to add in the CCI, forgetting to follow up on the compat revert.
> 
> I then completely forgot about the compat string and worse still
> misremembered the whole reasoning behind it.
> 
> This one patch series cleans up the mess.
> 
> - The fallback compat qcom,msm8916-cci hooks the driver.
>    Since there are no driver changes specific to sc8280xp we don't
>    need to add yet another entry to the CCI driver.
> 
> - The compat string qcom,sc8280xp-cci is additionally declared in
>    the dts -> compat = "qcom,msm8916-cci", "qcom,sc8280xp-cci";
>    The sc8280xp-cci will match the yaml and enforce constraints.
> 
> - The yaml entry for qcom,sc8280xp-cci constrains the list of
>    clocks which is specific to sc8280xp-cci
> 
> Result:
> 
> - No new redundant compat string in the CCI driver
> 
> - DTS is unchanged
> 
> - YAML expanded to capture missing string
> 

I believe it's excellent, thank you very much for the change and efforts!

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

