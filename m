Return-Path: <linux-kernel+bounces-42088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9683FC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805181F234D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31010F4EE;
	Mon, 29 Jan 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqZZocFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75245EECC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495087; cv=none; b=jPNo8CThrMCvYg464u/XRitZMVFlNdQVhJe84hF+PqQcMh3nezqpHhRXAt2wfX09GpEhOQwkVOCKOFQLBNc6CUcZV5FRiZS0jRdasZ48O4XDeAYBA/tklP16+eGHEO7hKSmbW5i1QJKVeY4UtI0n6ZyxcMgEjZuU1keKnmGCUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495087; c=relaxed/simple;
	bh=QM0Apf5YM/YhV2MIMFE6WuZ8GatbXGGqiCs5MMKo5/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRKOMdjNkd9dct4a5jd6b9KGeUVDFwBlkPo+pZ2Sy22Y8TwEG/8UvZ+RumnYSsOKS51rGUkvlVAylyEpIXsvkBzseJKP0Sc4UwW5Z056z/DDX8mgNQ2Cy5Xif9Or2lJ016P7o1b6/WrhJshUY7cmF3s7TEX7OuhLuaHO3wzq6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqZZocFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0174FC433C7;
	Mon, 29 Jan 2024 02:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706495086;
	bh=QM0Apf5YM/YhV2MIMFE6WuZ8GatbXGGqiCs5MMKo5/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cqZZocFjY2MUmwZm6fI1QIsoKiI8+JNYh78Oz9XteTp9GFejix6cMn8cMmDYZsPrI
	 1w+5Q7wOiP0Oz4IIgL69EDooU3XocX6a6gPvGYMTaETCOr+xH2SxAZfba+6tU+V/VS
	 ziWlKTItg2sVxrSIZoagVltnzwZV2h7yS2cuDj1EckYHjAJXdqv/nXbCzdQBpNAbGV
	 20V19/h0Oi6iQIvjOMDN4O6APWgvPoqXMKITkUj+41JifFfd7m8601g3kYuoIxv88p
	 1l4LD7V4HA0pVRs2r4zuXXqrJcj1tec538pmBjCX9m/1/th8LbqmYTlS6FtNGV7wja
	 Jy22ky5cx9zNA==
Message-ID: <1d80ae9f-7252-4262-9216-4e25742b1f63@kernel.org>
Date: Mon, 29 Jan 2024 10:24:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1706011734-1617-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1706011734-1617-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/23 20:08, Zhiguo Niu wrote:
> There are some cases of f2fs_is_valid_blkaddr not handled as
> ERROR_INVALID_BLKADDR,so unify the error handling about all of
> f2fs_is_valid_blkaddr.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

