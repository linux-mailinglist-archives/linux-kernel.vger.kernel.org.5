Return-Path: <linux-kernel+bounces-132696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266CD8998EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A870E28173F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E80161307;
	Fri,  5 Apr 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Ys7lT6yR"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B3C611E;
	Fri,  5 Apr 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307820; cv=none; b=e3sharrVeZAHiomWA0ePRfmmimkHbDih9+Z6TD+MZ5+8+NlEp2TXGF5v9hDftijrKolOkke7+UQzahGhjFDJlleKE33neslKiFpl7bKYk4S4YSqSzsdRJeq+Ti7NLrVRrpT0i5MlRPoczsbKdoPzwdoAjp6VuoQ9rIPe/IRH0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307820; c=relaxed/simple;
	bh=8uDLqN77WbrxwfS6o4GIiUnXkw6hu0o+sH31k4g4boU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B66nBsFGNHZ3VSAHxdGoqYRYOUZUXe4kPMNZSfPzXEECItUHDN65LwplWR/sAzgBEnHgsKjxYBLKRbcmIbX43XkF47qeJ1RGP5MDZiB2fVkCzs7qe+dWQHEZA+SE852tTrAdbfj7UaPYGVocFEhH1GTNMPWxW7Ap4Q3RXFupQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Ys7lT6yR; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 46F34100022;
	Fri,  5 Apr 2024 12:03:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 46F34100022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712307808;
	bh=CfCrImPVfmasb+F60N8ul7gwP1ihbKd1RFWZG/QLcfQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Ys7lT6yR7KzhOGZNrPGRI6tv3RSuYsEWhBSEA4iZi2kZPhYSPuF/iE6NjVtgrBgU9
	 q8HtUxFLN4QiqDnj7IFJH7+xGeORMLsjYV0LX9IP/ybiCrIgHpuh/oF1aZpiGu6u3H
	 IsBUzM1A3V2EmA64bevUJe6xtIPwQL993iO3qKc1OZrCKTspXPBhXfaG2ZUNeHX51i
	 AwNlUdPk1BpYirRXsUiS7L4TVUUbp6Lt2BkA4QRppDD319LoWAdSuRCOAzZ/XUYTdp
	 K7BKeJCR4452YBqAyxvPBnrB67tf9BSR9u0GAKTDtnikxWxy+eylO+dawgXiChGnvl
	 um9yhUxwhP7jA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  5 Apr 2024 12:03:28 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Apr
 2024 12:03:27 +0300
Date: Fri, 5 Apr 2024 12:03:27 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <quic_sridsn@quicinc.com>, <quic_mdalam@quicinc.com>, <ezra@easyb.ch>,
	<gch981213@gmail.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<sashal@kernel.org>, <vigneshr@ti.com>, <kernel@salutedevices.com>,
	<rockosov@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>, <stable@vger.kernel.org>, Martin Kurbanov
	<mmkurbanov@salutedevices.com>
Subject: Re: [PATCH v1] mtd: spinand: Add support for 5-byte IDs
Message-ID: <20240405090327.vowrj6aqjmmighs4@CAB-WSD-L081021>
References: <20240404121532.14755-1-ddrokosov@salutedevices.com>
 <2024040509-faceless-passerby-10ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024040509-faceless-passerby-10ad@gregkh>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184597 [Apr 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;lore.kernel.org:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/05 06:54:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/05 06:53:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/05 05:49:00 #24662499
X-KSMG-AntiVirus-Status: Clean, skipped

On Fri, Apr 05, 2024 at 08:37:48AM +0200, Greg KH wrote:
> On Thu, Apr 04, 2024 at 03:15:21PM +0300, Dmitry Rokosov wrote:
> > From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> > 
> > [ Upstream commit 34a956739d295de6010cdaafeed698ccbba87ea4 ]
> 
> This commit is already in the following releases:
> 	6.6.24 6.7.12 6.8.3 6.9-rc1
> 
> > E.g. ESMT chips will return an identification code with a length of 5
> > bytes. In order to prevent ambiguity, flash chips would actually need to
> > return IDs that are up to 17 or more bytes long due to JEDEC's
> > continuation scheme. I understand that if a manufacturer ID is located
> > in bank N of JEDEC's database (there are currently 16 banks), N - 1
> > continuation codes (7Fh) need to be added to the identification code
> > (comprising of manufacturer ID and device ID). However, most flash chip
> > manufacturers don't seem to implement this (correctly).
> > 
> > Cc: <stable@vger.kernel.org> # 6.6.23
> > Cc: <stable@vger.kernel.org> # 6.7.11
> > Cc: <stable@vger.kernel.org> # 6.8.2
> > Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> > Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Link: https://lore.kernel.org/linux-mtd/20240125200108.24374-2-ezra@easyb.ch
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> > 
> > In the patch series [1] only one patch was marked with Fixes tag, that's
> > why the secon patch was not applied to 6.6.y, 6.7.y and 6.8y. It breaks
> > ESMT detection flow with logs:
> > 
> > [    0.770730] spi-nand spi0.0: unknown raw ID c8017f7f
> > [    0.772688] spi-nand: probe of spi0.0 failed with error -524
> > 
> > Please cherry-pick the second patch from the series to 6.6.y, 6.7.y and
> > 6.8.y.
> 
> What commit id is "the second patch" here?  The one referenced above?
> If so, again, this is already in a released kernel, so I'm confused as
> to what to do here.

Ah, I apologize for not checking versions 6.8.3 and 6.7.12. My test
environment was running on versions 6.8.2 and 6.7.11. Therefore, the
mistake was on my part. Please disregard the cherry-pick for those
versions, and thank you for quick reply!

-- 
Thank you,
Dmitry

