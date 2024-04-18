Return-Path: <linux-kernel+bounces-150564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90218AA0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA6B21A75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAB173341;
	Thu, 18 Apr 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EP27Qkuk"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B36171092
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460841; cv=none; b=lKniKknxr13mdfmQgVbNBySs7cuw3hijsFd1F+aPO1LGf1y6JZVV2wuNtbgu0uo1LMcxjeZC9GXORbgqzQ1m2MJQDe3ggNJLpyps8CNY4sWuUDwVlxpx1fOApSHtvZVo6bvq1v5ml83h7lAOvMD66cKGv0h5iYyEKYvBBkZB1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460841; c=relaxed/simple;
	bh=adcR54Z9DZVpBzK6ntoYoyiLSTTmJ4moqkg3bo+b2Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYSdla0gKMuEgFKwmPTXxifibZ/w08VRxZc5jepR/uNNsZA5JcgquBJ/mIN9G9DM5rK6Lctv5iWCk7EwobfTOfrzQPAcoqHFcntAi8rW9JtCkLXicwG8N4hitkPTsPvXDi1SdB6E8orBVqIeBYymXErVkOqN43s4YssvDOyngUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EP27Qkuk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso1068692b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713460840; x=1714065640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R0tTCVfuOTVf+AXQk7Hj0zzAFRBFs2j53Yh4kAjxuk0=;
        b=EP27QkukJ4IrGgUfa8kQ5gJsukCM4HgagFsb3YUKYJXlcpcdckdsoVOUlvA1A1ER1b
         0h+E+Ydldtr3zwgcnL44NqkZJmWDQTsBSkdF61qHrnSFK5CNk/mAA9GuxKVL5XAYxSt1
         FSBISCEXvNdquMyHPqoMnKnokbDHGIGYMUJGlLUBltKV4XIrK2+wqMJVRcXNR9pYKmOA
         A3vwShcknPkpfZZRzMSRpDQqPsDmLo2z+jADHQbNKAjHl6x5cM4wcXqIMayrp6c0yVoJ
         sLlQj8zuQiyeyDMY1tiUTBqohp5Oe75yEYwLMCE4gWiHqfWRAIaRL4OM9cHSl1E2Vqmr
         6nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460840; x=1714065640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0tTCVfuOTVf+AXQk7Hj0zzAFRBFs2j53Yh4kAjxuk0=;
        b=q9Acu2swhXTICAewrKT9eQdVIEvESCavqyynCo3+/tn8v4B2Xx/nkFJOEziAWVJ1D9
         aPCIHj/YWBJOwOJEDhu+V0GKrmppweCLbldBuGgrCU9U8fjgIicwCto1eUh8JRnWlV+M
         n2vu2xfknc6X2/HoN1EAmTvB7Wnjb5EA2cJcKgU8S5yu+Dq8RxDxw6QCyWIQHbuQ6uOZ
         WG9CUYAMowaeWdS2WKSUOdU8wuZQZTDURflTeaxg8Y+WyDsoaWS2HvQHcCeomLA1agVF
         y99PrTqxI9jqR2rnWvKc+sp+3eOgbPibVk5TBbuSF8WWd/+f2Wmdh7tuisTrnze9LSQR
         Tw2w==
X-Forwarded-Encrypted: i=1; AJvYcCVLZZTnF1SU7P3GwkqY9EAxk+mNhYvOXN3kN+Sq5Odtd7hcGWs42JbC9Aty6PcD1N5btjQMSD9im9uZ5DwvWUb1AnvrMfNZYw8H30H9
X-Gm-Message-State: AOJu0YygiwaEhgjsd9rRXkNFZvdcZitYs2ujFJSce/Nke70UO/ssS9CM
	imM+PR3W2qF+FY/IdN/RkHd/PClFENd9yYtzR/HVbU9O7n6nYoWFRNhydgt8lQRw9qOA92Wz1qN
	1KG4=
X-Google-Smtp-Source: AGHT+IFNu9n3qrB/TwWrOE3bJqly+MrUOWWcCeO3tOJMkWxuujvWLHHCbJgnJYPMgEOY4c2iwpMQ2Q==
X-Received: by 2002:a05:6a00:21d4:b0:6ea:e2d2:5e68 with SMTP id t20-20020a056a0021d400b006eae2d25e68mr4280669pfj.27.1713460839643;
        Thu, 18 Apr 2024 10:20:39 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.148])
        by smtp.gmail.com with ESMTPSA id g21-20020a63e615000000b005f75f325db4sm1672670pgh.29.2024.04.18.10.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 10:20:39 -0700 (PDT)
Message-ID: <2cacd701-1746-47a7-93b4-97314c3d515b@linaro.org>
Date: Thu, 18 Apr 2024 19:20:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/panel: add Khadas TS050 V2 panel support
To: Jacobe Zang <jacobe.zang@wesion.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch"
 <daniel@ffwll.ch>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: Nick Xie <nick@khadas.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "quic_jesszhan@quicinc.com" <quic_jesszhan@quicinc.com>,
 "sam@ravnborg.org" <sam@ravnborg.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240415031408.8150-1-jacobe.zang@wesion.com>
 <9df035d3-438a-46d7-8fba-183aea84023a@linaro.org>
 <TYZPR03MB700133DB7CF443D0393EC867800E2@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TYZPR03MB700133DB7CF443D0393EC867800E2@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 03:14, Jacobe Zang wrote:
> Hi Krzysztof,
> 
>> You must say that you ignored/dropped received tags.
> 
> I don't know which tags you mean and where should I fix. Please tell me in detail.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Also, please do not top-post.
https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/process/submitting-patches.rst#L340

Best regards,
Krzysztof


