Return-Path: <linux-kernel+bounces-160360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD08B3C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D0FB24624
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABB152DE6;
	Fri, 26 Apr 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="TyBbXLeV"
Received: from smtpcmd0642.aruba.it (smtpcmd0642.aruba.it [62.149.156.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B614EC5F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147959; cv=none; b=Ut9UycpD/NAYZspDuqyn9nkds5EFunXQn/WkE5wAACcgR9rKDYQTo0Fz2BnSFaw9QHCzSnbO/g6Tf/0JQ568zkZDO+cgshJcC+O1D5bOgl1w8h1+DrI5x1buqlLr+UCy/F1OY71UVXPtKkzhGPcAwjRWT/54lchJqhAgqPh+SIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147959; c=relaxed/simple;
	bh=jhsZSBiMKwYAWJvtb86GH3AmRYcccKtM8oI1H2q5Mxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwyYURuJFll28fHH0G8li1Urx1UHIIIRoYq8naKhMzYbHmMo76ZpWf2cH72Mn483gV1KuIS4F01ndhvQGQnx64k7uemrwwb0oBm+bT4z6dOnL3D1wTbHptCKXLMjPtwbYIwqhQl2Mw0j6C3yMd9Biwz5ncZthYQOYF4taxQ8TS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=TyBbXLeV; arc=none smtp.client-ip=62.149.156.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.23.148])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 0O8hsyfaqmFXq0O8isDdzo; Fri, 26 Apr 2024 18:09:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714147772; bh=jhsZSBiMKwYAWJvtb86GH3AmRYcccKtM8oI1H2q5Mxg=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=TyBbXLeVO4NSelIMYg8B0D4zhfEbkIVDJRb8csqq2/0ypG1zZ0q1WoiPiZYyaaZdI
	 iBA7WEH8NQbNGPvvp+45KgrmgjilIm4zmp6bPbFFSok8qv449kq05xwL4nET6izolA
	 geQx0AqjoowiKFpaZuqezpTs2wIPvRZXO8pk+EB6MfSBuk+q5sebiFiFWrkeGY0YhB
	 X+Dw/2uVmokEgwrB+ixBofYdLW/5CGMoDKbLGC/MBngPFjHzaCokMF31IU2aPgb+1C
	 acF5+XZG6uwaC9e3THkEMeDgsgAqtv+e5Euztijij+Azc0tYVyrEsjw/quyGGNWB7p
	 LgBNE2P2y+5uQ==
Date: Fri, 26 Apr 2024 18:09:30 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
Message-ID: <ZivRugyk+4OAHI0j@engicam>
References: <20240426152730.9806-1-fabio.aiuto@engicam.com>
 <20240426152730.9806-4-fabio.aiuto@engicam.com>
 <CAOMZO5D=Ens3f-FnjEf8SDSTCChdzKW3m7LH+t6y6qUtWsSRZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5D=Ens3f-FnjEf8SDSTCChdzKW3m7LH+t6y6qUtWsSRZg@mail.gmail.com>
X-CMAE-Envelope: MS4xfBD+W35qTiMiVmWjSFm0w+UL1B78yGDDLn68YbLruqgzeyWeshTu8pHsDyyf+IemW7ochMJI7AZAs+th6v7Z2tsebqZtg1BDCOR/4J7KiRqy/sBWrQx5
 5WW5K7tGEag5+Pm3UEumuzxwlNoxMr2NQZN5iTPwDitpfKf0Yaiz5WdHjruL159mbF9bM11DbiaBele5yT9Y3xlcIacEEmOX8vbN4xwlvyw12LlRZn/0r0De
 Gb9uwatgkiIPr86ncsE0JE9Q5kZJuYfyHjKFP6ImBxPFi6yMtSm4LDm/6G7GejMmu3wX7sm1v4Ce4FQ94X3GAARKCTa3EeiDnM1NQhcQhB+g3tmC7h3ymHtf
 5kRNz8mp6/CnpZkKb7HOxUJF+DmpyqmeSNb7vGqA7+RKBmS/4J3oTVchhixDUR/zsz5BECRQaVWHiUxm6oGUO1EO/Hze3wQsAsAQgp5b1STjD452XtNoQXb3
 gt2XSXGLqjN1BweUJXVGeGdFYAv6lwdkeRqO+M+VpUK3E+Je+E7qVVx9ayIxQflKjaJAnCD9zdadwVS1NvbTp6tEnKAfAsnfoQSZfK1Mof1B5PbTssmutOmL
 UZT/6Lt1DH6PTM3v5Yv/2nBitcDTSAs/ny2UhzyinB60iDFleLULBFyfN/q9hvchf0t2ch/mgTMOSGZvngPKvkLV

Dear Fabio,

Il Fri, Apr 26, 2024 at 12:56:11PM -0300, Fabio Estevam ha scritto:
> Hi Fabio,
> 
> On Fri, Apr 26, 2024 at 12:31 PM Fabio Aiuto <fabio.aiuto@engicam.com> wrote:
> 
> > +&usdhc3 { /* WiFi */
> > +       #address-cells = <1>;
> > +       #size-cells = <0>;
> > +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +       pinctrl-0 = <&pinctrl_usdhc3>;
> > +       pinctrl-1 = <&pinctrl_usdhc3>;
> > +       pinctrl-2 = <&pinctrl_usdhc3>;
> > +       mmc-pwrseq = <&usdhc3_pwrseq>;
> > +       bus-width = <4>;
> > +       no-1-8-v;
> > +       non-removable;
> > +       max-frequency = <25000000>;
> 
> Is this 25MHz limitation correct?

I will let you know next week,
thanks for your time spent reviewing,

kr,

fabio

