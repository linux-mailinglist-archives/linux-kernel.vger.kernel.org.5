Return-Path: <linux-kernel+bounces-12954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0EE81FD43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EEFB20E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C88C02;
	Fri, 29 Dec 2023 06:35:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEA8BE3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T1bGp2qrwzZfrF;
	Fri, 29 Dec 2023 14:35:30 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CBAB1402CA;
	Fri, 29 Dec 2023 14:35:41 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 14:35:40 +0800
Subject: Re: [PATCH mtd-utils 08/11] tests: ubifs_repair: Add corrupted images
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20231228013639.2827205-1-chengzhihao1@huawei.com>
 <20231228013639.2827205-9-chengzhihao1@huawei.com>
Message-ID: <c903cd6d-17e9-d281-b2e6-1d005ba13a44@huawei.com>
Date: Fri, 29 Dec 2023 14:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231228013639.2827205-9-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2023/12/28 9:36, Zhihao Cheng 写道:
> diff --git a/tests/ubifs_repair-tests/images/xinode_mode.gz b/tests/ubifs_repair-tests/images/xinode_mode.gz
> new file mode 100644
> index 0000000000000000000000000000000000000000..c86f69c7e3a716864035d1763ae533079727b8b2
> GIT binary patch
> literal 5386
> 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
> QVZvU0uJPWrOJvtS0f#f8%m4rY
>
> literal 0
> HcmV?d00001
>
Hi, I find that  xinode_mode.gz is not displayed in patchwork 
https://patchwork.ozlabs.org/project/linux-mtd/patch/20231228013639.2827205-9-chengzhihao1@huawei.com/, 
maybe it is a bug in patchwork. You can download it from this mail or 
https://lore.kernel.org/linux-mtd/20231228013639.2827205-9-chengzhihao1@huawei.com/


