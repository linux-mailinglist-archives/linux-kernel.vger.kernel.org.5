Return-Path: <linux-kernel+bounces-44749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE48426EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60931F23FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583B6E2B2;
	Tue, 30 Jan 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMJnfP2z"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377926D1B5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624860; cv=none; b=s40fcRPLFwdw/se9pAHKXPrW26bp1eAhITmrsNvTCFJsaPHoDlrfFrZb+7cAMvkMO5JYPH6Pm/DmSyG9xLuK4PMXlJg6xnt9ndWXQzzpzjPppfwdSboUKcxKvKZiazPy/bcSjN+m1S3feVousVLFQnmLzVYV7htQgk6rk5KO/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624860; c=relaxed/simple;
	bh=1f5OFWRGCFNuCnU0woByAM3fR2l/VC/oHJ1U3YhfhlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgK3+XfluoFxVNO3jLH1gcgQ+q2ICsIIsOO48ihS28+cBdcOmtF5brFkgqgnmtsoI2hW9iIqz/IV8t3YiqMwOmsPJnYPYwC8WrjPisIsOwfy2HvkIKGW0MpBYByEuFjBM88l8qor80jIwJQBdGXzarRH6em4JK8fO73PVi8ct2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMJnfP2z; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3604697d63so193014666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706624857; x=1707229657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EECbX8jgSq+DfODAOJ8mQuJ3bJhPgpsfxnfB2ud2Lr8=;
        b=WMJnfP2zxCdV0tQcQRJb4VBNJd7HILoTETaWa7xvSdsYUeHYLaVIrcRySauTVOaXjv
         5LW1p0njPqvj5Xy4fikYQThm0RaXs4neU+8MVksnAbeE6et8Whlpb14+CsyvkYyRD0cR
         BF+75upDTsOvM9Vl5qw9ibf032y13LCLeKy/srJderYMVIl8UdtfQ0Fi9z764BTEdDVM
         eZ7OWsg2hLPg8lpwlg8SAJeS+wAk5wEmwWZ7ZD+HgbHrTQwtx1i7vqY961m8c3xav0hM
         epJloM7Ddbt9pkuzX+52BAudpxmTxWe8Jeu7NPbyMkX8tylccgvm0c5pfFmsF9BpYDEl
         +aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706624857; x=1707229657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EECbX8jgSq+DfODAOJ8mQuJ3bJhPgpsfxnfB2ud2Lr8=;
        b=RmxBtI/CTUC1h3aqfcJ9Oq0tuMm29ICk2fcyU7cxCq/OyOB9oc8llId9ZZH6MvtEyN
         06snT2qp+FjKiidF5jeBvpF3v6ymn6fB82qJrutRrqhXjOrV1VtPOaV3focwoVbgrPlI
         aEPe5Bto6unxQyQaUXru7382cUYpgy+7NGVlW4C6+ptISABjGNjhLlbgKqVt7kDEoG5U
         VJ6RcfeYzR3ukHdKLXfq96fYyUpyfvyED0WmLxcF5qfhmE4jkTGmXndz8uDIoV004SMw
         AUeV4kjt0eCXair+GzyhUczMnCE5uTjf+UwmqiuyTwrLVxljCdDcrsL7rprIzz2MDFGP
         L3KQ==
X-Gm-Message-State: AOJu0YwqeuTpeYPskFfpdwfJU0g85yQlbB1JRhecKoNPm67smJW1SZnU
	NFl5gg18s97AlhjfPBuxdlNYa+uNwp/ARKiTeoyM+I2a/hdBkZE0BeFAAJyONEY=
X-Google-Smtp-Source: AGHT+IEhDwot7I0Ca1EErZYG0g2gyImoJB4jCcK3FTPIxS7iueWSzoFuwIkQmoA+D3cUQxOJ8mRJqw==
X-Received: by 2002:a17:906:4eda:b0:a36:50fb:37ef with SMTP id i26-20020a1709064eda00b00a3650fb37efmr187019ejv.28.1706624857388;
        Tue, 30 Jan 2024 06:27:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnK5Kra680jGPQFlC9Zs/4lIqIMu+w0s4ov8PcmJoaKnb95Fm9Tu8/8hGnyGjnG4ZZkjezJyZGe+wBzEQpaktB9BZKM6kiecN5wI/0FKrJ2NT4/00weUSmQHga9EZoId8HDZECK9sjOLjTMt0OwTIkPbTkwwNvkAPPOHbSbu7h3eudPUTCmseiG9E77jzyyNlIWCqOrFiUjABZo4elqO1LALg511NPpT30Io3FLEa12z8+lezMIriJ5kdHRNvp84tuoYeTGdiXEBBX2Aa9klZ3AXcJ62MmvGsBVBHFJ4D2k2Q36SE7+SSfSJp4iNn0d+Ly8vS+LFo+PNaBMCO5DCAy1o1USQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id k4-20020a1709061c0400b00a349e943828sm5148913ejg.75.2024.01.30.06.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:27:37 -0800 (PST)
Message-ID: <9016fa2b-fdd6-4124-a53b-e06d45acd673@linaro.org>
Date: Tue, 30 Jan 2024 15:27:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "arm64: dts: qcom: qrb5165-rb5: add the Bluetooth
 node"
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240130130930.18683-1-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130130930.18683-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 14:09, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This reverts commit 71a73864e144aadaa582fe8296ef73fcf3ea7377.
> 
> The bluetooth module of the QCA6391 should be represented as consuming
> the power outputs of the PMU and not the regulators that are PMU's
> inputs. We will be able to model it this way (together with the WLAN
> module) once the pwrseq subsystem gets upstream with a dedicated driver
> for the PMU.
> 
> Thankfully this change has no corresponding DT bindings yet so we can
> safely revert adding the bluetooth node.
> 
> Fixes: 71a73864e144 ("arm64: dts: qcom: qrb5165-rb5: add the Bluetooth node")

I don't think that dropping more-or-less correct DTS nodes is a fix. A
fix could be changing the less-correct DTS into fully-correct DTS.

Best regards,
Krzysztof


