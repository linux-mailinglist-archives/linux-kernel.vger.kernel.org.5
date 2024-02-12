Return-Path: <linux-kernel+bounces-61579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87B18513DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A72281A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393E3A1A2;
	Mon, 12 Feb 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0potI20j"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A939FF4;
	Mon, 12 Feb 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742454; cv=none; b=sYqC18Ec/+CFCRGgItK9iktdNdRQ00iDydLlLcaGmEEMFlSCIIHEFRGFjcXRkOYnU+goIJMBFKlLi34qDjWTrSBsA7x6zQX1gurd0J5PFf4/AtRZxmyvOFqEWY3NZXFAN9wiAI2z+9JLdJ8LN+HfVBb6fpaba8tuhkCQEnftUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742454; c=relaxed/simple;
	bh=oE/IMGqKpiy3HjHmRhnL54QXNMGICW3K60ABAhZCIsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScmcEN/YFamZ+OSQnHAlAYvZu62A7AFjidbCKY57ZTPU43e/+qVlpcpNPEi25E56mfD2eXvp0wSg/WIGHpxXoGYwmWzM3EKRMKo+FLvyYlD1DtzYL8DqXHHB63IXoAtZHKxPBBd55fgpGudgISFlKtH1bp5CVRVg5kUCTq/1H0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0potI20j; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 68C97206F0;
	Mon, 12 Feb 2024 13:54:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707742446;
	bh=mKFrr/tv7+577+b46UKYGQ31Twn6Ut5p48YTAr9iamE=; h=From:To:Subject;
	b=0potI20jbbs/o4+fJug8vPLTUfzapnQJ4nVhpNhztYWaFh3GhvDkKJD9M1iFNl2tO
	 p7f16NfeXkDLyZpOryG4NO5c/eQ+lChhMDxtgKZuOVeowBx9eKndzsR0auEqUCAea0
	 9rRJWDhghwEA/ASVRxWR+r/ms7BoZOhbJowNdOlvL4e+D1xVjsbFdAW+wES0mkZLDh
	 9uesKqXDDxhMt+jFjDcmTjawsjcjsxBdLLmyNyThqR0tAIr0j7hanyVxIfKZ9cJuwP
	 y/pKTjkWJzwsE1nmndT1kFGfLyHfjJ0Bhz4v9l5QDMvFsIGBDo2z1HVl27brM0dXez
	 j61vqYrNY189A==
Date: Mon, 12 Feb 2024 13:54:02 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Sjoerd Simons <sjoerd@collabora.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Bin Liu [EP]" <b-liu@ti.com>,
	"Gunasekaran, Ravi" <r-gunasekaran@ti.com>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
Message-ID: <20240212125402.GA5043@francesco-nb>
References: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
 <2629cd30-23aa-4f03-8452-ae13297fd6b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2629cd30-23aa-4f03-8452-ae13297fd6b6@kernel.org>

Hello Roger,

On Mon, Feb 12, 2024 at 02:13:56PM +0200, Roger Quadros wrote:
> On 09/02/2024 15:02, Andrejs Cainikovs wrote:
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > index 464b7565d085..c49fbce5cb70 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> > @@ -663,6 +665,8 @@ usb1: usb@31100000 {
> >  			interrupt-names = "host", "peripheral";
> >  			maximum-speed = "high-speed";
> >  			dr_mode = "otg";
> > +			snps,usb2-gadget-lpm-disable;
> > +			snps,usb2-lpm-disable;
> 
> Instead of this could you please check if this series fixes the issue for you?
> https://lore.kernel.org/all/20240205141221.56076-1-rogerq@kernel.org/

Isn't this change correct despite whatever the test results on that
change are going to be? The manual is pretty adamant on LPM not being
supported by the AM62 SoC.

Francesco


