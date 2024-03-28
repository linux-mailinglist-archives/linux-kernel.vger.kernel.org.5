Return-Path: <linux-kernel+bounces-122688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1288FB73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F42029E57F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719546A00E;
	Thu, 28 Mar 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlWMSWI9"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4E65BAD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618109; cv=none; b=jgeuSEcC5NJnaAc1SJZSr2bj0Hrd+PPtumOnSlSuLgpHoPY+b2F652ISV2y4/tTSanOQA2miqSev8GH4kGjC4g4jk0mgr25GMLKmNrXQucCgroHXQLiZ+t8cTsk7fED1RjeKy9WubQBqJ+G6t0zmA2Warb3ENCP/6YNATBKje3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618109; c=relaxed/simple;
	bh=CkWHMVm8S2ewK7fVN1+IrsGA0aUUiJt/IOSayrLEL6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5j928nj+5ViKZyhJoyC7b4RivFFnHTp24ivFCgPLWM2TUo3X8gMmX1+VV+RRNYk2fpkOh01cry+6Hq76Bwlaj3J/18CwJ50OhhKiWzlaJpOsuYA+zMpEIZfxAJjFpFeOQHd3KdjTdatCtE2DxpfLkzG7Z1WhqYyg3Y+b9c3wb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XlWMSWI9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-414866f92beso5183115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711618106; x=1712222906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8vxcG9ckfTnaNAOnZALxn8W9X1qrkWn6D0TntHUEKr4=;
        b=XlWMSWI9ANYaFxCHO3izSnV19CUEhPZEgWo1tEprOGoG5dFEzaNenzIHfPZAw/LMl4
         sZsc0+W35WiGWfdrYAvGPiorpoHfLsDe8uMZBHcZndylmHnNJw5sd4ngBvAGaNHN06YD
         5lTVp6GUtPEC6KPoq7ORoyPUVrYpTy+4M//yBaVCmpZtam40+SlruWUnZytzoB7Pg/1N
         WuW/NCQap8CNrYAVcDE7yQrTBuo2uphRlwbhu1Y/hXZzKBVtjp+D7czfHNzyknD9sUqG
         MZluMp9Qk3UNP4lHnVw9nxkv3RrVGp1u6h4u+mlooejaYyAmSZaBlnVlN3bt8vNXOBWL
         0UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618106; x=1712222906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vxcG9ckfTnaNAOnZALxn8W9X1qrkWn6D0TntHUEKr4=;
        b=EzPmhadXOtaheKuLkVc+Nql3+ht83CNCtaEPPMyKn1ufslBFslzLC+kwa65jRn1Rc3
         vM6sX92cRWFxp6A1ge5CNMwVoisY6TRTILti7XKoQ6wYWn7mOY0uI3Hu2PvHmldaeIXf
         jyE0Qugp8oUbjr4XtwwLpaM+UxPYqOgYW0a7o0trkax3k4SkYYLlNoRNuk1ZruvM9q3p
         wfWbWQdMQlCJ3EyZ8eMEG3cN0/jab5KUC75Z9vFvbNpqN6oguclKxQaH8IutIM9/2t9R
         zHsDbYXTk6sZOhHNSNzQDji7M8+vg5gQ4ipxrsLCJhNz+3IN9vRLdyJv5iFaeZgOFGkd
         SXBw==
X-Forwarded-Encrypted: i=1; AJvYcCVRfyN+3CVFPSt12woDpoND2/FhykZ4yqPo6zLvQto5k+WMcwNjAUktOShNRTE9v3Mh1AuMGhdlHQ/O9rJ1BbpF3ScZFQ2UnpSpk5Jj
X-Gm-Message-State: AOJu0YysFaZJH2Al6nsq6/akm3GgX8/7/vur4EDxa0It0i1Z+LMgXqbV
	dHnzM2nx8+ZaK3TdARgezt+UE0ofF5ASQReLiAiF4YghwoS04g8eHT9wX+/M2M0=
X-Google-Smtp-Source: AGHT+IGKaShHHGG/JP9892DOBLrEH1kxyEmICzP8y/gYKnhkUTWEqFyUfPhKtl26ETxb5HtN2i8Qcw==
X-Received: by 2002:a05:600c:1c27:b0:415:45ba:bf5d with SMTP id j39-20020a05600c1c2700b0041545babf5dmr704289wms.7.1711618106456;
        Thu, 28 Mar 2024 02:28:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b004148619f5d0sm1705874wmb.35.2024.03.28.02.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:28:25 -0700 (PDT)
Message-ID: <121ba1d3-07f5-4ddc-8b0c-0b63476bb86e@linaro.org>
Date: Thu, 28 Mar 2024 10:28:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: hsi: nokia-modem: convert to YAML
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
 <20240327-hsi-dt-binding-v2-2-110fab4c32ae@collabora.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240327-hsi-dt-binding-v2-2-110fab4c32ae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 20:11, Sebastian Reichel wrote:
> Convert the legacy txt binding to modern YAML.
> No semantic change.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/hsi/nokia,modem.yaml       | 106 +++++++++++++++++++++
>  .../devicetree/bindings/hsi/nokia-modem.txt        |  59 ------------
>  2 files changed, 106 insertions(+), 59 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


