Return-Path: <linux-kernel+bounces-129500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DB3896BAF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BAB3B27A50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E67137C2F;
	Wed,  3 Apr 2024 10:06:10 +0000 (UTC)
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B113AA27;
	Wed,  3 Apr 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138769; cv=none; b=nZxZz3VcJGg74fhdqYe/LdWaVed2/g0JbHAcsDi2zU7ne9IOEbuKgFexMPOMpllR/MNic5Brg1Own/H95PmqobVrCklawfEOQqSzRFnUl9cFw6iH0+rYxUylwhigRcZTcodAaYTBFNrS2ZQOhmGQkLKYhEuR7Mc9R0bPgfHnRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138769; c=relaxed/simple;
	bh=PtsQ7BPoEhJdj1DTbguN0BEbC+PRqVWUfaWeLRN8KX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2BaEO3egs+We93TZMvJBLyI7gS5zK93axSr29PBMWKBBoHSk5zwx34m6qnT+lae8QQdot2qHll1P5YMUlR9EXs2Adz/LNMQxE+FsykabBcasBIBjtZwlEjUtFSwOZ59ZFs3EwtP+lS88rfZo47lLuS+ksE/iAfO0Gc3QojIFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C482D3EDD1;
	Wed,  3 Apr 2024 12:05:57 +0200 (CEST)
Date: Wed, 3 Apr 2024 12:05:55 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v3 4/4] drm: panel: Add LG sw43408 panel driver
Message-ID: <vcxytd7cxmvno3hb7tvxwfbnsupaw3mcqplt7mnrntjhkybklr@lxffwioi2bzn>
References: <20240402-lg-sw43408-panel-v3-0-144f17a11a56@linaro.org>
 <20240402-lg-sw43408-panel-v3-4-144f17a11a56@linaro.org>
 <3hh7nfqflj73422q47p6do7aiormxwspwkfg557epeqn2krtcc@dsufsohfaz4l>
 <pair66urg2ecqhob5gzzdtzuyofrmcf6rk7v2akggbotcpv7ld@bxhxftbd4xbn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pair66urg2ecqhob5gzzdtzuyofrmcf6rk7v2akggbotcpv7ld@bxhxftbd4xbn>

On 2024-04-03 05:37:29, Dmitry Baryshkov wrote:
> On Tue, Apr 02, 2024 at 11:17:52PM +0200, Marijn Suijten wrote:
> > On 2024-04-02 02:51:15, Dmitry Baryshkov wrote:
> > > From: Sumit Semwal <sumit.semwal@linaro.org>
> > > 
> > > LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel, used in some Pixel3
> > > phones.
> > 
> > @60Hz?
> 
> With the current settings and timings I'm only getting 30 Hz. I have to
> double the mode->clock to get 60.

Still seems useful to mention (here and in Kconfig).  The proposed driver emits
a mode to userspace of 60Hz, maybe the commit message should say that in the
current state "something" prevents it from going that fast?

Since I keep forgetting (because it's not mentioned anywhere) that this is a
cmdmode panel (or at least configured for that with the current driver), I'd
again suggest to play with sync_cfg_height.  If setting it to 0xfff0 results in
timeouts, your tear GPIO is misconfigured and not making the MDP aware of the
actual tick rate.

Otherwise, more likely, just bump up the porches a bit, based on the discussions
around reduce_pclk_for_compression() /not/ accounting for transfer time in
cmdmode.  In one of my drivers (pending eternal cleanup hell) I inlined the
calculation to reverse what the "right" porch should be based on a downstream
clock rate:

https://github.com/somainline/linux/commit/85978a69cde088a23963c03758dad5f1a2e79bab#diff-a9ac8689e45c59a4fe9aa150e4bd53675687f5c8b4aecb40b5b5b66b864257e0R353-R366

And separately, though I cannot find it, there have been (more accurate?)
calculations based on downstream `qcom,mdss-dsi-panel-jitter` and friends.

- Marijn

