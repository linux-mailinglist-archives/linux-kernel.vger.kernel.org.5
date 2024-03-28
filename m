Return-Path: <linux-kernel+bounces-122486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4680588F857
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0170E28F972
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF150A73;
	Thu, 28 Mar 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IzBnXcaj"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15030225CF;
	Thu, 28 Mar 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609286; cv=none; b=S4HDUZYCjNBGnlIgQQm/kJBhIYGymmrDYeuAYMrB1jO2tQ1pyx9eraslQ75RxaF+Io2aWUqA/aAQsgMGgp6MzGkUSgH8JRt6OfCxUDCRxoX3sqnXFcBQDYOsv7bWosQDkZ4nIWhGc916kLnKk5Xi8SYqp1+fbgxJDpKc1jItvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609286; c=relaxed/simple;
	bh=HyO70UXpTxYEBaDWL/ivItgZZD7QD6XJZHir4xF2tlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8vehfeQpH1S06oULMohn6tmcfL2VmkUXc8FGQRax4ollfC+lKQI3m3mQsUX23oRGomeJ9kNHLwvqIucwQicxSWo+YsMrFVjX3rO7yTM78yt2m+XE8XYJyTCvSUpR0uvsoKal5Xsy3NNpkhiaTbZ3VKvGLaRh3ZFLRiusnuNX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IzBnXcaj; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=82ZFp7VyOZKKHV/oXamdBpy5uNGx0xUbcQqpgu4PGLg=;
	b=IzBnXcajF2zVtvaY+akAi7k6WUTnXItn6upEJhi//TIhCRfdE/RU4/2rHnhboM
	me5TGnBMKgYb4940qjjvSkz6RduDHgJ38QT/fjTOTqiGFNkW+8hlgDU74GjKAN4X
	m9wfpQHOYi1gjjFPDGUHMmU726cIX945mesN/o1G6ruzA=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0IZEwVmFl9OAQ--.5317S3;
	Thu, 28 Mar 2024 14:50:02 +0800 (CST)
Date: Thu, 28 Mar 2024 14:50:00 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sl: tolino-shine2hd: fix IRQ config of
 touchscreen
Message-ID: <ZgUTGAvPqsnuUY9x@dragon>
References: <20240225225622.3419104-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225225622.3419104-1-andreas@kemnade.info>
X-CM-TRANSID:ClUQrADnr0IZEwVmFl9OAQ--.5317S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIcTmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDxqvZVnxclfKYwAAs7

On Sun, Feb 25, 2024 at 11:56:22PM +0100, Andreas Kemnade wrote:
> Correctly describe the interrupt as level low. Driver enforces that
> anyways, but do not rely on that in the devicetree.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!


