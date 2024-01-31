Return-Path: <linux-kernel+bounces-46524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79952844106
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFD8B2C369
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC980BEC;
	Wed, 31 Jan 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLxpQJZw"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42107BB03
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708551; cv=none; b=MXaL8sCc/BPQgOtc88MBM5ECWaTcm4HVeFQu1nekQyZKdDGbkMzBQRqEG3xkd/OMLI2GKlsKG2+Bs4KrmPg4sjDQG2LbRp8x4GBHTLUkl9E2pZ23OZcuCK2qHDPFyjLo071czqLDoEFMDQaLIWT2CRcrA5yKnIm0EJNOWkjCSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708551; c=relaxed/simple;
	bh=rNDiQg/0u3pLXkbL7csdAnsOg1ou8bFEsbWHOOg35m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivs1OSypomgmEhfTS1Df0578xdDL+aMO8g4TKziytGHCg70vIFRAqJ4GgLPOrBjeLN+A1JTHUka6qHhbFB70v5IalVQDg9PTww6fyi++BxPPXutA+K8H0DsOosGf0buX9rpT7CAnbm/Mzd1gCNwErEzu6IV815DAZUg1+wcstec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VLxpQJZw; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so5460105276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706708548; x=1707313348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNDiQg/0u3pLXkbL7csdAnsOg1ou8bFEsbWHOOg35m8=;
        b=VLxpQJZwt2QgB4fUsdFMmcyrasV38nhgYI8aUT01QepFbyHkcZagqLXnaZ63m2/XKd
         5cHaRZC+zwaUpdCKRA77u78jsIL5VKeVeCefaftXoFUhZFqlgLggk/KYN3Yy1/7bnGWs
         oO/zSvgTJ+I7BoT7SofS6Japxkpm2mBhhoYgOVzud1rE+V84tZvf/1ZPx+syxSi0J661
         YxQf+VOAhOyWbRbpdKoAnMN1fOoCyPJRdOooFj3fAf+x0oRW3WhU/dG+Z/DLHYRa1FCe
         Bb+aav80iceyvf3LE8LiBcz4Q4t1auCn4BWQsPEOv04YVTHRZyQ4TB+c85oWzhdIdM9z
         lxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708548; x=1707313348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNDiQg/0u3pLXkbL7csdAnsOg1ou8bFEsbWHOOg35m8=;
        b=LRZRuAsLpT1YR2hWK44tA+7yNBiUUOo+/GdLWevj7YXAZKGLotUeW4DOmGUJGMdM6c
         SpDEboyfsh1eDAENiA+TfIu1clnR2y3Wy8kEnk40JDIq060CMjnqMh7lIpQ/oBiI/LXU
         MmFhEvR0ZtQ/ovmKDSxsZI+4I91midHQzsQ0QVO+hRKbTOMYyHe5tLPFdKv2KlrWSfbL
         n2RBMXL+QTvqAgcYjL9aWsad1B+PcUP5qT8Ybo+VvAYJiIotIIaWzTrEuxyGUcipDHkk
         +vWBB+gPqrqK5hZaCp26SsdJpyd2Fc8QBQQjA5Lr0rWeRvUaM4alBbyiM7AMBa6kpKQy
         m+lQ==
X-Gm-Message-State: AOJu0YylRnMV9/JWlZhJaM2OmGpIJzs+qBmczmR1LiZyE1/RsIOMSM4k
	1dHsxtU6+FEsTolISISpqcpyCcN5dXrJnDCRGTPH9lVpYykx2RBfKmtqGGgvOWAu5d3xHYi9ZXh
	/goNcHZLb1m4QMOypNlda7orsWQMkN2rWGyKLWg==
X-Google-Smtp-Source: AGHT+IHskTXYXxhxPI1CgyG/kvHZeTnVrHblP91LDRSUCVYbyamup48H0wM9rtBK+kf6LdjtM5XNyL3x8PSddYdkrYk=
X-Received: by 2002:a25:6f83:0:b0:dc6:4b7e:d7e with SMTP id
 k125-20020a256f83000000b00dc64b7e0d7emr1623063ybc.24.1706708548654; Wed, 31
 Jan 2024 05:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org> <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
 <CAMRc=Mc1SGLeUOWmKg=fvCdM+RR6FSu2QkFuR17s7L99eRMGug@mail.gmail.com>
 <CACRpkdbaxqTzwL9L02vCpMMdBYsubNP1VkNuJ8mXB_=4E3Kjaw@mail.gmail.com> <5ef64082-0b44-4bb2-bd4c-654c96f4a9bb@linaro.org>
In-Reply-To: <5ef64082-0b44-4bb2-bd4c-654c96f4a9bb@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 14:42:17 +0100
Message-ID: <CACRpkdYa0nj6PK1FecBpQfOfkXhetwRmAyDgWNjJxcf4xgExMA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Geert Uytterhoeven <geert+renesas@glider.be>, 
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

On Wed, Jan 31, 2024 at 2:32=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The non-exclusive GPIO was made explicitly for regulators, so it is
> working fine there, but it is broken everywhere else, where the drivers
> do not handle it in sane way as regulator core does.

I looked at it, it's 8 users in the entire kernel that aren't regulators,
so let's put it on the TODO to get rid of those.

> To make it working, either GPIO should be enable-count-aware, to which
> Bartosz was opposing with talks with me, or the subsystem should mimic
> regulators approach. In some way, my patchset is the second way here -
> reset framework subsystem being aware of shared GPIO and handles the
> enable-count, even though it is not using non-exclusive flag.

That's nice, I was thinking if it could be abstracted so the regulator
core can move away from this too?

I guess it may be an issue that regulators are not using Device Tree
exclusively, but also has to deal with a slew of platform_devices:s :/
IIRC that was one of the reasons why it looks as it does.

Maybe reset can only solve this in an elegant way if the solution is
tightly coupled with DT and you have the advantage that you can require
it from day one? (It looks a bit like that to me.)

Yours,
Linus Walleij

