Return-Path: <linux-kernel+bounces-132889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE636899B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4A5B240D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456B16C42D;
	Fri,  5 Apr 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK2/kpTw"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85418659;
	Fri,  5 Apr 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315272; cv=none; b=JCc8eiP2fiKK1py8LyqXKrUa5ZB5CeqO4zov+beRInZzjXJQBgQlkj+HbH2bxMD+hzcwXsLo9ZkH8zg4HmwTVPRMLmez6/SwtY/4vXFeHEcvEwr62CJgXEzoOthY2oDX0Sr7EbxG37WuZMZqRxrVhV05HNWBwa9DtDhLRzhC7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315272; c=relaxed/simple;
	bh=87fmuLbik3W4Ac3ZqTmrh4k5PYq0/NphQip5MWUxITw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgazBHl7MqLli3As6Tj9NyW0bK+/npeYfxenoD52ZK2VEnqdWNMFo3KvMQ81B/ujjc2nnJYjDmllNbEZYPFhIdAMrAXMNVb5EYgbO0I+LtKxiAj78QpcalPtU3+aZrvLUTP5l126fO/eAHJfDzv2K1OVh6ckDLmO1HL64niPNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK2/kpTw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so2106298a12.0;
        Fri, 05 Apr 2024 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712315269; x=1712920069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9xHgLw53zJpmruDx7tv4qUMo9+hzZpsIUuIr1l11KM=;
        b=VK2/kpTwGbuAoa8/qYPTFDhfXX7D9eXhiWT/c0JymtNfLAGckdFxOTAd8qf99Fy5/X
         pTXLmoohWMT0T8e43NaRxi4TA+KVJNzehCynFTS1vrnhyKWy8/W9dVxStbW44Q+B+Hz9
         +hFUmYPZ4jkI6uauOFSHvQNJ8SmfmT2u+/CJug1tGl2FOeCY/TSthcqcra8PNIp/3UhK
         ThdNpBvIkBgNd/QM51NeCO9sShey9y587RudBkhnkKDFXa11NVcqcuzFHRGDvUaTvGgo
         yc9RunG4CHf2KgW0K/MHvg1L6aNlXzJ/bFHa3Dxw86lBeNqvLZ2Aese3JbblZtTCoEEn
         E3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712315269; x=1712920069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9xHgLw53zJpmruDx7tv4qUMo9+hzZpsIUuIr1l11KM=;
        b=w58SOOoFAOV3Raflmc0zkHTtWCG1uA88oP9y6WVB76ZJm6cFJsJdMjFxF84zlq741D
         YvDxPrxtFsYTv6tUezgZeNJG4SuOwwAZIfrvwSl3wBuRiTNUJBZ9B4/7VsweOKpwyOxt
         YtdJmfsS1VfNpjxpIm9ahMO0WcG7VesCouB6fW7q+87h3zlbkzsPs7Mi8+9IZuNBCSd6
         3jV6HsflhTX1qgpPyYeVUwAhOVk9eWR3edZ4bHdikucz1OKSb8G28lHg4flK/Y3Q7qg9
         cr83dSgj0VxHjj5CrL7gt0DuUFg355g5pEQGipoauj5Ab+jNKrI+1fTgjFJZOLRDyNpO
         FtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqFsUAJu5RbK+ATAAEZgoPNeHZ7RrCdQiO6NPXPmGQqDiAg77YpOtpi4P2cY2L099FkiuNs7FsJ6bftuGxxGI2PDbuVkARp84cOlK7fy60o6rJY0FBhva51pL0FGSoyAq6OBrO
X-Gm-Message-State: AOJu0YycssYy9ZnUUp+FbOEXz9xtGzO6Ig3A+dCoAZnrRjBIGJFFAtrc
	132VdbTehnlrwe+pWjAxPhHNv8M0CAgUvtvEAeB3FaJ+0gkHY8rz
X-Google-Smtp-Source: AGHT+IGG1+9Mqc13eWk/3SacISlrxycbkz+FTzpktzUPXrv/hdfTUb1d5xcoorCxuKaN2KMIYlqb4Q==
X-Received: by 2002:a50:9316:0:b0:56c:4db:33f7 with SMTP id m22-20020a509316000000b0056c04db33f7mr829730eda.10.1712315269128;
        Fri, 05 Apr 2024 04:07:49 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0056c2d0052c0sm666532edc.60.2024.04.05.04.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 04:07:48 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:07:45 +0300
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
Message-ID: <20240405110745.si4gc567jt5gwpbr@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
 <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>

On Thu, Apr 04, 2024 at 04:43:38PM -0400, Joseph Huang wrote:
> Hi Vladimir,
> 
> On 4/2/2024 8:23 AM, Vladimir Oltean wrote:
> > Can you comment on the feasibility/infeasibility of Tobias' proposal of:
> > "The bridge could just provide some MDB iterator to save us from having
> > to cache all the configured groups."?
> > https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/
> > 
> > What is done here will have to be scaled to many drivers - potentially
> > all existing DSA ones, as far as I'm aware.
> > 
> 
> I thought about implementing an MDB iterator as suggested by Tobias, but I'm
> a bit concerned about the coherence of these MDB objects. In theory, when
> the device driver is trying to act on an event, the source of the trigger
> may have changed its state in the bridge already.

Yes, this is the result of SWITCHDEV_F_DEFER, used by both
SWITCHDEV_ATTR_ID_PORT_MROUTER and SWITCHDEV_OBJ_ID_PORT_MDB.

> If, upon receiving an event in the device driver, we iterate over what
> the bridge has at that instant, the differences between the worlds as
> seen by the bridge and the device driver might lead to some unexpected
> results.

Translated: iterating over bridge MDB objects needs to be serialized
with new switchdev events by acquiring rtnl_lock(). Then, once switchdev
events are temporarily blocked, the pending ones need to be flushed
using switchdev_deferred_process(), so resync the bridge state with the
driver state. Once the resync is done, the iteration is safe until
rtnl_unlock().

Applied to our case, the MDB iterator is needed in mv88e6xxx_port_mrouter().
This is already called with rtnl_lock() acquired. The resync procedure
will indirectly call mv88e6xxx_port_mdb_add()/mv88e6xxx_port_mdb_del()
through switchdev_deferred_process(), and then the walk is consistent
for the remainder of the mv88e6xxx_port_mrouter() function.

A helper which does this is what would be required - an iterator
function which calls an int (*cb)(struct net_device *brport, const struct switchdev_obj_port_mdb *mdb)
for each MDB entry. The DSA core could then offer some post-processing
services over this API, to recover the struct dsa_port associated with
the bridge port (in the LAG case they aren't the same) and the address
database associated with the bridge.

Do you think there would be unexpected results even if we did this?
br_switchdev_mdb_replay() needs to handle a similarly complicated
situation of synchronizing with deferred MDB events.

> However, if we cache the MDB objects in the device driver, at least
> the order in which the events took place will be coherent and at any
> give time the state of the MDB objects in the device driver can be
> guaranteed to be sane. This is also the approach the prestera device
> driver took.

Not contesting this, but I wouldn't like to see MDBs cached in each
device driver just for this. Switchdev is not very high on the list of
APIs which are easy to use, and making MDB caching a requirement
(for the common case that MDB entry destinations need software fixups
with the mrouter ports) isn't exactly going to make that any better.
Others' opinion may differ, but mine is that core offload APIs need to
consider what hardware is available in the real world, make the common
case easy, and the advanced cases possible. Rather than make every case
"advanced" :)

