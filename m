Return-Path: <linux-kernel+bounces-104579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A687D062
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249B41F215DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB33DBBC;
	Fri, 15 Mar 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Pnis1sI9"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459253BB52;
	Fri, 15 Mar 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516820; cv=none; b=FlgaJOYf7iWFOXv0WbQQryI+b9H3IEjVuLfsqUCUjlX6DJBlH188n15pzqkzRpqpHJq1WVScq4e4m2AB5di07/qksM+dw5VK5BhR2p5KaZgp07Shs6DxaqvXIaeCmwyJLz75yrfsdj4NZBpVWyRy8qn4kZ1H0GVB/cVSmq+5TPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516820; c=relaxed/simple;
	bh=dvn4/U6uPrMUIBGYeEo6TqrtbQXgI9y158xfzC6wxQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ8ZYScz7JrTsjN0malfMhXOvBcT10oYEZH9wAHV70P6GrZ5aU3wYtETPld2SaRkNZH6yHoDCOUOHbxkUF5c14zowBsRcVXfGT/ZAKfFSCg8Fu2qA6MdTL3ITm1OlHcw6VxoidHo4WxQcPSkQA5cf1goEhrim0uK1U0HxHjENn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Pnis1sI9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EA3F91FA91;
	Fri, 15 Mar 2024 16:33:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710516807;
	bh=zPCuo2gTzB/xvX++e/jE9wP6QdKb7XMn6eqirgfq4pU=; h=From:To:Subject;
	b=Pnis1sI9ijiGFHdQ0SmQ3hYGuULP3RziWCzDJ4gd2RniZnwdVVwrU/hvpbHXaAkco
	 XWfsjRc72plRbwDSUwoAS9dlIii8IF/7AVFItueJjzG6+FaGlIxJM/GE2g2iA13Hr7
	 UiasOIujdYhXE5p50QV1BXHPb8Ugmg9kecpKbfTUUtT6apth2/GJGTU1A7Jz2DGZ0l
	 meQNrEypMfQ4MTixJ5obFOpsuYaHxIGAMaALBEUd6Ht34ifdDCkXbHidVzM/nWC1kh
	 1+zVIKtv4dOomXZKoPjIbTAXvF114esPQ9vwdUmuhNE9s4ItWHdOK6LheAKej6k0iw
	 dS6R7bh/AdnZg==
Date: Fri, 15 Mar 2024 16:33:22 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: Jai Luthra <j-luthra@ti.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: dahlia: fix audio clock
Message-ID: <20240315153322.GA3579@francesco-nb>
References: <20240315102500.18492-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315102500.18492-1-andrejs.cainikovs@gmail.com>

On Fri, Mar 15, 2024 at 11:25:00AM +0100, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> In current configuration, wm8904 codec on Dahlia carrier board provides
> distorted audio output. This happens due to reference clock is fixed to
> 25MHz and no FLL is enabled. During playback following parameters are set:

[...]

> Fixes: f5bf894c865b ("arm64: dts: ti: verdin-am62: dahlia: add sound card")
> Suggested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


