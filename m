Return-Path: <linux-kernel+bounces-93831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4F0873552
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00491F25916
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5176029;
	Wed,  6 Mar 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bwroREav"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3896CDCD;
	Wed,  6 Mar 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723240; cv=none; b=FVqw/itcLsc8QHtHaPY6hByQt+7vSuLLPSu+ry/NGqerepL1jB4iIY5LQ6Nvhimn61dnsKm9Ler07HvtD1xagMqi1M2GzEaBZx+8htmYhzuQ7ERDaq4PGxz7KpOdvCfdOrwRDCTFhvuHa9HV/7Umca1z7+zqnXVZKKehxnPsqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723240; c=relaxed/simple;
	bh=TeypHYztStanyeG63312ZYZhlqpeV7uIu2AEyXDDxv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX4DPwwbc9OSN2pF0M2pKPA28hrG8gWPIjkaY+N5XibBMq2x6puQsRAUQekF8NlUAr5fqKb42D/EIZv730yUbIKN2G0kHC8gppoXKRMk0Jw/XsAXQCCum79FyChisvUUf4IePPoXl+rSsoK9btMxbBf8q7pP18s/xpQSclTcG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bwroREav; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56A6F1BF208;
	Wed,  6 Mar 2024 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709723236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIfGVlbA1FFow5uYZDJCt17nXjkwv9ja0Xnzy8zYKwg=;
	b=bwroREavWNoesHITsTtxo5nGKtTkiEl3iUl3Cgs62Z7ke4ai6/wPmPA1ZB3KJL3PJbRZKN
	dvHRenJRQkqLszi4TQfOpR9kdW1jIVnwuQtR0ha5IkfBwdA++v1/mOTq5I+hj6QhfhCFSm
	Y1HSZuwqLSRSHlqaqYZx3IsAhhyKpJ2EYUinnXulj/t3KLPikY0FyNx1uiDxCJ0L043opQ
	M+EwRgyF2V9ZQ0CBkRe/U3Z2V+N+uqcf7swidw+dAx2Nrh9b7SHnAgO7ZccdEnEOY98KhH
	wNmwLz3go2zkv8/PvQ5j63ftEWzVUIwDo63qIGBCqPqHfdcsnLDYXhvoebp6zQ==
Date: Wed, 6 Mar 2024 12:07:13 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Nuno Sa <nuno.sa@analog.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] driver core: Introduce
 device_link_wait_removal()
Message-ID: <20240306120713.6d7b9344@booty>
In-Reply-To: <20240306085007.169771-2-herve.codina@bootlin.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	<20240306085007.169771-2-herve.codina@bootlin.com>
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

On Wed,  6 Mar 2024 09:50:02 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> introduces a workqueue to release the consumer and supplier devices used
> in the devlink.
> In the job queued, devices are release and in turn, when all the
> references to these devices are dropped, the release function of the
> device itself is called.
> 
> Nothing is present to provide some synchronisation with this workqueue
> in order to ensure that all ongoing releasing operations are done and
> so, some other operations can be started safely.
> 
> For instance, in the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
> 
> During the step 1, devices are released and related devlinks are removed
> (jobs pushed in the workqueue).
> During the step 2, OF nodes are destroyed but, without any
> synchronisation with devlink removal jobs, of_overlay_remove() can raise
> warnings related to missing of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2
> 
> Indeed, the missing of_node_put() call is going to be done, too late,
> from the workqueue job execution.
> 
> Introduce device_link_wait_removal() to offer a way to synchronize
> operations waiting for the end of devlink removals (i.e. end of
> workqueue jobs).
> Also, as a flushing operation is done on the workqueue, the workqueue
> used is moved from a system-wide workqueue to a local one.
> 
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

