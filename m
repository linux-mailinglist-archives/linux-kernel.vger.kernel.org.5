Return-Path: <linux-kernel+bounces-30894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A88325A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE402886CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED920B04;
	Fri, 19 Jan 2024 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A+kKV2gb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B328DA1;
	Fri, 19 Jan 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652488; cv=none; b=E6qgOiQ8HAPvQ4TK1EpTRmmkA5HwUKpmMzD7r2pYnrYBGC1/K/yrRGVgJ5y5onewdJM1Hh2ZHuFWpAZ2U2yXEcNaAuHIB0CXWxBqpuqSFHY+rqLOY0V+TMMFj+uTGLvGVs/GrRlNV4OgD0Uqq34YoFTFDx9m85DHNRcGwGTI85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652488; c=relaxed/simple;
	bh=r0lBl+LKAGRixf+QLXYXEETCshZa5OordGtzi06BNuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb+IPQww8wHraOIv2jJ8M6eN21zn6YGXUO2r6GCQC2OlGcdTsfmz7FVzqZiJxVxMEDspU/Vz5JUumDzTsfd8QRsGGDB/YgaxnWISp7EbtIy08PQBM2FHVGn05gRjLN1urT5hoBTAzYJHvWhIdMJ+fhG/QhR79QEftlWpAiGFw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A+kKV2gb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705652486; x=1737188486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r0lBl+LKAGRixf+QLXYXEETCshZa5OordGtzi06BNuI=;
  b=A+kKV2gb24Sz6ElKPaW1TXisavCCNgLZn0iHgjfonXp4lAdAegig9b1I
   HRviOcp2CgvJIrDTaqSIVUNRxAwPQItofz+bOWrXwoLlDSpO1ER3pnU0/
   jnertpwXzxThR5m4P9eamSqBKsg5VgSzG6i8u6FN4NPAGX+egZpoiotCL
   o9NUoZtXJulf2cFgvQDtt5sNfj7aMKAS0EzM/MaPXmBo65IhWwQDR8H+N
   RpNp8eosju3pu3Wt/HmjHyNqMqd7Li4/qFApXAJzODEorEsXC9oo5XazG
   7St8pur1VHMls68oWZW7RMMcwLSTaEKFjOUTxhk8FlkrB4RfSmwYhb9ag
   A==;
X-CSE-ConnectionGUID: Rf3V0rH7R+qbZwHMlwiFtQ==
X-CSE-MsgGUID: NJsGkk5xTOCxx0mUwLX5jw==
X-IronPort-AV: E=Sophos;i="6.05,204,1701154800"; 
   d="scan'208";a="245708547"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2024 01:21:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 01:21:05 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jan 2024 01:21:04 -0700
Date: Fri, 19 Jan 2024 09:21:03 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <Divya.Koppera@microchip.com>,
	<maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 2/2] net: micrel: Fix set/get PHC time for lan8814
Message-ID: <20240119082103.edy647tbf2akokjy@DEN-DL-M31836.microchip.com>
References: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
 <20240118085916.1204354-3-horatiu.vultur@microchip.com>
 <6fa37dfd-3c92-4842-9785-1b17bbbedc9d@lunn.ch>
 <20240118152353.syk3v7kgf3mutqpp@DEN-DL-M31836.microchip.com>
 <139fe4c1-6a3e-4ef3-a178-ebbe09652966@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <139fe4c1-6a3e-4ef3-a178-ebbe09652966@lunn.ch>

The 01/18/2024 18:00, Andrew Lunn wrote:
> 
> > > Maybe submit this for net-next?
> >
> > Anyway, I don't have strong feelings about this, if it goes to net or
> > net-next, I just want to fix this at some point :)
> 
> Please submit to net-next. I think the ML bot which picks out patches
> to backport is likely to see the work Fix in the subject and decided
> to backport it anyway. But its not our problem if the bot breaks the
> stable rules.

Yes, I will do that.

> 
> Is there any danger of regressions? Could the higher word actually
> have a value for some reason today, which is being ignored. Would this
> change then jump the time forward?

I am not seeing any danger of regressions.
By default the higher word has a value of 0, and doesn't have any
special functionality to jump forward or backwards. It just contains
upper 16 bits of the second [47:32].
I have seen only on register PTP_LTC_STEP_ADJ_HI that the most significant
bit can signify if to jump forward or backwards.

> 
>        Andrew

-- 
/Horatiu

