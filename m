Return-Path: <linux-kernel+bounces-157666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E038B1440
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4851288FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81813C9CF;
	Wed, 24 Apr 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEVGIFXW"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8A13C9C8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989611; cv=none; b=otXsdySp7Wi3TMGi1hrJl1GwZm5QqkJVRSUQGU3ddX3RBuF35hOMMiXoO9Vo+VnvsdtQ6+FjGr32I209rtJkcjqBNP6mgV01KlJ3lDl0RwGT1Tf0znABqCoM+4U30PBciYgc7lp/Y/HTFqxJi7N1D8Z8Y/OVthQVu7tki4AWkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989611; c=relaxed/simple;
	bh=sNqyq6y7H3czTBGecgPDxHefPtcbiiQFYk5mcfLGh6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2HjA047wKUgFmaTnDD57jiEJfgk810U2GYHElh4LNCs5FJBC2wCpcOTjzVMmghTe55rA/gWpSZbmMfJ2f8Jg5Yw4MLJT9QERqgioA22BBNDtObAmC81z18erX7Afy1vhN2kGW35SOhvD47PhZLyA4oowLGxWMehuPZXbDlX0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEVGIFXW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so2767121fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713989608; x=1714594408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1VIKcgsAHqC2f+MP6K6SFFkgVq/PwMZ7TgiEnmGAfw=;
        b=tEVGIFXW4rpeeM6utr9fkF2W38s66a2dEIh0SHs+iJZSvYVggkLJRxpKh2GysqOGEE
         Xz6BM859boB7giMq5RmzMl4XIzkaGijOFu4TyiiEQvpctXnMIf0i36q5mZjdvIfZBBA/
         Xl4qeXhh5NSocA/oeOOLNRbAJY8B+bMajicI4p9HlC3uClnd/PQv1PYQTmeHzL0Ioz0H
         NlGF5f7C8r9NcuH+XdPeLFN81JMQAIcMhoQd+zNSJulSgUyIKRCdyc4tFpUKs5O2zv4Q
         fr02Skqt6q7JoLw1cD39930hJzO3Yq3e2+Y1dOleyQkJGgkrEB/KgXn/Y8WcchxcCg3l
         9jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989608; x=1714594408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1VIKcgsAHqC2f+MP6K6SFFkgVq/PwMZ7TgiEnmGAfw=;
        b=mQDOFzbnde6cyO2JlpYpgsAP8aTb2HxTl/6/SBdFVdUAXh0mT8q0e9ztKfj262vk22
         7Evsedld1LoVdC3uMfUIPP/g0J+joXoB0V0dmbmfeiWs6Qq27a6K4v9zugTmxLWLDMKT
         KSHX7qT9M65/PlmGUfspTnKD6HF02VOXX2wbdVgieZPqiaI1LgBHL7guVPa5XTA6TJUF
         nNeRF/TMoI8J1GhPFzE+pJajnOYPEZJLmd15uDN+vboQm/hoJj8gNSyOgU86PS3GJqDQ
         6O/L5kLUjCTh+7/Gip16jbzOYtQ0oyQM0TCs8nHi7zf1BmHyXI5OwLB+Y9pRjiXEmNUC
         7Okw==
X-Forwarded-Encrypted: i=1; AJvYcCXCnyUXbTKeQFJ6Jf5lcFiRKRT85dD6Q3PX9EZd5mtyb851Un3fdzf5LOHbdqrRpMKIxSWwpZeYCubaMuPOrKcCNMeSlPLokCJwHxml
X-Gm-Message-State: AOJu0Yzg9ZktCLluWhid4wrOsUq6info+Lzna2CJPYP45GKD+9FmoOMQ
	WV0aeHUb/kBlH2oxj3OnvoAdaUBU2MDtXDAg4sKzQSzpsYP5qVcbYORTFpW2Ygk=
X-Google-Smtp-Source: AGHT+IF0z5d2SuEtnxThz/DS8L2JAH1ZbLC/6QxjxTDIakRRLrQTokCWhknjfh/nR/NbFXdJxFtKDA==
X-Received: by 2002:a05:651c:a07:b0:2d8:8b7:76e3 with SMTP id k7-20020a05651c0a0700b002d808b776e3mr2590960ljq.11.1713989608620;
        Wed, 24 Apr 2024 13:13:28 -0700 (PDT)
Received: from [172.30.204.223] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z21-20020a2e8415000000b002db98d0f2c8sm2061822ljg.85.2024.04.24.13.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 13:13:28 -0700 (PDT)
Message-ID: <e74692c4-e027-4800-b80c-449fb3ef9bdb@linaro.org>
Date: Wed, 24 Apr 2024 22:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] soc: qcom: smsm: Support using mailbox interface
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
 <20240424-smsm-mbox-v1-2-555f3f442841@z3ntu.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240424-smsm-mbox-v1-2-555f3f442841@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 19:21, Luca Weiss wrote:
> Add support for using the mbox interface instead of manually writing to
> the syscon. With this change the driver will attempt to get the mailbox
> first, and if that fails it will fall back to the existing way of using
> qcom,ipc-* properties and converting to syscon.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Looks good!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

