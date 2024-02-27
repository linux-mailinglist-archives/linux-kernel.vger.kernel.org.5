Return-Path: <linux-kernel+bounces-82674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0FD868818
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E3E283116
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD74D11B;
	Tue, 27 Feb 2024 03:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTrLlMjX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEA4CDE0;
	Tue, 27 Feb 2024 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709006104; cv=none; b=JO/mgZI2cs02g7N1WGe5HhchqbJ/CnwXsrD68TQBcg86z5gKkSuzr2CRYGOA/9B9JKU/NKnWAJ8mST9oiB++4uXuTXnirly8q8Gu4HdIh1OGUMnqdh2gnZptozYDJ592DU38nSO2JEWgoUG+LMIPSDeKf9KVmGVJ/Apf4E27rRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709006104; c=relaxed/simple;
	bh=GapRhH6Ok62RJMtMFM7fqvjgxBgjNKUulRJwiJTDpRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJJVt8SUDpE8e97A1hY1wA0HY3xX6Gh3t5D0+b5qjQ1rDDK+XBSRsN6ECClfgl/dFH3Vd/XBkj67Qqx2CbkJz2b156IxTX8L0lformJB0h2sfXGVz/oG3nLm3g+Dp11HHzjpBeWIlIyRYo6HL9ADQWI3PUvQHrr/vgxYg/8aQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTrLlMjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE542C43394;
	Tue, 27 Feb 2024 03:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709006104;
	bh=GapRhH6Ok62RJMtMFM7fqvjgxBgjNKUulRJwiJTDpRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mTrLlMjX/+85j1Qik9LUrEUIPSGS/IIWHxZbi/K6RhtrnbpBYdwh7KC+WHJZk1dJH
	 o136O7M9cCBrJRyTK5ZO4VAmu4ouLE1ArFofsbFxNRJ+a8c2dfHpjLJ6efsr1LcuWX
	 qyaDnrxqCwCRikGfwfnV+0I76TIaC1zVWppLh6VDVe0pR5ONXcdSG0dFHywNw8voFA
	 hBlNEQnsbdtWOP1zT1Ix/hRig9SravsJ0aIZoDLincjCTXjIpiZ28gtJP4LLiXMINC
	 MqTI70oc9oTlnw52Xn6U51t1XFpHPT7h4m43I/Vwg8dotyrQfOcOoUoFHnbNZ3aKBF
	 zD0HaymskfPoQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512ff385589so1917052e87.1;
        Mon, 26 Feb 2024 19:55:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCuQK0vAlB3sbjL3aPPEq3FvP1Cw1AF6oojkyv3sKFKSupwCHQnTFZE0v1DEmUwfOrHiQE0aAI6jRtKr32gj5Ua3TQQHX15H2rZFuTAvfz/c4NAF9SH2YwU0t0GpOhC3Zw+ZnNBUVbq10fl1u5wSstBWc65Z1HZ3lGztmC5zGvquXcngnqaYX9GHAWaPHc2tljPKidCniLT33rpUV72j36fkdrRK65+n4=
X-Gm-Message-State: AOJu0Yy0Oz5Q08ETrEv68ElEV6e0DRd59vZLb5jyKTbyG55G94ZWIYi7
	EkQK23YnKZwJF9JSEFrjWFPnZFr4ek49QpLTYDUjh4BLHcdAbTbvy6tvSHJrpvMej48K0v9Rohi
	nwMaX2Tz19hbt8OcwoZnX3aiHUQ==
X-Google-Smtp-Source: AGHT+IEa5SEn2U+j2tz2rEkGzuP63uIymMu+x3njmMP2xVTj3Tb+5qkgznrNTzN48OXftf7xrzekiuie5b0+ROvcOPY=
X-Received: by 2002:a05:6512:2241:b0:513:34b:67ec with SMTP id
 i1-20020a056512224100b00513034b67ecmr965394lfu.58.1709006102187; Mon, 26 Feb
 2024 19:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com>
 <20240226195516.174737-1-raihan1999ahamed@gmail.com> <20240226195516.174737-2-raihan1999ahamed@gmail.com>
In-Reply-To: <20240226195516.174737-2-raihan1999ahamed@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 26 Feb 2024 21:54:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Z5UA1jEJSL0tRSXrC+Juud6ZMXtvR9ne5Cn_-cw9UzA@mail.gmail.com>
Message-ID: <CAL_Jsq+Z5UA1jEJSL0tRSXrC+Juud6ZMXtvR9ne5Cn_-cw9UzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: msm8953-lenovo-kuntao: Add
 initial device tree
To: Raihan Ahamed <raihan1999ahamed@gmail.com>
Cc: krzysztof.kozlowski+dt@linaro.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:56=E2=80=AFPM Raihan Ahamed
<raihan1999ahamed@gmail.com> wrote:
>
> Lenovo P2 is a handset using the MSM8953 SoC released in 2016
>
> Add a device tree with initial support for:
>
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - WCNSS (WiFi/BT)
> - Regulators
>
> Acked-by: Rob Herring <robh+dt@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

We gave no such tag. I'd suggest you go read what these mean.

Rob

