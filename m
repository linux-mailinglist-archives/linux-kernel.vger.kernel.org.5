Return-Path: <linux-kernel+bounces-97041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494E08764CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C922811A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392B71EF0D;
	Fri,  8 Mar 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OFUZ6dr3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DC1D52B;
	Fri,  8 Mar 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903520; cv=none; b=BEtPQ+PvLeJ4tf/LEjmky9ZvRmC0KY8v8bBM6kRTYwEweKkL8VKSxjGVxgRNCmltvqcHEf9P6mepPkD4WFvvmC1mKD4bvjT3rITMy8rTqZ11bhk+/3YXAwoPqaCGNaNyyx038+RfrQwx3DaZfiGZeWQH2OIv8fbtTE46tl3QA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903520; c=relaxed/simple;
	bh=gcumVgz1ssgz9ZPeWgypFCiLt/j3KSXG86VjjMzVmFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhfGo3ObUPs563mEzH4f4OYiSF9RCR1CxlCZ8A3SfVFq0uDVZMme1+BeUZxyyhMOSmcmxGpChKluerlQlJTfdMeBtjsruCV8Jep6oViTtZJwUyVXlUKJyDUrMXbKZtBcsPa4GKRHlFBJtqPSo7ygJ/mMdhAlod1/RMGSLPgiQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OFUZ6dr3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709903517;
	bh=gcumVgz1ssgz9ZPeWgypFCiLt/j3KSXG86VjjMzVmFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFUZ6dr3F1lEsOdziSh5iwWY+UOvrol7INXFb/YVJoPZcr/67tN5ElJO33CONLEwu
	 jdM7ILmp+yEkVvAMZK3viS9V45N2da7WyUONURr75CvqnkVAJgZx7LmVmTTssmB2od
	 za0WZfOE8ZXuIjBG+nk/+6pZJ5wGkSykYFNDG8RwV6fF9B6SUysRdR+uHUwtm1ivTI
	 2lpr6Xe4bCkPOisjUdxKQX/f5IMNvPYoAZJWISRZqN5ERMj72XH9SPdxNQpgaknzsm
	 QdM3OzAy8y6lYc914cbvFdGRghvUJaLlMpT17BelaN52+YhG16pvVoQVB0bdcfJ9pe
	 kEbMUAG4ClaDQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0BFE837813CA;
	Fri,  8 Mar 2024 13:11:55 +0000 (UTC)
Date: Fri, 8 Mar 2024 08:11:53 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Message-ID: <58fbe746-528f-4761-99ae-a42fe2c41c38@notapiano>
References: <20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com>
 <3a0910c4-87f4-4c0f-b6b6-3f7bf553a5f0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a0910c4-87f4-4c0f-b6b6-3f7bf553a5f0@collabora.com>

On Fri, Mar 08, 2024 at 10:26:29AM +0100, AngeloGioacchino Del Regno wrote:
> Il 07/03/24 23:05, Nícolas F. R. A. Prado ha scritto:
> > Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> > specification as required, it seems that not all batteries implement it.
> > On platforms with such batteries, reading the property will cause an
> > error to be printed:
> > 
> > power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > 
> > This not only pollutes the log, distracting from real problems on the
> > device, but also prevents the uevent file from being read since it
> > contains all properties, including the faulty one.
> > 
> > The following table summarizes the findings for a handful of platforms:
> > 
> > Platform                                Status  Manufacturer    Model
> > ------------------------------------------------------------------------
> > mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
> > mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> > mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> > mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> > mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
> > sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> > sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
> > rk3399-gru-kevin                        OK      SDI             4352D51
> > 
> > Identify during probe, based on the battery model, if this is one of the
> > quirky batteries, and if so, don't register the
> > POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW property.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   drivers/power/supply/sbs-battery.c | 45 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> > index a6c204c08232..85ff331cf87a 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c
> > @@ -1112,6 +1112,49 @@ static const struct power_supply_desc sbs_default_desc = {
> >   	.external_power_changed = sbs_external_power_changed,
> >   };
> > +static const char * const unsupported_time_to_empty_now_models[] = {
> > +	"AP16L5J", "AP15O5L", "AP16L8J", "AP18C4K", "GG02047XL"
> > +};
> 
> I think that you must make sure that this is seen as a quirk, rather than
> "something normal" because - as you said - the SBS specification says that
> the TIME_TO_EMPTY_NOW is *required*, so, this is a *deviation* from the spec
> (so, the SBS implementation in those devices is *out of spec*!).
> 
> static const char * const quirk_remove_time_to_empty_now_models
> or                        quirk_unsupported_time_to_empty_now_models
> 
> ...the former, if you want to avoid having a variable name that is 5000 characters
> long (:-P); the latter, if you don't care about that (there's no rule anyway).

(and I just noticed I forgot the usual sbs_ prefix here, so it'll get a few more
characters ;P)

> 
> 
> Besides that, since I didn't like what I just saw, I looked for different
> alternatives; the only other one is to de-constify the sbs_properties[] array,
> which is something that I also dislike anyway.
> 
> I'm not sure if deconstifying that could be acceptable, but if it would, you
> would be able to remove-reorder without copies of this and that.

Personally I don't see an issue with creating a new struct and copying things
over - this will only happen during probe and for the quirky batteries anyway -
and it's nice to keep things const for the common case.

> 
> Anyway - the only thing I really want here is to make sure that this is seen
> as a quirk and a clear deviation from the specification - everything else is
> a plus, and not really a blocker for me.

Yep, and you're right on that. I'll make sure to slap the "quirk" sticker on the
variable and function for next version.

Thanks,
Nícolas

