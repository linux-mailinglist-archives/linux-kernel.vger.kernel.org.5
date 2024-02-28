Return-Path: <linux-kernel+bounces-85824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88586BBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65D3B213C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD376F04;
	Wed, 28 Feb 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOAj82Ry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6EB7291C;
	Wed, 28 Feb 2024 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161183; cv=none; b=m+qh8pmmCMMIdhWNnxKNvX1ewmApQFn1B8sTONernuAgv/a3DiTbAbGxl/OLAHel//qSE98Yw1mo7p8u+1JLxxJbIaF/+67DFCgE6KzenYmQkobimbRVPOTC2E+aRR+WPTXL+GoSYJUZEpGf8o6+Y1Xu4LKakZ4YongKNDWjABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161183; c=relaxed/simple;
	bh=qyALoYJ4e/xDXFwou2aAo1rZPwgMePJQ8UyFijx0rcE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=RdG5QxMn7Wc8IcywNk4vau683+lZsogGUavXz9JH57eoiEBCglvCZ3Hh49NwDmp1hsPSQqZs6CLLYvHIX2MAGkcYB8GgP96Bl2ek68uDhatdKcoIINMYg1Rt5eRjrFztEcyqXemj96oC4+dV9h4Froy+NQzug+WlLPjHKDncmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOAj82Ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C742C433F1;
	Wed, 28 Feb 2024 22:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709161182;
	bh=qyALoYJ4e/xDXFwou2aAo1rZPwgMePJQ8UyFijx0rcE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VOAj82RysJU1YtvCqndNJphH/ubZQADuXdO96RADGytgnXjlA+ueUjB3eQQM7rNvY
	 7D8Gv/t/60sQQb1T+CYzm8cYJQNlWLCHyEg06whSTkbNUPfTBJPBNXOGNWQnoSoIc1
	 n/2LULwb9QJLOuMROfxqNW6hnbB2yXZFOeiNrzDHavMqYue9Cq1OUF0oYcSfT3iAsl
	 I4QckxPVdUOxC9zYtqbXDHp5/R9nmtgxry3TvdrZ9Qcz6obcYBJh3QFjRPKkxMfCjH
	 aZ/TBvhMxj1ejolQHOMvHcRFkE+PZ19UrBOAFykL+2yeuDZP8zxeoQ/penk3oRJO08
	 Bvn7VXDKAEjAQ==
Message-ID: <2df72cc0d2be877c1f6eda8ebcf79508.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240224091236.10146-2-krzysztof.kozlowski@linaro.org>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org> <20240224091236.10146-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: clock: ti: remove unstable remark
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Date: Wed, 28 Feb 2024 14:59:40 -0800
User-Agent: alot/0.10

+Tony

Quoting Krzysztof Kozlowski (2024-02-24 01:12:35)
> Several TI SoC clock bindings were marked as work-in-progress / unstable
> between 2013-2016, for example in commit f60b1ea5ea7a ("CLK: TI: add
> support for gate clock").  It was enough of time to consider them stable
> and expect usual ABI rules.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

>  Documentation/devicetree/bindings/clock/ti/adpll.txt            | 2 --
>  Documentation/devicetree/bindings/clock/ti/apll.txt             | 2 --
>  Documentation/devicetree/bindings/clock/ti/autoidle.txt         | 2 --
>  Documentation/devicetree/bindings/clock/ti/clockdomain.txt      | 2 --
>  Documentation/devicetree/bindings/clock/ti/composite.txt        | 2 --
>  Documentation/devicetree/bindings/clock/ti/divider.txt          | 2 --
>  Documentation/devicetree/bindings/clock/ti/dpll.txt             | 2 --
>  Documentation/devicetree/bindings/clock/ti/fapll.txt            | 2 --
>  .../devicetree/bindings/clock/ti/fixed-factor-clock.txt         | 2 --
>  Documentation/devicetree/bindings/clock/ti/gate.txt             | 2 --
>  Documentation/devicetree/bindings/clock/ti/interface.txt        | 2 --
>  Documentation/devicetree/bindings/clock/ti/mux.txt              | 2 --
>  12 files changed, 24 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/ti/adpll.txt b/Docum=
entation/devicetree/bindings/clock/ti/adpll.txt
> index 4c8a2ce2cd70..3122360adcf3 100644
> --- a/Documentation/devicetree/bindings/clock/ti/adpll.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/adpll.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments ADPLL clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1]. It assumes a
>  register-mapped ADPLL with two to three selectable input clocks
>  and three to four children.
> diff --git a/Documentation/devicetree/bindings/clock/ti/apll.txt b/Docume=
ntation/devicetree/bindings/clock/ti/apll.txt
> index ade4dd4c30f0..bbd505c1199d 100644
> --- a/Documentation/devicetree/bindings/clock/ti/apll.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/apll.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments APLL clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1].  It assumes a
>  register-mapped APLL with usually two selectable input clocks
>  (reference clock and bypass clock), with analog phase locked
> diff --git a/Documentation/devicetree/bindings/clock/ti/autoidle.txt b/Do=
cumentation/devicetree/bindings/clock/ti/autoidle.txt
> index 7c735dde9fe9..05645a10a9e3 100644
> --- a/Documentation/devicetree/bindings/clock/ti/autoidle.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/autoidle.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments autoidle clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1]. It assumes a register map=
ped
>  clock which can be put to idle automatically by hardware based on the us=
age
>  and a configuration bit setting. Autoidle clock is never an individual
> diff --git a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt b=
/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> index 9c6199249ce5..edf0b5d42768 100644
> --- a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments clockdomain.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1] in consumer role.
>  Every clock on TI SoC belongs to one clockdomain, but software
>  only needs this information for specific clocks which require
> diff --git a/Documentation/devicetree/bindings/clock/ti/composite.txt b/D=
ocumentation/devicetree/bindings/clock/ti/composite.txt
> index 33ac7c9ad053..6f7e1331b546 100644
> --- a/Documentation/devicetree/bindings/clock/ti/composite.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/composite.txt
> @@ -1,7 +1,5 @@
>  Binding for TI composite clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1]. It assumes a
>  register-mapped composite clock with multiple different sub-types;
> =20
> diff --git a/Documentation/devicetree/bindings/clock/ti/divider.txt b/Doc=
umentation/devicetree/bindings/clock/ti/divider.txt
> index 9b13b32974f9..4d7c76f0b356 100644
> --- a/Documentation/devicetree/bindings/clock/ti/divider.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/divider.txt
> @@ -1,7 +1,5 @@
>  Binding for TI divider clock
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1].  It assumes a
>  register-mapped adjustable clock rate divider that does not gate and has
>  only one input clock or parent.  By default the value programmed into
> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Docume=
ntation/devicetree/bindings/clock/ti/dpll.txt
> index 37a7cb6ad07d..14a1b72c2e71 100644
> --- a/Documentation/devicetree/bindings/clock/ti/dpll.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments DPLL clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1].  It assumes a
>  register-mapped DPLL with usually two selectable input clocks
>  (reference clock and bypass clock), with digital phase locked
> diff --git a/Documentation/devicetree/bindings/clock/ti/fapll.txt b/Docum=
entation/devicetree/bindings/clock/ti/fapll.txt
> index c19b3f253b8c..88986ef39ddd 100644
> --- a/Documentation/devicetree/bindings/clock/ti/fapll.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/fapll.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments FAPLL clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1]. It assumes a
>  register-mapped FAPLL with usually two selectable input clocks
>  (reference clock and bypass clock), and one or more child
> diff --git a/Documentation/devicetree/bindings/clock/ti/fixed-factor-cloc=
k.txt b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
> index 518e3c142276..dc69477b6e98 100644
> --- a/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
> @@ -1,7 +1,5 @@
>  Binding for TI fixed factor rate clock sources.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1], and also uses the autoidle
>  support from TI autoidle clock [2].
> =20
> diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Docume=
ntation/devicetree/bindings/clock/ti/gate.txt
> index 4982615c01b9..a8e0335b006a 100644
> --- a/Documentation/devicetree/bindings/clock/ti/gate.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments gate clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1]. This clock is
>  quite much similar to the basic gate-clock [2], however,
>  it supports a number of additional features. If no register
> diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/D=
ocumentation/devicetree/bindings/clock/ti/interface.txt
> index d3eb5ca92a7f..85fb1f2d2d28 100644
> --- a/Documentation/devicetree/bindings/clock/ti/interface.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
> @@ -1,7 +1,5 @@
>  Binding for Texas Instruments interface clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1]. This clock is
>  quite much similar to the basic gate-clock [2], however,
>  it supports a number of additional features, including
> diff --git a/Documentation/devicetree/bindings/clock/ti/mux.txt b/Documen=
tation/devicetree/bindings/clock/ti/mux.txt
> index b33f641f1043..cd56d3c1c09f 100644
> --- a/Documentation/devicetree/bindings/clock/ti/mux.txt
> +++ b/Documentation/devicetree/bindings/clock/ti/mux.txt
> @@ -1,7 +1,5 @@
>  Binding for TI mux clock.
> =20
> -Binding status: Unstable - ABI compatibility may be broken in the future
> -
>  This binding uses the common clock binding[1].  It assumes a
>  register-mapped multiplexer with multiple input clock signals or
>  parents, one of which can be selected as output.  This clock does not
> --=20
> 2.34.1
>

