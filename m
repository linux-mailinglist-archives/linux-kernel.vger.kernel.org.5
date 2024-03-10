Return-Path: <linux-kernel+bounces-98361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27437877925
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C456CB20CAD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C23BBCC;
	Sun, 10 Mar 2024 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KooS23Bt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300B2D79D;
	Sun, 10 Mar 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710112090; cv=none; b=T/fcwDlZNTBnqu5TzP9GW8kd5rfH4M6asReaSSXVVWMyDvn8D27w4y+qO4d/XRu9gBq+Uk3H+aAMSLzUnM1jy04uBj6zpr/yEb2AA1i4Wd162lHzCPrpy0M+xUqx6TfZjAYkpTxI2RZ0pIPvj3bMQigh5MNHzqmefTUoqFWs6UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710112090; c=relaxed/simple;
	bh=d05Fp+Mo/IaC9ODFAJs9AlyX2mCgDDPAW1Bffk8Q1ew=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=B9jPrL+sOU1Y0T4gQRV6KqE+E00Rnz4J4ziuN6QzjlB/nohyza/YzBq+oqKJFQaJeStQFjpwLzU1pqx+oXMKevrbvjz4YyisSkj9CCOGTNLvi84aA+5CrvsJeqVqmToCyzSO6sFJRZXnuuRRjIJafS5Oq/WRQrbh2tBk9uXD2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KooS23Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48689C433C7;
	Sun, 10 Mar 2024 23:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710112089;
	bh=d05Fp+Mo/IaC9ODFAJs9AlyX2mCgDDPAW1Bffk8Q1ew=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KooS23BtfwsQkI+LoKt/DY+PM6e4ICbv06YlI/qpQAWVPkTzfyveU6fSwrqdexrSS
	 XhGr8SjauYU123WRnmfFMDjSQ8GD/6y7slMsNjadRi7wnlKVRw3GuVLj4VJpDvbHuk
	 d6sT7oRI9MRzSZRbeYYntTuOnjb18o57wUTsPooaXQanuS8nbGQImWSWYpLwFEl+nv
	 XSaNvajsBbqdyD/ba5qp6NjSpIYtPpFhxUW+9+Olz/HYUOphVEsnSgBsX31EE3QGph
	 2BA+LWrxi1H8S4P3oZ6zr8tbHSCy6Jb+LvuqQLI+5ebWVSG1flF7UkLBf/vVwGvWbx
	 acqRDnsJhf9iw==
Date: Sun, 10 Mar 2024 17:08:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com>
Message-Id: <171011208646.4168843.11425236211455218194.robh@kernel.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe
 LED usage


On Sun, 10 Mar 2024 01:51:58 -0300, Luiz Angelo Daros de Luca wrote:
> Each port can have up to 4 LEDs (3 for current rtl8365mb devices). The
> LED reg property will indicate its LED group.
> 
> An example of LED usage was included in an existing switch example.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  .../devicetree/bindings/net/dsa/realtek.yaml       | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/net/dsa/realtek.yaml:121:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/net/dsa/realtek.yaml:131:23: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240310-realtek-led-v1-1-4d9813ce938e@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


