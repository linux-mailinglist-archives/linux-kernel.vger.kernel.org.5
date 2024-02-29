Return-Path: <linux-kernel+bounces-86810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD386CB22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265F61F2507E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D361361D2;
	Thu, 29 Feb 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7rNCS5Q"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B91350D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216058; cv=none; b=jWptm7u64d0vZ2G3ZKH9paSVNDEnLUB6n225ywiXf9WJ4PJCDJ99TZV+o0oNMZ5h0lf3KHmfqy/MluBABZm6AR3KOR9O5rIzyJ2QC82s0tfcOjngYK7WgvWeNn40AWyTTk7pabyGN6jSH4qkunuclR2Ah94G0jN+TdmS7MwSGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216058; c=relaxed/simple;
	bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYA5j4I3P200HWW7lTkbgo6Fb3hQsm4rx3G/nS2F4Z8E81mXAApzjK8OWMdT9mUCQ5ji6xMiHvGjvnVO2OKSxEmH1r6qGyW+C0DRs/kci+NJCEgSkcxb5i6wSqMqZekuhzXXTDbiZhtEXkdsxoo3jpSKdE/Fq+NSbYpruZ5QAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7rNCS5Q; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso1076013276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709216055; x=1709820855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
        b=U7rNCS5Q4Wm6KFwyDDzrg5qUX5k15bLbOzYxyKpo11u4DgwTEBLJB5E5A1DPSvUXIt
         9KyqSTSMWO+5JZ3wJa+L7U8ytSVOtniIDk04s2kLIS1oGrLO6wGdKpR6TX6sCX+YgTw/
         +feAuAoPMYppHzEdfhX/88mmAbrTf//8qxREx/pSnHwQu7lscGXrhORQ12/yvcaNfnMK
         /EQvPrx3GRFgOW2S5tyYbkdoCN+JcaVSDLCNrTTpRiyJ6AKGst3/Iz04AjBvlrZXOeop
         OF1foZGOdiJRrydRJps4wJhNi4z579QE1E3C81hcM6hlAiNhG/ZuB6xGhAz6/phBxIiK
         WJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216056; x=1709820856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
        b=gSKITFRUR+3Vf2hlnLkk+skTz8nRbD3yxdwcNCm87uONbDf879FwMarXdNClr1lrLT
         MF9Zj7cgfrdKpwuAfV+tp3fDo49hp1XHe99gG0yDYo7rKkQ9BcWP4pjpqkY4AtJMcRLQ
         b0fgrq315Pn/v0MRced1kx0NBYCDnm4Hk1xsG1tEYRS2tIuyixBQFTE3jb1+rEZkhRDZ
         DGuLsFQbzzw700/VFb468iayJQdCGQS7y94tp+4TZrz6jvDwIThySGoJ3r5/KiOTkfBi
         h/dQ26IssLSAULJEkdFLwjNoTYV241TEfqMLWGfQIBFI8ME5XIPGGoYnoJpg5oxQ1WeI
         qUAg==
X-Forwarded-Encrypted: i=1; AJvYcCUxtHhlJrMCcIXZCDaQMaNLpdj6VsMX7Kbc/oQFseBRSphTtn9+bzq7jmFFUAiTj/6c+vWjzqeMzqxJrgNrzxWhg12nEMHWgPnUrV96
X-Gm-Message-State: AOJu0YzNp5IPjjAMsC41r/bCchrf2wwgu9DAXQMuW1Pt/Q2GoG2h7nRJ
	e+VO9Fsitq4wkBFj13itodIP/GNPdL/RazRI2OaKEPvhxMknf4ihHG6H0zcqlYL7urWBcbPy7dJ
	zFTfnmF1L7/Tne8trmDK16y2G0cb1DJsyP821rQ==
X-Google-Smtp-Source: AGHT+IEHu/G/RhbOGKUNEO2WjqaeGbfVkPM+qKPD0bGUq5f2BIYPRcqqhijch3RLX61Osl7GsvNx9tUYDJLBmHsC+NA=
X-Received: by 2002:a5b:f05:0:b0:dc2:2e01:4ff0 with SMTP id
 x5-20020a5b0f05000000b00dc22e014ff0mr2149084ybr.45.1709216055678; Thu, 29 Feb
 2024 06:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 15:14:03 +0100
Message-ID: <CACRpkdaEzexhCYFf-NKnbcagXc6Tqcn4J+sFWk94mbJG9LkpVw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] dmaengine: ste_dma40: Use new helpers from overflow.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> We have two new helpers struct_size_with_data() and struct_data_pointer()
> that we can utilize in d40_hw_detect_init(). Do it so.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Wow really neat! Much easier to read and understand the code like this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

