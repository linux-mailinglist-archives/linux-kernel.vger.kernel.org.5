Return-Path: <linux-kernel+bounces-151737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AB28AB333
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D61C21D26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F64130E5D;
	Fri, 19 Apr 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmBaaj+9"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE6131193
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543484; cv=none; b=fbx/usLkzFp7dwqExJstIVapo0Ts72gw8ap+e/qeNzkwnp+B1l6ee+xsuyDeaTMsz3gPwXYP/Cs76d+L+fkEaAaDjoWjbNQJj+APK5QcwKispg6aS+/Q3xS6Aq2LrNN7Lx3u8ZtDwSvrUQ3d+ji4YaYgAGQy8qbMXA6PFPERwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543484; c=relaxed/simple;
	bh=DOaOWqE1D7DUqa1LvsHy0ZMdH4TVB4NTyMIBeL96zao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxENQELhue0x4LwXK5pTjQdwjccY+lIXNB9rTIyvd+QmnXY0fw29nM9Ivh7XSEUIPz0/FGzCjXEUAMKy2k6ivbFCyOnvTCOefYryrE31YTe/ucVavaG3FP2TNhEzOrpvNHKUCDniXt442xEX8jektGx20cUHqcddZxVc56nqJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FmBaaj+9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so2306579b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713543475; x=1714148275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spx5J53LxWT9NZPJkLKrAhGW+607qnxyHYuW8vb0pwU=;
        b=FmBaaj+9Bk8W+PV8FjzxWWXQl+iyauJTVcbc1AKtm9juQfIBahiUWCAfO98K8f5AWZ
         Ym0RQ4G/DqXLwRVg33vy64McvxEAtLag5K7EKrL8TgKxocvWTaq7cCRqxlHCVK9IJ1HL
         45Ikv9yf1QAWTW3UR1lxKxKS9u22/s7XfFFWxoUsVkAP2JhrO30eW0u0sEo1PowFM9rq
         PdPxYdCwRAtqja4uh2/qYpUd3l3cg+Ms5U+0OCfHTCTfEDr2XIuTJ2tTvkfDZ+pE4HZS
         i1A16Zj/aj3j+o/tTZFD9qxgJZyrZKRg572/VmVFVzDwSBwKvx/ViUdUtuBzGsbiItz0
         V4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543475; x=1714148275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spx5J53LxWT9NZPJkLKrAhGW+607qnxyHYuW8vb0pwU=;
        b=qWHxNv+SwpXQ5A5TGRjF8Jo8A9+4mFwf3q+VZ34XeIMgqEj3VKq/C0/0rBopoTwAMY
         0v1Ato58JAgWeEQ/VHBC35m7it54C7zobKbms5FzhfvHShEiriL6Pbo0Di3S7RpyL0pG
         dKZiMi4bQc9Ac2li6VzAzokDEZaFcSxjb3oK3VJkAXU7K4K2afZK/NOimF2fYrrI/qmy
         9FQPvlMKnWPa1rWaka2MWBzxwot0MylbK8S1HFRzsRRRrv0/iu6pTmeLnjZKV1nhRDRi
         qrNi9Hl7GAGINr3zNb2pEavRBZ/mFMr8dsyzZZ7LX1wBNoFaNKc5Da7rUpgqgtZ8XggK
         ri0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZct2QhN1gTrl+JyioNZeey9m5/qeVSAauZgMIwL5pkRTLiBsshwQWq7MoIrFWeD6JJtfyaiadN6F36icpEWqfy8ImaT3FjmaMwJGl
X-Gm-Message-State: AOJu0YzrgtgqNjcSXFUYFTRMnxi2pOTCUDOpi93Lz21Xf7T8iea+9s/Q
	4Dm6C+NoZUji7bcD74IHs9i1jxe8/IGqcB6by2gqeNh75dHuF4UD5LUxF91vm6ZySpBoxBZ5aaL
	M0rc=
X-Google-Smtp-Source: AGHT+IFPut/a4p0qYz4XASJQROV/eGEDhtCt9CzxlXg5cpEyLEGgpNKlQ8xCn2yZsFlhyHHI9aA0VQ==
X-Received: by 2002:a17:902:8302:b0:1e8:b715:45bc with SMTP id bd2-20020a170902830200b001e8b71545bcmr2407965plb.29.1713543474718;
        Fri, 19 Apr 2024 09:17:54 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b001e48565b40csm3531990plb.210.2024.04.19.09.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 09:17:54 -0700 (PDT)
Message-ID: <e1afdc35-a45b-4d5b-9fcc-aaa26d2080fe@linaro.org>
Date: Fri, 19 Apr 2024 18:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: usb: qcom,pmic-typec: update example to
 follow connector schema
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20240418-typec-fix-example-v3-1-08f649b6f368@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240418-typec-fix-example-v3-1-08f649b6f368@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 08:38, Dmitry Baryshkov wrote:
> Update Qualcomm PMIC Type-C examples to follow the USB-C connector
> schema. The USB-C connector should have three ports (USB HS @0,
> SSTX/RX @1 and SBU @2 lanes). Reorder ports accordingly and add SBU port
> connected to the SBU mux (e.g. FSA4480).
> 
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


