Return-Path: <linux-kernel+bounces-65264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25824854A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDEEB24489
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008454729;
	Wed, 14 Feb 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="dqA+1IG7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BsbGSXWK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65C5466A;
	Wed, 14 Feb 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916857; cv=none; b=Icu4cITwW3TdNAtiDyP24LT4h0BfQ3Z3PfiSZdSzBTCRVGkS+nW9f+4pV3/L9hsC2d1zVSAwk+SUWNXQQCJy8wg89vdtxuhhty7qwvlBH2muSAK31Z1WxQ5h0QRcs3uSRBDdT9pZucR49VBqxo5Wy3bNJlPDpUPo4b7GDzmY8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916857; c=relaxed/simple;
	bh=NasOj5Rgwdnt2BKlk2KyEOGaXNw9z2FOCu2Yo3tJ+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dezZ4HsC6pKNNXLtRSy2QBAvP0Q4ZyayOv9u/Y0Gmg5YtxSkaEvxTRnNmKb7M7kkJz4KlXXJxVq7QxCxo4599bXBkDgnFGigOTXX1mndsqBCBDRChx3QZOcvR42LZc8BLf8Onzf0EgjBL/1K34b9dLU9KeyroFoUf/KujexJ35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=dqA+1IG7; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BsbGSXWK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707916854; x=1739452854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yrrdWc24p8EoY0O9KXepRzsU4U8z8HdRzd2XY11wwMM=;
  b=dqA+1IG7iu1jfjWUgY6d5j06RbiW7wlLNvS5iMsbUb83Y+i/orr2IyKC
   eVgCBWlfLk6OY9PatGIjrqMrlGjO6Dhw0bw1AMQ3/lG11h5rwld74b178
   wq8UIDETIEcdDDCKhi93JgJXswjCjloA26S2r5S6gkax85x/QZrg59WsR
   1DzhsYsbM7bft5srSNvinqd2N9ZdSzzN2OuuldvL1GpIydaalCERfpdbt
   QX9gofawkSGYjjRHcxe+sb+T1uNLVHG8195GRiWGc8Yd92zWT+ntn7uZO
   lPFijvmbDQubIePZjWzU3EoMutsZm3v9CwE9YolRsS9LYW33Y9B5LQxKx
   w==;
X-IronPort-AV: E=Sophos;i="6.06,159,1705359600"; 
   d="scan'208";a="35404619"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Feb 2024 14:20:51 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96BA316E1E3;
	Wed, 14 Feb 2024 14:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1707916850;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yrrdWc24p8EoY0O9KXepRzsU4U8z8HdRzd2XY11wwMM=;
	b=BsbGSXWK9tho49jJ39YbUE6Uo5TOWRI0lL8ji3WEhZ/Uy+KdKIX9EAXomsngooSSusykOG
	F2WIJaEwMDEkjvdBXDYTGNkUxEWCZOb1c0DiJf7DENtk/zSiZpUorpXQcg9VTg4gfrenuI
	UqJXS5kCI/c4zhBjDewqXUpqtk2jQlzci83r51waH8KTTX6S4WJk2YJ5RkkkJLzKIhK3/A
	E4Gh9WQ1LJjWfuh40g7u3S4tBG1Is6/WB/GB9iFl8FwxSImJKO70h0S12UrkAzhzVvlYQe
	3AmUUSk4f+IEE1rVK8TIt8NOOCXP3BFkQEgBZpqEj/zBaiu8xaOj4g6Wm0Q+yg==
Date: Wed, 14 Feb 2024 14:20:37 +0100
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 05/14] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <Zcy9E4riyFRk8B1P@herburgerg-w2>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-6-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213213955.178762-6-dima.fedrau@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Dimitri,

On Tue, Feb 13, 2024 at 10:39:44PM +0100, Dimitri Fedrau wrote:
>  static struct phy_driver mv88q2xxx_driver[] = {
>  	{
>  		.phy_id			= MARVELL_PHY_ID_88Q2110,
> @@ -255,12 +439,26 @@ static struct phy_driver mv88q2xxx_driver[] = {
>  		.get_sqi		= mv88q2xxx_get_sqi,
>  		.get_sqi_max		= mv88q2xxx_get_sqi_max,
>  	},
> +	{
> +		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),

I tested the series on a 88Q2220 REV B1 (which is id 0x002b0b22). The
driver works fine on this revision.

I understand that in the Marvell API the initialization for Rev B0 and
B1 differ. For B0 some additional init sequence is executed. I did not look
into the details of this sequence. However this patch seems to work on
Rev B1.

Would you consider adding compatibility for Rev B1 and following? I
tested with:
		.phy_id			= MARVELL_PHY_ID_88Q2220,
		.phy_id_mask		= MARVELL_PHY_ID_MASK,

Otherwise:

Tested-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>

Best regards
Gregor
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

