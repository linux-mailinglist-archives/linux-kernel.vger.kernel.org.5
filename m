Return-Path: <linux-kernel+bounces-108694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF1880EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628EB2854DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BB3BBCF;
	Wed, 20 Mar 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOg3BRqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787663BB4B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927233; cv=none; b=CisGOb9HBxYqOzL/o8rrPPp4HhnVNxwv+PjE2r7JqSuIBcnFkAgAlOaf9ihqRJ2FuwmQs4g7/7MgP0DTM06sp/u66zdBefH9s2q/bfhomkGytrQNfvVRuTnBHs3WhVNGh7CzmNdRQZU9u7+vK1o0WvS9yBgRC4IHloZDv185uUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927233; c=relaxed/simple;
	bh=IE+o1l0WGWEttVDnKe7FjFvkcYXmDz+elWeacfnwMZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDT5dqYesVIKy8GWUjefDGXq5gOMOvWuRCd4wH33fAy/+GnKAKip2SaCyIxblT3m4x4AEFJXxgh7AJF9vX8us9Ngm7dDuUNxoNgnJH0y+2g21smWZ5GGe2UHazp+D+VgA4C2toY2A3nJqLnRQQD96U7379fZbZkRFqj9vJ8btE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOg3BRqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55712C433C7;
	Wed, 20 Mar 2024 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927233;
	bh=IE+o1l0WGWEttVDnKe7FjFvkcYXmDz+elWeacfnwMZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VOg3BRqKWZLSqHtq60RdJXWRP4F7nfsNUtfrDO3sbq5vIfcRIK88XmEZsS5EZnbvR
	 Zrmwmw449xp4CrA+YFDAo85FUcRhLcFY2Z4jaaU6BtrNtwNcPsDSaN8SeZewxtI5c6
	 OTjtia7ZVRaPyjYqwAIngNRe+156MfJLEyVBLbcpzoBKpmuosXzFr0Mli8+jTjwFjR
	 6s3ZnETQ8ZgN99U4/ghylzk9NpdAmbzjxlzzq/aGEi5gTfAmGI6WfungbC6a1Vv5tY
	 rZLZQQK/XoasuSaZD/00B1kNswaaNYN8qs/l/b4C4FSLDhUQ4X4rjHX+WvsoHvA8lk
	 2P+kYv+clO1QQ==
Message-ID: <ee24b313-a168-471e-b60f-1404c69e61a7@kernel.org>
Date: Wed, 20 Mar 2024 17:33:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] f2fs: add REQ_TIME time update for some user behaviors
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/20 14:22, Zhiguo Niu wrote:
> some user behaviors requested filesystem operations, which
> will cause filesystem not idle.
> Meanwhile adjust some f2fs_update_time(REQ_TIME) positions.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

