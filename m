Return-Path: <linux-kernel+bounces-14744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F382215F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98C71F2330F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486915AE6;
	Tue,  2 Jan 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6s9xs/z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389FA15AD2;
	Tue,  2 Jan 2024 18:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2EEC433C7;
	Tue,  2 Jan 2024 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704221442;
	bh=yOE/YHnF1UAW/Il+r+WmLQDz4UIfzONUe1nYkxnQURc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j6s9xs/zjOmU+d7T/tdZnQp5Cuk604kN70iRsyKMds+yoU3x1HHhgxT2KkyCURaIs
	 Qr96vgrsvnUD6MUf/xBw0mOtdpmunUgXPLEbW2vYLsQLyHGNgKJ6+HTkj7pGDuYHuy
	 AoyYp+6ZajXBej4Z5Qs5yFHhVZxcFDbUihHI/tcEEauBCRu+aM/h56KRfSA9QbcrrD
	 3vourfOaMgJrTThurFkxHnPZOueAUALkUtD324vEqHHot378Ad9pGGvZ7wrMq0a4Lp
	 a85yB4ounWrwYHONaIKsUgFnJtBBAhBm3QYGQ8UFKgehYCyVbioiEp8Sr3IN7JUHxu
	 rXaEYLgmj28lQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd10001532so10910161fa.0;
        Tue, 02 Jan 2024 10:50:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwZObPalzsZx70Y1/TfP0VASFtBh/tG8mUDhZNLin+NEtgPsoi/
	kE8nEYIP6pyBaJG04E6Z4xIgkszjIeLfXhnd4Q==
X-Google-Smtp-Source: AGHT+IEkg0lOcyuaw3VHV9V69o18PA2gIkrX3H8AL273tC0pEndlNYSNfmgExwmdDjXZq9K3LzSGyhgmBw4TShB3LPU=
X-Received: by 2002:a2e:4c0a:0:b0:2cc:a253:a4a4 with SMTP id
 z10-20020a2e4c0a000000b002cca253a4a4mr7816833lja.21.1704221440847; Tue, 02
 Jan 2024 10:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com> <20231207070700.4156557-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231207070700.4156557-9-claudiu.beznea.uj@bp.renesas.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 2 Jan 2024 11:50:27 -0700
X-Gmail-Original-Message-ID: <CAL_JsqK113msK_ZZopzF59LaOQJMCVbvXnJkfMpn6iT1tj_+JQ@mail.gmail.com>
Message-ID: <CAL_JsqK113msK_ZZopzF59LaOQJMCVbvXnJkfMpn6iT1tj_+JQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: net: renesas,etheravb: Document
 RZ/G3S support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:08=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document Ethernet RZ/G3S support. Ethernet IP is similar to the one
> available on RZ/G2L devices.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> Changes in v2:
> - collected tags
>
>
>  Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 1 +
>  1 file changed, 1 insertion(+)

Seems this one slipped thru the cracks.

Using this trick I just learned:

pw-bot: new

