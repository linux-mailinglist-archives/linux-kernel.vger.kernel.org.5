Return-Path: <linux-kernel+bounces-38898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15083C811
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5EA1C21C62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F12512FF98;
	Thu, 25 Jan 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMt0/VGy"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053C19472
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200309; cv=none; b=q2oU+1L174wqMP/S9IZo8ilEGIZG1EknK6F3imsS7iZZpNE7ztVTiXv2pQt0kwbpipYwsqUY1E4FQb0l2vck+6V2jTBsMAJxsRdAat3Q8abuvQWvZxud1zLg0QJFQNOoBiBjc2vpqoVsa5TA4UFIOR3yBTmg2iDSuGxb0Nf+8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200309; c=relaxed/simple;
	bh=MZKWkX75/WD66NsinU0R8DD7Gnp8wiXbU1Jb0hyFr+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFAtkxFPXTcOz6+7YI3LyQ+xOL36VmW2pT/10D1yYLRwM+McImFaUmXA3jMXrby6/+a+Z+6d9VoqQhn31gjWmfGwH9tU1CGxpN5JwMhfLR6JoLCpsOFBaZ8akMHBpkDcd1jirPj7BkoDvpRcXlUgYd2bQD7qBHQDS4YaJ1fRUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMt0/VGy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso10298014e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706200305; x=1706805105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHt9cw9hi+emNh71kc/Y1SwsbEiHyqR1F+qFgT8zHaI=;
        b=mMt0/VGy8hcd01n5ZwINxofsG1T38YlxvBHfnzw2vKMv0ZTUhGFEA03oTxvZxWfA7S
         8lxvrb+Ri1c8TAAzf+QLBXrEHqZacEcJRbjN2siU9uy7IGdZfSwxGuNMtfDWGPS4IWj5
         z8UpQWqofHmild1/CINxWyiXLv0mBQ1udLLub9mJQCdDkJjKHMUcYVbqMgSHYbUWwdJ0
         6ODl2MR5NyYAwXbwW+ocdi9dNQ9rgRfhqFGH3u87QCR5lL6mghQf3mh7g/elKmXTK9eW
         tfbRZXk1JoGhG+Tp5Cl92omwWR7D4ByCugZqSj46KJlotIU44gxMvfQKU+p58Glg4bRL
         xAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200305; x=1706805105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHt9cw9hi+emNh71kc/Y1SwsbEiHyqR1F+qFgT8zHaI=;
        b=g0qIzenEli341ebgK/OT6EGMgdPAm/+400y2AL/8QoBiZwg62YJ0mKfxcpEflflMIi
         vFoz8aWVMMLmAcWQZVYzUt8Vnymp+Pwms3LC0+ftNzrT+oBXBDP5FDJgg4fbF7LmCI7t
         HyRC5MK7rniN5sROT1/3lSgcFN/CDCyE2MVrsRFfhiri09JZ8dBC0ipUGijfm3b8iOS3
         5hwL71We03eZ3wI93et8PFMRh9LIXehC6G0VBEQNWtgrRRLegkwQGuLpi0baPvmw2YV4
         TZ9lrzb8vHbsoYSUafvw1/JMpmpEDCvvQq/v0inObrTo9HReaEfMtlx3dDmrsV2h2LWf
         iqwA==
X-Gm-Message-State: AOJu0Yxn5o1bWWfGGcuQCnnGAAzbqEp7n01GEPhACg+vJeM4/T6UDg1q
	atPdNViYOWUzfUq8E2/UkbWDqsBhUP9uJzhJEPw7fHzJ8JoHAbYN2sdNq1kI0KI=
X-Google-Smtp-Source: AGHT+IEIxBsCNyRypg+gLOgOnR1oEjXMKLRsv11AIrGxHqtyz4LYV+aOkVm+21pMQfUYxcNuLGfUJQ==
X-Received: by 2002:a05:6512:3a8d:b0:510:146a:a122 with SMTP id q13-20020a0565123a8d00b00510146aa122mr63068lfu.46.1706200305167;
        Thu, 25 Jan 2024 08:31:45 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b0050eebe0b7d2sm2931938lfs.183.2024.01.25.08.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:31:44 -0800 (PST)
Message-ID: <e018d258-6503-471f-9aaf-88d8eae112ee@linaro.org>
Date: Thu, 25 Jan 2024 17:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: apq8026-lg-lenok: Add vibrator support
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121-lenok-vibrator-v1-1-d4703ff92021@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240121-lenok-vibrator-v1-1-d4703ff92021@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/21/24 11:09, Luca Weiss wrote:
> This device has a vibrator attached to the CAMSS_GP0_CLK, use clk-pwm
> and pwm-vibrator to make the vibrator work.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

now your mainlined smartwatch can wake you up!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

