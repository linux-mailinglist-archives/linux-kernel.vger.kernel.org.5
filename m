Return-Path: <linux-kernel+bounces-127158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE789478C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA1D1F22867
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139E56B7F;
	Mon,  1 Apr 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoabbMPU"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58904D28D;
	Mon,  1 Apr 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012709; cv=none; b=mWbxC8zVGsT/piH8xDal/NImhO+NT+JkQXDl8zMmYZcIVu1UKr9zjqpYsHmIkiTL+RVCvBJmtrWVEmwWLhcoTLriNQieYdSvtaqHFjb1zTvzUsEYDMeU+F/WLn+rn2Do2hoW6g0V1PYQWkmQp7fs7SHjrD0jgli/ziWtuh6ksB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012709; c=relaxed/simple;
	bh=4nfQ3VKgAVCoMffKoucpw3WN+zAqPsrt0JARR6EFVJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiRM8LQAUT92WTDvtKVrCQol5QiHOuwyKkPcHdR3YDk6tXLwsur6dcs0Ll+cRlQ4Bti1LazOMDiIRSFnTUC52xRkIsxq/zQoNg6Wme30EIAkBIkGl/zyBGBZe91Owy5gPg0oRwt/zwevN4kAI1BnHRaS6u3C5xityUoVMhKjyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoabbMPU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ea7eff5f3cso748054b3a.0;
        Mon, 01 Apr 2024 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712012708; x=1712617508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ns3vmg+RhBRNwgNneyJSa4OOrkY3KigKEhbkR8ToKM=;
        b=BoabbMPUra2n0Pn+URwSKOAQaSu/M6MS4tNkv2qc1fF0OK4/7VHcjbQZB21GzMpzjf
         8J4EvXwL2PXPGKP5c1PQjEj1jBwzL8HYOESpnX6Nxl6toIZH0PIIPvDYeAcC/zBaqB4G
         9P9LUS2DHjJeR7ESGN5LXanwDw9CLBG9zTxzi3h6Bi9Tf2H1mUFCSVJ8z4OF+oXDAbOP
         PyILHhZsvKSe3BpSM9JFJ25QeribC3F1P9Gwm6MT0LUGfuqxp1XIL8bjSPCf1xozobED
         6J+95TSgtVobOsBQzNLAldJzqaxazZ09zh9athOFYW25FS/c7dCIDwMkCTHQgEIJpbDA
         EN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712012708; x=1712617508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ns3vmg+RhBRNwgNneyJSa4OOrkY3KigKEhbkR8ToKM=;
        b=Awcqe/7VVlSSedR+G4ZiFJkUEMWwgho7xS9JSDduwQ9B3ALS4rp4xWYXAKA1UgrHWc
         kYzmWPZhEV9Z9U8QZ5hLXreGtVODY2GrxoLys1gKz43UwCRAFEOrDCBHSmCB/jCcTe/g
         ow6RKiua2yck650k4W3YdpGt4qgCPjbeIBFb1wQFTNxlnkI3GCcCAx+pwYbvew4eaVT+
         BATccQOHSSzARZReWmcVkhsVJRKiox586pK6Jz1J45pLNexMl/dZnFVeoBriLAxh4FLl
         pJMel4Ges4ZbYWo8qoTa2U5pRHmUVenz0Kp/w9YCHgZhArz6z66RHEx6R6KaGyZJP6dc
         WvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHsKgD2tF5pMlVchcEStZ0ANRpsdX+gzZq3R61DQfpHyzRKrkrTLXdQfa8YdsAXvazdyJjCj5sRoj8YXT/Jj06xy65m3mSUuzZQHJk46CkeN2OJBTSatkKRsd5CAxRR8Y7gIZnYnKPK/WfFfo3SQyAI9b3zPd77ujddqxWgibHDA==
X-Gm-Message-State: AOJu0Yw2cz0ac+QMuxJLVPLzczGJrng/Z4tTkD6/yzpITu+Z675DqE+O
	C3CbYIJuY2gsbOSt+JfFZRI3mYXPL6fgRt/T2O+0W/UzQyQxER2TEHy2B6Pl+P0BVHCIVLXivPp
	JLvZL4BT46YGyeAtUXnTAm+iJfyc=
X-Google-Smtp-Source: AGHT+IF55TrHPzAh4Iwu94EBfsDCHNPepD+JsBP4CbULZpvEhvY5U5aHOBdIVoo6WwWNJ/ZYLwaKDnlZZRg97KINu1Q=
X-Received: by 2002:a05:6a20:7345:b0:1a3:c603:61d4 with SMTP id
 v5-20020a056a20734500b001a3c60361d4mr14923368pzc.3.1712012707679; Mon, 01 Apr
 2024 16:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-dts_fix-v1-0-8c51ce52d411@nxp.com> <20240401-dts_fix-v1-1-8c51ce52d411@nxp.com>
In-Reply-To: <20240401-dts_fix-v1-1-8c51ce52d411@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 1 Apr 2024 20:04:56 -0300
Message-ID: <CAOMZO5AJrQ5jyV4A-tvX93-R0_nEWpEO9YY3f5DpeXaAFO4cSA@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
	Philippe Schenker <philippe.schenker@toradex.com>, 
	Max Krummenacher <max.krummenacher@toradex.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:25=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> lpcg's arg0 should use clock indices instead of index.
>
> pwm0_lpcg: clock-controller@5d400000 {
>         ...                                                // Col1  Col2
>         clocks =3D <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 0     0
>                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 1     1
>                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>,  // 2     4
>                  <&lsio_bus_clk>,                          // 3     5
>                  <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;  // 4     6
>         clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
>                         <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
>                         <IMX_LPCG_CLK_6>;
> };
>
> Col1: index, which exited dts try to get.

I cannot understand this sentence, sorry.

> Col2: actual index in lpcg driver.

You should not describe DT in terms of Linux driver.

