Return-Path: <linux-kernel+bounces-80421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE086684F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A0BB20F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45497F9C3;
	Mon, 26 Feb 2024 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJwuEg+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD6EAC2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915685; cv=none; b=X7dRg+q9oQXfLkgewJVxlJMPbbw2B5L5LVcqbttXM5+9h7oJp8v15bEo5luIFLG2Q60YB4H8vsXEXK7otZi74SOiFrfrQJZMJ7H2o3LDdurmzYcO1Ix+pJW5Ri4apSIFuiBfxN+6rrRMEzn/0lq06Gnhcd3UZXGQuBwyLB9RzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915685; c=relaxed/simple;
	bh=UyE9kqRHnjuu/JVrTs6boGbg+Y9Veu3Y0uj4/okwmiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H45dyO1OFU6n0geYdRVpC2Wgg8FjDkmg6N+EypHNzOD1rKtiqZjJHy0vIofnT/shxTCqp57PIJRBaIO4EmirJJfz6K3mGHRRTiUfjPU97CAn4amFY8Y4jjXSEPDZLzwLaVbPuh4RCAeFJaSo2scQRFVCXv3LgtZcYA3G2Wi8y6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJwuEg+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF6AC433C7;
	Mon, 26 Feb 2024 02:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708915685;
	bh=UyE9kqRHnjuu/JVrTs6boGbg+Y9Veu3Y0uj4/okwmiw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=mJwuEg+Y6GCM5bXijENcg5aLRgP20JTqgfG9ShYPXs1+0wDyxpwtrtWm9A/T2hxo+
	 VilpbGXIyPKEZ9uzUkWrlj6wLK75I+E5QtyHdgJcHJ021rz/W2BtLBHJyN8efuUjUh
	 gDuhb1Icg+kXLSlclOaMsAdKJOFehfaIw38TXnmvQddPdCrqtVPpk4F1Yz0ke49Giu
	 46+mBmv0/GonV+6YdU7qYGdnLD7gyWg1SZz/g71t1XnTJYg+C0dLnejXZcz3Nuo1lG
	 MNPh7yt/cfacDXPSk0GLjf//xpBl3cS/yC1JAsM5dBj/T689RdnByA8P0BoA3HaZ9+
	 ibq4AI+ZQfZyg==
Message-ID: <68e95cb8-9bf5-4849-befc-bbbe8becfd68@kernel.org>
Date: Mon, 26 Feb 2024 10:48:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/5] f2fs: fix write pointers all the time
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-2-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240223205535.307307-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/24 4:55, Jaegeuk Kim wrote:
> Even if the roll forward recovery stopped due to any error, we have to fix
> the write pointers in order to mount the disk from the previous checkpoint.

Jaegeuk,

IIUC, we may lost warm node chain once we allocate new section for all logs,
should we give some notification in log to indicate such condition that
filesystem doesn't process a full recovery flow?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/recovery.c | 2 +-
>   fs/f2fs/super.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index b3baec666afe..8bbecb5f9323 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>   	 * and the f2fs is not read only, check and fix zoned block devices'
>   	 * write pointer consistency.
>   	 */
> -	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
> +	if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
>   			f2fs_sb_has_blkzoned(sbi)) {
>   		err = f2fs_fix_curseg_write_pointer(sbi);
>   		if (!err)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2e41142d07c0..4d03ce1109ad 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4673,7 +4673,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   	 * If the f2fs is not readonly and fsync data recovery succeeds,
>   	 * check zoned block devices' write pointer consistency.
>   	 */
> -	if (!err && !f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
> +	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
>   		err = f2fs_check_write_pointer(sbi);
>   		if (err)
>   			goto free_meta;

