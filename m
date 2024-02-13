Return-Path: <linux-kernel+bounces-63565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F0C853172
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBE628BFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D5853E09;
	Tue, 13 Feb 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uKlKkjZm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F253813;
	Tue, 13 Feb 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829843; cv=none; b=UkS2jeXmTPxIuNmMUHx4ViU0cCrWS6i+GmOFtiAEtmzL1QbNrSbUzKKl/opGfdT+gW2E5Ln9rb7rglMKOG7EMaJgFLay7P6jpDrYgz8/tNHwd9NgJEe3eNZLd2s/rvNyxcApGrgvp07EjryHbl0jim3stgihSbFuhbHkfrJcYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829843; c=relaxed/simple;
	bh=ErfgDXhiipWo6UTfivgIO33Glx/+fm68/fY8BAz0NFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGtZAAIALb0WWagDCitn0PIhHaQRRcm7QtlYaEq1VLDSVG3QKAyPXPh8UX5b/SJbYGCtouUBVdOLu5z+Ra4yxVRemjtBtIJinoH/zjjI1JySuvrUdnhMblaQ9Rhe/p7RYzbS1LKVmri91rGwOD2uN2i8olJ81jeid2UJYb0oRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uKlKkjZm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=3ig8/hoTtbhy80ogS8uSOp9SFFQKfTzlGTZZfEqeCAg=; b=uK
	lKkjZmcr48PGWo0prm69OS16580SSdihn5yY4dqMcSNq2Ce1aSuVQ0N57nQ+wI+0MqYsDqqZPE22W
	+vCLS+cssvlk3cEJoJYb/NXQqDJFZcIbWyk3uzq05eiKvBL90iWuzilfpWHD8uZvMjEgSOdMIvSnv
	u9X4i2Dr5aIclHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZsYc-007g8X-7T; Tue, 13 Feb 2024 14:10:42 +0100
Date: Tue, 13 Feb 2024 14:10:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 1/2] ARM: dts: imx6dl-yapp4: Fix the QCA switch register
 address
Message-ID: <e00ed8cb-f73d-48a6-9999-f5acd5a202a0@lunn.ch>
References: <1707751422-31517-1-git-send-email-michal.vokac@ysoft.com>
 <c5dad8e7-c486-4dd9-bfb5-bdfa2ddc18b3@lunn.ch>
 <db282aa5-2db3-49b9-a7dd-86e94226aa7b@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db282aa5-2db3-49b9-a7dd-86e94226aa7b@ysoft.com>

On Tue, Feb 13, 2024 at 01:20:44PM +0100, Michal Vokáč wrote:
> On 12. 02. 24 17:08, Andrew Lunn wrote:
> > On Mon, Feb 12, 2024 at 04:23:41PM +0100, Michal Vokáč wrote:
> > > The switch address in the node name is in hex while the address in the reg
> > > property is decimal which is wrong. Fix that and write the reg address
> > > as a hexadecimal number.
> > 
> > This feels the wrong way around. The reg value is used by the kernel,
> > where as the node name is not. If the reg value was wrong, the switch
> > would not be found. If this file was tested, why did somebody not
> > notice the switch was missing?
> > 
> > Do you have the hardware? Can you confirm is really does not work
> > without this patch? Was 15b43e497ffd never actually tested?
> Yes, I have bunch of these boards all around my desk - we manufacture
> them. I am pretty sure I tested all the patches I have ever sent to
> the mailing list regarding these boards.
> 
> The fact is that the switch actually works regardless of the reg value.
> It worked prior to the 15b43e497ffd commit with address 0, it worked
> later on with the reg value 10 and it works now with reg value 0x10.

Ah, so that is the missing piece of information from the commit
message. That the reg value does not actually matter. Hence it is safe
to change it.

Please reword the commit message.

> I admit that my understanding of the MDIO bus and addressing of
> the connected external/internal devices is pretty limited. I have no
> answer to why it works like that but as you brought up your questions
> I would actually like to know as well.

My guess is, the switch assumes it has full access to all the
addresses on the bus. It probably uses a subset, but that subset is
hard coded. But the MDIO DT binding requires a valid reg value, so
something has to be used.

There are some devices which use a single address on the bus. The
mv88e6xxx can be strapped into such a mode, so you can have multiple
switches on the bus. The reg value is then used. But you can also
strap it so it takes over the whole bus, and uses #num_ports + 3
addresses on the bus, and those addresses are hard coded in the
silicon, so the reg value is ignored.

    Andrew

---
pw-bot: cr

