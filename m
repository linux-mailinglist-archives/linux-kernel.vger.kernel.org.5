Return-Path: <linux-kernel+bounces-109991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E888858AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D241C21A73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968CC5F87D;
	Thu, 21 Mar 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mtB+gPKT"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A93C17;
	Thu, 21 Mar 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022351; cv=none; b=jiHg4Ah7DhoS9MbtZJgVjOMxhA7F+Bc9cqlCo57TlS2oA50XsHIDR2mRTaGVvNOydAXcPrnDFm4LRrqFn1L3MVs9JCwlLzOkiWV0CcBa+AvcErd8B3fix98QI8kwHYix4a9HyUjlk+aDjC9ojdV/AqTpLEwNbNkT7rLda3pSnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022351; c=relaxed/simple;
	bh=4l7z5+TdHi+BKunYZZy4EZuhnXWh6eaDGUcdasVF4b8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hz4khCNEFT8F19FEdovif+C6ATXgvfzh8ptKlEgzR2/QGpl4WxuoTKPedYPrh+BewKkixG/D0dHaY2CMe9dduvF17CS/Sfff4N6xly1EPiuiBsdwIqfuEhSTv/czKeOorYaB9kW7qbzszPupMP2Ux7dasLitt5TedpbHfYu6c6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mtB+gPKT; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0BF3C0003;
	Thu, 21 Mar 2024 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711022346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Qc2Wwh5dphHynIkahcrVg8ut74EJtXDbZzhz6iGqAE=;
	b=mtB+gPKT2g/Go95xLW/EKAjV+nWv8P8bvxyNBrbFgXMoWxGehNU9WRGN/n0XtDG0LGeTxJ
	dvTziae38fTr0mXDLcrIxtUr5a5XFtCqVCMCECt+lpYiafjEVIW86w/JkFuBDcmhdbtQ0U
	9AhZfrrysHM+IiaCJz/Lpmdod1RsIkMbkXKFvzIdUmWJ90gnhhH+yRndFQKq801nDLCyOT
	xFiPvUjB+UNu6MOXn3r7dGEyoQRSE0P3Z4zNzD9Rk59/Xz23bxnel9MwA0waS1aIRAN4he
	davASsVe99/Ar9OZqoKD4Y6Sp4uL38M2X7prIQhMZcEuDgp0PGqzmdpgprll9Q==
Date: Thu, 21 Mar 2024 12:59:04 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang
 <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier
 when created from phandles
Message-ID: <20240321125904.3ed99eb5@bootlin.com>
In-Reply-To: <CAGETcx9eFuqwJTSrGz9Or8nfHCN3=kNO5KpXwdUxQ4Z7FxHZug@mail.gmail.com>
References: <20240220111044.133776-1-herve.codina@bootlin.com>
	<20240220111044.133776-3-herve.codina@bootlin.com>
	<CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
	<20240221095137.616d2aaa@bootlin.com>
	<CAGETcx9eFuqwJTSrGz9Or8nfHCN3=kNO5KpXwdUxQ4Z7FxHZug@mail.gmail.com>
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

Hi Saravana,

On Mon, 4 Mar 2024 23:14:13 -0800
Saravana Kannan <saravanak@google.com> wrote:

..
> 
> Thanks for the example. Let me think about this a bit on how we could
> fix this and get back to you.
> 
> Please do ping me if I don't get back in a week or two.
> 

This is my ping.
Do you move forward ?

Best regards,
Hervé

