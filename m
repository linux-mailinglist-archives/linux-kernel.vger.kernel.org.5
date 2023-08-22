Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E347837EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjHVC2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjHVC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:28:01 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [IPv6:2001:41d0:203:375::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623C11C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:27:59 -0700 (PDT)
Message-ID: <c9517c34-4481-cba3-99fc-5a287c299416@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692671278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5154UYh/GIJtpDQwuaG3mQw45Rj1ETgmSuyAGLt8a0=;
        b=B4SnZU7smyIWK+QTHYjhW1HGK+FQ8++HHFcQz/WY8bxD26MPb7+bX52nMik+9cJ04mBrIy
        bMfBOkNVW4/9U+ZZW9x6a3PEwx2ApRMJZueGEl2xb+/mi3kF/yetunPbCyyQb1DvYX4T7N
        L7dERMlblJCM8v5YFjlj84KCb96t0Ss=
Date:   Tue, 22 Aug 2023 10:27:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] blk-mq-tag: remove bt_for_each()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        ming.lei@redhat.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
 <20230821073528.3469210-3-chengming.zhou@linux.dev>
 <98296794-01e6-7192-ef3f-0ea454527aaf@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <98296794-01e6-7192-ef3f-0ea454527aaf@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/22 05:26, Bart Van Assche wrote:
> On 8/21/23 00:35, chengming.zhou@linux.dev wrote:
>> 2. __blk_mq_tagset_busy_iter() has BT_TAG_ITER_STARTED flag set, so only
>>     started requests will be iterated, which should be more efficient.
> 
> The above motivation sounds wrong to me. The goal here should be not to
> change the behavior of blk_mq_queue_tag_busy_iter(). Although
> blk_mq_queue_tag_busy_iter() iterates over more requests than only started
> requests, apparently blk_mq_queue_tag_busy_iter() is only used to iterate
> over started requests (blk_mq_request_started()). Please mention this in
> the patch description.
> 

Ok, will do.

Thanks.
