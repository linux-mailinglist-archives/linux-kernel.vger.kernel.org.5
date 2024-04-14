Return-Path: <linux-kernel+bounces-144219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC718A4349
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A102A1F21030
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203F134740;
	Sun, 14 Apr 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNdn/MJ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01136224CC;
	Sun, 14 Apr 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713107814; cv=none; b=lpWqSUFt6NFinw8TUTolewAOohFcdb8gRS4IVf/sJXfaArIOIR8uUW9CYQs5T5dC7YVFUD5Q3qKHmMsSvMBu8NGN68RNlVLeoFUzz+EOT7yD+PrO8smD+7SHwq+M8VTRK+AetsClRdyGFc7jORMHI/JKx4y+yJFZjRQ2wCz4quE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713107814; c=relaxed/simple;
	bh=dIaz9anlikHWba06YrDBAQby4aKTcYk2yTTCqB4q1Nk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q7zt4jVTKsf9ba9LEQLw9NU7hjmFjYeLdJSpkoHGkmNQoqDTyywfi+skkoShSPJG4sTy9s6Qc5m4mDe5S4820EdjBoKV3/ROFB9XU5p1wf8oMVkOTqjHNBIxNYfiRP4M5GlLgEPbRpLBSFJBzuxDOovDoENlLM2ClJz62au8IHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNdn/MJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F080C072AA;
	Sun, 14 Apr 2024 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713107813;
	bh=dIaz9anlikHWba06YrDBAQby4aKTcYk2yTTCqB4q1Nk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jNdn/MJ/5g0fj4Nfa+HSXBkxY9wV+cXd2plYkREfO5At+xfdwBQ8KD+08pFxIX9es
	 dIMbSEEG/UHDwYsD2Lsup+YmU100jFVlhYoeoCCkpU/LUwYg7D/PWV6nLJ11qQNH8g
	 QSPoc6nyRRCBfmAsltUdJAccGj8+56iRRZSxo4ZT899A67QbH+8sA0HK296o3OV8+f
	 zBh6wjHoAQyxUJq6ejX14RE+LugAito/ikjdYstKmUcOcSwaU6RaYwpydN71H9MpDj
	 BbHKUwjCZhWZm6x3MBQj1hsn0ZyCZ4y75UAgpWFY4193PeReC6c9PTQ7ntCLkdEUHy
	 NQGM++qWbK9DQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 18:16:49 +0300
Message-Id: <D0JY1B6C8LVF.3PD5CYKW5FNN7@kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Alexander
 Sverdlin" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: tpm: Add st,st33ktpm2xi2c
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Michael Haener" <michael.haener@siemens.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240414074440.23831-1-michael.haener@siemens.com>
 <20240414074440.23831-2-michael.haener@siemens.com>
In-Reply-To: <20240414074440.23831-2-michael.haener@siemens.com>

On Sun Apr 14, 2024 at 10:44 AM EEST, Michael Haener wrote:
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

I applied this version of the patch to my master (not yet mirrored
to linux-next but eventually will).

BR, Jarkko

