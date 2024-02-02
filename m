Return-Path: <linux-kernel+bounces-49370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FD84694B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E0A1C246B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E317BB6;
	Fri,  2 Feb 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpwZg7pn"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1417998
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858958; cv=none; b=uhy5BMZZtvkf5ipwuTvaiiENE5hBgdQzxLu9xwszrmflmB29pzFZIsIJ2wLIrV9mH0PLIw5cbIMwErOQorSgzm6NBuSqdAdRKeyrGLjmUwTCH/7uuTlg+y6HsIN8YEvbvPQLrwH+X+0PWQUzgz/ruJ4ISrEOHfvTtahrvwChZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858958; c=relaxed/simple;
	bh=XkazKXRUenQO5J7STXT9Fr6bXUUP6LXUQi6Ou5A9ZJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2UxTmrkOugId53JzxJbRmuKFnBflhj+G/TMGY7KhRzf42B+PVIihNfx2xr2OwdyCx6KBydqCHMlv60CZyb6xEXJPXuINXlwmMTQzZL4c5YMrUhDGrmpYQAQxQrPps6RVCa9SK8CSl+/w5jIiI8iI615HhycnfSkd7v5NblYp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kpwZg7pn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so247355466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706858954; x=1707463754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRF5sYo98ckV+7UPDrqZ1AZRgxQhiNObXXT7etMsNTM=;
        b=kpwZg7pnJf5FAWAmvQoVe1O05vW9m7pxgSSqwJngj6BKibA1IBS6mnmwDnKLtuaiyT
         MyAucAVdEDui0q8oF69bJxnFh6rWzwcirh9gFKGjSRCCWqaoc8fk4SXiGumlNHkRvfeE
         bzsaeQCZX4cXF/H+I37DGW8faQWFOkOju7tu5bN6CcWj6axLD7MePpPwAG8ctBo3jXs4
         RgiXFfj69Ywg7WABJ9vsY47JZ2Hw7TgugMSSGZsiAFx7sDM37tBRbSS5YN+mKSADA7cF
         WNB5+VXLM7tySsywSRKHH2v5/JbWf+wxJc9L8dygAQJQE8dkhCXMoQAqTu4e9p1Q41Aw
         55EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858954; x=1707463754;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRF5sYo98ckV+7UPDrqZ1AZRgxQhiNObXXT7etMsNTM=;
        b=Rq0QNsgyJA0/t+kIWAvCeSJWew6pb0qBEkO5uX1z9pdd9fO5g+GgKOC00pvSe3Go7z
         f4FY87MD96DlCRAOmZOsxTzqexZOwwsqMExNSUNhwbsAWGCwrpIGdUd7S0NfaihP3ZGD
         VZykr4HDBi+ltEdy3uzuFZCtS3Uap/n/aRXsfn8y0fuagBdLqnSIrIh5veq7nvQSh1O4
         6ZTFwVt/IbFwxqJtgMFldiztpS0LZ6TkbfamBTRCFNjCFC5z80ReZQwNR/GZs00Xc6G6
         ++s/IP/86dbrpkEaZK+9O4Ye0kdJvdjHos1BTATlT7tG4MaiidCWBqBcu7nYOHpIhNBX
         2JUw==
X-Gm-Message-State: AOJu0YzMbbsQqTJ4bim64O2HcPgfPjxcRTY30a4txb4DzQxi4H0tCwXf
	OLeNUGdtPmFJNG0GlEjRh6pFDSOXvseaYYCO2XwnIvDbCete2pnq6GQ9bkx80cE=
X-Google-Smtp-Source: AGHT+IF/wNBdQLqxY064yFgektHzMrB0pEXF6QjzPgSdPG0f3CS+TftaT1Wp4/KUKKiH3KgoCWQeew==
X-Received: by 2002:a17:906:1b57:b0:a31:2119:90d7 with SMTP id p23-20020a1709061b5700b00a31211990d7mr4864362ejg.38.1706858953894;
        Thu, 01 Feb 2024 23:29:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcauxxc/lkGwZOCA05VcEim4gUL40lXkyYLFfBCxP1wvZqwA0Da8CTkcr7TgM56RTuiNmr/eFebHcklcI7zAGDiqmNbfOW12UZHgC7veHCKLSznsm5apBGtKowq1oiXgr7bSQtN0tv4oQxdWbienLZQgiIzo6ffKMRk6w6qBBDL7SJGNeOQwPt6yTaOcnSM4+CrIlwikwXbOD1AvxGPwdbfS4Cy9KoLP/DlkYb0OpJtzR3kH3sg1Q0wq8jF5GFMr595Xz7ktGNryzNZDlOXZgym97HbfNJ+SovavE1Q6mAhhmZY8COGkOzMLvDH0PbfzCUwVZvTn/vmBoSfs1IYM25OeSXOl4SkmaPVXYqmZ7Fh16SJZXA2KPSgF2A1Tsvj2OyUttwr9zxEMDlku9tHbxk2qFdNQkGAaiI9kLNayKUw8BcsQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id tl6-20020a170907c30600b00a370f877b5csm236627ejc.152.2024.02.01.23.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:29:13 -0800 (PST)
Message-ID: <1de7cfbc-3507-459f-842e-c9349b2f05ac@linaro.org>
Date: Fri, 2 Feb 2024 08:29:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: Add qcom,pbs bindings
Content-Language: en-US
To: Anjelique Melendez <quic_amelende@quicinc.com>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org
Cc: konrad.dybcio@linaro.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240201204421.16992-2-quic_amelende@quicinc.com>
 <20240201204421.16992-4-quic_amelende@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201204421.16992-4-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 21:44, Anjelique Melendez wrote:
> Add binding for the Qualcomm Programmable Boot Sequencer device.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

How is it possible? This is v1, not a resend, and I never give review
tags not in public.

Best regards,
Krzysztof


