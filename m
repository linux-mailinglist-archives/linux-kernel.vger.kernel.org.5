Return-Path: <linux-kernel+bounces-128446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4193A895AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953CDB28ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780215AAB2;
	Tue,  2 Apr 2024 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeKkoUAh"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F570157E74;
	Tue,  2 Apr 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079836; cv=none; b=m6yifVd15DH5voW1Y2YzIJNOIRe2w7XQruyKwfCQZ21k3Wu1ykhq6eCDDxQM1tXvq4Wizw9NT7IVQTavBw7EA6+VzXqFBRr4yw4supQGG/1kBiMcMIkiAd4hSAmGWy9qomX8Onro21ThEoAvlT8EA+WCQWhIof11+mjA8uLbpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079836; c=relaxed/simple;
	bh=9uFKBEZ+jTSZSHC4IJ8ZjKJhk+5U54ScceL4P119hY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAdP20zVWkxclSipFvQI4+Dffvenxo9ghh8ww72iaJiQl6W3ZmMosgbTex/f8Kh7I0TbCh2WtzhU+8bpqIzyzN6BjmG6JjL4rl3CwBW5E+u5xp764vFAZhRYQUy/ouRfWYSnq28plAFtDQJtymlS7YifALi6LvO5umUX9FBtx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeKkoUAh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4e8904bd71so128904566b.1;
        Tue, 02 Apr 2024 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079833; x=1712684633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1U6HAKXhhezsA9SEW8MoU/AGoBW+xsxrufA0vT6Ds4=;
        b=FeKkoUAhP8efx+DgeKRR5cDO+J4gSI/IJFO+5RxPhXgOz6PbO+CVVviexfYeTin64O
         /ajJ5x1kFXLXj2e0RddTHpv6USb0AEVvw03jIzfvL3mdMthKi94IUBiuxV1n5uqsdY5B
         EJshDyZ5rKdlc/CqWKVZ/tuErssVqr5YjMNkrT+HNWK6oVd99om9pB47uHRhAnqTUN7y
         7cdAko25r2w5sm+jJzSsMIyFHSkfdrUxGAf+PGQtsq51lpi4x7RGYTSYOL0VaDotvha4
         hJdKWnrtO982o1LaHWsOg5ZpKWcTVm1FFwv8WHQf/UEIWvgwXjBjQYkMGU3A17hoAebT
         Bavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079833; x=1712684633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1U6HAKXhhezsA9SEW8MoU/AGoBW+xsxrufA0vT6Ds4=;
        b=pGf6PN34m4SuF1hI8+W4kLfykd4AAmi7AlE7DUdqifuwPBQ3e/lxqqr68TwddS3j62
         2WKNWexIIu+tgc9UkryyzLX5W9C/0xLLHSi8SDyAbMQBciEPnSdTnO/UBEjpsHQy/NW6
         4+H3Ap0uz95PzGByAMTHSuKvi8BBBzEFOhGmOHOFjw0uW4kwVF27yw+VqsfMA4zidHqN
         TyM81QaEQibh4F2VCBs8hAuB6SaJa9te13E2fU+h9zQkze7lmiGUQbGXN15rcqLUROkZ
         8gQLQNWmcSpAHyK0KMe7wIIK+PADKu6gW04PjR+zT1bDj5ORIjip4foAVFc3nEr62Mhb
         ld7g==
X-Forwarded-Encrypted: i=1; AJvYcCXalBsL6oLGKWYp0NlWBV9VJZKYy+SC0VFNAoLHTQpap8PDa4HTtHd+PTD8MnA4jV+GyEJe0i2NMQWZrYiImy8blnmG5V/7dYI+BgIfMar0FEICqkGazxpVItdpWjftvaemQ5TE
X-Gm-Message-State: AOJu0YzmdCw4pf0VMKuhTdRPW4rAVUJhzGMW8ZNWkeDBGqDSW4uQq+DM
	UGwmcvW7bFSYibwQR9wrhV2gJ/sFCYxO5xEZNrxhjfI+JdvneFbQ
X-Google-Smtp-Source: AGHT+IGbjo9a7II81wJZE7yvGIsqmk4ELHWFPT0Xo4t03Mb3LTWDHJDj0Vy415xHzy+PwPE+bj14Lg==
X-Received: by 2002:a17:907:ea8:b0:a4e:51aa:b409 with SMTP id ho40-20020a1709070ea800b00a4e51aab409mr7562662ejc.59.1712079833049;
        Tue, 02 Apr 2024 10:43:53 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm6832789ejb.148.2024.04.02.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:43:51 -0700 (PDT)
Date: Tue, 2 Apr 2024 20:43:48 +0300
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
Message-ID: <20240402174348.wosc37adyub5o7xu@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>

Hi Nikolai,

On Tue, Apr 02, 2024 at 12:28:38PM +0300, Nikolay Aleksandrov wrote:
> For the bridge patches:
> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> You cannot break the multicast flood flag to add support for a custom
> use-case. This is unacceptable. The current bridge behaviour is correct
> your patch 02 doesn't fix anything, you should configure the bridge
> properly to avoid all those problems, not break protocols.
> 
> Your special use case can easily be solved by a user-space helper or
> eBPF and nftables. You can set the mcast flood flag and bypass the
> bridge for these packets. I basically said the same in 2021, if this is
> going to be in the bridge it should be hidden behind an option that is
> default off. But in my opinion adding an option to solve such special
> cases is undesirable, they can be easily solved with what's currently
> available.

I appreciate your time is limited, but could you please translate your
suggestion, and detail your proposed alternative a bit, for those of us
who are not very familiar with IP multicast snooping?

Bypass the bridge for which packets? General IGMP/MLD queries? Wouldn't
that break snooping? And then do what with the packets, forward them in
another software layer than the bridge?

I also don't quite understand the suggestion of turning on mcast flooding:
isn't Joseph saying that he wants it off for the unregistered multicast
data traffic?

