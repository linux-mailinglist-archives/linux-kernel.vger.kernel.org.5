Return-Path: <linux-kernel+bounces-89382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D159C86EFA5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B541F21DE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E474012B9A;
	Sat,  2 Mar 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/BwCm3d"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B44323C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709368913; cv=none; b=cgCALwzYmbCAPKZLVGit4z9KA17HiuLZNw+o4feyAOuN/r88ZSvrxNwvlTxm/koeFGlolgeC5qOAIrwUBidy3zLUjUh9kuOWm0TRB1EtcKce6gH9vfxzMoKSHwESgnro6lttzyE825iRt62Wc7A4RuUHjyAf6ulhzLi5RYe7ceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709368913; c=relaxed/simple;
	bh=i06+Q/Vq3Gu73ByxmtYXnfLawZG8jTRvZ7loBaUVmio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKdGn+Lm6lUDij5TrYGxKl+bKDF4Lvlg15tEj1+pi3usZDwKdBT374pY0Zsxz1lOAajd8EGFyJGW+a8KG1VmyaMGpE30qhbVyUiIUNhxa+NdKfjRlaWiQHtYT7TTzhSAhW2pHRGT+2ZigzQVNDscx1yxcSOuhQLtDMxG21T/RnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/BwCm3d; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso3221575276.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 00:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709368910; x=1709973710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i06+Q/Vq3Gu73ByxmtYXnfLawZG8jTRvZ7loBaUVmio=;
        b=X/BwCm3daa/4v8ZbznXYIxraczIYaIvNdUKhKVScjj5FIGOnMIJ9hsSUwjlbqdDHhD
         FkVeQA7/J2FWKYcytDAWWcW/67XqoENb87v/sQJbwLJZX4onpT9EeEuvwRQ7J1yS825Z
         kYi61Zfil/nqdw8BvUe/i2KtULWQXOZ6ZYjBLRbvwFfYehjNrXCNmsUeKbnwK7OWMZE7
         vEmARiMFs5AYnfCjUm+UbGVk5Vf/ZA9WLncX0lS/nsfQe55G2LoLMW6yRF9W0FeqUyQN
         Y6IuiC7PQ03Ff4C+guh5KB+s9czpvm3xQT+zrRxSh3jW574vt/LLE7KHh2rkGxrpMSW2
         9Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709368910; x=1709973710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i06+Q/Vq3Gu73ByxmtYXnfLawZG8jTRvZ7loBaUVmio=;
        b=NnYGMkp162a7yxNlwyMi1vKGUUsuWOsQ0d21wOxhbC++GyZlZ9hRZp2sx3pmXWeAvr
         9lUxhlRbvYR6r5zSSaZ1gXLnAPlN4SoYmEX4HaEZbUnTBxj2BKMoQMoyd7bwt5Nh4rzX
         tIZWvKGyLgqge9CDN2SFSVHCYHnJMb7iNwdEZeyVEH+2w1dqDHEnFaG9vKNsF11a8TkV
         57F3+igE5PMT/9WpiwpqFrphI9x1trQLLd8SnEjKWUWhXEmIk46rIplQkyjYk2uUFqpF
         MOjscqzrXd2Hd5HEcIMhRRGzr5KxGTmAC05XIHZJZgI13PqMfrNQIwoF0OshOg1iqgNF
         j3qg==
X-Forwarded-Encrypted: i=1; AJvYcCXzuUHflbb1MFU+aniPZBDaWq2bm0UvMJiJDu0v22mYP/NkQvIZ7a85VgG8EWXJLNH9ee2WtyicXTOyld+HF9pUadGjQ3FB9CtkZ/VZ
X-Gm-Message-State: AOJu0YzjWARJQ1nq/VT2su+gPbKQdFq2cA171rj4tHe81c5eNgK2LbJX
	wuUd0JGTcscaXki+fi97f/Q+yqA2W2uhlFvVRYa3U/87r68o763D0R+NjrLJA63yCzjtB3L1b+g
	ozsyuVfeToJRIug2EWpU62Vk80eUN5QztesADoA==
X-Google-Smtp-Source: AGHT+IF+W26qPzsF12czVIW2SxHT2d1xwGHhJWPuMoJc5YsfUxwi1XPDF1yM8wJqarGflY6PCGtR51z5voIA0ZbbnLg=
X-Received: by 2002:a5b:810:0:b0:dc7:4692:c29 with SMTP id x16-20020a5b0810000000b00dc746920c29mr3557511ybp.33.1709368910700;
 Sat, 02 Mar 2024 00:41:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302004439.197232-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240302004439.197232-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 2 Mar 2024 09:41:39 +0100
Message-ID: <CACRpkdadN6gQvbAEDc8fjhucB2JmSH25HP+gKC0vS1vic0j1GA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: nomadik: Finish conversion to use firmware
 node APIs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 1:44=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Previously driver got a few updates in order to replace OF APIs by
> respective firmware node, however it was not finished to the logical
> end, e.g., some APIs that has been used are still require OF node
> to be passed. Finish that job by converting leftovers to use firmware
> node APIs.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v2: also update necessary parts in the respective pin control driver

Patch applied on top the rest, thanks for this rapid cleanup!!

If the test servers are happy and my manual tests also work I will
merge it all down to next and send a pull request to Bartosz
soon.

Yours,
Linus Walleij

