Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38F875283E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjGMQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGMQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:26:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD471BD5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:26:03 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-785ccd731a7so10954239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689265562; x=1689870362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pt77v8edZ8dsPqoE8IOEob2CDByUrWMtzPxeFhDj+MM=;
        b=ArhpsC+HZuER0kHhyWPL1kcHR3AX48bjJByPrCAvYwhoFsL57cWL4mRAmeFhCbidRQ
         FCOjj3GPstwjkM8JabKNMAUO7NAmQVkXu8gaxcKbAsUGbP9z/1TBh2E7Mpmc2XdRUuxh
         TQhR3rohZBmgA9YG8aXgJ1VcPgDz9IfYEPgEbYz24+XWaN5HEFP1i1fdwmNDLmN3MeKi
         ujiK48FvYufMWZf/IPUaOXLcWfzkPzd1vccMlbR6v3hjY2NLWjqVmEWCOiF4F7iC/7jg
         ca1MqSkqXmSgIkPwMLZfoDh7frazbgvD85XSGC0Jy5CWhUtUxaqBL/pAAZVlRVCZMj+i
         KfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265562; x=1689870362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt77v8edZ8dsPqoE8IOEob2CDByUrWMtzPxeFhDj+MM=;
        b=B6dURvCYye/z/w64wXcHrjP8zDJAuVcArzZuR3qzVJNMrmwW/p6dcJWKifMa+uMSeu
         r1XLxGuVLTF90jIMkS+xbjFPSYmiTPprnxtgxupxEqA/V2Iudr/rnfqfBBqbqZm4NW+l
         OlhdbiS2iFILFbpekIbE8EeChwvc8xu4gqQk21X08HNzPJYl5Utac/KBQjGimkP0A2sp
         GO1gjPN2BQ5vTLGTy9v3mQrsVLUyQb3wf1FxTxEnqsQlm0AhgoYPf5zys2pBGJLu9MI7
         lo+oa58cvIUDlMQJczW/pK+ZPU5AfH/vV79TbmOShTSGi/v17hbVCt6YS+ibva0YR8MN
         12ZQ==
X-Gm-Message-State: ABy/qLbJkT6ap+yKaLYIBo09DCJezbRCos7knJeLIt/REcjk+RnsmrOt
        mTasd450unAVM3NzjB2LlPq4AA==
X-Google-Smtp-Source: APBJJlHG7bAFL9tD2fJxqxqp3bTUhaqcrORWA9M6cspExF0UwxxJUNK1usQwN1q3Zgz5tBKDPLo4XA==
X-Received: by 2002:a6b:8d17:0:b0:783:743c:fd01 with SMTP id p23-20020a6b8d17000000b00783743cfd01mr2166673iod.0.1689265562689;
        Thu, 13 Jul 2023 09:26:02 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o14-20020a02cc2e000000b0042acf389acesm1880077jap.71.2023.07.13.09.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 09:26:02 -0700 (PDT)
Message-ID: <b231ae46-b885-4351-25d5-150c5fa3d6db@kernel.dk>
Date:   Thu, 13 Jul 2023 10:26:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] io_uring: add support for vectored futex waits
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, andres@anarazel.de
References: <20230712162017.391843-1-axboe@kernel.dk>
 <20230712162017.391843-9-axboe@kernel.dk>
 <20230713115412.GI3138667@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230713115412.GI3138667@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 5:54 AM, Peter Zijlstra wrote:
> On Wed, Jul 12, 2023 at 10:20:17AM -0600, Jens Axboe wrote:
>>  int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
>> +int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
>>  int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags);
>> +int io_futex_waitv(struct io_kiocb *req, unsigned int issue_flags);
>>  int io_futex_wake(struct io_kiocb *req, unsigned int issue_flags);
> 
> That's an inconsistent naming convention.. I'll stare at the rest later.

I had to stare at that a bit.. Yes it is, I'll unify that.

-- 
Jens Axboe


