Return-Path: <linux-kernel+bounces-39494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9583D211
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029211F28157
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C510FF;
	Fri, 26 Jan 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axsI+Ry9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2E1EBE;
	Fri, 26 Jan 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232485; cv=none; b=Pla/Z9MvQypHY+fG/6mp6Z0PNRBt108bf591tOzUotmzDH1ItaVnLEcfXXlylRUq0kugMupD3x/Y5YqAAV47JQBZzLVEAd0+urkRUDmV9AZdxs8jT2FnOZ9m46veZ/CwIeoELvcsYAxNtk9BW65z1yG8Xjgnq2R448D2gRLoh28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232485; c=relaxed/simple;
	bh=bZlX9cUI6w67vtkj69iIAjpu7YMBHhLSx3TrsQFcCVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWB+raCLJHwkzJuwcreniR67WfOVMD1M3f5m/cTCtCgE/A3xD5hWLZaaXsicW7WLBOAPh0xe9XhYaMY/7aaI9xpzOUiXzH0noKVeT0GTkIZdzjqgfZ4amYVFtv603fzsQ5TxhKexgJnhWEFZBADnX1CA4q9WIX6lCdWwVT+FqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axsI+Ry9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF5C433F1;
	Fri, 26 Jan 2024 01:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232484;
	bh=bZlX9cUI6w67vtkj69iIAjpu7YMBHhLSx3TrsQFcCVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=axsI+Ry9/nH8tehj4XSMn0DSClxkGB1iHb+8GWqKbL4B9TzOgERO7oYCN63NbNmjN
	 9AbkuMOxK59KYJx/duEk8WFxf3Ai4TpJbPhPbuTR59Z5DEPkb0S3PXsYVg86kHOC0Q
	 Q4/mbEVroaZv3l30ALMalMRjJoalAjEoARsd4E4vbH1KqJijt8oZ0fR3jURH8/H8y/
	 bVnmh1WcegGz+tzEIbyOYCPjfvxJoypgFN267niTZ3uhlxVzEIpORfIhqtxBBzZtaT
	 sn7Eamo9AgbUhlIOyPsHD3Ctv3J4K7F6v0laatull0f2QrQKsjxoUz32tCFCMemFH5
	 DtEwarYLWAfAg==
Date: Thu, 25 Jan 2024 17:28:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Reset MAC stats during probe
Message-ID: <20240125172803.01189ac4@kernel.org>
In-Reply-To: <20240125110601.124209-1-saikrishnag@marvell.com>
References: <20240125110601.124209-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 16:36:01 +0530 Sai Krishna wrote:
> Reset CGX/RPM MAC HW statistics at the time of driver probe()
> 
> Also added a devlink option to do the same at runtime, this will be
> helpful during debug.
> 
> Usage: Reset MAC stats
> devlink dev param  set  pci/0002:03:00.0 name mac_stats_reset value true
> cmode runtime

Where are the stats reported? It'd be more intuitive to add the ability
to reset stats to whatever interface is used to report them. Or one of
your reset interfaces (devlink dev reload).

