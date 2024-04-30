Return-Path: <linux-kernel+bounces-163174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F2E8B66C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FA4281986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8964D;
	Tue, 30 Apr 2024 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJOftMy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6156623;
	Tue, 30 Apr 2024 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435895; cv=none; b=d5fEZhq9V4v8RxyIPgofMMhpBkBsQAV2t1GeYimZlsLE1YXiJkQtVa4uFsNoGh6JdHD/LhQlDSxnMSKEr2UgPS2jhuy0/DcjyeADgsflydpAKciqls2XTogbRqt1CJe7l4tz4zF0jUaS6SKWriuNky+pqjcxZKGLhYKqaBhjIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435895; c=relaxed/simple;
	bh=7aen4RxW6Cxx8Y89Zw/1tNmoZDOjWvi37qKkCmZ9BjQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mswUoeSl4zNgk3DnfbVzufPclqvBrABvOiyjq+hdVVCSyIeVmVxNrmBJIbfA7zqFu9hsVVqEjw/ay4TukOtfR+mwOYOATqDTRh0CYXvgUkHdvLbNCwwWz9pZFqqWhzW7F+BWNyOth12CbJUSOvaFgRNSnEEWtFcnueU/vQUXf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJOftMy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10988C113CD;
	Tue, 30 Apr 2024 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714435895;
	bh=7aen4RxW6Cxx8Y89Zw/1tNmoZDOjWvi37qKkCmZ9BjQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EJOftMy98yQDvSXuEh873SDomx9OIZ8kgxRqD1ms7lqqNq2HJrvKuRoO0muDgi7gv
	 XG46xTZ6RwVz5vn3nRvcS/ygY4C5U0o/FZgpMo/pRRwRQznzMYPEYtgOZ410p2I9TF
	 vKvs0zNFHJ3yekZE3zaw2uc7Rez7H8IKmPDqZcowtM/3mx9QzYF42LdwmLyRQJwKig
	 rE16XxkkhZrPnNDDUsJikUTctnwqsTiFMv0vRLA6Z+xRa7FObaz+FjXSS/kj4ENojV
	 tuRK4sCOVd0FtK+sXMwmYCYkvd+Ay31Acpqoh6fxDDn+CMR/As3lfTvdYxaf7i8tLs
	 X5ozUolEKSpxw==
Message-ID: <9e1195f05f4eced0a158c49616deba6a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240425183810.3079069-1-robh@kernel.org>
References: <20240425183810.3079069-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: fixed: Define a preferred node name
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Mon, 29 Apr 2024 17:11:32 -0700
User-Agent: alot/0.10

Quoting Rob Herring (Arm) (2024-04-25 11:38:09)
> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/D=
ocumentation/devicetree/bindings/clock/fixed-clock.yaml
> index b0a4fb8256e2..d287bd092054 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> @@ -11,6 +11,13 @@ maintainers:
>    - Stephen Boyd <sboyd@kernel.org>
> =20
>  properties:
> +  $nodename:
> +    anyOf:
> +      - description: Preferred name is 'clock-<freq>'

Is the preferred value of <freq> the clock-frequency property? Should
say that explicitly somehow so that it's clear.

> +        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
> +      - description: Any name allowed
> +        deprecated: true
> +
>    compatible:
>      const: fixed-clock
> =20
> diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.y=
aml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> index 8f71ab300470..962a1fe85416 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> @@ -11,6 +11,14 @@ maintainers:
>    - Stephen Boyd <sboyd@kernel.org>
> =20
>  properties:
> +  $nodename:
> +    anyOf:
> +      - description:
> +          Preferred name is 'clock-<freq>' if the input frequency is fix=
ed

Similar question here. Is <freq> supposed to be the output clock frequency?

> +        pattern: "^clock-([0-9]+|[0-9a-z-]+)$"
> +      - description: Any name allowed
> +        deprecated: true

I hope that deprecating this doesn't cause folks to try to clean things
up and then break code that's depending on the node name to be the name
of the clk. We don't want that string name to be important but it is
sometimes.

