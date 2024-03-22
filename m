Return-Path: <linux-kernel+bounces-111934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296398872F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA76E1F24738
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0F2651BE;
	Fri, 22 Mar 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdRSYolz"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976BE62801
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131775; cv=none; b=fQKbu6VgC3wLmjC8HyQqZ5QuJm0INrNVsXtryy4qhQ5JY04Nz8BTbm7IpxgFV9vUpJSfmhL+iliV/gGMFY2IohRdOCtguKxGHN7AdgB5Qb02YHThB6IrYskjP/VVPewPYN1LsSQdZqNlevHQ0tWQq2i0OkWdgC/hk4t3jEDVM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131775; c=relaxed/simple;
	bh=qkQte3r0ijCtO/RXb6KA6OLOuQLxORYyhLd8+PxHMCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2/owN55ZCH3iL2grCX6dra4pDr9EoKDMwl8wja+3HP5s7bbUif2LGYONkeWlmta6ozOpXKNph3WT7ubZWm8rkMrbcEdg37P6+x4Sm7b621/EJbmq5XoJDZlw/bao8iUPARQKmxNTn4vlvHbD3Ca8NviPouSDEmtJnyltHw48YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gdRSYolz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46cc947929so342479466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711131772; x=1711736572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MveXzUtHIxiGC+UvZrjMJW/3zlt1prAejsyF3p/A0e4=;
        b=gdRSYolzpYBhiTeiMEiuqdEKDPYutLhi/yoalMGgrSsNh9O3aV1zk8g1wtZFX406oz
         zbPbLKI7CPIKmACv0SFyz26x2ftxqUsEfijypwRlTLyohTI7tYXkGNgWL/zue+WKC14E
         EroeMLHIhzZ7KLchW5EfkKMXx7zAaoxtQAzQig+hzc1KIoNIwXwAe9hvkuhU3JSU2lPD
         x4n7luzZLpXGb3ZKdt2z2hle6LKvHw1xClCHYfXzQ0LiSdcrNxVTKFw5Aw4CUXJYiCPz
         LYzYZYKCC2mYEVDjdL/X4z+hRbFMrPTFr01txO/RHdk0RmDChtKF5HPCxDXgjC/HJGSE
         Lahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711131772; x=1711736572;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MveXzUtHIxiGC+UvZrjMJW/3zlt1prAejsyF3p/A0e4=;
        b=Wr0Guwl0onAUkKVNbsR1JO6I/k27MJ7LD3t/x116HvJz2NAYkuLy3XzLJ6iKQktc3Q
         gWIQloLS3LHpUt5neUl0ZMwa8QvPc4RaGNSIzNNBjWLs5jQgoztj3IDA6yaTt9qptHbv
         DDQ7L3gipiigmuYuZqIEGYYtLmvECIy85Aj1SOk2y7rSmPadon/Ab0xNdv6RX4SdxdnN
         O+u8jmfy61mNLBl+f2Vsj5f7mWam8jNqXbtfSuhx6o28ocs1kWKLWjt9TysqEaYGwl1U
         UkoKGjGqlNyTZfQZbA0r6Bw8BRkbDem+2PlfoQHJBGlMehvvqbp0iOt40CAGZPWNTp94
         z2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1THHS0anlTfH9Sczua/X1WcRP6kVfEBTrYubSGt/RCRALO+V/PkE7QEoAYhakH9p3NWQOww9o+FPufRXAfBtVgvQu/oUDf2/YXtOW
X-Gm-Message-State: AOJu0YwJmKxUBFb1pGb2sxoYWKP1XEvostekHRVcapounO2k9ttznBdF
	cj9ZxlvG6SdyxA584eHvWqWTJHUU3cfi5o/LD5OAWlQfjf7QEEgQDa1WubAkn6c=
X-Google-Smtp-Source: AGHT+IHR/N1B5eWWzUpqIvN7EWkP0veGaqivyFrZDe/pkqJaeePtFEmggg6ApO1eMFdLjsorAkHZ1w==
X-Received: by 2002:a17:906:c00f:b0:a47:20a1:5a4a with SMTP id e15-20020a170906c00f00b00a4720a15a4amr360290ejz.23.1711131771926;
        Fri, 22 Mar 2024 11:22:51 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906131800b00a46b10861acsm77304ejb.208.2024.03.22.11.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:22:51 -0700 (PDT)
Message-ID: <728bb2bf-c5a9-4e7e-8592-0fd7901837ec@linaro.org>
Date: Fri, 22 Mar 2024 19:22:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] firmware: scm: Remove redundant scm argument from
 qcom_scm_waitq_wakeup()
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
 <1711034642-22860-2-git-send-email-quic_mojha@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1711034642-22860-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.03.2024 16:24, Mukesh Ojha wrote:
> Remove redundant scm argument from qcom_scm_waitq_wakeup().
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

