Return-Path: <linux-kernel+bounces-9531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF281C71A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909E2B23947
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A94FBF6;
	Fri, 22 Dec 2023 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GR7i7ZcI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29AFBE4;
	Fri, 22 Dec 2023 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qNs/d/m5HRR+Zs73s2mZ2qYKhdDpwKKnjFyOpsSszvs=; b=GR7i7ZcIrd3uGAUV1jBE0Nd5RC
	zsn4OV+6/DoYOxgBUJORzdb8K+LwEZ9QkFdU3vc1W/Ob8frTwGew0SBoLEOkKJWvPEYDb5M/+n06/
	qxuUku0EePid2Bw8MSxt/QL71rEizih999x8iYW4uk/jqykIYckeeAt8LfaT3qoT7Vvk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGbQH-003ZXw-B3; Fri, 22 Dec 2023 10:02:25 +0100
Date: Fri, 22 Dec 2023 10:02:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 1/2] leds: trigger: netdev: display only supported
 link speed attribute
Message-ID: <626aedab-99b5-4fe1-a55e-4c7649a4e214@lunn.ch>
References: <20231220224827.27667-1-ansuelsmth@gmail.com>
 <20231221100848.4a7da2df@dellmb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221100848.4a7da2df@dellmb>

> I am also wondering if this sysfs ABI could be extended for multi-color
> LEDs.
> 
> For example:
>   echo green >link_1000
>   echo yellow >link_100
> 
> Or something like that. But that is a completely different discussion.

I've not looked at how the LED core code supports this.

You do see bi-colour LEDs. They are basically two LEDs head to
tail. You positively bias them and they are one colour, you negatively
bias them and they are a second colour. The two colours are mutually
exclusive.

It is also possible to have two LEDs co-located. That should already
supported, since you can control each LED independently.

It would be good to describe your hardware. We can then figure out how
they LED subsystem should support it.

     Andrew

