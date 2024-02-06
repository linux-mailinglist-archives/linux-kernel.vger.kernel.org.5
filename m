Return-Path: <linux-kernel+bounces-54679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C693884B25F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10199B2661D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95612DDB3;
	Tue,  6 Feb 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z88lnJLw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393212B14E;
	Tue,  6 Feb 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214721; cv=none; b=NWGQa/WhSFbT+Glkj+qPK3oBXp8n+S+uSpJWXaoCPX9lIpoCq3uZ9ZXg0fh7mu6y2hsoeUt0jPwXt1A9ep7pzrCFeMrPZAhYMm+oUnmghP8xh+aaP8vFJ7al+rM5ljeGkkrAbE7kjiVbpLjjsAkYMuqmLantfJRrLXvkEnIPdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214721; c=relaxed/simple;
	bh=8oScLxzw3aBc2CthwbejXgtiSm9NvZ9+lZg+kx+hQzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ7RoumjzQUvg9186GhOj5rbGnESmNGKOWuxLt5iBxr7lnddIa55hm0oW6Hvq19dg5OStpwtX2+NoFESVF4iLdff8x5E3VvnHvd5SQICSxTRTSMUcGjWwQzO4wo58t8XYJmNCgh1cV4g5fDEWbPXGqyG5JcPyNeE2yk5EP4DfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z88lnJLw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707214719; x=1738750719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8oScLxzw3aBc2CthwbejXgtiSm9NvZ9+lZg+kx+hQzs=;
  b=Z88lnJLwojXrUze5ZzJniBDdGZU4KuQt/saa4AMEb5eZUHIIGHbX+huA
   Ov/LSyiDGfWvjzPuljVSDIjN2uz7VZXttvd9N5a5wUnzap5u/sZEY1J2T
   3lqcPHZ9GSICokJbl6tDKxGfhUxJZ7WBeESbHWB/0cQRUzO2jqcbQuXlQ
   vIWmeoz30PwdTJhSMUaX+FE7AJodVzjR7rGVdmXMT8bXY2j8a8IFc6048
   QD74h1x45dsM0jJlGDRbiNzOZRtAVWsxlsFmiPk1+dtg5dbGGlVjrjLdU
   9DyGJjs+cX1h2+FCr+xMUg42rOxIPQwfXVeUw79GD8bZJYrFhoHreOuer
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="598377"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="598377"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933419597"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="933419597"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 06 Feb 2024 02:18:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 Feb 2024 12:18:32 +0200
Date: Tue, 6 Feb 2024 12:18:32 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>, linux-usb@vger.kernel.org,
	jthies@google.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: typec: ucsi: Get PD revision for partner
Message-ID: <ZcIHePkgN2in5AAX@kuha.fi.intel.com>
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
 <20240126103859.v3.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
 <CACeCKaeVtU3ckmGU932d-pPn=eOnt6KjAavNY3rSOUgrJNriDg@mail.gmail.com>
 <CANFp7mXOXc6TzLJ+EJ9VYxqGHcjW099oBhDctarUdM5eJGz5bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mXOXc6TzLJ+EJ9VYxqGHcjW099oBhDctarUdM5eJGz5bg@mail.gmail.com>

Hi Abhishek,

On Mon, Feb 05, 2024 at 02:05:38PM -0800, Abhishek Pandit-Subedi wrote:
> Hi Heikki,
> 
> Friendly ping to review this patch (I see you added Reviewed-by to the
> other two in this series).

I think Prashant said that he prefers macros with those version checks,
and I kinda agree. But I'll leave this to you to decide. I think
that's also something that can be improved later.

> On Fri, Jan 26, 2024 at 12:25 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Abhishek,
> >
> > On Fri, Jan 26, 2024 at 10:39 AM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > PD major revision for the port partner is described in
> > > GET_CONNECTOR_CAPABILITY and is only valid on UCSI 2.0 and newer. Update
> > > the pd_revision on the partner if the UCSI version is 2.0 or newer.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

So this okay by me:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> > > ---
> > > $ cat /sys/class/typec/port2-partner/usb_power_delivery_revision
> > > 3.0
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > >   - Formatting changes and update macro to use brackets.
> > >   - Fix incorrect guard condition when checking connector capability.
> > >
> > >  drivers/usb/typec/ucsi/ucsi.c | 23 +++++++++++++++++++++++
> > >  drivers/usb/typec/ucsi/ucsi.h |  3 +++
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index a35056ee3e96..2b7983d2fdae 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -782,6 +782,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
> > >         }
> > >
> > >         desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
> > > +       desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
> > >
> > >         partner = typec_register_partner(con->port, &desc);
> > >         if (IS_ERR(partner)) {
> > > @@ -856,6 +857,27 @@ static void ucsi_partner_change(struct ucsi_connector *con)
> > >                         con->num, u_role);
> > >  }
> > >
> > > +static int ucsi_check_connector_capability(struct ucsi_connector *con)
> > > +{
> > > +       u64 command;
> > > +       int ret;
> > > +
> > > +       if (!con->partner || !IS_MIN_VERSION_2_0(con->ucsi))
> >
> > I'll reiterate my comment from a previous version, since this series
> > has been revv-ed a few
> > times since and it may have gotten lost; no need to respond to it if
> > you don't want to,
> > since I believe we left it to the maintainer(s) to decide [1]:
> >
> > This macro is unnecessary. Since the version is in BCD format and we
> > already have the
> > macros for versions, just a simple comparison is enough:
> >          if (!con-partner || con->ucsi->version < UCSI_VERSION_2_0)
> >                  return 0;
> >
> > I'll add that Patch 1 of this series [2] is also using the same style
> > for comparing version numbers.
> >
> > > +               return 0;
> > > +
> > > +       command = UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER(con->num);
> > > +       ret = ucsi_send_command(con->ucsi, command, &con->cap, sizeof(con->cap));
> > > +       if (ret < 0) {
> > > +               dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed (%d)\n", ret);
> >
> > nit: I know this is being done elsewhere in this file, but we should
> > avoid putting error
> > numbers in parentheses [3]. Perhaps something for a separate cleanup patch.
> > 
> > [1] https://lore.kernel.org/linux-usb/CANFp7mXP=aN8bQi4akKKcoMZE8RaCBuFnwTa5hbp0MZvZe0hYQ@mail.gmail.com/
> > [2] https://lore.kernel.org/linux-usb/20240126103859.v3.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid/
> > [3] https://www.kernel.org/doc/html/latest/process/coding-style.html#printing-kernel-messages

thanks,

-- 
heikki

