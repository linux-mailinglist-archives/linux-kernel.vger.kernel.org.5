Return-Path: <linux-kernel+bounces-80271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C74862CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368E5B21529
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3121B7FB;
	Sun, 25 Feb 2024 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="P29Ipmfl"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AF19BCA
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892202; cv=none; b=ssYfTWluM5rAjFlYISKbUBZlnLL4dzIRKvGjqJRvKhRCqtptePJ6d0tgsp35kKd7CaOyplonjuasaK2NwIiEakZpUNOx/7wb+dTXjSMwqa0GIqYq2KEkhQn39EUsrHE63BqJgkEHWZBgR7RjWbNX7ArtnRsVcZLljAx3h2r3oFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892202; c=relaxed/simple;
	bh=cPbPG3uOvlFXj7CQ8vLSlhfo46pBPzqgKu0g5fXAYM8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRZsrmntlclP2N+el5jeG49XX6ecUP/C6jxQuM0yIO0otcfLQLW1xS80ch0OkTQZgzjxXjKLzkkGnRhkUaWhBMDJ4ituvJoizq/z8RdZB7G5JhvOjwnaN71NtYTw9aWqz9khBCg6i4gm+umbK2EmnqVUIuI/+OxJeDZBKRp6tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=P29Ipmfl; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1708892190; x=1709151390;
	bh=cPbPG3uOvlFXj7CQ8vLSlhfo46pBPzqgKu0g5fXAYM8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=P29IpmflpJfyZiJQm3j6juYz6/e+zOKi0E5LqEKSENaPU84I9QtxcGWjezFQ1Ko3j
	 aBBjjH47hs1inq9Xgp+jNJlVrXGxDAV9QxI18jq4e3UhUvtV/RJWNQxYfPQRRO4zPK
	 JLaHyQ68hkZr2PNk8CfyYq1i8OKg2B5nViM83iAtWyOCiKXlPFYXC4Jw4dtX0SmtaW
	 B2kamzYH2BXF4Aqbj5sUWTRE5MODkLjHtLvHYRDR+7Okqka9N/zuA2IYK3QlmYXIV+
	 lxZeMupsQSeFo1jtRncvPawNHdFsSHF1YjnsR/YUSgn4kwBzOPZ3HmdLR220Tmt2HF
	 qntk5mKjDEhbQ==
Date: Sun, 25 Feb 2024 20:16:08 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, saravanak@google.com, abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, colin.foster@in-advantage.com, djrscally@gmail.com, dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, rafal@milecki.pl, ansuelsmth@gmail.com, richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, jpb@kernel.org, rafael@kernel.org
Subject: Re: [PATCH v1 2/4] driver core: fw_devlink: Link to supplier ancestor if no device
Message-ID: <iAkBSgwuEqM4V5DeWWTplkq23zj8zBgHebmwIbpQl7MiojKNiMDtJxN_SaQ2F4CjD42K2gR5wxG-63JiUX0mcZ48UrZY2augArDt-II5_TQ=@pm.me>
In-Reply-To: <20240205160011.42d1cf80@xps-13>
References: <20240123014517.5787-1-mcpratt@pm.me> <20240123014517.5787-3-mcpratt@pm.me> <20240205160011.42d1cf80@xps-13>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Thanks for taking a look at what I have so far.

On Monday, February 5th, 2024 at 10:00, Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:

>=20
>=20
> Hi Michael,
>=20
> mcpratt@pm.me wrote on Tue, 23 Jan 2024 01:46:40 +0000:
>=20
> > If a fwnode is flagged as FWNODE_FLAG_NOT_DEVICE
> > by the time a device link is to be made with it,
> > but not flagged as FWNODE_FLAG_PARENT_IS_DEV,
> > the link is dropped, otherwise the device link
> > is still made with the original supplier fwnode.
> > Theoretically, we can also handle linking to an ancestor
> > of the supplier fwnode when forming device links, but there
> > are still cases where the necessary fwnode flags are still missing
> > because the real supplier device did not probe yet.
>=20
>=20
> I am not sure I follow this. In the following case, I would expect any
> dependency towards node-c to be made against node-a. But the above
> paragraph seems to tell otherwise: that the link would be dropped
> (and thus, not enforced) because recursively searching for a parent
> that would be a device could be endless? It feels wrong, so I probably
> mis
>=20
> node-a {
>=09# IS DEV
>=09node-b {
>=09=09# PARENT IS DEV
>=09=09node-c {
>=09=09=09# PARENT IS DEV
>=09=09};
>=09};
>};
>
> Besides that, the commit feels like a good idea.


The link is dropped _in order to_ make the dependency towards node-c
become a dependency towards node-a instead.

The "recursive searching" happens after links are dropped in order to
create the new fwnode links, and it depends on the new flag
being placed when the supplier device (node-a) probes, which can happen
before the links are re-attempted, or after a single probe defer of the con=
sumer.

I placed all the logic that decides whether to drop links and retry linking
to the consumer immediately before a probe defer of the consumer would occu=
r.
That logic could be distributed around multiple functions for fw_devlink,
but I'm concerned about false positives. The only reason I didn't use or ma=
ke
a new function in order to "move" the links is that in this position in the=
 driver core
which I believe is the right place to do the fixup function, we don't have =
direct access
to the fwnode that the links should go to, it would have to be discovered b=
y recursively
walking up the tree looking for the flag in the new fixup function
instead of where the fwnode links are made.

To me, it doesn't matter which order we call the functions,
but if we are starting with fwnode links that refuse
to be converted to device links, we need to do more than just move the fwno=
de links
because after a probe defer there is no hook to automatically try switching=
 them
to device links again. Driver core expects that to have already happened by=
 then.
I imagine that without having to add a lot more code in a lot of places,
I would have to call fw_devlink_link_device() after "moving" links anyway..=
.

It's possible to call that function only when the bad link is still a fwnod=
e_link
and do a "move" function when the bad link is a device_link, that is,
if "moving" a finished device_link is possible or good practice at all
since it would be skipping quite a few checks that occur before a device_li=
nk is made.
It seems to me that making a device_link is a multiple-step process, so a n=
ew function
to only move the supplier of a device_link might be a big one as well.
I tend to try to reuse as many core functions as I could.

>=20
> Thanks,
> Miqu=C3=A8l

--
MCP

