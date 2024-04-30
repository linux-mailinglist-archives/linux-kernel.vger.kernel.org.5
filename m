Return-Path: <linux-kernel+bounces-163594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D98B6D72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D081F21BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64660129E75;
	Tue, 30 Apr 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZZrBJ0sW"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3734127E02;
	Tue, 30 Apr 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467095; cv=none; b=XPkAbtr0kP+lSVmejX/mkzYt+AIWpIivTxPx0OyOVS6J/wxWaCfKcB6r4YQp9AhXILVebT6E5YIB/gYr+KiK8ffF0RLCKIioxdEpkpioWmH/UwJtcV+UvH6OL2kRSIMfWvRteOMzFHsM3JhTZWIM6ysUoO8rATHqjkbdmQAXKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467095; c=relaxed/simple;
	bh=zvLIiyW+JffmN42SewRlbiKGu/JyJ34KrEDyBdS2XdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvx5s8loqHbva+78IHgw/fW+uAOnN7FdeSf52RKCYz+Ge915liNBjsmkmhAordd4L2tEcHP2P8XZXj4BwHOJYBQzjc7SkFLmi3A+IVzkvvl8fV4HYbvcomn+MPPOLS2VlRomUstChjxt+/U2hfdQX0r0/VaRoAXK7yzJjfG7yJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZZrBJ0sW; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F86920007;
	Tue, 30 Apr 2024 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714467092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ33nCDPzcz3GbzldkrJNXG20ehE1+Mdo499qe1NhRM=;
	b=ZZrBJ0sWMMQ641ZoxefcTdJs+U9C/L15J6uz2Ou0JHNB2IHOu+Zdq65d9u2RUMu1AWGyF1
	PUDbN6BFrZTJNAhfK+dMOpAghh9uRVZc97yPj+TPRuCllkdkGJlyuDgn36QBGc+gUIGLyS
	VIf/rU14jKRvvaM38y+apb4YxuDYUw/9Q5XJFKQeFpUMRtb0koQaCV7UwRuyUlT2z4Q4Vv
	/lDcJbyyg+js3YfU+Tzq1M7DCjgK1ijQr0JeWAUhAxjR9VPjLIZ0xJ5v6aB39zifkJfuq9
	O4Ytlahza2BZlzoP3Bb2o3L5XRco9nIU34pcH7WwalxcCmWVqBCdP0jjqZTfCg==
Date: Tue, 30 Apr 2024 10:51:30 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Doug Anderson <dianders@chromium.org>, Chen-Yu Tsai
 <wenst@chromium.org>, Matt Coster <Matt.Coster@imgtec.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor@kernel.org>, Saravana Kannan <saravanak@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: Hotplug hardware with (un)loadable DT overlays - unconference
 meeting notes
Message-ID: <20240430105130.11725e1e@bootlin.com>
In-Reply-To: <20240426115141.201f257a@booty>
References: <20240426115141.201f257a@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Fri, 26 Apr 2024 11:51:41 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

..

> One use case is for the LAN966x, a classic SoC that can be however be
> started in "endpoint mode", i.e. with the CPU cores deactivated and a
> PCI endpoint that allows an external CPU to access all the peripherals
> over PCIe. In practice the whole SoC would be used as a peripheral chip
> providing lots of devices for another SoC where the OS runs. This use
> case has been described by Rob Herring and Lizhi Hou at LPC 2023 [4][5].
> 

FYI, I sent upstream the first iteration of the series adding minimal
support the LAN966x PCI device driver.
  https://lore.kernel.org/lkml/20240430083730.134918-1-herve.codina@bootlin.com/

This driver binds on the LAN996x PCI VID/PID, and when probed, loads a DT
overlay to instantiates all internal devices re-using all existing drivers
with no change.

Best regards,
Hervé

