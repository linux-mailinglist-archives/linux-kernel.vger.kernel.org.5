Return-Path: <linux-kernel+bounces-55554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E822B84BE10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BDE288CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8DC17588;
	Tue,  6 Feb 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dryfk4hB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE2171B0;
	Tue,  6 Feb 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247518; cv=none; b=m46aFUWi1TdTZr6U8wfFRoPv0ETDVlCqF8KpnyVFidncfdAeBmAfqWyA4kVsB9/JPV/0C7CHgSC+dfZHqat+mD/flg5AoFWPaOZbybUJfJEr+LhrL1FYPukU5vodbL6XSk/Jv0Gn2QF+OiRNCWRXCFvD+pw+/yRp355etbKGpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247518; c=relaxed/simple;
	bh=Mu4K6W1Ehm84eYP2IsyclOUmQOj8IiBKVmzjXqzzQ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWBP9lEX6742jPRNzmrpl8jb3BCnOQzZ9mSR3Jb8jk7ebAJkFvBfchrbhL/K2Ju1gup8OweNqMYk7Yoc0JRdfTXc4VfCgBG3/bENIHpaCnskGmVCBprslJcAGz6ED+1qr5vhPZ0PjVXTxW1srUj7uvq7ONuG3EuiflZ7q7QtZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dryfk4hB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CC5C433C7;
	Tue,  6 Feb 2024 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707247516;
	bh=Mu4K6W1Ehm84eYP2IsyclOUmQOj8IiBKVmzjXqzzQ2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dryfk4hBPCkoHPTRg3bOk3W70RS8MbpKC1iEwwOvNetBlzd81NKnbDWZByUZFt2Kk
	 xCSY4+QuwurPs60t78WctLqClMcT0WqgN6MJPDJfbJy1nAJK9PFB/u7g7YevXeeU66
	 Oz82bqacMGrjQs8YoAnZOObRKuVMnFFiVKgVScvClx1Pw0ABQK1kJOJyv5ns+hYGi3
	 507LPYJs7O1l3UavO+3NG68bZOMB6bK5eOaZm+YUpAR6OyCJ4Bb3IRY0Y74lRxGcok
	 YjMjV232u0P1L1iEJZbNwCaEIjMnf+OpXmQ+lagpDKh2GgI6jvA39b2/UhJQxkO8qI
	 ro6dKcSZh907Q==
Date: Tue, 6 Feb 2024 19:25:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2 0/8] Add T-Head TH1520 SoC pin control
Message-ID: <20240206-cornball-blighted-e40a9cc059cf@spud>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9SR2866Q2kC1oVMZ"
Content-Disposition: inline
In-Reply-To: <20240103132852.298964-1-emil.renner.berthing@canonical.com>


--9SR2866Q2kC1oVMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2024 at 02:28:37PM +0100, Emil Renner Berthing wrote:
> This adds a pin control driver for the T-Head TH1520 RISC-V SoC used on
> the Lichee Pi 4A and BeagleV Ahead boards and updates the device trees
> to make use of it.

I'm gonna mark the bits of this that apply to me as "superseded", albeit
somewhat preemptive, since you'll need to resubmit the bindings patch.

Cheers,
Conor.

--9SR2866Q2kC1oVMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcKHlwAKCRB4tDGHoIJi
0jngAQC/9KRmKdjlujY+RbvfKLmq782PlybcZHEB0rVLPFyb/wEA7SN2iJajXSPV
T3vr7u9GNYAvcAHAcDhp3/esony+yQ0=
=3Hcg
-----END PGP SIGNATURE-----

--9SR2866Q2kC1oVMZ--

