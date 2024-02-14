Return-Path: <linux-kernel+bounces-65973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6F855496
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F6EB26AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CAB13EFF2;
	Wed, 14 Feb 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0f78tbG"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8A13EFE8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945425; cv=none; b=loCR31ythcBQldXzrgXPp8zdKSx+Te/5LSk3TIuQ+5J1ppsx5sHLrrR+3Gzmr38ggw5UrKfogTBG6zyrRqbBuPRB51b55dz2Hdy+jFe+543PXPbOE4dCUkIczesOb8JggRka7yBGEjQKpFWL12iK/TDN4B2GTV71kmr+nvll4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945425; c=relaxed/simple;
	bh=9ik5hGU43C445XfS3B7kFnzkAX2hpzkfNLNcFsBrlu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLZTwQwy5PYachbLOR93YpWFa7REOUn6dnm05s4U6XX/aIQbpWW14w1dzWQ5b0KG6fnMzn5ylJy0sM9lmdx/4sC8LtKyvZj640icPcU3WSg2bJ5cqS+GdR8Yvvr64FAu6vwnI6W4+H+GIPlrixdveOVsqGkNTa2P4xzdajm1Es0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0f78tbG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d6ea28d46so89694766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945422; x=1708550222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vDG27qbGXDXotWt4r5BxMuF8Z5aqGlNS7zowiQwidN4=;
        b=R0f78tbG022MA436lNTB6BJee5lMq/xFznJhj4xsTYJH+xD5z9v9P3AAjN0RP4luM7
         nfWPAjIgdRzjw08p4lA7FYrY+WHFHeppWgNT87Rxz/B46QqxoE8GnV/vjZ7cacDUbQ2P
         vIVAppbs5YXIrIukp9RvqKCPTfBNoZNEeTUG4jZcM0zL7Kn/t4S/CR135MxLDo8vWWDt
         qZNJpQ0fs25AlOkk5wq/8o0yX9M4cfefnrWA0sRlXJX6KCUVsc3wlXmG6SRYhzD+eze3
         UdYR1shyhwzNR3Hd4wk42qQGER1eM9VrH4q4BQWG3SiiB3pg0qsmNbXUZ/bWHIzNPYEY
         hDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945422; x=1708550222;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDG27qbGXDXotWt4r5BxMuF8Z5aqGlNS7zowiQwidN4=;
        b=lOHgY0eeVaAjYNreMFG8g2Rk7vdwSQ1gBayEKO9437jLKbm2P4mXxAmmudiOZdCP+t
         KPsGNkY5m2FUi8+3+LpLstD+gBt4cMEFEn5ha/TVwE2PdRjt2+ZwGqaR9WV40lZbqU96
         M1Wao6sOPFoNcyfCC967OxppVF7lZyztZ10AEG2Xw7K1uiWsZZetQqXNmFSfuIxe/2Mt
         noJUwwYys0thcx2r/bXHHMOPXn3BBCbO4E3eT+XyTpi0rXPQeFjER6KRTB4Qd7eP7/ET
         fpU7b3GqesZ0zep9Ud3ejYFaNv7cJoLL7GZv+OiEd7k1BxLpXqoeb9A+tnHGeTF9aBIG
         o2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXRaNI0CaoNAGne2bwGf2xnyqGABi+ja7UQ5ziLe8r5rPIAFDufWRvYsYzd41CRAYJ8ROq/foh8xeUdEeAoKyfDspYA2LGO3tJSYjU
X-Gm-Message-State: AOJu0Yzsn2LUNezVlsVVj7wjUVcpeD0E1pji9UMdO1XeuuZkmEQeRvEw
	BA4tQMzLscb3DmPjlQCraoK3SCLz018emV8zHzDx3Q5naF0HfA3ZICGNx/nOw5E=
X-Google-Smtp-Source: AGHT+IHghIYGSVV5nYIaOLJXpc5/fTKV6YwQnTrz41TL27HdJSrtwGoV0czzrSjRCJfQ0TEdc1kgBw==
X-Received: by 2002:a17:906:1c59:b0:a37:30aa:3cf3 with SMTP id l25-20020a1709061c5900b00a3730aa3cf3mr2416808ejg.25.1707945420810;
        Wed, 14 Feb 2024 13:17:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9JojA/QSHANBTn9Irw1tl3eWBE5j4Be+VBQKri52r1b7vefT6kTjhNI5Wx/tUpYayJ6v7qI3PoYYqmIqnvsxcTOKnoHUtKQfw7L6OBwB5/zEbTaCODiOHB8Sia5rG0EQmnTeZfHWo7cpfGfZUs+vLQADkyICJTWIh1ui+4CqWFcr9bQFgLxm+byuu4KDLns8/27Qwzc/JsZyBypk6Rk6BKbfQwz3snnfBATgpkif4C39+shswPLz49Ek9nQid1u98L0b4Tmd73h978/KLg4nDIMAxnZrCIWu6mfO9RcHV9dVFGFN5qqUvtPDP6oFCgm4LhpFGK6t5mNGbciGNys0e+a5aMC8RZcEoqZZazZRaqS6nxb0zEN8NZSXWhm0I8yb7opJ6aR2PWoU/F4MYqKPvQYZ8jTFZ/T62LTDOH9Ra/gffLvaAI9OMon/GStMHSC/1f6TTJTFhZwJ4WuZVCDKL8f/Roew9Nn4=
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id mj18-20020a170906af9200b00a3d3fde216dsm1006846ejb.217.2024.02.14.13.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:17:00 -0800 (PST)
Message-ID: <d9f88786-abe3-4826-adbd-fee461a70c2c@linaro.org>
Date: Wed, 14 Feb 2024 22:16:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/4] spmi: pmic-arb: Make the APID init a version
 operation
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
 <20240214-spmi-multi-master-support-v3-2-0bae0ef04faf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240214-spmi-multi-master-support-v3-2-0bae0ef04faf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.02.2024 22:13, Abel Vesa wrote:
> Rather than using conditionals in probe function, add the APID init
> as a version specific operation. Due to v7, which supports multiple
> buses, pass on the bus index to be used for sorting out the apid base
> and count.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]


> +
>  /*
>   * v5 offset per ee and per apid for observer channels and per apid for
>   * read/write channels.
> @@ -1178,6 +1246,49 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>  	return offset;
>  }
>  
> +/*
> + * Only v7 supports 2 bus buses. Each bus will get a different apid count,

"bus buses"?

Konrad

