Return-Path: <linux-kernel+bounces-101683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5A87AA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F3EB242B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750D47A5C;
	Wed, 13 Mar 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajQsrxej"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD04595B;
	Wed, 13 Mar 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343958; cv=none; b=XHb2HYhLVG6sj7kyIwLoA3myUI+40WiNDvQBxL0fGH/yo66siyksP262031dFKZZ7QCk2qZdW/yeI5TABgk3gndhn2pYOx0cqEuHDHa8mn9AMG45E+l5adPt2T66Ry96El2hOSP48A5jZVfbkGkzw4Laj5uKWWMzx3Xkz78smnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343958; c=relaxed/simple;
	bh=SXintdCZxmv3YrePptPMqe4uFM8pu6Zw1KyUM+YfwIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svdlb7nQwf9Wu/3lIUj1sC4I8ghjQncQF4ezQb99N3ZwM1TpH3mM2rSl6mkddnXx0NtqiJLEnKOXhAbO2OpcP7MAOKv6Sx47QLPokhts/slAyRPLbfo6TgTHzot5iWprR/uTSD+2ljVT8wx71Zic9RQYpFgvL9kVNcIHkhDyOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajQsrxej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5303C43390;
	Wed, 13 Mar 2024 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710343958;
	bh=SXintdCZxmv3YrePptPMqe4uFM8pu6Zw1KyUM+YfwIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajQsrxejrhdqPTrSdl54MMC30/dHcv9oa3ptfvZpXZVu6ssKlpajpyqUq83FvKuT0
	 8IR8paej7oCAzcU89lXIm41mLn1XfghKwazdWRjGqCQh6N0JeceFnxzn0KqG/JIROZ
	 +MEAe0hiMMmEMxfU00sOFbU4FTIj25SPfN/PUBZ3X3duPIxflzHReN7HCMkEhwsUaX
	 9/bcRtGxnXUvz/ihLPL8KtTPWUhL8h4NeVKM+/O1dm9sLq+ej+aPKt6zDUzp3kHPbT
	 wggYEMEKqwWeEEYdoWi5msFhli5mpxsKFkxIapkP7cP+HI7YmxDeqbjBPRxjRtcgIF
	 5ZGyxcH8O1b+A==
Date: Wed, 13 Mar 2024 08:32:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>,
	linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, llvm@lists.linux.dev
Subject: Re: [PATCH] ssb: use "break" on default case to prevent warning
Message-ID: <20240313153236.GA2931742@dev-arch.thelio-3990X>
References: <20240313001305.18820-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313001305.18820-1-rdunlap@infradead.org>

On Tue, Mar 12, 2024 at 05:13:03PM -0700, Randy Dunlap wrote:
> Having an empty default: case in a switch statement causes a warning
> (when using Clang; I don't see the warning when using gcc),
> so add a "break;" to the default case to prevent the warning:
> 
> drivers/ssb/main.c:1149:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]

It is a hard error with earlier versions of clang as well:

  drivers/ssb/main.c:1148:10: error: label at end of compound statement: expected statement
          default:
                  ^
                   ;
  1 error generated.

> Fixes: e27b02e23a70 ("ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403130717.TWm17FiD-lkp@intel.com/
> Cc: Michael Büsch <m@bues.ch>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: llvm@lists.linux.dev

Thanks for the quick fix!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/ssb/main.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/ssb/main.c b/drivers/ssb/main.c
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -1144,6 +1144,7 @@ u32 ssb_dma_translation(struct ssb_devic
>  				return SSB_PCI_DMA;
>  		}
>  	default:
> +		break;
>  	}
>  	return 0;
>  }
> 

