Return-Path: <linux-kernel+bounces-47846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144B8453A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767281C23560
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8415B11E;
	Thu,  1 Feb 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="OsxhNkrA"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6915B0FC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779105; cv=none; b=N9wMdU9fvvhv+KaSEqf9vsIoUzuv13Hjq7TXVUh+x62TWHm4HD5vljR5xRdWJnrxBWUltgWKMTNU5Gseifsh62wWY/0hTM+jaHcyYzGLr+ec2OhG3NPErvlkrxbuNI91ylJjM8L2q2ARfKaYdAJ+OlKRiyNramhpybVCJ+t0F44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779105; c=relaxed/simple;
	bh=EUZRmjznJf7uktMI/AJN2/RLF765JhNXs89YkHS9eMg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq3uCGCPpuc5ELhzF1MpRHDNJuimayfXPFmUN4q/MPgsjrlxAFgUZuPp7a+q8vxG2COzbd6J+JelmqZFIkLW10Mx63wIcsm4+HKWhdrZgW49+OuHKRylEF0I8IwAg+PQc2jQIldnD5vPyyId1DtYquCAG5YzhDYFXfMjV11Te/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=OsxhNkrA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33aef64f702so380464f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1706779102; x=1707383902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEttoquMBORN6X4KLOQ1HnCQdxX+dcoYjDqA+Xsf5nc=;
        b=OsxhNkrAPaquHCZXomgs2+pubinWwh0TGKkUgddUbpQu0pCzJQ7jYsdBIYpbLugWrX
         HToXkdw70u8bk2nZz3DIIvjIFiHw0VOy7P3Cg6btxKTONB/Qz72qysfg+FqgmelufQ7b
         Dg4IHD0GBkXJG6TWzoU+83aay3E7h8rVxwSPxRaOulhdwIy+UFljOfRDT7QDEbWZAdBx
         3AeSxVcaSg3Nt0yYYuEOp4c8pmKnsnGWvyyPM3tBZCgKXEzr8qK8TIhFwU196KTVKpcL
         yj2/aOGmjsUpsvmyRSAG5d7ruT1OpGmUHRIdWZGi/9RWnTeuwpBMFHBb56T2+LLL78yf
         9AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779102; x=1707383902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEttoquMBORN6X4KLOQ1HnCQdxX+dcoYjDqA+Xsf5nc=;
        b=AKRl7ElallIttk3Zx3njU4xaw6wcdUrmMrSwvWgUiaCtAdNuRyWZEbG2Ns8PX6hBGr
         ALqOKaZ6jvOe6NHJXf4y5d7tV3TMRFLbUIXlzKZewmfVObe62gNdq4PCI3BMsJyR8fAW
         zgLWlh3N3vJ/38NiU+MWyHk8mHrwkshT8CAG/O1IIbpmfiBHDDuTr1Z846QyQdqheMD+
         h03YebwlU3ypB6a88dRcyP183PgCkGnNP0t/c63LzsY9O0mcB+s6N12ksdWdENhVg2ps
         Dp/weChaiD7hXQoHdgpr0JqM2cxbOpNBXsrCBqxth/3KFH54ztFT2lxb33EtreQWV4BJ
         pbmA==
X-Gm-Message-State: AOJu0YweV0NnkdRx3uJfETIa2BSqfz8dbh9c/RXLvFGGjt+T8xgPH3uR
	kEFs8Ad2e7Eprv+Xa5ACRa6jfwJPRKL9nctVPr6fypzh1jYEXv2qyVxHcn7XkaE=
X-Google-Smtp-Source: AGHT+IFw0DWUiLl1tUNyCJGEwA2LpJkInZ/B4JMmhUPc0OouAkt0uWSIO4LwhnVDdGlYTg0JFS7jCg==
X-Received: by 2002:a5d:6d81:0:b0:337:c454:81a8 with SMTP id l1-20020a5d6d81000000b00337c45481a8mr3592889wrs.55.1706779101761;
        Thu, 01 Feb 2024 01:18:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXvXSGM7vfyq7dVsZqNQAi+DQTXyi5a2+5UOOqH/FR0pFGD5OcMIve6BCeRx+vtvwVlFi2/Z08uRVDT/eXfGpwv29BmEfMB96wMKavFc6X+ljsDL20gPzY3fvZ4xszPqCQ+qbG63YKPVgm4dvnKr4MkN8emoXaJWoi8jp1jqu8OxSUlEinLpV5diAqVGy2HsnTFcHnxOqix3Ir7aug6YM4OilsJ2GcAvOQCWsfBj+UvbUecAeXptoWYs0NuViiYO81D6LF7m5D7EaE5YI3ZLYwI6al/hSPcYDl5L4kuUuuFQeOR6sjYVNNQuzJfbStsx5LwuW5kx+w0y/LYJhR+rjAa4uFM2Yle3EWRnpkjO3C9GabtE/Mjy9IgwVShJT0tf9rpVl4OhF87jTBEvtgf1wQ2prwhVG174R8dZ2x2c9eMBD1aLM8nmYsj2m/+x6sEpz9mqBSuBmHH6hlDp55PSkYp5CJodYREiZoMxVeGAmlB/xgY+d1Ig5YQT9A=
Received: from trax (8.red-79-144-185.dynamicip.rima-tde.net. [79.144.185.8])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d66c5000000b0033b1549a400sm963197wrw.95.2024.02.01.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:18:21 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Thu, 1 Feb 2024 10:18:19 +0100
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v2 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Message-ID: <Zbth2wZ+TtGuCJux@trax>
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-3-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131174347.510961-3-jens.wiklander@linaro.org>

On 31/01/24 18:43:46, Jens Wiklander wrote:
> Register eMMC RPMB partition with the RPMB subsystem and provide
> an implementation for the RPMB access operations abstracting
> the actual multi step process.
>
> Add callbacks for getting and putting the needed resources, that is, the
> RPMB data and the RPMB disk.
>
> Add a callback to extract the needed device information at registration
> to avoid accessing the struct mmc_card at a later stage as we're not
> holding a reference counter for this struct.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/mmc/core/block.c | 177 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..5286e0b3a5a2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -33,6 +33,7 @@
>  #include <linux/cdev.h>
>  #include <linux/mutex.h>
>  #include <linux/scatterlist.h>
> +#include <linux/string.h>
>  #include <linux/string_helpers.h>
>  #include <linux/delay.h>
>  #include <linux/capability.h>
> @@ -40,6 +41,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/idr.h>
>  #include <linux/debugfs.h>
> +#include <linux/rpmb.h>
>
>  #include <linux/mmc/ioctl.h>
>  #include <linux/mmc/card.h>
> @@ -163,6 +165,7 @@ struct mmc_rpmb_data {
>  	int id;
>  	unsigned int part_index;
>  	struct mmc_blk_data *md;
> +	struct rpmb_dev *rdev;
>  	struct list_head node;
>  };
>
> @@ -2707,6 +2710,169 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
>  	kfree(rpmb);
>  }
>
> +static void rpmb_op_mmc_get_resources(struct device *dev)
> +{
> +	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> +
> +	/*
> +	 * When the MMC card is removed rpmb_dev_unregister() is called
> +	 * from mmc_blk_remove_rpmb_part(). That removes references to the
> +	 * devices in struct mmc_rpmb_data and rpmb->md. Since struct
> +	 * rpmb_dev can still reach those structs we must hold a reference
> +	 * until struct rpmb_dev also is released.
> +	 *
> +	 * This is analogous to what's done in mmc_rpmb_chrdev_open() and
> +	 * mmc_rpmb_chrdev_release() below.
> +	 */
> +	get_device(dev);
> +	mmc_blk_get(rpmb->md->disk);
> +}
> +
> +static void rpmb_op_mmc_put_resources(struct device *dev)
> +{
> +	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> +
> +	mmc_blk_put(rpmb->md);
> +	put_device(dev);
> +}
> +
> +static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
> +					     unsigned int cmd_count)
> +{
> +	struct mmc_blk_ioc_data **idata;
> +	unsigned int n;
> +
> +	idata = kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
> +	if (!idata)
> +		return NULL;
> +
> +	for (n = 0; n < cmd_count; n++) {
> +		idata[n] = kcalloc(1, sizeof(**idata), GFP_KERNEL);
> +		if (!idata[n]) {
> +			kfree(idata);

don't you need to unwind these allocations on error?

> +			return NULL;
> +		}
> +		idata[n]->rpmb = rpmb;
> +	}
> +
> +	return idata;
> +}
> +
> +static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
> +		      int write_flag, u8 *buf, unsigned int buf_bytes)
> +{
> +	idata->ic.opcode = opcode;
> +	idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +	idata->ic.write_flag = write_flag;
> +	idata->ic.blksz = sizeof(struct rpmb_frame);
> +	idata->ic.blocks = buf_bytes /  idata->ic.blksz;
> +	idata->buf = buf;
> +	idata->buf_bytes = buf_bytes;
> +}
> +
> +static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_count)
> +{
> +	unsigned int n;
> +
> +	for (n = 0; n < cmd_count; n++)
> +		kfree(idata[n]);
> +	kfree(idata);
> +}
> +
> +static int rpmb_op_mmc_route_frames(struct device *dev, bool write, u8 *req,
> +				    unsigned int req_len, u8 *resp,
> +				    unsigned int resp_len)
> +{
> +	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> +	struct mmc_blk_data *md = rpmb->md;
> +	struct mmc_blk_ioc_data **idata;
> +	unsigned int cmd_count;
> +	struct request *rq;
> +	int ret;
> +
> +	if (write)
> +		cmd_count = 3;
> +	else
> +		cmd_count = 2;
> +
> +	if (IS_ERR(md->queue.card))
> +		return PTR_ERR(md->queue.card);
> +
> +	idata = alloc_idata(rpmb, cmd_count);
> +	if (!idata)
> +		return -ENOMEM;
> +
> +	if (write) {
> +		struct rpmb_frame *frm = (struct rpmb_frame *)resp;
> +
> +		/* Send write request frame(s) */
> +		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
> +			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
> +
> +		/* Send result request frame */
> +		memset(frm, 0, sizeof(*frm));
> +		frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
> +		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
> +			  resp_len);
> +
> +		/* Read response frame */
> +		set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
> +	} else {
> +		/* Send write request frame(s) */
> +		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req, req_len);
> +
> +		/* Read response frame */
> +		set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
> +	}
> +
> +	rq = blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT, 0);
> +	if (IS_ERR(rq)) {
> +		ret = PTR_ERR(rq);
> +		goto out;
> +	}
> +
> +	req_to_mmc_queue_req(rq)->drv_op = MMC_DRV_OP_IOCTL_RPMB;
> +	req_to_mmc_queue_req(rq)->drv_op_result = -EIO;
> +	req_to_mmc_queue_req(rq)->drv_op_data = idata;
> +	req_to_mmc_queue_req(rq)->ioc_count = cmd_count;
> +	blk_execute_rq(rq, false);
> +	ret = req_to_mmc_queue_req(rq)->drv_op_result;
> +
> +	blk_mq_free_request(rq);
> +
> +out:
> +	free_idata(idata, cmd_count);
> +	return ret;
> +}
> +
> +static int rpmb_op_mmc_set_dev_info(struct device *dev, struct rpmb_dev *rdev)
> +{
> +	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
> +	struct mmc_card *card = rpmb->md->queue.card;
> +	unsigned int n;
> +	u32 cid[4];
> +
> +	for (n = 0; n < 4; n++)
> +		cid[n] = be32_to_cpu(card->raw_cid[n]);
> +
> +	rdev->dev_id = kmemdup(cid, sizeof(cid), GFP_KERNEL);
> +	if (!rdev->dev_id)
> +		return -ENOMEM;
> +	rdev->dev_id_len = sizeof(cid);
> +	rdev->reliable_wr_count = card->ext_csd.raw_rpmb_size_mult;
> +	rdev->capacity = card->ext_csd.rel_sectors;
> +
> +	return 0;
> +}
> +
> +static struct rpmb_ops rpmb_mmc_ops = {
> +	.type = RPMB_TYPE_EMMC,
> +	.get_resources = rpmb_op_mmc_get_resources,
> +	.put_resources = rpmb_op_mmc_put_resources,
> +	.route_frames = rpmb_op_mmc_route_frames,
> +	.set_dev_info = rpmb_op_mmc_set_dev_info,
> +};
> +
>  static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  				   struct mmc_blk_data *md,
>  				   unsigned int part_index,
> @@ -2751,6 +2917,14 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  		goto out_put_device;
>  	}
>
> +	rpmb->rdev = rpmb_dev_register(&rpmb->dev, &rpmb_mmc_ops);
> +	if (IS_ERR(rpmb->rdev)) {
> +		pr_err("%s: could not register RPMB device\n", rpmb_name);
> +		ret = PTR_ERR(rpmb->rdev);
> +		rpmb->rdev = NULL;
> +		goto out_cdev_device_del;
> +	}
> +
>  	list_add(&rpmb->node, &md->rpmbs);
>
>  	string_get_size((u64)size, 512, STRING_UNITS_2,
> @@ -2762,6 +2936,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>
>  	return 0;
>
> +out_cdev_device_del:
> +	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
>  out_put_device:
>  	put_device(&rpmb->dev);
>  	return ret;
> @@ -2770,6 +2946,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>  static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
>
>  {
> +	rpmb_dev_unregister(rpmb->rdev);
>  	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
>  	put_device(&rpmb->dev);
>  }
> --
> 2.34.1
>

