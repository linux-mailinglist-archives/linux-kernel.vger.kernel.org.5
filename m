Return-Path: <linux-kernel+bounces-71457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FEA85A589
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218981F21ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294F374DD;
	Mon, 19 Feb 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYjXTyUQ"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFF2D610
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351993; cv=none; b=i43DtxBAF2XIawMy9t8ZIDp22jeTiSgfvevmA46JoWlBXGUPSwG6RA1Y7orRz+VcS3VWyeNMwvbfuM5skZMHFYt49CufPjeaxjf11veYhfdTjx/s7j+Fcd2ACRhpi+hsPSWgf6BiTd6UCzL6/vIsPsKddUSLX37BT+rxYoaNCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351993; c=relaxed/simple;
	bh=yakgxatxnJj6XQND1mgzVdcVV6fqvQwXLMjVua/FQAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiE1vvEeRAN2zTY0j4BGyqreuuGg7MIDQn7rjkPuy/3ybJBpOObYtpmfx+g7soDU4W17ij39zNVC4kRoT7in8Twq+72hIZiuO29zUpJ2n5coLJF81OkCzSh5FeTxTyWFkszfbhP8jfGowHYPIfXwJr37EY0LL19YtCEbrDNMnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYjXTyUQ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607e707a7f1so40974047b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708351990; x=1708956790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yakgxatxnJj6XQND1mgzVdcVV6fqvQwXLMjVua/FQAA=;
        b=wYjXTyUQzQFHYJXgyqu4Z4vi7xwEWZZ+hu8Kiga5hpzYDOx1pTJdRMNRfvYfEH04ck
         SJkY4ofsA1mYs5iguk8IhjlQwwvoYbBQYXFnaTND8d4lJShHllt843PGRBoe9WYJj1At
         HNw0uV8AYHhOlzeIApUt16BqoFMr+ErR1ew0hVQDXnlliadUemi4iKmjp/pTT/ML/1vt
         NNy3wlSfnIZ4s142C3Kt3hfUiz1fhLKM9uL+B7sbqTiRDTcFWfjYLXGYCUIQdXgYknh7
         1sr4UWPRarOB2GcotIwTlTd0/VTChOCTLwewj3AfR8Oat0GzzvA2ZDUi5+44KMjFwLlh
         9KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708351990; x=1708956790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yakgxatxnJj6XQND1mgzVdcVV6fqvQwXLMjVua/FQAA=;
        b=d+ZX6YAvbsl9sjM6/xwMPXZXjoUGpc586vxFFsPdZhGf/q+hL33XJ5ZxY5ABw0WevE
         nV8qgowdeMynsGUbpcyLszG3KeQLgFW7D7z7DNA9iGnxXMbnhX1Z7Y7hShX+GBxDlWD/
         fxE5N+Wnl/CScXsnk2FCeJ22HPNBGOaKw3NDqSCy3HSryY9X/+KlAaxE47clCtiQUkM5
         qQAQ8jYWeIjQA+UHNg3FgMhy+AWhk6DHvBWc7zLa3XHmNLcaIezJnO+0tLqrowFCnW1Z
         4fQ6Y/geTaVxdUDkKaWRLQG39MLAQyO3rEe3ZVnuNekGKfKrt4gOapjSJlKNrQSYn0cc
         bfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlGas0YPPlyHap6RTOQgn0MyVyjLMrFaae4eJm7K6EBDtXFMdKOYBCnIDyZAw6zCtW405qJro5B/z7qB7kdLSS65HxWdybOCNLxuOH
X-Gm-Message-State: AOJu0YxrJivqsf4EknSZEEY6rpb1qDd8T3WMwqCAoVIRiWuSSfhdN+tC
	U9K/jwaMsPrs9JYlmRaf4T1CLWXr6LivHJC8DGSJR+PA9UoaBEgdi+Upk5w08v5zdPbcflP0w4Q
	Zf2KF77m7fwB1jOQ6r8etKepXkfXxEb1r7XdByg==
X-Google-Smtp-Source: AGHT+IGjbvj/MUOy5k/jrn+sArC4bxPErIKvoZVJoveJFaQaake5ePStBM8UhZaxSmC2jmkv2sTNyhEbwf0oAzkLVEk=
X-Received: by 2002:a25:2e42:0:b0:dc7:43aa:5c0b with SMTP id
 b2-20020a252e42000000b00dc743aa5c0bmr11657477ybn.21.1708351989672; Mon, 19
 Feb 2024 06:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mbly-i2c-v1-0-19a336e91dca@bootlin.com> <20240215-mbly-i2c-v1-4-19a336e91dca@bootlin.com>
In-Reply-To: <20240215-mbly-i2c-v1-4-19a336e91dca@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 15:12:58 +0100
Message-ID: <CACRpkdaZVOpR8twgOiPifUgQeUKcertU9kdpH_vCYBaE0UhziQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] i2c: nomadik: rename private struct pointers from
 dev to priv
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:52=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Disambiguate the usage of dev as a variable name; it is usually best to
> keep it reserved for struct device pointers. Avoid having multiple
> names for the same struct pointer (previously: dev, nmk, nmk_i2c).
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Fair enough, it's more readable like this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

