Return-Path: <linux-kernel+bounces-65477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032C3854D95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C78B232D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266295F845;
	Wed, 14 Feb 2024 16:02:59 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3505FF00;
	Wed, 14 Feb 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926578; cv=none; b=JxPcFrJEEijQHFu4o8dOCoa3IVvjhv/9YVQ9zrBaf8ZKHk0PaN4rcioJ9D2mO47at/+gZipOeTnWJzXr+StoJ2fM4aTCZAoc/fWqeHfxskcsf75KzLPQOFr4alV4GrHLuzIq1lXF5eN61zkfEsKHVHsJbcDjlsScIC4ZzR7zMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926578; c=relaxed/simple;
	bh=JOhGgWOBLHzlfl0ShDrN8m6jb3+iIPxQhzDHCGEnS+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADcL0ayFn5SoWGbLNCRbAneYSJlYMVsH7iNjzTq6mSK+rslPnksqUSeGmzKmIF9bg2xWvzLnbDSZvXgccHIP7Qg5xIWsaZVBGkjqTmJLEEf40DT5kepveYQSZLwovaTMBK21CnO8DTxnhq6qBRyyoYSMU59u5LPsFkl5jvtIB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6078c4cadd7so17681097b3.2;
        Wed, 14 Feb 2024 08:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926574; x=1708531374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L/79rtraSNUe6Xv7NrDNgtDKxSydrueix98kqkSg9I=;
        b=eapf2o5f6WiJyK4yv8PNzU4S6XZ6M0BCsP3mrA43c+Vd+X0v/KVs3XQiZp248QRapF
         zoWAbB/FB+XiB8TviN3LL9+bw6ONl7M0LuTKSy6nKj4WS26n/ImKMCDxRg4p4NvFNnct
         9SLUQMARSdu4aUiZ0JEgiOBY5mNdg7H6tMEl4UOQc7N7eTVFpSHUbj3mvPXL240BBBm5
         xagkaZk+g9sWFVSyC7S/k3hcSZy+RCN2ClfYgn+TTrxEkqTTu5+grqK79mNYAw9Az6AC
         G/1O4SyEuNS5fCb9Z1de06kjtetbnV7js8uq11YG2j8+ZrIUkMWK1rUL3BFRT5GcmLy1
         HA5g==
X-Forwarded-Encrypted: i=1; AJvYcCWtZrsClBVCn1sheEIlxFDqZmYQsnLEyaycqrvN6FqmTCDJSaAOy2GA6TIUKGbWrTUEmXWAz7afXJ5h2GNDU6j0ef9r3fhF1DMLCxsHqdrds2Y0WCUR7mJ2WJQ2HYmMpc4P7CAKwmbwzQ==
X-Gm-Message-State: AOJu0YwIRhIOQnhcgjhAP/K2/B+/rwmqs0WFDWRB+KsRUks1IYAiO4kM
	bzJXum1qwXHYGYrfOSZ32YDtgbK00x7Q0a1QfwH+cAIoRGe9ASjEHikpecc1GDY=
X-Google-Smtp-Source: AGHT+IFmVwDNq+8x+MUsgHUNbVgbTzCfEHmtr7iJfBdkVOobAxYi3JMORoFAtxMUNyFj6x2AnF2VqQ==
X-Received: by 2002:a05:690c:4701:b0:607:a8bd:c24 with SMTP id gz1-20020a05690c470100b00607a8bd0c24mr1872699ywb.29.1707926574554;
        Wed, 14 Feb 2024 08:02:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtkDPdtcxqnfAUjsGwNt2321LfeM1cYhU4rkFtACqH4U0RtsYmCDt3N7N+faKY5U8PWgXe+ty6qGzqdH98D1lExIQTYKrkaXzMbep0YWH7dkH2ec4nqQ6qoGuNE3g2/zDfvRRPWO1Bqw==
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z17-20020a81c211000000b0060420ceffb7sm2182425ywc.120.2024.02.14.08.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:02:54 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso1986934276.3;
        Wed, 14 Feb 2024 08:02:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWidbqZCEkt15WiLIaXs1GhniJOSD66ooNbzsV1qwTtXdfAx6XaRJjTSx1P24clSkDG0qhTBoh4CXHeQqoxgyQ/3bBU17c1cEvQ6t40hFwY0auM9yAnGXYAXfW9wtsELtjPqPS+ECMJcg==
X-Received: by 2002:a25:ac09:0:b0:dcc:54d0:85e2 with SMTP id
 w9-20020a25ac09000000b00dcc54d085e2mr2795393ybi.24.1707926574137; Wed, 14 Feb
 2024 08:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240214155438.155139-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:02:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUOS5eXgJtbkZe3crVp0R0OC6Bug2LJskT1pSgkkTaQtA@mail.gmail.com>
Message-ID: <CAMuHMdUOS5eXgJtbkZe3crVp0R0OC6Bug2LJskT1pSgkkTaQtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: auxdisplay: adjust example
 indentation and use generic node names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht <robin@protonic.nl>, 
	Paul Burton <paulburton@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ralf Schlatterbeck <rsc@runtux.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 4:54=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The example DTS should be indented with two or four (preferred) spaces,
> as mentioned in Writing Schema document.  While re-indenting, change the
> node names to somehow generic names, as expected by Devicetree
> specification.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Ralf Schlatterbeck <rsc@runtux.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> Changes in v2:
> 1. Previous, removing GPIO expander node is gone, update GPIO expander
>    example as well: node name and indentation.

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

