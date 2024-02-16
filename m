Return-Path: <linux-kernel+bounces-68704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA062857EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76098B24760
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D712EBFB;
	Fri, 16 Feb 2024 14:05:08 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAD12E1FB;
	Fri, 16 Feb 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092307; cv=none; b=U/QKWZfudAqW3xFjt/DBWRIcMbJ6VXj7CvvMqTVEX+sl4YxlipJvG9vlRrOzBmq6MAbRdZ3Fq8R3z1AE4HDAekXiEzGV4j4OTbRgiEKBtoB5cRc8GtGLzg3s+nrV13aONdWKV8E0JfJwNfQ/OF/ZxgU6ODEd8oVjkZJ7CmPCLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092307; c=relaxed/simple;
	bh=QZXZX2IoWGNDy7kmcmAiaCDX9jMXDdWmkZ9Kx1tLQO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy7KkWLzNOeJutWXdceI4ZRBavY9Tlo03b9keI3SAQu8Y1D3Ig3aAQ4lCvp3PLvwQPVHguKafQzkMumQg3VHxR8DPenw4EXXeVK6Fptsl4h1tshXeDFLrU0zMYNM6iiqh86HHciI6VtMTi+rMMbkgaesYLpiUd0E/a2zOYoMEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607fc3e69adso6253357b3.0;
        Fri, 16 Feb 2024 06:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092304; x=1708697104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssDcYGlo0XYIPkaIe9oJbg8yYcN5gJ/6X+ClgyE2yKE=;
        b=MklT8zJCPr9HWHNrXrPSi3LSI298iu9F/IgFdPs5Qd7jbp6RQdmNfl+nq/IFFjH4ol
         Xg8WKzrWwgeB4pDXoFbxthtd7wuIjvMF2+Nw9PMprt+8YOiIPjmjNPUhMLzeemFaXCVU
         D2nWSSTpk05KM6iAiu2PQ0EZrFDbRIBzduWKXsv4hlYKu+VSCBRL2o5PH131imxVq2US
         qG4u8kPZHJQ51g50phLMGiKKp2eriMfLpTB4Budc3B8JoIliDNyZ0do7aOmBsq/fSw9D
         yfL8Fdz4/wKUpuSAcSfvbwMMVHxyXfBtobQVRbpA2zKABj27LcVfIk8tiNKms2nVYW3W
         TRDw==
X-Forwarded-Encrypted: i=1; AJvYcCW2yXUGvT8ZUWdUG466HHmD1fAjUIXMbLxmymA7OQLjw/bf+1Lf8zuYJsjPWckTNXe/YpyJCpdBXJBYPZpdPq+kpy2Bh+90Uc+uvtt9H2dJVm5vkzXZqyVKQ8M1VVFo55v2X+W+pclQu9poqk8ICg8S/QN/NUa4j8Vo88i4HZ6PSlFQ6Ogu1ioG0t2lJ+weZc4gbEk16FHXFoRoO+SG+MndeXW57SXL
X-Gm-Message-State: AOJu0YxGGZ+0HVpVWFhoEO33fvRWfmxSGI8Erk7mw05F9wp+nJX2bZta
	sPmveRc3Je4mY57Ogz03rbSAqKKTeKQMvoGKUPrJ3V4fk8QiZHoLyl7ZrbswGA8=
X-Google-Smtp-Source: AGHT+IGkvWkUSPgZyYUvxAEQQJfdydoi7Q0iPKDpUVwAA1grbOfQyQQWVBV1tBnTizRVlDHcrSfkBw==
X-Received: by 2002:a0d:e8c7:0:b0:604:3f64:48e1 with SMTP id r190-20020a0de8c7000000b006043f6448e1mr5462798ywe.5.1708092304430;
        Fri, 16 Feb 2024 06:05:04 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c2-20020a0df302000000b006046bd562a5sm348965ywf.128.2024.02.16.06.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:05:04 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso2174811276.3;
        Fri, 16 Feb 2024 06:05:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJ3hNqBqctAjgCA8ureXlIFqpb2gcuGE+5ntQB1ylGWYYX3cSCLLXERFPw3RmqsAo4N3Ro6NnZS9BQrFC1XejilUEfGVJNeraq04So3XjnogxCn6fU+ZGM5OiD65Kj0bm5TG5E/c6EBs/SybjKXMcFAnD0erXSnpw20kNOZEq5tWJwUYIs/xMq5sziKJVT++PlJL5B7rqWQWRIYm8nojJmp1SnaQ6G
X-Received: by 2002:a25:b78d:0:b0:dc6:c510:df6b with SMTP id
 n13-20020a25b78d000000b00dc6c510df6bmr5663068ybh.55.1708092304106; Fri, 16
 Feb 2024 06:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:04:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW2AsXJk_crdeiMjMHzBKq91UO1d=ukwjW0hkCK4DRvTw@mail.gmail.com>
Message-ID: <CAMuHMdW2AsXJk_crdeiMjMHzBKq91UO1d=ukwjW0hkCK4DRvTw@mail.gmail.com>
Subject: Re: [PATCH 06/17] dt-bindings: clock: renesas,rzg2l-cpg: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:43=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The driver will be modified (in the next commits) to be able to specify
> individual power domain ID for each IP. Update the documentation to cope
> with this.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> @@ -57,7 +57,7 @@ properties:
>        can be power-managed through Module Standby should refer to the CP=
G device
>        node in their "power-domains" property, as documented by the gener=
ic PM
>        Domain bindings in Documentation/devicetree/bindings/power/power-d=
omain.yaml.
> -    const: 0
> +    const: 1

While the driver will soon support both 0 and 1, we may need to keep 0
for RZ/V2M for now?  RZ/V2M does not have CPG_BUS_*_MSTOP registers,
but uses the Internal Power Domain Controller (PMC).

Please add a link to the power domain numbers in
<dt-bindings/clock/r9a0*-cpg.h>,
like is done for #clock-cells.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

