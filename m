Return-Path: <linux-kernel+bounces-128202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D47895790
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A885CB2E1BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62BA13174A;
	Tue,  2 Apr 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifShd6t0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768D12C530
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069379; cv=none; b=ehOcum9D/udFwdCUjQ/0rZQHc4r02nr3ufPV+dt1K2v19UZOjASHDaTr61gV5w0y+SMSJ6tB11vhOXKOJYkrIfcDWwTsWu3Mn3YZT93fVsH+rcaVIwD6KLKOgK3RFjqQyK8/UFe/A1OjKTc4O+s9toZJAcSjAztg+KViq9meW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069379; c=relaxed/simple;
	bh=R6qde+iITv8Ux/EKpL1jJjmQD4xhkEmuDaLF7RETwOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TStQvaQprrb01lEddqRBLO5Z1sBfjkeT+qrX0HaMH63aYtO4MBQlEaRTaa7pILHBzls3IyH+096yPItAqZ+WOgUJJW2DeS/nedRRkwuDztgA7++Xrx064a5okU0zKnaG3QZJSgOh43JmxZ3IZ3/kENnBaW97OonCcv24/43NBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ifShd6t0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4e39f5030dso514749266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712069377; x=1712674177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qLa+MN3bXJ5HxwNKiIPGEXS1wglnZiuZ2Ea5/Fw6iIM=;
        b=ifShd6t0t41raE9O8TOLw/bl3gnuNErHtn2VQNJ8lvrgANbupd8YLKj/qr7dRj4kLw
         N6/STJR+rtB86Xt3BBbD086vMel9IY4Y2vUBwoSV/32NZ8uZExqjwcmCDNkREnC8fvos
         Lw2H0VSUTij3nL9vPENkzDtH1Hbo1wg3ZIFEknuN2zrFPG7Ilwoakuuwdt/fKhfS69Ju
         jRm2hX4Jn1lBAO7Fc+3hAG2DFSe+Dzz1vaC07OxsNJMrjga+RJZWB4O6X+Yipqzz1Cwz
         yn8kmPd4uTgoZSqE2vLW9atyh9iZwsId7Mz/ejQV7yM4GaB7EkOFCtyAGO+6419GcbUs
         S4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069377; x=1712674177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLa+MN3bXJ5HxwNKiIPGEXS1wglnZiuZ2Ea5/Fw6iIM=;
        b=F9YaIOd+Y2OYvC2/qMlU7nTupaXs85xYVdj7M5Qp3GjYCR1M8h+hxqKqQR3tyALJUh
         8ZCi5RJ7RQcJeTm4NgMqvmQleH+XP8J2fKxsTlp2DHAihhYIs2aeWbZU2NBf0qO0DCql
         pcVQPK8UtB/y/UV1DNeIw5zYH0XU15/BkL2fUA5Lutu2A7XMCVat4anxg5qY3EWMEZEE
         A7KuZikEIEflC+A1omDZ5XnFusc/IEe0rpPIHXrtCg3gLrUqTC/6Q5Sm1NDbylHDQsmj
         ZUpNTesQPjUvl3gPD7n2hbXF16SZOBSEk4faephkAoAnnJaQxslW49wPdEYL7hUoNtt8
         KPQA==
X-Forwarded-Encrypted: i=1; AJvYcCW7JlB6bhBsMo/RSbsI5wgT0/ME8TjRcG86Cm563UzX07zt+iQ4z1EfFWsOQr5d/fi4YB2tH/Fl51ufB6cn9E9ZKa/9rZkoffKELT3N
X-Gm-Message-State: AOJu0YzhPt44md6u+NkzAlRvsz07lus6gTojRGPLTvV6wFsLPIu873Me
	D+/1+rEazEEhnyfDOQWZo6tRkrmS0n3VZsloyGoJbfHCtYsT9dM6YmCB+4QioBs=
X-Google-Smtp-Source: AGHT+IGFYhRDcZm6Ii0rP7m5rmXlrAdHv5FZrzsVIj839wjWmHdgrYaO3ezpyXY/JT7It50aaa5OsA==
X-Received: by 2002:a17:907:9286:b0:a4e:4e76:5fc7 with SMTP id bw6-20020a170907928600b00a4e4e765fc7mr8881269ejc.65.1712069376618;
        Tue, 02 Apr 2024 07:49:36 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709060e5100b00a4623030893sm6527417eji.126.2024.04.02.07.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:49:36 -0700 (PDT)
Message-ID: <0e599137-4a23-40b9-9a22-3c32f795fa1b@linaro.org>
Date: Tue, 2 Apr 2024 16:49:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] interconnect: icc-clk: Remove tristate from
 INTERCONNECT_CLK
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 djakov@kernel.org, quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-3-quic_varada@quicinc.com>
 <CAA8EJppyuagb5zkP4LCjjJwConw3mw3iS-+dO7YB01=7-waRTw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJppyuagb5zkP4LCjjJwConw3mw3iS-+dO7YB01=7-waRTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.04.2024 12:39 PM, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
>>
>> drivers/clk/qcom/common.c uses devm_icc_clk_register under
>> IS_ENABLED(CONFIG_INTERCONNECT_CLK). However, in kernel bot
>> random config build test, with the following combination
>>
>>         CONFIG_COMMON_CLK_QCOM=y
>>                 and
>>         CONFIG_INTERCONNECT_CLK=m
>>
>> the following error is seen as devm_icc_clk_register is in a
>> module and being referenced from vmlinux.
>>
>>         powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
>>         >> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'
>>
>> Hence, ensure INTERCONNECT_CLK is not selected as a module.
> 
> NAK. Please use `depends on INTERCONNECT_CLK || !INTERCONNECT_CLK` in
> your Kconfig dependencies.

Should icc-clk ever be built as a module? It really seems like it should be
a part of the core framework.. And dependency management would be easier

Konrad

