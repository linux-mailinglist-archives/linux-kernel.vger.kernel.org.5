Return-Path: <linux-kernel+bounces-66079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C22D855653
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5930A288254
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7127453;
	Wed, 14 Feb 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3hMHwIq"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151A1DDC1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950884; cv=none; b=YbJRUKTFOStkCOiQ1KiUoaZ0aeKIuZCQ5mV2zT6VcdVuAv9SwSXZOBNxsVsidrxBeLpxroOPnZSHPXfc7VXQQYU55tu4WZaLi3PpSBsmqnnxiA8YEBgYIxqMS4AqZdAozXM46sQhEPh2N72pewFSR2y9pGNHrGRhhGZBlfIw2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950884; c=relaxed/simple;
	bh=HSfmelwd1XU3MyUvUaiGTtXyx60hIyu8jW65rYsWTo8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tYV6cJuNwt4MzJUb4FLpx6t2iU2n84c7k+R/BjYOnamZpEvmXMkEFkEv6vixTDxnAfvv3FSGQZ09Fbjh4c34hqm9Ilk39hr6E2A5DFgZ4zvJJFwlCTnR1TDickZQZa5SLk5DWw8cZ0Jp+WO2xzb2AsNnF2Yste6nRUJhN0UPxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T3hMHwIq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-411d715c401so1920095e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707950881; x=1708555681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSfmelwd1XU3MyUvUaiGTtXyx60hIyu8jW65rYsWTo8=;
        b=T3hMHwIqQJ9HcCbK9Rxx0fvi7LbCH/+6wv8NfIz3i18s8IBhukfbYKKockJ0X2v09R
         EBRnyetMHxIAU/oNLfVdXa3fcfguFQyDoPC+P+dUtvxB4a/wpmB5JArOs7ozR7VuHsh+
         APQD3TPUbgNCAYUCLGD5FcwRzT4dJcpYhyKcLXnUmVVOZgUpThwWRxb3rQb1dJSYSYqo
         cAGlz4y49HdjneUxVbbUsEnfW1KJTjnqJhiGsRhuzVnAV68gHw6efBRX4bkVMfLPMUUP
         yLgIEqMSRN72dVucK8cuAqD1/hQGAe0EZKNcJX29V7TCNUeRVGEGHcCIGqr5I7CfyV5a
         UzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950881; x=1708555681;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSfmelwd1XU3MyUvUaiGTtXyx60hIyu8jW65rYsWTo8=;
        b=dlZTC1/U7tQv17a0UUBjWgtN9V2OqxfhmwzWfH6GrEy6Gh8HAoYhdj5CBUrohso9QT
         59p8F0MY+Nwth7XpfzVoiWyscPS5AQ3h+B31jireNPbQ9APx68ORonisC4/J2hLNOYNT
         6VaAd2S9C9Fn0XoNqbjhkVaLQcd1N72CrGkkak1chwLTvukau09VwO1QSfdPSRYSJFWw
         6CfmeC+S5IkA3H0WPUCqAyIXDAjywFnfK0wu0/jYx3OZO276YxnFI0LIgtR0dVP0BVdp
         SLxqumRIKDoa6LpgAfCYO3RH3FFAa4SYOHEhkySx32K+at6PgOhx/NXBtXmgQyCpIEY8
         gPHg==
X-Forwarded-Encrypted: i=1; AJvYcCV4zFyG8IiaiinrpCNJLUA6KcnhjaGY3uOQmiwhg/Acv584GhEBI+06EjWFJL3tmNtBdqDXSA4Zp+v9KgkQadhCCcVDFHnkTTwQQ+0K
X-Gm-Message-State: AOJu0YwKZ7PdTRLUS6yLvlCI/05xVzDnK1SxVNwPtLXgWeXcic5sGxD0
	qRNu16YeVYfTB5QWmBjd3QuOmgNnU3eAKduXSaxkI0POn8rNFK0L+JZuDef/ic8=
X-Google-Smtp-Source: AGHT+IFYMUnYSP8KPIiy3Inq4GQZqvIvnjeRZZWCmvnpjDiveWRMLt8suI/sGBQfwanVAu7pJ0WIWw==
X-Received: by 2002:a5d:4e02:0:b0:33b:80ab:46c with SMTP id p2-20020a5d4e02000000b0033b80ab046cmr15754wrt.63.1707950881401;
        Wed, 14 Feb 2024 14:48:01 -0800 (PST)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id t4-20020a1c7704000000b0040ef0e26132sm1786389wmi.0.2024.02.14.14.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 14:48:01 -0800 (PST)
Message-ID: <aa30d8ab-86c2-4f75-8c5d-6375e859998e@linaro.org>
Date: Wed, 14 Feb 2024 22:48:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
 quic_fenglinw@quicinc.com, quic_collinsd@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
 <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
 <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
 <a09d6450-95e7-4ed6-a0ad-5e7bb661533a@sirena.org.uk>
 <df6a49f3-88e9-46b4-b7c3-e5419fd01eca@linaro.org>
In-Reply-To: <df6a49f3-88e9-46b4-b7c3-e5419fd01eca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2024 22:47, Bryan O'Donoghue wrote:
> And there are other rails @ 1v8 if 1v8

[sic] If 1v8 exact matters to you

