Return-Path: <linux-kernel+bounces-64860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E38543E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FB91C22A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E48F125AD;
	Wed, 14 Feb 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2Hi3sxu3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE04125A2;
	Wed, 14 Feb 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898510; cv=none; b=i2vkcknKD9iR60iOzVkJa64iS6XdnQmBvrLRs09cLMKb44m8tx8gqGk+7ydXPq5wzzs5Hr707VVbNEW1y3q5krn99xY7Ui8T2XI5uhAZfzI74JsRR8SwHCq4X7AddIPEOIG2/9PMfEX4Jxk0CQbN80xKxrN6PjDyl5xZMcHIKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898510; c=relaxed/simple;
	bh=R1qEZaJZqEahESp0vUMVsznWrk1nhHpzObybxfL6gjg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTD6m+Vyo1pA7hRS5AAgsrzpiv8PQixEG1QOCsEo4SK3sTjpG+bS126HGIFBcLVuKldVCJWiqOYjqDwMQceS9BF4q2NSc0njSZe0H0ZzjwIDz0Q1wPtPHzomrn0zZPO2+c+6tczXDex5e8g2yiGVVC4gZ4aj5pI0qQr0ZEO50aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2Hi3sxu3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707898510; x=1739434510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1qEZaJZqEahESp0vUMVsznWrk1nhHpzObybxfL6gjg=;
  b=2Hi3sxu3KM/y18BIdJtYyMkzkWnI6/rToE2SIV3Skh4t3A2zZ3evc9Ms
   fUTirA42tG56e/0GPdWeS3W56LK6/gymUPgf5aEd8KZemmh66Tjkj44xK
   w+GaOz1nhmypbpvHYkb2sTg32/Bq460PBgfwPJr1BXutzLl5qGTxtsMiM
   2lOHUbi7kwKz5wyn6NYJsEd0e/65Ptt/nLmTfZ6CnuS+cr8FQk+jsOhkt
   hEuOzh7XAJpPSCK9SWwBuxsctedE23E+HJ1YzCEHCxw343hkFSDkuTqWY
   SCfWScxv69hom9yVYxI37Ski+rLqUt5dQvxN6kbRV9ygACuzqQAn/X5b+
   Q==;
X-CSE-ConnectionGUID: CP2X/acaTSCOFjJ1bbznCQ==
X-CSE-MsgGUID: GHR+fUgGQOG+4nuI6k8xAg==
X-IronPort-AV: E=Sophos;i="6.06,159,1705388400"; 
   d="scan'208";a="16217464"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 01:15:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 01:14:43 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 14 Feb 2024 01:14:43 -0700
Date: Wed, 14 Feb 2024 09:14:42 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <u.kleine-koenig@pengutronix.de>,
	<rmk+kernel@armlinux.org.uk>, <vladimir.oltean@nxp.com>,
	<jacob.e.keller@intel.com>, <yuehaibing@huawei.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sparx5: Add spinlock for frame
 transmission from CPU
Message-ID: <20240214081442.w533wvcvqpvq5352@DEN-DL-M31836.microchip.com>
References: <20240213121705.4070598-1-horatiu.vultur@microchip.com>
 <5476743f-3648-4038-97f8-a9df22c0f507@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5476743f-3648-4038-97f8-a9df22c0f507@gmail.com>

The 02/13/2024 09:26, Florian Fainelli wrote:
> 
> On 2/13/24 04:17, Horatiu Vultur wrote:
> > Both registers used when doing manual injection or fdma injection are
> > shared between all the net devices of the switch. It was noticed that
> > when having two process which each of them trying to inject frames on
> > different ethernet ports, that the HW started to behave strange, by
> > sending out more frames then expected. When doing fdma injection it is
> > required to set the frame in the DCB and then make sure that the next
> > pointer of the last DCB is invalid. But because there is no locks for
> > this, then easily this pointer between the DCB can be broken and then it
> > would create a loop of DCBs. And that means that the HW will
> > continuously transmit these frames in a loop. Until the SW will break
> > this loop.
> > Therefore to fix this issue, add a spin lock for when accessing the
> > registers for manual or fdma injection.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> Any reason you targeted 'net-next' rather than 'net', as this appears to
> be clearly a bug fix here?

Yes, it is a bug but it is not something that happens all the
time and I thought this fits more into the lines of 'This could be a
problem ...' therefore I had targeted 'net-next'.
But if you consider that I should target 'net' instead of 'net-next' I
can do that.

> --
> Florian
> 

-- 
/Horatiu

