Return-Path: <linux-kernel+bounces-110274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE3885C71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38CA1C2182C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9386654;
	Thu, 21 Mar 2024 15:44:52 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681A224F2;
	Thu, 21 Mar 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035892; cv=none; b=pQkwhqkd1cGxA+zJqgAgv7oM0cJE6j5VEAS7JEyYF2AuCqNkOyIo7BoaNx1yes1swh5r8AR9iVNAxTWIalvJ3a1jebj4zzMwA9+MZy87AVbSq7AG6GO6JpM4+4Xuitrnbm5wFy8Acw2cC9kBfplWKu5eSHTPuXF1oVKd8KHQ0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035892; c=relaxed/simple;
	bh=T4H0ERp4UEzD6+VME4K23Ub9xg5TJjr1AVHthGvEjwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCqxKtidDGBgD0RU9EOIxFcbJkyK0PqlDNjS/ylBEDbfyigJFrJWPQIO45wo43QiAG9lyV5+ngyVXi8q9ItAyJ6X3YhvmhaixUwb1LkTxL8gWBte98qQ9rocVypssMC5rEw1yka7hb3flk7NbdMmRZsgJS/ZFG9PMIOhlcesPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnKai-0007eQ-2t;
	Thu, 21 Mar 2024 15:44:29 +0000
Date: Thu, 21 Mar 2024 15:44:25 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: add driver for MediaTek XFI T-PHY
Message-ID: <ZfxV2c-JBCFrpSRV@makrotopia.org>
References: <745f8b46f676e94c1a396df8c46aefe0e8b4771c.1707530671.git.daniel@makrotopia.org>
 <3bb95f1d795eede63284dbcb224e06ea6886b421.1707530671.git.daniel@makrotopia.org>
 <ZevJwSq-A43vqO6k@makrotopia.org>
 <20240308193632.158b3c42@kernel.org>
 <Ze3j-7WzbTM52kAs@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze3j-7WzbTM52kAs@matsya>

Hi Vinod,

On Sun, Mar 10, 2024 at 10:16:51PM +0530, Vinod Koul wrote:
> On 08-03-24, 19:36, Jakub Kicinski wrote:
> > On Sat, 9 Mar 2024 02:30:25 +0000 Daniel Golle wrote:
> > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>  
> > > 
> > > It's been a month since this patch was posted. Maybe it has somehow
> > > slipped under the table (or even under the carpet)?
> 
> Nope, somehow I dont have this in inbox, i think i have some issues with
> gmail and list server,

The series can be found here, just in case:

https://patchwork.kernel.org/project/linux-phy/list/?series=824861

> 
> > Lots of people in To:, lets direct the question to Vinod? 
> > Most active generic PHY maintainer according to git, Vinod?
> 
> thanks for letting me know...
> I will review it in next few days (pulled it from lore using b4)

It'd be great if you can take a look and maybe merge this so
we can proceed adding support for MT7988.

Thank you!

