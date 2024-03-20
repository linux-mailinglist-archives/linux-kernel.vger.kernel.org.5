Return-Path: <linux-kernel+bounces-108821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE12881077
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAD71C232E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFD53D970;
	Wed, 20 Mar 2024 11:08:54 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2E3BBFA;
	Wed, 20 Mar 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932934; cv=none; b=b4vunODEKQhwh3pBnwaE3cCvQWil0GpUJ9cb9F2YjhzR7IcTpOdzBuRqyjKws99SNCBeRk/Of8ASObuKOqhXN6RkfgLXU3Gou3rv7ZpjIAZ91U3fniTwo2a03NLfl5vNcdayhahlkpgk76y5yy1Ftpunz9fzivCfXGhWEnzfRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932934; c=relaxed/simple;
	bh=GVLutt18GQlJPG4WB2z9PrJepa+Hhk6WaYlpmouuWbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJdN8Jg2hvPkuOEstgUTl6ZAlU32JLnEIeAEgva18tjs0eBtUcCGDC6AiB1P/Y+fRp3084+K6l2LL/mHQfLRbhSDfJT+bvqBNvHO6ANq0SJY3paHMR1rXoJ5cazbDpdhKSlnt8usrYVndEja4KCMvRgylhB3HfqdcCpiAte055c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rmtnv-00017k-0M;
	Wed, 20 Mar 2024 11:08:19 +0000
Date: Wed, 20 Mar 2024 11:08:12 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Message-ID: <ZfrDnFyGay5YTTFg@makrotopia.org>
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
 <9d111cc9-c73a-4d3c-83f5-3f59e6c8841f@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d111cc9-c73a-4d3c-83f5-3f59e6c8841f@arinc9.com>

On Wed, Mar 20, 2024 at 11:10:19AM +0300, Arınç ÜNAL wrote:
> On 18.03.2024 10:46, Arınç ÜNAL via B4 Relay wrote:
> > Hi.
> > 
> > This patch series fixes EEE support for MT7531 and the switch on the MT7988
> > SoC. EEE did not work on MT7531 on most boards before this, it is unclear
> > what's the status on MT7988 SoC switch as I don't have the hardware.
> > 
> > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> I see the state of this patch series is deferred on patchwork. I see that I
> forgot to delegate this to the net tree. As I don't see any objections in
> this series, I'll send v2 with it tomorrow.

Sorry, but imho it should go to net-next, and you might have overlook
it but there have been some concerns.

For sure it should not go to net tree as you are enabling a new feature
and not fixing anything which is broken. EEE on MT7988 works fine as
of now (see my reply), EEE on MT7531 was supposedly intentionally
disabled for reasons we should ask MTK people about.

