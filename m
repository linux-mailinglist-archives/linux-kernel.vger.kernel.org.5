Return-Path: <linux-kernel+bounces-16484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67A4823F35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33903283CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9320DD6;
	Thu,  4 Jan 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrEuyE9X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD620B24
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5537114380bso269934a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704362768; x=1704967568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2VRerHbUXnseXpnoaycYA+JvWQ06UaimMD+PjvMoyo=;
        b=BrEuyE9X56UHGPz6chp5gwhNAK4GhCYDarxG8r4NywgzTb3e5Qk4VotrMxyPoQkma7
         2zmBKVIcEX5/+ckGOh0u4VRCNJ9QOK+4QETz2ZA+3EjA6gCM/LVskvcgU8vUPaCys6l9
         mkMFcgVEgK2MT063yheFYuSiWCxVkJFkFdpWN+H3He5sKlek4xl7HYVLgNlkPRU8cJ9b
         xiKqQgG7XyNhokMVCXXrqkfkUqN0SZ6dFZ22MHslEPe5fRTMBEM4dQf77dL47AlGCbq9
         LzjBZ/1vve3tZcxgdqxRusbEiFj11i5WBcWdw5lnhhgN/epq97gnfUq0Xr5K2sX24prI
         MT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704362768; x=1704967568;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2VRerHbUXnseXpnoaycYA+JvWQ06UaimMD+PjvMoyo=;
        b=MKgmz4ffhulydIF0nv46WtuO0IPI0Rlg2lHA6qgDGTQ/6i5dq05AsnUT1lKTuy05yD
         Fftw2/KvUhGvkf2xCcMCteps3Nnu3SOSGOL2K2eOiwoKQz74Rwj7c6TboSUZaBNto/fH
         VZawfbCnNSJQGX6nWF8cYP/NsS8D3V3LkUI+Sn0C8uW72y3aWddsNI1/mRCpSMZZqv07
         pGdIV5u5HZleW9fxv7ds3ECqN0qxF7WMqKPjRr5qGs0nqs07sxC4gGcaq8h3hjYSLD+D
         g0FbUFJtWcfzxIhJ6n8FGelW4pzhS0E32oG26XqfINgoVv0dalgMbeS0ejU/VoQ6+xto
         Q9Sg==
X-Gm-Message-State: AOJu0Yw4wE81weVEFtz1LcvxwgPed/nOSvNSysCTULMJ4VX0ATHjK+ct
	w0zk3GPNLtOf7v258QTsFPpv4cotgZlnAw==
X-Google-Smtp-Source: AGHT+IE7B8T8Xf8ldzmLF5fnpBcVnHBKV6LTQYuD94tHojlLNLIWKY05YMbLyFDnMtBnb6Gr2jbqLg==
X-Received: by 2002:aa7:c31a:0:b0:556:be08:6645 with SMTP id l26-20020aa7c31a000000b00556be086645mr219506edq.28.1704362768324;
        Thu, 04 Jan 2024 02:06:08 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id e24-20020a056402105800b005557a9395e1sm9917768edu.47.2024.01.04.02.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 02:06:07 -0800 (PST)
Message-ID: <2aa360c6-3e8a-4454-8a1e-31ed285d7a68@linaro.org>
Date: Thu, 4 Jan 2024 11:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] interconnect: qcom: x1e80100: Remove bogus per-RSC
 BCMs and nodes
Content-Language: en-US
To: Rajendra Nayak <quic_rjendra@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
 <20240102-topic-x1e_fixes-v1-1-70723e08d5f6@linaro.org>
 <4d4d5d3b-cdb2-484a-8297-4b8bb0817986@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <4d4d5d3b-cdb2-484a-8297-4b8bb0817986@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4.01.2024 10:59, Rajendra Nayak wrote:
> 
> 
> On 1/2/2024 11:59 PM, Konrad Dybcio wrote:
>> The downstream kernel has infrastructure for passing votes from different
>> interconnect nodes onto different RPMh RSCs. This neither implemented, not
>> is going to be implemented upstream (in favor of a different solution
>> using ICC tags through the same node).
>>
>> Unfortunately, as it happens, meaningless (in the upstream context) parts
>> of the vendor driver were copied, ending up causing havoc - since all
>> "per-RSC" (in quotes because they all point to the main APPS one) BCMs
>> defined within the driver overwrite the value in RPMh on every
>> aggregation.
>>
>> To both avoid keeping bogus code around and possibly introducing
>> impossible-to-track-down bugs (busses shutting down for no reason), get
>> rid of the duplicated BCMs and their associated ICC nodes.
> 
> Thanks Konrad for catching this, I do see these nodes in other Qualcomm SoCs upstream (atleast sm8350/sm8450 and sm8550), perhaps they need to be cleaned up as well?
Yes, I cleaned up 8550 last week, I'll look into the rest.

Konrad

