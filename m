Return-Path: <linux-kernel+bounces-21297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC369828D35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571242822F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164ED3D0CD;
	Tue,  9 Jan 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYUQvtQL"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE133D0BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3375a236525so2950086f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704827824; x=1705432624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nw8bo6HycPIUh7vFJ/CIj/JyyWCNJbpjHcGtT85afhY=;
        b=jYUQvtQLSCe3e/aRpuyW56o7yOEDXop81DcaeDgjNI7ZhvgVcoV4fhsAG/V5Tzj9lW
         eDS9STXqhLcgDMhjFSeb9qNaHYPFUhUybay3XPrcvQzus4p2PltiDIOMr4xECoTOu2SY
         nfRkX/YSAeo4y0kGOyAf/n0q4r1QFeHvmufFUBDvCA44sjw6gVyrNjlWWJrowH3gXdv/
         7KACZMCw2T+nX6Rs4aHasu6gitPfrG/L41Dbfdyrev794Mmec32nGnRNUYHgwvYG2xwy
         p02HRA0bDSnc6f9OWgRHtRAn9qbCkEWJtegzxAjFEzjNqwONMlNJERb/ofV7rdAywzty
         OZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827824; x=1705432624;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nw8bo6HycPIUh7vFJ/CIj/JyyWCNJbpjHcGtT85afhY=;
        b=NOr8mHNdPRiQ/t+MYjT9acO+OTXnZuXEd796nNaAxPoVmxqCsieZryKvvXYkECIedK
         I1Y2W6gORScJ/ag5qYGGBrzJzos/UO6JZMs4g3cd6+ooEkuO2XX87AqUQ+rEc40XoRFF
         EFvHAs9hdZu624g9+wUa4ADzfdWNRRUHOh3gjooQ54FYmJaRQ/3E/yTIv7MLA/b+gqVV
         Wv3PdRLdXyP6/oMvuN6Mh9270MLQBl+CFE2wdk1YTLwZgyOO2zC/ieWl1lJ7baXQoSst
         C+zOsmDOgwXIZnstdhMF/vG+Hc6L6f8SfcJO7xJ/8u+mcw/AtbepfM4IibgPiZJNEdJ+
         5xyw==
X-Gm-Message-State: AOJu0YzzI8ttk87AQN9fo+z3vEfjAvHL3l2kJm74VnTD1yYULTSdR0U2
	xUn7Rf65fSjOe/jVsLuliY1lQSqvZpzEKA==
X-Google-Smtp-Source: AGHT+IGzh3R9C8fYtSFIq6PDEsHbVKq+wJE4DnL2GUvNk/3Q7MRX9zo0PKlVWDPH4ScJvs2DLGpjng==
X-Received: by 2002:adf:ef8a:0:b0:336:6377:6e3d with SMTP id d10-20020adfef8a000000b0033663776e3dmr1013411wro.66.1704827824061;
        Tue, 09 Jan 2024 11:17:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id j17-20020adfea51000000b0033660f75d08sm3073785wrn.116.2024.01.09.11.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 11:17:02 -0800 (PST)
Message-ID: <d584255f-87ee-48a7-869d-e2a0b40a52b4@linaro.org>
Date: Tue, 9 Jan 2024 20:17:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] dt-bindings: gpu: Rename img,powervr to
 img,powervr-rogue
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 "H . Nikolaus Schaller" <hns@goldelico.com>, Adam Ford <aford173@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?=
 <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Paul Cercueil <paul@crapouillou.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-2-afd@ti.com>
 <11e3afae-76a7-4ebb-82ac-3dca040710dc@linaro.org>
 <d0c242ef-bb8f-49d9-bbb0-7922db2c322a@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d0c242ef-bb8f-49d9-bbb0-7922db2c322a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2024 20:04, Andrew Davis wrote:
> On 1/9/24 12:59 PM, Krzysztof Kozlowski wrote:
>> On 09/01/2024 18:19, Andrew Davis wrote:
>>> This binding will be used for GPUs starting from Series6 (Rogue)
>>> and later. A different binding document will describe Series5.
>>> With that the name "img,powervr" is too generic, rename to
>>> "img,powervr-rogue" to avoid confusion.
>>>
>>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Reviewed-by: Frank Binns <frank.binns@imgtec.com>
>>> ---
>>
>> Why do you send new version while we still talk about previous?
>>
>> Please implement feedback from v1 (and this is v2, so next is v3) or
>> keep discussing.
>>
> 
> I agreed with everything you said in the last round (RFC v2) and
> made all requested changes. Did I miss something in this version?

The recommendation is that naming of the file matches generic compatible
and your file has only one generic compatible. Therefore I don't
understand why you claimed there are multiple compatibles.

Best regards,
Krzysztof


