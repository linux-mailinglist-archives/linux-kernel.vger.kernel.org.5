Return-Path: <linux-kernel+bounces-50210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489DA8475CB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D3CB23F81
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EBC14AD34;
	Fri,  2 Feb 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqiubCOe"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964F17C69;
	Fri,  2 Feb 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893686; cv=none; b=ulCzBgAaxpfUou5oN2RbVmLXYQzQs0u+Tz6Zt19SZEcmjM9OIyk66pJtl6bosJrBBy1Xs1KexzouH3jog0HdNpKhth3N+YgijtmunQ76+8h6hIXYY7vuCPVm8kkW/VOvzkNJoP5SqDRFFXn9XEJXKrY8NvwDiZP8anu3FlMlV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893686; c=relaxed/simple;
	bh=nJsDcQKPmUGxipMGHsoS3ef4KudBXimiRhwIHTZUido=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT8iT4NYQyBE9D80o7jPvv5pCoS4KefBg/SLX17sYf64gDjX5VGJPGh9DiuCcYh3JZhdnQVd4BfQi3LLkEGXJmb2EVRRUpoGw4NQ33vJUUyZubOgsLvn+PnoLcBUyvPlAqGrDgWnCoXswN69fY5nNNAs5iqXARIDgpvh0eY3nIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqiubCOe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fc6578423so7703565e9.0;
        Fri, 02 Feb 2024 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893683; x=1707498483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8yz77hdqu3xW1RZmxsC2XtkWXQ/ktZsm22Dc2aBeR00=;
        b=JqiubCOew5ZkKeGaWOH0EOFrmwCHH6aYxLR8vv6OQGwcvhWtPwysdCiRIss1RpDxfo
         FexFolyqYblFU6mVsFN9jfMm0/T3OL0PNnNx+PIq1NK9TsaoW1R9GiuNkvnkGHILbLFC
         9SYDd4mmpGkxehlRPqn5za5HHnkfwUs62ZMj53JKRK7tSwqS9RbQNuJOJm8Q6qyLWG4l
         X+eYvOI3pKdbYDJWIoJwwp54705SZBNbeseKv09ReuD1AaTLZGWige4tz6R5sQ0UAphD
         hopRqzJb0PQ58x6EVI16MAsEm+KRxmloqo8ZIR9WktkgZaleMpdKUFWPTYYkIhtvSl4E
         XqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893683; x=1707498483;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yz77hdqu3xW1RZmxsC2XtkWXQ/ktZsm22Dc2aBeR00=;
        b=ZqLQNi2/FcuNG0FC+cRPaFvuwCptHgxoB0ZYryO0Cb/XyTzcUkruozG6JBq/aRq6j1
         JzlNStnpcPBqmQ8CePAcTgNWog7hpIoqvi0yXOY3EFlaFIec3Gmvs/V/meNGwwTByhzn
         J9FKS/jXOj69Kjkd6foVbDdZ6ALxZJ8E4s1aqAeIYfQglmtXn62MzDdXMcjifZGKL5TM
         8N2QnmPpxR8xZxjY/fRtHfl3qBXRlL7VEdhHucUhaxH09iGaZkPp2VN5KVDuImW8ExSV
         L3HAkg02AK4eSiX6ljVTTGiWKztcoHGCxMHzA7giHET0JCM3HXJpnjYRL76JQB3VmC9a
         Te1g==
X-Gm-Message-State: AOJu0YwXKVtDJ62NsTe0OQk5bngONF7TBwY6a8Ye9xtE36qSsBNOL+BS
	gYWDYv89jfw/0B28zu228fuhShPiVmiNvkgYgwMj7Z5eOs1dmcL3
X-Google-Smtp-Source: AGHT+IEkg1EFNRdi0qgjyn5EEuepISOEdRNauXjypgq3uZISwW/zYx/TcVjYpO9BtfrOvy25qdHm6g==
X-Received: by 2002:a05:600c:4586:b0:40e:f5e3:5e16 with SMTP id r6-20020a05600c458600b0040ef5e35e16mr7815645wmo.27.1706893682521;
        Fri, 02 Feb 2024 09:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUsZ+AnNrt9quaemMFKVJPRulRmfUkvJQf7KKsQcLA1ViI9TO63C1ciGqRdBl6oHO4rOySBX6YWEU+c8jXYex3tn3E/bgumxc3jvEmBvmta0jTq3/AuqfjfB/xDr/vMU4HTLT2xTW1ltrjW1UlEU+TGUgpfy1WylEEO+tIdxXmRKMXQpts6/pnZvlzF/mYmEOv1iKachjj76NdA68n/9azWdI5y4zgVE8xbgU/YteQJmGMsz90UabinURtMgQ2QedPKcmeMNMmFygw3jvdbCSW+eUwoebhGOVVeVQznF834H2WySfmqqkXfNSkKpdxK7OsjLf/9t4WQPz3CRJ6QZYXtTiCgH9DY5ZKXJED3c3PQi7h+hKCtbk9LP5pTHmmXKypTDHO4qESKbULnlKMvf4Q5l7G4W1eZl+bM3C4Ek7kzRlMtJOIbYNWZ2n12Onjo99AFEuwrG1jpIjkAH6DapCe4F/BkBnEjRVVra0snX7DIR22Qj6IK4nfdClLB1pNUik7yoj87B1njTLS8ZcrrgG2EwbFoq1Wa98p/Jrznz9D0qN2wwq3kVwM5PimhrLijNdo=
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040e88d1422esm452922wms.31.2024.02.02.09.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:08:02 -0800 (PST)
Message-ID: <65bd2172.050a0220.b661.349f@mx.google.com>
X-Google-Original-Message-ID: <Zb0hboevnTEURuwJ@Ansuel-xps.>
Date: Fri, 2 Feb 2024 18:07:58 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 9/9] net: phy: qca807x: add support for
 configurable LED
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-10-ansuelsmth@gmail.com>
 <46085abf-8e82-4fd9-95b8-95cbfde6e5c2@lunn.ch>
 <65bd1af9.df0a0220.c0618.9f8d@mx.google.com>
 <Zb0glzoHmgN5iHl7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0glzoHmgN5iHl7@shell.armlinux.org.uk>

On Fri, Feb 02, 2024 at 05:04:23PM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 02, 2024 at 05:40:21PM +0100, Christian Marangi wrote:
> > On Fri, Feb 02, 2024 at 02:43:37AM +0100, Andrew Lunn wrote:
> > > > +
> > > > +			phydev->drv->led_brightness_set = NULL;
> > > > +			phydev->drv->led_blink_set = NULL;
> > > > +			phydev->drv->led_hw_is_supported = NULL;
> > > > +			phydev->drv->led_hw_control_set = NULL;
> > > > +			phydev->drv->led_hw_control_get = NULL;
> > > 
> > > I don't see how that works. You have multiple PHYs using this
> > > driver. Some might have LEDs, some might have GPOs. But if you modify
> > > the driver structure like this, you prevent all PHYs from having LEDs,
> > > and maybe cause a Opps if a PHY device has already registered its
> > > LEDs?
> > >
> > 
> > God you are right! Off-topic but given the effects this may cause, why
> > the thing is not const? I assume it wouldn't make sense to add OPS based
> > on the detected feature since it would have side effect on other PHYs
> > that use the same driver.
> 
> Maybe phydev->drv should be const to avoid this kind of thing. It
> doesn't look like it would be hard to do, and importantly doesn't
> require casting away the const-ness anywhere. PHY drivers themselves
> can't be const because the driver model needs to be able to modify
> the embedded device_driver struct (e.g. see bus_add_driver().)
> 
>  drivers/net/phy/phy.c               | 3 +--
>  drivers/net/phy/phy_device.c        | 4 ++--
>  drivers/net/phy/xilinx_gmii2rgmii.c | 2 +-
>  include/linux/phy.h                 | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
> 
> Just build-testing it.
>

Seems sensible to me. Also for everyone that does that (downstream or
driver that needs to be handled) it would result in a warning for
modifying const stuff. Maybe I'm wrong but I can only see benefits in
doing this change.

-- 
	Ansuel

