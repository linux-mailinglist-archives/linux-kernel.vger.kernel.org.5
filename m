Return-Path: <linux-kernel+bounces-44561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460CA84243C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DDD286870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67A67A0C;
	Tue, 30 Jan 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhjC5B7R"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC58679E4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615850; cv=none; b=IkzX0j3KnqaiTCxPniYh8hCTb3efoxAigSP6UctGkBCzj+oS95J0nT22//kwN9uRZNEam9qn/QBFXOxFXTxgdcBNSdjrPrxlrC7jNXFpwtq/EGaZiWzslzM9UkHuRXNJnLk68GwDkSRUQXIBye/up0OKRlregVINvrHn95Ai7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615850; c=relaxed/simple;
	bh=lNDEbS0L1aK+WLlskcr9fEx2WP60RvRbgDqk1mGHees=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unZgF7cZ9n9lg+5GzvF7PgFkOf+bh9HFT3QuMAykbyqn9NXlEPcThSGqP3qJcURSl+zvj1sYw3iZpaOiDCqopPdwzfE1swhL3BxTq/GO0xlLQNECEz7hwtQP/V1ivi645+PlEo+z3uPR7oOerwbqFcT+DJkBB75jRsVprhfB4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhjC5B7R; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so3111353a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706615847; x=1707220647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxgM5kktWvhN2w25/56fYWOdVFlRlmsv8vzO6AkG6kw=;
        b=JhjC5B7R7WJdfIXD1xCVywxjtRzosj3zCiZQUzwPG4abmDbTUdeck9VMDVwWFbObXz
         uHhQ8Rldyvz3Dn+QKYH0z/+XvF4lXAMHZgQ4/EEzVJE1yXdPu8OasTw6mdhmid4g9u3V
         ZdLz/RWC6SzMcGKQEp3TjlAJKi73KwYte3hL85TOUfvnuws0yvj9Pn0j6oFEjhAp0tQO
         TO4+e/zYURoIzl3hPk/A1CSkVQ8QJXhesdPiAgRUJGUfKTMWMXIi152at87zET9LlKBf
         KZS9IaGITKtKGe1YxxXIlTjaeiGXwKoCny98uWwpA23wEe+XG4+jEMtjwdzgoS4MJpVy
         8wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706615847; x=1707220647;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxgM5kktWvhN2w25/56fYWOdVFlRlmsv8vzO6AkG6kw=;
        b=gcrq/STdZKAYOfYrH/l2RZ864FMdhydrWUkWYNgX/tB+JSGeI0+tqEt74qSbmuFN07
         7f21cnAA8AaDMjjFuK87zwXfMmNbYTAfxd68rDDIihY+FKi8VMaybIGQe10e1pL98d7n
         PqaMBk3XB6pLJM6Idbp2lKhI+O+IUs/A7ZhkVjIsL+k0NXcnMedFay/xJ61A6G8jxa/i
         7W+DToOBnTGM2T45qgMElauindtQeFWWOKlnQ98OP6AyBu4ejK25H82WtOxvuBp+05y8
         /WLBMcrl5LoSYG8462fellehapqile1+qEjgtpMdQTgfIDkGs3utOBApnbXczfkCfkMO
         fZ2g==
X-Gm-Message-State: AOJu0YyXGHR6+Ndx7PLtjVPAy+lh73MeCk0Q16Z8dXBP3jC9nPYF7P6O
	8cvt6iYnHwwvxnSu2/dLOfwZD5wRg8ZJJxwMrYHY0xYnlD4pkArc+6hOvIivUKo=
X-Google-Smtp-Source: AGHT+IF1F08ZntrtXaFyxdA7jLj1HYHz9j6xcKeHsk/iufbTeHvIh16YPQZeHOgI712uzqcJ/DBARA==
X-Received: by 2002:a17:907:7656:b0:a36:2df:5ded with SMTP id kj22-20020a170907765600b00a3602df5dedmr2008663ejc.72.1706615847139;
        Tue, 30 Jan 2024 03:57:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZUJtUyQ/vL5MwD2eZitFUhCNH2NI+X6Xk21ahRksW64edPD4h4r94tUKPG8BUKsPKk7PCyoO4mQbRc8EkYokE2fiLECIHdCpVOOuEwm/vtrLQWMPVNkdjjF/4JUtiwgakbTOH2kFdJFF2CX4jZWX3cuNGtZ/caT3DFIQOjTMWLIRJQ0qf5g+plhozootZ74W/nyjeKYC3pY9zXoisCB2OQPKE130BawTFyv1eKy4sCXOXeOEjMf6VVZkckF1xumHzrlTvo5ecfNUXnhabQOpTddI3utxgt1PflrX2VZy3ltI5UsB89AZDZ4YT/UQW90siib8VQEkcPffrReyo3GBPPtNycLptLiXq4UwEwo8xPlzIwneOiUIRHDVcTMe2eF5tt0g6g+PiwAv4WPiPaosEbIatM2mgCBl+H0tEgubZ/xYeX/UFWaTqC5Dpa2SvYQOiYPe+YO6hV6uLZ2CvCHulV8CxskAPvavJ45jWTevTlGPHh6rRa3uZ8HzuwIv24ct+QsIz5pdrJVZhxpQ6huyvD5M8akfJSHQSapbjMZf3W1QXC4mVcapMyyFKkCesHDYpabqDIo7ySliGZtptp9xCLuUYZFBkK7V4VZE+7pFiXPw1S8XCBAXB5sOBpWQuB7i3Gr8jrse6mcv/PQB4YAmbz/wDPH+FyWo0FpRKEfpwAMYCH4+4VDSn9ytVFyRJtxZD8UJEWgxsuTQA8qmYXaCC+yPOAImPUcGIAKEVGPvBmrUYeDKCn8cHneVbAwnlu+8GMfUvaKYerIyr6Q==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id pw18-20020a17090720b200b00a35c1d11621sm2016372ejb.131.2024.01.30.03.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:57:26 -0800 (PST)
Message-ID: <a03839a4-7f5e-44dc-a719-149795ed952b@linaro.org>
Date: Tue, 30 Jan 2024 12:57:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/3] arm64: dts: qcom: sa8775p: enable safety
 IRQ
Content-Language: en-US
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney
 <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>
Cc: kernel@quicinc.com
References: <20240130114102.4116046-1-quic_jsuraj@quicinc.com>
 <20240130114102.4116046-3-quic_jsuraj@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130114102.4116046-3-quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 12:41, Suraj Jaiswal wrote:
> Add changes to support safety IRQ handling
> support for ethernet.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

NAK.

Read the replies you got. This was applied and anyway it is not
next-next material. Please do not send DTS patches to net-next.

Best regards,
Krzysztof


