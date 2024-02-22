Return-Path: <linux-kernel+bounces-75734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C8E85EE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8D285221
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D910A05;
	Thu, 22 Feb 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFrikoh2"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95CA2919;
	Thu, 22 Feb 2024 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562354; cv=none; b=oLxvZnN7VuFFDmUckRaBfnKn8IORFdu/vYrusRylqdOaFjCmDKzOw1B5AKio1cLu+SCzowf2IqeDavlUqeTlxnDiQKCyryaVUMYMyIUlKQhSqjkKvD/nUK4X2vcQXQvyE3f4u2fXSNDUA1JQrLWSrg7iR/2oWYhrSvIAtA6ZbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562354; c=relaxed/simple;
	bh=ifKIAem4yfEoVRXVhc3MrFBJtYEZ/51w2ITPAL6zi78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2ANd/bF66E+QZqRF1bPtFBgGtul5JJ0lx2MJ27ltKOEDT4SD/S4xGePJCBsal4q2u88ADaMxCzeec+f38fGDwJ43ukGkMj+6SSUXRCi/TUTumpGKNtcxLf9+lDLgx2yxnbqeFFpJLOlX7DicfSagn5NAeX/MkBetExIQngZVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFrikoh2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7877dd9cb40so153909085a.2;
        Wed, 21 Feb 2024 16:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708562351; x=1709167151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJDEO7vyFXsjZSDLvvopvcbjb0QZuTT+aq/m4OvzmuE=;
        b=UFrikoh29drvZy83/qYoJDBW78iWlcKgVe5QclP8AVO80jBPlNDSu1dktLTaciYUR5
         PWqOlu5b9sRzt34aYJMn8JFLqNbmj5lt4cylUwSxNULd5cYedWf1M6NzfcAEA147TxE3
         Sym+GZs9aeRb49QADkw8yJMEh0MdTrMXa2APcYPPBW5AbkbhaxjZC+897eMWCRTRNm8E
         8TJ0eNXFsjS5xOsIRlAFqBffNqZ4CfeCXzNuKc5yb8rtUNymTWi1A8PdmhcV3QIyrwkt
         fg0VT7dyOc/iXTbjjXKheqDrzIU6HE7VlBUVzx1v9r/xXdgNleyWRxLLAycE3gvkHPAb
         pQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562351; x=1709167151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJDEO7vyFXsjZSDLvvopvcbjb0QZuTT+aq/m4OvzmuE=;
        b=En4m8LkL9WJG6MckBbaG68s5ie8Dp9CduPqB8JKU4GQFrnRuN1+x31H6B80rWDuAjr
         VKL356cNkt4HDiq3FCMIflkfpD3tm5Qb2pSPSspIuxe2wI311DA6WTl+kQgxZY94Si+s
         FsCGWtwdISNgtcs3tOcU8rV93E8tUWV7HSNNCYwCAPCbGQB5KZBsRQtWBCObFa8B29C3
         9om+GaRIwr5c9cAFzmExa8tcPADKcKaqDNENg79KSx/mfM8qK7U9vrn2Xw4D7pLLniPb
         n4T8Wccq5qF4yA0LTS7YsO0b6DkmtzrpDUP3k0viHvrzVr4UzzWcY0ktJWy374dHQDgt
         e0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUOBYEQxuo/vRXZgwyM78vIPXKPD3yHizz7pTqNgT+Wqthzr8C4ra0dRIQoRmLpi6CqL7t84H5HIjQrq0ESfv2OmDv93kiyF03/Hj3sd792ffZhYci2za5BpawPctV3KwCR2LqBE54tiA==
X-Gm-Message-State: AOJu0YyyqJ3tDD9etfoD/x/GHGfrmtdi8UZEmtyU36XupmuaRgVW7248
	mPYjmKWV8QVKFcOEpnRrTvuYsR9CDTueq4jAztFIZvl4agEtPShASKMCfXYs+A4=
X-Google-Smtp-Source: AGHT+IHNa+pjqucXOsTybFzT9bvCneHMvXA+ivC4T9RMD3L/R4kszup14jb3j2D2IMaJI9x1yCNBUQ==
X-Received: by 2002:a05:620a:146c:b0:787:73c8:c77 with SMTP id j12-20020a05620a146c00b0078773c80c77mr8007138qkl.17.1708562351556;
        Wed, 21 Feb 2024 16:39:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05620a0f8f00b0078401adad7fsm4811165qkn.133.2024.02.21.16.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:39:10 -0800 (PST)
Message-ID: <c145b90c-e9f0-4d82-94cc-baf7bfda5954@gmail.com>
Date: Wed, 21 Feb 2024 16:39:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] ARM: dts: broadcom: bcmbca: Add NAND controller
 node
Content-Language: en-US
To: William Zhang <william.zhang@broadcom.com>,
 Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 David Regan <dregan@broadcom.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>, Shawn Guo <shawnguo@kernel.org>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-5-william.zhang@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240207202257.271784-5-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 12:22, William Zhang wrote:
> Add support for Broadcom STB NAND controller in BCMBCA ARMv7 chip dts
> files.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>

I would like to apply this and the next one, but the use of the 
brcm,nand-ecc-use-strap property which is still being discussed would 
require me to wait a bit, unless you want to split things up and add the 
NAND controller node(s), and then issue a subsequent patch which adds 
"brcm,nand-ecc-use-strap" where relevant.

You have a few days to decide before I send the pull request for 6.9.

Thanks!
-- 
Florian


