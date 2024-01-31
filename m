Return-Path: <linux-kernel+bounces-46481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388E844054
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EACA28EB10
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2737AE47;
	Wed, 31 Jan 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnI8TbWG"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE7D7AE77
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707088; cv=none; b=cm2VASRzalmAPZ+8IEQef09pjQf7Gam95QGtZnVpknUB3bEVV92rPVMpuyjfZq3j6YS331wb+hVoc3yoZXjYyVk3jRc80zlFpR7vORObSxT8vfSEcsscAt/2BHkUOZwsQzHGgmX2WZrcTdMq1W69B0iCzl6xwqr00fcSYn2hQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707088; c=relaxed/simple;
	bh=dr6D8tcSVVpexu92k5w3N7i9nF+7FRKOS7uUR00A6YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X617LQlgBbi4FDnhj+xWXtCWA3cgNQMtq8BgAro0olvih+t7jKOOjaY07Ee1Q335i5a87Om3bVRF45xr+oMrG6995bhXBnOwOdcL4avnfLowty43ZvSgvoJWpkSTPd3/Nd/r3Xm2Hpaej+jN3Mp39hcQA/xyJIvjKUKbPa4jPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QnI8TbWG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6002317a427so43206337b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706707086; x=1707311886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr6D8tcSVVpexu92k5w3N7i9nF+7FRKOS7uUR00A6YM=;
        b=QnI8TbWG2XKPFB9aozCWTavISGyEjEIeKvQBhFVZ5daEc2Gvbg1a+uRaA9AEr1386U
         0xudJNvDJ30LyjyFJmsPwFu/u7Hxt8SIIBM4vL+b/JJRqFYk5NMC3lOENIkHYFOrbVxh
         GF57jP3AFv8Xg2eMG0Hb1EPlibZ0ZyS3kqTNZHy8iuxaX7s2XpL6+15F89GUjAoDWNXD
         MMfPk55M/V13sFxB+NHHhB3FiOQLnkaGO5GgUogGV91PZepnmTwbXwl7JBq2lwTO80KD
         0OQe5pFIf2uRB9A6KAJL0XvN1CspSRq3q2brtC/BDwHx7OAeIrhTEdKgC5qtkeOxjk2V
         hvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707086; x=1707311886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr6D8tcSVVpexu92k5w3N7i9nF+7FRKOS7uUR00A6YM=;
        b=PQJCpGqjimE3tmY9Mz33CA4daomwADKBaSZSooB2bWpPz5rOQwd3DNQS0wdtGpM9sZ
         VHXzZcLqWR9wyvWjh91QJ+iDiaPoaBdiuzmioflZDrrOselSTssb2MqzIga1GKRZJmWg
         fjro1vTg4hiUyz7HDf0Ad/k+YuKpQftDMS2XHJyZLkuL/Q1IQ3fz+4qfKo4T8anVD+Iq
         0SrLo39WLWeaqjfbL1tbrRmXH+TUAvb2DvnGrF/sdMbpOHVF9aDo3UcqPY2EeAfRSjKM
         +0S4MK1+YTUIxkSqs6neuQzN3OyJ2B046lDArL6sB7w6i7Su0FV+4ydk1afLQ1lDVaWt
         jsvw==
X-Gm-Message-State: AOJu0YzMY+Vw6Ws4wuywkQGgTzxviK9YziSUNpdtBWtDrRA6JzaNBACC
	91lEP+xgFWFR1g1FeTWEX/WVN5YyOKXyjvOYAK1jQMlD3IIqyOBsoMeoxpkC2QYBF4SBjoeis4T
	6czWksfZDqxtnpV/sRKR1vCA9gJed4euiU7a7EQ==
X-Google-Smtp-Source: AGHT+IFVACpGX4CJfjjGDw2bakc2klq/FcD8fSXKF03+Z3ok8uxur5h6A7nnyOGYfn7248iMkpgzntKDjCWeB+kOfoE=
X-Received: by 2002:a81:79d5:0:b0:5ff:f756:8804 with SMTP id
 u204-20020a8179d5000000b005fff7568804mr1275150ywc.45.1706707085871; Wed, 31
 Jan 2024 05:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org> <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
 <CAMRc=Mc1SGLeUOWmKg=fvCdM+RR6FSu2QkFuR17s7L99eRMGug@mail.gmail.com>
In-Reply-To: <CAMRc=Mc1SGLeUOWmKg=fvCdM+RR6FSu2QkFuR17s7L99eRMGug@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 14:17:54 +0100
Message-ID: <CACRpkdbaxqTzwL9L02vCpMMdBYsubNP1VkNuJ8mXB_=4E3Kjaw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:37=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> [Me]
> > reset -> virtual "gpio" -> many physical gpios[0..n]
>
> This is a different problem: it supports many users enabling the same
> GPIO (in Krzysztof's patch it's one but could be more if needed) but -
> unlike the broken NONEXCLUSIVE GPIOs in GPIOLIB - it counts the number
> of users and doesn't disable the GPIO for as long as there's at least
> one.

I don't know if the NONEXCLUSIVE stuff is broken, if you mean reference
counting isn't working on them, then that is by design because they were
invented for regulators and such use cases that do their own reference
counting. It's also used for hacks where people need to look up a desc in
a second spot, (perhaps we can fix those better).

As I say in commit b0ce7b29bfcd090ddba476f45a75ec0a797b048a
"This solution with a special flag is not entirely elegant and should ideal=
ly
be replaced by something more careful as this makes it possible for
several consumers to enable/disable the same GPIO line to the left
and right without any consistency."

I think for regulators (which is the vast majority using it) it isn't broke=
n
because the regulator reference counting is working.

So if we solve that problem for reset, we probably should put it in
drivers/gpio/* somewhere so we can reuse the same solution for
regulators and get rid of NONEXCLUSIVE altogether I think?

The NONEXCLUSIVE stuff was prompted by converting regulators to
gpio descriptors, so it was for the greater good one can say. Or the
lesser evil :( my judgement can be questioned here.

Yours,
Linus Walleij

