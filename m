Return-Path: <linux-kernel+bounces-35742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F183961F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7C1B2D847
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0207F7FD;
	Tue, 23 Jan 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="deW47T29"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AB48791;
	Tue, 23 Jan 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029223; cv=none; b=UbTV7wNqKhiMtC+poUDD049ee79iqFAjKi+yUgJzio+s7m23jDVvQuxR/ksqyXqiKU7DM8Dd9wIR5pwnyUIauCFkAqH+OiCeQt9ZYFY9sFWYl8whGzzH43PaXjX7X4Yg44JERGtkMtwMYOpOZxASpGl6NZyhZpfln8Hcjko4Z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029223; c=relaxed/simple;
	bh=xG91bq5jiHJZ/duHCwup533F99GaZXNWVJuTC0VN+oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luavnXC2sxQs5W8l9NceHWpXLQtZpE2AXC+F1gESDBBaoSzXHZHyvOvNlMUHuQFiewRYdtXueC4Qr1g6NBo/8pEBdSzlkSXYzlyoU4KC/lzXnHAgUvNw62hGI/PUehFsQ23H+A8SoY795jsZR3BLGrxeSJiP6u+/aobcQifqrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=deW47T29; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 01C3B207BE;
	Tue, 23 Jan 2024 18:00:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706029216;
	bh=ck/KUQN2/fWIfoiB86Fojcmm81D1jTQUt3Ati8mZaHM=; h=From:To:Subject;
	b=deW47T291xctdvmwgYDoRDQPpRtj7wxPZi8jCRsZ7//44oSdfFt6t+Hamyu8UHvca
	 PotpleVr3MA6tD3slnLRyyC7ziycDEj+hShAg0PDJSiyUBYdMeZK4r7e6toWQJO2rm
	 pgIErDaprR+G1UWJ4+RZB4T1P73YP/qbjYx8mz4ub5HuiBEo3sQ7h5JhGcadQYPo2n
	 nZKjTk9F0lh3EymxKBfonsNA7U3fWtk8Sc4ACjm5WtI0HOCDC0/Od0six+x5wJlbPk
	 NTf8cH3wbFV9mRbufT0cnHU0bsUXnqcRMHj6EuzmAayEDkyyP22fUDIX/+AR0LUuK0
	 0n6t/Qy6/rR9A==
Date: Tue, 23 Jan 2024 18:00:10 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hiago De Franco <hiagofranco@gmail.com>
Subject: Re: [PATCH v1 0/2] nxp: imx: Add support for Apalis Evaluation Board
 v1.2
Message-ID: <20240123170010.GA16396@francesco-nb>
References: <20240122123526.43400-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122123526.43400-1-hiagofranco@gmail.com>

Hello Shawn,

On Mon, Jan 22, 2024 at 09:34:58AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> This patch series introduces support for the new Apalis Evaluation Board
> v1.2. With the introduction of v1.2, a common dtsi file, containing 
> shared configurations for both apalis-eval.dts and apalis-eval-v1.2.dts,
> has been created. The eval and eval-v1.2 dts files will now capture the
> differences between these two boards. Additionally, updates have been
> made to nxp/imx/Makefile and arm/fsl.yaml to accommodate these changes.

We found a couple of late issues during some additional testing on the
DTS, some regulator delays are not correct. Hiago will send a v2 in the
next couple of days.

Thanks,
Francesco


