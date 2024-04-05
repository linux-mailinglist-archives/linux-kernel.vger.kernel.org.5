Return-Path: <linux-kernel+bounces-132813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCAD899A98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97C7B21C0C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA81649A8;
	Fri,  5 Apr 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc/f4u4D"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CB161B52;
	Fri,  5 Apr 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312440; cv=none; b=DtCpjMd2K/lRMr0vuQZFOC3n9dDz0BLVTY3lIHZhNaS1z3siQdyMwGtXicuEv7yFnZmuJBK1jFH7KvbhSt8xd3Uzi5UQxnAGN3DQUrU+koB6uR808CVRDVaizjbDeXwav6CadKVw0LPcV44vVMou93mGx0TwjshoMxMTS85KWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312440; c=relaxed/simple;
	bh=epDKG6z8Wys76tNckad5xGVbR4DAr0bp6dvNStvP1C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJTBn5ZPjZ6fUo9MTiunMYMVVEyBRFDDf3OuePTNuCGmFMcsCJE/t7Z3cLxzocjSS1eAKiMM/f022SFxKG82tzpmylRAgod56EoBfuNfYk09+VJKUHPRW9xs/iOdvZNweetjNywHrWesvkG/DVDQmx93yNlKsMv18PUxSZVATxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc/f4u4D; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51addddbd4so6350066b.0;
        Fri, 05 Apr 2024 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712312437; x=1712917237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38SWrSmTZWs7KDa7oBODYF0O5nAtrKs9S3NxjeSZaq4=;
        b=cc/f4u4DCdZeMgtMvIq9Wyfk2GHINXpdfGHt/crOfk0EB1SSD/cDAsmFGxHB8atXK5
         CMfDbOa4H3icYPeYmJ968fluaDfdYAB2FqQLsjSVIqL1MAEFf5UWXb1tFOk6J1yx25xO
         GvPyjyvG7utA5MZnD67txisGErUlN+eeAovdPczwnBVoGj52aWm1GseIPwJ4o1TTpC+h
         3VAUllZWDdK8zl3l861Avtocl1W+6AL3Q99ddP3aIzIqbzL13HgDWplVVkOhaT1Tfcd+
         nFUYletAFlji2lDo4eZR6SA5fdWcCo77RDDF8FvGPQ/hkA5eU19/tNXJcEsiGXjFMgic
         vyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312437; x=1712917237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38SWrSmTZWs7KDa7oBODYF0O5nAtrKs9S3NxjeSZaq4=;
        b=ko2kGZ9Oa8Rp95WD8cbcNNZKWF1afwGNsFb/ooneI/TsqxwLVN07LIz3jzvmR79YHd
         /5R62jH2cBwd3JHsT580J1WQbXd2im/TkQKOTNeIXuJDGqkj27LZSYM+805kFeYgeOTS
         HhtkU0oJ7OMv2LSIKfSb19aacyxtc6EvujvjXuZ9np8LYrL6NY9pwemK8tz1UQKVR4t9
         wUsOohKUfW/2aIhch+dkq3+QTyX5OL8xVZgwVO+XZQbAZhj5oyg3kDbtyPkpyHsS0T4g
         k6vjrg4RSkfA2oN7IUvurB3eEZjrbPA6i9z+e99AN+Ehwv0tVtkMSDkZw6SviMCMLofS
         42iw==
X-Forwarded-Encrypted: i=1; AJvYcCW9CQw3YvdL06Kjxc0tlo2mcZmXGm/k3UVL06Tipz9tQTltLMDrKYg0aLpdViX7zyLx5mFwm8RMP7UzMT+ZXSYe/kArd7mzEH5HLbvCOu7XhlQ6eoQDxJXJnBK7w9TWafcG2Tmr
X-Gm-Message-State: AOJu0Yz2BuIPE4oSlVOmxWkTORGvjkNw4E4vNT1/+DeU55G7k/IS3jS1
	AYeafvthN/SOQMn/dXWg1VNC0glta4YL+46HU61o5bq9hN9rcgPv
X-Google-Smtp-Source: AGHT+IFzAzEM6HnQJr2tKMWx1hqTxU9tn1IAVVfhSzf33DWUScYbAaumh/DzJ+2Ebu854plrEnueXQ==
X-Received: by 2002:a17:906:b213:b0:a46:e8c1:11ac with SMTP id p19-20020a170906b21300b00a46e8c111acmr636309ejz.18.1712312436499;
        Fri, 05 Apr 2024 03:20:36 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id ks13-20020a170906f84d00b00a46d04b6117sm665637ejb.64.2024.04.05.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:20:35 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:20:33 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>

On Thu, Apr 04, 2024 at 06:16:12PM -0400, Joseph Huang wrote:
> > > mcast_flood == off:
> > > - mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
> > > - mcast_ipv4_data_flood: don't care
> > > - mcast_ipv6_ctrl_flood: don't care
> > > - mcast_ipv6_data_flood: don't care
> > > - mcast_l2_flood: don't care
> > > mcast_flood == on:
> > > - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
> > > - Flood all other IPv4 multicast according to mcast_ipv4_data_flood
> > > - Flood ff02::/16 according to mcast_ipv6_ctrl_flood
> > > - Flood all other IPv6 multicast according to mcast_ipv6_data_flood
> > > - Flood L2 according to mcast_l2_flood
> 
> Did you mean
> 
> if mcast_flood == on (meaning mcast_flood is ENABLED)
> - mcast_ipv4_ctrl_flood: don't care (since 224.0.0.x will be flooded anyway)
> ...
> 
> if mcast_flood == off (meaning mcast_flood is DISABLED)
> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
> ...
> 
> ? Otherwise the problem is still not solved when mcast_flood is disabled.

No, I mean exactly as I said. My goal was not to "solve the problem"
when mcast_flood is disabled, but to give you an option to configure the
bridge to achieve what you want, in a way which I think is more acceptable.

AFAIU, there is not really any "problem" - the bridge behaves exactly as
instructed given the limited language available to instruct it ("mcast_flood"
covers all multicast). So the other knobs have the role of fine-tuning
what gets flooded when mcast_flood is on. Like "yes, but..."

You can't "solve the problem" when it involves changing an established
behavior that somebody probably depended on to be just like that.

> > Yep, sounds good to me. I was thinking about something in these lines
> > as well if doing a kernel solution in order to make it simpler and more
> > generic. The ctrl flood bits need to be handled more carefully to make
> > sure they match only control traffic and not link-local data.
> 
> Do we consider 224.0.0.251 (mDNS) to be control or data? What qualifies as
> control I guess that's my question.

Well, as I said, I'm proposing that 224.0.0.x qualifies as control and
the rest of IPv4 multicast as data. Which means that, applied to your
case, "mcast_flood on mcast_ipv4_ctrl_flood on mcast_ipv4_data_flood off"
will "force flood" mDNS just like the IGMP traffic from your patches.
I'm not aware if this could be considered problematic (I don't think so).

The reason behind this proposal is that, AFAIU, endpoints may choose to
join IGMP groups in the 224.0.0.x range or not, but RFC4541 says that
switches shouldn't prune the destinations towards endpoints that don't
join this range anyway: https://www.rfc-editor.org/rfc/rfc4541#page-6

Whereas for IP multicast traffic towards an address outside 224.0.0.x,
pruning will happen as per the IGMP join tracking mechanism.

