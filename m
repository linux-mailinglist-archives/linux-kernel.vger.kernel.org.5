Return-Path: <linux-kernel+bounces-77981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C6860DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC18828515D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CCA22626;
	Fri, 23 Feb 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PIjLVPmn"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E81B7E7;
	Fri, 23 Feb 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679482; cv=none; b=i8Cr89g/MwD2hH6eNOzfvqGDlan4dXJT4wECV8mMupJRjjQVOsZlU1LD4kbncAkNU0VPyS5EJleAZkqaFYhcMIQwK1Q2VD+mw62qLeJiVzX3rpaJhFvYjceDqlgFu69M0X/YsU91EgMAuIVGbRFOg8FHavR0XQgTutBe3KfeANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679482; c=relaxed/simple;
	bh=c6onSyFsMg3VwKDt1Z8AV61DOB0LoijW6PGiv843Oec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3CFI+xS5LYES3U5POczDACGNeOqc4hbvnYC2Ff1bIVfWqzfhkCz3sh6/TbMTm84qrC1iyMeMnc3X7vYxJLG4FzlSfVmH+ztcssCcbA2stGoWZ8n9Ux8DlC/syrRqK/we71Tb/AOa3j5iLayzfRfHbMKE9OwomFkgzsLVRmJyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PIjLVPmn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49B841C000F;
	Fri, 23 Feb 2024 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708679477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sD1N4nDxW3Kd7KG9bWK0FIKYBY/2uMXk37wAWE+LS/U=;
	b=PIjLVPmnfC/iqoqSoMCF5u2pKpBi5sDeNm97LbgFakhJCyFY4ICTwn/KW9ngfa25LWXa0Q
	KRynmBiATSMop30LmLAZL4hc0z01TZa/ey14/DuhZYgvbRNUAQZa4jBse7PaZ6cZITuiUd
	YjVYtbI1x2n82K8bx/b735W0K8NZb1Vuq0jZCs02gY1ai2SC833Jag+aNKFaLmwV2BQCBE
	W9XFrMyZERIjlrMh1bsHoQTOe1e9rt7s66wd/y7d2WzPGhTRNbviFdzWuuXfyTgFpm4394
	SG99hXS/8QuVgJT3SktgkWxFjoSzAAqleRFYyEg7BCQ7BGXymS44hKpdIo9Dgw==
Date: Fri, 23 Feb 2024 10:11:15 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH 1/2] driver core: Introduce device_link_wait_removal()
Message-ID: <20240223101115.6bf7d570@bootlin.com>
In-Reply-To: <CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	<20231130174126.688486-2-herve.codina@bootlin.com>
	<CAGETcx9uP86EHyKJNifBMd23oCsA+KpMa+e36wJEEnHDve+Avg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
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

On Tue, 20 Feb 2024 16:31:13 -0800
Saravana Kannan <saravanak@google.com> wrote:

..

> > +void device_link_wait_removal(void)
> > +{
> > +       /*
> > +        * devlink removal jobs are queued in the dedicated work queue.
> > +        * To be sure that all removal jobs are terminated, ensure that any
> > +        * scheduled work has run to completion.
> > +        */
> > +       drain_workqueue(fw_devlink_wq);  
> 
> Is there a reason this needs to be drain_workqueu() instead of
> flush_workqueue(). Drain is a stronger guarantee than we need in this
> case. All we are trying to make sure is that all the device link
> remove work queued so far have completed.

I used drain_workqueue() because drain_workqueue() allows for jobs already
present in a workqueue to re-queue a job and drain_workqueue() will wait
also for this new job completion.

I think flush_workqueue() doesn't wait for this chain queueing.

In our case, my understanding was that device_link_release_fn() calls
put_device() for the consumer and the supplier.
If refcounts reaches zero, devlink_dev_release() can be called again
and re-queue a job.

In device_link_wait_removal(), I don't want to break this kind of
recursive removal.

Maybe I missed something.
Should I still change to flush_workqueue() ?

Best regards,
Hervé

