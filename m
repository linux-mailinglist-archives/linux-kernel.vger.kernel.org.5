Return-Path: <linux-kernel+bounces-127567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C92894DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37071C20A73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B93F8F7;
	Tue,  2 Apr 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1IO3xRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66071772D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047047; cv=none; b=pHMyvnF+xUmRLG63uUStI6BqRWEp1MkuvMnnsfEck+FfEh0Oj3gJE9yVgdIk8hEb9CNmjvjYt4hZmf+5QAutOgoVvx8HLo251B2MlwzHZgb7U6Jrx2r4R+bM9/IaVE0XAhHpmAIP1845KJs8J4tt236abocbOxHRp+xaxz1qSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047047; c=relaxed/simple;
	bh=OHCex86ejAIFqX000VOlgpmI23A1qiIbvTNM5wesSIU=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=XlOcozchV1jf3NTyfa9LXWWMo6AVNnMcMn5UX5kKM+BYXZCvTY1z4ILNdxqj9cQygrsdnLj3pCRmwlY0i8JZW5g4pekXgDS3uTQKF2rjGb7yAmOPEtpOFAOn3OYNW3laVeVSpzOzZE7KY5Zs0kJ7Gc5akFa6KUOoLuY/Fd0n7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1IO3xRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5258AC433C7;
	Tue,  2 Apr 2024 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712047047;
	bh=OHCex86ejAIFqX000VOlgpmI23A1qiIbvTNM5wesSIU=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=P1IO3xROQZGS2fCZ06UxWybjaAvUHfySV+PL9Lk/sdZX0HSDZqNn8TzMqg6B1atOP
	 NpzgdA03rRe+GmeaDJS4XjpJ8owWSw7BMiAO2dINP7wuSImLIJ5730esclltvIC0or
	 QwI+D87nzxVwJ3mpj8Oo4FKhGF+cNhfL8mWppEQzzaWBN7mASJ06fajusyPARVNTNQ
	 ++nLF+qIwMOlMjSFXZeeIsFpqid0PTSKgiHnTPzzXKRU0EtV52dwWjnXKq+VYeIFUH
	 BKLELzpvOVTvNNTC+AnYyiUfLL8p9RfuDY2TBDyKlq3CAjkK61BJ3vmbTndmkTbAh3
	 KNHTlO9iKb91Q==
Content-Type: multipart/signed;
 boundary=da0864b69030f7d19a4d86df6475a90ba83b3b0f6fe192d174a168ba9ad7;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 02 Apr 2024 10:37:24 +0200
Message-Id: <D09I0YEBGBV8.3SOV5AYONO5ZL@kernel.org>
Subject: Re: [PATCH 1/3] nvmem: layouts: store owner from modules with
 nvmem_layout_driver_register()
Cc: <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.16.0
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
 <20240329-module-owner-nvmem-v1-1-d700685f08e1@linaro.org>
In-Reply-To: <20240329-module-owner-nvmem-v1-1-d700685f08e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--da0864b69030f7d19a4d86df6475a90ba83b3b0f6fe192d174a168ba9ad7
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Mar 29, 2024 at 5:13 PM CET, Krzysztof Kozlowski wrote:
> Modules registering driver with nvmem_layout_driver_register() might
> forget to set .owner field.  The field is used by some of other kernel
> parts for reference counting (try_module_get()), so it is expected that
> drivers will set it.
>
> Solve the problem by moving this task away from the drivers to the core
> code, just like we did for platform_driver in
> commit 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--da0864b69030f7d19a4d86df6475a90ba83b3b0f6fe192d174a168ba9ad7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZgvDxBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iyWwGApFLJ3/8u7BW1Nu9VLng/g6AXHPywIVXs
y58D+lf5bN/DnIsCHk88i8axaeAc3XiEAX4gazxHDDv8Gg01blW6Jq6aE5pHrSeG
lZpOUdqiPEEOo6WFxWDOn+/oh96hIDPcz9c=
=avti
-----END PGP SIGNATURE-----

--da0864b69030f7d19a4d86df6475a90ba83b3b0f6fe192d174a168ba9ad7--

