Return-Path: <linux-kernel+bounces-27625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D539182F329
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0FA1F2366D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFA1CAB2;
	Tue, 16 Jan 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK03GT/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863051CA87;
	Tue, 16 Jan 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426105; cv=none; b=ditpHM5LsHCT2VU6l/HGJ4GyyAcDkuMLsgeg9P7XqCm+WDF06vXgpqYozK1oml5FEbklzfLcpo5e0J3NCeOQdwU3FmZImqEIPlJlnhIW4RE5ukz5WXxG9vLY/AKErDtaoflCZ5o1WXs+Mir2uL0JpvHvZOumdeI1RzkjtUat52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426105; c=relaxed/simple;
	bh=SWL5G0LjV0lpMDKzn8CRRXkd5G6+btg5P5k/L59uDfA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=u5ub+/4Odu1m8gIK0xzEGdXG/K2PcErK8U+KT/mKpbQMUFBKXmALHHBjULGAOKbfL+H/1eVpz1cazCGpGw8BS12P6dVQbK4KquRx2ZPGfLdsAD27h4PlpW5/2tu9KMgo9OtcSPkHMYw64Y5Ll9eL5mheWMuLTiZAHE67xeA4d7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK03GT/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC11C433C7;
	Tue, 16 Jan 2024 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705426105;
	bh=SWL5G0LjV0lpMDKzn8CRRXkd5G6+btg5P5k/L59uDfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK03GT/OWFBrC0LOzXAl0GPKkSUteJrIfgk0K26pApAeYiEdvicmRiMoJRcPFgEOm
	 8PMS9BXyWCPPw8O+xRkuhxr791c3Zfv6COgvZB9kk47L29n29wmU0jby6bujdpIVAD
	 FYju1PZUDmF+6IkhuUHtuabsGhJFf7LQISubDsA2zxUybB+tuIFyUk1B5GD3QAqVLT
	 9JF0VeVVQ4/795TS4UDz7o3gXRSw5H9k/VCJO/EWCH0EV4rRFyBhWn7Ko0TQf9HgQs
	 qhFTcHPS4RgExjtuKp047FvzgaTbAt4XjZbpDCnI61zJ2zQ3VHP49EfjRH4njaPYWx
	 WQzOv4ley8w9A==
Date: Tue, 16 Jan 2024 17:28:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Jeff LaBundy <jeff@labundy.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: iqs62x: Do not override firmware-name
 $ref
Message-ID: <20240116-porcupine-tibia-86a0b72beb5c@spud>
References: <20240115182042.1610134-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zK8bEK6C98ZCcMF7"
Content-Disposition: inline
In-Reply-To: <20240115182042.1610134-1-krzysztof.kozlowski@linaro.org>


--zK8bEK6C98ZCcMF7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--zK8bEK6C98ZCcMF7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa8tQAKCRB4tDGHoIJi
0sWEAQCF4cHfGy+VeTORaPLC2SPrznEUpRBL+2WPBHCTad5b0gD/dLG6mNx7TrjD
M15iQk/FX3T/SUpmWyHENjXbTbGVzwE=
=p+Bx
-----END PGP SIGNATURE-----

--zK8bEK6C98ZCcMF7--

