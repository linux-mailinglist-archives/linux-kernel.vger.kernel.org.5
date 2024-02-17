Return-Path: <linux-kernel+bounces-70024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235E8591EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC1283B46
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805527E10F;
	Sat, 17 Feb 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sTwCheEp"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC641A91
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708196037; cv=none; b=dvQOogq6WhCRZvoxsUwKkwE4j08XZyYaUYkTdmSSXMQ7iwtE7STWftsDMw1fNSqvPDC0bFwHnN9ko2oNqf0TNgOqvzIkizqOx2NzM8C4yK0E5MTUH2KiOvX4ioMpRrofBlxMVHp5xww2lTWw6AYx+eNThvp9UbWm7BUWVeqNis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708196037; c=relaxed/simple;
	bh=7FpDL5ycXyZNcpHLLovIdneYlyoyq5WC40Q8GBSv954=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4s2Pvz9W2ghDu51pDH+ejSfVLh079WwNVmPfU3W8+err6F31XVKHayZ4WiTR1VI5xMfRrrhMY7AP1zPYxcKB4WUxjV6+W4KPDilcFyj2YTY4Tt/E7xwfSzvwTTShkMO7dnq4lMd7NBmI7GAYUmZHeg1DV1keEOn3FMc/L73+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sTwCheEp; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5bddb0f4cso1182677241.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708196035; x=1708800835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FpDL5ycXyZNcpHLLovIdneYlyoyq5WC40Q8GBSv954=;
        b=sTwCheEpbQRR7HWH0eNlv7J54SQ7krjGMWB3kuHNsh8rQMiSQuzRF5yIQonVu5y5jQ
         Rr9VAeuWIbWgi32UaCG3MQHHycVu07+3bNQ10y79WVqpyzDgd9g1q5iHUKNaVWkrkcQN
         vc04jsxeO1iFTLtXP1Lc7JrZXW+Tr7cL/fvSRmke5eYABOHoQWaBg6Nlh1Qx84YFbdo0
         lJnCyyyPdnpN5JyGVWH2XzD2FZzH2unNy9TkCdavlsESSteVNNH+PaS5ruQal+U7ZZPS
         7Rl6W7J14o7REhgABDgOC2EEfv84mp678KyrJ6TxIbvv9FEJCxvzonWapgcZIEk6s1S5
         LGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708196035; x=1708800835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FpDL5ycXyZNcpHLLovIdneYlyoyq5WC40Q8GBSv954=;
        b=E1xNvzOAOpcfu7Xbmx9tmhZkWJRCEiSKX7X5StWIHD/sDfVaeGXwFoPVUEHYGV+qeS
         lD5yL+OJWFBSKB36RgLUy6vF2FewIkAdQMPamQ5da1FQ5izqcOa9KDtEAWsO1wxGdDqr
         73By6un+5AXu8PpUQioPILLAED5tR2wuHBF6k3PmIIK9cfleTfSo7lwS4zA6TWrTSlrG
         Z3XW3rCG9UtDAZl3CGxu7+O5/fAcLiWjEM26vkJAr/YmdV2RGUMWxWYXzWeuW8gtZwRA
         C/RMTnZcCZMcKCYuK+XeK5U8MR1t0cg513IiIg8KHS8AORBYlz7TVeC1b8SxmyewW+7c
         phGg==
X-Forwarded-Encrypted: i=1; AJvYcCWrCN5/drsmpE4K6CG3wxWWuc5++FZxLB9uUHZuBIbhsFMReZET+7sw42H+PWI7xVAGwqP3GOvO8TcCIYVEMkI4my91hcF79UMi7YOG
X-Gm-Message-State: AOJu0YxiAI7HK1G3WS53SIUTSAti1xbd86zSNg6ALr4bovahAaBXLMmu
	SQp96HiPUSPQ10r52ilbsD59kLxmay+3I13My02crTqKOtc+dgiqJHRYvf95YFMxEUmeR/2Nxk7
	z0uwCaGYNnR2XZxIa3aKNcYQhRH3ajcj4C9G3hg==
X-Google-Smtp-Source: AGHT+IGMlsUZR0OKxV5uoFysUN5BBaGIZC5M0kLSSCwt2sXagBefCJ/FHz7lU856rOvaMtqzE4+peSuOeyewP+QKatQ=
X-Received: by 2002:a05:6102:548b:b0:470:47b2:78aa with SMTP id
 bk11-20020a056102548b00b0047047b278aamr713828vsb.35.1708196035432; Sat, 17
 Feb 2024 10:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-9-brgl@bgdev.pl>
 <CAA8EJpry2yiGXrtPqZ6RXnoTqQZr_hxA_gCPsUbmyFtEBuD4VA@mail.gmail.com>
In-Reply-To: <CAA8EJpry2yiGXrtPqZ6RXnoTqQZr_hxA_gCPsUbmyFtEBuD4VA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 17 Feb 2024 19:53:44 +0100
Message-ID: <CAMRc=MeEWvhHjKJsNgigF=Oja+b1=ejvtAjkK=ptKWK0Ojjo_Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] arm64: dts: qcom: sm8650-qrd: add the Wifi node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:10=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 16 Feb 2024 at 22:33, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Neil Armstrong <neil.armstrong@linaro.org>
> >
> > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > board.
>
> WCN7850 is the same combo WiFi + BT chip. Is there any reason for
> describing its parts separately rather than using the same PMU
> approach?
>

Yes, I explained the rationale in the cover letter in detail in the
section describing the DTS changes for the series.

Bart

[snip]

