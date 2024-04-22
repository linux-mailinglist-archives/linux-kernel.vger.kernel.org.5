Return-Path: <linux-kernel+bounces-152710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F88AC33A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B773B28122C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D54E10962;
	Mon, 22 Apr 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="foSg7VtP"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C9A8831;
	Mon, 22 Apr 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757936; cv=none; b=Fayz22OFIGTPh+RcWVtWOwG8+uZ9Fj1EzsUXk4YVf/Z42W6J7XGsi8lTo78ANhh8Oi3cbxu91eXIL7ocx65YXfk8k7WeB21s9hM3/ZhFHJTSx419ICcJC/M90zM1CoG13dubq2eXdbwSOb+6EaYuGaTYXql9ToOStUBS5LSg8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757936; c=relaxed/simple;
	bh=qh2lATBnUzpzdGwkWu5xianoE/fEhMZqMckQVquiV/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpRwpTffJ+l2TJR9Vd/tddaFgAhbY4htv/4czMnd/cDcCKIzGgBmkU6BPu07no1ifxs8htFmEs0tfyU+eF3xWKb/3hrmZAI6PGcYL4IqErmmoDsnzOS8eWA+P5USPVgvRCwi7gyBGvgrhqEll75UHmnhUIEbDfELFHpNpjTLw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=foSg7VtP; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=NOwt1UGzpwYrljiDMRzV2Nl5es+FS2lFQ8lExF5kDl8=;
	b=foSg7VtPVvtudsSwbGV+piQkV5VJoZhu+wuOXNp6BoxNaOoupkj7suXFaT+MFd
	9YBBeTY+I7ndVdLBAeufvZ4qEWa+5GP6xCYnBwzRpsMpbMyfrzDLaUbfZIZnCWOs
	4+xiSiInrjfOBrNc9UySLuHr565AZK2I0UAmxw519vxaQ=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrABHrxiT3iVm6gIyBA--.28493S3;
	Mon, 22 Apr 2024 11:50:44 +0800 (CST)
Date: Mon, 22 Apr 2024 11:50:43 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, jun.li@nxp.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/7] dt-bindings: usb: usbmisc-imx: add
 fsl,imx8ulp-usbmisc compatible
Message-ID: <ZiXek6rDRdku9Bfm@dragon>
References: <20240403090438.583326-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403090438.583326-1-xu.yang_2@nxp.com>
X-CM-TRANSID:C1UQrABHrxiT3iVm6gIyBA--.28493S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxGYLDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBTIZV6NnuIK1wAAsT

On Wed, Apr 03, 2024 at 05:04:32PM +0800, Xu Yang wrote:
> Add "fsl,imx8ulp-usbmisc" compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Applied all, thanks!


