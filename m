Return-Path: <linux-kernel+bounces-103045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2987BA59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF1E1F22FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E36CDB7;
	Thu, 14 Mar 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugfOSjof"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451396CDB4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408343; cv=none; b=ObTcXYcT3EBEegboqt3U2PCdU7D9m5Y+0JjrsudxQr2iUBTU0XpBHUrsMPIVLVdRz1nDCeLHN+FWQXGYjeBVoGIHMGcDpSSFR9+qp/5pZWgr3nHZYS+VxM8NPUJwQR7yz0sFelnlcVtpkfsiik4LvWMYiZdmt4LK45zwwOCoOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408343; c=relaxed/simple;
	bh=fgonNeMf/o/pRXS7JivunfUA0eISBue8LuSCTAtdblU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEimkWFKMqN+XzSLJmyjj0lsV+usT7coj/iE5cJuLbaCduzL3VXzb0QAxNUgaqTmUpySid/xndLonwyozpKqQ26uf4C/W9Z8OM0JeIYzx5So535V2lNQClIhTso6rYOrFbWf9ic78BhGThf4gkGQt1ftq6GRgh/xhrFAFfpf5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugfOSjof; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso8556341fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710408339; x=1711013139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8d+4q0CAgInaiDlbX468rkRXDY2d+JUTnc6y78NLvE=;
        b=ugfOSjofDJujBPI1gmKRaPhrsuxOqhHTqr4q3LHgvK4A2hwC3ud3Y8Em3/0oT2vmvm
         JVyk0xSJSc8xmDaWek9sCFSSAHEFYYjvHpqsSQ4EfjwFnuovflIFhxUq3RHnlZimLXVB
         ZECa3QYuHiTJQl2sCM8zlsdXbkHzxoDH8RDYidsp2XHLhLgNQHBsDUfh6QauuLxPBdXn
         cOPbQ8B5nZES+sXyGIdQgVxm/y3WBken1yyze4Q5XdDUXISuCqxa0JFN6SDrXRlusNeC
         xvfVQyR0jQuI8gF1dw/q8Ua2Dn9gPPH6FXgmwsffSdno9NH5w+TXuwI8kCe9nAB6m17m
         i4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408339; x=1711013139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8d+4q0CAgInaiDlbX468rkRXDY2d+JUTnc6y78NLvE=;
        b=xIVLCf/080UzEdH6qD90deDQ6QLfveKcDaAaqJS96YwcqikRjW9dNiJEC5/x/CG6Gx
         8HZ9T+ydQa2HQ+LaGvIyw3zoBoZEA/K4gQAd/g61Ac1gax/yDmQ4YYD1W7D8++FUG4lO
         EeuX7wFYG/pMNKOTXCCxFCX2hGeSYBMko3nBKrdn0+jcxUJUlZP/ldcX67hALz2JHFr9
         b2rakJa5cycHSIvlK9+P7kGTCtOrt26+Ea1bwjC6+dC5kqR35VZF+o7ifLpEf52Oqgzu
         vVwqlNORNJauS7UJVsBCbSlihQNxNSDJLu+ThH1L9IEJmUt58ZbW+iiGQinegTyxMzsz
         UPFg==
X-Forwarded-Encrypted: i=1; AJvYcCVfJXRrh81tkSgKWaTfZsdV8yVGXOHo85QA+Y1vK84ttEUz5krx7TRRRsj1h3y0+LtGKSH5YywUwAxCfCxDshH1fAWke5CyNgw8MK07
X-Gm-Message-State: AOJu0YxQ/5sXjlpMOSy3wzOgXphhC5LaSZgP0L41zuDYirSTPKV7Gn6B
	/0nyNCpyPJ41wRgPQfdWFUjWq5av9xtmeV3o70wf3Wk4DxJkf1vGr4UultUwhUg=
X-Google-Smtp-Source: AGHT+IFBBk4rux63ZSQC8J/phAe2l+ZN2bujZdh2Zao6JevEjXLO5PGu9I+qsB6H3c6vIOUM1vmoAg==
X-Received: by 2002:a2e:b0e6:0:b0:2d4:24c5:a35e with SMTP id h6-20020a2eb0e6000000b002d424c5a35emr698266ljl.29.1710408339520;
        Thu, 14 Mar 2024 02:25:39 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002d2697570fcsm56937ljk.93.2024.03.14.02.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 02:25:39 -0700 (PDT)
Message-ID: <9eaedb7a-f417-43a7-9728-1ba89f4b2151@linaro.org>
Date: Thu, 14 Mar 2024 10:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: fix usb interrupts properties
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krishna Kurapati <quic_kriskura@quicinc.com>
References: <20240314-topic-sm8650-upstream-usb-dt-irq-fix-v1-1-ea8ab2051869@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240314-topic-sm8650-upstream-usb-dt-irq-fix-v1-1-ea8ab2051869@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/14/24 09:53, Neil Armstrong wrote:
> Update the usb interrupts properties to fix the following
> bindings check errors:
> usb@a6f8800: interrupt-names:0: 'pwr_event' was expected
>          from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names:1: 'hs_phy_irq' was expected
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names:2: 'dp_hs_phy_irq' was expected
>          from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names:3: 'dm_hs_phy_irq' was expected
>          from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> usb@a6f8800: interrupt-names: ['hs_phy_irq', 'ss_phy_irq', 'dm_hs_phy_irq', 'dp_hs_phy_irq'] is too short
>          from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> 
> Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
> Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

