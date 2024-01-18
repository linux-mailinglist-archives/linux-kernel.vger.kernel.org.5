Return-Path: <linux-kernel+bounces-30272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A77831C74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D341F2A99B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714262C1A2;
	Thu, 18 Jan 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M8GFV3eE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D82C198;
	Thu, 18 Jan 2024 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591457; cv=none; b=ESTozI7CidukO1zRRMJB1JZf7aTBAQj+73MKi53EGA6Yd0QGR4LuP0YdbMF8NceUYphPTfYXHadtDSdncIRcuSVdEXHcvdTi9BcIyHk0UCmYS6aT4dQ3+Vbhbyj9E7HN1hJT9xhpA/bUyOl7aiMndJwPo2GsXIVYkN9wgBHf67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591457; c=relaxed/simple;
	bh=EpEz591QpZ/Hd3izu39M5yvfIQZ2SywK/sJKu7P4pXg=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rUl07/d9LtNZAEIScxZCB8W/qnFkvaN/VHpHvqwsoSp87JLEP8MXKxQnMClrfaY+DS3dvZrDFfK6xA7KTcP4xS03oTg74brUx49nCxEqB1iUCQnpAqszDhYZ/bCAFdJD+KYBtLePZCCBZtWq+lr8vSElYj8SQc75Jc2CLxSlANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M8GFV3eE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705591455; x=1737127455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EpEz591QpZ/Hd3izu39M5yvfIQZ2SywK/sJKu7P4pXg=;
  b=M8GFV3eEURYKeNF+OpBQr8O6Oi+JOLg1+vCbOsuoNIxiFOiCMqt4sqLb
   YtHrSW5nx/4euGJrippDeD8+LfWTiRsmDnvW9npk6a9OyAtzl1a2R+F2t
   Yf1Ri5jvCa3ornRTNuadRt0GYUWFTD64oQPThEMDrFOrszX3HbeWUX/Be
   q2l+5/X/b55fshUhvrb8PMpK0j5YxGtuF48UE4FLGBfOH8YOTzGoXEOSD
   7UDgQbfS78p7u/Nll7nQdmCZq2lgftwj6qUEV1XAXg9htwNw4uJqVfWvm
   K+gbi8nO1xfGx904Z0+BoM4PhA5RglrONI04/dJBh4+icPo2oC0Jsnvkm
   w==;
X-CSE-ConnectionGUID: Al980YKDS2y1LYrm50ovYw==
X-CSE-MsgGUID: 2tV3QeeCQZ2Ql97vyE0pug==
X-IronPort-AV: E=Sophos;i="6.05,203,1701154800"; 
   d="scan'208";a="14943914"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2024 08:24:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 08:23:54 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Jan 2024 08:23:54 -0700
Date: Thu, 18 Jan 2024 16:23:53 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <Divya.Koppera@microchip.com>,
	<maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 2/2] net: micrel: Fix set/get PHC time for lan8814
Message-ID: <20240118152353.syk3v7kgf3mutqpp@DEN-DL-M31836.microchip.com>
References: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
 <20240118085916.1204354-3-horatiu.vultur@microchip.com>
 <6fa37dfd-3c92-4842-9785-1b17bbbedc9d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <6fa37dfd-3c92-4842-9785-1b17bbbedc9d@lunn.ch>

The 01/18/2024 14:52, Andrew Lunn wrote:

Hi Andrew,

> 
> On Thu, Jan 18, 2024 at 09:59:16AM +0100, Horatiu Vultur wrote:
> > When setting or getting PHC time, the higher bits of the second time (>32
> > bits) they were ignored. Meaning that setting some time in the future like
> > year 2150, it was failing to set this.
> 
> Stable rules say:
> 
> It must either fix a real bug that bothers people...
> 
> Do we have users of this device in 2150?

No, and it is not like a customer raise this issue because they have
some special cases. It was me who discover it by accident and I
found it annoying not being able to do something that is that simple.
I mean, I just want to set the time and then be able to read it back.

> 
> Maybe submit this for net-next?

Anyway, I don't have strong feelings about this, if it goes to net or
net-next, I just want to fix this at some point :)

> 
>       Andrew

-- 
/Horatiu

