Return-Path: <linux-kernel+bounces-22546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0707E829F78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC11C22B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF0B4D107;
	Wed, 10 Jan 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvlAHQar"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981874D586
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so5304976e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704908535; x=1705513335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjMoBaJslgOWw0PjOC5tF8h+iRVzEHZGeY/kRdR3+Yg=;
        b=dvlAHQar4GJFXERCWrckZBE+0/jIA/JuiPUZ+D9LYW/z8sjehVt5ikv2jAbFLfGWva
         Nok8C+TJGceViM8MV0U+lAhcfu8ynjsb6UQzAUDclqxhzf2ue4+IwRUVlOJKz62j1FZv
         +u4vX70sDB7DFWtd3Bbqy3Hr1A0sqfMO0tM0h1WxYqcV1oeEUVF1oA2yFmeKoiPl3jm8
         7SLgfCVkKzedKP3Gjzp5BR/5zRcEUd3qiWQh2vB+T7YG5oGyaTPE86ld9q35MymA7R92
         PvnIK5e1/ok7F630RQk3EKGYOgInhF0Ezc1s01209DIkeKpII+m3cdiMmUGxXPQfzKtz
         neuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704908536; x=1705513336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjMoBaJslgOWw0PjOC5tF8h+iRVzEHZGeY/kRdR3+Yg=;
        b=LxJD6Q2BcOnbyvMYiQgbsE/bxGOWgP6PMgqPnqOTEriSg+B4TlvUZdhsGNUHN+lopz
         tA+7SUlro3dKaGmqUr63/oCkQ3VS6JCHsGHEYfQ43zjKfnlbkKMHjuVKb7m6VWSgnGd7
         mS79PSHfY7ETgX9rqrqMEs4fj7R+AJwvzifYjq4PbmP8XCmUCv54f/0s7na2bZU4OT9y
         VF1hAmEDfvR8SKvGX+tJKfNekOrKXjgYfXsCmqxnGlHC3VLQUCoM5AKJZb2P2LO9oOyQ
         4kV7yfBtpoCqTSvyqQYlNV65Rk+4i/ZF/aWTXjsocZ88RNMZtx7V90Hl18GgCBdwuE+0
         s/Sw==
X-Gm-Message-State: AOJu0YzYHu8rtpYojplcHuH3M9jXGfhKVpm1mn8OGIoHtu5jNel/4R/2
	EgQt1B8HQ1IDXwrZUIAoD2KKx+4n9kbQ3Q==
X-Google-Smtp-Source: AGHT+IHT1prjATADHPcha+6hRVeVajAEKA9n2RxWsP2L6hY0yEyK/iXNVOuhwOgvmCbXJi+mqMHvqw==
X-Received: by 2002:a05:6512:128c:b0:50e:30a8:4c8e with SMTP id u12-20020a056512128c00b0050e30a84c8emr682347lfs.43.1704908535603;
        Wed, 10 Jan 2024 09:42:15 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a27-20020a195f5b000000b0050e8cd014d7sm741726lfj.16.2024.01.10.09.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:42:15 -0800 (PST)
Message-ID: <2d200f5f-37a5-408d-9ca9-3137ec717647@linaro.org>
Date: Wed, 10 Jan 2024 18:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 display and GPU
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Andy Gross <agross@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240110-fp4-panel-v2-0-8ad11174f65b@fairphone.com>
 <20240110-fp4-panel-v2-4-8ad11174f65b@fairphone.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240110-fp4-panel-v2-4-8ad11174f65b@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/24 16:14, Luca Weiss wrote:
> Add the description for the display panel found on this phone.
> Unfortunately the LCDB module on PM6150L isn't yet supported upstream so
> we need to use a dummy regulator-fixed in the meantime.
> 
> And with this done we can also enable the GPU and set the zap shader
> firmware path.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

