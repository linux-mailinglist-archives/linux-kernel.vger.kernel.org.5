Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3493677FCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353942AbjHQRUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbjHQRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:20:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB7510C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:20:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf1876ef69so42365ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692292820; x=1692897620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEEMLBU7KyGRl1jyNCYxrTksFBbZzFyIftfWwVnH+fI=;
        b=PxIUkR6QCMelRphwb7nNTBBi5xX67tY9gBxIJQneBYD/lufdGIcKBXtI0wXLmhh6yK
         IXKYehGZRpVB06BRWgNaJIme2xyrwWLBp8fwJuXiNGYjgAn2iHxtCvTrrTfFyWf6LoHg
         cNGAJONtBhpceK1CP9h5IuHNaITDgJwoDPGF8hteE3T1gES4G64Z1GvqI2734PqBvGt9
         ycTCi8iTcAvOjfj04kWI6NI7+e6IzqZHU7ZAmvi1vt5e8wul5LM9nvWZDT/wnXM4a0/2
         880w8DBgAwaBq0ukUfdyvtlD3oFooVcxMmIUemt+6E+Kz23Sm4Yai9k+3i1k7NrF036w
         OP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292820; x=1692897620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEEMLBU7KyGRl1jyNCYxrTksFBbZzFyIftfWwVnH+fI=;
        b=jUKjkB1UyaJmUIbZtsgcjhnYP65X3orM2qwFvMY4rvSqjPL/GQf0LkVA7sTqx0Pl/1
         /IP5dcSNetGus2ILs8uH4vyEPavmyMpTxMU8RNfIcZTYoV185tLgakpD7monplC1MNaV
         8yCuhlLgLlYoav/V7LsrqlTn95q1e+YuyjkMwvBODmSnxcw5QeCHWrh45bTHyFXarLbu
         1Y2WD0lajdnvTeBJSa0tGp/dHPzyR/cEhK6/nhbpHouPH/mLdcLAjl08BkjJ96G8HypT
         dZpUf/9c4a5OaXtVh8rplFn1+TbChuNG3PoTgRvsXvDG3KcZmh5jRMXffrK3+s+wXH3f
         FNXA==
X-Gm-Message-State: AOJu0YzGtLdNGlo4JPljgaddMymSq2J/YaXDtzhU/LUYmVns1JY/Vyjw
        tDGnO1/V0opkQRGtAnQdevnNnA==
X-Google-Smtp-Source: AGHT+IHoZ5NKn64ndpHfUzrusz+K6F4l2vMaKDWesViwP5pjrPID8odhdTPKfLUHX0peIYDLzKhc3w==
X-Received: by 2002:a17:903:248:b0:1b8:9215:9163 with SMTP id j8-20020a170903024800b001b892159163mr6305223plh.6.1692292820095;
        Thu, 17 Aug 2023 10:20:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001bc2831e1a9sm24212plx.90.2023.08.17.10.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 10:20:19 -0700 (PDT)
Message-ID: <8c262b00-9856-49fa-b425-da863efdff7d@kernel.dk>
Date:   Thu, 17 Aug 2023 11:20:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Bart Van Assche <bvanassche@acm.org>, hch@lst.de
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, cel@kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <202308172100.8ce4b853-oliver.sang@intel.com>
 <af61c72c-b3ec-ce7a-4f41-bce9a9844baf@acm.org>
 <317715dc-f6e4-1847-5b78-b2d8184b446a@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <317715dc-f6e4-1847-5b78-b2d8184b446a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 9:29 AM, Chengming Zhou wrote:
> On 2023/8/17 22:50, Bart Van Assche wrote:
>> On 8/17/23 07:41, kernel test robot wrote:
>>> [  222.622837][ T2216] statistics for priority 1: i 276 m 0 d 276 c 278
>>> [ 222.629307][ T2216] WARNING: CPU: 0 PID: 2216 at block/mq-deadline.c:680 dd_exit_sched (block/mq-deadline.c:680 (discriminator 3))
>>
>> The above information shows that dd_inserted_request() has been called
>> 276 times and also that dd_finish_request() has been called 278 times.
> 
> Thanks much for your help.
> 
> This patch indeed introduced a regression, postflush requests will be completed
> twice, so here dd_finish_request() is more than dd_inserted_request().
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a8c63bef8ff1..7cd47ffc04ce 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -686,8 +686,10 @@ static void blk_mq_finish_request(struct request *rq)
>  {
>         struct request_queue *q = rq->q;
> 
> -       if (rq->rq_flags & RQF_USE_SCHED)
> +       if (rq->rq_flags & RQF_USE_SCHED) {
>                 q->elevator->type->ops.finish_request(rq);
> +               rq->rq_flags &= ~RQF_USE_SCHED;
> +       }
>  }
> 
> 
> Clear RQF_USE_SCHED flag here should fix this problem, which should be ok
> since finish_request() is the last callback, this flag isn't needed anymore.
> 
> Jens, should I send this diff as another patch or resend updated v3?

I don't think this is the right solution, it makes all kinds of
assumptions on what that flag is and when it's safe to clear it. It's a
very fragile fix, I think we need to do better than that.

-- 
Jens Axboe

