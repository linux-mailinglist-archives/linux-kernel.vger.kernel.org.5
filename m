Return-Path: <linux-kernel+bounces-94346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54546873DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9B5B22CED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2F13BAF9;
	Wed,  6 Mar 2024 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LtT7u0aU"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE58135A5B;
	Wed,  6 Mar 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747177; cv=none; b=lv3meiuCj0p9BugBFjOI4EI6btyxHcQVKZlmsB+yPUQJlMkoJN7iRjcWt7fhsoeec2h/zlnHaFX4FPlneo6FrP1HpiiyzNhL4YePY4NZqSECW76PS8n55M9DDEPViAPb55dnPnoP5PVbgVh53uyDaJisqEeBStlvnrp3toZ/rEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747177; c=relaxed/simple;
	bh=VTEgi30FbwNlL4FbYg7JVPoXMEZ94IoTaaIvVhCiH2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvmSkOMg8FQLcuX9Uh2bVj99FpblqyBb3u1jeanzzdgPbWWGmILxWD4KCj/qAZJ6PiH3nih2GwBAJu0J62BUSVQSB80+aVKuWYfx7G3AypnolKEK6x6iCXWNthuzBau/AjWS3fElN9MpuebT/wMYddmvk+ONS2w9TQDsBSJwCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LtT7u0aU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D73E60004;
	Wed,  6 Mar 2024 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709747173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Idele/8qXZRgSYp7F56voFjVrzpXCoT8VmNU5ueySCU=;
	b=LtT7u0aUPYz/2P00L0hev/DeNZRJtF/aa0hlfQMSIWJ/xJLluah5IUILkRiNVDobjxMZz2
	k19P5OupxpbdBocA4PFC/v6s4bDyhZc6EEh3qhk4BmQ8R66nPFINNs5T9T8JbKwnclj9dX
	RL+4C8hpZgDDTvR51xwjWZuKp+GzK2//sbDwhcRJLDY+yhfk7q8EV8cvnSK5whU0Hoqhu6
	VH1+bU9iG8o2foDne+gB8PI9RRwR3GhetzDj/+DLcATkoFC1Soh18En8d9N79SpS+dTq8K
	ynJJh1sZpzRSSlYEVYn3hfss4fs+82d2lmgEYox1qUqyy1QqsMKMco7wO+TFRQ==
Date: Wed, 6 Mar 2024 18:46:11 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/5] net: wan: Add support for QMC
 HDLC
Message-ID: <20240306184611.0cea20af@bootlin.com>
In-Reply-To: <20240306082230.7ecf207b@kernel.org>
References: <20240306080726.167338-2-herve.codina@bootlin.com>
	<20240306105651.1210286-1-rkannoth@marvell.com>
	<20240306143743.5732b298@bootlin.com>
	<MWHPR1801MB191837C8907B39F67893F0BBD3212@MWHPR1801MB1918.namprd18.prod.outlook.com>
	<20240306082230.7ecf207b@kernel.org>
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

Hi Jakub,

On Wed, 6 Mar 2024 08:22:30 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 6 Mar 2024 16:01:48 +0000 Ratheesh Kannoth wrote:
> > > > > +	struct qmc_hdlc_desc *desc = context;
> > > > > +	struct net_device *netdev = desc->netdev;
> > > > > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);    
> > > > Reverse xmas tree    
> > > 
> > > The reverse xmas tree order cannot be used here.
> > > qmc_hdlc depends on netdev, netdev depends on desc.
> > >     
> > ACK. Usually I get comments to split declaration and assignment for
> > my patches in upstream.   
> 
> Yup, that's our general preference, to split the init out of 
> the definition.

Does it mean that I need to update in a next iteration ?

Best regards,
Hervé

