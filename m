Return-Path: <linux-kernel+bounces-117212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7088A8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CED34570B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755114A0A7;
	Mon, 25 Mar 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLAottkP"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BD149C66
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375846; cv=none; b=d7BeXsgo1TeoEdLoebi2EMd8G9LEJ7w0eHlEKw9h2ROGnAGF6GjhMrjdOfBjOPLC0XKBHW8DBSBoO7VvGGOM2Fo951QOPmCMPfPn/YwxTZbG/C/Axs0J+UmNk4N9btCQq4sdyQWxLqUQns7TlpCm3scxMonXItpuz0u5OQEwEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375846; c=relaxed/simple;
	bh=+QYOdWMPVby5jZqjvQM8+GF5g7s+FSbARSBKiK4+XKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT7Z4OitDQnIxqhzRvNeT6Y69jpPbUrlivZBxlGozATU3M4E4apE5W5gohpaSVMZ+jzlHGwUjS+jGpt2yVyDy+q4WQtRm49oCi8MomfIiXB3NbI0mmLn+XTgEEbTuD4EquSInTgauZE5DKvPLL2QIxGT7+8Znnfnu8OOa0ufbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLAottkP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso4001476276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711375844; x=1711980644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=txFP5jH6roviK6Ext4CLx3t1HKBA8RgvWyQlQ3eWqFA=;
        b=OLAottkPaWDsRg66TFozTifR3NbFgYiz13RDyldFcH46HyNIE7PIOjpkH6rJrPO+2s
         hSqZUDRnsrLfA52eSnw8Tr9FyvWO/gPe9slRHkySIXzKPbJfUnqNtakgk3qBwnsIeZx0
         wWYRCkd+N2YUy2D/c4njD586fY4fPSWUS5QgTjkpi7e57tX3Z2biepWCkyj7mQklMYZJ
         yX9WTAJg1PmR0nHWpTQuGfJOXRiKC/ARLv6RG6FulWWEv5LKWHfA4vU0lmTpWboX23xD
         1fH94Ozabua+dEi1qyTwCpe3lkT61muvBTO2QSvWf4mLz09af79j61gHg20ug9Mazwnn
         Fe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375844; x=1711980644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txFP5jH6roviK6Ext4CLx3t1HKBA8RgvWyQlQ3eWqFA=;
        b=nSvMdaa5Pfet5QXlXtIGVXuZzlC0Zjo/CiHRXjoefjUD+ELZfL7a6Nd46HcNcX32cs
         RwALWlIf5CplIGJ1dTie0mYlAWC08Nb3nvbmn4DECzLxutmmF7mknBWkWrOxPowSip1G
         Z1/8aZadJZeGagSF6dtPRvVJnX9hj1UX5SrN2gIZwP3mrBFWEAkS7RhU5Tun9rkWG+Et
         p5+0tu/5ufrh2/bHhHB8y/wX+V/ODrjcRLaJKOTuvt8NW4Rya8tGMMfidPm+zVDLHd62
         cuGqx14fkP1mUkwRrMMoCulXK5KU6/zL2cdFg3r5LbcLUrQtotnYIzvVFD1kzOEtpSNL
         135w==
X-Forwarded-Encrypted: i=1; AJvYcCUb0aOZEo4Vtn+xq+L7T1WhWMhUohUK4FWEZrtdXU+KxHh5MIDa9zu7nyaJnzJYeU43zc3oLxM43zDZa008JxdrNpzUR8ds2BCTCYEH
X-Gm-Message-State: AOJu0Yxj6HxDZjg3fshKQ/dRLApCUGM9n6oZsnznpCL4VCCd/9Fi98zC
	pL1TygG4GLOqnil4b3H/ISnE6514KtM5CiMmzZon44ECIAy6rE+j1HEjVQpKkaUXrzSVLcS7pXq
	iHp1iF4uuS6CLZOttV9yIgz7vdirg9ZK3h24qrw==
X-Google-Smtp-Source: AGHT+IGK1q4FlEtm2qFSh9/hQncp6/6I/Wk9SmWPqaTVVT5u98SyrANfhyP3OahcZRjZ4NnXsYrWuGfGuMA9EjiBEe4=
X-Received: by 2002:a25:aab2:0:b0:dc7:acb7:af14 with SMTP id
 t47-20020a25aab2000000b00dc7acb7af14mr5485083ybi.5.1711375844041; Mon, 25 Mar
 2024 07:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325081957.10946-1-johan+linaro@kernel.org> <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>
In-Reply-To: <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 25 Mar 2024 16:10:33 +0200
Message-ID: <CAA8EJpqvYYCFRJVr732VORyHgpU-H2nif+n6hB6pJbXsqCH3_Q@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 16:01, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Mar 25, 2024 at 09:19:57AM +0100, Johan Hovold wrote:
> > Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
> > supply for GX gdsc") the GDSC supply must be treated as optional to
> > avoid warnings like:
> >
> >       gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator
> >
> > on SC8280XP.
>
> Can this device actually run with the supply physically disconnected?

On SC8280XP this is supplied via power-domain instead of the supply.

-- 
With best wishes
Dmitry

