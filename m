Return-Path: <linux-kernel+bounces-119172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C388C516
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E6B21DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224F12DD90;
	Tue, 26 Mar 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS4zhIih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964F20DF7;
	Tue, 26 Mar 2024 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463226; cv=none; b=RPjMtCw6ea0xHgxYYqiZld7GB3i3nQPHrlq/t9QRAUPLh68UEq7NNvDS8lJ5dqo0eMUs+yem54ISk/tpwZxsQ1eHuJo46GpKH7Ah2Z8XW+BA/pTorV142/UrHF2PzloPhToUc+hVR4lLm8+qayGeBhGkEjIfXmFydTnNZA6ZhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463226; c=relaxed/simple;
	bh=qoEJASPCUxmcyaJydCy2VV6pZZWWMfCad+tM+6zcuU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGLavpmWKlFCUMIx3VuZNXmceC81faEZdUPcnaLrhm2eLVmYAMjs/TwKprLMZhAelc0jByAqb7RFVqiCCCD45J3d8dw7S8uo/nYjbCRHDf7x3MubqGR9wdPtzzPzucHQd/HAyR/rumhrUGveYvm61kmwf8c6ubJPpA7qf71sgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS4zhIih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A48C433C7;
	Tue, 26 Mar 2024 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463226;
	bh=qoEJASPCUxmcyaJydCy2VV6pZZWWMfCad+tM+6zcuU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qS4zhIih2hC+so417yzJNvaab4L7Oie30dt1x5IbaGQQ5ivzJIMiragYqFDaziYdl
	 V1SXGkh0w0txXIID6rDnT+oHviOLxvy2ES03x3Re1TldyhA2AUZl4DY1p11OiO+BvB
	 3H9UHTAvd4AB2y3gwJwUCIThH2dDUGxyY4VbzCCv9zYw1fsHxcOSawEhKzQccsTFae
	 P3CmJ4NfnmaNNexMwOrcJapL9yoTi/KTS+c9d7Jb/wfdgln34YADG86H+eV2Xk7KPV
	 TPPczJfDQ39U0SvXP+0o9wLjnGE42PTK1qxA3d26lcrhjCWfzFnhyRdEmUavG3+dE+
	 99qucStc/c9zg==
Date: Tue, 26 Mar 2024 14:27:00 +0000
From: Simon Horman <horms@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net v2 2/2] octeontx2-pf: remove unused variables req_hdr
 and rsp_hdr
Message-ID: <20240326142700.GX403975@kernel.org>
References: <20240326061233.4133148-1-suhui@nfschina.com>
 <20240326061233.4133148-2-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326061233.4133148-2-suhui@nfschina.com>

+ Dan Carpenter

On Tue, Mar 26, 2024 at 02:12:36PM +0800, Su Hui wrote:
> Clang static checker(scan-buid):
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:503:2: warning:
> Value stored to 'rsp_hdr' is never read [deadcode.DeadStores]
> 
> Remove these unused variables to save some space.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Hi Su Hui,

as pointed out by Dan in his review of v1 of this patch, it is not a fix.
This means that it should be targeted at the net-next rather than the net
branch. As the granularity of patch handling on netdev is generally at the
patchset level I believe that this means that you need to separately,
in different email threads, repost:

1. Patch 1/2 of this series, targeted at net

   [PATCH net v3] octeontx2-pf: check negative error code in otx2_open()

2. Patch 2/2 of this series, targeted at net-next

   [PATCH net-next v3] octeontx2-pf: remove unused variables req_hdr

Also, please be sure to wait 24 hours since the posting of this patch-set
before reposting.

Some more information can be found here:
https://docs.kernel.org/process/maintainer-netdev.html

..

-- 
pw-bot: changes-requested

