Return-Path: <linux-kernel+bounces-158138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3628B1C08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA41F22AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2958F6D1B3;
	Thu, 25 Apr 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="A00fBTDh"
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000116BFAC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030695; cv=none; b=XbHVmBKKfFYOr3wbPG5hj7YUyENC2ladkRxM9TyoHhY+mlBFwL/vC+gDq98Dbi2KjatLf+E+WF+3pcDbeRiUCqanXnWfKb1rD5jcw6c7X0HWhd2Rvv/FC9BK9HS2tPX44kFNQMizwvCW6vYrPq9EcpIVFK0iUpDuOcGskgzICVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030695; c=relaxed/simple;
	bh=POh6DGR1npxv4cI/95gDfs4EK4FCh7xmdJxnsnYyC4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyyrFlkXg7ii2h+BbfBpgQfY1Rrsu0YxaNrEbf8g8S3NubBMhx3ZFPh9TxsucPBsCtSpyg+nhVJP5Aqov18Z/WokwVzjSJQK+HyWHxghD/86hh7q2IQOQtWloh26AmdkEfA6BU67BnfdwgsGxSCKzMOcE/IcPYzGo7sZCN6WtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=A00fBTDh; arc=none smtp.client-ip=62.149.156.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.5.97])
	by Aruba Outgoing Smtp  with ESMTPSA
	id ztZDrKsmITSwmztZErYHig; Thu, 25 Apr 2024 09:30:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714030255; bh=POh6DGR1npxv4cI/95gDfs4EK4FCh7xmdJxnsnYyC4A=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=A00fBTDh68ZUE/kDsxWFk0KAhPmfzKkHmPT1rrd6wR5vYB+bxIwpy1hhu4eEDT+aX
	 WU8R9RkKtb1kGWWMLmUde+VI2BA5QrglUZtx6jQ6keh1j6yVQ8zRgU2iKDpf6RK0Rv
	 9TThcrcwLDZ618KRmqMwECtpeV/eGiUQm5y7nyrSOM6lnqYX+MgFYrbv+ZB8FDk4Qu
	 STdTZ8nBFnjeTldkSx9L7PPuPqQJDQJE9IY52mjmjAGqE/jJUMQQzbjhUSHfQZLU3H
	 xUuNMUT6BLIDSdSrYzSJImfchTk5TRbl4wxuTQVWTt4UOhL7w89i7TxBpRrHJEoixo
	 2SKQeAKT2J/Vg==
Date: Thu, 25 Apr 2024 09:30:51 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: imx93: add Engicam i.Core MX93 SoM
Message-ID: <ZioGq1/zlRP1o7dj@engicam>
References: <20240419144953.8700-1-fabio.aiuto@engicam.com>
 <20240419144953.8700-3-fabio.aiuto@engicam.com>
 <ZioFaJtxYsUlchfW@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZioFaJtxYsUlchfW@dragon>
X-CMAE-Envelope: MS4xfOQWB1BSUo/PFP/F0yaa0ZoNYNDwofTChEHlBDRgFN5BH3HrLSVlIU7RetjGhX/lddbtefa0HqPQfnOBkhsTi2FAHSKOICqeu06p9oCBjcS4AjYeQ+tB
 vdVMUEZajEbyw4wBdXt5Nmgb1yOUREK2DilvR1p43gs3AYiVF+1ZCvlQvunFKZw0bewR7GVhSNoLd/VNIYTLuYvruukoNhKCFFnKUWF2YkPwgJmQDJBfZmDt
 qIS53Zxh/IV7ytZ5erh7ImwTmmP8WI8CkBcoCd4BIyg2UY38b7alkmHdcWRSDLLWw4WFkK7tkGUi4BAwEfXOjOhS3BlclBt0VE7Vz+AV7hsy8uorVMyVBL9s
 /tRl5L3YmZsuB2gaG1TVgylyG0wrzQUytUdwbFfjf6bSTa9110ie9XRfiVEs9HNcS7W8FSR86XI/+LqpCrzkD3o4SM614aFhilyXWrKF/S8T4Nep6Ns4enh2
 ObVOK6YiymmkEwPSWdWhdBborByOMY7+OuZ0CY+GtpjhSsGIFhvEGQHTp1oWrCRHLbhpVKPR8mEjvFsLW5H4EZ/1AlQRqDs1VNZ4c2Y8lXlMLmxs2xWShYXc
 ScQ=

Dear Shawn,

Il Thu, Apr 25, 2024 at 03:25:28PM +0800, Shawn Guo ha scritto:
> On Fri, Apr 19, 2024 at 04:49:52PM +0200, Fabio Aiuto wrote:
<snip>
> > +			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x130e
> > +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> 
> Could you try to align the indents, so that those hex values appear at
> the same column?

thanks for your review, I will send a v5.

kr,

fabio

> 
> Shawn
> 
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> > +		fsl,pins = <
> > +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> > +		>;
> > +	};
> > +};
> > -- 
> > 2.34.1
> > 
> 

