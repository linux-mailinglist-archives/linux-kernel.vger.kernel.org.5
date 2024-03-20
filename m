Return-Path: <linux-kernel+bounces-109199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E319C88160D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D111C213E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EFC320B;
	Wed, 20 Mar 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcN1K07l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2A69DF5;
	Wed, 20 Mar 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954256; cv=none; b=AjmzpzEtEBymLMRXqbaOviui/Dh9HSGlollalFNN8N1wo3kwo++SqS8xLJqp/0V0dqonOYcS4glQli2E5NfQQALBv0z34LZvi8Ht5KhaRLLmNApRsSRIEDHt/Pjir4/J6UHKucs3YMpPp7AJzpRUvJwtP78oYiTGKWrBW8ISnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954256; c=relaxed/simple;
	bh=RqtX2Uov+cVDeo5FJe6SPhnsqgRm92ErkCH5C8fMcuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCIhaOPL+HBZX6tGrZJKcexWux9S0lFma8uYQLC96maMZcI8m8w6FukfxodOIlw0f77UzzMhHn63VWfoCfJmfkN/+nYOntBCBjEaXhJSCYQmzovm3L1/poFUfHncE/Gquzoi3d2p3KFgJ6pIoCID2pKq6wKWHy4eMJ6lTa2jRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcN1K07l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F0C433F1;
	Wed, 20 Mar 2024 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954255;
	bh=RqtX2Uov+cVDeo5FJe6SPhnsqgRm92ErkCH5C8fMcuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcN1K07lbqcuv6SxlRFaF/r/FCyZyF7dah5XfZkbxZfdOA2G47QaZJ0wOEbL7dSbM
	 +Ykvc7JYMR+UyGv0POXIjBvkrP+R169BgiLcvaQed6P9ENG7t3CqWUS9+6WCb6wifY
	 jv5h765Itu8ALejabNMoAf4rpe4obDKyLcFnDeJXPq2L/Z8xk13W/QSiReWr42vVwp
	 R7n0/9WfUAtKwWbjh1iGB5Am3FDqt6yGoHhQVMxE5kOx+rZAIyMHiZXDQBUPPyw3Y+
	 MZKtQhn5lf44MMnjEi9/YsOhF5FA5ZCe1LWwAWIu6NEKV1+ch0ASjKChggnixYm6wM
	 Yq6XbYdWisHEA==
Date: Wed, 20 Mar 2024 17:04:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: samsung,exynos5-dp: convert to
 DT Schema
Message-ID: <20240320-reanalyze-koala-4c086a24fee0@spud>
References: <20240313182855.14140-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nMjoPdMruxxpI5xO"
Content-Disposition: inline
In-Reply-To: <20240313182855.14140-1-krzysztof.kozlowski@linaro.org>


--nMjoPdMruxxpI5xO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 13, 2024 at 07:28:55PM +0100, Krzysztof Kozlowski wrote:

> +  clock-names:
> +    items:
> +      - const: dp

> +  phy-names:
> +    items:
> +      - const: dp

The items lists here are redundant when you only have a single item, no?
Isnt it just
phy-names:
  const: dp
?

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--nMjoPdMruxxpI5xO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfsXCgAKCRB4tDGHoIJi
0l2NAP9TyOLHxFuOx/QWxt0vBNzUBke6gJ49JqaA6N7sGbZQ7QEAuMFkizybFMdo
8sKlXYG6AEuVT4QqR0/CuuBpzOwlaQg=
=oJhJ
-----END PGP SIGNATURE-----

--nMjoPdMruxxpI5xO--

