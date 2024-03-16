Return-Path: <linux-kernel+bounces-105226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9991487DAC4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DDD28230A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB841BC4E;
	Sat, 16 Mar 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXNM6JFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64561B964;
	Sat, 16 Mar 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606009; cv=none; b=uHSimcp9LlZHbKbpT26QHTEfjGhXC2DoHtQRdt6LbChJlC87fQQQvANkIQudLaFkWLfpVW26cAlVU4devfkaKOX5YWXUnfkqzJlBRivHgrnfaxSB8vgEfBpEZCoYvfZohxHJvZpNPTmoge9wPpsGcdNsjy+cPc5Z0Jf73bDHpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606009; c=relaxed/simple;
	bh=wWfDrMxlKAAHdXQoz1wKJ6soUSFbO+NXsn6wGPuTqeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8W9Y9oFLpNBcaSx71bZ4YtQt1Hswt1LJpCIBrRLyrCKPSnrgxQCtlXXT88X3wM55CPUZr0+UIVysG7AnsbzzYnrKEFzoYjx47OwHu9qIYTASQzN6aAmEbxxm7pXvGAWhnttF0J3eLEic/yrWxD9UghS6HdGjSGwPFlsnltlJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXNM6JFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5136C433F1;
	Sat, 16 Mar 2024 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710606009;
	bh=wWfDrMxlKAAHdXQoz1wKJ6soUSFbO+NXsn6wGPuTqeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXNM6JFWMvnjo24oeEsdu6XQL44YKNfYOZgAr/fIZzRh/Z/Yszq1ltqqeGNHx4ZUR
	 AOsBUQ4TQf04amRNE+iFRbl118k/paSNZaMFSL+41+8zdvWSVNMcVEcDTkZ3F3lWFr
	 po6tQKcq67y0LDRY1pWITvAISJ/AmuZmvWmPmuyB6UCdNRMVFQZBmNlOPmqmm8JfwP
	 h8MxSegPgTf1EYKTeHgxpC/f6SaNI/ALXn9QEKadLOEw/nfBwiLI//+yitKD/IeAiN
	 TFq8O0tN3nzdG+jF/+KahMmY3CiTyW6Gqmwr1bV2CY6vlO0Y8Jo1b0lzIi2dQa8nhL
	 sirzoeVrGBSUQ==
Date: Sat, 16 Mar 2024 16:20:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Amrit Anand <quic_amrianan@quicinc.com>, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
	peter.griffin@linaro.org, linux-riscv@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-mediatek@lists.infradead.org,
	Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: qcom: Update DT bindings for
 multiple DT
Message-ID: <20240316-germinate-browsing-6865db3a44d7@spud>
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
 <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
 <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tCduvHh9wXhEP0el"
Content-Disposition: inline
In-Reply-To: <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>


--tCduvHh9wXhEP0el
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2024 at 02:20:38PM +0000, Caleb Connolly wrote:
> On 14/03/2024 12:11, Amrit Anand wrote:
> 2. A top level board-id property that isn't namespaced implies that it
> isn't vendor specific, but the proposed implementation doesn't even
> pretend to be vendor agnostic.

I pointed out previously that the Chromebook guys had some similar
issues with dtb selection when the OEM varies parts but there does not
seem to be any of them on CC here.
There's definitely a generic problem to be solved here but I don't see
an effort made to involve the other people known to have the same
problems and this is all highly vendor specific.

--tCduvHh9wXhEP0el
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfXGswAKCRB4tDGHoIJi
0i8QAP933DDPKZ34gelBNiCnSveXI+wd4DrofTe+JiVItAGQngEA38mvngcysQke
6ZrKo1u7YDvXAH0bmMFJAWV6LKzeWg0=
=F4VS
-----END PGP SIGNATURE-----

--tCduvHh9wXhEP0el--

