Return-Path: <linux-kernel+bounces-130402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C848977A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D679A1F294E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFA6153574;
	Wed,  3 Apr 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WizGwgwq"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A601DFD6;
	Wed,  3 Apr 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167131; cv=none; b=ZbiR3d4BRYJ+s2Nfh+d9SjBI+qeCn//7eNEYK5Tj9kfeTHmYgdo1SGqF9A/ZOgDJ0KUS0KYR9OuKjQEajssIjDVPlF85RsKD1I5eqH+uJQ9+ruZy4NpkEzF/Tc2+IJZ7Vswu1gAFjGcsVDFZmkStMm+Vh4jdqVI/o4nrAvQpu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167131; c=relaxed/simple;
	bh=T77JDQnJ0hsdJFUa5ETbkj6RTVt2ZW/eZKnQNpSp5PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDZ9Nn8ty/JUcwk7BwUkiL4+XFmyNXaMGZaWVQJ0hS/v8kfVdyDQD0VMQfKqGyBAbOioM+0nbAQLijhFySmNa+Wj0lUdh+ZcHqX5uQbarpQKXA02ECs4VHnelaVqsTx/PRu7V3oQWAlICXZGgx9PZu8JdrKoxMrlguZeimskSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WizGwgwq; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e9e46f1e03so87054a34.1;
        Wed, 03 Apr 2024 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167128; x=1712771928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrewaSl6Jc56kNZVXV/Ge3JfdB2Ym16uXrC4TB/dGqQ=;
        b=WizGwgwqrO55Wl/Ys9cvOL3Ogs7Mje0ydhLphr0vTL3i+Q/I0oTTTcrS2TEFfY1KT3
         1pmb+DLw7TVpUnB4RmXWujuXbb67TsdfCXrJh0+cxfo3bTGaKZ79TSO2F7EEWzy8u+8M
         VaIlJri987Pj/5uIrRAQZVkYY9VG7rqimKpEFZ4eGmyRiyxATNqv9TZL5jCTLiKr/hT7
         Dz302aiqOZgWyEC7lbqS/mJh5uNnvCU5qYVC6f5sPNwTDqdYmbza4ZmuwTNvNq+7OZI7
         nWt2hzk3CUDxWK/jTarx6HpjncOykmvUcyUrx+THT7DIrgNEznkPAQyzSv8VxZzLIDn4
         1AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167128; x=1712771928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrewaSl6Jc56kNZVXV/Ge3JfdB2Ym16uXrC4TB/dGqQ=;
        b=Ng+GHkNZDa87zlCUI/Zwabas/TsAcO31ptELN3FuxIVbbQypSEwTqs7eZklUI6jboV
         GAqN6Wpgx4NG5gKbYHQ5XjW3HYxYonV/D6SWiSBM7DUk8lW3UTBrqxh7aEBOa2AGNwGD
         1TUtkzItEjQw4pJtWFQIgFyij3rLD+Ys09kwe8d0ScG4+oLehSQ9OVhxaMeRnrHTf1eq
         jcAYMqJfw+VrXv53Ykam5BQiPDPVk2FFnV/b7+JOfWola2FfSQUIDFNM0xPZcTQsOL7I
         qyzuOSQjuASZ6oWyUak70alUt4IYez5tWg7KlTGdcjim/ttaCj0ZA6BL6MwP4lVWSV/U
         TM9w==
X-Forwarded-Encrypted: i=1; AJvYcCWpkPImx1LwPNbzSq5FumoQ68aBp+vp7kJPCibihNkeL4vAfspj35PQ8u4B9rd8Q5Qmoh7p5ybGyRSl0P+GirhfcyzoqxcC+D93FIj9itay0bCszTR12NAR2U4WHsb9nk4cD5KU3ZXYpap9FZ0xv/cVIo31GueeG/N3eW+uTnHUPL+h/FmHWbSKdGT1hIC6eIcFdVeR0OC4v6kBEKlt5Cu4uF8=
X-Gm-Message-State: AOJu0YywXzWc5LqnXnKc44RXSLlIjnpgKgvbF5fqb6EvdOFh1JzXIHu3
	McPwMRSQ7JnXdUsLfcUQco+/C8chvL9JmedPmYPJWKfgO088Y3kI
X-Google-Smtp-Source: AGHT+IGhLvfnk61jEqJuwTE8ZDrxA4/6Gc4gOsanVBK9ECZUWDl79PSn6cFET38D/6LqOpN6wTy68g==
X-Received: by 2002:a05:6830:617:b0:6e8:af73:3b41 with SMTP id w23-20020a056830061700b006e8af733b41mr3590661oti.10.1712167128373;
        Wed, 03 Apr 2024 10:58:48 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id m40-20020a05683032a800b006e6bf2cc882sm2732667ott.26.2024.04.03.10.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 10:58:47 -0700 (PDT)
Message-ID: <54016e9d-b887-8ec4-b896-5ca2355180dd@gmail.com>
Date: Wed, 3 Apr 2024 12:58:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/7] dt-bindings: clock: Add PCIe pipe related clocks for
 IPQ9574
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ansuelsmth@gmail.com, robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
 <e392a1dd-20bc-447c-82ab-f6256bf2be69@linaro.org>
From: mr.nuke.me@gmail.com
In-Reply-To: <e392a1dd-20bc-447c-82ab-f6256bf2be69@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 02:10, Krzysztof Kozlowski wrote:
> On 02/04/2024 21:25, Alexandru Gagniuc wrote:
>> Add defines for the missing PCIe PIPE clocks.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> I did not get half of this patchset. Are you sure you are CC-ing everyone?

The other changes are driver code that implements these DT bindings. I 
used --cc-cmd of git send-email to find the maintainers. I'll manually 
CC you to the other patches in V2.

Alex

> For this one:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> 
> Best regards,
> Krzysztof
> 

