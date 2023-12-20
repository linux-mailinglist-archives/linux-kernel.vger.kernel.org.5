Return-Path: <linux-kernel+bounces-7077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A981A156
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1303D1F22CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514883DB80;
	Wed, 20 Dec 2023 14:45:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com [45.254.49.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988103D989;
	Wed, 20 Dec 2023 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [0.0.0.0] (unknown [IPV6:240e:3b7:3270:35d0:2d5d:a87c:93d7:296a])
	by mail-m12773.qiye.163.com (Hmail) with ESMTPA id 9186D2C063A;
	Wed, 20 Dec 2023 16:47:09 +0800 (CST)
Message-ID: <8a0d7c64-128b-277a-8128-5b413f4fc341@sangfor.com.cn>
Date: Wed, 20 Dec 2023 16:47:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] scsi: ses: Fix out-of-bounds accesses
Content-Language: en-US
To: jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: zhuwei@sangfor.com.cn, thenzl@redhat.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231130142835.18041-1-dinghui@sangfor.com.cn>
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20231130142835.18041-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR5DVktNHU9DS08eGEkeQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlMQUhJTEtBSE4fS0FJH04fQRpDTBhBQkgfTEFJQk0aWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JTklVSktLVUpCWQY+
X-HM-Tid: 0a8c86684666b249kuuu9186d2c063a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6Kgw*AzwxNyNJCx1RTkoI
	CRVPChdVSlVKTEtIS01JS0hLTkhKVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
	QVlJT0seQUgZTEFISUxLQUhOH0tBSR9OH0EaQ0wYQUJIH0xBSUJNGllXWQgBWUFKTEpKNwY+

On 2023/11/30 22:28, Ding Hui wrote:
> This series includes a few OOB fixes for ses driver
> 
> Ding Hui (1):
>    scsi: ses: increase default init_alloc_size
> 
> Zhu Wei (1):
>    scsi: ses: Fix slab-out-of-bounds in ses_get_power_status()
> 
>   drivers/scsi/ses.c | 55 +++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 47 insertions(+), 8 deletions(-)
> 

Friendly ping.

-- 
Thanks,
- Ding Hui


