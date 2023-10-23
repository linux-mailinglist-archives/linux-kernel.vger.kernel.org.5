Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D117D2952
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjJWEjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWEjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0961A4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 21:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698035898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+eSKGQ2xN4ZLbjlbyzfe4wcaqVlBtIbGPZ+opB2sEI=;
        b=K4b3HbXUSPKFCbeXpp5gK/XX7oQ9nDpxuw84yWRkqPGfVvNSl2klgbXdP9kL/dhw2fj6Cm
        ge8p/W+rUMM6xhndg6xBD6pDu2btAovg4L28xzUPsqwWI2bRLisXAvhdTPgcUoGecirtN3
        AGLlUn9nuvmq4N6kVo8zkNzHq7slKwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-a26jCd1OMpGLjClclRW9ew-1; Mon, 23 Oct 2023 00:38:14 -0400
X-MC-Unique: a26jCd1OMpGLjClclRW9ew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB33310201E4;
        Mon, 23 Oct 2023 04:38:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D3E91C060AE;
        Mon, 23 Oct 2023 04:38:07 +0000 (UTC)
Date:   Mon, 23 Oct 2023 12:38:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 0/8] blk-mq: improve tag fair sharing
Message-ID: <ZTX4q7QBerKbjzQA@fedora>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yu Kuai,

On Sat, Oct 21, 2023 at 11:47:58PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Current implementation:
>  - a counter active_queues record how many queue/hctx is sharing tags,
>  and it's updated while issue new IO, and cleared in
>  blk_mq_timeout_work().
>  - if active_queues is more than 1, then tags is fair shared to each
>  node;

Can you explain a bit what the problem is in current tag sharing?
And what is your basic approach for this problem?

Just mentioning the implementation is not too helpful for initial
review, cause the problem and approach(correctness) need to be
understood first.

Thanks, 
Ming

