Return-Path: <linux-kernel+bounces-152729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94868AC38A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E417281878
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0B168BD;
	Mon, 22 Apr 2024 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZL5n0Mo0"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E03F14269;
	Mon, 22 Apr 2024 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761952; cv=none; b=KklJpNe2V7YBFvWzV9KGvKz9biKnO1k14vfXoZx0Zf4UvYANOAZAqAny309rqA3t6xXOL/LPO5PRjJhpuw8myM5bKftt5B6rczBtHIm3yn8H9T/Q1RAKDG653fZZroNxckPiupWEFXR2FDJEdcA0kccw+pH0inj055f8FhWJNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761952; c=relaxed/simple;
	bh=e2IOv5P5BEhLEgCvqfH/NoIA22PfHjXvysi4/N9o8Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvE8jOGKYSmVA6bXOTzUF3WFyamU58lWLb/ebhzBmO9k0Hk9EzX8eB5hHZJ8ni5o8gEkbHklNmK1bERDpkk36tvwQONEv1DM3GaPfyzTRRAeLLe7gXMqAAkFvD/UlM/oz0+ETUaLhYN6NgvRXMdyCD7Q80CR38DXWLynu1oFu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZL5n0Mo0; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=bLSMPym9YLKBmvTHeO2esyIfmmXqnJLIMS/RpQu5QIY=;
	b=ZL5n0Mo0pwM+TSXvjxE6CKzjodmMDGkjTlKhujJGdGqF8jfDQA85U79CDpfCUs
	QYOUZTkLIK7utM0DIXcw9ZzszpaZlkqUPyd0q3MT2KAs3piS2JW9W7Ij6rHO7LSV
	ejGoTWc40Vtvhd1QL6aKmmihGF6hVol0YFpERkGEfHgwg=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADHTw9_7iVmhDAzBA--.10732S3;
	Mon, 22 Apr 2024 12:58:40 +0800 (CST)
Date: Mon, 22 Apr 2024 12:58:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: Enable HDMI on TQMa8MPxL/MBa8MPxL
Message-ID: <ZiXufwvLKmZ9ouXB@dragon>
References: <20240410063706.3813894-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410063706.3813894-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:C1UQrADHTw9_7iVmhDAzBA--.10732S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVco2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBbIZV6NnuI2vQABsG

On Wed, Apr 10, 2024 at 08:37:05AM +0200, Alexander Stein wrote:
> Enable HDMI nodes and add the output connector.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks! 


