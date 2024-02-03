Return-Path: <linux-kernel+bounces-51108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107E848691
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2E285AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97C5D909;
	Sat,  3 Feb 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xplTRPv5"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B835CDC7
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706967833; cv=none; b=Vn/AXomyOI3YoYXQeJrWI28J3oNVrRxFtExdziQTyWwBB9w2qTy+JdD1teWy6yHQSY7EQbDhl8cZeX4LHk4EJNqIc7w1y9zpz1U6XynFbQHLyYNxT55s1dCsk7QNqhJCm3BhUGt30geamQ7BXDgIK/FwY3wrUDByUHO2+wnIDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706967833; c=relaxed/simple;
	bh=bB5NkbMpLI0HMjQqKghAYbfh6kYTOIzuHFhSgRTqF8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1LPqvGwIfi7pVjQSAALEeUCtMEOgUZEk2FzYtUpzUwN7LV8hghKaTtKuiOXYh7hFOe87WAINsHYEZLJnbKd7BXuYIbJbDT99+kNh21N0bWZ5h3YFK8jkTSsYysyT0wQS5pZ61ORlgPrKrE/euJoaZqAReZY2xodCZiShXlo7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xplTRPv5; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d8f31930so1353642276.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706967830; x=1707572630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Moz+VNtFoELbtekbvE4gjgVQwcWCMsMt8Pxrs1cix0U=;
        b=xplTRPv57H9fHe6LnBMdCcERI3feAeaCo41jCCrPg2eze8Eoo/PsbSvOdrsZpmlfY3
         F63PSW/SscYt8VhqjI5IC0AMtxjwfzVTQRsoA4CsGy90zZvnTkoOEXKzYiSu5PelOtit
         I0ZZZtn8mSerCtIxjUgAAwVoH6W5Mim1nBZU2zhb1LK9usflDnx7GL2ks6Eq2SUoytcx
         6DpChByqZsBdtiaiQRRAbOgjHQIcc1E/DmI7Qv7EDS6Vv/WZ5/mEpXJ6iTvrHDI+Xoau
         3IO560cECUFt7IqWZeVC56fM14trVlNTdnVqgkEDPuOjj3sBL/8HZjQeL9jIKroEBRJP
         AmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706967830; x=1707572630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moz+VNtFoELbtekbvE4gjgVQwcWCMsMt8Pxrs1cix0U=;
        b=vNJckOChVk9DRp3I8W4Qwaia0aEvgOjXL01quL7CTFHbFwF5S+Nsflh4BM9dZX3gUY
         ziq6dJoCAi2ngY3fyZp6ddqTAN1gd6nCxLGchFAoj7AwCLvC52OwQ8NOY/uvUlxvxQX0
         lzyAmMcvUoJXtPdMXEawB2Qx0SRNrkn+wT5yya+XBXwsjRNph9hTrCbqMg24Dt/PSKnC
         8Y70lJ2zvFWbEqU9pk9DyHL26e1RMc3wT+ndBTH4avK5iAOcPabPNNg1MZShxEC0s9Zq
         mgpitxBWvMAfmH9sTvwAzktfHHp09Fyc/B6ILCmxUZO9LWRUONtWf9+sOt+i274dPX8Y
         8QMA==
X-Gm-Message-State: AOJu0Yze/fQGdZw9XJed6QIx8NFX9ew+zsYFOkeuzEjnoL6+n8WvuMdD
	Kwjpq74Th6he44ikWUlYdXufLhlVhnuG6E19gwFmxgsH60SZu96zgL3XL462udbop3ausNM1Kmo
	GlglxI9U150ekmscU8m6eqXL6h4MM0N57XVg4Ww==
X-Google-Smtp-Source: AGHT+IHC1Kjcdw2ForbRnh30ds48ubtWrAYlVUrU2czhMHf7NwzSUklUGHHrewM+CW4nYQ+906Zj9TjWidJCAslfPqs=
X-Received: by 2002:a05:6902:dc9:b0:dc2:a46:3d29 with SMTP id
 de9-20020a0569020dc900b00dc20a463d29mr987960ybb.9.1706967830271; Sat, 03 Feb
 2024 05:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eqepewdgp5k3ajusf3hk7nazi2eli2w6wgxlbjroldwyobzh3d@aewtie2d3ora> <20240203070008.15206-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240203070008.15206-1-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 3 Feb 2024 14:43:39 +0100
Message-ID: <CAA8EJppdG--2=pC=WjaK0HH3NDrh_HXLNmk8AMMMfCLvbtxpEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: ipq6018: enable sdhci node
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 08:00, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Bjorn
> > That sounds good, but do we have any one of those boards that should
> > reference &ipq6018_l2? Could make plug it into the sdhci node on some
> > board?
>
> Actually I have an ipq6010 sdcard device with pmic, which needs to
> reference ipq6018_l2. Also on the downstream qsdk kernel, the sdhc
> node writes 'vqmmc-supply = <&ipq6018_l2>;' by default.
>
> > Essentially, why is it needed upstream, when there are no user?
>
> Most ipq60xx devices have pmic chips, including some ipq6000 devices,
> while another ipq6000 devices do not have the pmic chips. So it does not
> mean there are no users but the supply is board specific. Maybe we should
> move the mp5496 node outside of ipq6018.dtsi.

Yes, please. In the end, mp5496 is not a part of the SoC.

-- 
With best wishes
Dmitry

