Return-Path: <linux-kernel+bounces-135868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B467989CC58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275122868C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49526145B17;
	Mon,  8 Apr 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkb7ZVxC"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB6143C59;
	Mon,  8 Apr 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604080; cv=none; b=RLBnG7Wq3wUuzXysCCq7e8vlVB5Gu9NFmUX91PjB8PukbZdOgQlYiDIOlten1KpbB3cN58XmtJ2vttm68EpBiDWXknY/6GvcAXcaHib7cNtXRHLqqfFx3baxUDecfdYpG7MN6VRmeclqRjnW00zJnaBEQzg0d8uGIM0E/QBbkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604080; c=relaxed/simple;
	bh=yWTzWK6xiTolmcMAZmDBPdb70p3OB+ZD4SGUXyqhAkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seXATynhjVjSBQkzR2ZfkPhj5mHi5FY4F7C6V+Mo2A46rOTqwQRhXlpjEgDiMm21pIEcjst9OSTbqmQkbZtSCxIenh7aZwlb9zkH28T7CGKvAxZyNApuSEA2FEGBE9ZKHNfuqz8Li+pHQ6alcpHe2mCfqi+xujf7e8S0KMwvyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qkb7ZVxC; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa16c0583eso1469817eaf.1;
        Mon, 08 Apr 2024 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712604078; x=1713208878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AamdBDO/VS9vOUYPUdxb7pzEW1gk+yCkE+Fv1jk8Ttg=;
        b=Qkb7ZVxCrbaw3VoorF+IakEsRLHi6zsA77tjPb5IxeEM78fLhQCT/a3ankSVn9OUJ0
         YKhoeTRWbxqRvmc4Hvaof2m5fnEZi/hrcUVZKwEAvoL2foKIcBqXIYGzgsxQ8ep9nMi7
         dFNqbLtIzmayk/fw5VMmvPZL+0c2gtgc7iszkrzoSZK3SQE45o3stNU2NPe6bFFLuBsE
         JqIFwaBI613We7UCwH35Baiy/KvyCbT7GJQIABf+YgYaxGA8p0oGIlSow+mky3gUqtsE
         X/ADcns6ajjSUvjDe0q30LKyc3FdC2+RqKMzugkSmPTW8cKiMKgaRjiTZenrEkAt2mTQ
         JIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712604078; x=1713208878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AamdBDO/VS9vOUYPUdxb7pzEW1gk+yCkE+Fv1jk8Ttg=;
        b=ZT+XcUDnxB3syZJ5nO3A+NsPuD2EctAKu/k7WC+LHNl4jaILar9l4BJicmdr/vGiLf
         vCjmj6A/l/Gax2JFVL9139bm7pIZPmOlaq37kTMDJrRF9a+8ENy3L7Z0BPsmFweE2N5L
         qYoKDwjpo6W71QDNouthkVlIV34K6X7YCuarS5Ga5NTf2/e/2AzUjypA6aYzyWBhVRkm
         ufBdAYaLLtXP0pzvz/CAArEMwYTp/w0BbXdvT6eKdGr7agfjGzjgNmHfFyo0Ta2DyJ6b
         +KgSNaC/j5rlcjRYRO9GUtH42RNlgFW1L95Js1oFPuNaDYNhJiQE5tiTDg8Vu1v6h2as
         LmOg==
X-Forwarded-Encrypted: i=1; AJvYcCWB9w7H024+LSDXdjxAMW+zTxS4LgTnf1wawJBJAU9QopbIkZYlCIWE5G5Qv/w2bWiIpFW9Qz0DQ9b6SqQhpyEs3HegC8wFVoPzpW4fip/cL/EENSmT3Oyh3Xt5O/8MXRtkdBTwovxz085Vx24TuZnTQv9vxGPO8ilhCct1cKcGza+PKWiNgM0LLqgC0NZPiZXzlcacTsKivPP0HA==
X-Gm-Message-State: AOJu0Yxh834Nr0/YHRt6VjsIemFLUuGgGKkCxiosQdKxA2w8YpmSgdti
	uE95gSx9SgAqxEEN/M+xWkfVfi8TgrKUmgpNZDS4pki/s89TT+Bo
X-Google-Smtp-Source: AGHT+IE6qOZ10utu6Mbidwe88/lmT5YDCQNznzNpFX1CMDFk8/4ST4mEeN2WAnfgVNwPDNjKcMoDUQ==
X-Received: by 2002:a05:6820:150e:b0:5aa:18a1:cc5 with SMTP id ay14-20020a056820150e00b005aa18a10cc5mr8792365oob.6.1712604078079;
        Mon, 08 Apr 2024 12:21:18 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id q10-20020a9d4b0a000000b006ea24b907b1sm34217otf.5.2024.04.08.12.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 12:21:17 -0700 (PDT)
Message-ID: <28f45cfb-6c77-b893-2927-d4c8a99e2c04@gmail.com>
Date: Mon, 8 Apr 2024 14:21:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 5/7] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Content-Language: en-US
To: Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
 richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
 neil.armstrong@linaro.org, nfraprado@collabora.com, m.szyprowski@samsung.com
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
 <20240129051104.1855487-6-quic_devipriy@quicinc.com>
From: mr.nuke.me@gmail.com
In-Reply-To: <20240129051104.1855487-6-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/28/24 23:11, Devi Priya wrote:
> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   Changes in V3:
> 	- Moved DT_XO to the beginning of the enum list
> 	- Hex values changed to lowercase
> 	- Construct mask for resets which require multiple bits to be set/cleared.
> 	- Dropped pm_clks as the necessary nss clocks are enabled in the
> 	  probe function of gcc driver.
> 
>   drivers/clk/qcom/Kconfig         |    7 +
>   drivers/clk/qcom/Makefile        |    1 +
>   drivers/clk/qcom/nsscc-ipq9574.c | 3068 ++++++++++++++++++++++++++++++
>   3 files changed, 3076 insertions(+)
>   create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c

Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

