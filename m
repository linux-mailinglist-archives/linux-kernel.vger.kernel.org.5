Return-Path: <linux-kernel+bounces-128732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D064C895EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEB71F22FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0D15E5DE;
	Tue,  2 Apr 2024 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="IFzlhnzS"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E515AAA7;
	Tue,  2 Apr 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093722; cv=none; b=rYAqdW5BPJl1/M9iFmqG57IasJLZNI3Nxoq4KYNcPDMAv3hz5PXdI17iJxvUpgtDx71g5Zq2L3HvqzfQVrIhPLZX/3ygYtzUKYp3NPAU2LCF2bYfIO9tUaRAln9rNv8Mem/mMowySQQHueJtk3/TqfW7M0ymVSrGk9jPuDecaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093722; c=relaxed/simple;
	bh=mNmmeopVZW8R+hRHGFqpjTJLMIULY/6ZugH9hRAZW+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipdcUOo/b7QrzeuxhcgPDdXVS8Q9IzUvgCwD8vCnCo/2bprRG29zuAcJzIf7/q4Wz86lO0FkYlGxBU/B2Bk2VnUlu9+JsHH9SRHYTA9pwTbwxaY7pATCogu+LfUPCkUBu0zKSxwySMf6kr8hRx5WG0Wp0lfPuFIVgxHnkMMWd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=IFzlhnzS; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.205.62])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 63A7C93D53;
	Tue,  2 Apr 2024 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1712093719;
	bh=mNmmeopVZW8R+hRHGFqpjTJLMIULY/6ZugH9hRAZW+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFzlhnzSBf0HkC+YMBQQ/rDsq25ktTne7JWz+FOVI2sA/Ko4c1lGRyck6b1M8W+Ep
	 zQAABuoHEhxWoDHz1CTpYtVnhojyP/6m+rBDMYx0Ba58+nzQ0iI7C5AiTPZieCYDXu
	 mRvfA0b0/6zia4PKIexSIkrNdqlely9gwINkInJJx8iXt0KWQvNZuLdVzsMRwOOieH
	 6JSZNxr/EDmDVChgPsWB7dl8P9GlQOWd0u1To3+TDbgip3KFA0LWeGmtmwsWgwQXoD
	 N/p3bgv66kecEEHJ3c3WODcjfsyAhC6zBpotYrYB4QvET5XUPou5NQUvKDrAg96t2E
	 he/8fWh8qKiVg==
Date: Wed, 3 Apr 2024 00:35:15 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix multiple issues reported by
 checkpatch.pl
Message-ID: <kjytiegrl5spztv43qsiqtvgsnjbk6tkaxfzm564u5i4jsgrh7@2edrsmgjzrzt>
References: <20240402155543.36856-1-me@wantyapps.xyz>
 <CABBYNZJ5y9DDgKwZjsCrpn6fn0KgR5NOnQ9YuZ1bGS=mbseMGA@mail.gmail.com>
 <vnw2eqp5acqtszne6xhlb6bplxv4fomv4mnrjy3qcnduaqcq6p@4xg65mm6mcmn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vnw2eqp5acqtszne6xhlb6bplxv4fomv4mnrjy3qcnduaqcq6p@4xg65mm6mcmn>

On Tue, Apr 02, 2024 at 07:12:23PM +0300, Uri Arev wrote:
> Hi Luiz, thanks for taking the time to review my patch.
> 
> On Tue, Apr 02, 2024 at 12:06:30PM -0400, Luiz Augusto von Dentz wrote:
> > Hi Uri,
> > 
> > On Tue, Apr 2, 2024 at 11:56 AM <me@wantyapps.xyz> wrote:
> > >
> > > From: Uri Arev <me@wantyapps.xyz>
> > >
> > > This fixes the following CHECKs, WARNINGs, and ERRORs reported in
> > > hci_intel.c
> > >
> > > Reported by checkpatch.pl:
> > > -----------
> > > hci_intel.c
> > > -----------
> > > WARNING: Prefer using '"%s...", __func__' to using 'intel_setup', this function's name, in a string
> > > +       bt_dev_dbg(hdev, "start intel_setup");
> > >
> > > ERROR: code indent should use tabs where possible
> > > +        /* Check for supported iBT hardware variants of this firmware$
> > >
> > > ERROR: code indent should use tabs where possible
> > > +         * loading method.$
> > >
> > > ERROR: code indent should use tabs where possible
> > > +         *$
> > >
> > > ERROR: code indent should use tabs where possible
> > > +         * This check has been put in place to ensure correct forward$
> > >
> > > ERROR: code indent should use tabs where possible
> > > +         * compatibility options when newer hardware variants come along$
> > >
> > > ERROR: code indent should use tabs where possible
> > > +         */$
> > >
> > > CHECK: No space is necessary after a cast
> > > +       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> > >
> > > CHECK: No space is necessary after a cast
> > > +       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> > >
> > > WARNING: Missing a blank line after declarations
> > > +               int err = PTR_ERR(intel->rx_skb);
> > > +               bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> > >
> > > Signed-off-by: Uri Arev <me@wantyapps.xyz>
> > > ---
> > >  drivers/bluetooth/hci_intel.c | 19 ++++++++++---------
> > >  1 file changed, 10 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> > > index 78afb9a348e7..44731de1a2d6 100644
> > > --- a/drivers/bluetooth/hci_intel.c
> > > +++ b/drivers/bluetooth/hci_intel.c
> > > @@ -537,7 +537,7 @@ static int intel_setup(struct hci_uart *hu)
> > >         int speed_change = 0;
> > >         int err;
> > >
> > > -       bt_dev_dbg(hdev, "start intel_setup");
> > > +       bt_dev_dbg(hdev, "start %s", __func__);
> > 
> > We probably don't need __func__ either since this is normally calls
> > pr_debug which already has support for printing function names if the
> > user wants to, so I just leave as bt_dev_dbg(hdev, "");
> > 
> Thanks for the comment, will revise. I still don't know most of the
> debugging functions in the kernel, as I am a relatively new hacker.
> 
> > >
> > >         hu->hdev->set_diag = btintel_set_diag;
> > >         hu->hdev->set_bdaddr = btintel_set_bdaddr;
> > > @@ -591,12 +591,12 @@ static int intel_setup(struct hci_uart *hu)
> > >                 return -EINVAL;
> > >         }
> > >
> > > -        /* Check for supported iBT hardware variants of this firmware
> > > -         * loading method.
> > > -         *
> > > -         * This check has been put in place to ensure correct forward
> > > -         * compatibility options when newer hardware variants come along.
> > > -         */
> > > +       /* Check for supported iBT hardware variants of this firmware
> > > +        * loading method.
> > > +        *
> > > +        * This check has been put in place to ensure correct forward
> > > +        * compatibility options when newer hardware variants come along.
> > > +        */
> > >         switch (ver.hw_variant) {
> > >         case 0x0b:      /* LnP */
> > >         case 0x0c:      /* WsP */
> > > @@ -777,7 +777,7 @@ static int intel_setup(struct hci_uart *hu)
> > >
> > >         rettime = ktime_get();
> > >         delta = ktime_sub(rettime, calltime);
> > > -       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> > > +       duration = (unsigned long long)ktime_to_ns(delta) >> 10;
> > >
> > >         bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
> > >
> > > @@ -822,7 +822,7 @@ static int intel_setup(struct hci_uart *hu)
> > >
> > >         rettime = ktime_get();
> > >         delta = ktime_sub(rettime, calltime);
> > > -       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> > > +       duration = (unsigned long long)ktime_to_ns(delta) >> 10;
> > >
> > >         bt_dev_info(hdev, "Device booted in %llu usecs", duration);
> > >
> > > @@ -977,6 +977,7 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
> > >                                     ARRAY_SIZE(intel_recv_pkts));
> > >         if (IS_ERR(intel->rx_skb)) {
> > >                 int err = PTR_ERR(intel->rx_skb);
> > > +
> > >                 bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> > >                 intel->rx_skb = NULL;
> > >                 return err;
> > > --
> > > 2.44.0
> > >
Hey Luiz, I sent a v2 that adds the above suggestion and fixes gitlint.

                 Uri Arev

