Return-Path: <linux-kernel+bounces-86277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121986C338
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938331C20E68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68E48CDC;
	Thu, 29 Feb 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwV2y6HT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5ED41AAC;
	Thu, 29 Feb 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194393; cv=none; b=qYvTgbq3Yrt+i5RCfws5C1f6cxVa7wPtH+/kjUkHBpRNQqyaEdKwvBoAwEcKSbashxPa9yGvZeerqTGIsoep8qH/AMQnjnMcz3zwG4b8c62tjz6Mr7mOLNMzdYEawkrrxNCq78rqpd/NmRsbY8QqPPhLZ1FdrWDKAXG8oJJxF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194393; c=relaxed/simple;
	bh=l6yHvRdD7XwsCkxIzl0V45IYEtDBJCBz6/WZSkkdEZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZPz0X/afwWgM7+eWCcZRXSzU+fhWBhw3CYcKCVRCaOunVzeLzWbloMArFuanCZ8B2TNdFy4IgmH+Kiha5nwB/F0iXq61s6lN4XszkTn8Zq0AH+RFMHCCLBB6UC3fIdM1bRGYY3QRnHPV7TGN2GJeOZiV7gPIyQcbmHmjaBvtYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwV2y6HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34929C433F1;
	Thu, 29 Feb 2024 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709194393;
	bh=l6yHvRdD7XwsCkxIzl0V45IYEtDBJCBz6/WZSkkdEZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwV2y6HTxA+rcrGYLOmj/MXe70IksqePBpbe39FxTn7DKaK/VzwfhHB55Do8wPyMB
	 7v9oEyO42hJqoMC3zzqIdWFVD87sjsVIGPoWi3jqScnWwxNTGSbR4bkWjYawKcL4ZR
	 mjMpxKp959ishPVQZMfsuIDkFynI1FraPRNylm0LnsM54y62jXxxxnIlY14a52X7zY
	 DzfWg7/jG0nbLjwsoQ8B0nuzrV/GIDzUnzxYjhFX8wOmt6g2izmdIfx/ruVKdKmMDd
	 nXcgSRG42Y9kiZG1K9H4xBCuk0fEAVMkNSFYaxOisfpV8Y59L74p0VE/ugtu94R/qe
	 Ire28xXZg+oAg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfbXd-000000000Pw-35LO;
	Thu, 29 Feb 2024 09:13:21 +0100
Date: Thu, 29 Feb 2024 09:13:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] dt-bindings: spmi: clean up hisilicon binding
Message-ID: <ZeA8oQIE_Ab_ey2s@hovoldconsulting.com>
References: <20231130173757.13011-1-johan+linaro@kernel.org>
 <ZYG8jA64drRFL-SW@hovoldconsulting.com>
 <ZbNtWWy1QaV9MRL0@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbNtWWy1QaV9MRL0@hovoldconsulting.com>

Hi Stephen,

On Fri, Jan 26, 2024 at 09:29:14AM +0100, Johan Hovold wrote:
> On Tue, Dec 19, 2023 at 04:53:48PM +0100, Johan Hovold wrote:
> > On Thu, Nov 30, 2023 at 06:37:55PM +0100, Johan Hovold wrote:
> > > When reviewing the various SPMI PMIC bindings, I noticed that several
> > > examples were incorrect and misleading and could also use some cleanup.
> > > 
> > > This series addresses the related hisilicon SPMI controller binding.
> > 
> > > Johan Hovold (2):
> > >   dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding
> > >     references
> > >   dt-bindings: spmi: hisilicon,hisi-spmi-controller: clean up example
> > 
> > I noticed that these are not yet in linux-next so sending a reminder.
> 
> This series never made it into 6.8, but could you pick it up for 6.9?

It's now been three months since I posted this series. Could you please
pick it up for 6.9?

Johan

