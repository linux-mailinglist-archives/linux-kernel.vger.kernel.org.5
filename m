Return-Path: <linux-kernel+bounces-81242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD186727B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE531F2F03C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3131CFBD;
	Mon, 26 Feb 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TuokuyE3"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA41CAB9;
	Mon, 26 Feb 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945268; cv=none; b=lsbjpg5LoW3EZYZ5BLH3gC4Ji/VGjrGVTbQL/LgkmEB3aHtgFfJyE9Tnr276Mf1FMxgttTbhZgeZWS4Z5eKyk6QGFaRPbVgDlMPOmbYhxUCzyakXXIbS1hSBKbz94kWJKrfy6miT08+qlvPU8vFExJLzzcnDhVZh7BcAzfsyfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945268; c=relaxed/simple;
	bh=LzhaBbcauACYgRqWWxkBvFp7cRRf5oYmpzyjCxeAY98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3PAjmVXHDcGHBbsKMeG0V49J9ztyNtJ18P6XEABoO0gvOJs5etwjqwlojq64EMPc3XJOSlJKOskz8+9727k8FTs0stLntXSEnqjALwAQFF3tCvLtfKAGfi1uwS2z30qGAvbWPD50td8ejlWZEdMLctDCqbBIziJd0AI42tmMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TuokuyE3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B178A1C0006;
	Mon, 26 Feb 2024 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708945265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqkRj/rY7R3cywYO9k2uRqXTAZKlVb9uhXpJ8UyQP0I=;
	b=TuokuyE3C1jQg9T65gISvpN6QmI6EHUW42lXxLt/pi8Do2rzZ8Cjr7Di4BzTsb4hV1kpqB
	wL0pdVVAkVCgAz3dFLcuNuPajyusBCWg/om3tgcrOe64dSnZS5VrL0gII/YvVihOQNzLV6
	V81PPcRAOf0C+V1fBn+lOKzJ6JTtNEjx+RVJVyptMGTPSQItuoQv/zf81Jx9gR59GsvZ5u
	QkgO1F6bbIeXf7tpdmChTakmvO7F9ZWF6i7UUDKFJv4eRohlRY+5S77dfHtV5ZxSqONSrQ
	FkeZLiIYAzi1w+r9S03AdcIbW4DX60bMb28NmJl2LpPAB34ja89DGIyo8iUnyw==
Date: Mon, 26 Feb 2024 12:01:00 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next 0/2] doc: sfp-phylink: update the porting guide
Message-ID: <20240226120100.47ee550c@device-28.home>
In-Reply-To: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
References: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

Russell, did you get a chance to take a look at this series (maybe it
went under the radar, if not, sorry about the ping) ? I'd like to make
sure the examples are meaningful and correct, and you're clearly the
most qualified to comment on this :)

Best regards,

Maxime

On Tue, 20 Feb 2024 17:04:02 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi everyone,
> 
> I'm currently in the process of porting fs_enet to phylink, and I'm
> using this occasion to update the porting guide along the way. Let me
> know if these changes are clear enough, and if there are any mistakes in
> there.
> 
> Thanks,
> 
> Maxime
> 
> Maxime Chevallier (2):
>   doc: sfp-phylink: drop the mention to phylink_config->pcs_poll
>   doc: sfp-phylink: mention the mac_capabilities and
>     supported_interfaces
> 
>  Documentation/networking/sfp-phylink.rst | 48 ++++++++++++++++++------
>  1 file changed, 37 insertions(+), 11 deletions(-)
> 


