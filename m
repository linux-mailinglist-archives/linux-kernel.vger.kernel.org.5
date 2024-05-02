Return-Path: <linux-kernel+bounces-166100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6A8B9631
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5715E1F244E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB113219F;
	Thu,  2 May 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDk0OmGm"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2A2D04E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637515; cv=none; b=iLVBI89cCHC4nA6GmACE9RdkQ5B66PZ1wzwKEq6ZELTvr2uqckBLBNhSCrasbFxgkAGeXPLrmtqOj1ge3f7hznjoGBQFHlN5oDAj2tSeTfozl1qJ0RzvT/N2AkhGD3Y8zM+ZUGSiezHcZu0XQ/HpI+npWbSMYh1c672uvQEdZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637515; c=relaxed/simple;
	bh=AxkLqxQzKhgz4GC9Gf06h2iC/l3nC8wOfhxYa15iJUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1zzmOMLRWG/cUV16GKeQOFN0LLm0zEDyeN9/mu+nUp+UZMh1ei3AmWPmHqXJBp/snfXtHGDKbwh1+uhL398CoxG5BFVkQhdRIFm04KQtA/wEHtFzYMCUiNmT4cKw8nIXpjrmWlR8sa2pn8cn84JDZgoWXLqiyr4AmhFyTZt5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDk0OmGm; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de596c078c2so7651645276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637512; x=1715242312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxkLqxQzKhgz4GC9Gf06h2iC/l3nC8wOfhxYa15iJUw=;
        b=PDk0OmGm8t5aM5t14gcwG3Ns9+q+FlgldEFuaTJWpdmUzxlxLvRStW3u5W05ShjTgV
         U12D8UUivYnklqVL7agFZEp6J1xd5qUUrs1NHHjOtObqFEYoDYzRWL9iLZ2erPyveGeg
         37ArbxJFltrYqhG5tG1onGW2xTpMEHKruII1KKBO8fjDWtk+zwOL7UO7mV8L2nws+M3N
         ubBFb5zT8EplYBGuSdhu3T3GKunNq8A7El9wFw2miyMxhgq1oGyLw/Oq6USmKHJpjlat
         z+5cIqAnrmwnJuj6ITewXWRLyyT7tcOFtzYoZQv0sUC+a8EoK2FBtOixqw2yGbykrdCE
         ujcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637512; x=1715242312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxkLqxQzKhgz4GC9Gf06h2iC/l3nC8wOfhxYa15iJUw=;
        b=GMCTPF3arq5W18NOVK9ut5EmFxkd+WpGryLRpIXK9DwdgYh3sR1cMg8FaWoFyEf5Vx
         NIsmKW9uDcJOgW9pz8AMfxkpmJvF+JNKjiqDsWufHnRBAKqSGv/nBk9hWz/WTeNSB2g0
         9HI7Aj/+P0a2gkKcyEpl5V+/Wq9bR9kWxM2dbKfqSUcJie+bogtvfrYhX9aOKKG4KJ/n
         8bzYZYzu54SazemNSGephML5EWNVymMpeJmVXJy/R5RrJef8lfe+Wx+xPq1L9rHXRX9S
         h+MXPwWat3UhrQD0Hq/8Rkh0yZRCphYWGZrSrN8/PKjKHJF9H27wOCxYkBCXIPzWzuUt
         NlKA==
X-Forwarded-Encrypted: i=1; AJvYcCUDlEw3sGg5X6bWl6YolXkfbnBsmmDeFQ3Vrw41JNb3GRDZU4rWodTTG5pwrA7EzmCV57yZ2LuQbPONO+lkzIPws+RmMIr3LzhzK6eC
X-Gm-Message-State: AOJu0Yyce85aNXUGW686VKuC6zElTXnanGkRZeh0HP7wOstcaZNuqUQ4
	PMBV/31MidVAdPpW8b82/EM+MvSbeEGuQFpkHCSsRAf3SwGzPCrC76cCECDMMCT3l8szZWFmepX
	gAGEHCoBiK0JdyrOHkD6DafckDEAA71XMJw8fIw==
X-Google-Smtp-Source: AGHT+IGhjPNgECD7yDSeleITFfk/B4zYUZteAUhS1Lgf3atsjCBfVHl7o0e4W3MEUJPn8a0m2qQCHm05xC1M/8Hy+QA=
X-Received: by 2002:a25:ae9d:0:b0:de4:6ef8:2778 with SMTP id
 b29-20020a25ae9d000000b00de46ef82778mr1528694ybj.29.1714637512103; Thu, 02
 May 2024 01:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-9-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:11:40 +0200
Message-ID: <CACRpkdaCLNO4XvOYk2NM2vX5uH1UP8KsAKmivmf2HO5Dd0yppg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] spi: pxa2xx: Remove timeout field from struct chip_data
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The timeout field is used only once and assigned to a predefined
> constant. Replace all that by using the constant directly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

