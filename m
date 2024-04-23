Return-Path: <linux-kernel+bounces-155595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C08AF49A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB621B242E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669B13D61F;
	Tue, 23 Apr 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJqXzxJT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1991E898
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890956; cv=none; b=Pc4oCDGGQ4FSQiksYHn/iC2DaqWN/IFjP3ZyriEJn1HuOr4zAIG7CZSegQB80QZBONRfEuN14u/7CouLMPbFjsVldn+a+QUHPqC8GJWL1nJCXSSfyLDSA7Tye51tuL4ZN28eNyYo44FJP2z33vnn832OSGWkdRmsiRY2aRFf2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890956; c=relaxed/simple;
	bh=ldVzTwv3fwEiTXBi6dYuRPKuiRpDDdt1y7A0qo9Q2QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEVPKrJ6WAmoy5hTLWAc3zoTY7RqQpBes4D/A/hz7pwYxKkMNR38PcraS95wOS/ibefqzcRtlmn3b9b07M54csVKo8ztmzA0zo1wjnAnXEUaqgu1GLkXjQMfw7tFBJd/AQulcJseU8oRxR5ZMcpZb5hjRxYdGzqqep/ZzzkYkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJqXzxJT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff00so15112585e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713890953; x=1714495753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldVzTwv3fwEiTXBi6dYuRPKuiRpDDdt1y7A0qo9Q2QA=;
        b=LJqXzxJTRNDrHx9LQ1+C+/IPem1dbVrCqOUDX5bhqfDgMtzHOoopq52gzWru11PHZ/
         1UnliwrVtmzmorsz5YPSU3SlPlDjLXaxVmY9KfLg7QvowFS9B7/z+wxKYdu8NQEzEwF4
         nn9kfLOemMNUn7TK1gtgKK6OLjwLe4xJ/8evQ8Kk3h/mj3BRWBPbZJyiAsfewxJyQBhm
         FuEFVsU+ZGDl7ozAfXnfBkz9g9JOdfOLFofaSYZM+EL1x6QT6tPrn9x9EtVVuKhFUwaI
         nmfe8UzhkxwLYPmNK4PSAe3QTgoAgeTI8TmJH7nWhav0FUP08AhckZ8KYiVidUEEes/c
         yChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713890953; x=1714495753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldVzTwv3fwEiTXBi6dYuRPKuiRpDDdt1y7A0qo9Q2QA=;
        b=OMwmgk7aJ+O97OYEwS9TpgbGur2D6WlOikLkKVqSRVjDBg1CB6A8A/2YTEj0lMnk6M
         RfrAe2ZsK9V6tcgDmCmBG6wHfXZ94g1wWtlXSSei0altkBegd/z2taVAPGORDCoQ0qTj
         drrB77dZAtknRuoUifx2lHFmOnj/b81nYTYDI7GcLrUGLvGx7dqbjr8a4TJkkCKPAIVf
         zLWJArXamqncruesUi1otNgK5Dp8N7c54vjWkHsKf01ifa6KEgiO2sIqJxUMCQvrAuE3
         Nj0phoVBq2pHmgXrhc8VRQuu2j79wb8CvLfuNPawdxE5W/XU/UoTxokp70VZ+U16BwCf
         PIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvnFwqliCuazIL6SnIb41rfBZxZ5liHebIFkDX0CcQaeFwWHnTJU/wMNsSJm7o4vhoOzLjXIBON3+2vFb2jWHDW0dv1pgqN8N0nbvS
X-Gm-Message-State: AOJu0YxU9Yp4YOBEPteg/TOD13EcK3AhhD7RRWVrS9y5V5tZ3/30LNtJ
	ZWNowyoBED+pmzXTYOjS4CX1QdW2U1cutgvedZgAHodtTptM8bTI7GJx8GOPmiM=
X-Google-Smtp-Source: AGHT+IFFjiX0lGTvRX6PkqniQZmmmeygPyoAEul4datqZN6BwlChbzsJP3H/9AAw03G7QKIB4ZDERg==
X-Received: by 2002:adf:fa88:0:b0:34a:d130:611b with SMTP id h8-20020adffa88000000b0034ad130611bmr7093753wrr.17.1713890953167;
        Tue, 23 Apr 2024 09:49:13 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d67cc000000b0034a51283404sm12576954wrw.72.2024.04.23.09.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:49:12 -0700 (PDT)
Message-ID: <81770681-7ddb-41b4-8202-8dd44014c5e8@linaro.org>
Date: Tue, 23 Apr 2024 17:49:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/35] media: venus: Refator return path
To: Ricardo Ribalda <ribalda@chromium.org>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
 Abylay Ospan <aospan@netup.ru>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Dmitry Osipenko <digetx@gmail.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Jacopo Mondi <jacopo+renesas@jmondi.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Pavel Machek <pavel@ucw.cz>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-26-477afb23728b@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240415-fix-cocci-v1-26-477afb23728b@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2024 20:34, Ricardo Ribalda wrote:
> This is a nop, but let cocci now that this is not a good candidate for

*know

> min()

But I think you should change the commit log ->

"Rewrite ternary return assignment to mitigate the following cocci WARNING."

> drivers/media/platform/qcom/venus/vdec.c:672:12-13: WARNING opportunity for min()
> drivers/media/platform/qcom/venus/vdec.c:650:12-13: WARNING opportunity for min()

then

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

