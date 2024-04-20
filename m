Return-Path: <linux-kernel+bounces-152226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EED8ABAFC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F01F21D50
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996BA1805A;
	Sat, 20 Apr 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqZmho2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D7EAE5;
	Sat, 20 Apr 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713608640; cv=none; b=XC3A1L1wYojejMUZiMraqqXkaQ3vqB5bUBU+2wJDB17xv8cNvgqUiDn6AYGPS8Uv4kyLx/RC3okHniomh5TLf5j2mu/MClk6EECk4G57m5VlmPd2h7aXd4saG257T1OWxcnAYrMbnsGZfA3WWn0rNtmI5yOzJotyT5MYHGII/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713608640; c=relaxed/simple;
	bh=O706/Wu4EJCalwCyUXbD1345T/rl3q5r1/D58up9X3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYGUMdJTFeD0Z9mkULHsTpHYYvK+a1ZAbcL0xOa6V4njq1VYi8QdMajPfwz+cHtf9MLPFSZfPG3PZMI8syiaXr2vl9BIODVvdvbO4c13elyt/AfEynE3OI1WF3t/9jxLKlZhyghTsbTEYDnTeczzYWtXrXpSlNilgsLrUiyAG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqZmho2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B0C072AA;
	Sat, 20 Apr 2024 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713608640;
	bh=O706/Wu4EJCalwCyUXbD1345T/rl3q5r1/D58up9X3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqZmho2hVR3+nk4Rwe9/XpcaYokk6u0MO/cuJ7PXO3zV6mjqLCk2OVRrhQJVJeBgu
	 tc+yo6SC2sRnVRLe0UH8MfhGZzAD8OfPiql2UQ39x28ZW+TgENG1Sx3M+Ssg9fnUki
	 0nhLD16UBs7KFCFoH1tmSVLT7M5lJ+l7a0X0ka4OHLj6dgfDVUWu8Qw1WaMsg5gtqN
	 vIkEfDdBc479mc2mHEK8Vjh84ggvFa8pfYb2rZkC/Z5yDcQGqQR/MIMdsvvt6XexLf
	 SMeOMPkK1gZcJv4fPKIq/UptGIYtVrGqGiNzn5yKUO3gb8gBtDH9mmKqw2Ctqsfpv6
	 fYksbCfgB4r4A==
Date: Sat, 20 Apr 2024 11:23:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 3/4] iio: ABI: add ABI file for the LTC2672 DAC
Message-ID: <20240420112347.6bd1daa4@jic23-huawei>
In-Reply-To: <PH0PR03MB7141B4F4DBF3D77F7384B555F9082@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240412032102.136071-1-kimseer.paller@analog.com>
	<20240412032102.136071-4-kimseer.paller@analog.com>
	<20240413162640.77c6fc56@jic23-huawei>
	<PH0PR03MB7141B4F4DBF3D77F7384B555F9082@PH0PR03MB7141.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 14:18:23 +0000
"Paller, Kim Seer" <KimSeer.Paller@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, April 13, 2024 11:27 PM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring
> > <robh@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>;
> > Conor Dooley <conor+dt@kernel.org>; Liam Girdwood
> > <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; David Lechner
> > <dlechner@baylibre.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH 3/4] iio: ABI: add ABI file for the LTC2672 DAC
> > 
> > [External]
> > 
> > On Fri, 12 Apr 2024 11:21:01 +0800
> > Kim Seer Paller <kimseer.paller@analog.com> wrote:
> >   
> > > Define the sysfs interface for toggle capable channels.
> > >
> > > Toggle enabled channels will have:
> > >
> > >  * out_currentY_toggle_en
> > >  * out_currentY_raw0
> > >  * out_currentY_raw1
> > >  * out_currentY_symbol
> > >
> > > The common interface present in all channels is:
> > >
> > >  * out_currentY_raw (not present in toggle enabled channels)
> > >  * out_currentY_raw_available
> > >  * out_currentY_powerdown
> > >  * out_currentY_scale
> > >  * out_currentY_offset
> > >
> > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-dac-ltc2672     | 30 +++++++++++++++++++  
> > 
> > You can only have per device ABI defined if that is the only user
> > of the ABI.  That may actually be true here but given I've asked you to
> > generalize
> > the voltage equivalent, I think we've shown this is general enough that the
> > current
> > version should also be raised to sysfs-bus-iio-dac  
> 
> I'm still getting familiar with ABI documentation. If I understand correctly,
> generalizing the documentation to cover both parts would also mean we remove
> the overlapping sections from the ltc2688 ABI. Is that the correct approach?
> 
> 

Yes.  To test this build the html docs. IIRC that will complain about duplicate
ABI definitions.  I'm sure there is a way to test just ABI docs build but
I've never really looked into it.

Jonathan

