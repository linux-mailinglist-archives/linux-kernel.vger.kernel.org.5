Return-Path: <linux-kernel+bounces-133364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D660D89A2DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905BA2887AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C1171667;
	Fri,  5 Apr 2024 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TDe+wZiT"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36201171657;
	Fri,  5 Apr 2024 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335702; cv=none; b=IVTKzP0sOzFnjRDEsDP+gcSMwcJIJLAdfQU7R49jzNVLpVPR9czZrGU2Cgy9nZoQJoAlRq2WpoWkihBrdbIGgHc4fuT4f+ASIkliR9/2OvYBpE/X+dSVxJvMHfl+SmL7RZNz2npdw3eNRNLtCb4qwZduS0bFy5fXZvjqUYhYpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335702; c=relaxed/simple;
	bh=KDqdUluM40o2fzI058Ag48OzZtWO4/ZJ8Ed3fjztaxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKOvDGlkT4CuSt+ZmsZUrYjHebDQw8y6fkv5LJwDYtvaGsJ+wfhrOZiIscs9Vn7jG95p27I+fsf+55x8GwydT4AWp384YtTRF3sqRIo81RwmDwRLpyHXVuNqn/W4nXtVopEMI9HFmg4TFl7tkc6NyRIPBjnV1afGQ9410aIe/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TDe+wZiT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DA4EE1F8F8;
	Fri,  5 Apr 2024 18:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712335698;
	bh=hlfps7bjzQHeLJP55InKnvxxZsK4HvjU/VrN10ewGE4=; h=From:To:Subject;
	b=TDe+wZiT6n6AjYZKFG7qJ5YzhTzB3I4YwhAkmkBkgNwrza5LG3G9QZGwlbMo81cuq
	 QFr0cE+Rgf5Gwsc+3Bd5jji74GDzFB7pAUuaunxfWlP2B0JXZg5FL2xl7MN3Sqsxa7
	 E66O+YfHSgIl/ss8fT8A/6V47YWfwmtSGP0W7n++qL/lX5XrOb/WNYaqoNAgliaqus
	 NSuuPtp/cZLvDanYPyRBtbLYHlwdaXtIuRG725S0mrbW/hTEgGkQkFDSYkIe7JP5SW
	 q2d/J5T66CLOA470uph6G/wa/FtXgtLZa+iWYQH9PWrKc/6CDcn1NCwkkbx7DCY124
	 se6VYbEscPc9Q==
Date: Fri, 5 Apr 2024 18:48:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 3/4] arm64: dts: freescale: imx8mm-verdin: replace
 sleep-moci hog with regulator
Message-ID: <20240405164816.GC5994@francesco-nb>
References: <20240405160720.5977-1-eichest@gmail.com>
 <20240405160720.5977-4-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405160720.5977-4-eichest@gmail.com>

On Fri, Apr 05, 2024 at 06:07:19PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The Verdin family has a signal called sleep-moci which can be used to
> turn off peripherals on the carrier board when the SoM goes into
> suspend. So far we have hogged this signal, which means the peripherals
> are always on and it is not possible to add peripherals that depend on
> the sleep-moci to be on. With this change, we replace the hog with a
> regulator so that peripherals can add their own regulators that use the
> same gpio. Carrier boards that allow peripherals to be powered off in
> suspend can disable this regulator and implement their own regulator to
> control the sleep-moci.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


