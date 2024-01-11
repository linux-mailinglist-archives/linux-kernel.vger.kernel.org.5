Return-Path: <linux-kernel+bounces-23589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46782AEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C9C286544
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55415AE4;
	Thu, 11 Jan 2024 12:30:32 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E276156DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T9kVY60cFz1Q7lS;
	Thu, 11 Jan 2024 20:28:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 13FD21A0172;
	Thu, 11 Jan 2024 20:30:27 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 20:30:26 +0800
Subject: Re: [PATCH v2] ubifs: Remove unreachable code in dbg_check_ltab_lnum
To: Kunwu Chan <chentao@kylinos.cn>, <richard@nod.at>,
	<Artem.Bityutskiy@nokia.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Kunwu
 Chan <kunwu.chan@hotmail.com>, Richard Weinberger
	<richard.weinberger@gmail.com>
References: <20240111063656.68810-1-chentao@kylinos.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <920ffa51-15af-c07f-3eae-1e1ebd5fdd33@huawei.com>
Date: Thu, 11 Jan 2024 20:30:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240111063656.68810-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/1/11 14:36, Kunwu Chan Ð´µÀ:
> Because there is no break statement in the dead loop above,it is
> impossible to execute the 'err=0' statement.Delete the code that
> will never execute.
> 
> Fixes: 6fb324a4b0c3 ("UBIFS: allocate ltab checking buffer on demand")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Suggested-by: Richard Weinberger <richard.weinberger@gmail.com>
> 
> ---
> v2: Remove the initialization of err
> ---
>   fs/ubifs/lpt_commit.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> 
> diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
> index c4d079328b92..07351fdce722 100644
> --- a/fs/ubifs/lpt_commit.c
> +++ b/fs/ubifs/lpt_commit.c
> @@ -1646,7 +1646,6 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
>   		len -= node_len;
>   	}
>   
> -	err = 0;
>   out:
>   	vfree(buf);
>   	return err;
> 


