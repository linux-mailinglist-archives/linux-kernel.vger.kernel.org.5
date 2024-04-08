Return-Path: <linux-kernel+bounces-135308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3128789BEB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E92D1C21583
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8556A8A7;
	Mon,  8 Apr 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stfBO71f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC76A33B;
	Mon,  8 Apr 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578476; cv=none; b=Zow68kSzT+c/OYyaS4bvFbkEL4AEgtrku76OH4xMjJsrBxPLK89tx5d5fOYOVv3Z+VzCv+WSI5Zlk8fLUlcpsBzWPon4/geVi1oB0iCQJ8/jJLAYAAr0OWaUUhE/akiS4L1qMnUvBWmZAOACQYFZbyOU2RMh7NsTAhNBqaYELzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578476; c=relaxed/simple;
	bh=x+FsxZWRAjPjLs6UXRrQ4jbrSYbaGPFtemQodRNwj0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QomQLE1AM9x+TbfurQJuR2Kr/ZvQY/H22PmAAhjvpQ+okUMW+FQEN9g7+hPQ5wkRCSBTvDEXWk44iu+8sQqsxn+bW9+VJWTAcW1FXBWxRe53RknSs18V1mGuLxEjAQoVy4yXIK3FCVv5gzxf61oKK8aIPL8mwqQ4GErYFkVfI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stfBO71f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE6FC433C7;
	Mon,  8 Apr 2024 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712578475;
	bh=x+FsxZWRAjPjLs6UXRrQ4jbrSYbaGPFtemQodRNwj0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stfBO71fztxYkHI6vQb0jBV0kkAT+9xNUYlPLhYKidsvrIigy4SLLrRQrckt/8Ovw
	 /xMaqUilw8ZVL/gTLnwzb+gETQokd2aLRtEJa57lwprg50osIy3lj1OGAeewn24yM3
	 kom4j8UtMNnJmq2jM1IbJMp4AGA6hx2yDi2WJYp2hHyEBagjcLYSniK1GRc6Uqq67f
	 1ghx88gA6ywGh94lZdWi03fvYNNtBQKZJiWYIV+tDQFI28zLcnzYDl4yabYGJ8CQWk
	 iDcJvIv2DlSNv63+RcelicnrMEBP7Y3AfiZFY4czY3UdHyoJRlcJS6/7/mHlcGCjlv
	 9dAXU6vYEo5hA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rtntN-000000002B9-0kG0;
	Mon, 08 Apr 2024 14:14:29 +0200
Date: Mon, 8 Apr 2024 14:14:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
Message-ID: <ZhPfpaEx9fV61Y_3@hovoldconsulting.com>
References: <20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org>
 <ZhOYpHXz6t0fkzZ2@hovoldconsulting.com>
 <2ejpom6ykci6o7d7luwa2ao4stpm24aoyi66aoncxcqcwgidxz@gcsqvpb3s7nr>
 <ZhPYjXjX3LcCMhyh@hovoldconsulting.com>
 <CAA8EJprJn-sq1Xb9E0bJD814CepKPzsD=xCFAKFeCGjj2Tv9Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprJn-sq1Xb9E0bJD814CepKPzsD=xCFAKFeCGjj2Tv9Dg@mail.gmail.com>

On Mon, Apr 08, 2024 at 02:48:44PM +0300, Dmitry Baryshkov wrote:
> On Mon, 8 Apr 2024 at 14:44, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Mon, Apr 08, 2024 at 01:49:48PM +0300, Dmitry Baryshkov wrote:
> > > On Mon, Apr 08, 2024 at 09:11:32AM +0200, Johan Hovold wrote:
> > > > On Mon, Apr 08, 2024 at 04:06:40AM +0300, Dmitry Baryshkov wrote:
> > > > > If a probe function returns -EPROBE_DEFER after creating another device
> > > > > there is a change of ending up in a probe deferral loop, (see commit
> > > > > fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER").
> > > > >
> > > > > In order to prevent such probe-defer loops caused by qcom-pmic-typec
> > > > > driver, use the API added by Johan Hovold and move HPD bridge
> > > > > registration to the end of the probe function.
> > > >
> > > > You should be more specific here: which function called after
> > > > qcom_pmic_typec_probe() can trigger a probe deferral?
> > > >
> > > > I doubt that applies to tcpm->port_start() and tcpm->pdphy_start() in
> > > > which case the bridge should be added before those calls unless there
> > > > are other reasons for not doing so, which then also should be mentioned.
> > > >
> > > > I suspect the trouble is with tcpm_register_port(), but please spell
> > > > that out and mention in which scenarios that function may return
> > > > -EPROBE_DEFER.
> > >
> > > The probe loop comes from from tcpm_register_port(), you are right.
> > > However then putting bridge registration before the _start() functions
> > > is also incorrect as this will be prone to use-after-free errors that
> > > you have fixed in pmic-glink.
> >
> > You obviously have to mention that in the commit message as that is a
> > separate change and also one that looks broken as you're now registering
> > resources after the device has gone "live".
> 
> No. I'm registering a child device rather than a resource.

There's no difference. You're registering a resource for someone else to
consume.

And it's not obvious that this does not lead to missed events, etc. in
this case.

> > So you also need to explain why you think that is safe, if it should be
> > done at all. You're essentially just papering over a DRM bug in the
> > unlikely event that probe fails.
> 
> Unfortunately, as pointed out by Reported-by, Caleb has actually hit
> the probe failure loop.

The probe loop is probably real, I don't don't doubt that, but you
still need to explain when tcpm_register_port() can return
-EPROBE_DEFER.

But the point is, you don't have to register the bridge after *starting*
the port to fix the probe loop. You're doing that for other,
questionable reasons and you don't explain why in the commit message so
that others can evaluate your reasoning.

Johan

