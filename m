Return-Path: <linux-kernel+bounces-86792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9886CADE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF101F2384E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289A212EBD0;
	Thu, 29 Feb 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YiZL+a3X"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91A7E11C;
	Thu, 29 Feb 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215228; cv=none; b=b5EP88rFbwLHsfBF22rnHQfWO8Sylx5IK7FZc7aAZfEKjWKXQKBAzzmaKV35VrRNK3rsPWLkjwmfPPEP79pHctNhkQmZuMfhULqHTjis/WX48OoteP/zD/tJYBFHHI46mo0RyApLJLB/EXjty2RtsfAce7SNgcF3e2/voOYgg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215228; c=relaxed/simple;
	bh=9aTKfiP16X2IfNlrgDgZsUeZoHQ/POniTIXliywY110=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9I7OxFz0mQlAWFJt86BzDaM9BmuhjS93qhO4sjFU/zzpf8D1/HehrYvQ9eBjg6kwROmOS7EgxlZoHCsjWnaIfO9zcjCTTyRRdddGfQDmhVhhOqI4zL+rkuehtZFLTp00VsWzyUxWJxSpX10VUG4euTIsKTLcSzDl1+JogGXT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YiZL+a3X; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11B8620016;
	Thu, 29 Feb 2024 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709215221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSOPpxQOP4tSJrjvsMisvQMfvQyAh9en8MuxIImByDQ=;
	b=YiZL+a3XES1qyOHC+3RPd4Wicyg9/e1BDpmcZlQI10R7AwwJpKtJLLcBDZK8qRWGwmIoyI
	SMf2A8WVH+r3icOonZL9CUwLpHnp2JXqzeOGSTWaOmNLL8v6W+Ua53IT3KShINy0TeJNKp
	6tWeQF0+S/vkqqqKdvq7cxffnMYRPgzGegiPmh5bv0zbUEVCMH2zfsZQWpclBNpVHMw/uz
	uwFONn9LTssn8EFc6tjvtOLL1QXz7E2q4SPrkRbCY3S0C0pweVnATMxq92LQgXqDbJTXGi
	2Gs/7mGeAaswXnhWHp5u+gnTGZIkyznmECNYZN+c7lWPZKMaWVVXg2w+UUvHgw==
Date: Thu, 29 Feb 2024 15:00:19 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
 <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] driver core: Introduce
 device_link_wait_removal()
Message-ID: <20240229150019.07e6f7be@bootlin.com>
In-Reply-To: <CAJZ5v0jwXiJU6SMwHZUJ0RVhGTmiwX1ijx4UcgbYdM6SnftSfA@mail.gmail.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	<20240229105204.720717-2-herve.codina@bootlin.com>
	<9cc3d11bc3e1bb89a1c725f865d0c8d1494111c5.camel@gmail.com>
	<CAJZ5v0hGfqrczS1Si8Bu67vTSkTKO_gO7ftO2R7CQxGKGWsbAA@mail.gmail.com>
	<af8a97f3a187cc403b6184948d3e335ee83f44ec.camel@gmail.com>
	<CAJZ5v0jwXiJU6SMwHZUJ0RVhGTmiwX1ijx4UcgbYdM6SnftSfA@mail.gmail.com>
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

Hi Rafael,

On Thu, 29 Feb 2024 14:10:58 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

..

> > > > > +void device_link_wait_removal(void)
> > > > > +{
> > > > > +     /*
> > > > > +      * devlink removal jobs are queued in the dedicated work queue.
> > > > > +      * To be sure that all removal jobs are terminated, ensure that any
> > > > > +      * scheduled work has run to completion.
> > > > > +      */
> > > > > +     drain_workqueue(device_link_wq);
> > > > > +}  
> > > >
> > > > I'm still not convinced we can have a recursive call into devlinks removal
> > > > so I
> > > > do think flush_workqueue() is enough. I will defer to Saravana though...  
> > >
> > > AFAICS, the difference betwee flush_workqueue() and drain_workqueue()
> > > is the handling of the case when a given work item can queue up itself
> > > again.  This does not happen here.  
> >
> >
> > Yeah, that's also my understanding...  
> 
> Moreover, IIUC this is called after dropping the last reference to the
> device link in question and so after queuing up the link removal work.
> Because that work does not requeue itself, flush_workqueue() is
> sufficient to ensure that the removal work has been completed.
> 
> If anyone thinks that it may not be sufficient, please explain to me
> why you think so.  Otherwise, don't do stuff to prevent things you
> cannot explain.

I will move to flush_workqueue() in the next iteration.

Thanks for the review and the confirmation on this topic.

Best regards,
Hervé


