Return-Path: <linux-kernel+bounces-96140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7D875790
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EFD1F2463B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790FE137C50;
	Thu,  7 Mar 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kapLg7TB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0763137C36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841082; cv=none; b=NZK2uru6/HXy2IXv3WOrV4YTiY4TB2+qISuaCFwjgfLOuvwA/olC9TeTqQ0prefVI0OPSYuxAK7m1zn+2WVZPZU5IRoNbN2xBDms7ip0YT1sNnJULm+EeKuN4vu135BfYwWpS33w7dVQQqG6gCyRug/SBCjABpHMUPwGWVlYnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841082; c=relaxed/simple;
	bh=97urD+vBImmdNRQsyW72trebuT9te7c4DAnEjaMVfSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCQ5cipNExpHnk9xzTeOdqbUg6WjlR/8E+jV79wtXkCO0ojvaDVEnBDUNwyzXX0Xg6U3LsYu6+lrjgmfEi0oRAGAvHC5LNoTEGdhyqUooBgH+i1E8Hu95XovF/VVIDKHTN1zpfSr20wCCcyTHmIHWiuJ3rNVL6EBVcLUIbJBRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kapLg7TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACEBC43390;
	Thu,  7 Mar 2024 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841082;
	bh=97urD+vBImmdNRQsyW72trebuT9te7c4DAnEjaMVfSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kapLg7TBtniwoZ0MnEPUDezQYDL9b5LaIdoEn6UhIeM8/TaFTXRYAKl9AN1SBA3LU
	 etRw0xnEHXOJWqIU+ozysEaGbAHjg+VvQhv0POE/clZFMIjT+6ppNfneS//YL0t/th
	 LSJMkZvhiFxUb7rSCfJZIUftSWNhzrCBeU2oVK8Q75vfi7VQBG7R/XyhAcc7fxVg6S
	 fcDM6fp8UN+dKvsBi6/2vySAM8+MfzJBNGTkLu+TdrIpMbk6PyFsM7TuFEzx4YduVV
	 yhuo5Tkj6w9wPmW+YB4vdCrUCfBZlRJwIS+Rwb5AnajLjNMGg+BIzSobbPVEdKxnO+
	 IAoiAa4f5R3Nw==
Date: Thu, 7 Mar 2024 12:51:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Len Brown <lenb@kernel.org>
Cc: linux-nvme@lists.infradead.org, maxg@mellanox.com, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] nvme: Re-word D3 Entry Latency message
Message-ID: <Zeoat2z25BXxA7qA@kbusch-mbp>
References: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ff4f9aedcb73ec5d8cc7f3e77ec4c72d72b4ae.1709839023.git.len.brown@intel.com>

On Thu, Mar 07, 2024 at 02:17:34PM -0500, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Some words are alarming in routine kernel messages.
> "timeout" is one of them, so avoid using it.
> 
> Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Len Brown <len.brown@intel.com>

Our messages must have crossed:

  https://lore.kernel.org/linux-nvme/20240307165933.3718589-1-kbusch@meta.com/T/#u

I haven't been receiving random messages from the list lately either. Or
maybe I cc'ed the wrong email.

Anyway, we just sent the nvme-6.9 pull request today, so I'll wait a few
more days before starting the next batch.

