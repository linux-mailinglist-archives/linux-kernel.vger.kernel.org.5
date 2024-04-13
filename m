Return-Path: <linux-kernel+bounces-143897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CEE8A3EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768DA1F2156F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1355647E;
	Sat, 13 Apr 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2iw8YLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99654FB7;
	Sat, 13 Apr 2024 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044863; cv=none; b=RBsBumOYK4NThayw2sdx2sf8kSm6QZw9T7MLW0z+RYR9Z9Cr/frt3vdhiShocPp0szVCnp9//uzalQMxhqIfHteadPKW1Pt7wg4lyhJycZ8tPxLbT6e82SQDvk630ScgrFZ/qHC8Flx++3PciK/DycMKFw502b336XFQB+3B25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044863; c=relaxed/simple;
	bh=HoN4sE3Oc8h1Wqf6bCXprmqJ8T88uZabTn6c7e7WTwA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZYZ5NmDmPsGFmNA8J1qs6lXJsnOmvtf1Vt12yaF8EEL4ghyqTLxXBAdnX0RzK4LmXSKwUKwVKHgjRc7NS95yLkFQdGxkPzzvn+PuvydvfAXRwejWUdflYjfv3Z5ZEkaBGJPjTrDc2AtnY2chD/4p/3Ml/vvDB43QmUbC9L36no4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2iw8YLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2825C113CD;
	Sat, 13 Apr 2024 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044863;
	bh=HoN4sE3Oc8h1Wqf6bCXprmqJ8T88uZabTn6c7e7WTwA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=E2iw8YLt3xa6oL/dwk8PVB8KGM+qhhNNgVf80XQpryfqE/QtV67dw5E8izSz4KQ96
	 K83/si4CVhwoInR8Ij1iNLrRkS59KPOUxg/FXQyLcXlcCnJzTimz52fBC2bc7ttSfZ
	 waKWGwnorVauk6n6ywubdwS4//9aGUavZeMn59+APulQWgzHUgVECeuQJjIoNrkZ1M
	 Q+KJg/qfPHOUrVRNO/4LTYD65hC+7JxSdnN5/h1wYod6gWjq/r9H06aAiXEfWh82Dn
	 qr4IfvDO8pRT13Wt7cj2dgdzFexERQm16EkEgrcRpr5sR24gd/6hUj6Bm/iHtC3cFZ
	 p1+99YBtrgx3g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:47:39 +0300
Message-Id: <D0JBQ0A9FXUS.NH8RBK4KXXX8@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Alexander
 Sverdlin" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "M. Haener" <michael.haener@siemens.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
In-Reply-To: <20240413071621.12509-3-michael.haener@siemens.com>

On Sat Apr 13, 2024 at 10:15 AM EEST, M. Haener wrote:
> From: Michael Haener <michael.haener@siemens.com>
>
> Add the ST chip st33ktpm2xi2c to the supported compatible strings of the
> TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
> Profile specification.
>
> For reference, a datasheet is available at:
> https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf
>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> ---
>  Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b=
/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> index 3ab4434b7352..af7720dc4a12 100644
> --- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> @@ -32,6 +32,7 @@ properties:
>            - enum:
>                - infineon,slb9673
>                - nuvoton,npct75x
> +              - st,st33ktpm2xi2c
>            - const: tcg,tpm-tis-i2c
> =20
>        - description: TPM 1.2 and 2.0 chips with vendor-specific I=C2=B2C=
 interface

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'm ready to pick these unless Rob has anything to complain (hold
to next week).

BR, Jarkko

