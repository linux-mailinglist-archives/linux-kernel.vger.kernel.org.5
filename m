Return-Path: <linux-kernel+bounces-20435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D9E827EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22E9285805
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319838F4F;
	Tue,  9 Jan 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELqD70Qf"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3B6124;
	Tue,  9 Jan 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5eefd0da5c0so23561137b3.2;
        Mon, 08 Jan 2024 22:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704782729; x=1705387529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80w7kcr2BiF5GwXEFqXyPAg3AD4hnM9w5LfuY1QzR9g=;
        b=ELqD70QfcbgvZTe1mTHG4N9EDCIdciqe+gbOKJfNA88Iv/dEzM79X/Ppa5EsbDaxCk
         a2mO0hbPXPbDXKx+Y5jRaYm3llx/7B0r3pfr05VMYdkGmKjI/KqcOWx9eDvHXj0PlfM5
         BuLhNphVWvhwCHSqKVe1E9uL7Qkah5Jbz2QfPzqlp7UCKFuzFolC+8eNRfpXN7M9fb0H
         bAnJ4G8H3ELHNT0tbtBsAA6nxjOp6Kg64DZerCg4N+3WnX78isXpY3UDXhP0oxGViJuu
         zUmwTeA5YoyLbHnKjIPXh3T6RJdNEt5GspPfC1QjxGAAE8QTSqQqz8gGGpM01km5zFJH
         Q3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704782729; x=1705387529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80w7kcr2BiF5GwXEFqXyPAg3AD4hnM9w5LfuY1QzR9g=;
        b=JrAFkgFUJiTO9EyuKiazPlPpLVuRTiOFD0rO4EabkOVtx88jsC61KUnx+5oze+hxIf
         UFnhFbWknt+3zZb0T1504iQ65Ga/EIAhOb4TTr/6Hd+pGRlu8J5TeJQnpH4fx0BHl1Sv
         Rc7OI8trjCMrH8CXvE19JxUNTt987g+I26Y5PGPlHyR0aRD5PNWqyXvHCsgCuM1S8dYE
         aj8ZDvBeCYuJutb6Re9tAGxp+g4piAUgyHS5JqrMs9gBINmbT0IlO+M1q4CG9t1rUXyk
         ZH8n3APS6yLnj1i+kzjzssFvIfZCG7OxOmaZOAquIOC0+BBCS+HkhmLT1vY1G89kI5Xn
         mBpA==
X-Gm-Message-State: AOJu0YxuRiMUeNIs0V4nv5sQUSlznRJArg6ZPm6Gl+5YrdH8f4XsBZcr
	ewOJyDkQh3nFT1Pw2kW3x0fXDwMan0QwBjsN05w=
X-Google-Smtp-Source: AGHT+IF6yT0FJnKlKhXx/rXnY0cNXPiWZTwPKLF8DD+ZaBFDZq7+NnCGOMow8QTcirbtaj3I4WJ3pTtlcUMgnGyhs8o=
X-Received: by 2002:a05:6902:250c:b0:db5:3e3b:d2bb with SMTP id
 dt12-20020a056902250c00b00db53e3bd2bbmr2516111ybb.48.1704782728999; Mon, 08
 Jan 2024 22:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-2-tmaimon77@gmail.com>
 <170474817687.2140623.4004065884295248395.robh@kernel.org>
In-Reply-To: <170474817687.2140623.4004065884295248395.robh@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 9 Jan 2024 08:45:17 +0200
Message-ID: <CAP6Zq1iZdcrgc2BJREPvx8T9DZAZ=Sx_3iWbX0g=x2DmaG2MhQ@mail.gmail.com>
Subject: Re: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m
 clock property
To: Rob Herring <robh@kernel.org>
Cc: robh+dt@kernel.org, venture@google.com, linux-kernel@vger.kernel.org, 
	sboyd@kernel.org, tali.perry1@gmail.com, linux-clk@vger.kernel.org, 
	yuenn@google.com, mturquette@baylibre.com, openbmc@lists.ozlabs.org, 
	benjaminfair@google.com, krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for your comment.

On Mon, 8 Jan 2024 at 23:09, Rob Herring <robh@kernel.org> wrote:
>
>
> On Mon, 08 Jan 2024 15:54:14 +0200, Tomer Maimon wrote:
> > The NPCM8XX clock driver uses 25Mhz external clock, therefor adding
> > refclk property.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/clock/nuvoton,npcm845-clk.yaml      | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.example.dtb: clock-controller@f0801000: 'clocks' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.example.dtb: clock-controller@f0801000: 'clock-names' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240108135421.684263-2-tmaimon77@gmail.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

probably I missed adding the clock and clock-names to the example
node, will be fixed next version

