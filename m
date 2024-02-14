Return-Path: <linux-kernel+bounces-65479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992E854D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9967285874
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D75EE78;
	Wed, 14 Feb 2024 16:04:14 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CD5BACD;
	Wed, 14 Feb 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926654; cv=none; b=u2lFJ1l3sJhsy/p+QustzquT3VITxHxMJ8ZhDOoLnPWY0fm0oVnwMQJNJScffNW2f/rOcrxRKN909qYnRlFY9JrR7B7aUpnK0eCDqff4QS0qhhgPAGqJOU7G4FB5Ak28B5hvWhf83WR0cmx+5jojn8J/j6vNh66mqn4jpto/h1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926654; c=relaxed/simple;
	bh=19v6gx2DJfVlZZULMPm1mh6gRX7ouK7EO3zKbiGfPkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOr1eFEb+qIz+SuMsCZ6EGP/8H2HECBxPNO7jz6LhbOovBQ7F4Ij9Tt1Q/CowFI7EPGfZL4AMZgptmq2oIn2xEI+Qr3o3/4Jvfeor7QfA8AzTf3bu3t3xvqR+0K99sgJD/vK/AkUuodsQn3e99yZqfsZcRkqZPJS1hs4Gm96NzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc73148611so2273767276.3;
        Wed, 14 Feb 2024 08:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926650; x=1708531450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMfOvZOGSbuvehiEEFO5HBvjvnOP6eC+Oce6QL/RRnw=;
        b=ifcYXkA5/JFYDfoVGslMDOhU/odQ7LSo1Di0c26W1pJGMFmaZY075sbifW5aEVctMT
         wnbO9QVImnLBe54H3C0YjCqKtvYBmErni5IaiuxTbtAtS7atKtK8Otu72QmdmfQ6Nd6j
         OwkEP6vMQr/9Y4s/z3T2oUjjVf72ufYQnmmkfqD87eAoe/MHoMV2OLwlTzDJt0AQYtPo
         43HcFmrTdHc1chXz+nakIwaYYXHK1SbsfuRngMTT13oe3qFXEZcJfE60c6AuWk50tO/M
         kekmQp/FSDFZSrgEPXSNrI4jkn/1vAxrsNqZSvkT8MFsGYmsVzdzr88nQ8FR7sf6hXxL
         DNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw2B4AE7AEzCZ8fcM68IHqGwP7+2GXznTkwPsHHDIB4eHSyfq8NpcOIVYZuKOpUxjPpcbzr0fsb6ZYp7LudDyY8jACgAzrzlePr3+kzR0ACJyGhoHaL8EOsnYC7t8duNOfF2oOiDBOcA==
X-Gm-Message-State: AOJu0Yz5SlT7XQ192PVLOD7gNLzj1ZfCG1cEndi9IbQ1Kp3m5muvijbP
	IoykGY08nq+rtohG4W5Wdrt6r3sMSIlDs7Q4V1l0KTcq4LrFMqrA2BBNEloUc5w=
X-Google-Smtp-Source: AGHT+IGiK8YwR2fVLu7BTjJDcw8P88LTxkfFm9rVN6YNcRTWdanUEPTG3virTbVasP10GpRsS8QlMQ==
X-Received: by 2002:a5b:b09:0:b0:dcb:abbc:f597 with SMTP id z9-20020a5b0b09000000b00dcbabbcf597mr2474904ybp.54.1707926650515;
        Wed, 14 Feb 2024 08:04:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKRTMcbbNUwTcfmX06Nskl6VHDi+yIceB82eglvJb8YIweB8fdO+61+pyiaXMj0LonKfhN8wJQu9/5QGxTLOVbyAfJ/69mu7I3O/zqoXYFprCtq0v2PHDO4FIFVfHtQzpgErSnTgI7pA==
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s17-20020a258311000000b00dc2310abe8bsm2093263ybk.38.2024.02.14.08.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:04:10 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so2227841276.2;
        Wed, 14 Feb 2024 08:04:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1j25HUwlctFF6fmmez8QN9u/90D4Up3jCD2ikYt6Brlw8mzyQu9hqoB4P2e66/QYb/IQQgoe5vsi3UkiCOwq+P3Zx9CWX8lQ6yU6HZfbYmCXcfHgVSRJj+saY1NPo4ylvU95RcAvjyw==
X-Received: by 2002:a5b:8c5:0:b0:dcd:b432:9bd0 with SMTP id
 w5-20020a5b08c5000000b00dcdb4329bd0mr1529064ybq.56.1707926649493; Wed, 14 Feb
 2024 08:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org> <20240214155438.155139-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240214155438.155139-2-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:03:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqOecSzjPqGiQ6t--o55NmY+BfA6KfGrDkt6Xx-nj8Jw@mail.gmail.com>
Message-ID: <CAMuHMdVqOecSzjPqGiQ6t--o55NmY+BfA6KfGrDkt6Xx-nj8Jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: auxdisplay: hit,hd44780: use defines
 for GPIO flags
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht <robin@protonic.nl>, 
	Paul Burton <paulburton@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 4:54=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Improve example DTS readability by using known defines for GPIO flags.
>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> Changes in v2:
> 1. None

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

