Return-Path: <linux-kernel+bounces-163199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D048B6718
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEDC1F22377
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F30923BF;
	Tue, 30 Apr 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTF3O4aZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266E10F7;
	Tue, 30 Apr 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438796; cv=none; b=F3Kw6l1dCyTob1J4p6MaUxjVrqQ0Wy3wUiw7jeFVCsnQhEWFrNq0Qqk0HdK2Tub8WF10uursvP9QVdN69GMTQ1XzC+MoM6BWHDDtDDGKdz/oPsKGQQ6AGhJoRkRrYeP3r3fY4G2iUxpXZAi0CFBGamKw8zE8gjTKqEhhm1of6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438796; c=relaxed/simple;
	bh=rZ5Fgvfjroac2GiLwSMgIhQ7CG5p1B8aQRKKwWjaFBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXwKwEJax0lPvpauxjq6TLfRzadAC0YObctwX7mdgSbAx424TNjg5y3IEbsMgfuCNDwppqd7fHtGq+cvb9IddVWiDa0UjlrV9iHgq+F6bL8URh9woPlL7vXs1RIV5nZ6VIuVSAucgucWlhcFVTugcaF34RR006YWUbONV9G+18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTF3O4aZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so6153574a12.1;
        Mon, 29 Apr 2024 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714438793; x=1715043593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AW/wYh4RsDtCMHIZdU80eftqWkVY8DHoSo6I6qnwxU=;
        b=bTF3O4aZB3hqJRffY2sP+enM8lKdpvRk/DxiX6EDcBF6tPyr9fKailVSFW7LRlbdrl
         xZ90mJYvNAMJekb/hcGcRJ9k9Bybs5mk5XuiWpiss0LwBfpOIJ2oNjR0ItBTpeQGCLBN
         CGmbq9vRkIbSk+ZTGD+nmbuUnJbQpDQEspY5Y5l03LZpIXCFzpgfSBVshrsBfPIK9EKm
         PDfu5fL+8K1imQ5NA9bMWddruKj3Y4T25tSIY81jvg6Gl3EfPBG4Rf/+FEBprjf9Hcjm
         ILcjzzoOAVwh+4Th1BK7tkYD9mFIwAnq2+4LyD+XUxdi1m2kVwgTGyDFB/E0tkvaQ7fP
         +ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438793; x=1715043593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AW/wYh4RsDtCMHIZdU80eftqWkVY8DHoSo6I6qnwxU=;
        b=nSz73cYVxYg24pf7L9U3sIoTDETtvMFaglPf+EbBmo5/nG+3Pnm4/kMI6ZD5bOYLQI
         BopxBOl+wmhGxkCiTi0GU+XRzbSj9sxH+FNdFdMQP9tpFQF+dDd8Mae7PlexXPsoq1kG
         iMJVT1/RqVup6f+aa0VMdHp0GibFVWRXBjS4Vaa7Ekv064F/9NbA9bGWrwr3NAPVww5s
         MM4iTXNXJUwgC5k5Lo0cqNvp3KR+lJLQm9uA994tYyifXn8gdUIlIwwdOz6+bI6Vnoou
         VOMwuQN4/zY+tvd7un8rsyoUkYPaEt2wob9Nea+0oUiOf2pNyzm9qCTS8dve3Amoaj/y
         1+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXP1qe6EGq9VfnaiDHomSovFXPwZ4/3HTlGTAzoS8KUkBR7hDTuJKd8IwrafYs1yCp18R4wUTmnhHnfT1oi9rtBAWd8x2QjGNwYMLVIUXxRpuVVLWNJqDjrM+uPwpbmtIqAF+oO
X-Gm-Message-State: AOJu0YxvxJYLeKykgt9SXJan24b97pzYpd95f5sgfJ+R6oVKQ/6VUOW4
	zHAdg27YIbNHkqTxNdgOd9FYp8xiqo4DsKNE8CgJFWvAhM26vfCK
X-Google-Smtp-Source: AGHT+IHdNhQ1o7yqt5336ceWzkBhi+68iQi+cVplWUMRflPGIyCHcqMyO6RMKJHvbgODYQmgqdAYrA==
X-Received: by 2002:a50:d593:0:b0:572:2264:76ec with SMTP id v19-20020a50d593000000b00572226476ecmr8068209edi.2.1714438792982;
        Mon, 29 Apr 2024 17:59:52 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d70a:9c00::b2c])
        by smtp.gmail.com with ESMTPSA id ef9-20020a05640228c900b00571bde3b0a4sm13261791edb.34.2024.04.29.17.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:59:52 -0700 (PDT)
Date: Tue, 30 Apr 2024 03:59:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
Message-ID: <20240430005949.44lcegwhmcetpddm@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
 <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
 <20240405110745.si4gc567jt5gwpbr@skbuf>
 <c4f5c444-832c-4376-845f-7c28e88e4436@gmail.com>
 <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>

On Mon, Apr 29, 2024 at 06:07:25PM -0400, Joseph Huang wrote:
> Something like this (some layers omitted for brevity)?
> 
>                                       +br_iterator
>                                       |  for each mdb
>                                       |    _br_switchdev_mdb_notify
> rtnl_lock                             |      without F_DEFER flag
>  |                                    |      |
>  +switchdev_port_attr_set_deferred    |      +switchdev_port_obj_notify
>    |                                  |        |
>    +dsa_port_mrouter                  |        +dsa_user_port_obj_a/d
>      |                                |          |
>      +mv88e6xxx_port_mrouter----------+          +mv88e6xxx_port_obj_a/d
>                                         |
>  +--------------------------------------+
>  |
> rtnl_unlock

At a _very_ superficial glance, I don't think you are properly
accounting for the fact that even with rtnl_lock() held, there are still
SWITCHDEV_OBJ_ID_PORT_MDB events which may be pending on the switchdev
chain. Without a switchdev_deferred_process() flush call, you won't be
getting rid of them, so when you rtnl_unlock(), they will still run.

Even worse, holding rtnl_lock() will not stop the bridge multicast layer
from modifying its br->mdb_list; only br->multicast_lock will.

So you may be better off also acquiring br->multicast_lock, and
notifying the MDB entries to the switchdev chain _with_the F_DEFER flag.

> Note that on the system I tested, each register read/write takes about 100us
> to complete. For 100's of mdb groups, this would mean that we will be
> holding rtnl lock for 10's of ms. I don't know if it's considered too long.

Not sure how this is going to be any better if the iteration over MDB
entries is done 100% in the driver, though - since its hook,
dsa_port_mrouter(), runs entirely under rtnl_lock().

Anyway, with the SWITCHDEV_F_DEFER flag, maybe the mdb object
notifications can be made to run by switchdev only a few at a time, to
give the network stack time to do other things as well.

