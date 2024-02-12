Return-Path: <linux-kernel+bounces-61388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD128511BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E6FB24547
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928E2BAF1;
	Mon, 12 Feb 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dc8T6tEN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56875F4E1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735929; cv=none; b=GlggmFtC9/BXTfQWgbJv0w/DZXY/ZABOUQaez61IjLXIL5yBISG6NT8/mmuAcNO1E9AmXFxPWvb9BXQlvoydGF6fN3cBSYgCPISnGPxDr1mJqcCCSx+VQrkuXpyLQyKoQaM0IcqNBfiPeuj1aMtzeJ7t/wraTbQa6T0m6pWKmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735929; c=relaxed/simple;
	bh=J7reBNqJq6CK0rkUDfuuUDDZmuDIhyJcsro/9tVB4DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mdlxCzorYaIBMb6JP3NKrgxX9wRgWudlOJdSSwy8RR05z+tPXNB/bxw+DBPnhNqm97uzcXez9zvjhG4QVg+iLmZ4VAgbv8wQ1h04vABhgkC7A4QTijH/7DmYRMYGohN85RnISo/TEQH/vIVQvPiVgtqMlgDPMl6zyGo4z6r7cEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dc8T6tEN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3864258438so558046166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707735925; x=1708340725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PU6V0metwPXw1DLE3fEvkcye+fWokLPWFeUE9bD0e/8=;
        b=Dc8T6tENk5owdZQ84jiMiXtFMer4QdK26eCSJ8WwbxbeF9VS2h+J/2W0fGWv5Cl4k+
         oUb+941vHxpaxXGbgSvzIRBRumDqqNlGwx5dMcxeju5WPLggagUzQkIvA4ZhPl53Jsnc
         g9tyRieXi9T+FAMVI7Cfx2c3/XZCLpdRuhmzhnN5shDq33mZjTq3t5iD75esSOUhhRFh
         2g1YfVMrfmo54D5W1rTjYsm5JuriJ/I3sySVx9SSQL3thSWpn649Mpx3mM1OPBKMh1UG
         /dK/+FWSbUB0RqsgX1nRVeuZcJ2MCST5s6a4fPmYV5yQmu07phsk2SHigmW8Qk/b+1FB
         RqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735925; x=1708340725;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PU6V0metwPXw1DLE3fEvkcye+fWokLPWFeUE9bD0e/8=;
        b=cbQT/N5aDLYyIbpN+gIHt89uPqFNHFISXY54XSRCIuq8hskasHMnyGAkcEDxEPW6Rf
         /BqdKCLUk/FqVLhms17FqzUFlRXiA/EcYSQV1GB6BAEK+Y9tTUP/2p/NrIXDAYcxIkdD
         giYTllXrYjfeiJlvJD7jJwZooZaN4Z/7soOvDDzTqiyS0tiA3VGZnPNKDxGjcWZhctbD
         uTIxDg55YaXdA0u0Xj+WU9iLVgNWMwgF6VxzPJBIKunyRDUEXw47EwL816+dq+7ZR61S
         wSErb4p8CV2y6SdlUi8Jvq4xDmyPLN7brk9HfjQ8Axb1dnpmkrOcEGBwcO/YzoBCiCgg
         xLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDIOTCG9CcrB9DZL29zsFuS6+J7H3jg91ZpLs7DbXpLlNf6JtdAtP9fYZCAbVf4S1qIftXnxkx89K3kcKOzAu9jEd504qNos3gZfBm
X-Gm-Message-State: AOJu0YxCt0S/GJQ8FFxhlljNcxy3QWDdF9W6id3Snvbo+wjR45jkyEyb
	IXfIts7JbbgAScTsYxhSyc7Gc+2SUaxeDBQ6BEQkLEuawRLa8H/9EofR43nWodA=
X-Google-Smtp-Source: AGHT+IGFh+Q/dCyq3XtI1XrsgWonKFyWiqJ18N5lIZn2hFjuhXYKrhJXR/N4qKiJPLE1lUJxS8r5kg==
X-Received: by 2002:a17:906:48d:b0:a3c:2c8e:9030 with SMTP id f13-20020a170906048d00b00a3c2c8e9030mr5042555eja.6.1707735925631;
        Mon, 12 Feb 2024 03:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUsaSSocjiJbI8uJld+jThkZisQMD08tRokWsybW+C/zVaqQwWvYFFohqNJJcFTIDNzmGSs99UTj5+i/0a+N1H0nPW6aoGli39MDMjTh6n+2TXEw8fD58tZo6SZe9/XRbXHBahSdL2I5ySgmpsA5qkuLQFJzUwu/HdtUNKokEHAUpkjEKIq6vbSLP7oHX5Hkrv9Vpf90FQxnvD3PFtOrMgYK0rIh5RaLLYuAU9NQgiVBA3dkqtfIesFYmGYCIMpmcMh98if5Oyzj49eD7RvcAI/21QKZf9+nY51G0rBYuPma7Pc8gTnDXlNA==
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id d18-20020a17090648d200b00a3ccbeece96sm97404ejt.33.2024.02.12.03.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:05:25 -0800 (PST)
Message-ID: <55fded4e-1c14-4f1d-a1b7-08fdbf05bfe7@linaro.org>
Date: Mon, 12 Feb 2024 12:05:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: add QCA8075 PHY Package nodes
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240211202700.17810-1-ansuelsmth@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240211202700.17810-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.02.2024 21:26, Christian Marangi wrote:
> Add QCA8075 PHY Package nodes. The PHY nodes that were previously
> defined never worked and actually never had a driver to correctly setup
> these PHY. 

Missing Fixes tag?

Also, could you please give me a link to the series that fixed this
on the kernel side?

Konrad

