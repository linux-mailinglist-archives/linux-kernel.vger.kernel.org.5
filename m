Return-Path: <linux-kernel+bounces-83500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E79869A47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECDC2850F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D714533E;
	Tue, 27 Feb 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p4316UKj"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101C54FB1;
	Tue, 27 Feb 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047474; cv=none; b=ZmGOA5FwDjSumsJ3jm6atDTcKHwwv75qrJdBZcr7BtLmBc4l0rOqFNqyQENDvOdOSJAUGZpFRwSw9yynX8ksSdJpRCzRDkOBpS6kM2GCJC1Q7+TazrswxGisUbcYZ89mR9GokfxUEbxO0u0+gbz7nMkHFhaQ74gzSWZ0HdgfMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047474; c=relaxed/simple;
	bh=GuTfgtHzMKbOGMBI9rNQiBxMjIpAwrQs7hdX/RHtN60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhJROpwzaRQFAMoD4MkOXt5fm0KEmhJzyG8r9LBhDH9l8wwI2Zsj5zqtDvJeGCjdzP5a/QFXO2fMzfc18lNZSlHRQbei6cyf+RuWZ7/IQ9tBFgIHQ3FlgDUzQbI2seg20P1aJgcXspPM/8jltRZn7HAY6AGlj2bYOFB/vE9fdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p4316UKj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2440AE0010;
	Tue, 27 Feb 2024 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709047464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnAHPEcowK5eolH8QESk6XYN95fzlShrEvPWb9+hJwQ=;
	b=p4316UKjdx4lUOBO+8N8DeVFxUyyJ6Wa8qPAJw4hMN956lqYzDxtSkWx5cOiOMKOhbN6Ak
	vxDKywlRMK2ijorAolfU2GERaCPuO4xDoxX0w9s8+k45I/bp87fVGHvw6K0IK/b0IJ2PkG
	C6ujohvyp9VSCh3wo1Np6oWntS/502Bu1h9dEIwmmd9/CKuT97LMcHRl+GFbScNWC2+qhz
	yz3i9fZKgcLGIQ+L80G6GYgAp0NFj485yKZTSWX8yXj1zkE+n7ZgO36jlP0F/GQZbVN03H
	O+owmC60nrmS0LfYCoiggnqGp2kqQ0NrdmyBNXywXD3d2jDG3pIhgi0XRB9aWg==
Date: Tue, 27 Feb 2024 16:24:22 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
Message-ID: <20240227162422.76a00f11@bootlin.com>
In-Reply-To: <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	<20231130174126.688486-3-herve.codina@bootlin.com>
	<CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
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

Hi Saravana, Luca, Nuno,

On Tue, 20 Feb 2024 16:37:05 -0800
Saravana Kannan <saravanak@google.com> wrote:

..

> >
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index a9a292d6d59b..5c5f808b163e 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * Wait for any ongoing device link removals before removing some of
> > +        * nodes
> > +        */
> > +       device_link_wait_removal();
> > +  
> 
> Nuno in his patch[1] had this "wait" happen inside
> __of_changeset_entry_destroy(). Which seems to be necessary to not hit
> the issue that Luca reported[2] in this patch series. Is there any
> problem with doing that?
> 
> Luca for some reason did a unlock/lock(of_mutex) in his test patch and
> I don't think that's necessary.

I think the unlock/lock in Luca's case and so in Nuno's case is needed.

I do the device_link_wait_removal() wihout having the of_mutex locked.

Now, suppose I do the device_link_wait_removal() call with the of_mutex locked.
The following flow is allowed and a deadlock is present.

of_overlay_remove()
  lock(of_mutex)
     device_link_wait_removal()

And, from the workqueue jobs execution:
  ...
    device_put()
      some_driver->remove()
        of_overlay_remove() <--- The job will never end.
                                 It is waiting for of_mutex.
                                 Deadlock

A call to of_overlay_remove() from a driver remove() function is perfectly
legit. A driver can use some overlays and it is already supported.
For instance:
  https://elixir.bootlin.com/linux/v6.8-rc6/source/drivers/of/unittest.c#L3946

Unlocking/locking the mutex for the device_link_wait_removal() call opens
a window with the mutex unlocked.

What are the consequences of this mutex unlocked window during this
of_overlay_remove() call?

> 
> Can you move this call to where Nuno did it and see if that works for
> all of you?
> 
> [1] - https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com/
> [2] - https://lore.kernel.org/all/20231220181627.341e8789@booty/
> 

If the unlock/lock can be done, I plan to unlock/call/lock in the beginning
of free_overlay_changeset():
--- 8< ---
@@ -853,6 +854,14 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 {
        int i;
 
+       /*
+        * Wait for any ongoing device link removals before removing some of
+        * nodes.
+        */
+       mutex_unlock(&of_mutex);
+       device_link_wait_removal();
+       mutex_lock(&of_mutex);
+
        if (ovcs->cset.entries.next)
                of_changeset_destroy(&ovcs->cset);
--- 8< ---

I prefer that location (drivers/of/overlay.c) instead of Nuno's one because
of the unlock/call/lock need.
Nuno's call is done in __of_changeset_entry_destroy() (drivers/of/dynamic.c)
IMHO, I think it is easier to maintain with this lock, unlock/call/lock,
unlock sequence in the same file (i.e. drivers/of/overlay.c).

Didn't test yet this modification as I need to setup one of my boards in the
right context to reproduce the issue on my side.

Also, I need to take into account some other comments received.

Best regards,
Hervé

