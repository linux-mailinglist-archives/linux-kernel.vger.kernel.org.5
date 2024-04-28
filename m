Return-Path: <linux-kernel+bounces-161397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC058B4B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91651F21075
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0457334;
	Sun, 28 Apr 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7+xVqZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23456B6C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714303403; cv=none; b=RJiPhHZslvT6XDvcljpNg8qbiM4Wr/J2U2ClwB9QDe4rnNzukaF5FcEr/TqpELms28mpH6gLp/q03UsL+Muig3GEekLq1PcBhhP1vZNvE1ciUW6HUH1sYqI+EqbFRW/IIhrR8lvEZPpaqh3HP26tlD/uB2KDiXnOxJTN6vSwlwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714303403; c=relaxed/simple;
	bh=qeSlEnULi1s8O4qV+q5O9CH7dsCvGcClXmiaLVpkARU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hevkgU6BgOdpHCG2ByOAT/AmaSlA0B7N1/SX8SPtaIDyd1xMw7IU1+LFAZ9wHwppghWNpAXAFGKoOQyC25cL/FoMPh87LPPr+efybkBeu4YuwDwsoB1bL4Ztwjnq3q9KXcBMMfUjlH7h5ZCTmNGV0jMyEh5LEZFbVefcdel8Ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7+xVqZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2643C113CC;
	Sun, 28 Apr 2024 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714303403;
	bh=qeSlEnULi1s8O4qV+q5O9CH7dsCvGcClXmiaLVpkARU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a7+xVqZTUUSVCh78XU7dKkzK7vgpylcPKZADLwILLepCP75gkYNa0cI2nTDogIpTO
	 7MsAUvTh+U2PbWMfKIpBsv20imwXHA8/xOY70KL01Jiv4dbbFdkaKDCveTiQldivav
	 RWGTUoqd90ptzANwEvFV2ey6JNsnQb3UbjIu5/1fW5zaZAfnwfSUGHLIYAxeIZwk0U
	 MyeY7ZweBumfxBDCy+lsDE4Kzr3G1UcZIag4u636Hmmc+D7I/9TQjVUya7t5BSPrB0
	 hPB+3Zifi2ObG+g0yFEj57Uhql//uEHqlsz3O+YgaNtd3wUFgqfbQuHxEv+YpgnOU3
	 7O6z4QV509KIg==
Message-ID: <7f97aae7-557d-4fac-854b-594e99939598@kernel.org>
Date: Sun, 28 Apr 2024 19:23:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs:remove the restriction on zone sector being align to
 pow2
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: bo.wu@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240428111457.17224-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240428111457.17224-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/28 19:14, Liao Yuanhong wrote:
> For zoned-UFS, sector size may not aligned to pow2, so we need to remove
> the pow2 limitation.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   drivers/md/dm-table.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 41f1d731ae5a..823f2f6a2d53 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c

Hi, please discuss this in dm-devel@lists.linux.dev, thanks.

Thanks,

> @@ -1663,10 +1663,6 @@ static int validate_hardware_zoned(struct dm_table *t, bool zoned,
>   		return -EINVAL;
>   	}
>   
> -	/* Check zone size validity and compatibility */
> -	if (!zone_sectors || !is_power_of_2(zone_sectors))
> -		return -EINVAL;
> -
>   	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
>   		DMERR("%s: zone sectors is not consistent across all zoned devices",
>   		      dm_device_name(t->md));

