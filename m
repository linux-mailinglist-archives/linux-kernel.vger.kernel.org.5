Return-Path: <linux-kernel+bounces-155935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF18AF9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6853AB2AFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BAB14830D;
	Tue, 23 Apr 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="jPxOIJhR"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9886145B06;
	Tue, 23 Apr 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908615; cv=pass; b=fv/asxhwogFTgO0Q9ypeDdsQyeDR5/HxDz1jrTJfwyJ7Csr2c1bemX/ShdixGlknkFCZWzBQS82+/ZShtHK6gRiOKx/9vbD0L9vrklWzW+tXG33wLiS99LskqNomL7aqyTq+66gL8AveWncZTc3YaxHXRHI3+M4lvw6Iewqd6hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908615; c=relaxed/simple;
	bh=lZmTtkNLtHoyI684P55R2eGce23W5SDipF7n66IgUMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaAwImYBo/PCo+KiODxQZluXTjnAbOGAYiR3isPDkzOcgo0HyssV2AI7ApuJqAjTbJV5zRFIqdt5tjSxruRsOPhTM1IjzH29vH5KgPYgrNFW8CAsiWffZUbFG44G0ipIZZwtf6fNgTpfT0Y5fi0MKbPGcZ7p6nj1HLAjV4c6Opo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=jPxOIJhR; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VPFwq32vVz49Q05;
	Wed, 24 Apr 2024 00:43:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1713908604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLqMEJxoaWFasN2MCsFBWnfqPLspdvp7bGhu9Pbap4g=;
	b=jPxOIJhRkaSVTPHtwmPjyp+Q5vajhxCS9fRVxhQJWQYQDNWto33afXvHlu8/mZzHm01qiG
	uhGNt2j7n+LcINKPE9PbmXvtZv2ddgxFS6psywd1rocS8VJW5DsWPT3U3whSIQgqKv74f3
	/vVTflu0zQcqLPwjnFphJRa+fk/OELriVgs01OSESbY+RzZ0lM4EsWxZjVi6vJZBJd/PRY
	C4Ve0wfBmSuZcuYfS7mEmwRixDGxGwhIRzRcJ7Lf6Bi7UPeVluSTXYjJjvuaIS5SZLMRmJ
	Q7ylQDyNX9dgr0sZIovstxKvF0aKavJ6gFGhVsS4Ryj5BlinaJrNTt1t9W9lKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1713908604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLqMEJxoaWFasN2MCsFBWnfqPLspdvp7bGhu9Pbap4g=;
	b=M6zUs/EfUIPYgvaq1nPxdq+0GrLsk1Y2xjmDep+Ag7vSNnFdg+QiuIzWeGo9Jv7oSFEW8r
	KI9j7cqu0mobbSetMMnjsujDmw4oLrvR85QlB1U11XbrhjpFdIwY8rCa4jC3H1bwjsurHu
	gG4MCEsmsriJXk2q2RwJxneRdpCnuwSatEnJkL+U8kzdTwFmOG4LHVb+bvvsJs1AEIo7f3
	1R6i0F/wFDNuUDfBlqIB5QmCTLG44LgETeljEGk9bnrjLnD910h7IOAoTrbDKfdgoLpRJy
	mFvwlgENBRoucLCUN0weT8yE93P6pVK+EYB8yr1m4W1i6rd4RBp4J7YIxzlS5A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1713908604; a=rsa-sha256;
	cv=none;
	b=BytMvg5F1jRL6Ol5e3nsjLiTikopKfbBfes1/GXjWaBynT+Ruq1M7sv3Nwl9MLpzLnv/6U
	QfdLODRu8NQaBBSegVFN5IpE53EK1m8rfxFuo20YrnhJWyjPKrt075eH4hc4Sao7QwuFtn
	FLaRaNCUpKnUYECuVqrY8e8oc3QmbKBvCzsuMUSb7I3VduiYELdm1FzXBvwVhzQ7y1bkJ4
	xLsH9H89nNRPTEaYHLvmUu6kFABHaiynnB5ezrTP7qKh2CP9KuntykpufPD2Zvsmo8a3NI
	Rg3H7AUG9CuwjwYRi0FWM/bWgOEIojqQ7sXDD4lTyGz5LX/lNy60sZM8NB40fg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 14EE2634C96;
	Wed, 24 Apr 2024 00:43:23 +0300 (EEST)
Date: Tue, 23 Apr 2024 21:43:22 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: media: add Maxim MAX96717 GMSL2
 Serializer
Message-ID: <Zigrei9JB9L2XUEO@valkosipuli.retiisi.eu>
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-2-julien.massot@collabora.com>
 <ZhkWqEAN4RozmPlT@valkosipuli.retiisi.eu>
 <f5a178b9-2eeb-4737-a051-b43cde9fae20@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a178b9-2eeb-4737-a051-b43cde9fae20@collabora.com>

Hi Julien,

On Tue, Apr 23, 2024 at 03:36:39PM +0200, Julien Massot wrote:
> > > +            properties:
> > > +              data-lanes:
> > > +                minItems: 1
> > > +                maxItems: 4
> > > +
> > > +              lane-polarities:
> > > +                minItems: 1
> > > +                maxItems: 5
> > > +
> > > +              bus-type:
> > > +                enum:
> > > +                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
> > > +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
> > 
> > Now that you have C-PHY here, does the hardware support data line order
> > mapping? Just wondering. The bindings can be added without that and support
> > added later on---that's what the video-interfaces.yaml is currently
> > missing.
> > 
> > lane-polarities is only valid for D-PHY. What about the data-lanes, the
> > maximum is probably different for C-PHY?
> My mistake here; MAX96717 doesn't support C-PHY; I think I was confused by
> some of the schemas implying a deserializer with C-PHY support.
> I will drop the bus-type property in v7.

Ack, thanks!

-- 
Sakari Ailus

