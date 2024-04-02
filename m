Return-Path: <linux-kernel+bounces-128674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15563895DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EE21C232D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB415E1F1;
	Tue,  2 Apr 2024 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3it5SL7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF015D5CB;
	Tue,  2 Apr 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090767; cv=none; b=MuJwYdSRm4YyIWkqVaC4/RiIgFGTyUHZNINIL0ycJmgUaNk0+1OThulSJKHB+FIiYIneAgoC8HYmfADnDJJqMZAUsCAKYh/4whsw5SggkRKk9O9Sn4bIbWIhGmXt3S4lcTsqqMALYUIeQE2cm6FFYXJkgRQqyvhaRxtMlyEtZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090767; c=relaxed/simple;
	bh=5hHpzI6HyHcS+FulCNSl/epqWvWlTMhwAJLmlEdFBcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXXitDVbJSh2AmNBx7tPAFI2EtrmKsxcwWnTMwEj9qklI3j+4XNGHp1RFu0qJwXd7RZXn7dG/FcU9INfEaZoanARoBfGv5v8oVDOoqbTTxdSyM+YMzzXy5rHSECfkiKUitZk+4809qgShuWc2MEu0quKeNt7o9tEayVzc77qkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3it5SL7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4e62f3e63dso330882466b.0;
        Tue, 02 Apr 2024 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712090764; x=1712695564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQiI7BxLmggkQQzq0/Zcf0rP2ERdhgPoF6NdWm8XFzU=;
        b=S3it5SL7wUbjhrjMMiaU5Yg+D5EFLILB0bf3wV+y4jTJgW1PFfrF7lA89KQzJdPZYx
         ogNsa9BziDoqbf2hvhdaYcTgW1wK8k7oIyarp0Ee3wqdE/17hWNsVvor28E90MOMYoLz
         EMnawYeIuiVrLu2IgpD387K5eCmaGOgQBk0/WgR6gyKxXJGkjKyWjTezUBt2NG914LOv
         WQxOXH/trQiDYWOKee/lKzToGLPV2Fy0HLzjLZR6AQoDH6i+V0Cy3UoRMNGtOCYQ1PAZ
         woZiHEAhQNajK63ypJj8eyf8jR1scTUMp+RVdr+mken/ex9KNPq2T9/Bu6O6pSRgw792
         vtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090764; x=1712695564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQiI7BxLmggkQQzq0/Zcf0rP2ERdhgPoF6NdWm8XFzU=;
        b=d0Xpsvqfgz/0WNP/RiDQE2oqOXDrPh/2QlEDkqqsEHmxgcGnouwa8DEqF6E5BkJM70
         HhUIPLc098hI4wtfONX0Fnk6o4R6iOjjOdSeQA81qnTcvzTJGHgIx6VZMlj9vGJS77yg
         opOtzr35JR33CghXsoS6/AMFQmuYOIlqf+vWnByacHlhGXgVF6UKCQ5Y+lFTNik/lym9
         A5CZkNChpN0a37o0cM1ycD/5Efp2d3hrygurmeK1D28JGgqZlDHsB2KHQRN9B96sV8tJ
         i+SgDrk/Avv6QM4RsGseaRhLD+N6RnJ9I5pgZyPseovyLwrGkVTPjD5cBoYUAk/LqF97
         B/5A==
X-Forwarded-Encrypted: i=1; AJvYcCWrvthCz1HD5ObMqfN8ISRWQpIOEzEjNjKOxhvuZQSehEJjhel2JTFViXqn3+k4W86ah8W1rtsuhLQvkzqXxjuQ0xT6O6lINZ6zkN/Q8wWEkzmxsAg5SnhihdQ0UUUrvNnPsnn7
X-Gm-Message-State: AOJu0YyFHzSHZDOYVhqaxOfHdnMiKUQK93zIy/YEMOaJwAin/AhzliCj
	uefXcYGtAl//tOeO2ACuYD4Vb8u/4d+XCkxAL2Iqvo9hNwtqkhoN
X-Google-Smtp-Source: AGHT+IFVmraJ2Ul4LRhcIdzwgvxmCNsrp6LyqCYKiZeHElLm1rMS/EmFJ0j2KzOaa05JxnSRknGnLA==
X-Received: by 2002:a17:906:c42:b0:a47:3526:2e0f with SMTP id t2-20020a1709060c4200b00a4735262e0fmr8185538ejf.75.1712090763903;
        Tue, 02 Apr 2024 13:46:03 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709062a4500b00a4dacd6b8b3sm6967956eje.68.2024.04.02.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:46:03 -0700 (PDT)
Date: Tue, 2 Apr 2024 23:46:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <20240402204600.5ep4xlzrhleqzw7k@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>

On Tue, Apr 02, 2024 at 09:50:51PM +0300, Nikolay Aleksandrov wrote:
> On 4/2/24 20:43, Vladimir Oltean wrote:
> > Hi Nikolai,
> > 
> > On Tue, Apr 02, 2024 at 12:28:38PM +0300, Nikolay Aleksandrov wrote:
> > > For the bridge patches:
> > > Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> > > 
> > > You cannot break the multicast flood flag to add support for a custom
> > > use-case. This is unacceptable. The current bridge behaviour is correct
> > > your patch 02 doesn't fix anything, you should configure the bridge
> > > properly to avoid all those problems, not break protocols.
> > > 
> > > Your special use case can easily be solved by a user-space helper or
> > > eBPF and nftables. You can set the mcast flood flag and bypass the
> > > bridge for these packets. I basically said the same in 2021, if this is
> > > going to be in the bridge it should be hidden behind an option that is
> > > default off. But in my opinion adding an option to solve such special
> > > cases is undesirable, they can be easily solved with what's currently
> > > available.
> > 
> > I appreciate your time is limited, but could you please translate your
> > suggestion, and detail your proposed alternative a bit, for those of us
> > who are not very familiar with IP multicast snooping?
> > 
> 
> My suggestion is not related to snooping really, but to the goal of
> patches 01-03. The bridge patches in this set are trying to forward
> traffic that is not supposed to be forwarded with the proposed
> configuration,

Correct up to a point. Reinterpreting the given user space configuration
and trying to make it do something else seems like a mistake, but in
principle one could also look at alternative bridge configurations like
the one I described here:
https://lore.kernel.org/netdev/20240402180805.yhhwj2f52sdc4dl2@skbuf/

> so that can be done by a user-space helper that installs
> rules to bypass the bridge specifically for those packets while
> monitoring the bridge state to implement a policy and manage these rules
> in order to keep snooping working.
> 
> > Bypass the bridge for which packets? General IGMP/MLD queries? Wouldn't
> > that break snooping? And then do what with the packets, forward them in
> > another software layer than the bridge?
> > 
> 
> The ones that are not supposed to be forwarded in the proposed config
> and are needed for this use case (control traffic and link-local). Obviously
> to have proper snooping you'd need to manage these bypass
> rules and use them only while needed.

I think Joseph will end up in a situation where he needs IGMP control
messages both in the bridge data path and outside of it :)

Also, your proposal eliminates the possibility of cooperating with a
hardware accelerator which can forward the IGMP messages where they need
to go.

As far as I understand, I don't think Joseph has a very "special" use case.
Disabling flooding of unregistered multicast in the data plane sounds
reasonable. There seems to be a gap in the bridge API, in that this
operation also affects the control plane, which he is trying to fix with
this "force flooding", because of insufficiently fine grained control.

> > I also don't quite understand the suggestion of turning on mcast flooding:
> > isn't Joseph saying that he wants it off for the unregistered multicast
> > data traffic?
> 
> Ah my bad, I meant to turn off flooding and bypass the bridge for those
> packets and ports while necessary, under necessary can be any policy
> that the user-space helper wants to implement.
> 
> In any case, if this is going to be yet another kernel solution then it
> must be a new option that is default off, and doesn't break current mcast
> flood flag behaviour.

Yeah, maybe something like this, simple and with clear offload
semantics, as seen in existing hardware (not Marvell though):

mcast_flood == off:
- mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
- mcast_ipv4_data_flood: don't care
- mcast_ipv6_ctrl_flood: don't care
- mcast_ipv6_data_flood: don't care
- mcast_l2_flood: don't care
mcast_flood == on:
- Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
- Flood all other IPv4 multicast according to mcast_ipv4_data_flood
- Flood ff02::/16 according to mcast_ipv6_ctrl_flood
- Flood all other IPv6 multicast according to mcast_ipv6_data_flood
- Flood L2 according to mcast_l2_flood

