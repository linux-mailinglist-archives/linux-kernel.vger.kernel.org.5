Return-Path: <linux-kernel+bounces-22197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A4829AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CF3285CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDED1487A1;
	Wed, 10 Jan 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUn8qYiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E248791;
	Wed, 10 Jan 2024 12:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952CCC433C7;
	Wed, 10 Jan 2024 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704891299;
	bh=5n8+CXGpbcg2EukFcN9GH3kiPhkvu8XAbFD9ugJEqO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUn8qYiDRQ8oiPkJuPpQGjABUZmMKQm5uuNqcRgXABYS9zK6SKk2So3nWtvKabFUw
	 PFJL5c1GtM6OUk5DE/Rqd7Sv9540B4JfPQZ7jSDewrSvMBZFwesnBjdY5Ay90Nj+9C
	 pqX21jHByezFcQ3De9rleGzR5Iz5ealyfNCJViQ8M/c3ClvH1IZBjvX9UWy1g4095V
	 rYjdpHJu4lMZClINUPhxpvvpHxRd3CvzpfFHtEtcn/9thYEB75QyuESqml3YArYeZQ
	 FTJBDXR7iqwp6Sjl5xP+n+QZ0FdGQFk9z5R2t1rweUBYff5L16HeZY2Df+/Jn7Yl4l
	 gT3KzSR2QX7tw==
Date: Wed, 10 Jan 2024 12:54:54 +0000
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/2] leds: trigger: netdev: display only supported
 link speed attribute
Message-ID: <20240110125454.GI7948@google.com>
References: <20231221171125.1732-1-ansuelsmth@gmail.com>
 <659e8adc.5d0a0220.a73cd.069f@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <659e8adc.5d0a0220.a73cd.069f@mx.google.com>

On Wed, 10 Jan 2024, Christian Marangi wrote:

> On Thu, Dec 21, 2023 at 06:11:24PM +0100, Christian Marangi wrote:
> > With the addition of more link speed mode to the netdev trigger, it was
> > pointed out that there may be a problem with bloating the attribute list
> > with modes that won't ever be supported by the trigger as the attached
> > device name doesn't support them.
> > 
> > To clear and address this problem, change the logic where these
> > additional trigger modes are listed.
> > 
> > Since the netdev trigger REQUIRE a device name to be set, attach to the
> > device name change function additional logic to parse the supported link
> > speed modes using ethtool APIs and show only the supported link speed
> > modes attribute.
> > 
> > Link speed attribute are refreshed on device_name set and on
> > NETDEV_CHANGE events.
> > 
> > This only apply to the link speed modes and every other mode is still
> > provided by default.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> 
> Any news for this?

Not yet.  It's on the list.  Holidays, merge window, etc.

-- 
Lee Jones [李琼斯]

