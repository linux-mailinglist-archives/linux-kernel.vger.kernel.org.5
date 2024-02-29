Return-Path: <linux-kernel+bounces-86908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D386CCA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78460285D09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD441419BE;
	Thu, 29 Feb 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHX8oLiv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B181386B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219740; cv=none; b=YYvASXTbbulK8FZDQJmcC5RS6llvdBfoKEWyUBOsSu8kBi/8gcCcDbStRq35ngxS59uN8Dm+JXBaNmmYyVcNXo5CfTRDb+XVgCDN11nM55Nv10W4VqV8J+gpi3dhIN+RMrSzSyilzfAl+z8NLAFc6LXWgfH9J9opLSQw6N0w5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219740; c=relaxed/simple;
	bh=V6OJiCShtzdvjWz97Ir+wJWCWv50bRJVMvZxVO1QW+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S65IKWzbGF0kVe51Q0RpFBb/bMSGt14GOCHxrsa7UXgIdkPPF5TkUySbQSKOBqKROQfPGev+ePyXPAb42U0lDVPpGi3p3iaMYEP5Ar40sj/HpNoii0VPM9aCirG+jKQkysRgzdEHXGI2yAQuHBJjW5pMDyv8ynTrltn7I9Z4SYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHX8oLiv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a444205f764so107059266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709219737; x=1709824537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YomR+DDsouVpMTkCKlMj3X1XHRJd3sZOjehM9h85Xsg=;
        b=PHX8oLiviMQwrGvWaTS7MxeD+jQGW8em6l1aMu8k/BC2aFJ0qicL9jKoZrid3hLS0z
         63VRag6Yo0hcdGpxi154BgRAIZ28DePG5UdGZ+UZWmWeAaSYAbKGWA3P3rsCVbcy83V3
         7r+TuScZFPzNQ5QO8/9Zf8XWBCmY8SIF8OVd9Pf6pZG15PDtJnI1G8yr4WA8qVI+JU2t
         g68HMYvzAH5NYMreTXgPXnY4qu9GgFNiGA1mpDiyFZjFNWj6J3rw2CVYJ0N8RCMOga6Q
         jeC+3atI4H/Du+0rdmj01Ufxw7bo8PMyMuEGVYBeipxjNoQf3AGulFWL2vsmg+lnEhm1
         BO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219737; x=1709824537;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YomR+DDsouVpMTkCKlMj3X1XHRJd3sZOjehM9h85Xsg=;
        b=FbbzJOLtgopsBuiIOWznxsBgc6bc00yrQlRynPL+LJwRCBj1cnw7nEwNSdI+e++3ci
         uUKQ9feiwaM4ugQtpEzB76dFHbVI2mJPWTyPcH92qgwV8wyUu27xRLhOel4fs7DZXsm0
         Rz+XXetdm4TT/uOyr1Miw7kr4GaaiH82MJP0UcNEfT64AcZDymjn7ly4yon0NtHpZP+M
         S4EA5nqk9tgW58Z18wLpazFvucuCe+tO9P2/HIdAQO16+UeGtbAmE8DjFXYazfBDFTS+
         NizNhzdkEMzP9bpiHJz/4g/ImvGygQDf9SOOZejYVmmFEGIMq9MLHmcFhpfI2lPYfAY7
         V2xg==
X-Forwarded-Encrypted: i=1; AJvYcCVO20btq9K5rcjQG/bawiFWiMlZhZcyCI3p9/YXiZyTPKVRPua2v2Q2fBXGw/Szg4Wp5UM75RBhQm5lmfnqtBr98p8QKmDUDNAWgJfk
X-Gm-Message-State: AOJu0YzsWuQxO0ZVXbuY3V23f30465xSrEXf6ZayTU5zJwes7SzZ2R1W
	Eel7liMd/WExkN/EfhEVuarjRqZl0kL3MKHIxkyY+1067i4gUtT2vYalr0u2jzg=
X-Google-Smtp-Source: AGHT+IEW57d6j7XDDz5Mx9iRBc88vALPtWhOXl7VICSIP2O7qZD+VkfxC7dUywt5yeIC67zGZt3+Pw==
X-Received: by 2002:a17:906:d146:b0:a44:1e32:a503 with SMTP id br6-20020a170906d14600b00a441e32a503mr1731569ejb.22.1709219736904;
        Thu, 29 Feb 2024 07:15:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wb4-20020a170907d50400b00a3ee5c19ee5sm769010ejc.109.2024.02.29.07.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:15:36 -0800 (PST)
Message-ID: <32a5605a-c810-4b3d-bb72-4d413d9f9bb9@linaro.org>
Date: Thu, 29 Feb 2024 16:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] dt-bindings: usb: ci-hdrc-usb2-imx: remove
 fsl,anatop property
Content-Language: en-US
To: Xu Yang <xu.yang_2@nxp.com>, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
 conor+dt@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, peter.chen@kernel.org, jun.li@nxp.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-7-xu.yang_2@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228113004.918205-7-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 12:30, Xu Yang wrote:
> Property "fsl,anatop" is needed by usb phy rather usb controller.
> This will remove it from ci-hdrc-usb2-imx schema.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v7:
>  - new patch
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> index a2932af2c09b..0a6ebb427130 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> @@ -74,10 +74,6 @@ properties:
>            - description: phandle to usbmisc node
>            - description: index of usb controller
>  
> -  fsl,anatop:
> -    description: phandle for the anatop node.
> -    $ref: /schemas/types.yaml#/definitions/phandle

Then why did you copy it from original schema? Just remove it before all
this work.

Again: Do not add lines in one patch which immediately later are being
removed. Such patchset has no effect and is only confusing. This
suggests your order is incorrect.

Best regards,
Krzysztof


