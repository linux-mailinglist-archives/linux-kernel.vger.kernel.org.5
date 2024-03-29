Return-Path: <linux-kernel+bounces-124432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349FF891787
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1041F229CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640106A325;
	Fri, 29 Mar 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hollGHfk"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF215381BD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711226; cv=none; b=UBJMZWz7Dao/c2o9zRBFaoZ1BjFCZuehNA5Kc6mdNAGDyzcmon+nbpWti03FP7K0VgU6t8yJNVcjDGByeBOV/Q22OYEXeDFEJfYVw6V3ij4iuQVfDcVWdfs2lHmKkYP/SLXqzhFVnotzjkN2KLawXKH4dWRyf6TzdiSLERSlTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711226; c=relaxed/simple;
	bh=5FBU0D+DDiOTc1dUOvctEb1Hp3EE9ut66nbbd/NvBwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSlRJfGBWuhJFcydN5BfO3OSdPLVa9esN8bdBDp0rn93G2W/VQcNe+sXmJJCFxZAXpv+DLtf7qT40B6+pu/Lh4p8T0Vh3wkhVMuiIlk/VwAtD1ADLTgt2qd83AE6NJQkB2GUvIT/FHdvXT5VLZskITRF4gPhpi4p7Ckl1VaYQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hollGHfk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46d0a8399aso494914466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711711222; x=1712316022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kKV3KbJjgkEGw8OwdQHUS9b2YPZiHnl3LTkJFrXOS7w=;
        b=hollGHfkPyjtKQpKpXuayAHxaS65beJEOjZjAY1dGluEWEBgOTdFfXOnh/ypoHtrGq
         17m0k8g6FtjqEfL3vijXGpI4QyLgtLHU/Ws34zTJ5KZutEnWspUyBa07cyuc+hpWthK9
         FsyfiHEBpb/AElf7/Q6fhm3L0PnHQivSMQ5wYrdSyWKmu5vIcfHXBTOm0xtusSGQxsax
         DekHx2U0a9oII43YB+Sb6Px4TVELq5YNeBIc1qiOPHK0pw2z8U9AgxYPKNr0vLImnFQO
         z83NeToF+C0Wo8WB7jOAJflp6K5Ol8JRwPWdGrtpct9z4Jub2i0R3bn83YaUsZ6Jxixq
         36XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711222; x=1712316022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKV3KbJjgkEGw8OwdQHUS9b2YPZiHnl3LTkJFrXOS7w=;
        b=ecXYAR4aIoFkeU/yMDvocoJqeOtE0wx1T9OOMJj9NP5I3DbTtwfWbFUmU3Jm6o+BFB
         oe8a7O8RtaO2jr8dLztAteEPOJjbkSg5rJzjxuyaB7gPD0/FkpGRkgsj8EjDeXfBe0OZ
         BSax98LpYecgG+ojbWkXzEUcxaUkPSf93E7xOBwtJWNaPrs3oSYG9B+d5r6qc0z7J+u8
         Ciak3QJkmoUMxfuaga5xFILpXYWrjSgOEfoPv4YzbhKW+4mXvDPrR4wU0gsR02WP/hOF
         7XMp8GVZTa1Rih5ayAil7c6Kz3D1GHzb26EUa86chtAsiUuk+dvtCeO5b9oJxWMO4uV4
         5nQg==
X-Forwarded-Encrypted: i=1; AJvYcCUEXwzAqymlIDorCOJHttRDDtN8WcuJIK0ZpI8xYvw3/xJJSDOLzq6jZUST7zyz+wWWfhxIgoDo44cmVxVyJpLRjreALSTxBJKJr/U4
X-Gm-Message-State: AOJu0YwNvbB0xMfGckJCKuXhw6kMLAJzkrYSa+ijLqI8ozW/9mn3wTr8
	rbK2n9C1/e5jaNaomxk+q2xKlEZhGBcEtlBSS7X3iGNYU8VScdR8YWHJ5sx9WSI=
X-Google-Smtp-Source: AGHT+IEIkAJ5ywwRATnP2MCZSETlJm79fyi1m4pgbxPFEky4Hig+TEPkqaU0GNDKkMruZAcPuppxVw==
X-Received: by 2002:a17:907:6d21:b0:a4e:24b9:bc23 with SMTP id sa33-20020a1709076d2100b00a4e24b9bc23mr3747234ejc.34.1711711222186;
        Fri, 29 Mar 2024 04:20:22 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906705100b00a42f6d17123sm1809758ejj.46.2024.03.29.04.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 04:20:21 -0700 (PDT)
Message-ID: <f80c380f-93b5-471c-8a7b-8cf6de0cfdde@linaro.org>
Date: Fri, 29 Mar 2024 12:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm6350: Add DisplayPort
 controller
To: Luca Weiss <luca.weiss@fairphone.com>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-sm6350-dp-v2-0-e46dceb32ef5@fairphone.com>
 <20240329-sm6350-dp-v2-3-e46dceb32ef5@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240329-sm6350-dp-v2-3-e46dceb32ef5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.03.2024 8:45 AM, Luca Weiss wrote:
> Add the node for the DisplayPort controller found on the SM6350 SoC.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

