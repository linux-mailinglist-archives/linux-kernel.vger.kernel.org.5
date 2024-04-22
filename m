Return-Path: <linux-kernel+bounces-153571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C98ACFC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610151F21829
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB99152516;
	Mon, 22 Apr 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="WavaBMV7"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600D152511;
	Mon, 22 Apr 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796973; cv=none; b=d+T3w3o/X5+OGVhs3d4p4wl2Wu5AgzvOpMQOs2Aqb95wBO64FzGMb8PnZCvHd9RLCtY5d/g1xzwEYtzVgESGqE3tYv3DTg4UrTQDNK+n6DdpVRWW927VUzcygtaCRtRnckpZzeRNHt1glwRtCS/w5RZiW+yxQMbPHmc8qeLZHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796973; c=relaxed/simple;
	bh=TehiPdP7f3BwX4F5malLw3rlYjffDIaaSV/a4YkcBSU=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=uE5osrYryhp31qOcq5V3Fph/4ieM6pHk7oXENt7nil0ajFjuxJ2cl5nHj7OJo6HD4arUrwN3P0n9YR2/jtekfcsCRwzvBMK6Gtpixv32/55ddEVthnGzpe6W2tF3XJwhHOcr+7+z0Ptg6JeTMN89twDNVezTQDakwaXIJPLRJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=WavaBMV7; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=YefPl8pmVD5zRqukU6YqokO25CT5Ld8avb97hYoywE8=; b=WavaBMV7qdbl3vAb4xfKAbuJkg
	1VifvB0ZoYvmj5cmwWbiYTHINp6/3YfUgTuzriUtOIx25FTHxAedmVo7U1BGMJVOn4gozOYfOjPT/
	RI7/0EyydvPitXCWkcqD6jvAcER9rVrS6Yihf+7KsXYCT8vnAg2k7JOmdnYwfEoLXxuI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:33346 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1ryusA-0007Wt-Gd; Mon, 22 Apr 2024 10:42:23 -0400
Date: Mon, 22 Apr 2024 10:42:21 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
 lkp@intel.com, Vladimir Zapolskiy <vz@mleia.com>, Rob Herring
 <robh@kernel.org>, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
 manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
 u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 Lech Perczak <lech.perczak@camlingroup.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <20240422104221.cb87be9a6905e681c712b024@hugovil.com>
In-Reply-To: <CAF1WSuzzzG_vm5b55zb_ha-Vj7H+i3ZbmPyN1F-EQxS3GLaurg@mail.gmail.com>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
	<e2989aa1-7f2b-4ac3-8fd8-822c87d61a1e@kernel.org>
	<CAF1WSuzqLxpxwYuNYfHyvXLDMBE-ZU69YLXwBdQokZzhs49xzw@mail.gmail.com>
	<c5fdfc26-b8c7-4e0e-bd15-1299ec052833@kernel.org>
	<CAF1WSuzzzG_vm5b55zb_ha-Vj7H+i3ZbmPyN1F-EQxS3GLaurg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v7 0/3] add support for EXAR XR20M1172 UART
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 22 Apr 2024 17:30:13 +0300
"Konstantin P." <ria.freelander@gmail.com> wrote:

> I do not skip it, it added to patch 2, as you requested.

Once again, please do not top post.

Hugo.


> On Mon, Apr 22, 2024, 16:51 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > On 22/04/2024 15:50, Konstantin P. wrote:
> > > On Mon, Apr 22, 2024 at 4:45 PM Krzysztof Kozlowski <krzk@kernel.org>
> > wrote:
> > >>
> > >> On 22/04/2024 15:32, Konstantin Pugin wrote:
> > >>> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> > >>> it has additional register which can change UART multiplier
> > >>> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> > >>> flag to guard access to its specific DLD register. It seems than
> > >>> other EXAR SPI UART modules also have this register, but I tested
> > >>> only XR20M1172.
> > >>> Yes, in datasheet this register is called "DLD - Divisor Fractional"
> > >>> or "DLD - Divisor Fractional Register", calling depends on datasheet
> > >>> version.
> > >>>
> > >>> I am sorry about too many submissions and top post reply. About second
> > -
> > >>> I do not know how to reply properly to this ML from GMail phone app.
> > About first - I just
> > >>> get very good feedback from Andy Shevchenko, and want to fix his
> > review picks ASAP.
> > >>>
> > >>
> > >> One patchset per 24h.
> > >>
> > >> Plus, you already got such review comment:
> > >>
> > >> This is a friendly reminder during the review process.
> > >>
> > >> It looks like you received a tag and forgot to add it.
> > >>
> > >> If you do not know the process, here is a short explanation:
> > >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> > >> versions, under or above your Signed-off-by tag. Tag is "received", when
> > >> provided in a message replied to you on the mailing list. Tools like b4
> > >> can help here. However, there's no need to repost patches *only* to add
> > >> the tags. The upstream maintainer will do that for tags received on the
> > >> version they apply.
> > >>
> > >>
> > https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> > >>
> > >> If a tag was not added on purpose, please state why and what changed.
> > >>
> > >> Just start using b4.
> > >
> > > There is not only for tag. I submit fixes for version 4 by mistake,
> > > so, repost to 7 was necessary, because v6 was not work (as v4). But v7
> > > should be based on v5, and v5 is tested better around tty-next.
> >
> > ???
> >
> > You got tag, didn't you? Then explain why you decided to skip it. In the
> > changelog of patchset which ignores/skips the tag.
> >
> > Best regards,
> > Krzysztof
> >
> >


-- 
Hugo Villeneuve

