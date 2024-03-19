Return-Path: <linux-kernel+bounces-107680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557487FFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DCE282551
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB4A651A1;
	Tue, 19 Mar 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nyJamMJW"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CD56776;
	Tue, 19 Mar 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860167; cv=none; b=ia+drBUHwkAk6s4ynqnZt4PoDW+81suzoli7PGRlMsQaiRN/zs4VcoHkP5ZngvbxbWTr46vNIWVzn6Lwmwd2SgCzkp+2Ir7WJhd6lHCDrpxL4azI29vPTmpjnk7dAvlGdVJODOmFoncHgPMPAELHUfZCRYpDHXwI+F9Ogsz+u+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860167; c=relaxed/simple;
	bh=MiwAs8rYwP47L2Dl9/eQYeyGQlYMgElvD/3OJmd+Bbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJQnWLtJEZuo3BfrMpqHWL8/wjDZL+AQbAWdp576FBEA1HYWbMkYnG4gDxG1rLiMZeCciHTBny9ABh42asVrB/y1NYzORlY0T+b5SO8WzA6ON729RPW30XkDtGnSmwl2Z+TGVoH3q0wDwUYZESDUqLGhOrh3bNgNpVA8Fd8Of6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nyJamMJW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46AD4E000C;
	Tue, 19 Mar 2024 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710860159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMCPTFu5zeWM0duV1ZpFr1rfdopav67r3tSZ4qxLDE8=;
	b=nyJamMJWhCZ/c6iAgV8MwsO/5Tdw7PcSEFJJR6iplaI+OR59+2vzYIqKeOFhBFGnQbqx3Z
	4h1Av5Mm19F2wnHjBN7dxcwsd5HHSsDfew7AVjUmS/TwyNfjchaSqX4M3h9VOfqdEQzHaJ
	OL7xxrT74eyhM8bCCNxIKCepE/IbSjhjDSHHSnHr8Mnuf0cmuBKOB/YBK5lxnv89xT49Bu
	sPa9IUR4WZl+ID78T+3+0f65liqqoeKsnIIt/cyMmwkKx4Ea6/vx6f6z8LSOlF0m+XFuZC
	9U1z37LA0TS+JlS+HiRAPCQlmISGlyyXcv0Oc8OxDuzWE8CrXGkM7echvB8gCA==
Date: Tue, 19 Mar 2024 15:55:58 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-kernel@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] driver core: Keep the supplier fwnode consistent
 with the device
Message-ID: <20240319155558.056e22f1@bootlin.com>
In-Reply-To: <20240108142302.7ecd2705@bootlin.com>
References: <20231114074632.192858-1-herve.codina@bootlin.com>
	<2024010436-bulb-direness-5582@gregkh>
	<20240108142302.7ecd2705@bootlin.com>
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

Hi Saravana,

On Mon, 8 Jan 2024 14:23:02 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Greg,
> 
> On Thu, 4 Jan 2024 16:39:49 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Nov 14, 2023 at 08:46:32AM +0100, Herve Codina wrote:  
> > > The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> > > fwnode's consumer links") introduces the possibility to use the
> > > supplier's parent device instead of the supplier itself.
> > > In that case the supplier fwnode used is not updated and is no more
> > > consistent with the supplier device used.
> > > 
> > > Use the fwnode consistent with the supplier device when checking flags.
> > > 
> > > Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > > Changes v2 -> v3:
> > >   Do not update the supplier handle in order to keep the original handle
> > >   for debug traces.
> > > 
> > > Changes v1 -> v2:
> > >   Remove sup_handle check and related pr_debug() call as sup_handle cannot be
> > >   invalid if sup_dev is valid.
> > > 
> > >  drivers/base/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 4d8b315c48a1..440b52ec027f 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -2082,7 +2082,7 @@ static int fw_devlink_create_devlink(struct device *con,
> > >  		 * supplier device indefinitely.
> > >  		 */
> > >  		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
> > > -		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
> > > +		    sup_dev->fwnode->flags & FWNODE_FLAG_INITIALIZED) {
> > >  			dev_dbg(con,
> > >  				"Not linking %pfwf - dev might never probe\n",
> > >  				sup_handle);
> > > -- 
> > > 2.41.0
> > >     
> > 
> > Is this still needed?  If so, how come no one is noticing it?
> >   
> 
> I think it is. At least, I don't see anything that make this patch obsolete.
> 

Any opinion about this patch ?

Best regards,
Hervé

