Return-Path: <linux-kernel+bounces-166464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1DD8B9B04
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB11C22004
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09F80034;
	Thu,  2 May 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="gjxqBVii"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4D59148;
	Thu,  2 May 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653652; cv=none; b=ereMUNN6F/M8Z0RjmU614SyEtYFzSR5E/mY8VDFQyhmFqjZCaoIt8nN4UxDNICVWtDz2OoqYF0IkLrkbweTbOFP5KHkIAdrhUrr+JSzVEaW/hURzjGXe2inn2c3BPrDJ+2eYZ3YI+7WUNYEysSecKoXhZBNW4fvldRIVpPXtSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653652; c=relaxed/simple;
	bh=ShSDr9MNNFwpvslERjkYEioWxBX5hey12NXSQGJCtmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCMo0ZRi+h7Ml6YcMc6athw1F7PaJJKOrx2HrK9XCWI+JYHytP7SVfYs8+9s8VzJlLxPMzxn6w/RIT6NzZ1q9d1X/O5GtHJ5lVTQkndA8/0zJtEgJQw37ek9Q4h9iOptceQe+VTH5NIKYMF35IQLoySBGGcvybtnHt19b5HgMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=gjxqBVii; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714653642; bh=ShSDr9MNNFwpvslERjkYEioWxBX5hey12NXSQGJCtmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjxqBVii58VhMNpnkwUcDVCjHx0DA1iXt2T67a5VCoyPUKEzQ9C6L6+48m7Cze70C
	 2BUhVYsqd0tQqPGt2bgRTNyw+CNwg2q66bwpz2X/DS2Jj9yiWXO2hnfN2qhGzdgHSq
	 0YoMUSv3jb5wuXV2E9CtTq9rJ8gKRimiugr2wDzw3QAoLBN+yuJpMqVL9FsWHZ40lE
	 OmdXQ0uWNgkESE4SnXBy/h2NmuPcsO4Hoha46GGRz8s0MGc/VvnPHXs0glmmckq1uv
	 iXDYUPLeDucwo7wZuUEkhHbrXOSgXjlkTkeFASrUfxZW/jS8qkZgCnGCfmRKvwQq1D
	 2+J2X3H1Kc4Bg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VVYSV1FWdz60;
	Thu,  2 May 2024 14:40:41 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Thu, 2 May 2024 14:40:40 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: renesas/sh73a0: use rdev_get_drvdata()
Message-ID: <ZjOJyGQE1ze2WXh8@qmqm.qmqm.pl>
References: <bb6b85722d80d665779e3043d1499c4fc38f0ff3.1714562004.git.mirq-linux@rere.qmqm.pl>
 <CAMuHMdUy+e1vQRBUfo2paBJi4pro-tKf9hOe3YaddcB=OtRfJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUy+e1vQRBUfo2paBJi4pro-tKf9hOe3YaddcB=OtRfJw@mail.gmail.com>

On Thu, May 02, 2024 at 09:56:39AM +0200, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Wed, May 1, 2024 at 1:16 PM Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> > Replace `reg_data` access with the official wrapper. The field is going
> > away soon.
> 
> Thanks for your patch!
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404301218.URkWO6dj-lkp@intel.com/
> 
> I am not sure these tags are needed, as the issue is not present in
> any tree yet?
> 
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Do you want me to pick this up (for v6.11), or do you want to queue
> this with the other patches from the series that removes reg_data?
> Please let me know.
> In case of the latter:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

If you're ok with it going through the regulator tree, then I guess it
would be easier to manage as the series would build without observing
additional dependencies.

Best Regards
Michał Mirosław

