Return-Path: <linux-kernel+bounces-128326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532989595D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AC61F2224D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3914AD21;
	Tue,  2 Apr 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="Xwe+J8eq"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC0134BE;
	Tue,  2 Apr 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074350; cv=none; b=hGNKrvg1u5IwkIF4fS4lxdN4vYkRCFTUM7Kb9CTSpC+bGtpJftEW1MAmhdq9OxWS9696gqegpymNdQIs4PaF3m4m5r9zk2IRYnnaJX/XF3ztaR9gVckemym3fq9k1lIGvh7dPb7bI+sAnwm3yLP18fB9ZhUIHVLQ6c74uNIh4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074350; c=relaxed/simple;
	bh=oih3nK+q8Uzw6WkRooj6wHj25NVHAXZmkzgKaV/UGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwp6NARMKhA/fsGn4SFiDD5o9wtXRduy+jmXLp8I0dY2ZljLSohPBgi+9s+JrPwvBgnwb6BbsrcwNOsaf04iKtVUfhLfmH1Oj/KzpwhkrTS6mdxxCPCb9gSe8eg3EpKhp/LcBby4fRnSTjnIxLunKGDgE3dm8YsR1U9s3fUW4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=Xwe+J8eq; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.205.62])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 780FC93BB5;
	Tue,  2 Apr 2024 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1712074347;
	bh=oih3nK+q8Uzw6WkRooj6wHj25NVHAXZmkzgKaV/UGLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xwe+J8eqxZJCDFXkbycLE5DnjmK295CSY9E4S4m76YT8P97/pIYKH8o0xXnYPm4QU
	 R1ccPASDYw1RzfEzHs8VmgBZtEjJkbHAQzjRkMBcHvN8KBcGU65lXq9QOwdEdjSAgF
	 tFW6TFnjk1TVGkC9xeYXl1bzEJJDWZgehwr9d79ue6TclzwjatmrZRH+TKlDWTDIfn
	 fR2MwJJYN8pD85Yz0buPSQfGFeohVt2yeNZy5S8iDV51kIglg2ZSLMJWpYJiPNIlx5
	 SsXe3UcjJV5Jpp0uc/h/KBgZ6AxtREmHbRFmOiNYwPUo7oMNmTaPd9UpEUeEc0XKT+
	 3j1HIf4Y9hDaQ==
Date: Tue, 2 Apr 2024 19:12:23 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix multiple issues reported by
 checkpatch.pl
Message-ID: <vnw2eqp5acqtszne6xhlb6bplxv4fomv4mnrjy3qcnduaqcq6p@4xg65mm6mcmn>
References: <20240402155543.36856-1-me@wantyapps.xyz>
 <CABBYNZJ5y9DDgKwZjsCrpn6fn0KgR5NOnQ9YuZ1bGS=mbseMGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ5y9DDgKwZjsCrpn6fn0KgR5NOnQ9YuZ1bGS=mbseMGA@mail.gmail.com>

Hi Luiz, thanks for taking the time to review my patch.

On Tue, Apr 02, 2024 at 12:06:30PM -0400, Luiz Augusto von Dentz wrote:
> Hi Uri,
> 
> On Tue, Apr 2, 2024 at 11:56 AM <me@wantyapps.xyz> wrote:
> >
> > From: Uri Arev <me@wantyapps.xyz>
> >
> > This fixes the following CHECKs, WARNINGs, and ERRORs reported in
> > hci_intel.c
> >
> > Reported by checkpatch.pl:
> > -----------
> > hci_intel.c
> > -----------
> > WARNING: Prefer using '"%s...", __func__' to using 'intel_setup', this function's name, in a string
> > +       bt_dev_dbg(hdev, "start intel_setup");
> >
> > ERROR: code indent should use tabs where possible
> > +        /* Check for supported iBT hardware variants of this firmware$
> >
> > ERROR: code indent should use tabs where possible
> > +         * loading method.$
> >
> > ERROR: code indent should use tabs where possible
> > +         *$
> >
> > ERROR: code indent should use tabs where possible
> > +         * This check has been put in place to ensure correct forward$
> >
> > ERROR: code indent should use tabs where possible
> > +         * compatibility options when newer hardware variants come along$
> >
> > ERROR: code indent should use tabs where possible
> > +         */$
> >
> > CHECK: No space is necessary after a cast
> > +       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> >
> > CHECK: No space is necessary after a cast
> > +       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> >
> > WARNING: Missing a blank line after declarations
> > +               int err = PTR_ERR(intel->rx_skb);
> > +               bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> >
> > Signed-off-by: Uri Arev <me@wantyapps.xyz>
> > ---
> >  drivers/bluetooth/hci_intel.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> > index 78afb9a348e7..44731de1a2d6 100644
> > --- a/drivers/bluetooth/hci_intel.c
> > +++ b/drivers/bluetooth/hci_intel.c
> > @@ -537,7 +537,7 @@ static int intel_setup(struct hci_uart *hu)
> >         int speed_change = 0;
> >         int err;
> >
> > -       bt_dev_dbg(hdev, "start intel_setup");
> > +       bt_dev_dbg(hdev, "start %s", __func__);
> 
> We probably don't need __func__ either since this is normally calls
> pr_debug which already has support for printing function names if the
> user wants to, so I just leave as bt_dev_dbg(hdev, "");
> 
Thanks for the comment, will revise. I still don't know most of the
debugging functions in the kernel, as I am a relatively new hacker.

> >
> >         hu->hdev->set_diag = btintel_set_diag;
> >         hu->hdev->set_bdaddr = btintel_set_bdaddr;
> > @@ -591,12 +591,12 @@ static int intel_setup(struct hci_uart *hu)
> >                 return -EINVAL;
> >         }
> >
> > -        /* Check for supported iBT hardware variants of this firmware
> > -         * loading method.
> > -         *
> > -         * This check has been put in place to ensure correct forward
> > -         * compatibility options when newer hardware variants come along.
> > -         */
> > +       /* Check for supported iBT hardware variants of this firmware
> > +        * loading method.
> > +        *
> > +        * This check has been put in place to ensure correct forward
> > +        * compatibility options when newer hardware variants come along.
> > +        */
> >         switch (ver.hw_variant) {
> >         case 0x0b:      /* LnP */
> >         case 0x0c:      /* WsP */
> > @@ -777,7 +777,7 @@ static int intel_setup(struct hci_uart *hu)
> >
> >         rettime = ktime_get();
> >         delta = ktime_sub(rettime, calltime);
> > -       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> > +       duration = (unsigned long long)ktime_to_ns(delta) >> 10;
> >
> >         bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
> >
> > @@ -822,7 +822,7 @@ static int intel_setup(struct hci_uart *hu)
> >
> >         rettime = ktime_get();
> >         delta = ktime_sub(rettime, calltime);
> > -       duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> > +       duration = (unsigned long long)ktime_to_ns(delta) >> 10;
> >
> >         bt_dev_info(hdev, "Device booted in %llu usecs", duration);
> >
> > @@ -977,6 +977,7 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
> >                                     ARRAY_SIZE(intel_recv_pkts));
> >         if (IS_ERR(intel->rx_skb)) {
> >                 int err = PTR_ERR(intel->rx_skb);
> > +
> >                 bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> >                 intel->rx_skb = NULL;
> >                 return err;
> > --
> > 2.44.0
> >

                 Uri Arev

