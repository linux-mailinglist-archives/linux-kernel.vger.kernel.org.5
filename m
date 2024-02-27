Return-Path: <linux-kernel+bounces-84125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4F86A267
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3891C22361
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2515350F;
	Tue, 27 Feb 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxQXMH+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CF14E2C6;
	Tue, 27 Feb 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072745; cv=none; b=vGJBo5OIqgqitRAzSuNyhUjEscHrQ/DS19CFLndMM0aKcdeaT4dhWJC5wnFCXOHssRKnl4+QJfk/DO8mXBG1BwfrL2NHoxnnFi15lc7UezZKc8DFT0dCqd3GozvE7zBNup2z53B4ETg17ycEavwgU2Y6S2Xu4hD3xYVqFQ+OU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072745; c=relaxed/simple;
	bh=cU0N8EL3WP2/OTKGm2lv5gr1b7Yfr2gWywwErVAJ6kU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ZgnJjIZaAPpd/ME2ZedDLmnnxvVjT4o5qlHgTfnfmiRP9Cp1WZcTiZXbRqtgENlTTLCKwJ5MBO9IeOxLGWsMBHGgWfdJ2lcHNkmPGNzKWLVVpUnJvu7ttqExln1kLSSDzMoy1rBeC96scVp/o0HalAJm1I/q4lJGjbjn7SWR0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxQXMH+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED44BC43390;
	Tue, 27 Feb 2024 22:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709072745;
	bh=cU0N8EL3WP2/OTKGm2lv5gr1b7Yfr2gWywwErVAJ6kU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YxQXMH+zIfWKfEYNyjzcJ4PNSrMKJ808/OekqlxvfSzM5qTs2vGOmKUEUvQZrTxGA
	 AGqbiElpvLjrvR6hmThwRUCNNnEC0NpWuo10z0KuKiFmeBTBacryQwRAn1xQSXI+DT
	 2NTZxraitBnfrMBBflb465pHIUFbjFyR25imlOgHgjsb3bY8csICuy+vrxSMUdO/7A
	 Y9PQbsW8VN6tuHfGLtpTQTBJkSzRkIsxHr5xKlh4cNpXGeec/elEZV16eNc2a0On6c
	 XGM3CvdL+8V3owUrSv7ATMJWuin5aBnO1DsxjCPBK28PlPsqElpTKQd1HFnhFL9taL
	 umo9O+SE0hDiw==
Message-ID: <0d784de32455c026ecc0c4ec1e844667.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240227110416.259133-1-abel.vesa@linaro.org>
References: <20240227110416.259133-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.9
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev, NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>, Mike Turquette <mturquette@baylibre.com>
Date: Tue, 27 Feb 2024 14:25:42 -0800
User-Agent: alot/0.10

Quoting Abel Vesa (2024-02-27 03:04:16)
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:
>=20
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.9
>=20
> for you to fetch changes up to 13269dc6c70444528f0093585e3559cd2f38850a:
>=20
>   clk: imx: imx8mp: Fix SAI_MCLK_SEL definition (2024-02-26 11:05:58 +020=
0)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

