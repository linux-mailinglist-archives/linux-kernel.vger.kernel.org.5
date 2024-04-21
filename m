Return-Path: <linux-kernel+bounces-152533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641B8AC017
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16671B20DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08D1BF24;
	Sun, 21 Apr 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrvTKj9y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4720DF78;
	Sun, 21 Apr 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713716223; cv=none; b=bGgGDvfpQVvJaC8jK7lhi9ZDI+gaTmWdGNNm2ZJhubM69xfHafDsekRsYxD78HXxnDw9Nq0Tvd01lgHE5V1Okw9ZzcywaHWWuhp9Vj4QQT9SDqrzRaNPL7nH23oS5CD+VRJeAYtO5UG4PXPCMduySjfVEuIQ318SS9iXFn0N9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713716223; c=relaxed/simple;
	bh=Y1i2tiiqhiRWOo34ZNUl9IFztlFEiOXgTNHgBSzqWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9AgFjW50Wtu5iCvkyCZ6bBgZ0jYpGra6P0Bi1xjukoud5+ci7074s5wF6pZBsMQpqcPb8U+oLQ1uDcuZ8Z6OjZNzB5XCfmhbAGyWIe7/nfljbHH0WC/f23CiXjSjYvlI/SItU6ZNn5SDacSZE8/Q6y3A3xUJkfCtXZJimNALgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrvTKj9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594FAC113CE;
	Sun, 21 Apr 2024 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713716222;
	bh=Y1i2tiiqhiRWOo34ZNUl9IFztlFEiOXgTNHgBSzqWmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrvTKj9y8BEB6qJ5+mg+FzzbwWc+B5rwssBf7qFHW+vacT2eTp8REsNvnBbai78fy
	 4Lqgf4EtkSuN38z33+bYymqqiAkO2t/NZBnaWGgZgubjcOdX2vG9qzNzUhy/LEtaD7
	 CJ3QBXqM/omb7TBIu8Kc25JcfoUo+pNZTZnoWk5Bzdqz7WX7aZofc/1xnoW/Ru0Gah
	 d1F7UBNKGJ/Tc7ujCQ3EEfbiVEwsolRir6Ah8q/1qCEnEy0Qqy/M4zkh+JEOpuGnxW
	 aQaR8EUch5RjUNYvwsXwd09zZHlC4UYk5rADceYqwK/A6yPBi+n+9ZWaFxhPvkEgsd
	 p+cnyW6hIH5TA==
Date: Sun, 21 Apr 2024 11:16:59 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mka@chromium.org, quic_cpratapa@quicinc.com, 
	quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com, quic_subashab@quicinc.com, 
	elder@kernel.org, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mailmap: add entries for Alex Elder
Message-ID: <kabhsybtcfg6ky46rwry462dpql2k6mcrnb7w7xtb5d2httg7r@lg6rbbmaiggp>
References: <20240421151732.2203345-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421151732.2203345-1-elder@linaro.org>

On Sun, Apr 21, 2024 at 10:17:32AM -0500, Alex Elder wrote:
> Define my kernel.org address to be the canonical one, and add mailmap
> entries for the various addresses (including typos) that have been
> used over the years.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .mailmap | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 8284692f96107..a78cd3d300eb1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -38,6 +38,18 @@ Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
>  Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
>  Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
>  Alexey Makhalov <alexey.amakhalov@broadcom.com> <amakhalov@vmware.com>
> +Alex Elder <elder@kernel.org>
> +Alex Elder <elder@kernel.org> <aelder@sgi.com>
> +Alex Elder <elder@kernel.org> <alex.elder@linaro.org>
> +Alex Elder <elder@kernel.org> <alex.elder@linary.org>
> +Alex Elder <elder@kernel.org> <elder@dreamhost.com>
> +Alex Elder <elder@kernel.org> <elder@dreawmhost.com>
> +Alex Elder <elder@kernel.org> <elder@ieee.org>
> +Alex Elder <elder@kernel.org> <elder@inktank.com>
> +Alex Elder <elder@kernel.org> <elder@kernel.org>
> +Alex Elder <elder@kernel.org> <elder@linaro.org>
> +Alex Elder <elder@kernel.org> <elder@newdream.net>
> +Alex Elder <elder@kernel.org> Alex Elder (Linaro) <elder@linaro.org>

Isn't this form (with the name in the middle) when you want to be able
to map one email with two different names, to two different addresses?

As described in last example in the "gitmailmap" man page?

I think thereby this would be a duplicate with the entry two lines
above?

Regards,
Bjorn

>  Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
>  Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
>  Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
> -- 
> 2.40.1
> 

