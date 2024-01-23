Return-Path: <linux-kernel+bounces-34557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D9837F86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F33E1F2363D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42435633EE;
	Tue, 23 Jan 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="KbR41SM5"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E20627E3;
	Tue, 23 Jan 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971175; cv=none; b=WgMi2mYvS2BiuOnb56KucsdcvTD1itGdP3V0C7wL/9pgYsdVHcW9NT1bVTLRYCitrq13PD+TdhBYWyzs4VWYrGnl7FtjZT2oL4l0JdCZdg+I/R4atAYeFY5/4fa+wcQlBJB3rxH6R/IBY7laHz5/SHVfhzX5p4sYObQ1Ve+mhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971175; c=relaxed/simple;
	bh=IHHAkhaPD/VxLEfCh4L6KUuwb5xEYZxbqYfBzxCDqiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czN8NZpG9iLUOPo7XqFNJyVSjIF9bBOCPavPUCxzwxKAHFEZRSqOnIqSD7Jl6z0wFFIz1EuEDKI4PkTwyyCp2MOtwPX02D9VurfbASzTR2W/bh9zTpU5nJYPG7+gh/yIuYBMcNbkO3Ckx2BRbD2edQ0O0mpF0qUUHmsYwPDc2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=KbR41SM5; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 7CD0F450F1;
	Tue, 23 Jan 2024 00:52:46 +0000 (UTC)
Date: Mon, 22 Jan 2024 19:52:44 -0500
From: Aren <aren@peacevolution.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Sebastian Reichel <sre@kernel.org>, Hans de Goede <j.w.r.degoede@gmail.com>
Subject: Re: Re: [PATCH 1/3] power: supply: axp20x_usb_power: add input
 current limit
Message-ID: <2dkeq46flco2xukggii3ljlw2zo7wjwuiutha7jlxozmf63swd@xnirwnfvvvcv>
References: <20240121014057.1042466-1-aren@peacevolution.org>
 <20240121014057.1042466-3-aren@peacevolution.org>
 <CAGb2v65QcP1bcT++51n7Ada6QvFmrQzqiA-b3tbzfAr3XC6XJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65QcP1bcT++51n7Ada6QvFmrQzqiA-b3tbzfAr3XC6XJQ@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1705971167;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=1amB/L7gOBoM9TVvcIEb8QCr/e1Osy+QoThWNMN1a/Y=;
	b=KbR41SM5eVxA1weRH7IkSPrSd9EVRgpemzguutoPd3732qEfAgt8MG+HSPZqcsdik4MsAy
	3DdF5oM18yQ+mcwwDS0G9FRhx5OyMSPxCsFg7mrMVkD3CI3co8f6rtQuDT6T4y6r36SLHe
	u0JpMpBF9BIudl/WQ0pT7y3RCENjB2c=

On Sun, Jan 21, 2024 at 11:25:04PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> +CC Hans de Goede since the AXP288 is similar to the later AXPs in the USB
> power section.
> 
> On Sun, Jan 21, 2024 at 9:54 AM Aren Moynihan <aren@peacevolution.org> wrote:
> >
> > Add properties for setting the maximum current that will be drawn from
> > the usb connection.
> >
> > These changes don't apply to all axp20x chips, so we need to add new
> > power_desc and power supply property objects for axp813 specifically.
> > These are copied from the axp22x variants that were used before, with
> > extra fields added.
> >
> > Also add a dev field to the axp20x_usb_power struct, so we can use
> > dev_dbg and dev_err in more places.
> 
> I think this patch highlights some errors in the driver.
> 
> 1. We are likely misusing POWER_SUPPLY_PROP_CURRENT_MAX. Based on the
>    ABI docs, this is supposed to be a read only property. The correct
>    way would be to use POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT as you did.

I think so, yes. I was hesitant to touch that because I wasn't sure if
current_max was relied on anywhere. I'll do some grepping to confirm
that it'll be safe.

> 2. For AXP288 and AXP803/AXP813/AXP818, we are setting the current limit
>    for when BC detection finishes in register 0x30, not the actual active
>    limit in register 0x35. This should be fixed.
> 
> 3. BC detection race condition
> 
> Could you maybe respin the patches to address them separately instead?

Sure, that sounds like a better way to split it up.

 - Aren

> Thanks
> ChenYu

