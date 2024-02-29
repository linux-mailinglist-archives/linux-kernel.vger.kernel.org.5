Return-Path: <linux-kernel+bounces-86528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EE86C696
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB491C2100D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085C63CAE;
	Thu, 29 Feb 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfMcgvOY"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8561665;
	Thu, 29 Feb 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201678; cv=none; b=mIjw7BO0haAUkmmQKNtzRrbyetlUPn+6v53P2bVxKLDGwz48YLojqKueoYJjoTB2H4KU36lWRnRgxIAZR2+iYaeHb2HToBjdiLQ557/0+laTl4JVXNtvNB0LkHpMDOGart23mM2IdYsn1Y6ho6l/pzc1YwRJPhuFgSLZqPq14RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201678; c=relaxed/simple;
	bh=N/24cYqXozyOmOacjrNVgBVLbi7RWjtfqxIR2O+6Iwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjrHgqcIYTMhyFtgGvPAdiXsg3pu7xuZTPT/DThBkYQ0IpmtjeHlHpNdJgpEr5LiRPq3YlQ/GCrJrvExfzSc0HV2jocFrgHcik+9BIX6VA+b9mXUUDADFyLQMjmIYzOxy4lxBhkcMyB8AW9des7PgiTxrdz50M3psYuAmiFcEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfMcgvOY; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DB2560003;
	Thu, 29 Feb 2024 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709201672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0Qg6WyRbahfjflhKo2Gr2gpsraYYAk4H6zxz/KiuF4=;
	b=VfMcgvOYZaY3xiZssK0Ck2+vdea62Zr400HIkIteqKIYTIRamm8Zvb10WEdn2HzGqKyKWA
	Qwi8tGsWypDoW2NX3GhWDwZMWjL/Cs3i9Qstgn/uqL3eWSGK7DjyXxrbG2uQ7dzQOYElY4
	1KxFQhAG4KV+gtNB0L9AbZIS7MUbRNxGiEqJNPho10KN03/G5YP+1OTVThJevOSIaho6S9
	DFeEJ16VUBD31OPV7yhA2eoEpU7N3zv82Xkbcgy59sY9BGxYoWsfOb90tIHmC99PUX/9k3
	atBqJDpQeo1BBaZs5UEArjBtpCCNoHfD2m1tTH08qRs1/MQJh2ATSKFzA6k58A==
Date: Thu, 29 Feb 2024 11:14:30 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Greg Kroah-Hartman  <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
Message-ID: <20240229111430.54bdb6b1@bootlin.com>
In-Reply-To: <c2b830bb4a4cf76dec8783f38b2477120edb1a15.camel@gmail.com>
References: <20240229083953.607569-1-herve.codina@bootlin.com>
	<20240229083953.607569-3-herve.codina@bootlin.com>
	<c2b830bb4a4cf76dec8783f38b2477120edb1a15.camel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Thu, 29 Feb 2024 10:50:21 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Thu, 2024-02-29 at 09:39 +0100, Herve Codina wrote:
> > In the following sequence:
> >   1) of_platform_depopulate()
> >   2) of_overlay_remove()
> > 
> > During the step 1, devices are destroyed and devlinks are removed.
> > During the step 2, OF nodes are destroyed but
> > __of_changeset_entry_destroy() can raise warnings related to missing
> > of_node_put():
> >   ERROR: memory leak, expected refcount 1 instead of 2 ...
> > 
> > Indeed, during the devlink removals performed at step 1, the removal
> > itself releasing the device (and the attached of_node) is done by a job
> > queued in a workqueue and so, it is done asynchronously with respect to
> > function calls.
> > When the warning is present, of_node_put() will be called but wrongly
> > too late from the workqueue job.
> > 
> > In order to be sure that any ongoing devlink removals are done before
> > the of_node destruction, synchronize the of_overlay_remove() with the
> > devlink removals.
> > 
> > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/of/overlay.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index 2ae7e9d24a64..99659ae9fb28 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c  
> 
> In the cover, you mention device.h inclusion but I'm not seeing it? This is
> clearly up to the DT maintainers to decide but, IMHO, I would very much prefer
> to see fwnode.h included in here rather than directly device.h (so yeah,
> renaming the function to fwnode_*). But yeah, I might be biased by own series :)
> 

Damned. I missed device.h in this patch.
Without this one, the patch do not compile :(

A fixup commit I missed to squash before sending.

A v3 is planned to add this device.h.

Nuno, do you prefer I wait few days before sending this v3 waiting for more replies
or I send it right now and you re-do your comment on the v3 ?

I would really prefer to send it now :)

Sorry about my mistake.
Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

