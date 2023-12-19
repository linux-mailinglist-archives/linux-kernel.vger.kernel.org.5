Return-Path: <linux-kernel+bounces-4810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDBE81824D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB4C28173E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611328BFE;
	Tue, 19 Dec 2023 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g7kIdKys"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984B14002;
	Tue, 19 Dec 2023 07:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984A4C433C8;
	Tue, 19 Dec 2023 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702970961;
	bh=y6RBCIu9OY3HOVOGUQg3W1nyYZAoT5q8bmoyUiYZ9ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7kIdKysYjh1FddlkGPrnR24C9vihgrdtdAXuRUtvanGhYya58+wah0ILnQBQ7zzT
	 QOtr/ZcH/dfvDFRf/DzzeYWKa8EiG8Cp945+QyUMbjAYPHI4vsmguW/tu2BHLEb5hO
	 xZMrVTYq4G12N99X877RFH2CDTtuFNJZm9wAMXpc=
Date: Tue, 19 Dec 2023 08:29:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, Maxime Ripard <maxime@cerno.tech>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 5.10 00/62] 5.10.205-rc1 review
Message-ID: <2023121951-cement-repaying-f524@gregkh>
References: <20231218135046.178317233@linuxfoundation.org>
 <CA+G9fYszCtMbbrurrjqpDzSa20ZX5mVdQ+RZv-KdiyLU4o5=0Q@mail.gmail.com>
 <ZYDp1XeCrTlaOrIF@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYDp1XeCrTlaOrIF@codewreck.org>

On Tue, Dec 19, 2023 at 09:54:45AM +0900, Dominique Martinet wrote:
> Naresh Kamboju wrote on Mon, Dec 18, 2023 at 08:54:13PM +0530:
> > commit that is causing build failure,
> > drm/atomic: Pass the full state to CRTC atomic begin and flush
> > [ Upstream commit f6ebe9f9c9233a6114eb922aba9a0c9ccc2d2e14 ]
> 
> I also had to fix up a few nxp-provided drivers because of this commits,
> it seems a bit heavy-handed for stable trees when users can have a
> couple of out of tree modules.
> 
> It's marked as a stable dep of fe4c5f662097 ("drm/mediatek: Add spinlock
> for setting vblank event in atomic_begin") but that looks like it's only
> because of the context and it should be easy to backport that commit
> without the crtc atomic begin/flush rework -- what do you think?

Good catch, I've dropped those two larger dependent patches now and
fixed up the spinlock patch by hand to work properly.

I'll push out a -rc2 now, thanks!

greg k-h

