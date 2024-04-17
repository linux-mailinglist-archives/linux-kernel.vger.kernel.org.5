Return-Path: <linux-kernel+bounces-147945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F118A7BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7323A283822
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F851004;
	Wed, 17 Apr 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCjhDUeX"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678C50264;
	Wed, 17 Apr 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330516; cv=none; b=HTjXy+xGWVBQD0DFFAthybg2THEmAnm8SEkqotyLzyLZtvgYcGg2GiXaaRucuFr8S8EboRg5xGM0FLuy9Gd0hQEM0mC/HyDsdWKQLW+onOJzxVWOR8emfjw+dO0RTgLzH/YOlg04Odn637iEK0EYn4NSNM73jT+3Ma9MeoixL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330516; c=relaxed/simple;
	bh=kivKBm+AJbJeHjI252CbHSM6JyqAqX6T/vNgHy/wBXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZ9BSKn3dgyyAwWb20rFOVWMweodBbN4ka/keROBXtXdFmwtI1d0ZvLmlwitzUisa/vItxNXGpuS5yBO4JvNvhVAJf3bUcj/tcH8T9wO/vnC7EW6UakStINCzZVS1bTKSuRDUrMJKBHk5BhLIOdv3A+73MHLUzhzbywMDHTkxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCjhDUeX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91BC81C0004;
	Wed, 17 Apr 2024 05:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713330506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLz4QLC5Swmd9g2vMTOYCJ6WGpq8oN/I1V5mjTJgaRE=;
	b=fCjhDUeXCuiFF6jO+IBaK8FrhfdDUCFIk3oI00WsvCHTe8VNh/LdS5f5FbNV+BT74Y3Nzt
	DwlsyUcyscUmsWioL+/6PfsOX5lqVgmj89SELxfaTCtyYTMGzq1ySOkH1KzlhknmqazZtZ
	EEth4Klh+jWUO/gKf6LDgNgXbfpqbJM0CyKnpSof1+NSq0Vl+6zsZdnOPn1H9RJObtoExg
	FL51YtsP4ljc8IfgkA/TDZ31TFiC9NI+3LBe8HGPtOPCOLTVntoYIBgjpFwUuQ2rHZ6tgG
	ayq3zYiWice6FYUpNyny/q2LBhz7JljjKlB+SLrrgCTKeJPN3AN1E8tDiqKftA==
Date: Wed, 17 Apr 2024 07:08:19 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan
 Corbet <corbet@lwn.net>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] ASoC: doc: dapm: improve section "Codec/DSP
 Widget Interconnections"
Message-ID: <20240417070819.7dce3e37@booty>
In-Reply-To: <Zh9RCMdihgSyZqTw@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
	<20240416-dapm-docs-v1-10-a818d2819bf6@bootlin.com>
	<Zh9RCMdihgSyZqTw@archie.me>
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

Hello Bagas,

thanks for reviewing!

On Wed, 17 Apr 2024 11:33:12 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Tue, Apr 16, 2024 at 07:56:16AM +0200, Luca Ceresoli wrote:
> > -Each input in this example has a kcontrol associated with it (defined in example
> > -above) and is connected to the output mixer via its kcontrol name. We can now
> > -connect the destination widget (wrt audio signal) with its source widgets.
> > -::
> > +Each input in this example has a kcontrol associated with it (defined in
> > +the example above) and is connected to the output mixer via its kcontrol
> > +name. We can now connect the destination widget (wrt audio signal) with its
> > +source widgets.  ::
> > <snipped>...
> > -Interconnections are created with a call to:
> > -::
> > +Interconnections are created with a call to::
> >    
> 
> Not strictly related to this patch, but for consistency, I'd like
> to write remaining literal block markers at the end of previous
> paragraph:

Makes sense, sure. I can add a patch doing this in v2, or send a
separate patch after this series.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

