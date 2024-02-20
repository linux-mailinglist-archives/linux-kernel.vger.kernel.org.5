Return-Path: <linux-kernel+bounces-73602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714085C4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BBA1C21B59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F71D14A0B9;
	Tue, 20 Feb 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bCLKgtoF"
Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7D436135;
	Tue, 20 Feb 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457788; cv=pass; b=PB9xUArCO9iHwDNjz13Z5v04Bc4hZh6wcKdnVzbf2ELCxxS4cPronmLtk2o8QG36x67sJlUKIKqfCQIyYlW41MhBbqiKF69FeBq9GglPkoRQtxyXLFUfUGcmZFNLI4Ax69/Pt3XoWQhDY9q0cgJmC1yiPyWprISulrFmAeNXcgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457788; c=relaxed/simple;
	bh=hJt/IYVb0eRDuwpPuHvdH7KdNxea+aTwmt9C56h0Cws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh5pcxiizzsEAGDEkuvSL4wyEseVGCv1Z8JMLvneAPH68dXPWGrC1mb1TGAi4NFUtnb+xPcNa5caay0u8L2bsSYvU5I58elAkVoBpSywYXC9ZEOURlED4jK73iuZhqrGy8rRR1RSt28x19rV0/A0MPUf7TYpADbUPxuX6kXmSts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bCLKgtoF; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 795DBC2827;
	Tue, 20 Feb 2024 19:36:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B5A33C3498;
	Tue, 20 Feb 2024 19:36:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708457778; a=rsa-sha256;
	cv=none;
	b=rq8hwytgf7mfKXDi/jrMKsK0qeveLAg+21O1J0OqhR26kVBhVXZpEGmDShPL2sbwzfNo6h
	TOij+q/41S3xbwvyQmMUZWWwKl79hgkJLCDytUeNkr4uxA3GoOIz+Tf6KsXRh/6cSwGXGZ
	/n7dR7MpEmHeReoGt6od0xgWFfWyUyTKdF7/8Mlkckg8Pz3f3hQTIYNnb8oWQsKzcugKYE
	zWY+VjWD9g/y3Z214qhJDNj1k3/r5Tt8O1qhRLuxCfy5nNGqFNVVGA9we6+8j/v2uUFCk4
	wHBkbz+6txUL6d/cZlFMdvj6NB/tsJ4Hu8Y1DoSUzTFqBsJcy/HQ2dAro1VWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708457778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hJt/IYVb0eRDuwpPuHvdH7KdNxea+aTwmt9C56h0Cws=;
	b=5+WwerzT6sexvjUn0gTAv/2v9cuIVnWsu4m7u04KPJQNZNiTO+oqugObIxEwNEQY+bU6fF
	R01G+Kb7dtW6+uXHYrlzbKMtWHJ8vMPq6EpBOArjSr7OWtQZ2pCMPvjl8J4mQC2hx+hpwb
	0pcCAbJ1mAARqW8m6LCRWqhmcSGZFuRW3gGUusvSlKeCZdOiGbvsE34J9VZDmivr9Ff6OJ
	3KuabrbMYstSyB6R9I7IsFO3h9iWiOSPAqCNY4+SqIpFF49BcwLBKEVZpo+0LsrkVZp38n
	NXh5a8C268Cohfyu2wttF45L4Xas/g49ul8i9S2pVTPFxw363AevUfl8FF+TKQ==
ARC-Authentication-Results: i=1;
	rspamd-6bdc45795d-cxkcq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Keen: 21cbfddf12f86fe0_1708457779192_187779232
X-MC-Loop-Signature: 1708457779192:1768560798
X-MC-Ingress-Time: 1708457779192
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.149.162 (trex/6.9.2);
	Tue, 20 Feb 2024 19:36:19 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4TfV5F37s1zKk;
	Tue, 20 Feb 2024 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1708457778;
	bh=hJt/IYVb0eRDuwpPuHvdH7KdNxea+aTwmt9C56h0Cws=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bCLKgtoFrIDxE9TulzKX03YtzRwqsgpaiO1i9BXGIp+M/aijYBAeHDzbbNlnPTFyc
	 ejaeFhjJd/gZ7Cdex0mXbkKVupxsDRzUyRQfjUFr4a+TS9h85+ECcC0H8pO18k8uIO
	 n70U1MC5zJ7leo2cLL5eCevDb2kcBF+KXkdk7N2r+uAyWDj4anHZheabv8ot3oWU2g
	 2skaS3Y9t+PA+jyqDxj9kc8s/6SB6r6MnCR8wcc9xqDEnQpZIshjC77ywO5yv0tG/A
	 VBCyvesPDEDOfUr+GoumHVd47XY3MrRVlMCopA/GxdHrGfbBklxsCikci5TlS3T+P0
	 Q/tNRI2Y7uAJA==
Date: Tue, 20 Feb 2024 11:36:14 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	mchehab@kernel.org
Subject: Re: [PATCH 5/8] usb: core: hcd: Convert from tasklet to BH workqueue
Message-ID: <20240220193614.b2rbzxmbobp3cbv2@offworld>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	mchehab@kernel.org
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-6-tj@kernel.org>
 <bckroyio6l2nt54refuord4pm6mqylt3adx6z2bg6iczxkbnyk@bb5447rqahj5>
 <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>
User-Agent: NeoMutt/20220429

On Tue, 20 Feb 2024, Linus Torvalds wrote:

>Mauro - the BH workqueue should provide the same kind of latency as
>the tasklets, and it would be good to validate early that yes, this
>workqueue conversion works well in practice. Since you have an actual
>real-life test-case, could you give it a try?

In general I think it's worth pointing out that future conversions should
still aim for an equivalent in task context, and now with disable/enable_work
a lot opens up for regular wq conversions. If users/maintainers shout about
latency, then use BH wq.

Thanks,
Davidlohr

