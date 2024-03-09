Return-Path: <linux-kernel+bounces-97765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A061A876F1C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D616C28255B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4136AEC;
	Sat,  9 Mar 2024 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxjs36Kr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC4241E2;
	Sat,  9 Mar 2024 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709957850; cv=none; b=jWSzoSCH8iBw2+0Lo7VPrr1SMfi7BlhWy4090TT2jcmQ8Qz5tipccFrNfbc2Ro9U0eWXVyq0PleG/RbEB45l/avKSOq9d+RroU2/hIsiO8eRKIDRmY8zlS9hg4Dg1P6K0QQz2jyLMrZYSOG0z+Ml8+Xe50div+hXKYAwVsBMovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709957850; c=relaxed/simple;
	bh=tyzSXJgpPTfUPd2ogPeJIwbYgRW4+h6K0zmCJkzehkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaDXAWpAGMnEBRmyL2/1GZWzAwahlzxvx4zKqIK0DJX54J5uXe3I/a+cltLNIDMuVxlBpOfqTofDM1ogqvhZH8ZKQZjqi7Y0mt/Bhvq/GgfkFyYORtC48+8kOv3qI4k/wgbiIq19nDV89TGZZrxk0Yr1XHdE1rsG/Xw9XYIjwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxjs36Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE418C433C7;
	Sat,  9 Mar 2024 04:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709957850;
	bh=tyzSXJgpPTfUPd2ogPeJIwbYgRW4+h6K0zmCJkzehkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gxjs36KrENkTb5op63Tf6+cdzG8qzeJVtw5L6RujJ7HNizkIzy8srqki84avaVXTz
	 Pd8mufS8dQ+sKLodsi/HbWj5nV9mt6txdRTmCxUpYMaKjwSTVouv/IGJlWZb6kAbyA
	 fZlHEfaAA31UjMXOQHohFnDkqm8afj28PQ2/NsMKWICVutfma25LcfCd0MaPs44zts
	 sl88WRUeql7TLBn29ZDkF9pffDm2fvIleYOFxStB+uMOd+iQrCIPeWLJyAmmvMocLP
	 p8Ur6rcJ64uSnvfcSeoeQOesT2vGwnLQaosDdFHJw56oe6NmREAGNjYR3Zs4XEFJzk
	 5PP7QGHR/iBeA==
Date: Fri, 8 Mar 2024 20:17:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: netconsole: Add continuation line
 prefix to userdata messages
Message-ID: <20240308201728.59e2e0ff@kernel.org>
In-Reply-To: <20240308002525.248672-1-thepacketgeek@gmail.com>
References: <20240308002525.248672-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 16:25:24 -0800 Matthew Wood wrote:
> Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Breno, LG?

