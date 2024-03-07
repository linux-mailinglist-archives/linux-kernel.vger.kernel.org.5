Return-Path: <linux-kernel+bounces-95576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAFB874FAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B25B2454A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B5A12C52F;
	Thu,  7 Mar 2024 13:11:25 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46C126F3E;
	Thu,  7 Mar 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817085; cv=none; b=QttK+3ly0IZSsCMOGoh787QH1qMCbihmBmUIZsi7Q0nJK7wrIuCYCcqkWzmU5aeIrbU9O4et6xHjtqW76Qk8FBWhpDTMM31GoYgs7GKyzxZeqbEmUTw54AR42FoTs6JTluY8UC8h2W7uOJfW+TI5lzB21Or6pFiINuf/8abykUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817085; c=relaxed/simple;
	bh=HOxpvt7l8aPbyL2UOZkbnFo+Qz9jpgrQVXtzDIzvAbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVSkwlc/e3NvZW3jj9+s6kp3Qiur2VcQZL0WiwCW0dv3KjvDS4FYPeQvrTvl52wFeNQ/Nq1Ngf0tEFbt1mNC1Br/S8qo1+h4lT0pVztS7Qw8ttzsNqUtIcQAlxuBCM4TghnK1l4YKR536jRl/ZivwrKSSPsfWEmtNvVEVx4Xjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6098ba9959aso9516207b3.2;
        Thu, 07 Mar 2024 05:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817081; x=1710421881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFlIwmRcKHBKOHIwaW1+o7J6TMDsEFn7JOOeCHjQR5M=;
        b=LpKYt4exlgqmxX+iezAFkkmVZqTpxhVKEDgFqtSECLiXAkEWTKGNq1kXm5e4Um6xvq
         PmdH1mvuYdZxpa0LQPag337tT1UWfbJRSP2N9y/44XIqKeDwjcfInAsCWKJ3TXmLU6tg
         RpEl+oUlud3LSo0048Z+Fxy9SFk32uGUwvaYfLTW47UlzmfL98YLLgR7dYHbDEYn2sHI
         qc0B4x5my4n5HIEx/X4h9zd3g44+NuOinMruBT4vmgyThYx6q6QFGfro3G3pkhF5nWZy
         ojZTfTPMogNrlysa1zZNNhPWlIPg1UuaeKdvRAnDlSJ5eswo14oTu23dbsQf73bWpW3t
         /COw==
X-Forwarded-Encrypted: i=1; AJvYcCXHP+ERSGLvjQwNPRfKVO/I1DOMXFVy+6lvnsP2NwfRrxDmOH5a1P6RZsCKl1bwh9NN9tVHAt5TL37O3Th4bJRlhHCNtuDaELdALugzXrrL/R60s93QYYOuS/j3dEkKxdiG3vlHpIrWW9xZ/5ulULB2aTRS9pZG1e6EVzVElFqkd51xTfc=
X-Gm-Message-State: AOJu0Ywu2h5eYoZq2dQ97fHcXMCXt0AZBFKn0dAWqhUdW+Na3FFLUF1p
	zYKOnfJVQjl6P9h4cBzK6bmFKKKpjrMBOKGu9lwejnp8ERRCounS8zpz59mU94s=
X-Google-Smtp-Source: AGHT+IENq1W1Tsq5tzd1JMW4YhwC8j2HptzbasFI6FjLhaa5YfCQ79TvaJQDgqUPL9BzwWe+MQha5Q==
X-Received: by 2002:a0d:ea51:0:b0:609:c56d:ed37 with SMTP id t78-20020a0dea51000000b00609c56ded37mr8814642ywe.3.1709817080818;
        Thu, 07 Mar 2024 05:11:20 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id t9-20020a81ce09000000b00608d55efe59sm4229270ywi.112.2024.03.07.05.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:11:20 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f4155b76so4102407b3.1;
        Thu, 07 Mar 2024 05:11:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxdKuPHHtw7bKeRc/K9xnvkeXhRD2nA8wsGg2hdqrkYqijztNrhvt+JoRPjsNiZyt5o24yw3M5fNqLEd++9XvsFUEHj3jW0xDjZnXf4BMlLPXwMaIdOYd04vm/3e05llFgP23SxtrjjBX/9v61aFqm/Ob3yGbWSm2stXoHPD2FzgXPbek=
X-Received: by 2002:a25:2e0b:0:b0:dd0:7a4:12c with SMTP id u11-20020a252e0b000000b00dd007a4012cmr14336879ybu.59.1709817079721;
 Thu, 07 Mar 2024 05:11:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz> <20240306235021.976083-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240306235021.976083-3-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Mar 2024 14:11:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXZ0mV4eqoPxsSBZVw7MJq_AP4GdmZpMNix+Yq2VAa1aw@mail.gmail.com>
Message-ID: <CAMuHMdXZ0mV4eqoPxsSBZVw7MJq_AP4GdmZpMNix+Yq2VAa1aw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: auxdisplay: Add bindings for generic
 7-segment LED
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, lee@kernel.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:51=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Add bindings for a generic 7-segment LED display using GPIOs.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v5:
>     - Preserve formatting, maxItems set to 8, group GPIO specifiers
>       as suggested by Geert

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

