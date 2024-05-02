Return-Path: <linux-kernel+bounces-166238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5EF8B97E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C195A2847E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EEF55C1A;
	Thu,  2 May 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLhl8z8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B55537E7;
	Thu,  2 May 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642722; cv=none; b=qAbszB4wRJbrYM11103WXqRMRJvb55lrFayxbsVtPvVEOeki2+6wu5A/f8lCnWo2OA6hRcM9wrqDlh/o2P1nxh17JA7GHGXKZztIO/0RJ2oOqhfQdDnYF8liT+5DCS4Xe9/+G7rp+UNsCKAyzzh8SjabRFpAfgdJR4KkMoupQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642722; c=relaxed/simple;
	bh=XwHxRHno9d682eEmga3lxYLCiiBJCv6+R/4CNOK+wX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxqrEt9huZuAjHWUY18hSbVDfaa5l0d4UKXo3nomNGGm0fkV3R0QcrHIOVLGPS0ebURHxYApQngQEurKhQI7jgmimpA5sLnORPDETw/BuLkoikfxyS3JXruPcObXcSiydaKCUTMz4hoV1KOdNBjRNl2JcSoNELD9XnxxpgPBR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLhl8z8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09867C113CC;
	Thu,  2 May 2024 09:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642722;
	bh=XwHxRHno9d682eEmga3lxYLCiiBJCv6+R/4CNOK+wX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLhl8z8DuaSnTjuZGogLydgg4R4bcI98TltjMLHpguwa7qSlHd5lA5366poMcdzW7
	 TKjMO3MC7bfMEt++e+lm5i+Sf7+L4kBM75fIrBpJvFP7BLzEVPeFyAlO5Savpt4tQY
	 PVlydbsz5J1Xu+hp3U4pkuftnuKfAHJu9famHkJj3lg/YoUViQqh8Cg/WAFwlk4DzL
	 la3KLy8Oz5az2PF2bOJ9kqq7w1n4MERBzr2tfRvzFgXaIaM+wUtb99DD2zgfQwXsMI
	 w6Tbbpp3AdMLfzymN6O+Gg7uC5AkPkH6RnOlpNIjGw/4CiHQ3sP/InDrGp931wLf+k
	 sCUT5FGI8cuDg==
Date: Thu, 2 May 2024 10:38:36 +0100
From: Lee Jones <lee@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Message-ID: <20240502093836.GL5338@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <ZidE5UcQ6XSc0YBI@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZidE5UcQ6XSc0YBI@finisterre.sirena.org.uk>

On Tue, 23 Apr 2024, Mark Brown wrote:

> On Thu, Apr 18, 2024 at 01:07:31AM +0100, Andre Przywara wrote:
> > This is v2 of the fixes to the AXP717 PMIC support series. Lee put the
> > original patches in an immutable branch already, so these here go on top.
> > Patch 1 is new in v2, and adds the IRQ status and acknowledge registers
> 
> Lee, this looks like more of a regulator series than a MFD one (it's got
> a couple of small updates to the MFD but it's mainly focused on the
> regualtor functionality) so it probably makes sense to merge via the
> regulator tree?

I'm fine with it.

Please ensure a succinct immutable branch is available in case of future conflicts.

-- 
Lee Jones [李琼斯]

