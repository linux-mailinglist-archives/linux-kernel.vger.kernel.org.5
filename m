Return-Path: <linux-kernel+bounces-137561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45889E3EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F071C23158
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46584157E9E;
	Tue,  9 Apr 2024 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="pUJBJC7p"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B2156C44;
	Tue,  9 Apr 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692364; cv=none; b=MIG1LDQRiODyeatGDPKNBsaMPDrW+10LitBuLos3Cw7UfsbCGRJkl+BwYW6OJyboDMcOyCB0akzlmrnva7OIQdPKHL8AI2a0WGXlJeb3GbJUQN5o1qcM5ammMZNEzla27heWpeo/e2GxjnEfVHrwdLafsj1OO4tQODz0T9Pf4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692364; c=relaxed/simple;
	bh=WCfUupxQWEzTuWu1BE7JTyPiJGMLZlc91L9lDVBeOMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpRo5mA5t9Y3GMoQ3ke2Rg6FjmeOnJBdMAXnp0hRfh+PbklWAuiy4lb8hZ6LCP1I92P+ZeYbUnFfq38a+bjiLBQ1rVtBEyhHq2rbfn7Vh3Lmm/jGnKzuZRNqz/WJc9m1ZiRqEIR9+v+MIQOuAwuahCSoFHLeOtuWN4wKl+ipJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=pUJBJC7p; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6F7AE1FA07;
	Tue,  9 Apr 2024 21:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712692359;
	bh=7m07SjhUDNDGWypwGSUDjFN/U1Jz2BBKoUov+80RMz8=;
	h=Received:From:To:Subject;
	b=pUJBJC7pgpTwW36t+b2S2tIPKHPG0GBpMMLGzeoqFrS8JNp77PLE9iDoYS0y7vN4U
	 zZTCxpGwrkGx5x8e8KH2HdJ5sofPi4Fh6SRF9VF1PdFuz/F+7qbGnaWGJcIWOj13Np
	 2uvL+mQZZ1KPgveqVT9KBl42nX6x3m+zARX/p3Do5KlWNesE6VG8aNxv1ugyDVGcj1
	 Ww4wEq6egAkxKYz4s78rzzjlzwnRhDm1mSs5OGqIZh4kKLQl5opZW4TZfHDfxJ13Bw
	 eSv+HPV6Uttpa89r1n9QewUk1pVsBpkbT34tY0gRV0UWunT3inTE0788uztxbfGT9F
	 PoxEil8giHv0Q==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 0BFDF7F9A5; Tue,  9 Apr 2024 21:52:39 +0200 (CEST)
Date: Tue, 9 Apr 2024 21:52:38 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v2] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate 5% safety margin
Message-ID: <ZhWchn3qr_7Ocggm@gaggiata.pivistrello.it>
References: <20240404153319.1088644-1-jm@ti.com>
 <a148e8ab-f502-45ec-b915-22fce751ad64@roeck-us.net>
 <a7b0baba-56bc-47ca-9494-0178f441ff8b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b0baba-56bc-47ca-9494-0178f441ff8b@ti.com>

On Tue, Apr 09, 2024 at 02:37:15PM -0500, Judith Mendez wrote:
> Hi all,
> 
> On 4/6/24 8:01 AM, Guenter Roeck wrote:
> > On Thu, Apr 04, 2024 at 10:33:19AM -0500, Judith Mendez wrote:
> > > On AM62x, the watchdog is pet before the valid window
> > > is open. Fix min_hw_heartbeat and accommodate a 5% safety
> > > margin with the exception of open window size < 10%,
> > > which shall use <5% due to the smaller open window size.
> 
> Please do not merge this patch, I will add an additional
> patch removing the hack in this driver.

Is the patch buggy, or you are just talking about an additional clean-up?
If it is an additional patch and this code is fine, why holding it back?

Thanks,
Francesco


