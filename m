Return-Path: <linux-kernel+bounces-71056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74D85A01C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917F1281CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9424B4A;
	Mon, 19 Feb 2024 09:47:11 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A772376D;
	Mon, 19 Feb 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336031; cv=none; b=n2x+ET1A6+oGyNi2DbUR2wO1Rus8vpsglJLJOTsAh7TCjAYBhRmUtyOAKQVDws2zwTvWogKvsd/2MSGznWVwwXwguOulNZbWUR5xHQ2k23QO4YN0H76r3cxqo3AuIHGtewFYFDnQugg8D7SZjzQNggUdp2AI8i3qCD3rxtb9TwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336031; c=relaxed/simple;
	bh=m/4dznxbgBSFJZQTFF0vW86u26Oju2apBeu/wmtxlwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKNhzCe6v4aU1TNEu3VJ1sOUVMnQaLSgfvGVTYuAQ20HdMlFt4jjXbAU5qJvnJ/tWS/rEn12lArLsk6LlabY4UVllIij3M+Z2pQMp69xX2PzD7RYfyDmvTOG3ah+aUF57wJ7bXfyj5qQw33PsTl9DXrdaHKX5qLlvG9s+ux/uGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5649f396269so412849a12.1;
        Mon, 19 Feb 2024 01:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336028; x=1708940828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqiQ7pV/qcZKf6d4gul+rJPooKYa9MwYrv6emu52dJ8=;
        b=boT1KYGConn4hUHlhfZyhDioBktJwgGq5gXZgluR79EqMMYQamN8y4rF9+AH+rdWRo
         Sna865LV1/8+14WYsPhdiOMj6b66YJN1wKpfcu7zp2Y5eLqz78PoPPvvKa4tXjGWyM0L
         jx7vJGrLyxeARjdk4NdO8ErLSRZ39Xrtjl0DI8zrdx2kyiC1Y6yxXDzJBw40eUi96fgq
         5nlF4oUNUVvkKBvSpvPMj+fVFIq6t4Hem2s9ftBdTbWawVq2v/uxMMqCCHR4QuYTFPjH
         r03liGsif3fdyJ9Q7cPE8FFdNd998kpWrd3HyDu8H7SVOmlufwI5YlTushDe2gPXH7Eh
         KBbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc3E0bsh3yBfICJaBRXkZBMPgDQA3znTFuYDjkr/F3VEaHXVDiD+aMX71GYYsp6cLSEjUolkKXWunffpe4YeLdpd71HG1OnvQDlUiQ3AwVcIZ4RoRHUf3RUagxypy2SFKth7bR
X-Gm-Message-State: AOJu0YxWguJtkIbs+EldYRS+04VbqxNG8Q0kBf9wtT5Z4BPFzOqjieLV
	X0K13eHPfbcYtOL04NA/B8eXVtDrxaSx5VP9TVfZxgpZ9xbQKNHr
X-Google-Smtp-Source: AGHT+IGrf2XT7kEij2cA5DQcyRl8OmqiUJYtyL1g3O7j/oOvVAnKImAftHzbHgSYZE3imIhHjh8dmA==
X-Received: by 2002:a50:cb88:0:b0:563:d237:4e1c with SMTP id k8-20020a50cb88000000b00563d2374e1cmr8211176edi.8.1708336027759;
        Mon, 19 Feb 2024 01:47:07 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id i26-20020a50fc1a000000b005603dea632esm2543825edr.88.2024.02.19.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:47:07 -0800 (PST)
Date: Mon, 19 Feb 2024 01:46:16 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <ZdMjaCSKFSkAoDOS@gmail.com>
References: <20240216094154.3263843-1-leitao@debian.org>
 <20240216092905.4e2d3c7c@hermes.local>
 <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com>
 <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>

On Fri, Feb 16, 2024 at 07:45:37PM +0100, Eric Dumazet wrote:
> On Fri, Feb 16, 2024 at 7:41 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 2/16/24 09:29, Stephen Hemminger wrote:
> > > On Fri, 16 Feb 2024 01:41:52 -0800
> > > Breno Leitao <leitao@debian.org> wrote:
> > >
> > >> +static bool netdev_uses_bql(const struct net_device *dev)
> > >> +{
> > >> +    if (dev->features & NETIF_F_LLTX ||
> > >> +        dev->priv_flags & IFF_NO_QUEUE)
> > >> +            return false;
> > >> +
> > >> +    return IS_ENABLED(CONFIG_BQL);
> > >> +}
> > >
> > > Various compilers will warn about missing parens in that expression.
> > > It is valid but mixing & and || can be bug trap.
> > >
> > >       if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IFF_NO_QUEUE))
> > >               return false;
> > >
> > > Not all drivers will be using bql, it requires driver to have that code.
> > > So really it means driver could be using BQL.
> > > Not sure if there is a way to find out if driver has the required BQL bits.
> >
> > There is not a feature flag to be keying off if that is what you are
> > after, you would need to audit the drivers and see whether they make
> > calls to netdev_tx_sent_queue(), netdev_tx_reset_queue(),
> > netdev_tx_completed_queue().
> >
> > I suppose you might be able to programmatically extract that information
> > by looking at whether a given driver object file has a reference to
> > dql_{reset,avail,completed} or do that at the source level, whichever is
> > easier.
> 
> Note that the suggested patch does not change current functionality.
> 
> Traditionally, we had sysfs entries fpr BQL for all netdev, regardless of them
> using BQL or not.
> 
> The patch seems to be a good first step.

Thanks Eric. I agree it solves the problem without creating a new
feature flag, that could also be done, but maybe less important than
this first step.

Hoping this is OK, I am planning to send a v2 adding the extra
parenthesis as reported above. 

Thanks

