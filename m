Return-Path: <linux-kernel+bounces-118303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB188B778
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D021F3F2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73253DABF7;
	Tue, 26 Mar 2024 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="nsrRNCa0"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607D79F3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420533; cv=none; b=qr8TBlyOZNOKS6u5azbu5EBfV/rT2kVO/xf2/fUqJJD9BI/Qcg0TeKw1GiKOaot15hemWKz7/VWYp8xcEDZ/cYiGbPQ9dLMJpePrc8lk2B9ik9uWaGSvB0mHxwAmVEXmpBaQNJheefh9E0swlHQ6oH5dai2EQoyUAhj84BD/3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420533; c=relaxed/simple;
	bh=KrqgeqQ69ysRMhocLmGqwoihzJ7ZoT9lykNpWpq0ujY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ5kLto+e93QeTAvZRmVHw+/m5OycGyFY88JlS1xJILAok7gXhrzuf/aQx9x4ce5b5cG8PSeIUvvdYrUCWK8gj33o/cfa7RYZccRJqIGvitxlGNRv+ftC8wSqrleIwi9b12qxJwg4h4NxQq3U8ypOI9JhQ6Pi+e09bG/j1qVf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=nsrRNCa0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Tue, 26 Mar 2024 13:31:43 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711420528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3XTjegj+eaYi+N9Zpt1T+o/loSSarSWNu0tvvxmWch0=;
	b=nsrRNCa0+ob1yUhW+qGncfO56QlhsyFjVS0edXC62PyX9rplVGRB3RQks6+flW4QthRuhd
	DJWDW/9AT+8o+Csd7oK5YMte+SKPq/HegUXTsF21Xymazor+zFRS2s8pgNtmF2Mmgj7Wy1
	arQCjwUKFVhfRofuCczT0geXuNYGfKK9Ztu+AFeMmMGsvckozNO+RWRlaG8xIhqQHCYKnK
	PSag61zM37z+foKjwIqKzPbaXNH1dheNHG1U1+pf6BUrvXArIauRLmvR1VqSZR/Jitghb0
	MEHxWSUX3HjyCaDdoirqOhpSrGgazVN0y0M9dtY+2904UXiptM5Gv3TeH1irAQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <ZgIzjwMEur8g1rsl@titan>
References: <20240224052436.3552333-1-saravanak@google.com>
 <ZfvN5jDrftG-YRG4@titan>
 <CAGETcx8+vw0Vr0NWzjOAvxAZ07M4U7BWPAgO9avCngW0-9e_kA@mail.gmail.com>
 <Zf7I65PiOR2wX1Uo@titan>
 <CAGETcx_=MmfgDajM16iJ4Of9Yr2Sy6ZpU=MyhYgnmOJFUTD_oA@mail.gmail.com>
 <ZgIZ4LmFOqdiDJBH@titan>
 <CAGETcx-Emvu41nB3UDnb4Gh2aJEKu_hFcHX89uWnBTnaqvpN8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-Emvu41nB3UDnb4Gh2aJEKu_hFcHX89uWnBTnaqvpN8g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hello again,

On Mon, Mar 25, 2024 at 06:35:45PM -0700, Saravana Kannan wrote:
> Ok, I have a solution. Have the audio-graph-card2 find the fwnode of
> "multi" and mark it as "not a device" by doing something like this in
> the driver. That should help fw_devlink handle this correctly.
> 
> fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;

I have done this:


	struct device_node *node = dev->of_node;
	struct device_node *node2;
	node2 = of_get_child_by_name(node, "multi");
	printk("node2 %pOF %pfw %x\n", node2, node2->fwnode, node2->fwnode.flags);
	node2->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
	of_node_put(node2);

This doesn't do anything, but this does:

	struct device_node *node = dev->of_node;
	struct device_node *node2;
	node2 = of_get_child_by_name(node, "multi");
	fw_devlink_purge_absent_suppliers(&node2->fwnode);
	printk("node2 %pOF %pfw %x\n", node2, node2->fwnode, node2->fwnode.flags);
	of_node_put(node2);

Should I be using fw_devlink_purge_absent_suppliers?

> -Saravana

John.

