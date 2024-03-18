Return-Path: <linux-kernel+bounces-105893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB93087E61B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66135282773
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E872D057;
	Mon, 18 Mar 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAU34mNF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DC2D047
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754852; cv=none; b=LS9ykZbrXoHU22tV0ND1Q+15GF4IaAW40Gyk3PMqvyacLFowxOmSeMt7BoVZ4/r6iWO2EEc6IBoWLWuuXASpnVCG3mHKptsqcfmDN+5g8O4TKUDVGhwO6zUZB0RSlDcgeevsbztqBq371tqH46W1CYZjhnnKZPBHkayUbV6vs9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754852; c=relaxed/simple;
	bh=7RRzsd940VesbdljysukgA3ppk4C5jd/NTCqUia9jTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkncrfYhecE0KW+/iIFnzUUN0+LmRIjw1Mt8xDqBcB3sZGC4w2mBBKbqLPzdB4JE/qYP53zv8ecrU8p6RshfKzCHJbY6vp3lvEMnjhRbh0V8mOL86pNfIc5QVTTEmr+coyNOiNZmNq+uguWyoUSi8uyNv6qmt3TWQJUl1MLAetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WAU34mNF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512bde3d197so3415813e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710754849; x=1711359649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbPc2grsn8ubyCfu19TPDk39rt7ZtyWx1KZ6ztW2BUA=;
        b=WAU34mNFEzexvwQKjVy6+JM+RSZQl8KmnMQliNIbc01Ne54/k6g0+AU4dmbGSUwy/6
         CDwoNKM+KxZXS/mY3nNSrBtu9q630lgrr1CtvRRYcCzB9DB9W5XqR/Pa8r0vUY6HXPsP
         uyKgnSPv0tb20U7j59BIf8/g/Y8t0x1P0TGc4soPlxCp9WGjMiDKMn6mBdAEcaT6yTAC
         Hk3yD8U/F8dJR04XUdOoF+L77LdFz33GkCdsvnKDRTY2sT0rUGmNJQcWovDrCPRBWAgC
         A4cQowiWJ/lqyMir9irAXJiG80+rsY9WPXyiBat10XQGMB3QEevF7acYdGL3MRUx13lm
         ylIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754849; x=1711359649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbPc2grsn8ubyCfu19TPDk39rt7ZtyWx1KZ6ztW2BUA=;
        b=c4xxSgBARLaDqCkBWafWOz/kX+KMdqD+BqRzHisefuc84PB2nbASGow9mJamhe0oSe
         l+uf5nKS3ykD8YKcqwibxIoRJ9Mwphmv5CCS3DmKPATJfjPFLlprAf5obskWFro3Wo+N
         JuL5uVAbJlhitpx8hG9OWO1qBArI/Oqgdo5vGMKV7ped80Wk2ufYEwWveNp7qxBy2Kr9
         AAa/1j0ENBGXiShuCnBPaniN7VYfiRzNHJklhHBBZZ+v8T6T7JPqYruP8hjvtQpc9069
         mfImTwFR0c1Sb7xRHbTvWCunS9yt2VCrIsvXEJSim32ZwXfCtoz+rcRCbmkdWsLYLHIT
         ntzA==
X-Forwarded-Encrypted: i=1; AJvYcCWzo2t0Q44Qiima0AR6k+QCiMvtBCNGsIQexWHqSL8/Y8oOxYwOeu3RnJMrhZ7MYmca4diXpl8A8LIIXjrpNd72u99IWbVb5U8CuKAF
X-Gm-Message-State: AOJu0YyYbcQcTqOZMzsISGxHdhRNeupfIXkdlbthWZu1lhAjmzMTIzz0
	f+bvcF6WJ80u5bEai19H57rpOCcRAve2bucjvcn1i8j46gNkirFjQiyCJOShIO4=
X-Google-Smtp-Source: AGHT+IEKP6RKoAYAEi3GRca/Mh+uZFVCwMvaxiJvWpR5WEyyJhT1ayzgEkhi83oDMj7FRlI97lfNtQ==
X-Received: by 2002:ac2:5983:0:b0:513:c54d:7bd1 with SMTP id w3-20020ac25983000000b00513c54d7bd1mr7677187lfn.35.1710754848789;
        Mon, 18 Mar 2024 02:40:48 -0700 (PDT)
Received: from [192.168.52.106] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q11-20020ac2514b000000b00513e3190eeesm642816lfd.171.2024.03.18.02.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:40:48 -0700 (PDT)
Message-ID: <fcd36435-ccee-4467-b61f-2733da5a9cda@linaro.org>
Date: Mon, 18 Mar 2024 10:40:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8974: Add empty chosen node
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318-msm8974-misc2-v1-0-f71668a2b8cd@z3ntu.xyz>
 <20240318-msm8974-misc2-v1-2-f71668a2b8cd@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240318-msm8974-misc2-v1-2-f71668a2b8cd@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.03.2024 10:24, Luca Weiss wrote:
> Add an empty /chosen node to the dtsi like is common on most other
> Qualcomm SoC files, so that various pieces of software expecting this
> node to exist don't complain.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Kinda weird dtc doesn't add it automatically or complain about its
absence at this point.. perhaps it could be taught about the latter

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

