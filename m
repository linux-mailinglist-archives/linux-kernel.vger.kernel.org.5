Return-Path: <linux-kernel+bounces-94224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057C873B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159D028B0AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A60B13790B;
	Wed,  6 Mar 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE7iMA6z"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECC135A4C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740992; cv=none; b=JwM7GTemUP2ELpMoozZcFuZxxhCPbaM6ptORl0mugma+tc8Y7zvfMu+iikdSjyTE/WVJf9Qe3Pqc/dRiTdKTdY6s8ksUdnwYrG4HUMbQi1Jw0/6wbG/AoCVsDY6XMs9oHp+lbj/g5n4abBw7ArJ6iGWR9g+G4qe/diOWcXbLtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740992; c=relaxed/simple;
	bh=R9r772f34HXHijYnV2MOXV7FUE/0NkutRga5zVmy9a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ipq1bcMJLuKAfK128ou6LDAm7HmqM+HlXP8J9Oo2sxGJpiqylOCBSsBw4DDUgfkR3X+sODba84r9leUiRfmmsHoCJWlsVfG0jbtn7qD3MZ0Keq2UWeB5CBnU20Wuo7X8qCU3DkKX2huKp7W/0DOWRrgPws9s3u6q5C2CTkwlyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZE7iMA6z; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51340e89df1so4658901e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709740989; x=1710345789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9MfW84pQmInKasVchKxLCBjmSCiqOVONg69XqoBKCw=;
        b=ZE7iMA6zxC7PEFwvziX637n4cWYjjfWv0hAutTBML1bwBdziqpOB2dhe/WqZJe3erl
         TYJzSbpN5eQW+NvXdufQyHRE61Mzm5buhJnwwi6g1XxBmqx1z0MTCo8Hr/qf3KSwbi7W
         j3qWC6owpoKFDNL2P+nbr4wZ8z1oTbzDUXICv5vjs8+WplLINHULUVcUpULC7De9sFHL
         3cSFxuB50SqLyxQYjateuQI3cb/n9Mj38HKYjkA+26as46IpgBeUTBm0eINQw5niKkRj
         FrxaZGTO/4PCTFzNxM2dFwLjArRsAmflzq+JpP05QcOUFF4PbpxwvWsf4f9E1SyZGq/K
         02rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740989; x=1710345789;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9MfW84pQmInKasVchKxLCBjmSCiqOVONg69XqoBKCw=;
        b=GPP8NwPkEQwUyN3HAfAN4nW+RLrz/CxyCyNtEBkfxhmAW5VGiDdaHVQOg4zbL7oGwa
         SRS/9Zvv+uYq/jKOv9JpSSK6Xwz6uZWBKc8KPZX5lydjIc4fafUgheazsadBK2VdHbWD
         7OrKQkAa5ejT9Psc3S5qmegRbMfcbxVE10YUVz/sryY4bO+tXaCJZ/Z15cdDAdZQ/P67
         1jtpIyoyYbntOm0/lwq5zaQLkJsehIyhzY+pl2tt4c1oow/T0mlKU1NnQ8ScYOxYta9p
         r3425xiclI714RKQ0M5HJ4cMtDpyF/H6T7FVd5IjV5O50iUh+ciJM3PFvVl7BrBxYzAt
         xwQg==
X-Forwarded-Encrypted: i=1; AJvYcCWY2gvpAH68LOJXDM3F4psP7/v/VW3MO+QWzfqL/YUhuzVunwaVyifr//1uC2SPibauc1U9IR+ta7RlhEsVXAX158V8r+oe7M5PkUcO
X-Gm-Message-State: AOJu0Ywo7f2i4DYFQoz4YaWVtiJ+PCgpYzJLWucKqbl2QiJdTf2bI0lm
	Y8qf5WmP3QGw5VobQ7XjhrPo+V4C6GDNS0FRFYI8AAiNwFGB4IxNlf9d/KBeAgw=
X-Google-Smtp-Source: AGHT+IHOB2NN7QC1FZy5/GvqwVh+kS2gHxn4TnbcM7tZzRLNsrdlnJEIMaHR2HnCSghLIEkxdL2HwQ==
X-Received: by 2002:a05:6512:3d8d:b0:513:57fe:97b8 with SMTP id k13-20020a0565123d8d00b0051357fe97b8mr4013094lfv.26.1709740959029;
        Wed, 06 Mar 2024 08:02:39 -0800 (PST)
Received: from [87.246.221.128] (netpanel-87-246-221-128.pol.akademiki.lublin.pl. [87.246.221.128])
        by smtp.gmail.com with ESMTPSA id m13-20020a05651202ed00b005134c52debbsm1076665lfq.162.2024.03.06.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:02:38 -0800 (PST)
Message-ID: <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>
Date: Wed, 6 Mar 2024 17:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
 <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
 <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/24 05:10, Elliot Berman wrote:
> On Tue, Mar 05, 2024 at 10:15:19PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 3/4/24 14:14, Gabor Juhos wrote:
>>> There are several functions which are calling qcom_scm_bw_enable()
>>> then returns immediately if the call fails and leaves the clocks
>>> enabled.
>>>
>>> Change the code of these functions to disable clocks when the
>>> qcom_scm_bw_enable() call fails. This also fixes a possible dma
>>> buffer leak in the qcom_scm_pas_init_image() function.
>>>
>>> Compile tested only due to lack of hardware with interconnect
>>> support.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>> ---
>>
>> Taking a closer look, is there any argument against simply
>> putting the clk/bw en/dis calls in qcom_scm_call()?
> 
> We shouldn't do this because the clk/bw en/dis calls are only needed in
> few SCM calls.

Then the argument list could be expanded with `bool require_resources`,
or so still saving us a lot of boilerplate

Konrad

