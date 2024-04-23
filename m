Return-Path: <linux-kernel+bounces-155844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8988AF7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DB3282C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028A14265C;
	Tue, 23 Apr 2024 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaGGyLk9"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265F142636
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903756; cv=none; b=UORk5oOCXGQrq9ugDSEaFNaI/YRCYhHVyMxPKTJwvhuS9pdWJW522E+dCSTRxRxlv/DZ2insxkkwC2ML1D7IXE1H1kERH0CNFI5Hxpneev+dYioDzIS4ebFAoQh5vN3F5RA2L3KnSlYsPdB5b6yMcWq/x04dlCovqRtIC1pjGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903756; c=relaxed/simple;
	bh=GGErmkzlmC6WZeWA3tNtKikh8sr6ZPY2e3b9gFjXmWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFc4+93P8HugT+kA0+z6Hd/rAyraSZAej3afLPKARDpbIsQiS2UqE1b0YQY7SJ7CzUGQJpYVW+XhowbNYwYncnspnxlxt2cqV9iIojlgYG3vuwyCqsHilkmD+fOz8t6Au9dYzfGIhmHCnpKEmT+9AM/3EHq79AoHrJhAmLgoTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UaGGyLk9; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ddda842c399so6068161276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713903753; x=1714508553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGErmkzlmC6WZeWA3tNtKikh8sr6ZPY2e3b9gFjXmWc=;
        b=UaGGyLk9Cb27kT8FC2fYbRJwUqnyUowz3pRiIrYfYl67nVQEO5v5fZjhBmi+6NB1T3
         1P9JwjU62OPTbTSRA2bFKtteA4MQTeTLiKUKRNyItifo8Z6BFbpa0lWao+s76cHj2oc0
         PDjAUSLcuLTQwibRdWJo4iZj7K8dpHx1iwmyLE+6pivQMWaGWoTJFMvoaj95KnxvwIev
         zZc9k6PiV9FmaBfcAjMIJIcBFactrM2ugVkSWYa3wFAjPRVQWXwBDyS/L/g6zuJrIKfF
         dVOmkX9mm0wjeWtWvPWidDx1FaGd36znjRnHxdL/lDcLRFvQG4joB9I/ncy5W3+Tsg4O
         gy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903753; x=1714508553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGErmkzlmC6WZeWA3tNtKikh8sr6ZPY2e3b9gFjXmWc=;
        b=IHtmp4BrYQHERvy46UTt57d0PZeKjPB7s2YkPIE0gQDWrkB63adUcVKpc4ObamJHgU
         w93kSZOZTy2vKp8GTzirLKmL194nzPeAuRn8f+rgZ3FJ408n9aOhI3YiXLkB3HcWPqWF
         h7gBOOLrvQpm7py1ipsn4vGiiCXUjVg8Ri6dGIpyUzkz5dmRkxqofVjCT35GfhEyEu4P
         tA+Zn0kz8p0OR66mPwut1m1QzZm2NZeQk4eLQ/piTJj91JLbNNCSsuZvnXWqNLnauneg
         MC4lqkxltzFbUy9zl7fojSf6MhvQQr2SqFSn6q9SMoH2PNqweF2fsXgvfp+BOEcEEh0g
         xdTA==
X-Forwarded-Encrypted: i=1; AJvYcCVwSKK3G19vlihDEhEw/Y3x32HQWjYsraHHNZZo11P8fGR3qvBIjYuazgc5qqTz57gbIAE0xwE3+BON+VtjTp5bHZYI47Zsd6jFVLLJ
X-Gm-Message-State: AOJu0Yy1NCSf314Qzv7qBDXC65Dsa+z6/g19QgDvwf8Y6KCtr2tUmY3K
	eCFxpZ6j4sBLLilsOdU4ah2bzd4a+wViKY8KH3g+LXxR7Lg+b7/j1DwR0MV66Lh/aOp8qHcGJrs
	RYnYDtHuPlbntOBWhqM7SZ5xrN1cpTlrhOMdhNg==
X-Google-Smtp-Source: AGHT+IHxh1O/61oKqKBZj0/l6rCF9/gTe4NYPI6eeRZaerGL9bnOmfNdfhEXsMyfKOn5oHbujkuB6lRkBsp9K/L5um4=
X-Received: by 2002:a25:2008:0:b0:de1:2874:730c with SMTP id
 g8-20020a252008000000b00de12874730cmr780232ybg.26.1713903753454; Tue, 23 Apr
 2024 13:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423184605.2094376-1-opendmb@gmail.com>
In-Reply-To: <20240423184605.2094376-1-opendmb@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 22:22:21 +0200
Message-ID: <CACRpkdY78Jd38b32QdJrCbpT_-99F7tZ2--nhg+tPqkaqNfZsw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: brcmstb: Use dynamic GPIO base numbers
To: Doug Berger <opendmb@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:46=E2=80=AFPM Doug Berger <opendmb@gmail.com> wro=
te:

> Forcing a gpiochip to have a fixed base number now leads to a warning
> message. Remove the need to do so by using the offset value of the
> gpiochip.
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

