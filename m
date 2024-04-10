Return-Path: <linux-kernel+bounces-139538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6208A0419
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23F9B214E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54623E497;
	Wed, 10 Apr 2024 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwdQRoX2"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFE3BB43;
	Wed, 10 Apr 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792178; cv=none; b=Mc0qVVlS08z3wL+UY3cqjQG+fNL2gIxqWa0HJM4VaDPiMC28o7SydL31mhEFPHgIlBNiWEY1bh2orG4oZV/wDXFBs/slnXbSWgXooT6k77Vt2opt9Q1AUwxH0LEPWeiHCCdZmn8rmre2ZjDrtBMj6sZ2ukyY1LuVR0K0E21Q2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792178; c=relaxed/simple;
	bh=3dPS/Dr7Mm5ktn4AhoyjpMG4l7lmd7uF0848jNlQCkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXW7gzf0YqPC+TA6ElV9fp/x9DvZUVy7/AL7lX8GKqHSPAUpI/OMYrDDQ9C0jIg+ZBJKz/RBTrCIkwlbQfubsl5yCURvTkUH9V9LSoElolR5+BORwItbYxCC/vjzl8EYql9qLz03oRxvMN4UHSIM/abEAK5LVYdljuAqiSYp+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwdQRoX2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2bcc0c075so1899335a91.0;
        Wed, 10 Apr 2024 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712792176; x=1713396976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCiwuhJlcdVymL9iabF0uqiMDb2CibrCH2dP3vtwOxM=;
        b=XwdQRoX2nJhz5YFyD4qmPJzSfgyO+jq7NXyevXyWPbEWfQXrsTwKnYqjHpW+2hARwX
         6WmeKDYDVhM8UVxbcSCYV1fNKZ6UTdk+JZ8XeFvIySNmLXij12EoNRpgzlXghIiSHuKn
         6XFNDeRXgWDLIESD/qlmhUAiPzMqioH3AsdXQJojZylsfJaYdJiHSVMDHGZZJW2eAvW0
         Oza2chM4ox/iEc+ifAleDmjktIUt6mXwXKIVAabFkbkxY00uYfQzQe/q9hdZNaD8F3KN
         uhWGN5il/m9p8Pp/B3iqgxvgeRN39def4WD1cBEXUr0zuaPPbrGDYq5WAmcyAX3Q/79r
         d/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712792176; x=1713396976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCiwuhJlcdVymL9iabF0uqiMDb2CibrCH2dP3vtwOxM=;
        b=qJFei6NLsnv27MkOtz4igZqeBPLEJ9lQFRbyZtE7PWHm9jReIROUWlRVGWZQ6/F2DF
         z9XHZ/DGuS2HfKOd+FEIL2nkFJdbZqfdBJ0J3oIM/8kBqajEU+YRIWyRP4PZolRIhmZJ
         eOQ/8Bsp6BnI7Eu9MftYuCowuf5moI5Ctm56qn7TD18HDHHq8Pa4NPsnmubc/k4g9ssF
         bFdYo58k7tph5Zp5jJYphik0kLQXGNfOZysWBfZC8A66n27LsAmaniPNFICko7BJpoAL
         fao4Gu37tqcAz24h+GNtvBLtYNc8KLkZOGGrw3hfLpbuMHAsyFYgYKCZWJwfrhC+TuvM
         9uUg==
X-Forwarded-Encrypted: i=1; AJvYcCWM1bCPkdqzYAhqXTpIJUlFSZg3GRaSoO0Vta4NVU4vjqBS1FM0A1WbRVgZQF9eBgF2MeUePzvtwSoBueIXHQGXa2vaucyUU/AmmG2cAAXMn9CI4+0dF6A+kch1U1vlXaA3xuLdiRFcR5ntCqF1Ev6qvM1nUCNsmiKg6/bHIuBr1TrPrY0aehY=
X-Gm-Message-State: AOJu0YwYGtbTyN7TzJNswh36E+7tDPy0GUnB3TqIH/FDJ46Pp62zNY4U
	yezZ2OD4jyFMp060hnjlhD6sa1P4ejpYdJmhgG+G/FVv/J645rpb3/0Pwjt5OQN5suK/WdKSP1P
	apA6htHWbGTp9rwImuoGUlr6bt7Y=
X-Google-Smtp-Source: AGHT+IHvxfBW1enUR1DnNYuaYxnKs9tO+hdbg0i47Qw9mY6cM7ho7vYbzxgiD/vaxzb1WdMzDzxpTGcfy4AZCrqiLA0=
X-Received: by 2002:a17:90a:4688:b0:2a2:6757:1de0 with SMTP id
 z8-20020a17090a468800b002a267571de0mr4070054pjf.4.1712792176144; Wed, 10 Apr
 2024 16:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170150.248428-1-krzk@kernel.org> <20240410170150.248428-5-krzk@kernel.org>
In-Reply-To: <20240410170150.248428-5-krzk@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Apr 2024 20:36:04 -0300
Message-ID: <CAOMZO5DFr8uhVRq8X+ZURCCAw4bLM4Ueaerr-gw554sFr+KLKw@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: realtek: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Jacky Bai <ping.bai@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	zhanghongchen <zhanghongchen@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 2:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.  Pin controllers are
> considered core components, so usually they are built-in, however these

You forgot to complete the sentence.

