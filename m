Return-Path: <linux-kernel+bounces-15610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F760822ECD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C191F2458C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F91A28A;
	Wed,  3 Jan 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaFmddNB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10219BD8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so8590144e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289372; x=1704894172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywm1NJM84MFVbNs8Kn4Mu02P9WC9fu63PnwufUkYyus=;
        b=eaFmddNB4wQQ6+LzNAHt0op2ZK3Cqm5zFKktcbxDa5pLixURkQqsakepP+CCKwog/g
         k95vv9wAyEhZJMBnlHnpJRzyIwpJBsLK78S824Sc0IwKteyNtGVZXnWkFubEAg/4lbWo
         uGzZsySL8E9v5F9gDnlR/meLHYTbSdUgLgGZwRvJa+SkN0TrttrzncTJM7qCqFdJPavC
         2i6YKLvnmc6O6PDDJhwKq3GiMKA/sZLeEcTyu3ybYZX7K0GvO9UJ3p8MnxSMnlI6yVdn
         OPWa4RCSJdvGlOJwpCs8sxJr9+tyaWFmcP4NLbRNaOJUCfiyFvt70xTinw3nAVUEeuXQ
         l1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289372; x=1704894172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywm1NJM84MFVbNs8Kn4Mu02P9WC9fu63PnwufUkYyus=;
        b=T/4PZnB3RAnSBmcHrdK/FrkX1XykCH8Y8MpiMh5XyZSODkw0xF2vwnr4Ix+3hk/rnU
         VCDU7M2rbrr9WTbDFljiFtJKlwXKkAJPiUoa01Kv3RNYeg4YhnM3DQR5TRBmvy7bfJgf
         ATbLPVu+adJoZdehA/yyEKDZgtrVR/5tCCKDQMOE4+H4cDNlAU040MQ7rZQFiQId0IjK
         nH/epS3jg8rN3XGr4unobBqJwex8dy98CznrzEtQFTR44J62d9LD1Qh+cKHNdbBTOU5k
         pZud5tWnEvhxJrZZw1PNVrTscBh7fJigGueRpE8F4/W3uJEYHwH7zXq8Mh7nfr1vMl4C
         6rXA==
X-Gm-Message-State: AOJu0YxY5PLVap3zmckKLKUo7B3BCJQnvLAA+eN23EpBldpunzxUOGKs
	VFqClV6VwnGecXGp6N22OFfp9An/pJZbUQ==
X-Google-Smtp-Source: AGHT+IF/E3O4/SeJ3/L03JtNje4HPHmKSxk1jYT6GhkDV/vLGOKfuXNGpS6l0kqQGCl2uDjt2JUZ0A==
X-Received: by 2002:a05:6512:39d4:b0:50e:8158:1fae with SMTP id k20-20020a05651239d400b0050e81581faemr7183741lfu.99.1704289372403;
        Wed, 03 Jan 2024 05:42:52 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090680c500b00a26a4458241sm12720131ejx.18.2024.01.03.05.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 05:42:52 -0800 (PST)
Message-ID: <6179e3c7-f399-4b0f-abb0-aaf5e549d8d9@linaro.org>
Date: Wed, 3 Jan 2024 14:42:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] phy: qcom: edp: Add support for DT phy mode
 configuration
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
 <CAA8EJpr8rKMBzcm-=HGu7-C5hPkNMrnG1cA78O00UjgJVT7p6Q@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpr8rKMBzcm-=HGu7-C5hPkNMrnG1cA78O00UjgJVT7p6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.12.2023 17:27, Dmitry Baryshkov wrote:
> On Tue, 19 Dec 2023 at 22:55, Abel Vesa <abel.vesa@linaro.org> wrote:
>>
>> Until now, all platform that supported both eDP and DP had different
>> compatibles for each mode. Using different compatibles for basically
>> the same IP block but for a different configuration is bad way all
>> around. There is a new compute platform from Qualcomm that supports
>> both eDP and DP with the same PHY. So instead of following the old
>> method, we should allow the mode to be configured from devicetree.
>>
>> There has been an off-list discussion on what would be the right way
>> to pass on the PHY mode information to the driver and it has been
>> concluded that phy-cells is the way to go. This means that basically
>> the controller will pass another value (that is, the PHY type) to
>> its 'phys' DT property.
>>
>> For this, we need both the bindings value and the PHY mode value to be
>> added as well.
>>
>> The controller part will follow shortly. But for now, lets see where
>> this is going.
>>
>> There has been another attempt at this here:
>> https://lore.kernel.org/all/20231122-phy-qualcomm-edp-x1e80100-v3-3-576fc4e9559d@linaro.org/
>>
>> Compared to that version, this one uses the phy-cells method and drops
>> the X1E80100 support. The X1E80100 support will be a separate patchset.
> 
> After several back and forth discussions, I think that this approach
> is not correct and not that easy to extend. Instead I'd like to
> suggest adding a property to the DP controller, which enables eDP
> behaviour (and thus makes DP driver call phy_set_mode()). Something
> like this:
> dp: displayport-controller@ae0000 {
>     compatible = "qcom,sm8000-dp";
>     /* reg, interrupts, etc */
>    edp-interface;
>    /* or simpler */
>    is-edp;
> };
> 
> What do you think?

Please excuse my alzheimer, but why did we not go with phy-type after
the last discussion?

Konrad

