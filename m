Return-Path: <linux-kernel+bounces-85425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B486B5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF2F1C217CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FA3FB80;
	Wed, 28 Feb 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvIWBoMw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC16EEEA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140815; cv=none; b=dONAantlm/WROh5oO8vArVvI9+vtEQ7tW43wbtdP4FVg2i66vMkexxchdsVF3q5s1aGyrxnO4qva36wJyIxqTzPVY46ZVZXzfWxq9Ot9GnnDpSbyP5oPlb48BaNH29Q72TMWOrUhwVEllS1x1iHALNjBlxtIbt2FjFDTQZP4KDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140815; c=relaxed/simple;
	bh=YnzcLHGhkoAnnjtHn3JWKUjRsN9NYTibQCgM8LFyDQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eg25C/8SdaW5WKmDOyQx0FcUzIjR7UwB8WKB5sfn15UMYyXgOs12AsHB3KIRcymDFi52x9CNDi/vYEgGU7NHF+yHcIMUcLZPP/FEd//QPpS6TjM/7lXyp1xLJFnQ8eLCkd/duIdXBjoIOSS+DJOYdwtX8ARCcKV+KRRR8jLnHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YvIWBoMw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bd533be0so6883064e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709140812; x=1709745612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTtoNXU05+3x+sA+PfVAb7gBpkSmywqkYgS428yH0a8=;
        b=YvIWBoMwm+rYrDHW1F18DPLLczGjwByh35dD7m5Ia/9zRaCvVxnop7ibeOuXTU2oD/
         YQu+POX5nMqAIOdopgiv+3T+88C9JegP4YAeumovX9DDN+jFOImKc1C1M5VV5WeBQoN7
         vuBX1tKmKpta2WfXXDLfa0bNC2Q3YUl9+5Y0hPfsG8S6gLa6Sgzlgz60Ofe8rfRd0uMp
         ZFhxdgldv9Jlj0Qi5TkkxQpU6g5RkdHXsr+s61yHxa5epaSzgnYv2DLtuiSKELf1j6cJ
         0v80Bw963yQ2dJYCfI2GoNJqWQCofJgz6HpzQCw/wV1ks2yCRZZ0LVHXhAxrVviNq6aq
         JukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140812; x=1709745612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTtoNXU05+3x+sA+PfVAb7gBpkSmywqkYgS428yH0a8=;
        b=czrXNNiWt+Qbj231E0ZmsVmJ6g7A99p0v5NtYOhGENFeuCwQqEpnftMEIqaV8v9q0p
         MtuNndvnWyh+DQcfTo3YHMafqqwsG9t4Py2iEiIpW3scdDgcMwMzFCVzrY2m/H+bo/Wj
         ug6Pjj9HXfQDRty8sCeiyPuyQHOglTL3QNMvk8klx/oQ9a+aGt/quR7mgBT3MH9KBivp
         3aOCoU/1LXWzIbmwb01loejtr3QJrWHT5rtpxKHdDNmLEZq660wonUsSoRN34bW4WPlH
         n08vkV7dC2v66uD7jDMcJ7SlJba8bnQljcdK4+4uBhYvGfNn48iRKacqHnwAycHKcnVq
         0ugw==
X-Forwarded-Encrypted: i=1; AJvYcCWkXScVml9lUzpS2uECeLWl/tgW0XDfMKpDUt13YesZXaveDyqTr1dKqRhycd5WrHKXHmm5LncXYf1VfDoaW49wezopFMqXLa5zuxKF
X-Gm-Message-State: AOJu0YwpcyC8jp9gc6vhPFIw/5A6dkKbBS0YZsLgiZQkoWSNx9aG7sQT
	Z3uGJDlJE8lQrEc7ULgntI6O3WW7eYn8vxm0z2eDdpW+/3JgPACnRgELe+BssfY=
X-Google-Smtp-Source: AGHT+IFOd+Zu7qeZ6jYL8j3/S+KSJEaWE5dSNrBJp3nEw+bc1IMqD2pna0G9xWgzNH2yGakVHP+ZWg==
X-Received: by 2002:a19:5506:0:b0:512:d06b:2804 with SMTP id n6-20020a195506000000b00512d06b2804mr193921lfe.33.1709140811931;
        Wed, 28 Feb 2024 09:20:11 -0800 (PST)
Received: from [172.30.205.146] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id j5-20020a19f505000000b00512daaef13bsm1593760lfb.102.2024.02.28.09.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 09:20:11 -0800 (PST)
Message-ID: <04b1c7c5-37f3-4673-aa0e-8c39fb5fce7b@linaro.org>
Date: Wed, 28 Feb 2024 18:20:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix duplicate return in
 qmp_v4_configure_dp_phy
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240228-topic-sm8x50-upstream-phy-combo-fix-duplicate-return-v1-1-60027a37cab1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240228-topic-sm8x50-upstream-phy-combo-fix-duplicate-return-v1-1-60027a37cab1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/24 18:05, Neil Armstrong wrote:
> Remove duplicate "return 0" in qmp_v4_configure_dp_phy()
> 
> Fixes: 186ad90aa49f ("phy: qcom: qmp-combo: reuse register layouts for even more registers")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Somebody was just trying to go up 2 levels up!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

