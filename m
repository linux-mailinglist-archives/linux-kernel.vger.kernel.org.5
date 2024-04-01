Return-Path: <linux-kernel+bounces-127137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44F89475A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3B11C21651
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6C56754;
	Mon,  1 Apr 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROhCidoQ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290156457
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010955; cv=none; b=TSJGPhKvezOugUGkwqNGrFij7ER0RTWZZYk6OieFy+rObuzUO6XnTl9InqNZybor0KkVbj296AuRGdnJxDoaAbbqxCAaLtt0LQaS58C/WNcWK+3lHGKgdOmUo/MJ3ivsqQuUH+jQBamiTwSW0TZEd9PRguaucUZoqp1QpnyCsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010955; c=relaxed/simple;
	bh=xZfZznOOUrMnj9F7MOa3gdK1gMRnr0e6ZI2tSYWbdYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJmIwK44OWjuUyHK0WDDvgqlEW8/f4Xhvahkapha4xgloGdBWxGnszRoGG+qw0FZH7iPhcft5jDZlLp19szH3s2qHePhrHOQOa5QQ4DRVfMHjJVZH0xo+hl3gu8sg0Xynoi7bnXJmY1vzRoAw2B8sWEwp7U9FKB4zZAabPlrXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROhCidoQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34005b5927eso3413354f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712010952; x=1712615752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vu7Ehehcol4xFG6h1WYhn2TyDJ5Skd8wIEgpO47rgU=;
        b=ROhCidoQGQLUVKqStikY/x5DTwRkKqRKVAnzQsdAPdMv1OR38aSJRzPGusqD773aZs
         KDrZZ4RXqXs0osB6sf39IcnPqapbO2SxBRBCaYGPxBkCWTxCDveAx0vBEIu23zvolkhI
         QHWmG5QJW35jjnImS1CKG/KgjPhqqnDsmq8QmgkqLeUWC/qN1yO0Ebk6m8/hOK9jpYxi
         qccaxY3QellUHYr7VVfpJ4qRwISUJ9PdAKgPxaFhSsIpYUGmHT7ISBcJl6vQbRQ++o2K
         EMSYQRJCfuUpX9E1j11RRnPLHU+dvcMX1Hl5ynWc99NbgZKaXsGFRuc12B/ymKU7z5Zq
         YtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712010952; x=1712615752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vu7Ehehcol4xFG6h1WYhn2TyDJ5Skd8wIEgpO47rgU=;
        b=i9w3VJgS9HVrtxRxH51WKJgOuTGgRbgBStgH+XaxvMY/LkHVeC4hpQyG93cKDtqDY1
         Z2RwkY1ts8EfwDUGav6soA61WAQVIGaBmRhwwUxAlgEMh09dFqceIzaXKVWyAQa1FM3c
         70Lw6UvSjR0QZz7oE9qtkFP1mVVd2uK7CjP8A4y8nf4JCJRBZOiVvQ6fSClySbRzEaYY
         t4bU3BtVl7HrTcBqbJH0DzWbzUJF6qoZnVh4BHPjS/Mulo6go4vaKDvyNZXUTKrGsbY5
         z6CqeNZCyhHAHdFIbZJdXc4k+RHF9zJfKzn6wJhn1bBnlapvW+pbdKSl5s21rTN0MQQx
         l8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVsknfuLJLu7P5tOW95vBxw2MP4E6+vhqaUh6yLcm9MKQgzrtGfy/smi/z2mqIIXVkDfjQBxsZ00MKmswMH47J7PF9OjwZohO0UZOT
X-Gm-Message-State: AOJu0Ywf5Zy44WLts4uMAvg8uc/k6furS0g6XLkT/7eGi+yigg9mzEyZ
	D85H+IU7qrlkb4mLhJvfa7c7HifnjauWMn/A2r0LVByoHwjR8ZCmrlSCLkJwH7A=
X-Google-Smtp-Source: AGHT+IE8YS+EpdrZk5681b14c4WM8tS0DI17KBtmsVaBo2K8H6KY6wB04e9lnNeDiZB9YxmB5EK6JQ==
X-Received: by 2002:a5d:4b45:0:b0:343:617e:26ba with SMTP id w5-20020a5d4b45000000b00343617e26bamr155174wrs.54.1712010951422;
        Mon, 01 Apr 2024 15:35:51 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041477f3f99fsm18985589wmo.30.2024.04.01.15.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 15:35:51 -0700 (PDT)
Message-ID: <60461c7b-b693-4560-ab29-8cd9d8ac4a44@linaro.org>
Date: Mon, 1 Apr 2024 23:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Move camss version related defs in to resources
Content-Language: en-US
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240319173935.481-1-quic_grosikop@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240319173935.481-1-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2024 17:39, Gjorgji Rosikopulos wrote:
> The different resources required for different camss soc versions are
> split in to two groups:

General series comment =>

You need to add your Signed-off-by: Gjorgji Rosikopulos 
<quic_grosikop@quicinc.com>

for each of the patches you are submitting.

Perhaps yourself or some of the other people in the series deserve to 
have Co-developed-by for some of the patches too ?

I really like the reduction of code and the definition in one-place of 
things so definitely the right direction.

I won't do a deeper dive into the code until V3 but for reference here 
are the branches I verified db410c, rb3, rb5 and x13s with.

x13s:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/sc8280xp-6.9-rc1-camss-resource-change-verification?ref_type=heads

db410c/rb3/rb5:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-stable-v6.7.9-camss-rb5-20240319173935.481-1-quic_grosikop@quicinc.com?ref_type=heads

---
bod

