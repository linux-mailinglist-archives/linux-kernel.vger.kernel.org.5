Return-Path: <linux-kernel+bounces-148178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FF8A7EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5A51F22859
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DD7CF33;
	Wed, 17 Apr 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xh6WRD7l"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A112BF30
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344070; cv=none; b=MsFp3X+dFkfiA0Q8LwzXsI9XaZkN4/FLWtyCejjc9w5wCAhsfVzpTBdMi+uArOWHWKprVbzdZDyMHu6dzUfXLRxhWwO1AqYZHKyaPIwEGYy3FcJRz9WDTLMhFwhXSkXK+Gi1n/4BYExSYm0p16Q1sTTD2kPcEm2rdFMZ46UsLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344070; c=relaxed/simple;
	bh=pUr9jUEluNjDUpKL1XhdOT0Lv6IHStg0F/BBAhk+RbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TENH3T4wAojb2RJNtJ5VOSOlN0gjtztocw6LqGWmZfSNTQtmv61oD0vtGoZKXfgsNJG8caEsEbeMeRMCSg5gXqla6/9bde3ji7qR9cquNXlw80TByUMc32urm+23glCGEn08X78tVH61u9n0c2ln8iP+z7rnpsmj3GuacnKNtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xh6WRD7l; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-618874234c9so52441987b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713344066; x=1713948866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUr9jUEluNjDUpKL1XhdOT0Lv6IHStg0F/BBAhk+RbY=;
        b=xh6WRD7ld306d7OSyUtKRE3GHJ4Q9HJEBPDl6c4eoBdNtUiRPQobdsdQPvWc7bpLYh
         uVvjfy0OAVws+6K8shCTwuQaGlK1SWJoofC0AKxYhpNthXHXxyIJTvY+nxFuZdnxVFF0
         BIyFm8QaCOqylccZ0OXu1pg84ww1rmbeO6ARKfqken96yH2nZWzgN31+aPnzgTl0wjkX
         oRVGEwJMb4C1LbDx2gBl8ziOigHSE17akvRjzyCqc1W4W7OlBOpoO5KsvlzABOYnTWcr
         Ald3uueXCR/sDSQlMFcQ32hhOnsShpaixeg3BAnjVVWS3/p42MoXEAdkWcweLeZqbXSk
         /DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344066; x=1713948866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUr9jUEluNjDUpKL1XhdOT0Lv6IHStg0F/BBAhk+RbY=;
        b=L6C65MJI38vtRBWJdy8l0llIKXbZvHzQCWYPZcSTvczFmYSrqfzUnlu6C0CxqM0ero
         XzZBV8lMLHD/kQ6vc719CDxKu06Os25Jg9KnDOhg3roy1gxFTtVzsVS2CnmsHb1aYOQK
         EYWPBw5Q7+xjpm2a8p5TqwfaMdEfZHlRqOxF89PfYGY/d2r2SZhCrVxY6tox3o9ERTou
         wx0KXrRVjY2IgpPocKwsTjo4BTBEYKe24kMWlGamsZvD2N3dyajZHRmE46LcRcAe3H3t
         lTHoa0JMQ5f6un0h6tHs/o8F9Fmoy2kPh9McdaLtfHpyJwqjY7tn8d3Q7tgpeRTA+Wk6
         Vd/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+aN3TQkD/reBtux+mEUwNToalCzBW5XK6ndDkG0Io++sXWqaV/+WG3Z1mx1HeytB6duV5o34qg1+rcMTvfj04+cv6LoCVyC9uA0Ht
X-Gm-Message-State: AOJu0YxJ/lcnv0OgNQeJd5aSArzhSIhCadeqaIOE19iKxg5/FwXsROZL
	mTQFN8mjxAOkE4YLR1+3QzSod4zxp22H+CSH6tmkY97KkQqs9XjczFcfOfmax9CBhvLaUne48LX
	di70gqapO0zDU4sN8qM1Ns+NZshUNsPF9ndhJrg==
X-Google-Smtp-Source: AGHT+IFoYrocRvRpBR+ypgZ5EFrRrR3n9ZMMmvzxL8rh4lxaQr8TltkxYPx92/ZFTYrzZqdNCJc0eLD6/6tpslWM1b8=
X-Received: by 2002:a25:860e:0:b0:dc6:d457:ac92 with SMTP id
 y14-20020a25860e000000b00dc6d457ac92mr13322625ybk.31.1713344066422; Wed, 17
 Apr 2024 01:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412005128.2937486-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240412005128.2937486-1-peng.fan@oss.nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Apr 2024 10:54:15 +0200
Message-ID: <CACRpkda3SQ8SMy3eFE5KhmFWwEviF0gUSYiWEMMVN0Fs2=8yhQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: print hex value
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: brgl@bgdev.pl, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:43=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Hex value will be easier to match hardware register bits layout,
> so same as pinconf_generic_dump_config, print hex value.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I agree, and it's debugfs so not an ABI.
Patch applied.

Yours,
Linus Walleij

