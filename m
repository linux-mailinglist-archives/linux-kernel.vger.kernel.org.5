Return-Path: <linux-kernel+bounces-63882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B98535EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E781C21AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C15FDBE;
	Tue, 13 Feb 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KfxO08AT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C805DF29;
	Tue, 13 Feb 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841388; cv=none; b=UvnHzZcfMXoQjVdm+CC+/WTxvTGa8cjF1RdtLTcGVYlHd0LYAmgtfuIDRLghXpq35a0ByLXqHyFrpuvm9KkvicAyScJYFom/JF0dIJisA55yiUnu+hlbC0+0CcAHwbvbR+O/jGv88YPwMF8iGtGapZ6aS77C48fhVviQdGLpzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841388; c=relaxed/simple;
	bh=bW37SueZhAPAkjInxJW7AsJifsXh4YgAmuBRJnvDcBI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A33e5pHWrqxKUQAtHfQ3rrZuD5ziF59rpxtuI43XiwWBwdvw07Gp41t0op1ghukwK0QHaCyK5j5EJb2aqRrGDV/IlAdd38NwCmBNDDNmKf50OlYHe+t3K6J0/5nDw7IxysXVnNPajh57jORxYzF3wrNalBJNTPaOhmcCjcI2sII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KfxO08AT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707841386; x=1739377386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bW37SueZhAPAkjInxJW7AsJifsXh4YgAmuBRJnvDcBI=;
  b=KfxO08AT1DGDL+k/gf6PzXWoUGIRTUkJU5KNOgxTmnZTBi12aYnmq8WK
   D6bczb8Z47XreiUlhabgm8vBPLze63eKbzL9Rl0nw0heo0UEeipIOcRYr
   UhC99M9owUBINV6o0n9RwvB8mXMw0bC8kOCgts2yhj9Op/vdi0djAf+B8
   dD+JT6sRfBImPFVWmfhOeNFJI8V3MPAkE5J69TbD+Gb2aDqzrQRxHPJYV
   vWaM//L5B8fi5vLQm/9+V0lvnXLuzPMAkgirvvOka2dczXziMMg0nG8sG
   w6jABJZuwGSLHfw3AlxbNtlFznl9+RKe4QvQBk0vH0kfYO5/OcUX7LjN1
   w==;
X-CSE-ConnectionGUID: GsRD6le2RpCGJQ3cWig+6g==
X-CSE-MsgGUID: WRcbYWLxR+SSapVj+Y6nnA==
X-IronPort-AV: E=Sophos;i="6.06,157,1705388400"; 
   d="scan'208";a="183445267"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2024 09:23:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 09:23:01 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 09:22:59 -0700
Date: Tue, 13 Feb 2024 16:22:58 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<u.kleine-koenig@pengutronix.de>, <rmk+kernel@armlinux.org.uk>,
	<vladimir.oltean@nxp.com>, <jacob.e.keller@intel.com>,
	<yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sparx5: Add spinlock for frame
 transmission from CPU
Message-ID: <20240213162258.ajicpzeevveajrz6@DEN-DL-M70577>
References: <20240213121705.4070598-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213121705.4070598-1-horatiu.vultur@microchip.com>

> Both registers used when doing manual injection or fdma injection are
> shared between all the net devices of the switch. It was noticed that
> when having two process which each of them trying to inject frames on
> different ethernet ports, that the HW started to behave strange, by
> sending out more frames then expected. When doing fdma injection it is
> required to set the frame in the DCB and then make sure that the next
> pointer of the last DCB is invalid. But because there is no locks for
> this, then easily this pointer between the DCB can be broken and then it
> would create a loop of DCBs. And that means that the HW will
> continuously transmit these frames in a loop. Until the SW will break
> this loop.
> Therefore to fix this issue, add a spin lock for when accessing the
> registers for manual or fdma injection.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


