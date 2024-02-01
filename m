Return-Path: <linux-kernel+bounces-48394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5029A845B61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5ECB27F9D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF486626B5;
	Thu,  1 Feb 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cv3YHO2q"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15A626B1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801023; cv=none; b=Lm0welt1WiLK6BzLfD1LH0dg1VjvumHnPjrCV2EPX2MWc1KBexh7sEeYj1U1L3HkrLdh0CUBhR5set3r/b+fs0Ls3h7VTCCwirU/KVnRMC6L5qQlY03rcP34vNuu/5Wn3wiMHVvMtl9IWcC5z8ohei5mZb5kWRm/GiYEXvHzg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801023; c=relaxed/simple;
	bh=PMSkrVfo4wCCBmsgQRZ5v3SqCDRO5S+47GIBIeR9PvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQoMZOKSfhpTQRLN4Rc6XKMHtG2iPvtAU/pPLKkZRjkDoNtjzgIc3C2aRin047T7+OmFJ9tCkhWhnNPsKHqx65CtvX9bpwxz3DvkdZVuXYZgf6hOF4WsKclsdeYQGyllPMdDBuqzAwfl7q0LmLvzv6L7qihNeQH4bIGdficGte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cv3YHO2q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso9346975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706801019; x=1707405819; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMSkrVfo4wCCBmsgQRZ5v3SqCDRO5S+47GIBIeR9PvM=;
        b=Cv3YHO2qnBmigGCP8Xv/tjBczT4dE29eLL1j+R9uAWt1IyzvNFHI8zf3iePr5n0D/V
         Jikeirzkahkdm9nvdk7Be3Z4VrvcLRCXt0SE3YxY/Xg6QzbycRDW/yP5Et5109lUr9DM
         k6Sr7dLlKHsoaKHD/kqnC99rDiSKLGHB0v8q0y8CWNJ9vFqv6BfQ37sUds6QtRnMyJdf
         X0X+QzA0VOn4qKrOmJ8xuOW7LMjeGczE03/SjQ4K/IP9Bdp2M8VmPmikB26hAaU1CgRp
         z+DKxZcDFd2OFVR/SNywrjuYOEQY0eYKhmMsI4ht1rwNLl6W9qmnm7b44fH+XRVbVN/v
         2KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801019; x=1707405819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMSkrVfo4wCCBmsgQRZ5v3SqCDRO5S+47GIBIeR9PvM=;
        b=jmxsYUlJqi01O658gZSOn6heMoCEyEMJ7+thz8y8Qn3hZ2nsqmloYhjHBAiiPeEoFn
         qQbWihcgkzPw9OVsD+Yacv7nCsardZqlgVJZkC7hnFUWM3hD1T+xSTsXHOk5f+kOqF2c
         t330e4sZ+NjTmGYgzilzxVoZgrZHg2q2Bw/Vr6zpok4GS7rbXNaawWnrhSk16ydrTSyq
         7xWVCn5c+JFRQQDsQNFPBHCY7HtEX3T1lfnAkt6ymudm49BZuenbRdDGQrdXn0z8WKra
         8QZC0l9otgFq7tBnz3dS1QHayvGAdmwR1Iwj2MMv5wpzgaHUlwP8YutrmWkq7OEU9iQG
         u7cw==
X-Gm-Message-State: AOJu0Yx35kTfMm1fGKd1GpumL8pCs84USHyEYcS1WZwBcoUx2+7fAcjP
	LrI2hTxIdf5YS1MuR3AMGQ8uTsdQVf5pEOWnVi/yCjRUubAJQNQqFTc6yakK7fE=
X-Google-Smtp-Source: AGHT+IFodjNDyMaCtYuTqV48vhgStAruvNKrxCZcjt1dAxjJZdOwQCmscUUIOnKz7B5yumA8IslNvg==
X-Received: by 2002:a05:600c:4e8f:b0:40e:f15e:10a8 with SMTP id f15-20020a05600c4e8f00b0040ef15e10a8mr4135288wmq.27.1706801019449;
        Thu, 01 Feb 2024 07:23:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWL0d7Ugr++UEHsJvIKxBYZi9F1A+/6aubU+Ro8eXX5vxRO+mg9PgqLH/KrlyrNxir73EU5QsKivnH8EPMWDirtNVQGVZQp/dFNwJcT8Pput4S6nynwJVCnKwrwvgR8gZ+sHoE+dGXvEcAUZ5tQuiMDb1ZNN5FuGDvpCPs/BJDWg3v8OffzNMQVhA91yTqpyM5BKqBVhY+8i4RMPl7VgagIAszO8VMZKAaqgrGTA2rvNU3PzMy+NegVU3ivUBzi1OzpztrmjK+qNWtwZRKXiIZmhbb5zJ/pkIsMQMbqUVQlsQto6x+ZawSrPYgZURyjlAaTpD0PnmGRouCpwcSDEY0ZAxF71Eu34Q+drwcNiHVHriAzjMvimHcTHFv+Bsrr8XRzxiRrKrz12thShte6WF4KORgdjfO31VfCkanLtx0DOXUINNrqTjJ5wTLzmhpiwQxxLkcCbNTKzJ+ria7oJvPOv43Djp6jgM0kNDI7nG3Fwps2+aj/qvEb6ycT3uxNj2YFKxwtSEva+tTznbThnS8tcAyaQCvt+iI0oZnzwOyi8oP+IzVXH9VJjEj2fv1ATjWYczhMbNwGThcxB2KRYV+SIeMFP2ihcf0NOwCZNFA6i+6cW8qSJuXHhhPo+R1MXpiNDBI=
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id f6-20020a7bc8c6000000b0040e621feca9sm4651115wml.17.2024.02.01.07.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:23:38 -0800 (PST)
Message-ID: <5d696d79d453c6b77f4ebc2d91256e4de6cd5ef5.camel@linaro.org>
Subject: Re: [PATCH v2 5/6] clk: samsung: gs101: don't mark non-essential
 clocks as critical
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org,  alim.akhtar@samsung.com,
 s.nawrocki@samsung.com, tomasz.figa@gmail.com,  cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org,  linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org,  devicetree@vger.kernel.org
Date: Thu, 01 Feb 2024 15:23:37 +0000
In-Reply-To: <8dfab6a9-f9d1-46c2-8bd1-6ead4b26fbe1@linaro.org>
References: <20240130093812.1746512-1-andre.draszik@linaro.org>
	 <20240130093812.1746512-6-andre.draszik@linaro.org>
	 <8dfab6a9-f9d1-46c2-8bd1-6ead4b26fbe1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Thu, 2024-02-01 at 11:02 +0100, Krzysztof Kozlowski wrote:
> On 30/01/2024 10:36, Andr=C3=A9 Draszik wrote:
> > The peric0_top1_ipclk_0 and peric0_top1_pclk_0 are the clocks going to
> > peric0/uart_usi, with pclk being the bus clock. Without pclk running,
> > any bus access will hang.
> > Unfortunately, in commit d97b6c902a40 ("arm64: dts: exynos: gs101:
> > update USI UART to use peric0 clocks") the gs101 DT ended up specifying
> > an incorrect pclk in the respective node and instead the two clocks
> > here were marked as critical.
> >=20
> > We have fixed the gs101 DT and can therefore drop this incorrect
> > work-around here, the uart driver will claim these clocks as needed.
>=20
> How did you fixed the DTS? Which commit did it? Are we going back to
> basics of driver changes depending on DTS?

Sorry if the description isn't clear.

a) these clocks are not critical for the system to work, and this patch fix=
es that.
b) the initial DTSI for gs101 used incorrect clocks for the serial, and it =
didn't
work. The work-around was to specify these clocks here as critical instead.=
 Patch
#4 in this series has corrected the DTSI.

So there is no dependency between the DTS update and the driver update here=
 as such,
no new properties, or otherwise.

That said, now that b) above has been fixed (in patch #4), it is OK to mark=
 these
clocks as non-critical without any ill effects. That's all that is happenin=
g. I was
merely referencing that in the commit message.

I can rephrase things if you wish.


Cheers,
Andre'


