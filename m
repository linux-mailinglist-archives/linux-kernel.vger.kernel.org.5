Return-Path: <linux-kernel+bounces-71176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434685A1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF82283B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB82C192;
	Mon, 19 Feb 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtNTerjv"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC82C191
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341257; cv=none; b=VDKDFJF8nZxXD6SPMx3T8YRCsqc/9N6PpC2zGb3nSMVtNofXlClVMFbPcv3FUWP+Kq+J96zdJ5SjXBMxN56H49zDq0foBcszC9mkzfrvNw8OSY26Dtjg+7Op+LC8ue5VhKxvRCSw7rOrgz3Rq+p/KmwkooRjX3RAaMsIO62bER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341257; c=relaxed/simple;
	bh=/l22stvFJzI9yLjBbwfg8RkvyuXPPxBQpKtOrGK1efo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLYNjIjeXiBh4ecOmTJoINEG8SjVetHvdR83de8vMpFlGKO7jAwqzwZF7UO9fkBhz6SwRKMr2pqqk/022BfYe6X3jCbgE+O3b3uzCDq6n5WK1DCpjQxjSVsL5RAPH6egyZEKc5fmcya6cyUQIlF7yqQzeygTO5JKRwJlSwfLouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qtNTerjv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512b3b04995so640666e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708341253; x=1708946053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PyYVs6a16AWoj9uqiI+CJG85+9K+sn1NezSceDxdaxg=;
        b=qtNTerjvhqJ/md57JkT4THZpTPcxuqNvnhh9xFwY5NoWmkQg+erFahtMhT0qnkkfeT
         SKJnkIfPY26bqlwtVLztN0zJx3zy6m4M+oO4o4e246iY07pn5M/JoXWlR4DIFrSHskni
         a54X36RENaLrcpQsNpooNelyTMXfwxQzUmkOSDb0w/jychN2G1BYAimP/SHR03bEgd8F
         9zsyYTkeZmzbP+BljJ14n+1B0aZuXuJ9LGAx5uP5ZY1OqLTHUpQEtZIhtyFVwYe5Bz9R
         z5JDs9r22vW4j0slIWzhxJuTXfZa4slAtPB7ypifB3abJG8fP7XV/j+hqiuRik0tf6uO
         e4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341253; x=1708946053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyYVs6a16AWoj9uqiI+CJG85+9K+sn1NezSceDxdaxg=;
        b=j1etIE81Lcbr2ja8IbL7mTMGDzMYYs4LFi2Vsy1qgoIK+9jg7HpwDR/gUtiMwpGjS9
         taU8SKN031ba1wEvZxNVpzn3s5J2k0vxyjbqlVw+Nn5j4Rdig77XOoycOK8hGp6QzNqm
         P7tFhXDAz4pe6Ik/xfSZOzflivJqic74sr2ixiH8vzwX3LbDXbWInv2D9i2jk9oFIy5I
         aINvqb+WpQiTgw2WVZfA8xIOX4VNdAkXm9HcvSi5PR2GfY2ktlylhQfC1zHy5TPKt/4T
         k912YlIr5R7dtvpAlbE0yP9cbbQ9tz+15S8y+aubHQpQW+gbkwmM5Dtzs3qLWlhERnmp
         Fibg==
X-Forwarded-Encrypted: i=1; AJvYcCVJXXDBHtgHXCc38ZnILOiVRpFhnkXHBoeGn2TS/LmK+XqG2az9f4ne1Xpx3VUDtfdvnP/PCAoSZWILnwvQ39H/a3EdKpslAZhMOdVY
X-Gm-Message-State: AOJu0YwX7Q/n2eA7Sv7B5cSrdDq5U6Lk5YkOUIc0PvuAFL9maf4VMw6U
	DpqKCmyFKUezG3C4HwJvotYmFb6MPP69/Y/ZEIJSdNc+3nKwFaF9qNuy307F42g=
X-Google-Smtp-Source: AGHT+IGA38n4uOYDiFqm+A8A1tAXiG/4/cFKj/5rEnOaCigHmhmw+eUeHz124Tf+djOBhjgA7P3mTw==
X-Received: by 2002:a05:6512:2021:b0:512:b041:d6cc with SMTP id s1-20020a056512202100b00512b041d6ccmr2061069lfs.29.1708341253546;
        Mon, 19 Feb 2024 03:14:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id i7-20020ac25227000000b00512be879e73sm16077lfl.81.2024.02.19.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 03:14:13 -0800 (PST)
Message-ID: <f522e679-3543-46ee-8b2d-92e384427382@linaro.org>
Date: Mon, 19 Feb 2024 12:14:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM7150 DT
 bindings
To: Naman Jain <quic_namajain@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, djakov@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240218183239.85319-1-danila@jiaxyga.com>
 <20240218183239.85319-2-danila@jiaxyga.com>
 <fce70468-05fb-4f51-a653-7921dd27bc6b@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <fce70468-05fb-4f51-a653-7921dd27bc6b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 10:48, Naman Jain wrote:
> On 2/19/2024 12:02 AM, Danila Tikhonov wrote:
>> The Qualcomm SM7150 platform has several bus fabrics that could be
>> controlled and tuned dynamically according to the bandwidth demand.
> 
> Please add what you are trying to do with this patch.
> 
> Ref: 
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

The reason for this change is explained in commit msg, so what exactly
are you missing?

Best regards,
Krzysztof


