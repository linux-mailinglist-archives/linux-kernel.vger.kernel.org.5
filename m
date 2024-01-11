Return-Path: <linux-kernel+bounces-24104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65082B6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B961F257F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DF958227;
	Thu, 11 Jan 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQETrqDh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495E5820D;
	Thu, 11 Jan 2024 22:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFF0C43399;
	Thu, 11 Jan 2024 22:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705010619;
	bh=jN9g+MnTl+CuJ+/RvoYQJ0TAQWXECkq+Sx15c1NcM4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qQETrqDh5M/ns6SFVKQSqUS42/kaxrvLrN8y2KF4vmyBIt1pOK66I2YZUfAYK80P8
	 4Ri50DkUoL/qQqqxRtTxh//fxrXSmxd6IeORDZTRpD+5lOl30hO4EOa1CuXOdJkvQN
	 Uq195P7kItZ4h6nIyqPHGLxZeeXqeJ2JaIyouph2k3r5XEpWduk873MXI5NoTpcEnu
	 CJm4XunD/djKIX/nD2nOWLWQWO+OsS9Re8qxJq6b+dL8gwEgOylQ70EF4eIf0FmIO7
	 ixNZdO550n/YmEFVIUR9uMIXHi0KeodQGv+tmV2UhkgiM4KlpAk36iUBaSaKp1qMzG
	 cJ1WiUt/sMT8w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd5b467209so52432941fa.3;
        Thu, 11 Jan 2024 14:03:39 -0800 (PST)
X-Gm-Message-State: AOJu0YwOZI+pKy/8XYCpN0XHjHhQKZL0tobFaDe/TeeUQIVFhtzbDBgS
	TaAzzC/7tVv21dDuVVgq772QTuUv0CN3DTNDqg==
X-Google-Smtp-Source: AGHT+IGqQEJRlx5vqZKnSFNrc+k4aJn7Nwqxw+vCHtTG57ACO6acRmhTsCZusCpdLBlZG73fSAeQv2CiH9ue0nIZVs4=
X-Received: by 2002:a2e:9e97:0:b0:2cc:610d:ca6 with SMTP id
 f23-20020a2e9e97000000b002cc610d0ca6mr198479ljk.81.1705010617334; Thu, 11 Jan
 2024 14:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com> <20240109-axi-spi-engine-series-3-v1-2-e42c6a986580@baylibre.com>
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-2-e42c6a986580@baylibre.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Jan 2024 16:03:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPRwDbQDAg0nqb2VRT3K3qWPWhQo_jsu20f7RcgSgdsg@mail.gmail.com>
Message-ID: <CAL_JsqJPRwDbQDAg0nqb2VRT3K3qWPWhQo_jsu20f7RcgSgdsg@mail.gmail.com>
Subject: Re: [PATCH 02/13] scripts: dtc: checks: don't warn on SPI
 non-peripheral child nodes
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:51=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> According to the spi-controller.yaml bindings, SPI peripheral child
> nodes match the pattern "^.*@[0-9a-f]+$".
>
> A SPI controller binding may require a child object node that is not a
> peripheral. For example, the adi,axi-spi-engine binding requires an
> "offloads" child node that is not a peripheral but rather a part of the
> controller itself.
>
> By checking for '@' in the node name, we can avoids a warnings like:
>
>     Warning (spi_bus_reg): /example-0/spi@44a00000/offloads: missing or e=
mpty reg property
>
> for a binding like:
>
>     spi {
>         ...
>
>         offloads {
>             offload@0 {
>                 ...
>             };
>             ...
>         };
>
>         peripheral@0 {
>             ...
>         };
>     };
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  scripts/dtc/checks.c | 4 ++++
>  1 file changed, 4 insertions(+)

Check the commit history. We don't take changes to kernel's dtc copy.
They must go upstream first.

Rob

