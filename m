Return-Path: <linux-kernel+bounces-118083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCAF88B36C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CF230595E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A89D71747;
	Mon, 25 Mar 2024 22:07:12 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BD71739
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404432; cv=none; b=C0CcwqTTf+CEUA0R83ms6YLn8KyvvrCrWCy28D5YoAdP0bng+RjZMw6FG/kJGrRIuBHDbV2l57TPsdH3NChwt10BwzRp7VTy0tzGXsOpL1WHrU8CbczO5hvXsdPMz2QzWjiqw+vMr4A/dVHEYQnEFgSa0o52mvs370rvvJ3fUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404432; c=relaxed/simple;
	bh=EMiOVf45ss87dGK9cVe/o5M2xwdQcFYlhgc0G6qx4T8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIZlAjHep9T2eel5oQfSJhaB56V+9Vd80A5Skc7vVsbyozmRQGspy9K5F/txVxUsl+WhUFX/We4NxFVeVt68pV+rKB+hOs5rgBUPo17nMZ0GU/bs+DAzN5Ay9hDafwRE7we88kH33VzOOnBQ7GU4onedqmhXcbyxiHnvzco9sg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 01746dfc-eaf4-11ee-a9de-005056bdf889;
	Tue, 26 Mar 2024 00:07:02 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Mar 2024 00:07:01 +0200
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ALSA: hda/tas2781: add debug statements to kcontrols
Message-ID: <ZgH1hVH_1-7kFbgp@surfacebook.localdomain>
References: <cover.1711401621.git.soyer@irl.hu>
 <cbdc337b911bee0f80f805b936041fd59c1db54a.1711401621.git.soyer@irl.hu>
 <377e0f33-697c-4baf-ac48-baff6199dd53@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377e0f33-697c-4baf-ac48-baff6199dd53@linux.intel.com>

Mon, Mar 25, 2024 at 05:01:18PM -0500, Pierre-Louis Bossart kirjoitti:

..

> > +	dev_dbg(tas_priv->dev, "%s: %d\n", __func__,
> 
> Nit-pick: you don't need to add __func__ to dev_dbg logs, the user can
> add the information with the dyndbg parameter, e.g.
> 
> options snd_intel_dspcfg dyndbg=+pmf
> 
> dev_err/warn don't have this functionality though so in those cases
> there's no replacement for __func__

You beat me up to it, I just downloaded the email thread to say the same.

Since I'm here, I think __func__ in dev_err()/dev_warn() usually says about
poorly written message itself (that it's not unique enough to distinguish
taking into account that this has device instance name as well). While pr_*()
ones indeed may benefit from having it.

-- 
With Best Regards,
Andy Shevchenko



