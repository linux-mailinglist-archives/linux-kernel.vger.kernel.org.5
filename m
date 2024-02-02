Return-Path: <linux-kernel+bounces-49048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED928846546
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804F01F252DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C8D5C98;
	Fri,  2 Feb 2024 01:08:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC25678;
	Fri,  2 Feb 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836119; cv=none; b=DQ1wxqlyAdU44Us9PfmS+gNisaeCTluWoSYuz0t4MqIXcjcHhX+tJJ6V5tE0lYKQRl114HdeYJhnWw3Q8jgA5EkNGefzXRmqldPtydBlJChUCbPUVpAzVTxZ60vJ2BNZya4yibOz8BEdXLWN7z3dv11JVNcbdFUKauZf89hyYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836119; c=relaxed/simple;
	bh=+1IlnfbKCOrC3eh+durzYDmP96KjG4rSyU+l64jClGU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bqw2RsZDFpDhWbZ8wvDiQnSSRbFlXhXzpN1mU6n0XYKX0dQ2iExrMob56n/2M0OiatYBMw7V5mv/tJLp+F9/KEf8eJL+lbmZv2R12xsNCJHcqxKWg6wrDkbLi3VsW9chgoMtUZZMnIP5GaG4Z0xIKPFn8B1pZ0tbvs6uH8Da8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQyMJ3gJ4z4f3jHv;
	Fri,  2 Feb 2024 09:08:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B92611A0232;
	Fri,  2 Feb 2024 09:08:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBGPQLxlhjjNCg--.17911S3;
	Fri, 02 Feb 2024 09:08:32 +0800 (CST)
Subject: Re: [PATCH] md/linear: Get rid of md-linear.h
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: Song Liu <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201224549.750644-1-maz@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b05b2e24-07db-5689-a965-97c5ced8c5d7@huaweicloud.com>
Date: Fri, 2 Feb 2024 09:08:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201224549.750644-1-maz@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBGPQLxlhjjNCg--.17911S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtr17WFW8Jw4DZw4rtrykGrg_yoW8Jry5pF
	yfGrW3CF48Jr1UG3W7XFWUua4ftaykJFWfKFy3Z34rXFyDurnrWF1UKrWSqF9IkFyrur42
	qFn2grWqvFykWaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/02/02 6:45, Marc Zyngier Ð´µÀ:
> Given that 849d18e27be9 ("md: Remove deprecated CONFIG_MD_LINEAR")
> killed the linear flavour of MD, it seems only logical to drop
> the leftover include file that used to come with it.
> 
> I also feel that it should be my own privilege to remove my 30 year
> old attempt at writing kernel code ;-). RIP!
> 
> Cc: Song Liu <song@kernel.org>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> ---
>   drivers/md/md-linear.h | 17 -----------------
>   1 file changed, 17 deletions(-)
>   delete mode 100644 drivers/md/md-linear.h
> 
> diff --git a/drivers/md/md-linear.h b/drivers/md/md-linear.h
> deleted file mode 100644
> index 5587eeedb882..000000000000
> --- a/drivers/md/md-linear.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINEAR_H
> -#define _LINEAR_H
> -
> -struct dev_info {
> -	struct md_rdev	*rdev;
> -	sector_t	end_sector;
> -};
> -
> -struct linear_conf
> -{
> -	struct rcu_head		rcu;
> -	sector_t		array_sectors;
> -	int			raid_disks; /* a copy of mddev->raid_disks */
> -	struct dev_info		disks[] __counted_by(raid_disks);
> -};
> -#endif
> 


