Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3475CA67
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGUOny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGUOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:43:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A52D7B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:43:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so26771639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689950630; x=1690555430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGagDaV4SNGT+G9QzKe3AoeV3zePvRGigYH1wE4qBpg=;
        b=rNyPGkL0cldwJzahvsfPlhOETt7OO2/r2GDIJHOICXK+fhO2BslCOLNzD3PjTcCYfQ
         9ZEdrqpnWoCqYCfPBvWpqOx5naImNzxifRUd4tJHn+FEunZDkvAVdOhbLLeYVbaYDZ42
         s7WwLkzb00kY6cIMFJEnYYesyMP0ZLGxDM6SvpyyjpfI6mMJM2lrRC6AgpuyrIEXMwCq
         g4QKt/OqAs/aZ29sMtPSajpTl1Dg7g+uoR1v1vDlIPX94F2l4TJ4wYJegwuILOvBYWV9
         1hpDn1EZudVvvmMjAfXG9RDmLSKj5EKQVgu0nI5jgYFDCFJGI/kmTbwGUI9Kxe7vzL/O
         a3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950630; x=1690555430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGagDaV4SNGT+G9QzKe3AoeV3zePvRGigYH1wE4qBpg=;
        b=X9rFy8md//r7cTaoA7d4JBPIj3Qv8dBVOYXsDCfoK93hdSKmO2Wzrv1w3ZPlevVjqe
         CosKcEUVstFV7wGub5suvewrkafhQ1Z+wD6oJejihCgSU8V9kQtI5TElDvnxW5q5/2QC
         hfOChgxvA6JOSaps3c9KqfFmu1UW50BqXLP+yrTgo7Alpsj65gQOws5xkici5ERAN0aX
         wungk3+g+CFUkVwSr42Ka1X5Gzc2TIGd5aPkzw2J8a2TiiMzo+EQpu0nCctYrJkk2COb
         hsoykmYQv33Ez/3kgAEA+S+lywN7SJ6YAJnCzRFtXjXXpoSHRJKJ0m+BkvVIaQMo8JmO
         Swgg==
X-Gm-Message-State: ABy/qLYNUq/1Ua9sD25bHwcpcBDnviVg5hkvukT1QJ7W8di8XsSnLn8B
        y1avBISkwbcohMqckCov8Yk6Mwq+HB4u8wsXwwg=
X-Google-Smtp-Source: APBJJlFg1lZKeS5s9FBguKfMTQwnZSZ0mEoi+qTZJmM6twjyGAQdlNnKzAxD5+hNeosbtw0Z5b2iNw==
X-Received: by 2002:a05:6602:480b:b0:780:d6ef:160 with SMTP id ed11-20020a056602480b00b00780d6ef0160mr2212021iob.1.1689950630361;
        Fri, 21 Jul 2023 07:43:50 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e5-20020a02a505000000b0042bc199556dsm1087959jam.21.2023.07.21.07.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:43:49 -0700 (PDT)
Message-ID: <d95bfb98-8d76-f0fd-6283-efc01d0cc015@kernel.dk>
Date:   Fri, 21 Jul 2023 08:43:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/10] io_uring: add support for futex wake and wait
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        andres@anarazel.de
References: <20230720221858.135240-1-axboe@kernel.dk>
 <20230720221858.135240-7-axboe@kernel.dk>
 <20230721113031.GG3630545@hirez.programming.kicks-ass.net>
 <20230721113718.GA3638458@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230721113718.GA3638458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 5:37?AM, Peter Zijlstra wrote:
> On Fri, Jul 21, 2023 at 01:30:31PM +0200, Peter Zijlstra wrote:
> 
> Sorry, I was too quick..
> 
> 	iof->uaddr = sqe->addr;
> 	iof->val   = sqe->futex_val;
> 	iof->mask  = sqe->futex_mask;
> 	flags      = sqe->futex_flags;
> 
> 	if (flags & ~FUTEX2_MASK)
> 		return -EINVAL;
> 
> 	iof->flags = futex2_to_flags(flags);
> 	if (!futex_flags_valid(iof->flags))
> 		return -EINVAL;
> 
> 	if (!futex_validate_input(iof->flags, iof->val) ||
> 	    !futex_validate_input(iof->flags, iof->mask))
> 		return -EINVAL

Something like that should work, with some variable names fixed up. I
just went with 'addr' for the futex address, addr2 for the value, and
addr3 for the mask.

Rebased on top of your first 4 updated patches, and added a single patch
that moves FUTEX2_MASK, will run some testing to validate it's all still
sane.

-- 
Jens Axboe

