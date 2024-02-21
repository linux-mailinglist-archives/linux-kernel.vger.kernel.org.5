Return-Path: <linux-kernel+bounces-75352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBCB85E716
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D252E1F277C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5170985C56;
	Wed, 21 Feb 2024 19:17:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13785C47
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543022; cv=none; b=jkIdXLMjyu7NPHu5li6qmRvixKto+oRU/6vMIvmbldYZbf5mTMQniwp5sQW+Moa82MkOPtSs5RjlUlZd3AmgTRAUEwPw4XABFHapGur3qVnXgVXY9sb9jKzxULOrnAMEOGWEEmX2K8GNZ8yakLOA57v/4jkWCEKFep21uo+SmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543022; c=relaxed/simple;
	bh=IE63z3ZyfP0d1ADwPQNY79jObR07BnfkWooa51X+ADw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhK1Sf/TajEKeRhRanckRuZp/6Z2iJvoQ+olfW0VRKVVKmQYtBo+58xLscbrltZmTL2t1XpE9MduZmGeJFryfO9sY/kgpZ3OXMOF7s6xZPbAZcnwxCZZyyZHCl3Cp5bmcpTokr2IYwYT5gOpH9dfViHuLuBNzLA3tODY5dR1Mvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rcs5F-0001v9-Ie; Wed, 21 Feb 2024 20:16:45 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rcs5E-00260r-By; Wed, 21 Feb 2024 20:16:44 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rcs5E-001Nmv-0s;
	Wed, 21 Feb 2024 20:16:44 +0100
Date: Wed, 21 Feb 2024 20:16:44 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	denis.ciocca@st.com, linus.walleij@linaro.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Add IIS2MDC magnetometer
Message-ID: <20240221191644.5r3ylr5w3cnfnrzj@pengutronix.de>
References: <20240221175810.3581399-1-m.felsch@pengutronix.de>
 <20240221-undecided-union-4078db711693@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-undecided-union-4078db711693@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-02-21, Conor Dooley wrote:
> On Wed, Feb 21, 2024 at 06:58:10PM +0100, Marco Felsch wrote:
> > Add the iis2mdc magnetometer support which is equivalent to the lis2mdl.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > index fff7e3d83a02..ee593c8bbb65 100644
> > --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > @@ -64,6 +64,7 @@ properties:
> >            - st,lsm9ds0-gyro
> >        - description: STMicroelectronics Magnetometers
> >          enum:
> > +          - st,iis2mdc
> 
> Without a fallback compatible to the equivilent device, how does a
> driver bind to this device?

I skimed the datasheets and the driver already handles this binding
exactly the same as the st,lis2mdl, so my assumption is they do match.

Why do I you think we need a fallback compatible here?

Regards,
  Marco

> 
> Cheers,
> Conor.
> 
> >            - st,lis2mdl
> >            - st,lis3mdl-magn
> >            - st,lsm303agr-magn
> > -- 
> > 2.39.2
> > 



