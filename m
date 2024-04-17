Return-Path: <linux-kernel+bounces-148021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994658A7CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9AE2821E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353EE6A338;
	Wed, 17 Apr 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzL6LIOH"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A26A029
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337474; cv=none; b=aNghC10PPuPA5oKfMnIToWhipaIJ5caxizULbw2G5a68kigT9tPz8hLGmZk7GgH0PZUYNnkcmpZS6vfh4mc1D2UCXEK86vVCPRz9X3ikWqcKsmOyQBMoRoqVCclDOJFq0ulyVcaR4EUl9/HvL3FFK6u3PyD59XYBj2F1vsUOWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337474; c=relaxed/simple;
	bh=wLz8abfq3kVlKeTtyEzkglVJzpgzgi5Y0+XvQGzUkPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+K9kmquy0YJthy65duDIl2cMVRYd7zYd4gtilP/xJgnOeIXM0/BdxiPILrovCMD2d89V8DHCg61gVFHh8hx/uJcqomkuyv4gz2voOJDJv7OdhjGJ3qROIHXukVz06Q9dQWGb4iLVbGBPxyXYymmACGBfoDiZSNWOhD4xmG1ze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bzL6LIOH; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5193129276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713337472; x=1713942272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMFdAdNWn9QA3B40ntn3UH6P170zQmFmd9udvg/kij0=;
        b=bzL6LIOH/ticvMVaK/hybQD9ZvffHtbd1kYjOgf5AwWEq5tKzvWnGLHKAkWSySIDvC
         Yxc0kdvoS/DHdnjud0lJcB9P0QYqxC88pV/D/g/dxra6izLSpjySapEUqi4sVq5Hkwxb
         QgSjop2aKRzcuMuGLDooimPybVa4gwo5ONgaAowWJGbGhMlmZdh6jUz1dgiD9hOumnJp
         FJGzebq442y72GYVKZJUIiB7wPG2RPEpknB7U+bP/f2rWA2EIDPgqzZFKdLgt+LkeXgd
         ruDgAgZs3YRukwbFQ2WvYoYpaYr9561bQljQoR3wOrNKNCtdhzjOIN3nwfnl5vWlnCGH
         NaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713337472; x=1713942272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMFdAdNWn9QA3B40ntn3UH6P170zQmFmd9udvg/kij0=;
        b=nXyj/XPqtxiX7USlM2Io6PiyUtIjRnUvSsu/8OyS0TSH74f0CzONKWqLOI99ZL7RFB
         tzGk2ZLrcSTUKxWbE+cYK/DFLsFNDnJNlhSp8z16MZaGipK52wc2Qq+Chbysbqims9cq
         7pBzryGH8hr4IYrFZ5KhB9M3ngPA7TqEpcSzvGlyS4gu2KDX0UYMJtDlhv5dBRREJAvW
         5DGUJONXwmPGeEp99kQAmqQ2GmGfwupkn7t9MugYAH8LQGAV8tOVt+zmGLsj8Z2fLzZs
         wG03RqYmjS42MZKR412M23u9ZytPuPUvhZwreFsYCQdBGCZgoEKCvfQnbuUnWp6azyM9
         E9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBDdW9a/zLvcgfBFUd64xvH2lNId3k2SVvlsMV420Pcg9DcenhYAQn7OtI+1Z8BmImWNimucrEOY0rAmktMhlOd/JaOaVvyIqaGDf/
X-Gm-Message-State: AOJu0YwyoSaGVk06LAfEWUxZtlLS9SBzc50vTAShu1GnvEGLRzhJHvBH
	cNggkbpp0mDXLH2WHvXB74dQp9xXkp48Pi/tMRjPKjuoIo1h6D0/Qg0J3pCQidLswLgMpUsxTdK
	IUY2jJ2KHn6naMbSuDdSGhfQwSmjwz2vC5ee90g==
X-Google-Smtp-Source: AGHT+IGgMo3eDQxlf11bJcRNOlltLMZRzS9QWPPxupZEHndTAtFDw9DLGVw5mr9dLI78B9QKduCiAvMxBX9xGcuKHcw=
X-Received: by 2002:a25:abed:0:b0:dcd:a28e:e5e0 with SMTP id
 v100-20020a25abed000000b00dcda28ee5e0mr12063316ybi.25.1713337472251; Wed, 17
 Apr 2024 00:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141814.1983384-1-github.com@herrie.org>
In-Reply-To: <20240415141814.1983384-1-github.com@herrie.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 10:04:21 +0300
Message-ID: <CAA8EJpo6oUi5PXO31j0ZL8DfqiTNLVR-VZ9wVrKxOYxS5UwdLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom-ssbi: add support for PM8901
To: Herman van Hazendonk <github.com@herrie.org>
Cc: andersson@kernel.org, benwolsieffer@gmail.com, chris.chapuis@gmail.com, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 17:18, Herman van Hazendonk
<github.com@herrie.org> wrote:
>
> The PM8901 is used alongside the APQ8060/MSM8660 on the APQ8060 Dragonboard
> and HP TouchPad. It works the same as all others, so just add the
> compatible string for this variant.
>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

