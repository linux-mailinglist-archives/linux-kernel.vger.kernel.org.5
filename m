Return-Path: <linux-kernel+bounces-166091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392818B961E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DA3282167
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD242C190;
	Thu,  2 May 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNF4aavE"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAE1527BD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637196; cv=none; b=OKz6wP6V8wFbdzRne3AAfSN+Ee5s79aAZaC+xaufpHyIJonQ2rGbzVnH7+t78Z7jHCEB4W1ZnIK1IqviDYh2ug023xHoItiiP0pwOM0JopO/+6HkZYPFwGuAnpSfcec5/KAdCgfnYalRrYlVUiT89MxGKqcsJ3q0Ax0h1VfO0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637196; c=relaxed/simple;
	bh=TAAlgVCtYWyJ8rLEZSKv9Vl6Fneb24lYVI70evDoNtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnAzgGZyTOPl45jfvqQTXV9ifrkNAXv5G5DBjZ3lRYBl/nndhddIkJEK8oQPcTZK3d+1IqvQQb4hKRDNh6/2WL1jyKCQK9r+MICsHv7VSBjHpl5S6mlkbGDhgIJSx3oTg3PJbHN/APBe8kGFnMWcuC2PS3dJTXaIz4ddI14gQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CNF4aavE; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso7388092276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637194; x=1715241994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAAlgVCtYWyJ8rLEZSKv9Vl6Fneb24lYVI70evDoNtQ=;
        b=CNF4aavEk3Wgfu9DhniAiG6nN7OUS53+gHVYgykRFs4BpMfb+x8RA/m+3zMoXjYiIZ
         gDszZFyk8j/Ov6zkl+7/nwFeaIgvyD1KHi6F39OP3Oh2LU2KSeRV7jg5FubVmKW3lw0H
         zPcdjnZCmpiAOGkRRacj5hXdrXUnpSQIQB/03wCojWglHcAHKLa00sm1hw5qMR1n3CMS
         NQ0ynTPISEmQCin20uLx5ESlY7iDtdbLyQ+Wa5ViNeXHt+DkLk5AkgePm5KlmY6mcf3Q
         tLXjA4bDIFuPyZbYA2ZdAOC4evzEOpxifjeidZoj1r0uqL8LIG6LPCT0ssNPG3qFgdSC
         bC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637194; x=1715241994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAAlgVCtYWyJ8rLEZSKv9Vl6Fneb24lYVI70evDoNtQ=;
        b=p3GzS14tyUGOpUp2QXPOyvRb0XMf0DrZ/MzdES7UGOlDdOqCxWtl21OraoK6S5wXpn
         tBHudbjsAmSFM++0znEtyx90ykpfcM9iI5AUrrRH3LUO6Upmfi7zzBH45VAsNZWyLbt0
         1R6h16YoOt1DMQ05ASTKfdnhJS1V1Ab9U9YQIholaqtdw48NqhigCfjWkOBIruYAOwBl
         bCAUbih4ol+1mkF+xhfDTqpydfClARyNnFTxHikVZtDTWcx/8lVD9JLiYlIGT4ij6ydp
         KMShGYcRfBdzyjVarXpj3PXVonN9hJulWwtnqXomTvj5wEZS2u69/YfIUSA16s3hO379
         Fhfw==
X-Forwarded-Encrypted: i=1; AJvYcCWvHnt+lhFjYKpsDFbCfo/VJgrBFa1fXpeHJOhQ+5ntoMLmZk0N8bf/0KRFNL/4sb5Iq2eT3+Yrf2KlEl2cl95JiLiYtKOd/MjtUUD7
X-Gm-Message-State: AOJu0Yw+qL3KQYgQDvx7QZeviRex73T9vaqmX7bEn9H7/zJTPUfU4dOn
	JZXgd77njkxcI5ZlKmp+NVAqcPwTxSI4Tbq+3b37pEVeJbhdp12qcGGDVnsZuEmpRgxynePmdEA
	j54VHlxu8B+Gyb5qGFnI9vP2zTcxmGNmn9P2jcA==
X-Google-Smtp-Source: AGHT+IEdpHs3MdojEWV7/ZoUgLG7frBLZ8CzWAbrlMKipMHZC+DakEVg0FxpmTiZsAKtA3mLCHDVNpEsXA1mtsst3n0=
X-Received: by 2002:a05:6902:248a:b0:de5:b328:243d with SMTP id
 ds10-20020a056902248a00b00de5b328243dmr1426581ybb.55.1714637193769; Thu, 02
 May 2024 01:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:06:22 +0200
Message-ID: <CACRpkdb1spub4TAtamZw1fO=WyyDyN1aKB89ZAxCEDbU0PLuYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] spi: pxa2xx: Allow number of chip select pins to
 be read from property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In some cases the number of the chip select pins might come from
> the device property. Allow driver to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks right to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

