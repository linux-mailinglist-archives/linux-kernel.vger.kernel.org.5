Return-Path: <linux-kernel+bounces-119672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564B88CBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37ADF1C64BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC328527A;
	Tue, 26 Mar 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtFzhrlz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC71B59A;
	Tue, 26 Mar 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476889; cv=none; b=tjfGsvKLN+7pD8PHH1qhNDQZNPzYJMBkxvzI//ElVuxahvRKby/mfye6zxGbyy+f32JBmOWMdf3UCtFiXH2I5rt8pXmFuLzRGiw8z9A5LBmKuZ+jxkwN6sRQPyC55++D+Ens/nhkt8BoOIih6GBNOirZffcaB3QjfkG2uuZ3Nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476889; c=relaxed/simple;
	bh=X8a4b9n/2CO98Mv8FxoOR09KTzFb7RNSCqdYPkuQjlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ6iMSPrWsmPxCBDGDw0wH+ad9k+3G4ufSnz0Qcm2gDFJcSZ+runepIRh1d9A9orrXnv1kTkASttkQV75Nc07iERYOrcOnIxoFbIzG1hiTK3Kbhmv/eF/x+vYFdpQu9eHymqJGAxZVcjZvPAIE5EAuBtrIWSzNTM8B6X47e8snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtFzhrlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329CBC433F1;
	Tue, 26 Mar 2024 18:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711476888;
	bh=X8a4b9n/2CO98Mv8FxoOR09KTzFb7RNSCqdYPkuQjlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtFzhrlzdRk+KbzyPgQCs5I4W4erYn2OQ0+vm1Vns6/fI8/eQmT5v+ngLFszeU+20
	 NCR56RMTfme2yhNj1ECez8zXAUIRquZMWUfduQFVBIOrcbhTFvcc79HJX2odS5kKKa
	 6oHGT0yDxNWPtiyXV6afOr09jfRtZIV3NBNAgPCNIPv+PKDOoWkS6ril5pQ7T8Njpn
	 lxibVlEmWkk5FCFf4k5vEqFFh/nI8/YbZ/yXvfN6PIGe3Ojp2JAqPJd1R+lUDqptQK
	 9CZPrDa8oQqnslT/86I5T1Elzs8jINTJINqKt2SfqvQD5gI2rCnLv8Ms+x1PSUppWh
	 2n3VxGLUar2dw==
Date: Tue, 26 Mar 2024 18:14:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: ahci-da850: Convert to dtschema
Message-ID: <20240326-rerun-flap-6d827f654453@spud>
References: <20240326121735.11994-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gspvcYe74748VKy0"
Content-Disposition: inline
In-Reply-To: <20240326121735.11994-1-animeshagarwal28@gmail.com>


--gspvcYe74748VKy0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 05:47:28PM +0530, Animesh Agarwal wrote:

> -  - compatible: must be "ti,da850-ahci"
> -  - reg: physical base addresses and sizes of the two register regions
> -         used by the controller: the register map as defined by the
> -         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
> -         for enabling/disabling the SATA clock receiver

> +  reg:
> +    minItems: 2
> +    maxItems: 2


Could you make this an items list with a pair of text descriptions
please? The original text binding's text for each can be reused.

Thanks,
Conor.

--gspvcYe74748VKy0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMQlQAKCRB4tDGHoIJi
0kzNAQCvdiynFxfbTGd6T2pL7NC8T6GWa+FltXTVrKbv2NGymwEAlpLZIVPht5Vz
5LIo1R6BiwZyyomefIWp4I0UNjMHmA8=
=mmeI
-----END PGP SIGNATURE-----

--gspvcYe74748VKy0--

