Return-Path: <linux-kernel+bounces-35847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FFB839743
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB3928C7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E04381211;
	Tue, 23 Jan 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krtGWImy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888D7FBB5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033312; cv=none; b=Qtba6UyBGop2hIf6qTsj8Kz7EuIvC8A91W+1eFtudkDYmKiPj8sZbUp+cqB+SBVIBzQ6d9QYhdeOPJryHqSvizQNL0G3jo9n2wrP+ZBvVRHY4Ge8ufVvGNNHm8iZxLkT8WMBrYpz4DAE8zkgqf2M3gte21bwfz5uCSJDh6u4NEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033312; c=relaxed/simple;
	bh=V05iKo+n6/NfP57WVS8I3bsIytgL0QoVsgZ/TQUCSU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDLV9t2yeR+7+v4bDVOalGf+aKBBfsd2OdBzaDP+UvhD78t35+UGXxu3OZ+BPOu1obpDIpOLNgIF4+uoSW9bsXu30N8svP8Xl7PqEgO1iiiYawjLjAdUkmYORvOqxSbJSY8042HCyf7mrymPltHE9dbx/RoWAZUeCxF4lOWmG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=krtGWImy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso4779980e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706033309; x=1706638109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VacN+hMZzICvOwFTo+1W7zaMNQJAc7ZHS+usoqRya+M=;
        b=krtGWImy3wPR+yZTPM7wzvlUZgE8qQ0eqrVp5cn6iE4Lpb7/K0vEFfPFds5c6V0AdX
         sigVsl0dOqUFrFV7rHj9muyDjxFg5muLgq+UOsrXFsW3Cds+ew9SvrzpKZvbung8KASC
         IWpZ6m24nAOhV+yhAQjRwXHMmIYROawhYVUYqkk/08PnvP01VXNGLp/RpMcqNTxLJh+L
         XNuOctpz8WFVP+S7mGj3O665Q12ZiBLRINAXSpNzdVAi8xv/c/c2R9q0yF2fhuzRul8T
         gqyxZ2wYyBcdy6NmWqKRPO+qU9ANZ0z9AGE5alazD/ViUnRv+BQOGnB46p/1pHX/2AFh
         yWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706033309; x=1706638109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VacN+hMZzICvOwFTo+1W7zaMNQJAc7ZHS+usoqRya+M=;
        b=cD7NQAXqK8Yz5kY+HXKtrKmbxJX4KGbkw4aiC8OlLarPS787hPyx0MzPv5/g4G63YZ
         3Kywm3/VveLLyI+yeMXB5DfdWh8SFxJE6T/XPIAYkLZySF5htKOXCtBKwwEdk0JpikWB
         dMu40g1J0Y1DVnabOBiLhv3RBL+24GFFLyS+bQ1e97uatHaCoQI8qv2pEIwWp0vgj/Vx
         vkBYgaqR46k9+N9DCAI92KjS72B2i2nlxGQMSf4LxSwwgsaFBPqojvG82l+ij7Z3C7WG
         MG430+aX5Zd5uBSmfMVPUgyhbTCHe5Z3OZQMjUwMmWvn+5/JI5TlxipwTt39+Q2Rsp5M
         Y2kw==
X-Gm-Message-State: AOJu0YwG5TVNfA+nBIF5Ye3M0jpp/IOuGkBb25c0z1utg13nvmkk6a4B
	J0E7twqpfFvOnH/8bisilNXKz2PeHVK0JPI+B6ejitdRIfWamd4d0kwBfznRfps=
X-Google-Smtp-Source: AGHT+IHeAnZyr1gr62qrxVLoqa6iDyfnOqrEEg0041Peb3w0NL5O66Teiup2mHYqHEt4atQeGd8gHg==
X-Received: by 2002:a05:6512:4c3:b0:50e:74c6:895f with SMTP id w3-20020a05651204c300b0050e74c6895fmr2408227lfq.115.1706033309431;
        Tue, 23 Jan 2024 10:08:29 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d17-20020a05651233d100b0050e8e88b529sm2344518lfg.237.2024.01.23.10.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:08:29 -0800 (PST)
Message-ID: <bd404b99-346c-4d51-bda9-f1148421540c@linaro.org>
Date: Tue, 23 Jan 2024 19:08:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] arm64: dts: qcom: x1e80100: Add QMP AOSS node
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-3-072dc2f5c153@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-3-072dc2f5c153@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 12:01, Abel Vesa wrote:
> From: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Add a node for the QMP AOSS.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

