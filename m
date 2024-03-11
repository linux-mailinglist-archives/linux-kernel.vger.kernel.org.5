Return-Path: <linux-kernel+bounces-98921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE7878108
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A962876EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F24207F;
	Mon, 11 Mar 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4vIxYE71"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BE4176D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165256; cv=none; b=FJ+LKRvUbVFuj8N4JkTvXtvWlth8rs00ovF6k6fZEIrOaJkChYWYJDxgkJPPctzTwou8Kb5QntB5ecjp2ZlEjU52JYhFO3WnU5E9sCnn7qVvOExyXqSRWgpoVAFtXX4Zkd30R7gFH1JOZqwSF3Xsxt1yqHE1BLb/eSegnWWJa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165256; c=relaxed/simple;
	bh=teFg2HfjlhBa/0gCJJYb2mjJeW6F9dWs3JYVo56bMdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQWS2sftyQpcqfeDYHWMQx1DZ71osTRRzGDqZeACfEFzpQRGX21yWtakT2SHahVKYsNWqtJxktcOckZkMbT0rhc2eGp+Nyt8PqL9lMrdNWehhCPk4pp7yjoAXa74aa0BugAYJ88PYL0tSKaRZM1MdG9N4PKAUNEV2CuOQPPg+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4vIxYE71; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710165253;
	bh=teFg2HfjlhBa/0gCJJYb2mjJeW6F9dWs3JYVo56bMdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4vIxYE71aIbuFjJXlBEpf8zMCx63GovGRmWPLlpJ+Qkbxq1qfEIBmPpppIEZ/uu0s
	 Ro3LgG8cHIZKx5mZ3RXZN13qHECNIMbdrZq66uCbMD8oFJ8AgIdT3G4STcUfiV1nKz
	 uaZfVoxoYLHGLfN3IkT2Uh0uE3stt8jMtvEVJR98+U9/7nxD06fNyYVl0H9GgAD151
	 5IyApVlO597zycgi19NsoIlfBZTkaVBI8vQ9Ghxj1ywGk4kiOmxWp7yIlZWJ6Zj9Z2
	 9wUeDCCRxCYxPHwUQn+2UH9YMfZe3DHsHQ4lVceaT0C8CSuVzekxK44ZvrdK7xJGlx
	 3Rq+lZn7gSTjw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 16E453780894;
	Mon, 11 Mar 2024 13:54:11 +0000 (UTC)
Date: Mon, 11 Mar 2024 09:54:09 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>, regressions@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: Probe regression of efuse@11f10000 on
 mt8183-kukui-jacuzzi-juniper-sku16 running next-20240202
Message-ID: <82c0c04c-ccea-4839-80dc-16bcf6794bf3@notapiano>
References: <47cdeac1-121d-4b1a-a3ac-e2affc7a2fc3@notapiano>
 <c4416256-eedc-4c9b-b968-3a02490c4c09@notapiano>
 <b888cbe2-6071-4445-91cd-8ce7cc9cc8f4@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b888cbe2-6071-4445-91cd-8ce7cc9cc8f4@leemhuis.info>

On Sat, Mar 09, 2024 at 03:06:38PM +0100, Thorsten Leemhuis wrote:
> On 08.03.24 15:31, Nícolas F. R. A. Prado wrote:
> > On Tue, Feb 06, 2024 at 11:11:00AM -0500, Nícolas F. R. A. Prado wrote:
> >>
> >> KernelCI has identified a regression [1] on the
> >> mt8183-kukui-jacuzzi-juniper-sku16 machine running on next-20240202 compared to
> >> next-20240118:
> >>
> >> #regzbot introduced next-20240118..next-20240202
> > 
> > Not sure why this got filed by regzbot under the mainline tab rather than next.
> > Maybe it was the missing collon? 
> 
> No, I guess that is a bug in regzbot: the support for -next is there,
> but not much tested. Will need to take a closer look, will do so in the
> next few days.

Ah ok, that's good to know.

> 
> > In any case, the fix has already made it to linux-next, so this should close the
> > regression:
> >
> > #regzbot fix: nvmem: mtk-efuse: Drop NVMEM device name
> 
> Out of interest: Is involving regzbot worth it in case the fix is
> already in -next? Or is that primarily to keep track of "we found a
> regression and a fix was already available in next". I don't mind if
> it's the latter, just curious.

When the fix has already landed in next, no, I guess it wouldn't make sense to
involve regzbot, as that would be like creating a regression ticket that is
closed from the start. (And basically it would mean we're testing an outdated
kernel release, which is not very helpful)

In this case when I sent the regression report the regression was still there on
the latest next. The fix had been sent, but not yet merged into next. In that
case it's very much helpful to involve regzbot so we can track the fix and make
sure it gets applied. Also, as was for this case, and probably many others, the
fix patch didn't have that much information on the symptoms and circumstances of
the issue, while the regression report I sent did, so the regression report
should be easier to find for people encountering the regression, and then they
can easily see the status of the regression through regzbot.

Thanks,
Nícolas

