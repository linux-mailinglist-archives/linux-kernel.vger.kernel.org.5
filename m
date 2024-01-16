Return-Path: <linux-kernel+bounces-27626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989682F32E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0451C22DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A080E1CAB8;
	Tue, 16 Jan 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn891NJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0B1CAA9;
	Tue, 16 Jan 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426139; cv=none; b=uZMGsCkpmcWM43oWIUWSsrNzvLs9Joi/L5+yLEuuwcwZDmRNcq8qY4WPwXRkic3QN/ujHQEdCcPTCp4/NB24vJCOSkEKleqXB3EEDc0JZOO1FbhMa/G5N85r5BpfQ5pnIzkUfVVrBBoxSEYmviwekz518R1+l6g/RnMlk4CGPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426139; c=relaxed/simple;
	bh=/hOfx88Mr5TBRirZPgigQeV/BpPCftA+KViWmZUfBk0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=gT3/IcBoqdt9pJE61uUd8QG81XRqyfR53WWQAnlmboKNK0LA4EhlZ8TQ3XgPAfnt5y2bTMQv4lmsjZbLiuoycJLd0pRP/jfdJeLkmf8ElDj94m3zLAsi035MXHwzAIBtxsDqKzexhCZrKnMJYjAfh90e9XyoxG7fyd7uiZVz7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn891NJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474D2C433C7;
	Tue, 16 Jan 2024 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705426138;
	bh=/hOfx88Mr5TBRirZPgigQeV/BpPCftA+KViWmZUfBk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn891NJyEc/4JfRFf6f3uY/VbDV663ecz9GSyg/vZfSO867aW+DuBOa44ggqyJ0xC
	 h9n4VWWmglvVgzobfA9ebqt4iN8YPHAaxz+RCicPlr5wWxuEcfoBzn68zTWD6TTc2O
	 4zIstqYGjpWrPNPuRDJRjyvpZSSPzYF7OUEMdZmVylPX8tH9Z/J52lMGfXP7Mj1RRn
	 AOW3S0hZXhAY9RFkRvzpEKn5P9lSnVO3sJDozR49t9w89Zh8XdPZMlkPwLadnQh2vA
	 p9fM8YwjGWVnv12uBradnGp39p/NsD9mpdrw+/bkpy8NtH0TpQ8OjESFXgKWDsjv16
	 1CwgdDQTe12UA==
Date: Tue, 16 Jan 2024 17:28:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: do not override firmware-name
 $ref
Message-ID: <20240116-subtotal-urethane-35e63c7433db@spud>
References: <20240115182031.1610088-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1syrabisp+vFZ/Vi"
Content-Disposition: inline
In-Reply-To: <20240115182031.1610088-1-krzysztof.kozlowski@linaro.org>


--1syrabisp+vFZ/Vi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1syrabisp+vFZ/Vi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa81AAKCRB4tDGHoIJi
0icdAQCcnGevmqgCCTEYkJuG6/u1PQcTwyvQMCVvh4SuWtK5zQD8CZft2NykhSW1
4Y6FpR4ygdfT3yOqtYhTrky6s0iWUws=
=oRqr
-----END PGP SIGNATURE-----

--1syrabisp+vFZ/Vi--

