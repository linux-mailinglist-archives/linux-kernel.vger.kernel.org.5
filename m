Return-Path: <linux-kernel+bounces-159614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9BF8B310E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5012830C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ACB13B591;
	Fri, 26 Apr 2024 07:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kSwFZtrb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E74113A898;
	Fri, 26 Apr 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115258; cv=none; b=Gp71nvOz3U+81FkZHrOYG9tfwWB58IRt+38xiS1iefD7X3NJMPs2RKs8cDGejy/p/Db+2Qk9smf5oG07R6K5QZg7d+PdgwTbNqWKVZPphmlxA/SUyxAp3d1664haPfP4wkd+wWlUzR91BO30hIrMSRLieSZ6LpRC4jP5Pa5wemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115258; c=relaxed/simple;
	bh=NEBKdcFsswo3hwvjczlnLZCT7OYcGHc/4aLeOdQ+4vw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8g/czoaqWNgW7jwop53IMlTBg0oPhbyL/hk0whEaaM+RQyqlBWjGkB7Ltev2b0CFDdRSSvzW4IornQVw9K+gVynmRXnZ+FMQ11UpxXrT7Aac+KT6y8Hl56Hq37ltPPzMS1nUc6wL76Zee2dL6EaUGK2+513YkFf7nPNREwAeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kSwFZtrb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714115256; x=1745651256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEBKdcFsswo3hwvjczlnLZCT7OYcGHc/4aLeOdQ+4vw=;
  b=kSwFZtrbaKdArdcT0huRhGAJEMAHnafc5ZS6oZSLCy8b9SBCuA8l5HcE
   NPuvFqRh2dXZfKXifCMlkXI0VI3RG0fYY3DlAsbH2wNTikTWdgfxozdVz
   PSt+4hC7h4b8SRuOG3XOFzXP/O7r4iqVpb8LLuZOcE5O8pElz8MnEPEf4
   dm2XbN7GnCBh934jbbEZymq4S2i+ytLw38RpQ4kFAw0UZDoyw2jWGTf/j
   LBP6F2mq3PJPvwRNySdcOzkzdxTNsrp6xsrGMxGaexa0oeZt9fNjLVpQq
   lbhUkI3hAijJTGHrvOGCLZxmsfeJyPRMn9vENcOXeXY9tVda8Qzq56A52
   A==;
X-CSE-ConnectionGUID: FQK/T8wqQH6Aah4DVsLuQw==
X-CSE-MsgGUID: IHFoSuOBRYSvjKL3Q/TCJA==
X-IronPort-AV: E=Sophos;i="6.07,231,1708412400"; 
   d="scan'208";a="24859171"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2024 00:07:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 00:07:24 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 00:07:24 -0700
Date: Fri, 26 Apr 2024 09:07:23 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for PTP_PF_EXTTS
 for lan8814
Message-ID: <20240426070723.kcwowvv56oojqdm2@DEN-DL-M31836.microchip.com>
References: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
 <20240425184457.70d4748e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240425184457.70d4748e@kernel.org>

The 04/25/2024 18:44, Jakub Kicinski wrote:
> 
> On Tue, 23 Apr 2024 21:57:32 +0200 Horatiu Vultur wrote:
> > Where the configuration was the following:
> > ---
> > [global]
> > ts2phc.pin_index  3
> >
> > [eth0]
> > ---
> 
> You'll have to resend, sorry, the --- lines are "cut-off markers" for
> git-am. So your commit message will get mangled. Either replace them or
> indent the config sample by a couple of spaces, that does the trick.

That is true. I will indent the config sample with some spaces.
Thanks.

> --
> pw-bot: cr

-- 
/Horatiu

