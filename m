Return-Path: <linux-kernel+bounces-128231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872778957FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD501F23421
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158C12C813;
	Tue,  2 Apr 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JmJ7UZYn"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD312BF26;
	Tue,  2 Apr 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071072; cv=none; b=JH7EaiZtR9TC72x777XkUUb5CksANtQur9WDT2TJO0vW+gAi276eH1AJnQ57i6ZwlgLMvavDp7bFWZHBz6LNqYoPJViZk6zZDuhE28YxgfSaQqnj5OUXBgddai2D/TMblMkJZuxVsd3BjpjDubcYc/mE1XH+x0nANWHYk6wJIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071072; c=relaxed/simple;
	bh=YTo9w2fHjpKrEKywxXucE0qQd92vHtW7IgMooVpRS9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzvQU84jVh8xmpZnebt8jYAnngbOiRDvRDPq2tULEq/HP/8clznQfe05/JdAM5pM84nvj0yJfwxWOCK70zce5NmqbKffDxE6NMbn6QokUczjwVBt9WisGOBFkP6IampfEXQQ8eccVybCzOYtWNYFYikgI1M1cf2kCKJ+0o3QkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JmJ7UZYn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B1171C0005;
	Tue,  2 Apr 2024 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712071068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04oCEJRlkMn/3tUgO8X/PzKFEHTFoybfxCmD6Nb3NAU=;
	b=JmJ7UZYnW6d2WwwDCJBioQvmfR/0wENnN0+GHBqHUBT0C8UWW4QPv75GW67eZ7d9CHfJ4W
	THXQCdmlXk1ADwRJ0Xt7p1gQgujIo5celqmtTJhdfVxaxphlzlRT1dgBUxz37yew2Y70V9
	u1hEeklAPmdxrvj3WJegzfcTEMyGER8cE1XBatf6wfkodLzUUCePCV8dUGUG4me6t2cUSk
	c8MOTy0KXc1xNcs567HezP2oWvXBfMfGJFGa4/YDdpV3pjIJa8U/8vR1cbDfngUOGWEFIu
	C863xUSRv8GEFYkLlBIPN644MMRIrn1RQ5f66lPbj1+doK95J9GKY/16vzSJXg==
Date: Tue, 2 Apr 2024 17:17:45 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: codecs: rk3308: add dependency on OF
Message-ID: <20240402171745.2cae620a@booty>
In-Reply-To: <ec02a779-0917-456e-9bad-c5b12528206e@sirena.org.uk>
References: <20240329-rk3308-audio-codec-fix-warning-v1-1-b9d177fcd6c9@bootlin.com>
	<ec02a779-0917-456e-9bad-c5b12528206e@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Mark,

On Tue, 2 Apr 2024 14:04:19 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Mar 29, 2024 at 09:44:47PM +0100, Luca Ceresoli wrote:
> 
> >  config SND_SOC_RK3308
> >  	tristate "Rockchip RK3308 audio CODEC"
> > +	depends on OF  
> 
> There's no actual build dependency on OF, please add an || COMPILE_TEST
> to improve build coverage and help maintainability.

I see, thanks for the comment.

While there, an even better improvement is probably:

  depends on ARM64 || COMPILE_TEST

using ARM64 because this codec is known to exist only on the RK3308 and
ARM64 selects OF.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

