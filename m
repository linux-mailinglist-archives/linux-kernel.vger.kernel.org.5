Return-Path: <linux-kernel+bounces-93363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A20872E87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1054E2823E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8B1BDC4;
	Wed,  6 Mar 2024 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsDIzB2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5238C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709704888; cv=none; b=gwognDdjWIM7AZwpb//2vvcNPTId2GmJwpH7NxLI0EPJm2P1F7BMOEVwI7GRlMXwtp+WMNow78L4+vI6eSNQCqaPxzuZOizoifRBSUz6zV+fa6lxIWSPJkH78OoVvkSTJNWoHtji46MwURDnAOd16eSiMB9vp2hiwmiwItAvJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709704888; c=relaxed/simple;
	bh=LEXu0zftvUCaHMRtidt+R8eK9jxwX75gz0eH8GU39wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqXffcCVKJhy1+J8Yp0Ci+XXeot83s8yH2b7dxbZ74rwLkRgrfuYsaJUtpKmnV026+gIMFtZSBedkvamWo+WdOla/BbYhgWHdP3hnRhJe/jkenVtoYM9NbmNrPlwObD8PslJOdi8sQe5G23N4b6VhBhWlzpatpAYf84OjQmBTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsDIzB2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DAAC433C7;
	Wed,  6 Mar 2024 06:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709704888;
	bh=LEXu0zftvUCaHMRtidt+R8eK9jxwX75gz0eH8GU39wc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UsDIzB2oRSEuT5fbfzip8GjqMGoG9RMDoCZBFz9FPM+5rF9bYJk/r7QxJNeUxm2IQ
	 3E2grz647YVgBtzgXs0dpU+br6ynSFd9fhsUoWr2CM5F8W1A7PdiEk+8SoeagfDgE2
	 rea2b/ghmCZHTj7cI1k7f7BZvhX99fv2SV0alKHImKuXbVgys2XaPYYGGozzEDuI16
	 Nm+/ejuU+f0jAwXUQhZW+neGdwytSMgfKcWKQ1xocIwVe8rhLqZsp6MH8qfsWJe1Nz
	 bnafvjRj632Yl8PV/r//FWMI5a2qRCq4uzE3JZKSMocjJ++LjEDbZ3MlrWc64goSP+
	 VvBBSGc5b8vDg==
Message-ID: <72a62115-8596-4697-9a1d-87aea34af1c7@kernel.org>
Date: Wed, 6 Mar 2024 14:01:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] f2fs: compress: relocate some judgments in
 f2fs_reserve_compress_blocks
Content-Language: en-US
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xiuhong.wang.cn@gmail.com
References: <20240306034746.3722986-1-xiuhong.wang@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240306034746.3722986-1-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/6 11:47, Xiuhong Wang wrote:
> The following f2fs_io test will get a "0" result instead of -EINVAL,
> unisoc # ./f2fs_io compress file
> unisoc # ./f2fs_io reserve_cblocks file
>   0
> it's not reasonable, so the judgement of
> atomic_read(&F2FS_I(inode)->i_compr_blocks) should be placed after
> the judgement of is_inode_flag_set(inode, FI_COMPRESS_RELEASED).
> 
> Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

