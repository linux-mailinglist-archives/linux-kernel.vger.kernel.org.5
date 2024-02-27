Return-Path: <linux-kernel+bounces-83430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92886990D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C28D1C23841
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04D13B7AB;
	Tue, 27 Feb 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXxZG9Xn"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDC31A66;
	Tue, 27 Feb 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045473; cv=none; b=hgADmdfvjECAzf5ufUmqk/3XdiPAYJgRln6Wuz+dE/sp0/aZ1xYJQadLjxR/hmpKLQtxp7/3smzvIj4/zdwAhHX5FpfORU6wANncBvKrucD5k7ocWnu9dY9f5l+bRrNVhQUzf0DXEmILluy/lis8kaUkfMNMuLlhpn0Pkrl3krM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045473; c=relaxed/simple;
	bh=R3XD/vBPL+EGtNTzCG+o2q6YHuxrQVUHvjfvDTkhdpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nScfmpefgptzTJ0seiSQbnSyEBLlhDn11RdvTpLMHjuM7LHKyTOFooIs0OfwUO1sIpNdYFuvgeMGMBrqKKRzkkldyKtbqjmyfiwQqgwKxe4Mx7KMHreALkAGtriMy2Jv6K+9KiU1foTgaD4LshEESFo5+rQ+YswECCTqlLU1CTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXxZG9Xn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a34c5ca2537so585466866b.0;
        Tue, 27 Feb 2024 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709045469; x=1709650269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIlOzHqEp95yte5/lk8bBybFxMXMoO07BYsA/z9Wq8g=;
        b=mXxZG9XnrioG5vO1NtNsv7E5JEhNq5MZuGZJ9pvgOWpNVLK6FBESlrvxcKHZWbHGX5
         H5eXO089hWfFv/iWUxRIU08oYxxAcFBLVBOSt0wJjv8tc/prZHzl3sJEEDm5MNNZ2Rdi
         It4uMd+nbdkJ4+keKFtRgAN+CroLB5Yj389Qo3me6uysnoLjTtWZUgK1hm56dibaKy95
         X7OjKv4FMyqIIQ4g+69u4INBKMrO8w102KSFUW6TFHlmQ/jnWFTZPKrqbutAnqWW73I8
         nTkkZNYVAwFLuyiN/frs6mCJVSZmjyp4icDKTZrxRmItNhaJX2OYC4KwmffIH26HnkkI
         OFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709045469; x=1709650269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIlOzHqEp95yte5/lk8bBybFxMXMoO07BYsA/z9Wq8g=;
        b=LfN1LRCskehDBGXUS64S3iHWrFto3KP5Zu+UOOxi+YDBdtDb5S5Fzjki7+3j4v2lXg
         XKX7CDzdzr/nvndrtNelbO7pKkBTVUSbRceqEQCQEUkcFygRfHGKxAJmou6wcfz5gptl
         VotHw47uw6ZeoWH68EdwFgt3BKsbtWi+joJocK4NaoVsmB3TPMqXbXVNmV1RXWqpDylL
         p2PCHwAOkjlGE++WGXvD1OHHK6JKMiyfq6r2l6pLLJtuyyadeh9wyjnrzOhsc0iLqnln
         QB7MmhrNaixo9iAyLPB+aJyN7lXEBFkBojL6hZUxhgHeqxqFLLRo/zZc9AeeV1nfWJLL
         T2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXT/pgdwz1O5DITDBo6k4y5PIDBjAT5RWx1xcRwx4M0NAfItRbQqXRDrCfEgpTjy8sZVBs3FP4KUF0mH+NGii3LLqVqkliXjd1y7k279tT0N0sVJezkAgiWKZH3zDolq8uLoBD0vQhlR/3GmA==
X-Gm-Message-State: AOJu0YxHPLmvcYMEiJ85Kv5hgdjdvlNOrbEL6uIL95CmPqUp14CyPF1r
	V2A8onjfh8ZdEoLR2ukkzYGtQpAH0OkVXn43ONILfhXlbFl2hoc2
X-Google-Smtp-Source: AGHT+IE3ZB1Z0msJDUIuHUHIEcO1rzR/aLiA76RUHE7bq23rGMw0G5szxhq3tRqr6Gw13AnxURzpqA==
X-Received: by 2002:a17:906:3c05:b0:a3f:4596:c3c8 with SMTP id h5-20020a1709063c0500b00a3f4596c3c8mr6891560ejg.53.1709045469077;
        Tue, 27 Feb 2024 06:51:09 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id oq19-20020a170906cc9300b00a3f9a10f792sm833657ejb.7.2024.02.27.06.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 06:51:08 -0800 (PST)
Message-ID: <203eaca6-7631-42ae-af37-8affa76c44b9@gmail.com>
Date: Tue, 27 Feb 2024 15:51:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm64: add minimal boot support for TP-Link Archer
 AX55 v1
Content-Language: hu
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
 <170904127322.3703788.10984942827471381721.robh@kernel.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <170904127322.3703788.10984942827471381721.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Rob,

2024. 02. 27. 14:45 keltezéssel, Rob Herring írta:

> My bot found new DT warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y qcom/ipq5018-tplink-archer-ax55-v1.dtb' for 20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com:
> 
> arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupts: [[0, 62, 4]] is too short
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names:0: 'pwr_event' was expected
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dtb: usb@8af8800: interrupt-names: ['hs_phy_irq'] is too short
> 	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> 

These are caused by the 'usb@8af8800' defined in the SoC .dtsi
(arch/arm64/boot/dts/qcom/ipq5018.dtsi) file. I saw the warnings, and I have
indicated that in the previous version of the patch [1].

Sorry, I should have kept that note in the current version as well.

Regards,
Gabor

1. https://lore.kernel.org/r/20240223-archer-ax55-v1-v1-2-99f8fa2c3858@gmail.com

