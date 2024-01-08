Return-Path: <linux-kernel+bounces-19665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152BE827090
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2797F1C2232D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DCE46547;
	Mon,  8 Jan 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IDRcJWNA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8EA4653B;
	Mon,  8 Jan 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UrcCoznsGe6jbQRLq+9vtH0N2hJ7Jd1bMTvVnCS7xYI=; b=IDRcJWNAvbnfe+/Ros99KeN77T
	HCfvHw1cG4I/ykS1D/K2sKSAFPGx2vEyBuYcK3FsCJMrig7D+CkK6FpB1G5XdVdEn7dm1F++xru62
	Re8FPLkomas9vR37NTlTz1De1U/GswxsLUaWm+LLorE14W4Kr527r6Vwtu2w7Bg51hPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMqCo-004eDc-K4; Mon, 08 Jan 2024 15:02:18 +0100
Date: Mon, 8 Jan 2024 15:02:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 4/5] net: phy: marvell-88q2xxx: fix typos
Message-ID: <10b09d30-70c6-4f87-8367-19b2579496a1@lunn.ch>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <20240108093702.13476-5-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108093702.13476-5-dima.fedrau@gmail.com>

On Mon, Jan 08, 2024 at 10:36:59AM +0100, Dimitri Fedrau wrote:
> Rename mv88q2xxxx_get_sqi to mv88q2xxx_get_sqi and
> mv88q2xxxx_get_sqi_max to mv88q2xxx_get_sqi_max.
> Fix linebreaks and use everywhere hexadecimal numbers written with
> lowercase letters instead of mixing it up.

You could split is up into three patches. Its probably not worth it
now, but its something to remember for the future.

Ideally you want lots of small patches which are obviously correct.  A
patch just containing a rename mv88q2xxxx_get_XXX to
mv88q2xxx_get_sqi_XXX etc, should be obviously correct, and just takes
a few seconds to review.

A patch adding a few line breaks should again take a few seconds to
review.

Upper case to lower case is easy to review.

When it is all mixed together, in a bigger patch it takes a bit more
effort to review, a bit more effort is needed to look for typ0s etc.
Its can be faster and easier to review 10 very simple patches than 3
big patches...

    Andrew

