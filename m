Return-Path: <linux-kernel+bounces-27417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554E82EFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB2128575E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E091BDDD;
	Tue, 16 Jan 2024 13:23:49 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17F1BDC2;
	Tue, 16 Jan 2024 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDqTK295bz4f3jHh;
	Tue, 16 Jan 2024 21:23:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 05C891A0171;
	Tue, 16 Jan 2024 21:23:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFXg6ZlCBoQBA--.16974S3;
	Tue, 16 Jan 2024 21:23:36 +0800 (CST)
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to return
 ENXIO, now returns EINVAL
To: Christoph Hellwig <hch@infradead.org>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
 <ZaZesiKpbMEiiTrf@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <210deda9-5439-244a-0ce2-af9dc8e5d7fe@huaweicloud.com>
Date: Tue, 16 Jan 2024 21:23:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZaZesiKpbMEiiTrf@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFXg6ZlCBoQBA--.16974S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4fAFWrZr4DurWkZw18Xwb_yoW8Cr1rpr
	s0q3s0ya1Ygr129a48ta1I934Fk3ZFyFs7t340qwnYv3y3Ar9xXFykCr1Fvay2qrZxCFWS
	qF4IvFWxAa1UCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Christoph

ÔÚ 2024/01/16 18:47, Christoph Hellwig Ð´µÀ:
> Hi Allison,
> 
> please try this minimal fix.  I need to double check if we historically
> returned ENXIO or EINVAL for adding / resizing partitions, which would
> make things more complicated.  Or maybe you already have data for that
> at hand?
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9c73a763ef8838..f2028e39767821 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>   	sector_t start, length;
>   
>   	if (disk->flags & GENHD_FL_NO_PART)
> -		return -EINVAL;
> +		return -ENXIO;

I think this might not be a proper fix, the reason if that before this
condition is added, -ENXIO is returned from bdev_del_partition(). And
there are also some other error number like -EACCES,-EFAULT following,
so this change will still make changes for user in other cases.

How about following patch?

diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..ec012cf910dc 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,8 +20,6 @@ static int blkpg_do_ioctl(struct block_device *bdev,
         struct blkpg_partition p;
         long long start, length;

-       if (disk->flags & GENHD_FL_NO_PART)
-               return -EINVAL;
         if (!capable(CAP_SYS_ADMIN))
                 return -EACCES;
         if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
@@ -38,6 +36,9 @@ static int blkpg_do_ioctl(struct block_device *bdev,
         start = p.start >> SECTOR_SHIFT;
         length = p.length >> SECTOR_SHIFT;

+       if (disk->flags & GENHD_FL_NO_PART)
+               return -EINVAL;
+
         switch (op) {
         case BLKPG_ADD_PARTITION:
                 /* check if partition is aligned to blocksize */

Thanks,
Kuai


>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EACCES;
>   	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
> 
> .
> 


