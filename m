Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8886777A6A3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHMNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjHMNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:54:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3011716
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:54:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdb3ecd20dso3592965ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691934865; x=1692539665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dU6/+ajCfl+HJb4TanoGPdQM8ZbXmY5z+s2kh4N2lE=;
        b=JLEU9lPfpAY8v3XOsxGYV+0ASZQgo/5K2xyMERHS+AXxxaN1vuvWVQ5t84dOi5NLqN
         ehezBD3mLumL0IMJnL7N/XRphRm7O0a/vpDHxTXgBvyopsEUg520wl/HWuowzkdAWiCr
         dBmxlBuzpi1TrdPD2eDIymqVGczs9OCdAitmGlrKfx3Q3v3Vo9148G7gB/kFsettecf8
         facJVMcqPCNeu35l8sz/pXf9K+uR33iiF0f1e/xxQcerQxOXgMriwO72uQQuNq0o4PcZ
         9IHOdvyT9rOb22BlVEhcK/XOf2/6ELNHkwgZomSL591vDq39h48+XykqaR4JTNTI58HD
         y0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691934865; x=1692539665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dU6/+ajCfl+HJb4TanoGPdQM8ZbXmY5z+s2kh4N2lE=;
        b=NVhPe0wUrpa4xqJX/TmH3doQL/jC2KXuHenQlys+1CHze7dFUKiVXu0gAip5VrGO7Q
         slmYqRXP3OWcHJdDqhJagf9Yc0RQvn8RfyrsaVh8wFcIMqIbW1GL7uSqSLQZ6KyW/J86
         dLgy42Z/2RU4z2Wveig5xMWl9oj2cxpmUpwDdypl0Gnj/0VBXD32aFh7yV2iWHvI6IR9
         XbUhJ5qE47eYnVpMBPzx4NoDAlPtrwxqzxWa576F+O934R+Ax7NjgRYrbaZqMJBqEbTn
         VZ1rZmckTRidINPKJwMLxh4jKhXsm1JceX+fWVIF1emkdVijHOWtCixqLiaAPv/c/mim
         /4TA==
X-Gm-Message-State: AOJu0YyQHWxVOQ/nr0ePgijOWujDsvOLdIZoVlGc6YKRYFIodXBGXDAf
        X+HpPFcERFsa6m/s0z/6j0ZR3g==
X-Google-Smtp-Source: AGHT+IEkKGC7ztuPN1JHBeVvFDDO6nxKY0m4JZuKBYDI96sPU0tSpN0w22cNzXwZ/PRltfJC0kIYIg==
X-Received: by 2002:a17:902:d4ce:b0:1b1:9272:55e2 with SMTP id o14-20020a170902d4ce00b001b1927255e2mr8844072plg.3.1691934865433;
        Sun, 13 Aug 2023 06:54:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bg3-20020a1709028e8300b001b6a27dff99sm7417242plb.159.2023.08.13.06.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:54:24 -0700 (PDT)
Message-ID: <4fcddc26-4f51-4228-9a35-58dc1b5a16bc@kernel.dk>
Date:   Sun, 13 Aug 2023 07:54:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: release scheduler resource when request complete
Content-Language: en-US
To:     chengming.zhou@linux.dev, hch@lst.de, chuck.lever@oracle.com
Cc:     bvanassche@acm.org, cel@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230813133643.3006943-1-chengming.zhou@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230813133643.3006943-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 7:36 AM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Chuck reported [1] a IO hang problem on NFS exports that reside on SATA
> devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
> submission path for post-flush requests").
> 
> We analysed the IO hang problem, found there are two postflush requests
> are waiting for each other.
> 
> The first postflush request completed the REQ_FSEQ_DATA sequence, so go to
> the REQ_FSEQ_POSTFLUSH sequence and added in the flush pending list, but
> failed to blk_kick_flush() because of the second postflush request which
> is inflight waiting in scheduler queue.
> 
> The second postflush waiting in scheduler queue can't be dispatched because
> the first postflush hasn't released scheduler resource even though it has
> completed by itself.
> 
> Fix it by releasing scheduler resource when the first postflush request
> completed, so the second postflush can be dispatched and completed, then
> make blk_kick_flush() succeed.

Change looks good to me. But since we're in here:

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f14b8669ac69..5b14f18f9670 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -682,6 +682,15 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
>  
> +static void blk_mq_finish_request(struct request *rq)
> +{
> +	struct request_queue *q = rq->q;
> +
> +	if ((rq->rq_flags & RQF_USE_SCHED) &&
> +	    q->elevator->type->ops.finish_request)
> +		q->elevator->type->ops.finish_request(rq);
> +}

Any IO scheduler should set ->finish_request(), so this should just be:

static void blk_mq_finish_request(struct request *rq)
{
	struct request_queue *q = rq->q;

	if (rq->rq_flags & RQF_USE_SCHED)
		q->elevator->type->ops.finish_request(rq);
}

and would probably be a good idea to solidify that with a:

	if (WARN_ON_ONCE(!e->ops.finish_request))
		return -EINVAL;

at the top of elv_register() like we have for insert/dispatch as well.
All 3 IO schedulers do set ->finish_request().

-- 
Jens Axboe

