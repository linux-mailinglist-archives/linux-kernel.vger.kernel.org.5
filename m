Return-Path: <linux-kernel+bounces-72430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBA85B31F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B9F1C21875
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E732D79D;
	Tue, 20 Feb 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpNNGn6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F997186F;
	Tue, 20 Feb 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411818; cv=none; b=LEqa5dWESf9sz5TGFlpD25F5n5Wz1fVzdtFgruZyrfNsDjm4jD812Qr+QWZ3rvLxAjUB5aQlEhDqDlvA+Pr7KJ//ExdjOV0fw8LF2SQoRnehNF9iDFkOWElVNvU+2pKYLxIyNKSKKemMEVzyyY83YyhwYGh042XGAtDawK1Yn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411818; c=relaxed/simple;
	bh=IPBlD9TMdkVk8QBHkD6dEwxAl+m+4DmFxsgsXh2F9go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO6xba+iq2TXl+OsgP7iQi4G3JZbYu/E+V99t0U4NJHxiY3DDbEJz+kfieGupaxMECrd779uffTfnBG6/TaW78JAzSNsENPnDzQDLZUUAW6/g2bgdJ6oxNEpGaeCxG79xqAm2yg3zLqLJZQ/lvgPUMObEcdEfC7eiKk2TpShMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpNNGn6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E030FC433C7;
	Tue, 20 Feb 2024 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708411817;
	bh=IPBlD9TMdkVk8QBHkD6dEwxAl+m+4DmFxsgsXh2F9go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UpNNGn6xAJiuHKtXcdVxpuPblf6NJYhvnuqnF1ax/trXw25ayAPalGxYTJjIQDrfb
	 uP7jQv0WomocoMV/q3unNO78n39l/R85ImfvpkfSNbzz0XK/jqRECnabxpxbeTGkfh
	 +YL7zXeYonH0B8+2p60ci3Gh59f6FZ/ybIUUDL90eZjjlFSmL0JzI1iyHsDW+dxmtT
	 q8/gKuRs7zAR45WnTPVE4kNbxdnF+nGaN/IE4h3jkqShR3W65g/oO0Ypln7PD86K6f
	 e+LilT/X/CBNrMUO9Z4t44eGP9VKCfjFnb0S0aDYNzFoCgzbjouZ+cbdWpMEML/wcy
	 nrZ+sL5a/KK2Q==
Message-ID: <f51946e2-68f4-4368-9a77-050382dfa3ff@kernel.org>
Date: Tue, 20 Feb 2024 14:50:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: stop allocating pinned sections if EAGAIN
 happens"
Content-Language: en-US
To: Wu Bo <wubo.oduw@gmail.com>, Wu Bo <bo.wu@vivo.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240205031415.557879-1-bo.wu@vivo.com>
 <793fd834-fe28-4647-b2cf-0012acb95b43@kernel.org>
 <bab0d763-2907-4412-8075-a7ebb25081c0@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <bab0d763-2907-4412-8075-a7ebb25081c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/8 16:11, Wu Bo wrote:
> On 2024/2/5 11:54, Chao Yu wrote:
>> How about calling f2fs_balance_fs() to double check and make sure there is
>> enough free space for following allocation.
>>
>>         if (has_not_enough_free_secs(sbi, 0,
>>             GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
>>             f2fs_down_write(&sbi->gc_lock);
>>             stat_inc_gc_call_count(sbi, FOREGROUND);
>>             err = f2fs_gc(sbi, &gc_control);
>>             if (err == -EAGAIN)
>>                 f2fs_balance_fs(sbi, true);
>>             if (err && err != -ENODATA)
>>                 goto out_err;
>>         }
>>
>> Thanks,
> 
> f2fs_balance_fs() here will not change procedure branch and may just trigger another GC.
> 
> I'm afraid this is a bit redundant.

Okay.

I guess maybe Jaegeuk has concern which is the reason to commit
2e42b7f817ac ("f2fs: stop allocating pinned sections if EAGAIN happens").

Thanks,

> 
>>

