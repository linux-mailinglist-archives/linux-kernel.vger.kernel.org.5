Return-Path: <linux-kernel+bounces-116887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91888AA42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED53B6022A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C3155720;
	Mon, 25 Mar 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2mYiWv7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D311BAC22
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365232; cv=none; b=jpop8K7ZEDVMHKPat5ceJTXfDXaDTHReMZladFcX8xd8QVQrxk231ysdaSNvDl9xHv1mJUa8AR2nD3/NVI2jBck+WY0JWEZik4OTixSa6zlUvhcxsSsFhLNnHs2d81d+Qba80Hasdt1IkHi8JgBW+cDhWLH2HAQ44TNRh7DR15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365232; c=relaxed/simple;
	bh=CsnJnRPcWog1AhZph4odR/X3hPqH8uWzUIUQNePou5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Epnwn1NZX+OluCO443rByE+DHKs3wRE22iZfUn/L0pR/NjxqnT87x2w8536o43TlOCttjYkTvTepLJV57jcYfP6Ll0YfNV58vIa7xjW8gvLrn+yzOX58wTeX+aNrNiIUqbzX0oAW0RclGC/HZJtiyz/b/qkabr2NOJdAyQvN2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i2mYiWv7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45f257b81fso487269266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711365228; x=1711970028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoyYuiUZGUFC3ha/4x22ZxwHLgySLn4r64un5f+TeAU=;
        b=i2mYiWv7cGRlMGxP3I4QE5gnhZNZUP0UJfpHR2g/YnKgMCcQaHgfxA/5bJamrE8mYy
         bfxvVSIBbkxvKiHJHdJ83niAW1Cjj+VBGyyg4tBVpGmCk0LInEgDqgCI7EczP3Jf202T
         GTQJY3GeVv/FXNNk3WA+sHenv2Y77/ATnUh+0kJSA6u1cXGIEN6JFASiZk4KuaIrxkiL
         x9IUh95qMo3OnBhosiXKm2akPg5gmQa333iMUtKVaU4O3jsnymM62PRCcp9LeIGmoRVZ
         pcdLxSe0rcxrLSfyLIpZLf/j+HppWBvT2hQZOkaCp+fL2YKCQcbhlBKwpZpjR+mdTO+U
         oOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365228; x=1711970028;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoyYuiUZGUFC3ha/4x22ZxwHLgySLn4r64un5f+TeAU=;
        b=Aw365T7EqZkBS80afjt9cIECh6386oAnOA1+xtO/PB3zkN/IcKH8VRWWRlhFmuIXE1
         mWeReVutIWFSKw9EVKXzdzhCNDZHBpBWZoPrqGzTpaZf3IH1JdzA9dlRvM+h1yf7AZoy
         eJGtt+0HCdNzlw73uqwp0M3jNaqcpgvEvEMRTOMfzpb3BgqasdWX2dWWYlm1fB/X0RdG
         h8rIO8vEYwls97LC6HHFvXoAmpB86fL57nKTTDHxnTncCwk+rNm20vkuTXan3oceIWzP
         mooHfid8t8hAXH1TCYHF4MxLexxK6A50V22R1Tlu3Md+nBvXc11P3RPPyhagFDSVsksz
         DEnw==
X-Forwarded-Encrypted: i=1; AJvYcCWUjsLHuvbX1ZXRcBqtN8Ekghvyd1yr3k2AfMhgPXVxSiSflljcrRbDlzmisGYgVmXU8Mv0K8qgmBmGGwdtiagjqwHrDA146iaIRXLQ
X-Gm-Message-State: AOJu0YxlYVP5rD3smKQZip448ZQwvTmL2FupIUmV8r/lVKC2tualU6b1
	NDCPt66r6Ptn2CFRK7pEiJI2dA2iME03wCSDogMuDV+j7kxVOZnD3gXm/INUV6Q=
X-Google-Smtp-Source: AGHT+IEUex17Jst2eGsMe98Iuo5t4cMBsMavpCzi4l2n3luenkHwWGs8eKyJbj2V1ryUNtTHXaDLJg==
X-Received: by 2002:a17:907:7288:b0:a4a:3955:460e with SMTP id dt8-20020a170907728800b00a4a3955460emr1569675ejc.58.1711365228518;
        Mon, 25 Mar 2024 04:13:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090679d500b00a4739efd7cesm2965936ejo.60.2024.03.25.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:13:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, broonie@kernel.org, andi.shyti@kernel.org, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 willmcvicker@google.com, andre.draszik@linaro.org, peter.griffin@linaro.org
In-Reply-To: <20240216140449.2564625-1-tudor.ambarus@linaro.org>
References: <20240216140449.2564625-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 0/7] ARM: dts: samsung: specify the SPI FIFO depth
Message-Id: <171136522717.38881.15348393587552800276.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 12:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 16 Feb 2024 14:04:42 +0000, Tudor Ambarus wrote:
> Bindings patch sent but not yet integrated:
> https://lore.kernel.org/linux-spi/20240216070555.2483977-2-tudor.ambarus@linaro.org/
> 
> Up to now the SPI alias was used as an index into an array defined in
> the SPI driver to determine the SPI FIFO depth. Drop the dependency on
> the SPI alias and specify the SPI FIFO depth directly into the SPI node.
> 
> [...]

Applied, thanks!

[1/7] ARM: dts: samsung: exynos3250: specify the SPI FIFO depth
      https://git.kernel.org/krzk/linux/c/43dc9f88ff4db5c932cfb35cfe4bfeff25ed60e2
[2/7] ARM: dts: samsung: exynos4: specify the SPI FIFO depth
      https://git.kernel.org/krzk/linux/c/f743fedc881b38a62ee47d752e59ab1ddb247052
[3/7] ARM: dts: samsung: exynos5250: specify the SPI FIFO depth
      https://git.kernel.org/krzk/linux/c/a0f87a269f660cb41c2b38041183e3e31c69818d
[4/7] ARM: dts: samsung: exynos5420: specify the SPI FIFO depth
      https://git.kernel.org/krzk/linux/c/cc8e49917ca8a3a939d303a7103b9d30ed7d0873
[5/7] ARM: dts: samsung: exynos5433: specify the SPI FIFO depth
      https://git.kernel.org/krzk/linux/c/65993c76e64a2fa71ffd05ce260f553d1b3e904f
[6/7] ARM: dts: samsung: exynosautov9: specify the SPI FIFO depth
      https://git.kernel.org/krzk/linux/c/b115751fddaf31a0367c19bf080dddcb928a109a
[7/7] ARM: dts: samsung: s5pv210: specify the SPI FIFO depth
      https://git.kernel.org/krzk/linux/c/d2c81a9b6acc9ad6fa1a97bf21939adad1882dfa

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


