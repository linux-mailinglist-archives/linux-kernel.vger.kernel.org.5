Return-Path: <linux-kernel+bounces-143899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073218A3EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8055FB216A0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E615676C;
	Sat, 13 Apr 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUpMFn2B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797356446;
	Sat, 13 Apr 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044990; cv=none; b=Wm1SbA5zS+M81fkTwCJiydYrht99SzCC5WGUbhw0Teq7XDCLBe3XFsp8i2/nUWjbVcLEByHOHn4qo9d3O3ksY6nkCqVuOLstFLHpULGxqQZ6/6byTtDHg3lE76LfC2Z106kp+HyeXFJRLlLf9oPbiAK2lYqYzfjoGCvFsT61V1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044990; c=relaxed/simple;
	bh=iEa00FLkPKOyueCNVfXTexNmnUkcPMuYdqHHduuBgyg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ntZtrqkJj09lK1NN2IyuEZnAknZFJyk1kiMhqo+kqf21rJk6jMNlyMCAygYXY5gS2fveKiKCfpFn4tvLs7JF9f5QRJxdmZuVus4+4NCm1DMp9Gt1ibAN5K9xIA97eVwSynCxOhGsZ0HQprM/mTbeT/dt1NsoCU1I3KJNsAQqnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUpMFn2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C68DC113CD;
	Sat, 13 Apr 2024 21:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044989;
	bh=iEa00FLkPKOyueCNVfXTexNmnUkcPMuYdqHHduuBgyg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jUpMFn2B2Jh0YoqQrXDaYclFiWyKe8Xjo2Wk5jVaW/oRZEJSH0pxYrVPZ4haex24k
	 IsvE1pwMCFV+RZkmzVtRT/69NVYGThVPqOPxYq86C1ueAGF34O6iAuVEQ6FAKasUL6
	 KusdEKp9NDcqG9P2+hUy46zHTgTo2FFyAjJCVZidQdpf6PdyzaDW4r0QP/boIi73O2
	 AODvcV25CnccyWtrt9Ej6bAj8184JIIy0ytC4STrbd2aXx9kndLxZlwV/VU+LeZwqb
	 25vuk50vRID6TuBJfi4GEasLYtQNJngwJ69gjYOFzMuo/qBnN8KbzvwnBuRP4alio4
	 KVIDZA/C3/9Bw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:49:45 +0300
Message-Id: <D0JBRMERS3G8.NJPPGQQU1E8R@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Alexander
 Sverdlin" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "M. Haener"
 <michael.haener@siemens.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
In-Reply-To: <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>

On Sat Apr 13, 2024 at 11:10 AM EEST, Krzysztof Kozlowski wrote:
> On 13/04/2024 09:15, M. Haener wrote:
> > From: Michael Haener <michael.haener@siemens.com>
> >=20
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>
> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L18
>
>
> >  Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml=
 b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> > index 3ab4434b7352..af7720dc4a12 100644
> > --- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> > +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
> > @@ -32,6 +32,7 @@ properties:
> >            - enum:
> >                - infineon,slb9673
> >                - nuvoton,npct75x
> > +              - st,st33ktpm2xi2c
>
> I got only one patch, but if these are compatible, why do you need
> second patch? Plus binding come before users.
>
> Please explain what are you doing in other patch.
>
> Best regards,
> Krzysztof

Thanks, I agree with the remarks. So holding for update.

BR, Jarkko

