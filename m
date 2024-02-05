Return-Path: <linux-kernel+bounces-52477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA08498B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1F71C224F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D852618B04;
	Mon,  5 Feb 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MAgVFpPc"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711518641;
	Mon,  5 Feb 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132118; cv=none; b=QJAbxdpJaKXl2eBFDig14G2Hps8MRPXsiu/g3NYvDVZPqd7DwgwbdY+OEIJfVJYH/RKHhBvesArhuMvvz3CuiKhCrpW/wSoSZUDJ8Updxn2qv6uqV65EhrRmyEy14WYm5S/IzaoFBEeEDGSvWEBvbyRloadeRv97u3WZqwepOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132118; c=relaxed/simple;
	bh=6vdRADLmto/3CuW0UJ6BuYaz7DLwN+tvUOa2KNkTtd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdk5c5Cp8k/vN6+sK2M63nMvie0uecJgAZjz4Kbw2tx6iziGWbdhlY20RhCZs/l+ZiENK1stQXtp7+QHCwgkceGj5LuyRgLHitnXB/D+lG917+8AzIzEH2c6bFITYDyhFREsYMNKWw+A73M+mVKia+w47MrOWR5EPJ+fMR1S1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MAgVFpPc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1707132110;
	bh=6vdRADLmto/3CuW0UJ6BuYaz7DLwN+tvUOa2KNkTtd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAgVFpPcDvjdp/mDzcBcyI5VATplfjxVibtuzVMZtFNGs8ZQiUV1G4BibKmWbDuUL
	 hLlgNIrAPVF1aC/bbBR7WzzpXhSzYYb0qaNK3fRGUXUYwouhGGd+dK16QyE3SAAhuf
	 yEgXJCfGsQCpJa4XF1w/nC/+ITDrqjZs2Z7hKST4=
Date: Mon, 5 Feb 2024 12:21:45 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 3/4] power: supply: mm8013: implement
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Message-ID: <569bbc9f-1c34-40c1-a563-e7f6aecf63d5@t-8ch.de>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
 <2f244f9f-8796-4cad-8bf8-d0c3411588c1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f244f9f-8796-4cad-8bf8-d0c3411588c1@redhat.com>

On 2024-02-05 11:00:01+0100, Hans de Goede wrote:
> Hi,
> 
> On 2/4/24 18:26, Thomas Weißschuh wrote:
> > The sysfs is documented to report both the current and all available
> > behaviours. For this POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE needs
> > to be implemented.
> > 
> > Note that this changes the format of the sysfs file
> > (to the documented format):
> > 
> > Before: "auto"
> > After:  "[auto] inhibit-charge"
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Changing userspace API like this is never ideal, but given how
> new the mm8013 driver is and that this brings things inline
> with the docs I think that this should be fine:

I agree that it's unfortunate.

However looking at the datasheet [0] it seems to me the driver is
not correctly using the API.

Page 23 documents the flag CHG_INH as follows:

  CHG_INH : Charge Inhibit      When the current is more than or equal to charge
                                threshold current,
                                charge inhibit temperature (upper/lower limit) ：1
                                charge permission temperature or the current is
                                less than charge threshold current ：0

This is only diagnostic information and not a control-knob, which the API
was meant for.
So POWER_SUPPLY_STATUS_NOT_CHARGING seems like the better match.

> [..]

Thomas


[0] https://product.minebeamitsumi.com/en/product/category/ics/battery/fuel_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.pdf

