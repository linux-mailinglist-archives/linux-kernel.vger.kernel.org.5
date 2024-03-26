Return-Path: <linux-kernel+bounces-118932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBB88C163
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0802E7C90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0596F07E;
	Tue, 26 Mar 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="meYl6z2H"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD06E616
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454413; cv=none; b=iiGtHY5o8/WHQjxz34/VueqZXIR3fWnTmLb+ipV6aedzdx0IEEED6ZIGVO//pXh4owzfPQgKF3ts0cDVIepaaC5qHwS5Gid7FZIE2Yb5QykKhPUlvDMu8kqB4m4gPyf8IHa4EGBqqxiZno/uNTe6w7fbeKFgH7tVoh2Q4HRZTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454413; c=relaxed/simple;
	bh=5DLrqyloRw4HA2iztKCEKBkf1PO/zzmKtFuIEtK1KD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdnqJDJWW45iRV3zXqWCovgD4DqNXVyxoaA4QPEk4mFAQjeOU6EwPo1tR5uQflgYl/Lh0VXhB85BFNCDVu/3ghplwcsapRKg+5ce1WzShcwcQH7+sSZlKRaKD6cX0atJ+Uz0EKig1MJQ0hQ87KnvCvqrQzLC7FY0Y7RPM6NDWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=meYl6z2H; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so18250671fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711454409; x=1712059209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCv5OyIKI9MbyQpyJs4bOZC+lzj0+dfLVYcz2czS3cU=;
        b=meYl6z2HGqvvCqek/SBsYcOkCtaKFnITbwl32h3incexUXPyhEZH/H/dpBRqQoNCAG
         LVC/T4aD7FxzYz9bg/NcIbqxJTK/AwGSsldHvdiXbaAdvJBR5M3lmGzBVdafT5UBLQw/
         Hu2rAcV4NSVmvuj3R3ZqXHslGmXd+tMCBRKT7i6aquf/yXP9/zpb8MwOGuxPzZVRtNn/
         Pni/Y/Z3FlDrbx5wyZWh4L54cdxZGHbC15tjR06G3Azup3ZfanahUXzUY8Llk/LUKtJm
         5E4lbB4Y/bSxhh6bQllerL5qTvkKV708KDRUS179g/QEICEUDpJwCi68rF5oJjjk3hNp
         jsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711454409; x=1712059209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCv5OyIKI9MbyQpyJs4bOZC+lzj0+dfLVYcz2czS3cU=;
        b=NrWfvytQSrE+qJN1W8B7gMBDilcKUrVgguWjJVsCgAqpZj6Npl+kat9DyzgTEirQ3Q
         05AQ2eXVCDFWdcwRRPsr0cGEL4bl7EHNYbJsljVimE/muZNMHElP+Y+MPBjzre/wdNtw
         qVWWAk2D44V6uD+9tn6+vs+qNwkp+A2i4Sgwp1OxTLfg2hFSj3AjYwU0pKL6OtwZ6JIr
         e2uMFtK0COCiu09oHRW0XIyG5s3Tma6Kv/8TUgc9EcziUt5Vki2Sl5mPskwraat4xC9w
         vZ2WqhRGGo7mgcGDGjlgyJS0Y0EaKW5gv54QXYKBfWXnWk48qqHkMlSxAn+SEHeqH63p
         y24w==
X-Forwarded-Encrypted: i=1; AJvYcCVRcQ3Egcm4ulbxYQA8Q66LPNGfCne5NZpoxaytOupJQxdKC70QtwOZx6DMVLzlxDxczbtHDowrfJ1OJ3/kx9OxSKT6lEKAR9iGheiW
X-Gm-Message-State: AOJu0YzeyHX+9+qjSc7AVg9ZO9YD9WfOo3UrhBFhNJdTewuzYl5MF2o9
	CxUhzhY/GNoSbjM8ewSg4X7XpWaeW0FaWbaVhvECUQO7noQxNU7v+idqXfI0mud6Lh5QkrgGCK/
	PSDnu0Cuw8O96GmwyCqII8y4AYt7lH3CkZ1HeLQ==
X-Google-Smtp-Source: AGHT+IFNzs3lUN7jBqt538CCJ/Kmi9XufjzZKlCPHzb2+sbiFzwhETIGqSwEBOwlrE9EYPH1QyZuRmy5e6/qRp6e0hY=
X-Received: by 2002:a2e:3509:0:b0:2d2:f5fa:f37e with SMTP id
 z9-20020a2e3509000000b002d2f5faf37emr1412010ljz.51.1711454408639; Tue, 26 Mar
 2024 05:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-gpiolib-find-by-fwnode-stub-v2-1-c843288cb01f@kernel.org>
In-Reply-To: <20240325-gpiolib-find-by-fwnode-stub-v2-1-c843288cb01f@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Mar 2024 12:59:57 +0100
Message-ID: <CAMRc=MeeG6+Q0YU21k19ADCDumDqSVej1DDdydi2axJ3J7Yf-w@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Add stubs for GPIO lookup functions
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:01=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> The gpio_device_find_by_() functions do not have stubs which means that i=
f
> they are referenced from code with an optiona dependency on gpiolib then
> the code will fail to link. Add stubs for lookups via fwnode and label. I
> have not added a stub for plain gpio_device_find() since it seems harder =
to
> see a use case for that which does not depend on gpiolib.
>
> With the addition of the GPIO reset controller (which lacks a gpiolib
> dependency) to the arm64 defconfig this is causing build breaks for arm64
> virtconfig in -next:
>
> aarch64-linux-gnu-ld: drivers/reset/core.o: in function `__reset_add_rese=
t_gpio_lookup':
>  /build/stage/linux/drivers/reset/core.c:861:(.text+0xccc): undefined ref=
erence to `gpio_device_find_by_fwnode'
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied, thanks!

Bart

