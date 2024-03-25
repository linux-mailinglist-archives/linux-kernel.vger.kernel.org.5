Return-Path: <linux-kernel+bounces-116707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4088A2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4DD1C381F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249762F2A;
	Mon, 25 Mar 2024 10:28:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8636156641
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356141; cv=none; b=GG3LQX+sB4pcJ829vSCiNhWtxvzfnPWHvVmSAMJCwCNKn1N4OZ4DPdeOv5hixBsTDIZ8ib+tnkEPPaYabNJpTbNlejRWtiTenD2wSL7CXQe9ylaqMmbTbQR7eufC6zA017b6WSPZHxyDzha5Lit31y1tcfjvF7gvTJQwIQFaBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356141; c=relaxed/simple;
	bh=AK4VerFKWg7/PO+KQ1ODIGaCGy63YMq9Bb+ygRxtKGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WLH3wNUD+GUgw9AEUI3CAq9to7eHXkeRTMfDZDA9d14raUnTx38/5J+B2SenUNn0x5j9C6hnZQRRp5bKyGANQ0wSau33s/IQSQh5f/hNjDBNFPaQxY3wlI8dVZRTXdm4p6DyKDjRQIAQ2i0bWbeEaSc/naPkE9SWbIE8omFwGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V35vt2zF2z1h3Zl;
	Mon, 25 Mar 2024 16:39:38 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id EA34E1402CA;
	Mon, 25 Mar 2024 16:42:15 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 16:42:15 +0800
Message-ID: <60aef4db-27f4-8be3-74bb-3efaee92b7d5@huawei.com>
Date: Mon, 25 Mar 2024 16:42:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ubifs: fix incorrect UBIFS_DFS_DIR_LEN macro definition
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
	<ada@thorsis.com>, <error27@gmail.com>, <Artem.Bityutskiy@nokia.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240324120333.3837837-1-wangzhaolong1@huawei.com>
 <bade7524-2b8f-449a-a29e-cafd11359504@moroto.mountain>
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <bade7524-2b8f-449a-a29e-cafd11359504@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200001.china.huawei.com (7.185.36.224)


Thank you for your detailed comments and suggestions.

 > On Sun, Mar 24, 2024 at 08:03:33PM +0800, ZhaoLong Wang wrote:
 >> The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the 
UBIFS
 >> debugfs directory name, is incorrectly calculated. The current 
formula is
 >> (3 + 1 + 2*2 + 1), which assumes that both UBI device number and 
volume ID
 >> are limited to 2 characters. However, UBI device number ranges from 0 to
 >> 37 (2 characters), and volume ID ranges from 0 to 127 (up to 3 
characters).
 >>
 >> This incorrect definition leads to a buffer overflow issue when the 
device
 >> number is 31 and volume ID is 127, causing the dbg_debugfs_init_fs() 
function
 >> to return prematurely without creating debugfs directory in the 
stable branch
 >> linux-5.10.y.
 >
 > This commit message is very confusing because you are talking about
 > 5.10 and the current kernel.  Only talk about the issues in the current
 > kernel.  Later when we're backporting patches then we can discuss
 > issues in the old kernels.  (You will need to re-write the commit
 > message and resend).
 >

You're right, I shouldn't have mentioned the 5.10 kernel issue in the
commit message. I'll rewrite the commit message to focus only on code
improvements for the current kernel.

 >>
 >> A previous attempt to fix this issue in commit be076fdf8369 ("ubifs: fix
 >> snprintf() checking") by modifying the snprintf return value check 
range is
 >> insufficient. It avoids the premature function return but does not 
address
 >> the root cause of the problem. If the buffer length is inadequate, 
snprintf
 >> will truncate the output string, resulting in incorrect directory names
 >> during filesystem debugging.
 >
 > Heh, my commit message said that my patch did not affect runtime but I
 > don't know what I was thinking when I wrote that. :P  I guess I saw
 > UBI_DFS_DIR_NAME but didn't notice it had some %d format strings in it.
 >
 > I think the calculations were wrong, yes, and the comments that explain
 > them were wrong, yes.  However, I think that the original code worked.
 >
 > -    n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN + 1, UBI_DFS_DIR_NAME,
 >                                        ^^^^^^^^^^^^^^^^^^^
 > The + 1 was added by mistake, however, 9 + 1 = 10, so in the end the
 > math errors cancel each other out.
 >
 > +    n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN, UBI_DFS_DIR_NAME,
 >                                        ^^^^^^^^^^^^^^^
 > This is also 10.
 >
 >                ubi->ubi_num);
 > -    if (n > UBI_DFS_DIR_LEN) {
 > +    if (n >= UBI_DFS_DIR_LEN) {
 >
 > n > 9 and n >= 10 are the same.
 >
 > So I think this is a nice clean up, but I don't think it changes
 > runtime.  We should backport my patch to 5.10.

I also agree with you that the original code, while having incorrect
calculations and comments, still works due to the mathematical errors
canceling out. I'll acknowledge this in the revised commit message.

As for the suggestion to backport your patch to 5.10, I'm all for it.
This will help fix the problem in the old kernel.

Thanks again for the feedback. I'll prepare an updated patch and resend
it as soon as possible.

Best regards,
ZhaoLong Wang

