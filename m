Return-Path: <linux-kernel+bounces-32124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661AC8356C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116ED28221C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9A381A4;
	Sun, 21 Jan 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kznw0K80"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E336376F2;
	Sun, 21 Jan 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856284; cv=none; b=EOkWpCsALGkEmss9FHsfEOKCX1eyCP4Z/jfjz0DFo7Kcn5E6bkBgKVdnD3nluX3e6xlWmaX+LvFw6T6Ovs+3okefOKm56Igwn/lkVwoeCiduXdCkuBe/kI2rTlYzErKyMajhyvRjHzB4g83LkDJdBlfyGv5oG4nC12lb+/P9Bk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856284; c=relaxed/simple;
	bh=ezyFbPn9T9HFOQqzU8/hFiYwVitfPmXG4/Dm9KACBKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D03T21PP0gn6KU8ZZ3oQdYyMmm51mzFOhYGvkI/vU/PE/EsjA6pczB5AFAUctGgbn3kqqaLwRW15xrUUchDVe8QH2g2PVguwigfNy8w++f3RYzaBl/QzLepdEg0sB37gRn6OjK/whxjgdsziL4+gefY7YJIxIx8naaBGHJ5ikwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kznw0K80; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=c37txM5AQBeipFKlwo48dwCVCZGCUaCC40m8RvSfo3M=; b=Kz
	nw0K80g2wZux006JZCCdff6hpb+mbikxpe0BJ47nr3Ub3l4+FNQjrjZ9Qkq9xxLa+bv07C+l6P7YM
	1H1mAl5X/KyV+M3X6Iscfv7nk3jyRleaH3PLEYzZTGp3Lu4KdnYrefSdKidAP2dIjfLJfgZxPd8B4
	3FWUkaTEl6k5q2Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRb8q-005f8u-VZ; Sun, 21 Jan 2024 17:57:52 +0100
Date: Sun, 21 Jan 2024 17:57:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Praveenkumar I <ipkumar@codeaurora.org>,
	Abhishek Sahu <absahu@codeaurora.org>
Subject: Re: [PATCH 5/8] clk: qcom: support for duplicate freq in RCG2 freq
 table
Message-ID: <28cca132-d5bb-4cff-ba2f-9be241a5ce83@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556DEA3D4740441EC561414C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR01MB5556DEA3D4740441EC561414C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Sun, Jan 21, 2024 at 08:42:34PM +0800, Ziyang Huang wrote:
> From: Praveenkumar I <ipkumar@codeaurora.org>
> 
> Currently RCG code looks up the frequency table during set
> rate and return the first available frequency greater than
> requested rate. If CLK_SET_RATE_PARENT flag is set then the
> set_rate request will go to its parent otherwise the clock
> framework will configure pre-div, m and n according to the
> returned frequency table entry. In this case, it is assuming
> that parent clock will run in the same frequency with which
> pre-div, m and n has been derived. But it may be possible
> that the parent clock supports multiple frequency and the
> same frequency can be derived with different pre-div, m and
> n values depending upon current frequency.  Also, the same
> frequency can be derived from different parent sources and
> currently there is no option for having duplicate
> frequencies in frequency table and choosing the best one
> according to current rate.
> 
> Now this patch adds the support for having duplicate
> frequencies in frequency table. During set rate, it will
> compare the actual rate for each entry with requested rate
> and will select the best entry in which the difference will
> be less.
> 
> The existing functionality won’t be affected with this code
> change since this code change will hit only if frequency
> table has duplicate values.

A good commit message for a change!

> 
> Change-Id: I97d9e1b55d8f3ee095f6f01729af527ba90e50e5
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> (cherry picked from commit 775e7d3b69ffc97afb5bd5a6c9c423f2f4d8a0b2)
> Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>
> 
> Change-Id: If10193fc79a3c1375ab73597813745ff1f4df0ad
> 
> Pick from https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/6dfb368bae130bee58e00ddf8330b55066e1c8c5
> 
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>

Please clean up these tags. These Change-ID tags are meaningless in
mainline. 775e7d3b69ffc97afb5bd5a6c9c423f2f4d8a0b2 is not in mainline
either. The picked from might be interesting, but please put it into
the body of the commit message, not mixed in with the tags.

Who actually wrote this patch? The first Signed-off-by: is from
Abhishek Sahu. But you have a From of Praveenkumar I ?

    Andrew

---
pw-bot: cr

