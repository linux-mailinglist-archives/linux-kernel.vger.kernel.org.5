Return-Path: <linux-kernel+bounces-98327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57C877872
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38011C209EB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B719D3A1DD;
	Sun, 10 Mar 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZLyaMJz"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F673A1AC
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102355; cv=none; b=C7jQ2Ura/a3qK75g4gRUcoqNbXir6DL7jnSFpk9XJXjN6VOI/xTFHvst4RMSbgiZpjqppiJ9Eq5MpnYpQPcASybn22Myz2NaIxcs72WEbWGOC2Ng2DCkf6VlZ4ZUHKXpj7oIfuqDkdy9qFD7KgThQ1c0+m8lmO66T5xqyh5eoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102355; c=relaxed/simple;
	bh=EYjGNNG8efHsMEdoHDZT6FK9wsbSPSnLAW4TfAbv0fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaQlJgLJyRN1v0j1lA0vVN+nRIXURe5XLMk/mMQ4qwcFZsFsuT/QYGkt5KE1ENSL6iovhqUV63NPnYTHRwcU+8zZxyZPD76NCdhcpErm9V1l/vz8ZsLWpG3X/cq3U75EyOC9gSnGDPdMViWbnNA9bO25tbEwQvStHFUg/VdVHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZLyaMJz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132953e130so2412145e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710102352; x=1710707152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EYjGNNG8efHsMEdoHDZT6FK9wsbSPSnLAW4TfAbv0fA=;
        b=OZLyaMJz8QX5LSj+DykDQ5tgRwsKFiSoK2qbzTyB0hlAuKsWIs6dBA9nphuVdtHF9y
         Gut2wx2yJOQBU4kqj41hu1Woc7alIHLYdn/9L449KRUIZ4mamB9D6IIIf+XGnUog3NSc
         APQppyQhVbha66s+IQnWUTNAZupEdVb+r/WLpiAlF9eo5U+5/Dhq9ub7c8VIkXOpluQz
         RUnyRop/FreEkWlblfRJGlWRO3tsyr/NdUWIfBc88E8Cq+tK+1OIiKke29u03GOo9q6U
         wTUb7/tqsquRujdtd8MfzV6fkxe2G5zk+uqhHxzpPR5oGJJgqvqahxUN+FmwTQmZMxVi
         sAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710102352; x=1710707152;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYjGNNG8efHsMEdoHDZT6FK9wsbSPSnLAW4TfAbv0fA=;
        b=gKHIRT/ElNp5RLPDSGrXogHCdIcCnSbVUZ4I86oJbAy1Y1gGLPjh2J1TMrOji72BqS
         DGoo3/7A2lqXBQVItlZgxZfCXy/uxLtnHSBUjsPXfFPbS7Fit5EqQQ/KXbaZD0Tu4baJ
         qOu2ag/Oxk2kV2cIA7runravQcw9YUPKPMrVQgmMOKF72n2lpo9LQukmJ/uouwS5wxl4
         LCgR38XEJUQyx5Tuus+hnbYEGvQsJjo7Qk6gg/YsAVh7KB+28KQE1x3Z+KW7J9b1rTqb
         xf7hlp0wec5HAPOytjRasKuwL4TEzyiNC1hH6CLGUZoI+ayh3D4WF3pC3T9O2X7uvbAG
         CdXg==
X-Forwarded-Encrypted: i=1; AJvYcCXxcW1Nj/fHfkI+EAE3W8XO8nffehX7Bp2IWL5gMTInA0eD6BpQFrXgehLQE9hK9JR0wp7JaDvTmBi63LJCZ4dCvMPeAAR/Z8Or8vzJ
X-Gm-Message-State: AOJu0YwpODeSadhSlkR5+73ztLwa++nl2GZU689BKhfI0b5/VvKYrwbc
	o1tGbJKb5Mn1n1thYcdHDOusutU+yYtrsaVXeujUmxdEjxSoHur24Gx5UN+b3GI=
X-Google-Smtp-Source: AGHT+IFGrgq6LscZC8VYgp6hL5B+n1n+xj7P5oW/LKOqa2kOw9GOFPl1TOg/HdruezS77OMunL1OZQ==
X-Received: by 2002:a05:600c:4515:b0:413:1319:a37 with SMTP id t21-20020a05600c451500b0041313190a37mr4485706wmo.41.1710102352225;
        Sun, 10 Mar 2024 13:25:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0041312e8ef2bsm6745898wmo.26.2024.03.10.13.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 13:25:51 -0700 (PDT)
Message-ID: <ba834984-d0d7-4b46-81f6-5a2df8e74944@linaro.org>
Date: Sun, 10 Mar 2024 21:25:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: imx-pata: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240310171958.96388-1-animeshagarwal28@gmail.com>
 <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org>
 <CAE3Oz82coV5RgcRE=Lj5mm2kjdzh3iFJGpMBBw_OfZppfWAHfg@mail.gmail.com>
 <d609c172-2bb3-479a-b5f2-841aed455bff@linaro.org>
 <CAE3Oz80zrnLvpo=YdBA-3PAtJFP8KK4LGHpEpQaMCacFFG13Qg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAE3Oz80zrnLvpo=YdBA-3PAtJFP8KK4LGHpEpQaMCacFFG13Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2024 18:51, Animesh Agarwal wrote:
> On Sun, Mar 10, 2024 at 11:08 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> I did not say about subject, but about commit message.
> Ok, I'll add commit message above the change log.

What changelog? Read carefully what I asked you few versions ago:

"Please explain the differences done during conversion in the commit
msg. There was no imx51 compatible in the binding before."


The differences from conversion. There was some binding in TXT and you
convert to different format. You introduce changes beyond pure
conversion, so this must be explained. Again: explain what changes are
you making *to the binding*, which are not pure conversion, and why you
are making them.

Best regards,
Krzysztof


