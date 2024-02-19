Return-Path: <linux-kernel+bounces-71327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565885A391
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE4FB2325B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0142E647;
	Mon, 19 Feb 2024 12:37:18 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE32E410;
	Mon, 19 Feb 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346238; cv=none; b=BCMedfzuqFZM2MGP9jXhCGyzLQyU67VlibbrCfGGUgQkbeUVgum0WlcnETNmiV9Y+bHsWF6ZC/Br+dMqm3vTXCO5BJdcn7lqcu8AaW0h2TrKWqgd3+k0Wt8J6bb6KL7AdViHDvaIW1s+R/8THO/DUSTKSODMEiTMqGB4KCb/k4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346238; c=relaxed/simple;
	bh=/J65+q+QomSfZ3wGcuHtMpFRfCHCYMuMStDpL3y0AZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gP5IUeCMi6KBw/4WhFJVnpR52gvvG2yEL9+fR3L6f4SQloUOsmzowUYDzpVA5jVFf6aeeYkkNTdfwvjos2Fv725m7rxLWXQygLcmUcWH/y9/uCU6gGlYoiDN7fXE/GtzR+r0JW+G1pvJUBV5jx92j6oy0jcaipkR6L8yU+9+X30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68f08.dsl.pool.telekom.hu [::ffff:81.182.143.8])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000073B80.0000000065D34A46.001CFF03; Mon, 19 Feb 2024 13:32:06 +0100
Message-ID: <531e85d73c1926161eb15f8900ea77aade394b6f.camel@irl.hu>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: support Fn+R
 dual-function key
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Feb 2024 13:32:05 +0100
In-Reply-To: <3b6a7bba-47a5-469c-aac1-5574ad78dadf@canonical.com>
References: 
	<0cdbc0e6eb65e160384ae0ed152e7de3ded1d9d5.1707604991.git.soyer@irl.hu>
	 <3b6a7bba-47a5-469c-aac1-5574ad78dadf@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ike,

On Mon, 2024-02-19 at 10:39 +0800, Ike Panhc wrote:
> On 2/11/24 06:51, Gergo Koteles wrote:
> > According to the manual, Fn+R adjusts the display refresh rate.
> > Map Fn+R to KEY_DISPLAYTOGGLE.
> >=20
> > Signed-off-by: Gergo Koteles <soyer@irl.hu>
> > ---
> >  drivers/platform/x86/ideapad-laptop.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x=
86/ideapad-laptop.c
> > index 88eefccb6ed2..4c130957f80d 100644
> > --- a/drivers/platform/x86/ideapad-laptop.c
> > +++ b/drivers/platform/x86/ideapad-laptop.c
> > @@ -1091,6 +1091,8 @@ static const struct key_entry ideapad_keymap[] =
=3D {
> >  	{ KE_KEY,	0x07 | IDEAPAD_WMI_KEY, { KEY_HELP } },
> >  	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
> >  	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
> > +	/* Refresh Rate Toggle (Fn+R) */
> > +	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
> >  	/* Dark mode toggle */
> >  	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
> >  	/* Sound profile switch */
>=20
> Acked-by: Ike Panhc <ike.pan@canonical.com>
>=20
> BTW on which ideapad we need this patch?
>=20

Oh, I somehow missed that. I found it on a Yoga 7 14ARB7.

Newer Yogas and Legions with 60Hz/90Hz displays have this refresh rate
toggle feature.

I'm wondering if this would be worth a new KEY_REFRESH_RATE_TOGGLE
event code?=20

KEY_DISPLAYTOGGLE is used to toggle the LCD on/off in other drivers.

What do you think?

Thanks,
Gergo

> Thanks.
>=20
> --
> Ike


