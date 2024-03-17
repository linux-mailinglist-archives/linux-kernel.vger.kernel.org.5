Return-Path: <linux-kernel+bounces-105412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675987DD8B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87257B20D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A31B813;
	Sun, 17 Mar 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kISgGytO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF681C680;
	Sun, 17 Mar 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710687033; cv=none; b=a1leAtliM1pWuZyK7WJycwVfycudM9onsCtNO5ctPz1ZmQGFqxaK04ndfn/yJA6knRSzBcjNrKRjT4VEO7+PlHzR1zHlGAiWoqeReqRMhUdImRWS+THiJIAeX9mG471d1/EjX4GeDco4hL5BsNCY3n4cJnVsO2gmcfeovoTKRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710687033; c=relaxed/simple;
	bh=oPBwva1WVfUuj8id2neC1zAsQejHqZ5JkFiuE8KL/0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgQtbgSBsrVuXaXKKovFNXvva0dSBzSCKp2Loan4bsT1iwa1+WppynZA9Ghme+M7CJqoORuiX8OWPUIr/7mn3pe1gjPxfCypcaETGjxM0iLQK6jIEvJG/yM4claG8F+Xp1jvsW+LYpeDQzSk+vqbX80RxYsB0XFBvulxCSS9mDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kISgGytO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687A6C433C7;
	Sun, 17 Mar 2024 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710687031;
	bh=oPBwva1WVfUuj8id2neC1zAsQejHqZ5JkFiuE8KL/0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kISgGytObCd7mmNaa1OY94GTga/nLiqxOye3F0kHhOjJIRXPIjfuksPRIeOlsNlNm
	 /2v9iixUOM7G9pN7737cV9mP4p2t1gNbsj4/SBOU7LrE7aZ8IuPdp86C/bfFCaCSyW
	 iHS8cwRYjpCAHx/OFIIOu5mdjBVs2CnHcLiJVWQMMLFHxI/g9Y+ifKyGGwlweIwD2Y
	 7tRnOe0qCNgJZFFATvvTSp/lkgsP/hlNH7mgCVbBgXYX379htlIfgoEWdApvpVFxcd
	 8GouHI+fRM7vPT6fM6YigZvUW9zNyOkrlTc/fKcfsKd5JAPj6XZ5BlvY66ByG49kIL
	 o9bfeFPvrhbuQ==
Date: Sun, 17 Mar 2024 14:50:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, ben.levinsky@amd.com,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: add Versal platform support
Message-ID: <20240317-overturn-frozen-b152dc552a2f@spud>
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-2-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1EV403AXl1yp7son"
Content-Disposition: inline
In-Reply-To: <20240315211533.1996543-2-tanmay.shah@amd.com>


--1EV403AXl1yp7son
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 02:15:31PM -0700, Tanmay Shah wrote:
> AMD-Xilinx Versal platform is successor of ZynqMP platform. Real-time
> Processor Unit R5 cluster IP on Versal is same as of ZynqMP Platform.

> Only difference is power-domains ID needed by power management firmware.
> Hence, keeping the compatible property same as of zynqmp node.

No, don't be lazy. Add a compatible with a fallback please.
This doesn't apply to linux-next either FYI.

--1EV403AXl1yp7son
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcDMwAKCRB4tDGHoIJi
0oaWAQCUJvsYFEe1emqOyewXQBDCqeKe9OxSG4FYTScohqSl9wEA+dqtZrIt1uYL
CtQKD1d2iy56L09U7L0EEdItNA6Sbwc=
=+0yE
-----END PGP SIGNATURE-----

--1EV403AXl1yp7son--

