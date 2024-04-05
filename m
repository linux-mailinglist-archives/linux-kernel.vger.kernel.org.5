Return-Path: <linux-kernel+bounces-132758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360FC8999D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF58B214A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED331607BF;
	Fri,  5 Apr 2024 09:46:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA51474DC;
	Fri,  5 Apr 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310371; cv=none; b=PTMa3XlPPk+ouVtRRqUSqjd9NWYC3iNNQsj4/KEzhOWoKYBlQgdE27HDEB8GgfhocyJFPWpDWt2Y1L2doHy2BvAcirkLjlGwXDjPN59nfsltWr9mRX1UPiNIBQ7MRVxH7rNicX0wJSsELE2tdyGnLFkImTv+WuGsdJ/TTo7wi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310371; c=relaxed/simple;
	bh=N/ilJYPULnziC1IDqUT0V88hxfBEu9DOsd7q2tbFgn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVq7xQ6Dca7GdhI+pMqKBZr1mjbnpqdoOBc4oqINPijzhZQYyI98JNPmVuJYXrrg7JCoaWpPWUG2yAK7aPfststfjLU2Jf3rmQIhsVuRPjLSfBLVyKP2NWwG7NSwLk3Ep3s5DSPwEx/Auw7s2PubEfQZuMoaU3fC7KKzJqts808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D534FEC;
	Fri,  5 Apr 2024 02:46:39 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AF6A3F64C;
	Fri,  5 Apr 2024 02:46:07 -0700 (PDT)
Date: Fri, 5 Apr 2024 10:46:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <Zg_IXLNPakLmbbc7@bogus>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Fri, Apr 05, 2024 at 02:13:28AM +0000, Peng Fan wrote:
> Hi Andy,
>
> > Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
> >
> > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > The SCMI error value SCMI_ERR_SUPPORT maps to linux error value
> > > > '-EOPNOTSUPP', so when dump configs, need check the error value
> > > > EOPNOTSUPP, otherwise there will be log "ERROR READING CONFIG
> > SETTING".
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > (...)
> > > >                         ret = pin_config_get_for_pin(pctldev, pin, &config);
> > > >                 /* These are legal errors */
> > > > -               if (ret == -EINVAL || ret == -ENOTSUPP)
> > > > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret ==
> > > > + -EOPNOTSUPP)
> > >
> > > TBH it's a bit odd to call an in-kernel API such as
> > > pin_config_get_for_pin() and get -EOPNOTSUPP back. But it's not like I care
> > a lot, so patch applied.
> >
> > Hmm... I would like actually to get this being consistent. The documentation
> > explicitly says that in-kernel APIs uses Linux error code and not POSIX one.
>
> Would you please share me the documentation?
>

+1, I am interested in knowing more about this as I wasn't aware of this.

> >
> > This check opens a Pandora box.
> >
> > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to have
> > them being moved to ENOTSUPP, rather this patch.
>
> I see many patches convert to use EOPNOTSUPP by checking git log.
>
> And checkpatch.pl reports warning for using ENOTSUPP.
>

Exactly, I do remember changing ENOTSUPP to EOPNOTSUPP based on checkpatch
suggestion. So either the checkpatch.pl or the document you are referring
is inconsistent and needs fixing either way.

--
Regards,
Sudeep

