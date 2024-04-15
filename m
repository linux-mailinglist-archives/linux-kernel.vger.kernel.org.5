Return-Path: <linux-kernel+bounces-144965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F718A4D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D9B1F2630A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C25FB93;
	Mon, 15 Apr 2024 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="v8YjF0Jo"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E775CDF0;
	Mon, 15 Apr 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178991; cv=none; b=fr/fp+Pe5qW08jDON1RgRGmtTsFRDbUI2ga9oZaiBHbuyz8H1QDuSrgzikPH/EqNOE0PbEk3Az3HROGlzctU98oj2JiPVvsaV3QkMCIO7ejU4K1u04r3K071/D/a7bWM7DxeLGBYxDxf8jY6LCyLCOLBT8dI0PRA/U8B1+e5o1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178991; c=relaxed/simple;
	bh=zeufB+IT2nElS5XbXcpCtUxCwmicTorWNgZOzuZLumw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvIqfvwCrxRwMYJabdKWx+H9gEYi7A/zPUYLMIycolxwqTZnAQLAj1JE9G5q9r1xw+uuv6STP/pHZ2HpuliiCdVHgKB5Z5/efRXCgHe65x36UwVbn2ikq5Y+fOYKMOGB4vXHgWgGIcU6DQen59gazTaYrO8qMPQ7WR7yaDMYhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=v8YjF0Jo; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B28AD1F9AE;
	Mon, 15 Apr 2024 13:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713178979;
	bh=IldUJ0BuDZyYdOwP/feqXIRy34BTc4XO/Kq0acOo5N0=;
	h=Received:From:To:Subject;
	b=v8YjF0JoIdrE7ytJ0YUkM0uPfAQqgUlz3eROzDkUZ3fTXfdFNdS8RSgjTaQjp0aLL
	 Pg7tr4dEj6MBb0mxja4M2Frtyyo2PTwp0c2x/kEFpQrkIo5YjR8j5JbolZ7Ym9iws5
	 pqTF3tYUAjQU8kQyjrdsZ6wgebYn+J6OfkTR2EJ5jyEDYuPpdLZOcDTPrJLcOKlxO5
	 JNz8rzzm3NflunpN41tAO4DFL4uF/6c/VwMGZbszPEzMSGP12zkg7P+7oGIIn83CxD
	 7fSGewiJErPrLNZBwOPZT5PnxgGoY7+tTWoyUmsHIiNk4gz94a9mhvlzHl32z4oJyu
	 zDJhvFN71Eyag==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 5C4AA7F950; Mon, 15 Apr 2024 13:02:59 +0200 (CEST)
Date: Mon, 15 Apr 2024 13:02:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, francesco@dolcini.it, kristo@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j784s4-evm: Fix UART pin type
 and macro type
Message-ID: <Zh0JY9FlqZOW6Ulw@gaggiata.pivistrello.it>
References: <20240415095605.3547933-1-u-kumar1@ti.com>
 <20240415095605.3547933-2-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415095605.3547933-2-u-kumar1@ti.com>

On Mon, Apr 15, 2024 at 03:26:04PM +0530, Udit Kumar wrote:
> Along fixing wkup UART TX pin as OUTPUT instead of INPUT,
> updating J784S4 macro for pin mux instead of J721S2.
> 
> Fixes: 5dfbd1debc8c ("arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom")
> Fixes: 6fa5d37a2f34 ("arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


