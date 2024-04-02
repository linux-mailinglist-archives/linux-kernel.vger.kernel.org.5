Return-Path: <linux-kernel+bounces-127569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573DC894DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3747285690
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4C3E47E;
	Tue,  2 Apr 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHfWfaj9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26326524D3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047087; cv=none; b=jU5yXDOddIrzFp3GpgYAkUNBt/81cLOjsVZvj/mLSB0BjYTo94QzZEvL9+GWen4LqeJhmYVaGouM8tpJGRRmWGNVlm3zzXBZ006StjEkWK8SoGhjSfUSN2EaTGejoy/zCWRS0wO4fMmbEY8VgXUuV5GsT+cPjmRYfiBdOF4XSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047087; c=relaxed/simple;
	bh=LirfE2sJe4kTeyCZkir8bGDzKeFgzEbdenSPFydvQNQ=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=tgF8d7YS7ts2b5iSbfS/Jfb1W1whHmjosoMJYa4LT4ZBcV6hCk8M6FY8gLxgw0RU+k5SalgWcGymmNgZMNkfIDn9hmtUAhSIT6CbwDvhumKHJieNd+2Fg2heEIvLP+H18YtF4nPPyBn7x/NXy1SnguTiXXFEjpj33BwDnG27+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHfWfaj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DF7C433F1;
	Tue,  2 Apr 2024 08:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712047087;
	bh=LirfE2sJe4kTeyCZkir8bGDzKeFgzEbdenSPFydvQNQ=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=oHfWfaj90NbGpbgzdX6HPUQ+pvZ4KsKGXHjluMvO8k/AwQCeT2d0hf3NkKN0jXq/8
	 MKBtYIwRTpl8r/g8nP2OtxQE/K43AbeYhMr5+hpv8o1/i5HEn3XtIs7xjiFvK1Gc+s
	 T60skhGMM+Y3YdXrHClqhkL7KJB1tvMR/VAShLDGRIgRysjBTY+2oXOZANFEG3Y+oy
	 4OSp5VWGwsbtRJeAdc5doYnoq23fqrqlLe8yjz9qq7DFVV3Sd8lrb54jKxk+spEaIc
	 4MAIqXHBSZ0PWWRS8DfhhXGx5IiiM/HcLAUgR0qRrDjg3pw6Kc62xYk24+IloYVsXy
	 wa9sd6DQVLm9g==
Content-Type: multipart/signed;
 boundary=8d306778cd3ad5495315504065c3a2fc14a3ecabb45663b2947b011d57f0;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 02 Apr 2024 10:38:03 +0200
Message-Id: <D09I1GAA205Q.1DKGG149MYCVA@kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 3/3] nvmem: layouts: sl28vpd: drop driver owner
 initialization
Cc: <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
 <20240329-module-owner-nvmem-v1-3-d700685f08e1@linaro.org>
In-Reply-To: <20240329-module-owner-nvmem-v1-3-d700685f08e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8d306778cd3ad5495315504065c3a2fc14a3ecabb45663b2947b011d57f0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Mar 29, 2024 at 5:13 PM CET, Krzysztof Kozlowski wrote:
> Core in nvmem_layout_driver_register() already sets the .owner, so
> driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--8d306778cd3ad5495315504065c3a2fc14a3ecabb45663b2947b011d57f0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZgvD6xIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jkMgF7BBKppQzmqxs6DFx6M4WW4tH3ynxQz273
780CK8YsyeMjjsdUigTj8EHriWoCa2rDAXwMqxIPjr6TleSn6ZUadnf5D2x4F8f/
++hp3RvIF5Vkpie75lDHspKpf/jRS1/04LA=
=TBFZ
-----END PGP SIGNATURE-----

--8d306778cd3ad5495315504065c3a2fc14a3ecabb45663b2947b011d57f0--

