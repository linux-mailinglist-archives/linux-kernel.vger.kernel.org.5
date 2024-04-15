Return-Path: <linux-kernel+bounces-144444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C18A467E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CED91C217C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359234C9F;
	Mon, 15 Apr 2024 01:17:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEF33CA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143844; cv=none; b=p9C7JLodS2g7K4gMHpETz2DHyi73kURMI9IrlZd+ZWU0t6YPYtjQAJAINCqcUEWb6odWmOIIAWLYEtCc5sMeCthaHUoYSUL6Qn3+1vue/1Dq30iIb/Z+nt1NEAV7nHKMfiIINWCA7qndPLJpFMGKsAYMsZZRjaNNtzTGmY5O5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143844; c=relaxed/simple;
	bh=U9JG8TZM3FnZ06qQJ0sxIT4Cybxdc176DamOpSNqkwo=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=jTzvzEHQa5A/4KmimaCWVXcsUh2H+TgCSVKO0AhGNbLPHgmWhv7K71EIQK48V4u8YeIWnTqgmcCmXqzapRh0owJXeNFvQKz9sCIIkFGemZwplRAHaTeH1C4NO4uAm34xCU+8VQrAa3GKjI2U5YvMKheFjzdwc6ZpyWrpbiCked0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VHq2J4Zr6z1hwMy;
	Mon, 15 Apr 2024 09:14:16 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 66AAD1A0172;
	Mon, 15 Apr 2024 09:17:12 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 15 Apr
 2024 09:17:11 +0800
Message-ID: <661C8017.1070203@hisilicon.com>
Date: Mon, 15 Apr 2024 09:17:11 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Huisong Li <lihuisong@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH 1/2] soc: hisilicon: kunpeng_hccs: Add the check for obtaining
 complete port attribute
References: <20240403081935.24308-1-lihuisong@huawei.com> <20240403081935.24308-2-lihuisong@huawei.com>
In-Reply-To: <20240403081935.24308-2-lihuisong@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Huisong,

On 2024/4/3 16:19, Huisong Li wrote:
> The hccs_get_all_port_attr() is used to obtained the attribute of all
> ports on a specified DIE from firmware. However, this interface doesn't
> ensure whether firmware reports the complete attribute of all ports or not.
> So this patch adds the check for this.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index 9ff70b38e5e9..bb69a95b5f2d 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -556,6 +556,12 @@ static int hccs_get_all_port_attr(struct hccs_dev *hdev,
>  		start_id = rsp_head.next_id;
>  	}
>  
> +	if (left_buf_len != 0) {
> +		dev_err(hdev->dev, "do not get the expected port number(%u) attribute.\n",

How about changing to "failed to get the expected port number(%u) attribute.\n"?

Best Regards,
Wei

> +			size);
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> 

