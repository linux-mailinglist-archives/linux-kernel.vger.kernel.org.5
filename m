Return-Path: <linux-kernel+bounces-134598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C9589B361
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A690EB21DE7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009313BBE9;
	Sun,  7 Apr 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K69cf+Bx"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB603A1B5;
	Sun,  7 Apr 2024 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512117; cv=none; b=nflEPElHaLAMfMXZgKg/yJt4vMqTLg4r7A+z6w5NW2SIVzXgakQwqUYRpY7YweY7IXJNZoJYxv6K8KTpBg+mWSHzAF1BpolvWrYr5zkHhfMhBggPTysZ165mhK+fjx55zrOey8Sv6C7Zhnyf0NSJn0j6uFQRfrApUkZGinXyCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512117; c=relaxed/simple;
	bh=rYYsdMtLNJhfKR+qWZmjeR6swj48dWfG4F6Xfwy5SqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDzl9nE32H/M2uBfkp8r6BV2CaKnQGqNzcEIMAHeDufbj2pGBtejE7ZCsbZWhMVi5Uu6FvRIxXSg+6+xuaKsqufmjXHC86SuSPlwbc7Qh0Foc9Qm/VM8iXra+3/iTBYi2J8tB4d+g92N2W8ISGulPTxvXSNRPGeESXggwabJwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K69cf+Bx; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea1189de94so551965a34.0;
        Sun, 07 Apr 2024 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712512115; x=1713116915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sXdKQMfOKyJsj4qQ0BFKCNMJKW5FrQPDHTE6QFVUwU=;
        b=K69cf+BxvxR9wFmPbZCVC0qR6OqtzjEahOcDYlpwjluMHFUOOoAQb07gEh5QTNQfwf
         E94T3Nsnep9entfAvSjNeDyXKldFL/Mj6hTJPI+N1vqdPmVK7XylsgeZoRdDtQD5ldlz
         1J6k8Qd2QJqejLMaySGvd17Dth16pmwSrq5R9IbfoGdwTXuN+rXQ/LmGPAvw41RIJrkO
         6+E4+eIYd0ACWOMgoVLyEpsn957ndZP/eknoFkJyJ+LqyS4OSOHcoQFvo+m9qfct5rFi
         XqEjJ0MsMlt752bl9asxTYF93NSMswJOMjg391ZrWHA2pV/hIfmSiI7WkbZWLKJpnfbR
         +sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712512115; x=1713116915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sXdKQMfOKyJsj4qQ0BFKCNMJKW5FrQPDHTE6QFVUwU=;
        b=GulK0RfcZ4Zn5R4EzBkYR0TI2vJcOQlnKqj6pm21wEq4grA5Tvsz+fbZN+rRewhomo
         pIzQXIiCVPL6KdL/Kj5Bcd7c+jfuF9CMOThx3FyQJLyA0mY62QwWV6XckCRm7PHeVANn
         vl98vbbzXCyVK+Qc9aJ5phMd0NVR2m5n9DTNhv/TjD71sc77mS2edU6pk/tb5lWi+LQN
         09hpspVSH3wSRmydoPtj+2cWZlh5xZ9E5wH7iLKSSF8CMyArygAEABlrRb5yAQHwAP0K
         55DgJoimfjcCdjVLIUakc5E3n+ZaFwgJmKyeTyDiR+OPxTyhznEHrV/wV8Yr4UcLVS36
         WvXg==
X-Forwarded-Encrypted: i=1; AJvYcCWCTOyxT2M6kfUE9cuwqTRY654yaujY1IejCCkySzDmrn6ps8K8GgrAAWxs8ZajTo16VyQR4Z65n9IRZlLYv4tFDo1o91JziNlC9b3tfNKr7MAv9KxDkLnQbKzCTc7gIrIy9wyMOC1GMrRR/+1qXjjLzxlx5XpIYPjXey1avrcFPg2qmtf7sa1ke9doQ+vpSbie4xsffyODBcnwpq0D7GKuE6A=
X-Gm-Message-State: AOJu0YzTXjAXYW7TscxqmYBw+IExMI6M8pOtiCaiCqpCQUsmc58qUIIh
	uGUFG2nGjbg4qgbEyU8FKBbdNI1Ws76PMFhoVW0BJZEJox+V6irk
X-Google-Smtp-Source: AGHT+IEmJUaWcK/hJUC5cAwg09zB7vyfipJlWU9lLlEVltY3uzjfm97qWwibUja23CycpiqAQa5onQ==
X-Received: by 2002:a9d:6a5a:0:b0:6ea:f34:8ab4 with SMTP id h26-20020a9d6a5a000000b006ea0f348ab4mr3238793otn.28.1712512114955;
        Sun, 07 Apr 2024 10:48:34 -0700 (PDT)
Received: from [192.168.7.110] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id a25-20020a9d74d9000000b006ea178dadd3sm132893otl.21.2024.04.07.10.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 10:48:34 -0700 (PDT)
Message-ID: <1c803d8c-80b2-47a9-bc8c-8b13cbfc6841@gmail.com>
Date: Sun, 7 Apr 2024 12:48:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] spi: spi-qpic: Add qpic spi nand driver support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 manivannan.sadhasivam@linaro.org, neil.armstrong@linaro.org,
 daniel@makrotopia.org, arnd@arndb.de, chris.packham@alliedtelesis.co.nz,
 christophe.kerello@foss.st.com, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
 <20240308091752.16136-4-quic_mdalam@quicinc.com>
Content-Language: en-US
From: "Alex G." <mr.nuke.me@gmail.com>
In-Reply-To: <20240308091752.16136-4-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 03:17, Md Sadre Alam wrote:
> Add qpic spi nand driver support. The spi nand
> driver currently supported the below commands.
> 
> -- RESET
> -- READ ID
> -- SET FEATURE
> -- GET FEATURE
> -- READ PAGE
> -- WRITE PAGE
> -- ERASE PAGE
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

For the entire series:

Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index bc7021da2fe9..63764e943d82 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -882,6 +882,14 @@ config SPI_QCOM_QSPI
>   	help
>   	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>   
> +config SPI_QPIC_SNAND
> +	tristate "QPIC SNAND controller"
> +	depends on ARCH_QCOM || COMPILE_TEST

Here, it needs to 'select QPIC_COMMON`. Otherwise it can run into 
unresolved symbols:

: drivers/spi/spi-qpic-snand.o: in function `snandc_set_reg':
  drivers/spi/spi-qpic-snand.c:56:(.text+0x484): undefined reference to 
`qcom_offset_to_nandc_reg'
..

> +	help
> +	  QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
> +	  QPIC controller supports both parallel nand and serial nand.
> +	  This config will enable serial nand driver for QPIC controller.
> +
>   config SPI_QUP
>   	tristate "Qualcomm SPI controller with QUP interface"
>   	depends on ARCH_QCOM || COMPILE_TEST

Alex

