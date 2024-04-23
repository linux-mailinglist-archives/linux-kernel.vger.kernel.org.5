Return-Path: <linux-kernel+bounces-154676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1A8ADFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20951C217A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223D951C5C;
	Tue, 23 Apr 2024 08:22:58 +0000 (UTC)
Received: from mail-m25484.xmail.ntesmail.com (mail-m25484.xmail.ntesmail.com [103.129.254.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92850297;
	Tue, 23 Apr 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860576; cv=none; b=BQYYjIEu+Vl1hGO1uiCp9hXyn9gmx43z9yyi9ekaRxpjR4dQJS7anEbDXEDeFMopBrJQy1p4wFlmRL4sRoxD1/XmjzyQrFz/dhksDnnX4Kh7whujidG+mEfddWJL5RV1yLjNvacxx2ms+iZyb2hwAbITag7ujJG9VDojhyBvR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860576; c=relaxed/simple;
	bh=qFLMOK6taO9F8RXZpeQ/bL+ucaOgdUZHiohjBHTMolQ=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V/I84oxr4eoi1v91aiKvWzsgH5H4NdmUOtGzUYkbE2ae9by8uHqOfQORD3GnvDwgK0Zi28ANxUeJj50iuPLrBS6Er6ruxuvkG+1iT9fdsL7DLtcP7L9YVzixkZoQcPzS1ts1Vh9wYV4Luigh23SqQOR9cclA8wsdLVlwwgD4UQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.129.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 4911F86015D;
	Tue, 23 Apr 2024 15:27:32 +0800 (CST)
Subject: Re: [PATCH 6/7] cbd: introduce cbd_blkdev
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422224240.2637-1-dongsheng.yang@easystack.cn>
Message-ID: <ed06533a-867f-5ad0-d655-b8ab9916267e@easystack.cn>
Date: Tue, 23 Apr 2024 15:27:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240422224240.2637-1-dongsheng.yang@easystack.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx5IVkJOHUMaTUxPHR1JT1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f09da4ed9023ckunm4911f86015d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6Nxw5HTc#LxJCFjY*ExxJ
	Qj5PCT1VSlVKTEpIQ05MSU5ITEhPVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSE1CTkI3Bg++



在 2024/4/23 星期二 上午 6:42, Dongsheng Yang 写道:
> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> 
> The "cbd_blkdev" represents a virtual block device named "/dev/cbdX". It
> corresponds to a backend. The "blkdev" interacts with upper-layer users
> and accepts IO requests from them. A "blkdev" includes multiple
> "cbd_queues", each of which requires a "cbd_channel" to
> interact with the backend's handler. The "cbd_queue" forwards IO
> requests from the upper layer to the backend's handler through the
> channel.
> 
> Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> ---
>   drivers/block/cbd/Makefile        |   2 +-
>   drivers/block/cbd/cbd_blkdev.c    | 375 ++++++++++++++++++
>   drivers/block/cbd/cbd_main.c      |   6 +
>   drivers/block/cbd/cbd_queue.c     | 621 ++++++++++++++++++++++++++++++
>   drivers/block/cbd/cbd_transport.c |  11 +
>   5 files changed, 1014 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/block/cbd/cbd_blkdev.c
>   create mode 100644 drivers/block/cbd/cbd_queue.c
> 
> diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile
> index b47f1e584946..f5fb5fd68f3d 100644
> --- a/drivers/block/cbd/Makefile
> +++ b/drivers/block/cbd/Makefile
> @@ -1,3 +1,3 @@
> -cbd-y := cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o cbd_backend.o cbd_handler.o
> +cbd-y := cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o cbd_backend.o cbd_handler.o cbd_blkdev.o cbd_queue.o
>   
>   obj-$(CONFIG_BLK_DEV_CBD) += cbd.o
> diff --git a/drivers/block/cbd/cbd_blkdev.c b/drivers/block/cbd/cbd_blkdev.c
> new file mode 100644
> index 000000000000..816bc28afb49
> --- /dev/null
> +++ b/drivers/block/cbd/cbd_blkdev.c
> @@ -0,0 +1,375 @@
> +#include "cbd_internal.h"
> +
> +static ssize_t blkdev_backend_id_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cbd_blkdev_device *blkdev;
> +	struct cbd_blkdev_info *blkdev_info;
> +
> +	blkdev = container_of(dev, struct cbd_blkdev_device, dev);
> +	blkdev_info = blkdev->blkdev_info;
> +
> +	cbdt_flush_range(blkdev->cbdt, blkdev_info, sizeof(*blkdev_info));
> +
> +	if (blkdev_info->state == cbd_blkdev_state_none)
> +		return 0;
> +
> +	return sprintf(buf, "%u\n", blkdev_info->backend_id);
> +}
> +
> +static DEVICE_ATTR(backend_id, 0400, blkdev_backend_id_show, NULL);
> +
> +static ssize_t blkdev_host_id_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cbd_blkdev_device *blkdev;
> +	struct cbd_blkdev_info *blkdev_info;
> +
> +	blkdev = container_of(dev, struct cbd_blkdev_device, dev);
> +	blkdev_info = blkdev->blkdev_info;
> +
> +	cbdt_flush_range(blkdev->cbdt, blkdev_info, sizeof(*blkdev_info));
> +
> +	if (blkdev_info->state == cbd_blkdev_state_none)
> +		return 0;
> +
> +	return sprintf(buf, "%u\n", blkdev_info->host_id);
> +}
> +
> +static DEVICE_ATTR(host_id, 0400, blkdev_host_id_show, NULL);
> +
> +static ssize_t blkdev_mapped_id_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cbd_blkdev_device *blkdev;
> +	struct cbd_blkdev_info *blkdev_info;
> +
> +	blkdev = container_of(dev, struct cbd_blkdev_device, dev);
> +	blkdev_info = blkdev->blkdev_info;
> +
> +	cbdt_flush_range(blkdev->cbdt, blkdev_info, sizeof(*blkdev_info));
> +
> +	if (blkdev_info->state == cbd_blkdev_state_none)
> +		return 0;
> +
> +	return sprintf(buf, "%u\n", blkdev_info->mapped_id);
> +}
> +
> +static DEVICE_ATTR(mapped_id, 0400, blkdev_mapped_id_show, NULL);
> +
> +CBD_OBJ_HEARTBEAT(blkdev);
> +
> +static struct attribute *cbd_blkdev_attrs[] = {
> +	&dev_attr_mapped_id.attr,
> +	&dev_attr_host_id.attr,
> +	&dev_attr_backend_id.attr,
> +	&dev_attr_alive.attr,
> +	NULL
> +};
> +
> +static struct attribute_group cbd_blkdev_attr_group = {
> +	.attrs = cbd_blkdev_attrs,
> +};
> +
> +static const struct attribute_group *cbd_blkdev_attr_groups[] = {
> +	&cbd_blkdev_attr_group,
> +	NULL
> +};
> +
> +static void cbd_blkdev_release(struct device *dev)
> +{
> +}
> +
> +struct device_type cbd_blkdev_type = {
> +	.name		= "cbd_blkdev",
> +	.groups		= cbd_blkdev_attr_groups,
> +	.release	= cbd_blkdev_release,
> +};
> +
> +struct device_type cbd_blkdevs_type = {
> +	.name		= "cbd_blkdevs",
> +	.release	= cbd_blkdev_release,
> +};
> +
> +
> +static int cbd_major;
> +static DEFINE_IDA(cbd_mapped_id_ida);
> +
> +static int minor_to_cbd_mapped_id(int minor)
> +{
> +	return minor >> CBD_PART_SHIFT;
> +}
> +
> +
> +static int cbd_open(struct gendisk *disk, blk_mode_t mode)
> +{
> +	return 0;
> +}
> +
> +static void cbd_release(struct gendisk *disk)
> +{
> +}
> +
> +static const struct block_device_operations cbd_bd_ops = {
> +	.owner			= THIS_MODULE,
> +	.open			= cbd_open,
> +	.release		= cbd_release,
> +};
> +
> +
> +static void cbd_blkdev_destroy_queues(struct cbd_blkdev *cbd_blkdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < cbd_blkdev->num_queues; i++) {
> +		cbd_queue_stop(&cbd_blkdev->queues[i]);
> +	}
> +
> +	kfree(cbd_blkdev->queues);
> +}
> +
> +static int cbd_blkdev_create_queues(struct cbd_blkdev *cbd_blkdev)
> +{
> +	int i;
> +	int ret;
> +	struct cbd_queue *cbdq;
> +
> +	cbd_blkdev->queues = kcalloc(cbd_blkdev->num_queues, sizeof(struct cbd_queue), GFP_KERNEL);
> +	if (!cbd_blkdev->queues) {
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < cbd_blkdev->num_queues; i++) {
> +		cbdq = &cbd_blkdev->queues[i];
> +		cbdq->cbd_blkdev = cbd_blkdev;
> +		cbdq->index = i;
> +		ret = cbd_queue_start(cbdq);
> +		if (ret)
> +			goto err;
> +
> +	}
> +
> +	return 0;
> +err:
> +	cbd_blkdev_destroy_queues(cbd_blkdev);
> +	return ret;
> +}
> +
> +static int disk_start(struct cbd_blkdev *cbd_blkdev)
> +{
> +	int ret;
> +	struct gendisk *disk;
> +
> +	memset(&cbd_blkdev->tag_set, 0, sizeof(cbd_blkdev->tag_set));
> +	cbd_blkdev->tag_set.ops = &cbd_mq_ops;
> +	cbd_blkdev->tag_set.queue_depth = 128;
> +	cbd_blkdev->tag_set.numa_node = NUMA_NO_NODE;
> +	cbd_blkdev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED;
> +	cbd_blkdev->tag_set.nr_hw_queues = cbd_blkdev->num_queues;
> +	cbd_blkdev->tag_set.cmd_size = sizeof(struct cbd_request);
> +	cbd_blkdev->tag_set.timeout = 0;
> +	cbd_blkdev->tag_set.driver_data = cbd_blkdev;
> +
> +	ret = blk_mq_alloc_tag_set(&cbd_blkdev->tag_set);
> +	if (ret) {
> +		pr_err("failed to alloc tag set %d", ret);
> +		goto err;
> +	}
> +
> +	disk = blk_mq_alloc_disk(&cbd_blkdev->tag_set, cbd_blkdev);
> +	if (IS_ERR(disk)) {
> +		ret = PTR_ERR(disk);
> +		pr_err("failed to alloc disk");
> +		goto out_tag_set;
> +	}
> +
> +        snprintf(disk->disk_name, sizeof(disk->disk_name), "cbd%d",
> +                 cbd_blkdev->mapped_id);
> +
> +	disk->major = cbd_major;
> +	disk->first_minor = cbd_blkdev->mapped_id << CBD_PART_SHIFT;
> +	disk->minors = (1 << CBD_PART_SHIFT);
> +
> +	disk->fops = &cbd_bd_ops;
> +	disk->private_data = cbd_blkdev;
> +
> +	/* Tell the block layer that this is not a rotational device */
> +	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
> +	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, disk->queue);
> +	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, disk->queue);
> +
> +	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
> +	blk_queue_max_hw_sectors(disk->queue, 128);
> +	blk_queue_max_segments(disk->queue, USHRT_MAX);
> +	blk_queue_max_segment_size(disk->queue, UINT_MAX);
> +	blk_queue_io_min(disk->queue, 4096);
> +	blk_queue_io_opt(disk->queue, 4096);
> +
> +	disk->queue->limits.max_sectors = queue_max_hw_sectors(disk->queue);
> +	/* TODO support discard */
> +	disk->queue->limits.discard_granularity = 0;
> +	blk_queue_max_discard_sectors(disk->queue, 0);
> +	blk_queue_max_write_zeroes_sectors(disk->queue, 0);
> +
> +	cbd_blkdev->disk = disk;
> +
> +	cbdt_add_blkdev(cbd_blkdev->cbdt, cbd_blkdev);
> +	cbd_blkdev->blkdev_info->mapped_id = cbd_blkdev->blkdev_id;
> +	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_running;
> +
> +	set_capacity(cbd_blkdev->disk, cbd_blkdev->dev_size);
> +
> +	set_disk_ro(cbd_blkdev->disk, false);
> +	blk_queue_write_cache(cbd_blkdev->disk->queue, false, false);
> +
> +	ret = add_disk(cbd_blkdev->disk);
> +	if (ret) {
> +		goto put_disk;
> +	}
> +
> +	ret = sysfs_create_link(&disk_to_dev(cbd_blkdev->disk)->kobj,
> +				&cbd_blkdev->blkdev_dev->dev.kobj, "cbd_blkdev");
> +	if (ret) {
> +		goto del_disk;
> +	}
> +
> +	blk_put_queue(cbd_blkdev->disk->queue);
> +
> +	return 0;
> +
> +del_disk:
> +	del_gendisk(cbd_blkdev->disk);
> +put_disk:
> +	put_disk(cbd_blkdev->disk);
> +out_tag_set:
> +	blk_mq_free_tag_set(&cbd_blkdev->tag_set);
> +err:
> +	return ret;
> +}
> +
> +int cbd_blkdev_start(struct cbd_transport *cbdt, u32 backend_id, u32 queues)
> +{
> +	struct cbd_blkdev *cbd_blkdev;
> +	struct cbd_backend_info *backend_info;
> +	u64 dev_size;
> +	int ret;
> +
> +	backend_info = cbdt_get_backend_info(cbdt, backend_id);
> +	cbdt_flush_range(cbdt, backend_info, sizeof(*backend_info));
> +	if (backend_info->blkdev_count == CBDB_BLKDEV_COUNT_MAX) {
> +		return -EBUSY;
> +	}
> +
> +	dev_size = backend_info->dev_size;
> +
> +	cbd_blkdev = kzalloc(sizeof(struct cbd_blkdev), GFP_KERNEL);
> +	if (!cbd_blkdev) {
> +		pr_err("fail to alloc cbd_blkdev");
> +		return -ENOMEM;
> +	}
> +
> +	ret = cbdt_get_empty_blkdev_id(cbdt, &cbd_blkdev->blkdev_id);
> +	if (ret < 0) {
> +		goto blkdev_free;
> +	}
> +
> +	cbd_blkdev->mapped_id = ida_simple_get(&cbd_mapped_id_ida, 0,
> +					 minor_to_cbd_mapped_id(1 << MINORBITS),
> +					 GFP_KERNEL);
> +	if (cbd_blkdev->mapped_id < 0) {
> +		ret = -ENOENT;
> +		goto blkdev_free;
> +	}
> +
> +	INIT_LIST_HEAD(&cbd_blkdev->node);
> +	cbd_blkdev->cbdt = cbdt;
> +	cbd_blkdev->backend_id = backend_id;
> +	cbd_blkdev->num_queues = queues;
> +	cbd_blkdev->dev_size = dev_size;
> +	cbd_blkdev->blkdev_info = cbdt_get_blkdev_info(cbdt, cbd_blkdev->blkdev_id);
> +	cbd_blkdev->blkdev_dev = &cbdt->cbd_blkdevs_dev->blkdev_devs[cbd_blkdev->blkdev_id];
> +
> +	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_running;
> +	cbdt_flush_range(cbdt, cbd_blkdev->blkdev_info, sizeof(*cbd_blkdev->blkdev_info));
> +
> +	INIT_DELAYED_WORK(&cbd_blkdev->hb_work, blkdev_hb_workfn);
> +	queue_delayed_work(cbd_wq, &cbd_blkdev->hb_work, 0);
> +
> +	ret = cbd_blkdev_create_queues(cbd_blkdev);
> +	if (ret < 0) {
> +		goto cancel_hb;;
> +	}
> +
> +	ret = disk_start(cbd_blkdev);
> +	if (ret < 0) {
> +		goto destroy_queues;
> +	}
> +
> +	backend_info->blkdev_count++;
> +	cbdt_flush_range(cbdt, backend_info, sizeof(*backend_info));
> +
> +	return 0;
> +
> +destroy_queues:
> +	cbd_blkdev_destroy_queues(cbd_blkdev);
> +cancel_hb:
> +	cancel_delayed_work_sync(&cbd_blkdev->hb_work);
> +	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_none;
> +	cbdt_flush_range(cbdt, cbd_blkdev->blkdev_info, sizeof(*cbd_blkdev->blkdev_info));
> +	ida_simple_remove(&cbd_mapped_id_ida, cbd_blkdev->mapped_id);
> +blkdev_free:
> +	kfree(cbd_blkdev);
> +	return ret;
> +}
> +
> +static void disk_stop(struct cbd_blkdev *cbd_blkdev)
> +{
> +	sysfs_remove_link(&disk_to_dev(cbd_blkdev->disk)->kobj, "cache");
> +	del_gendisk(cbd_blkdev->disk);
> +	put_disk(cbd_blkdev->disk);
> +	blk_mq_free_tag_set(&cbd_blkdev->tag_set);
> +}
> +
> +int cbd_blkdev_stop(struct cbd_transport *cbdt, u32 devid)
> +{
> +	struct cbd_blkdev *cbd_blkdev;
> +	struct cbd_backend_info *backend_info;
> +
> +	cbd_blkdev = cbdt_fetch_blkdev(cbdt, devid);
> +	if (!cbd_blkdev) {
> +		return -EINVAL;
> +	}
> +
> +	backend_info = cbdt_get_backend_info(cbdt, cbd_blkdev->backend_id);
> +
> +	disk_stop(cbd_blkdev);
> +	cbd_blkdev_destroy_queues(cbd_blkdev);
> +	cancel_delayed_work_sync(&cbd_blkdev->hb_work);
> +	cbd_blkdev->blkdev_info->state = cbd_blkdev_state_none;
> +	cbdt_flush_range(cbdt, cbd_blkdev->blkdev_info, sizeof(*cbd_blkdev->blkdev_info));
> +	ida_simple_remove(&cbd_mapped_id_ida, cbd_blkdev->mapped_id);
> +
> +	kfree(cbd_blkdev);
> +
> +	backend_info->blkdev_count--;
> +	cbdt_flush_range(cbdt, backend_info, sizeof(*backend_info));
> +
> +	return 0;
> +}
> +
> +int cbd_blkdev_init(void)
> +{
> +	cbd_major = register_blkdev(0, "cbd");
> +	if (cbd_major < 0)
> +		return cbd_major;
> +
> +	return 0;
> +}
> +
> +void cbd_blkdev_exit(void)
> +{
> +	unregister_blkdev(cbd_major, "cbd");
> +}
> diff --git a/drivers/block/cbd/cbd_main.c b/drivers/block/cbd/cbd_main.c
> index 8cfa60dde7c5..658233807b59 100644
> --- a/drivers/block/cbd/cbd_main.c
> +++ b/drivers/block/cbd/cbd_main.c
> @@ -195,6 +195,11 @@ static int __init cbd_init(void)
>   		goto device_unregister;
>   	}
>   
> +	ret = cbd_blkdev_init();
> +	if (ret < 0) {
> +		goto bus_unregister;
> +	}
> +
>   	return 0;
>   
>   bus_unregister:
> @@ -209,6 +214,7 @@ static int __init cbd_init(void)
>   
>   static void cbd_exit(void)
>   {
> +	cbd_blkdev_exit();
>   	bus_unregister(&cbd_bus_type);
>   	device_unregister(&cbd_root_dev);
>   
> diff --git a/drivers/block/cbd/cbd_queue.c b/drivers/block/cbd/cbd_queue.c
> new file mode 100644
> index 000000000000..6709ac016e18
> --- /dev/null
> +++ b/drivers/block/cbd/cbd_queue.c
> @@ -0,0 +1,621 @@
> +#include "cbd_internal.h"
> +
> +/*
> + * How do blkdev and backend interact through the channel?
> + *         a) For reader side, before reading the data, if the data in this channel may
> + * be modified by the other party, then I need to flush the cache before reading to ensure
> + * that I get the latest data. For example, the blkdev needs to flush the cache before
> + * obtaining compr_head because compr_head will be updated by the backend handler.
> + *         b) For writter side, if the written information will be read by others, then
> + * after writing, I need to flush the cache to let the other party see it immediately.
> + * For example, after blkdev submits cbd_se, it needs to update cmd_head to let the
> + * handler have a new cbd_se. Therefore, after updating cmd_head, I need to flush the
> + * cache to let the backend see it.
> + *
> + * For the blkdev queue, I am the only one who updates the `cmd_head`, `cmd_tail`, and `compr_tail'.
> + * Therefore, I don't need to flush_dcache before reading these data. However, after updating these data,
> + * I need to flush_dcache so that the backend handler can see these updates.
> + *
> + * On the other hand, `compr_head` is updated by the backend handler. So, I need to flush_dcache before
> + * reading `compr_head` to ensure that I can see the updates.
> + *
> + *           ┌───────────┐          ┌─────────────┐
> + *           │  blkdev   │          │   backend   │
> + *           │  queue    │          │   handler   │
> + *           └─────┬─────┘          └──────┬──────┘
> + *                 ▼                       │
> + *        init data and cbd_se             │
> + *                 │                       │
> + *                 ▼                       │
> + *            update cmd_head              │
> + *                 │                       │
> + *                 ▼                       │
> + *            flush_cache                  │
> + *                 │                       ▼
> + *                 │                    flush_cache
> + *                 │                       │
> + *                 │                       ▼
> + *                 │                   handle cmd
> + *                 │                       │
> + *                 │                       ▼
> + *                 │                    fill cbd_ce
> + *                 │                       │
> + *                 │                       ▼
> + *                 │                    flush_cache
> + *                 ▼
> + *            flush_cache
> + *                 │
> + *                 ▼
> + *            complete_req
> + */
> +
> +static inline struct cbd_se *get_submit_entry(struct cbd_queue *cbdq)
> +{
> +	return (struct cbd_se *)(cbdq->channel.cmdr + cbdq->channel_info->cmd_head);
> +}
> +
> +static inline struct cbd_se *get_oldest_se(struct cbd_queue *cbdq)
> +{
> +	if (cbdq->channel_info->cmd_tail == cbdq->channel_info->cmd_head)
> +		return NULL;
> +
> +	return (struct cbd_se *)(cbdq->channel.cmdr + cbdq->channel_info->cmd_tail);
> +}
> +
> +static inline struct cbd_ce *get_complete_entry(struct cbd_queue *cbdq)
> +{
> +	if (cbdq->channel_info->compr_tail == cbdq->channel_info->compr_head)
> +		return NULL;
> +
> +	return (struct cbd_ce *)(cbdq->channel.compr + cbdq->channel_info->compr_tail);
> +}
> +
> +static void cbd_req_init(struct cbd_queue *cbdq, enum cbd_op op, struct request *rq)
> +{
> +	struct cbd_request *cbd_req = blk_mq_rq_to_pdu(rq);
> +
> +	cbd_req->req = rq;
> +	cbd_req->cbdq = cbdq;
> +	cbd_req->op = op;
> +
> +	return;
> +}
> +
> +static bool cbd_req_nodata(struct cbd_request *cbd_req)
> +{
> +	switch (cbd_req->op) {
> +		case CBD_OP_WRITE:
> +		case CBD_OP_READ:
> +			return false;
> +		case CBD_OP_DISCARD:
> +		case CBD_OP_WRITE_ZEROS:
> +		case CBD_OP_FLUSH:
> +			return true;
> +		default:
> +			BUG();
> +	}
> +}
> +
> +static uint32_t cbd_req_segments(struct cbd_request *cbd_req)
> +{
> +	uint32_t segs = 0;
> +	struct bio *bio = cbd_req->req->bio;
> +
> +	if (cbd_req_nodata(cbd_req))
> +		return 0;
> +
> +	while (bio) {
> +		segs += bio_segments(bio);
> +		bio = bio->bi_next;
> +	}
> +
> +	return segs;
> +}
> +
> +static inline size_t cbd_get_cmd_size(struct cbd_request *cbd_req)
> +{
> +	u32 segs = cbd_req_segments(cbd_req);
> +	u32 cmd_size = sizeof(struct cbd_se) + (sizeof(struct iovec) * segs);
> +
> +	return round_up(cmd_size, CBD_OP_ALIGN_SIZE);
> +}
> +
> +static void insert_padding(struct cbd_queue *cbdq, u32 cmd_size)
> +{
> +	struct cbd_se_hdr *header;
> +	u32 pad_len;
> +
> +	if (cbdq->channel_info->cmdr_size - cbdq->channel_info->cmd_head >= cmd_size)
> +		return;
> +
> +	pad_len = cbdq->channel_info->cmdr_size - cbdq->channel_info->cmd_head;
> +	cbd_queue_debug(cbdq, "insert pad:%d\n", pad_len);
> +
> +	header = (struct cbd_se_hdr *)get_submit_entry(cbdq);
> +	memset(header, 0, pad_len);
> +	cbd_se_hdr_set_op(&header->len_op, CBD_OP_PAD);
> +	cbd_se_hdr_set_len(&header->len_op, pad_len);
> +
> +	cbdt_flush_range(cbdq->cbd_blkdev->cbdt, header, sizeof(*header));
> +
> +	CBDC_UPDATE_CMDR_HEAD(cbdq->channel_info->cmd_head, pad_len, cbdq->channel_info->cmdr_size);
> +}
> +
> +static void queue_req_se_init(struct cbd_request *cbd_req)
> +{
> +	struct cbd_se	*se;
> +	struct cbd_se_hdr *header;
> +	u64 offset = (u64)blk_rq_pos(cbd_req->req) << SECTOR_SHIFT;
> +	u64 length = blk_rq_bytes(cbd_req->req);
> +
> +	se = get_submit_entry(cbd_req->cbdq);
> +	memset(se, 0, cbd_get_cmd_size(cbd_req));
> +	header = &se->header;
> +
> +	cbd_se_hdr_set_op(&header->len_op, cbd_req->op);
> +	cbd_se_hdr_set_len(&header->len_op, cbd_get_cmd_size(cbd_req));
> +
> +	se->priv_data = cbd_req->req_tid;
> +	se->offset = offset;
> +	se->len = length;
> +
> +	if (req_op(cbd_req->req) == REQ_OP_READ || req_op(cbd_req->req) == REQ_OP_WRITE) {
> +		se->data_off = cbd_req->cbdq->channel.data_head;
> +		se->data_len = length;
> +	}
> +
> +	cbd_req->se = se;
> +}
> +
> +static bool data_space_enough(struct cbd_queue *cbdq, struct cbd_request *cbd_req)
> +{
> +	u32 space_available;
> +	u32 space_needed;
> +	u32 space_used;
> +	u32 space_max;
> +
> +	space_max = cbdq->channel.data_size - 4096;
> +
> +	if (cbdq->channel.data_head > cbdq->channel.data_tail)
> +		space_used = cbdq->channel.data_head - cbdq->channel.data_tail;
> +	else if (cbdq->channel.data_head < cbdq->channel.data_tail)
> +		space_used = cbdq->channel.data_head + (cbdq->channel.data_size - cbdq->channel.data_tail);
> +	else
> +		space_used = 0;
> +
> +	space_available = space_max - space_used;
> +
> +	space_needed = round_up(cbd_req->data_len, 4096);
> +
> +	if (space_available < space_needed) {
> +		cbd_queue_err(cbdq, "data space is not enough: availaible: %u needed: %u",
> +			      space_available, space_needed);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool submit_ring_space_enough(struct cbd_queue *cbdq, u32 cmd_size)
> +{
> +	u32 space_available;
> +	u32 space_needed;
> +	u32 space_max, space_used;
> +
> +	/* There is a CMDR_RESERVED we dont use to prevent the ring to be used up */
> +	space_max = cbdq->channel_info->cmdr_size - CBDC_CMDR_RESERVED;
> +
> +	if (cbdq->channel_info->cmd_head > cbdq->channel_info->cmd_tail)
> +		space_used = cbdq->channel_info->cmd_head - cbdq->channel_info->cmd_tail;
> +	else if (cbdq->channel_info->cmd_head < cbdq->channel_info->cmd_tail)
> +		space_used = cbdq->channel_info->cmd_head + (cbdq->channel_info->cmdr_size - cbdq->channel_info->cmd_tail);
> +	else
> +		space_used = 0;
> +
> +	space_available = space_max - space_used;
> +
> +	if (cbdq->channel_info->cmdr_size - cbdq->channel_info->cmd_head > cmd_size)
> +		space_needed = cmd_size;
> +	else
> +		space_needed = cmd_size + cbdq->channel_info->cmdr_size - cbdq->channel_info->cmd_head;
> +
> +	if (space_available < space_needed)
> +		return false;
> +
> +	return true;
> +}
> +
> +static void queue_req_data_init(struct cbd_request *cbd_req)
> +{
> +	struct cbd_queue *cbdq = cbd_req->cbdq;
> +	struct bio *bio = cbd_req->req->bio;
> +
> +	if (cbd_req->op == CBD_OP_READ) {
> +		goto advance_data_head;
> +	}
> +
> +	cbdc_copy_from_bio(&cbdq->channel, cbd_req->data_off, cbd_req->data_len, bio);
> +
> +advance_data_head:
> +	cbdq->channel.data_head = round_up(cbdq->channel.data_head + cbd_req->data_len, PAGE_SIZE);
> +	cbdq->channel.data_head %= cbdq->channel.data_size;
> +
> +	return;
> +}
> +
> +static void complete_inflight_req(struct cbd_queue *cbdq, struct cbd_request *cbd_req, int ret);
> +static void cbd_queue_fn(struct cbd_request *cbd_req)
> +{
> +	struct cbd_queue *cbdq = cbd_req->cbdq;
> +	int ret = 0;
> +	size_t command_size;
> +
> +	spin_lock(&cbdq->inflight_reqs_lock);
> +	list_add_tail(&cbd_req->inflight_reqs_node, &cbdq->inflight_reqs);
> +	spin_unlock(&cbdq->inflight_reqs_lock);
> +
> +	command_size = cbd_get_cmd_size(cbd_req);
> +
> +	spin_lock(&cbdq->channel.cmdr_lock);
> +	if (req_op(cbd_req->req) == REQ_OP_WRITE || req_op(cbd_req->req) == REQ_OP_READ) {
> +		cbd_req->data_off = cbdq->channel.data_head;
> +		cbd_req->data_len = blk_rq_bytes(cbd_req->req);
> +	} else {
> +		cbd_req->data_off = -1;
> +		cbd_req->data_len = 0;
> +	}
> +
> +	if (!submit_ring_space_enough(cbdq, command_size) ||
> +			!data_space_enough(cbdq, cbd_req)) {
> +		spin_unlock(&cbdq->channel.cmdr_lock);
> +
> +		/* remove request from inflight_reqs */
> +		spin_lock(&cbdq->inflight_reqs_lock);
> +		list_del_init(&cbd_req->inflight_reqs_node);
> +		spin_unlock(&cbdq->inflight_reqs_lock);
> +
> +		cbd_blk_debug(cbdq->cbd_blkdev, "transport space is not enough");
> +		ret = -ENOMEM;
> +		goto end_request;
> +	}
> +
> +	insert_padding(cbdq, command_size);
> +
> +	cbd_req->req_tid = ++cbdq->req_tid;
> +	queue_req_se_init(cbd_req);
> +	cbdt_flush_range(cbdq->cbd_blkdev->cbdt, cbd_req->se, sizeof(struct cbd_se));
> +
> +	if (!cbd_req_nodata(cbd_req)) {
> +		queue_req_data_init(cbd_req);
> +	}
> +
> +	queue_delayed_work(cbdq->task_wq, &cbdq->complete_work, 0);
> +
> +	CBDC_UPDATE_CMDR_HEAD(cbdq->channel_info->cmd_head,
> +			cbd_get_cmd_size(cbd_req),
> +			cbdq->channel_info->cmdr_size);
> +	cbdc_flush_ctrl(&cbdq->channel);
> +	spin_unlock(&cbdq->channel.cmdr_lock);
> +
> +	return;
> +
> +end_request:
> +	if (ret == -ENOMEM || ret == -EBUSY)
> +		blk_mq_requeue_request(cbd_req->req, true);
> +	else
> +		blk_mq_end_request(cbd_req->req, errno_to_blk_status(ret));
> +
> +	return;
> +}
> +
> +static void cbd_req_release(struct cbd_request *cbd_req)
> +{
> +	return;
> +}
> +
> +static void advance_cmd_ring(struct cbd_queue *cbdq)
> +{
> +       struct cbd_se *se;
> +again:
> +       se = get_oldest_se(cbdq);
> +       if (!se)
> +               goto out;
> +
> +	if (cbd_se_hdr_flags_test(se, CBD_SE_HDR_DONE)) {
> +		CBDC_UPDATE_CMDR_TAIL(cbdq->channel_info->cmd_tail,
> +				cbd_se_hdr_get_len(se->header.len_op),
> +				cbdq->channel_info->cmdr_size);
> +		cbdc_flush_ctrl(&cbdq->channel);
> +		goto again;
> +       }
> +out:
> +       return;
> +}
> +
> +static bool __advance_data_tail(struct cbd_queue *cbdq, u32 data_off, u32 data_len)
> +{
> +	if (data_off == cbdq->channel.data_tail) {
> +		cbdq->released_extents[data_off / 4096] = 0;
> +		cbdq->channel.data_tail += data_len;
> +		if (cbdq->channel.data_tail >= cbdq->channel.data_size) {
> +			cbdq->channel.data_tail %= cbdq->channel.data_size;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void advance_data_tail(struct cbd_queue *cbdq, u32 data_off, u32 data_len)
> +{
> +	cbdq->released_extents[data_off / 4096] = data_len;
> +
> +	while (__advance_data_tail(cbdq, data_off, data_len)) {
> +		data_off += data_len;
> +		data_len = cbdq->released_extents[data_off / 4096];
> +		if (!data_len) {
> +			break;
> +		}
> +	}
> +}
> +
> +static inline void complete_inflight_req(struct cbd_queue *cbdq, struct cbd_request *cbd_req, int ret)
> +{
> +	u32 data_off, data_len;
> +	bool advance_data = false;
> +
> +	spin_lock(&cbdq->inflight_reqs_lock);
> +	list_del_init(&cbd_req->inflight_reqs_node);
> +	spin_unlock(&cbdq->inflight_reqs_lock);
> +
> +	cbd_se_hdr_flags_set(cbd_req->se, CBD_SE_HDR_DONE);
> +	data_off = cbd_req->data_off;
> +	data_len = cbd_req->data_len;
> +	advance_data = (!cbd_req_nodata(cbd_req));
> +
> +	blk_mq_end_request(cbd_req->req, errno_to_blk_status(ret));
> +
> +	cbd_req_release(cbd_req);
> +
> +	spin_lock(&cbdq->channel.cmdr_lock);
> +	advance_cmd_ring(cbdq);
> +	if (advance_data)
> +		advance_data_tail(cbdq, data_off, round_up(data_len, PAGE_SIZE));
> +	spin_unlock(&cbdq->channel.cmdr_lock);
> +}
> +
> +static struct cbd_request *fetch_inflight_req(struct cbd_queue *cbdq, u64 req_tid)
> +{
> +	struct cbd_request *req;
> +	bool found = false;
> +
> +	list_for_each_entry(req, &cbdq->inflight_reqs, inflight_reqs_node) {
> +		if (req->req_tid == req_tid) {
> +			list_del_init(&req->inflight_reqs_node);
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (found)
> +		return req;
> +
> +	return NULL;
> +}
> +
> +static void copy_data_from_cbdteq(struct cbd_request *cbd_req)
> +{
> +	struct bio *bio = cbd_req->req->bio;
> +	struct cbd_queue *cbdq = cbd_req->cbdq;
> +
> +	cbdc_copy_to_bio(&cbdq->channel, cbd_req->data_off, cbd_req->data_len, bio);
> +
> +	return;
> +}
> +
> +static void complete_work_fn(struct work_struct *work)
> +{
> +	struct cbd_queue *cbdq = container_of(work, struct cbd_queue, complete_work.work);
> +	struct cbd_ce *ce;
> +	struct cbd_request *cbd_req;
> +
> +again:
> +	/* compr_head would be updated by backend handler */
> +	cbdc_flush_ctrl(&cbdq->channel);
> +
> +	spin_lock(&cbdq->channel.compr_lock);
> +	ce = get_complete_entry(cbdq);
> +	if (!ce) {
> +		spin_unlock(&cbdq->channel.compr_lock);
> +		if (cbdwc_need_retry(&cbdq->complete_worker_cfg)) {
> +			goto again;
> +		}
> +
> +		spin_lock(&cbdq->inflight_reqs_lock);
> +		if (list_empty(&cbdq->inflight_reqs)) {
> +			spin_unlock(&cbdq->inflight_reqs_lock);
> +			cbdwc_init(&cbdq->complete_worker_cfg);
> +			return;
> +		}
> +		spin_unlock(&cbdq->inflight_reqs_lock);
> +
> +		cbdwc_miss(&cbdq->complete_worker_cfg);
> +
> +		queue_delayed_work(cbdq->task_wq, &cbdq->complete_work, 0);
> +		return;
> +	}
> +	cbdwc_hit(&cbdq->complete_worker_cfg);
> +	CBDC_UPDATE_COMPR_TAIL(cbdq->channel_info->compr_tail,
> +			       sizeof(struct cbd_ce),
> +			       cbdq->channel_info->compr_size);
> +	cbdc_flush_ctrl(&cbdq->channel);
> +	spin_unlock(&cbdq->channel.compr_lock);
> +
> +	spin_lock(&cbdq->inflight_reqs_lock);
> +	/* flush to ensure the content of ce is uptodate */
> +	cbdt_flush_range(cbdq->cbd_blkdev->cbdt, ce, sizeof(*ce));
> +	cbd_req = fetch_inflight_req(cbdq, ce->priv_data);
> +	spin_unlock(&cbdq->inflight_reqs_lock);
> +	if (!cbd_req) {
> +		goto again;
> +	}
> +
> +	if (req_op(cbd_req->req) == REQ_OP_READ) {
> +		spin_lock(&cbdq->channel.cmdr_lock);
> +		copy_data_from_cbdteq(cbd_req);
> +		spin_unlock(&cbdq->channel.cmdr_lock);
> +	}
> +
> +	complete_inflight_req(cbdq, cbd_req, ce->result);
> +
> +	goto again;
> +}
> +
> +static blk_status_t cbd_queue_rq(struct blk_mq_hw_ctx *hctx,
> +		const struct blk_mq_queue_data *bd)
> +{
> +	struct request *req = bd->rq;
> +	struct cbd_queue *cbdq = hctx->driver_data;
> +	struct cbd_request *cbd_req = blk_mq_rq_to_pdu(bd->rq);
> +
> +	memset(cbd_req, 0, sizeof(struct cbd_request));
> +	INIT_LIST_HEAD(&cbd_req->inflight_reqs_node);
> +
> +	blk_mq_start_request(bd->rq);
> +
> +	switch (req_op(bd->rq)) {
> +	case REQ_OP_FLUSH:
> +		cbd_req_init(cbdq, CBD_OP_FLUSH, req);
> +		break;
> +	case REQ_OP_DISCARD:
> +		cbd_req_init(cbdq, CBD_OP_DISCARD, req);
> +		break;
> +	case REQ_OP_WRITE_ZEROES:
> +		cbd_req_init(cbdq, CBD_OP_WRITE_ZEROS, req);
> +		break;
> +	case REQ_OP_WRITE:
> +		cbd_req_init(cbdq, CBD_OP_WRITE, req);
> +		break;
> +	case REQ_OP_READ:
> +		cbd_req_init(cbdq, CBD_OP_READ, req);
> +		break;
> +	default:
> +		return BLK_STS_IOERR;
> +	}
> +
> +	cbd_queue_fn(cbd_req);
> +
> +	return BLK_STS_OK;
> +}
> +
> +static int cbd_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> +			unsigned int hctx_idx)
> +{
> +	struct cbd_blkdev *cbd_blkdev = driver_data;
> +	struct cbd_queue *cbdq;
> +
> +	cbdq = &cbd_blkdev->queues[hctx_idx];
> +	hctx->driver_data = cbdq;
> +
> +	return 0;
> +}
> +
> +const struct blk_mq_ops cbd_mq_ops = {
> +	.queue_rq	= cbd_queue_rq,
> +	.init_hctx	= cbd_init_hctx,
> +};
> +
> +static int cbd_queue_channel_init(struct cbd_queue *cbdq, u32 channel_id)
> +{
> +	struct cbd_blkdev *cbd_blkdev = cbdq->cbd_blkdev;
> +	struct cbd_transport *cbdt = cbd_blkdev->cbdt;
> +
> +	cbdq->channel_id = channel_id;
> +	cbd_channel_init(&cbdq->channel, cbdt, channel_id);
> +	cbdq->channel_info = cbdq->channel.channel_info;
> +
> +	cbdq->channel.data_head = cbdq->channel.data_tail = 0;
> +
> +	/* Initialise the channel_info of the ring buffer */
> +	cbdq->channel_info->cmdr_off = CBDC_CMDR_OFF;
> +	cbdq->channel_info->cmdr_size = CBDC_CMDR_SIZE;
> +	cbdq->channel_info->compr_off = CBDC_COMPR_OFF;
> +	cbdq->channel_info->compr_size = CBDC_COMPR_SIZE;
> +
> +	cbdq->channel_info->backend_id = cbd_blkdev->backend_id;
> +	cbdq->channel_info->blkdev_id = cbd_blkdev->blkdev_id;
> +	cbdq->channel_info->blkdev_state = cbdc_blkdev_state_running;
> +	cbdq->channel_info->state = cbd_channel_state_running;
> +
> +	cbdc_flush_ctrl(&cbdq->channel);
> +
> +	return 0;
> +}
> +
> +int cbd_queue_start(struct cbd_queue *cbdq)
> +{
> +	struct cbd_transport *cbdt = cbdq->cbd_blkdev->cbdt;
> +	u32 channel_id;
> +	int ret;
> +
> +	ret = cbdt_get_empty_channel_id(cbdt, &channel_id);
> +	if (ret < 0) {
> +		cbdt_err(cbdt, "failed find available channel_id.\n");
> +		goto err;
> +	}
> +
> +	ret = cbd_queue_channel_init(cbdq, channel_id);
> +	if (ret) {
> +		cbd_queue_err(cbdq, "failed to init dev channel_info: %d.", ret);
> +		goto err;
> +	}
> +
> +	INIT_LIST_HEAD(&cbdq->inflight_reqs);
> +	spin_lock_init(&cbdq->inflight_reqs_lock);
> +	cbdq->req_tid = 0;
> +	INIT_DELAYED_WORK(&cbdq->complete_work, complete_work_fn);
> +	cbdwc_init(&cbdq->complete_worker_cfg);
> +
> +	cbdq->released_extents = kmalloc(sizeof(u32) * (CBDC_DATA_SIZE >> PAGE_SHIFT), GFP_KERNEL);

Quick fixup, this would be kzalloc, the fix path is available at branch 
cbd of repo: https://github.com/DataTravelGuide/linux.git


     cbd: fixup: initilize cbdq->released_extents with zeros

     We have to initialize cbdq->released_extents with zeros, that means
     there is no released extents. Otherwise, it will make advance_data_tail
     confusing, and IO would be hang over.

     Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>

diff --git a/drivers/block/cbd/cbd_queue.c b/drivers/block/cbd/cbd_queue.c
index 6709ac016e18..ebde191eb907 100644
--- a/drivers/block/cbd/cbd_queue.c
+++ b/drivers/block/cbd/cbd_queue.c
@@ -576,7 +576,7 @@ int cbd_queue_start(struct cbd_queue *cbdq)
         INIT_DELAYED_WORK(&cbdq->complete_work, complete_work_fn);
         cbdwc_init(&cbdq->complete_worker_cfg);

-       cbdq->released_extents = kmalloc(sizeof(u32) * (CBDC_DATA_SIZE 
 >> PAGE_SHIFT), GFP_KERNEL);
+       cbdq->released_extents = kzalloc(sizeof(u32) * (CBDC_DATA_SIZE 
 >> PAGE_SHIFT), GFP_KERNEL);
         if (!cbdq->released_extents) {
                 ret = -ENOMEM;
                 goto err;
> +	if (!cbdq->released_extents) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	cbdq->task_wq = alloc_workqueue("cbd%d-queue%u",  WQ_UNBOUND | WQ_MEM_RECLAIM,
> +					0, cbdq->cbd_blkdev->mapped_id, cbdq->index);
> +	if (!cbdq->task_wq) {
> +		ret = -ENOMEM;
> +		goto released_extents_free;
> +	}
> +
> +	queue_delayed_work(cbdq->task_wq, &cbdq->complete_work, 0);
> +
> +	atomic_set(&cbdq->state, cbd_queue_state_running);
> +
> +	return 0;
> +
> +released_extents_free:
> +	kfree(cbdq->released_extents);
> +err:
> +	return ret;
> +}
> +
> +void cbd_queue_stop(struct cbd_queue *cbdq)
> +{
> +	if (atomic_cmpxchg(&cbdq->state,
> +			   cbd_queue_state_running,
> +			   cbd_queue_state_none) != cbd_queue_state_running)
> +		return;
> +
> +	cancel_delayed_work_sync(&cbdq->complete_work);
> +	drain_workqueue(cbdq->task_wq);
> +	destroy_workqueue(cbdq->task_wq);
> +
> +	kfree(cbdq->released_extents);
> +	cbdq->channel_info->blkdev_state = cbdc_blkdev_state_none;
> +
> +	cbdc_flush_ctrl(&cbdq->channel);
> +
> +	return;
> +}
> diff --git a/drivers/block/cbd/cbd_transport.c b/drivers/block/cbd/cbd_transport.c
> index 4dd9bf1b5fd5..75b9d34218fc 100644
> --- a/drivers/block/cbd/cbd_transport.c
> +++ b/drivers/block/cbd/cbd_transport.c
> @@ -315,8 +315,19 @@ static ssize_t cbd_adm_store(struct device *dev,
>   	case CBDT_ADM_OP_B_CLEAR:
>   		break;
>   	case CBDT_ADM_OP_DEV_START:
> +		if (opts.blkdev.queues > CBD_QUEUES_MAX) {
> +			cbdt_err(cbdt, "invalid queues = %u, larger than max %u\n",
> +					opts.blkdev.queues, CBD_QUEUES_MAX);
> +			return -EINVAL;
> +		}
> +		ret = cbd_blkdev_start(cbdt, opts.backend_id, opts.blkdev.queues);
> +		if (ret < 0)
> +			return ret;
>   		break;
>   	case CBDT_ADM_OP_DEV_STOP:
> +		ret = cbd_blkdev_stop(cbdt, opts.blkdev.devid);
> +		if (ret < 0)
> +			return ret;
>   		break;
>   	default:
>   		pr_err("invalid op: %d\n", opts.op);
> 

