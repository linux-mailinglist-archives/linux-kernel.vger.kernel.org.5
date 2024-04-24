Return-Path: <linux-kernel+bounces-156570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A78B04AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131AD281F60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE30158A0B;
	Wed, 24 Apr 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="GQ2ufe2w"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B0156C78;
	Wed, 24 Apr 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948326; cv=pass; b=UXB5j+hdB3aSkW7txd4CoxE0TbV0wyeKfgzkDYAUyhtvEfSNicOAdf6ina5Nbubnawk6bjaQyh4GQva/s9JeOQeavqqxjjMnrrJg40hRCTjkcBxKdH02BStPY/x4luWLt1SU/MeSt5pS+82MiFkb1FkgyUcCWGNxdZkrGT2Az10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948326; c=relaxed/simple;
	bh=DK2GOJTdeWn2NZS8rZg495zCEYYx/Seif5d3PdXPyu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqdmyjXIOR0MmSxuaAKYXwH8lPNdDxUhRSM/jzgSSTDlPIi9JkqXyXyONTakTe6xn2F1Gn4mZPvOoG9aEC+jM5/XZL75uR+41xu3b9kx2nyuGGNRmzVnABvNlaJie00MvSjq10gyewQG4cEdbpy+4jpmacYIvRn8RGKCcjdsICY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=GQ2ufe2w; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VPXcf0gttz49Pyl;
	Wed, 24 Apr 2024 11:45:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1713948322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ARC1X6nPXiS9BDAWi9yC8eI0rapb6qbuiAHzjCS0h60=;
	b=GQ2ufe2wZSmaSIgcb0DGfsmv084Pas1KH+gPiPxBx1bUCgkfKpG0Pmo6lSMfDWy+TYmmx9
	UyeDxCX/n8ELHsTmdycWG1x4kd3Kaz3P9gJGys2dQR/ZxwWdzy3rjuAiFZ/sKjOIZjr1ec
	d3mc/vhAVO6tNMvbtmfxWr3W0KkbHiry2V/pD+yiyhwXXcx1dyT5R0gK+wDdMs5MJjYjYo
	/wcU2aqHMSNDt6zfFwdFZJtq+WPeqyhUHvGw0SfWvFtxb+zxJLH0oW6xkBZCgiHlqQIe0t
	RWWvTObX/Shox7DfLEe7ayCoDLLXC9yITV+kLQ3XegzQi67ejh1wfVUOrzti3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1713948322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ARC1X6nPXiS9BDAWi9yC8eI0rapb6qbuiAHzjCS0h60=;
	b=vARlMAeU2/qNNW3KjGWvBUQXtOX24DqYA2xhLZCq0ZW6UQtRoojrOJMfaHjJaehEpzy0nu
	zMCtyFRTxCUFiSCvuZZkfBcXmfFQT/o2i3YMs12EDFExNdm1+0lfDopgZ2yEdxk7zEfRTm
	eG+dp8iMBqBTOJ/Noy67i9N9j7dH30GtAJQ3kkYSek1E9gWjHheDv1T20J9oxkcia9c1Nt
	AkLsuPOsO+XwjZVKk7aAAhAazQ5/ci0GZblXqyAXKnrkK0v9tXTuisvRuWpP8wiCcBeU9d
	wK/2/LIHzjUMt4tHKpzShCV9s8r/2m3LJ+0ngcKywEO+cAJYsstKKe4hOVGTQQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1713948322; a=rsa-sha256;
	cv=none;
	b=LfGVjMiUYE2LdAyTSBH4iq/tVmNqAuSj885mdc24Iy1uzjeMkskp/rhpcuR6nwEZwiJQM/
	kqtMTHPx//owdbZHcdvLQBLZaHXau4FDstts5EYYIy8cGJl9XA4MQahmTD8D3HCEXeCPWH
	TjIIz2WnI8988HEO2aZTsC6NLzu0FkB0NdCsU5rJ9Q0WcE8bQC0l+eNFzunOHL8rhXju+I
	XkZQE3rEms7SBzWeJRwpM2Kpbn4UtRD92N2xgBVWw4f4sETBRaHwLW9BvHt+YB4gapSuwL
	GHIdaFwWtXW6vUE80YwOlVuE852oE/avoVAsFGFgOeJ89Gjef7Xz5dxPziFK4Q==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C4436634C96;
	Wed, 24 Apr 2024 11:45:21 +0300 (EEST)
Date: Wed, 24 Apr 2024 08:45:21 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 4/4] media: i2c: add MAX96714 driver
Message-ID: <ZijGoWvyDhgpxl6X@valkosipuli.retiisi.eu>
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-5-julien.massot@collabora.com>
 <ZhkaR-83uciNFi2b@valkosipuli.retiisi.eu>
 <a70e3792-b938-4c20-840d-5dfa9bdc4b9c@collabora.com>
 <ZijDHtSa2vACgBjl@valkosipuli.retiisi.eu>
 <9075808c-783b-4af6-a92f-2a6d3f25d225@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9075808c-783b-4af6-a92f-2a6d3f25d225@collabora.com>

On Wed, Apr 24, 2024 at 10:42:11AM +0200, Julien Massot wrote:
> > > > > +	if (!priv->pattern) {
> > > > > +		if (!priv->rxport.source.sd) {
> > > > > +			ret = -ENODEV;
> > > > > +			goto err;
> > > > > +		}
> On enable streams the check is here :)
> Streaming is not possible without a remote serializer when pattern generator
> is disabled.

Ack, it was too early in the function. Thanks.

Looking forward for v7!

-- 
Sakari Ailus

