Return-Path: <linux-kernel+bounces-11083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD12981E11B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13F72823A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C8524C9;
	Mon, 25 Dec 2023 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De5DCPHi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FA524C6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703514062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A0EmpWvfAdSPJE8+m/XWO8c/I1sa1OMFa170YYbDYsc=;
	b=De5DCPHizJ2efEu6XMai9SQWkK3r//Ao2J/JTl8JPx7vDmXcUWnvyRPQz1BQjxcYOB3fP4
	tWDWTpINys4LCVukYq/bZ0WCbXpK4l871EACSZdxHzG1yA2qeBa+eOBAg818DY20YdEYz9
	0PGXu9U2LgzwLwZSfji+G1m2MnCo1EU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-Yela1zh-P_WqrPBMPp2Sdw-1; Mon, 25 Dec 2023 09:21:00 -0500
X-MC-Unique: Yela1zh-P_WqrPBMPp2Sdw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d42061a35so32638845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703514059; x=1704118859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0EmpWvfAdSPJE8+m/XWO8c/I1sa1OMFa170YYbDYsc=;
        b=nxXJ9Rn71gtB6R4ebM7AnyeZqdbL1gX/JqGnd47yAaJT6DkHRjs1VWdFr5VayVGKY6
         HhmISH6lY8oBxt22VvoRsY307iCDfVKgKMqghRsbIEFYbkAX0B2ANzCCeCG1PucBJZmj
         KeBGFdwZ9T7TX3nKoKFmRc7FkcxJXsnkDJ3BZsvwALtrtMhM3JIO4Ddn32zC9kpRFe1m
         HmGSFhzSQ9kyA9I9UzcmRx9xb16J82EIT529ZycEaAtlZEIsLFJJD7S3cFK+YSaLbAQy
         KSRjQnuURZ7RZ314dzXchdB5W8AjDmxbNBWi8o5G+8J9/cHXdVxQQ+SlVcuaf5tcrxnb
         RNTA==
X-Gm-Message-State: AOJu0Ywyb04T0/K3xDajMoNAm8XutxRBA+9QeBHTG2wv6OVfPipcPhNH
	UZrHVmZdnN6sWWHdrKnF0mR4Z/Spgu/vSfR1tFF5GiLbCnWHBK4FmsBcMrT6J/yoUi76KDkXIks
	Dvt8lMzuFolUsPTSKnJRMi8SAHQJ5x02G
X-Received: by 2002:a05:600c:1f18:b0:40d:5691:c79b with SMTP id bd24-20020a05600c1f1800b0040d5691c79bmr665882wmb.161.1703514059716;
        Mon, 25 Dec 2023 06:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE8e5P/wgQQYi0Z/keqL4AEB+Av4CdVoK8jSIR0wDYo70sScwXW6JKxyKYm5R3s7NwLZBf7A==
X-Received: by 2002:a05:600c:1f18:b0:40d:5691:c79b with SMTP id bd24-20020a05600c1f1800b0040d5691c79bmr665876wmb.161.1703514059325;
        Mon, 25 Dec 2023 06:20:59 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm25205840wmo.19.2023.12.25.06.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 06:20:58 -0800 (PST)
Date: Mon, 25 Dec 2023 09:20:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231225092010-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>

On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> virtio-blk is generally used in cloud computing scenarios, where the
> performance of virtual disks is very important. The mq-deadline scheduler
> has a big performance drop compared to none with single queue. In my tests,
> mq-deadline 4k readread iops were 270k compared to 450k for none. So here
> the default scheduler of virtio-blk is set to "none".
> 
> Signed-off-by: Li Feng <fengli@smartx.com>

I dropped this for now, pls try to address comments by Christoph/Paolo
if it's still needed

> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index d53d6aa8ee69..5183ec8e00be 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.ops = &virtio_mq_ops;
>  	vblk->tag_set.queue_depth = queue_depth;
>  	vblk->tag_set.numa_node = NUMA_NO_NODE;
> -	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
>  		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> -- 
> 2.42.0


