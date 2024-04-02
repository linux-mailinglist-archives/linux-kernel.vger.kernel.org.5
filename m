Return-Path: <linux-kernel+bounces-127925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567268952CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF88B26046
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B217A140;
	Tue,  2 Apr 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pRdBfDCo"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA678B50;
	Tue,  2 Apr 2024 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060400; cv=none; b=h2Om8w8vKcJtkKvJZ/rTuWjXV+7y/rT1aHI7YLUABJfXx6DrADsyLbGMii9htpytqS6duY18j7n5EBkcCmBr6RtRP7SBbeC8TbtwFPS6tLsm5wsvV/FiIkeM07GZuRcQKL/MxxKgMHcYF/CaaxJPDAMOux1hiH4CrCC9ORL2cxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060400; c=relaxed/simple;
	bh=10zaNQjO6cD0u802nObkF2rIFEWC9XMzwL4o5CgNn5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8dutkog5OrXT5LWnaqtpYZrkXT9RHTwuvOk4UPJLIcMb7Td5bHoj3Suv8KBrf+b1Igy28T/vLGSgkGHJsNUwuU+QoBZJrLf4wu047LeTGO3m7nJ26XRr5R+W1decWivqV/sEo9nhAtgE2DZgVVXbxdcnDvxf6FsguK2v6WEJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pRdBfDCo; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712060394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MRQA2S5++ydiyrHI6q0p5IMDBBaTSk6Hs3CzM+V9A6o=;
	b=pRdBfDCoYmdI1rBKdi6yYxKXmof6g5/j2wc3hwk7fQpgiwCAI3TahQEPog3seizS+VjQaLl58sT4iU9xNW3pWNho4R4K86f/Brwe1eNgW52IS9JokOTztuvbgTxi3vg0g5m4Nv/+TiK3JinXlkmRzbqoy/HfjoxkHTTVUR5DvRg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3oRGU8_1712060393;
Received: from 30.221.148.49(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3oRGU8_1712060393)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 20:19:54 +0800
Message-ID: <359c5369-da09-49ba-a900-415f41911fa8@linux.alibaba.com>
Date: Tue, 2 Apr 2024 20:19:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool-next] netlink: fix typo in coalesce_reply_cb()
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: idosch@nvidia.com, kuba@kernel.org, liaichun@huawei.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, yanan@huawei.com,
 Jiri Pirko <jiri@resnulli.us>, mkubecek@suse.cz
References: <ZgvpKNFcBw-39SOD@nanopsycho>
 <20240402121618.3575706-1-gaoxingwang1@huawei.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240402121618.3575706-1-gaoxingwang1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/2 下午8:16, gaoxingwang 写道:
> Add missing colon in coalesce_reply_cb()
>
> Fixes: ec573f209dfd (netlink: settings: add netlink support for coalesce tx aggr params)
> Signed-off-by: Gao Xingwang <gaoxingwang1@huawei.com>
> ---
>   netlink/coalesce.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/netlink/coalesce.c b/netlink/coalesce.c
> index bc34d3d..bb93f9b 100644
> --- a/netlink/coalesce.c
> +++ b/netlink/coalesce.c
> @@ -93,7 +93,7 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, void *data)
>   		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
>   	show_u32("tx-aggr-max-frames", "tx-aggr-max-frames:\t",
>   		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES]);
> -	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs\t",
> +	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
>   		 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
>   	show_cr();
>   

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>


