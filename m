Return-Path: <linux-kernel+bounces-3573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFA6816DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B134281A71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CC7D617;
	Mon, 18 Dec 2023 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+WsUw26"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E5199B2;
	Mon, 18 Dec 2023 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so3583674a12.3;
        Mon, 18 Dec 2023 04:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702903069; x=1703507869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4T70cxyfYBrIT00YJPhgzlaa8IjVEwywR+fjzgz6hnA=;
        b=d+WsUw26xqkHKaiBguVwyakO18u4pNIyivaUn4vPAkTgnV3VHrU/TzZkhhLXKryz5B
         QKA62sKxk8ybWtFJsoivwGoKCGuqpIxFqF/t20BfQTpzSD4qXisPMSmVYfOTffEzyV5/
         2WcfKSdjCS2EeImOc+BvnuwymaPF534SN1UjrfDLdQNz8flWV6J0AKn3kvbCvkkYqOxj
         yvs6aRAg+qPcF3AXZz1LBoKsDZIAjftM0Clh9K0Gdj54UoCeB9wm+mIkWBxg6oi7qDyQ
         CEtov8gE/TT2FMUKMFpFJmDSORmUYRzhWf6BjszseDQ8aV0oYxZzSPFomec08Q6UM3kv
         L7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903069; x=1703507869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4T70cxyfYBrIT00YJPhgzlaa8IjVEwywR+fjzgz6hnA=;
        b=uzLYtHW2rGrINSXilYRawfNVG5X4yZ6DGO7F3/MiSHYeNlI92PGLAXumimgFATluza
         fgjY157hJKjg7YYa0sjOBN6ijnTO37zDNbn1AX/VYXBgXRiPbh2ZJztJovhv0562axRj
         w/am0QlRgqEGqrrEgjRGVULtAlW/K6NMudu/FqgT/x3QS8x+3HQyinENVD8pilPQTpfn
         DoMclCMyPZbN/5P1s5zI8IIer4PhTA2Tvi3K5pRo1ggQVD2HS08td0NpI2j7ep0Xlo2C
         8ZDkZDstv248rIcBdDFzg1K9aV6NPrx8yKxHHf9c8y216paZ+YQH8iHAXvsvCilSIr0D
         jZkg==
X-Gm-Message-State: AOJu0Yyvot2WmGUX2mx0tIzPH/Z6rNjlO2hFSAGnxxkOkwtG60Y2H3kE
	r+rrYrApB5WXxM2XyE3orw==
X-Google-Smtp-Source: AGHT+IEl9hnKaHmsyOpOJuG4izfnlVs83sWcBIPusYmmVQwjw+L77gL9w/VRBPAhCbzD46onZKa2pQ==
X-Received: by 2002:a50:c346:0:b0:553:7898:e6ac with SMTP id q6-20020a50c346000000b005537898e6acmr137799edb.126.1702903068671;
        Mon, 18 Dec 2023 04:37:48 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:4847:f8df:b40e:3aa8? ([2a02:810b:f40:4300:4847:f8df:b40e:3aa8])
        by smtp.gmail.com with ESMTPSA id dh6-20020a0564021d2600b0055338547cc1sm1409895edb.70.2023.12.18.04.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 04:37:48 -0800 (PST)
Message-ID: <c58b97ca-3faa-4bf2-8d7c-7ff34e0428ca@gmail.com>
Date: Mon, 18 Dec 2023 13:37:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/27] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
Content-Language: en-US, de-DE
To: Maxime Ripard <mripard@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-21-knaerzche@gmail.com>
 <rrtknir3vizvcyamp3kfy47r6uppn3wwevb6a5gln2k533t52z@otm6vum6pg43>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <rrtknir3vizvcyamp3kfy47r6uppn3wwevb6a5gln2k533t52z@otm6vum6pg43>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 18.12.23 um 10:05 schrieb Maxime Ripard:
> On Sat, Dec 16, 2023 at 05:26:31PM +0100, Alex Bee wrote:
>> @@ -431,6 +452,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>>   	else
>>   		inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_709;
>>   
>> +	inno_conn_state->rgb_limited_range =
>> +		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
>> +
>>   	/* Mute video and audio output */
>>   	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
>>   		  v_AUDIO_MUTE(1) | v_VIDEO_MUTE(1));
> This needs to be done at atomic_check time: the expectation is that by
> the time you commit the state, everything is prepared for it.
OK. I guess that also applies to the other members of
inno_hdmi_connector_state (former hdmi_data) and was wrong all the time.

Alex
> Maxime

