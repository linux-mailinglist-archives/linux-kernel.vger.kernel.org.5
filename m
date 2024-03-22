Return-Path: <linux-kernel+bounces-111942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ED4887311
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC22EB23C22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF75664AE;
	Fri, 22 Mar 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ynwp4U3A"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38D664AC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132016; cv=none; b=Z0qibdERotscOEEJrGLawSW/bzRGU59g+Oe7ZzI1t4NCJA6X4mf4ZOQvK3/HFIjIcqAS+5zoNgDUlrw+bZaIhctNKoKsNfo+ZdnMocqGCP/mqq2hCFNGjjR7a+VAgHjIumkuWArYUN6jao76SZvRvp2llUnFeSf+7H/ioZCuBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132016; c=relaxed/simple;
	bh=Q/u452WT4SEBFlq4/JQ3yRAJcz5QKxX8IHHraP8XT0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsGgWcc6EghwZvrUqHCocTaiEYLR7KgwDvtKWONoMHsQ3iN/FTgreIL5uFgizVKwxWErvTvuMa2r0ODszuGm7ijgdJAUJU97uZL/XvjEjFfU5cdv3vZqDvGN6+jYEHXPE/KPvX+SkMJZ387DdHTAvoYHB2sUzEHKpFJK77jmMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ynwp4U3A; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bdf694a81so1299037a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711132013; x=1711736813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXnRqDF4YLp0T9y0ST2nEq3wWDFSifmMU5J5sVht3i0=;
        b=Ynwp4U3A8+gXGUodnmCHhhytsCoOhTVcIuz0Kklbg6bbwFUdbsG4iEc+VfSuxMfYSg
         evVaVAo9N0JCz+y5Pwth7e5q8GAuWcxpUVyqzICa0qfk/PbaKjzmq0utDg5cKyo7FGpn
         F3ocCdxT8yEpXqVTMQZzDnHSkFHyifUe4tCqAnU9W93zNzOS3R3XTLcbeHIFi3Y5i8Xm
         ij9FgDIhyN8n3petwpmEDOzWILFXbxfRIqdW3/nlo32Prlxn+/UZZ0qRuHMeq3wIrw8a
         jC6xoOM5cnfb859C5gFTULleIHmLJwkxtoJUbzepRYKLB/eoxjDFd6Cb6xS68fWVx8i0
         +cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711132013; x=1711736813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXnRqDF4YLp0T9y0ST2nEq3wWDFSifmMU5J5sVht3i0=;
        b=oEAYcFoEjJRT4gqI/JuGGOvGGdGmu4cv5rGqaDO6wICxLZcECu37gHvjRYpFbCFzbF
         iwN1UfgTeCXwTqgJHxcYCWvQ11d7xYSdv5rYSX+QJJOLqRhj6dySN1xdLm5FxUBM8/XQ
         RMP8Z+aEPavnJaeVN5TxeizMuJqZ6abOq24RNF797YdGwUy1i/I3GLvATxLzaZrXR752
         8MVuqfKPFm475z6AnD+sczIxTP1//I08fun5Jjv8Ab2KLJZo45/Nd5JtKa0e+bPFP8MS
         tqxKw7D4nQSOsKoEi/tCFdTYoKPdXo21ke38bdoQqETDSu4YMNQuYwPURdDkmEY9Rr8s
         I5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU1bIvn/kOhHansEWogx67XF2VzwkqQ435OXezGT8kzhPLVw58sXPn1Ol4W+hkyahUlKZil3bapH1ppwjACVfJdoa64oRl06xszxGQX
X-Gm-Message-State: AOJu0Yy2SpqbZmbMg8ahXxb8FS2Plh6Obfy+nrblR4wrRRKLaDds5Mdg
	XFJnu+LdY4o+2Rd3hScffpXA0I4FiC07N1qjZGbIuSAKqbakihel06aMsKC//iU=
X-Google-Smtp-Source: AGHT+IGz5DnzgT/I8P9WToBe0xq02OvN1rsW50qQzORerVn9Tb0FvWjU1lHVQ7pLUk2OOmuEpSw0NQ==
X-Received: by 2002:a50:8e01:0:b0:568:32f7:6c53 with SMTP id 1-20020a508e01000000b0056832f76c53mr235919edw.3.1711132013484;
        Fri, 22 Mar 2024 11:26:53 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id ig4-20020a056402458400b00568b6d731e1sm86945edb.4.2024.03.22.11.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:26:53 -0700 (PDT)
Message-ID: <1fe26dcd-87c9-4d9e-80ac-5cd37d5b7b96@linaro.org>
Date: Fri, 22 Mar 2024 19:26:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: usb: qcom,pmic-typec: update example to
 follow connector schema
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
 <20240322-typec-fix-example-v1-2-6b01c347419e@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240322-typec-fix-example-v1-2-6b01c347419e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.03.2024 12:52, Dmitry Baryshkov wrote:
> Update Qualcomm PMIC Type-C examples to follow the USB-C connector
> schema. The USB-C connector should have three ports (USB HS @0,
> SSTX/RX @1 and SBU @2 lanes). Reorder ports accordingly and add SBU port
> connected to the SBU mux (e.g. FSA4480).
> 
> Fixes: 00bb478b829e ("dt-bindings: usb: Add Qualcomm PMIC Type-C")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

