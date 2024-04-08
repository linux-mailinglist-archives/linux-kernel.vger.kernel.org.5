Return-Path: <linux-kernel+bounces-134744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C688989B648
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CF7281844
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A141878;
	Mon,  8 Apr 2024 03:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESEucKpu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19176E57B;
	Mon,  8 Apr 2024 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545684; cv=none; b=geIpaj7sPTIGrB397zdeDPJmDUWbPs1Sfbd4j+jrzn7S+bpneixnfThi2djsVvIPxBp0RhkCJUxp9x8Dg/OblAsibzyjI+HCtnEHB4Hx9oAXonDLPJLciuxFjcYS/Hfpm2LxWp5bcA5sWyJxVdsI7x1kIQRd+Fz1Ns/9vOP9K/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545684; c=relaxed/simple;
	bh=79d7lOUXPylRd1CJrRvxmgrrpw+uJBDEGPcnJHO8NkE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=n0RgYChdxIG+A0FePEfEZC4S9U/q1tQdt7Kxq1CviB6ZQlHAXSOrbSCtKnNA6CY31bbPJClIPYIjDB966if70Cyi4KRWq/zxOZa0nWNUAeAm0cDJz4pBPI6xyyMjUlkKnH3/IIQRhA0iLyqNK32mFwjIqKjAIegv7HMCP6xR+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESEucKpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E24C433F1;
	Mon,  8 Apr 2024 03:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545682;
	bh=79d7lOUXPylRd1CJrRvxmgrrpw+uJBDEGPcnJHO8NkE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ESEucKpup5atxO3W1Ot59LsEvU8cdwyudJZTsXnOuCJN0Nv//Es7SEloN2gXuGR7T
	 WI990ZD4gPoLdFr5Tm1cQdmo7HUoD+Np1gIiu6tCmoP24ZnfLNnSKWkVNMygflR33g
	 LjBMBtD+p3NIYLiaZejXV0I8ieTnDI7xN9NowIjT4lsRpMzQR1xgNby0U5yDwA+Ons
	 QEdTeCsa5XXa/iKAofGLL6XdvRt3AnIGKPeKHJx3tl8glSv6XOh1BP6n9E5q8oiV+x
	 U1A2sKOG78f9IrW6RAcrvwTg0CUkwhBgM20d3DmyWaA8SujFS5PNW5i9C2T8NP+uHb
	 x59KRSdZ2aKeA==
Message-ID: <7eace4167b9ae4fbffb42dd3961215ef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231130173757.13011-3-johan+linaro@kernel.org>
References: <20231130173757.13011-1-johan+linaro@kernel.org> <20231130173757.13011-3-johan+linaro@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example
From: Stephen Boyd <sboyd@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Date: Sun, 07 Apr 2024 20:08:00 -0700
User-Agent: alot/0.10

Quoting Johan Hovold (2023-11-30 09:37:57)
> Clean up the binding example by dropping the unnecessary parent bus
> node, using a define for the second register value of the PMIC child and
> increasing indentation to four spaces.
>=20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Applied to spmi-next

