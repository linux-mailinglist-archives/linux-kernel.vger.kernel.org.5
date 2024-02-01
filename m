Return-Path: <linux-kernel+bounces-48780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8934846125
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C202870FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18085290;
	Thu,  1 Feb 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbTcrcsZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC807C6C1;
	Thu,  1 Feb 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816464; cv=none; b=oi+BjICPfTE1I6yon9Q2hqTUjn9Y31JLY30G5pI8ckgzXLzjLls9B7nslBVrlkFjKz6D47Kp8W9iza7rQx5aH8imLicoO8j3Ac73UURcmretgeO7ZiJWnTB7MSi4fB2XA6Gxh9pNzZYbd0SjNpNw0ms9ypi890MBeoPQtwc1NyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816464; c=relaxed/simple;
	bh=mw8IruWtLhnVBZG2bw57KfvNyrKA6nWlauPlAegiYXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDboBe0om26ZBO/wwfNELDeuXzu2DzVwY3VrkZMi1XyAs0cVaGrQYG/hB0F54aDTc1Vrne5GUM98RMKwg1Qkx9yH6ZwF64sWnb2fQXnypQ366FXr7tXmDyhkKPfhl3iBdjqfBXvqrStCh+cER/83VS0n/Wlq8autMCb/VBeTz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbTcrcsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2756FC433F1;
	Thu,  1 Feb 2024 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706816464;
	bh=mw8IruWtLhnVBZG2bw57KfvNyrKA6nWlauPlAegiYXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IbTcrcsZUbMN85dPQYaJ8qHiKYG7r4m4/vfEYOZMt/h+f2q/V3Jc7gXKXWs+YfMTO
	 1elg+W0ORBzckh9fcP7CfBW054G/WcsrDwYiK1BmG1m+vN3a9npeL92wIDqwJ/pZeF
	 Hb3Taetog6bGz8vOrfoiDKy01/JZWQfY1NbNmaBTSPTzP7T588bLgP13/Ms1XeVOtQ
	 C0Pdm48g9a65sdi/W9/Hgb31NeKqeoO1TJjndCf7weVP8XYSwz6WpI5uB0uWySEXqj
	 fUvChv/wDo2t0g5vYPMnLoQKDWFl/E3Rtf203kURT5zR3FQPUTLAR4c5NhPWD8xQqd
	 bWhF7rbv7o7Xg==
Date: Thu, 1 Feb 2024 11:40:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, Andrew
 Morton <akpm@linux-foundation.org>, Mahesh Bandewar <maheshb@google.com>,
 weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, andrew@lunn.ch, leit@fb.com
Subject: Re: [PATCH] blackhole_dev: Fix buil warning
Message-ID: <20240201114059.50b1051c@kernel.org>
In-Reply-To: <Zbvm8HhzdHGXzlus@gmail.com>
References: <20240201133238.3089363-1-leitao@debian.org>
	<20240201085509.40a0bb76@kernel.org>
	<Zbvm8HhzdHGXzlus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 10:46:08 -0800 Breno Leitao wrote:
> > Since Jiri suggested a title fix I reckon we should be a bit more
> > specific, still. Imagine this title ending up in a quote or a Fixes
> > tag, could be many things.. How about:
> > 
> >   net: blackhole_dev: fix build warning for ethh set but not used  
> 
> Sure, let me resend it.
> 
> I suppose I should recent to `net` given it is a building warning,
> right?

Not necessarily, net-next is good enough for W=1 warnings in general.
Compiler warnings only show up if the file in question or some header
it includes was modified. The linker warnings are a bit special.
If you touch any file in any module you'll see all linker warnings.

