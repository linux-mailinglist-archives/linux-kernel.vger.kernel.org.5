Return-Path: <linux-kernel+bounces-87149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E4E86D03F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43CE1C21724
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A10470AC2;
	Thu, 29 Feb 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC+eskhk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B076997F;
	Thu, 29 Feb 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226723; cv=none; b=FDFW9SztbiphJZjDJo4zZdv75F5Ga0xhaaf6ogjms00c0qKyb36bU23MbBZbVf+srUnr6zBU2llra2GwWismDa+cIP5kXzDfnGK72gcTpoKTp5Oe+yjJzkzRsMpmD8sFu7pwOS4D+yryzEtvroLn5w7wYka0QpvlGYiKyZEuWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226723; c=relaxed/simple;
	bh=VG+D+qi/TZVphX/2CxdUZBtA1M2Vw5Tcn2yPs23Fek8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s31LHHPdH7W51s5dOMh1qKxwDOSXaYqDBuGU93RMTz3HahP13l5eQpJX9+9gLm6SObGljK7W4ThRNHMN+d7WxNi/HqFH+xRFLrGNXPdxxCWczk3/boRbYaGKKCeZ+1R3HUp3bd+zgsthb66hxXp0uGn6Ezpt/TuWqTdxF6MZEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC+eskhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173AFC433C7;
	Thu, 29 Feb 2024 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709226723;
	bh=VG+D+qi/TZVphX/2CxdUZBtA1M2Vw5Tcn2yPs23Fek8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rC+eskhkTRByz+sXdvXhNDcxf+Mqe8D5QmUEgaoQBf31TzfNH2Ev5uklY2tzJ99OS
	 DSXSyFOQjZYURl2OZR3bK6W7eg4TpbTuZDYCR7nGNiWo7Ng6lWcjHn6/IBXmLDolkj
	 KvdzYbhnFg62+kfriOhaQCZV7IWHbXkf55Phq/HzNPcCS4e10yW1GU/Siw9cjsEkAw
	 VQbCG0m0b5xEkiUghvdle6d2qUimGgiPxMrsFKkZuwyIW7pOcbS4QUkS92ODgzQdPk
	 3Wz9bBdAzlTuehcgQTnkRaAwimCnnX9uNkYHxiuUvrE5dLG0OoraFHirIfvvcQwUB+
	 xPO8MV+i4A+8A==
Date: Thu, 29 Feb 2024 09:12:01 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] f2fs: Fix two spelling mistakes in
 f2fs_zone_status array
Message-ID: <ZeC64dDr-nBGlsli@google.com>
References: <20240229091449.105032-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229091449.105032-1-colin.i.king@gmail.com>

Hi Colin,

Thank you for the fix. If you don't mind, can I integrate this fix
into the original patch?

Thanks,

On 02/29, Colin Ian King wrote:
> The array f2fs_zone_status contains two spelling mistakes in
> literal strings. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/f2fs/segment.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index bdb27e4a604b..072c4355d3d3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4921,8 +4921,8 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>  const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
>  	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
>  	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
> -	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
> -	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
> +	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICIT_OPEN",
> +	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICIT_OPEN",
>  	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
>  	[BLK_ZONE_COND_READONLY]	= "READONLY",
>  	[BLK_ZONE_COND_FULL]		= "FULL",
> -- 
> 2.39.2

