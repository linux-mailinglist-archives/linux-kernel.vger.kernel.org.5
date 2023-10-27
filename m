Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC87D9DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjJ0QGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJ0QGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:06:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38960CE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:06:36 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a950f1451fso26253939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698422795; x=1699027595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPlo4x7yobsVXsYN+X/3Ftss4isqLA61+zu/I1aWQ0U=;
        b=q2Jd8zEC8gPh9qXAhJwpF+7swBvR2VAtYiMdnAEsyULSEHHqaR0DNGpxUwvky5OrHA
         XOaxKZQVWFvvUKIX95fAfrq66Xl0OjgQQBnSG3CGC6D/kTeTuRUKW0LMyX0Fjpc88U4D
         CoikvhzbkJJcCVWyfRmvzlr2RXWzhBSGwErcOl73y62ZTRwYsabjNQGV6PF/nqJc6VTa
         Qz2/7zMoNW4mnZIB8r4mTqWatt+HwrNy0DKEjBHvutnLRCDk6rUmozMbqNaZh1itlpEU
         DzdHmegxAkrcldfG/7jNzeOiyMng3bkyoG3z16GWTSM2S9Yzw1JLEHEYX0dt6S6mdqMH
         3KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698422795; x=1699027595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPlo4x7yobsVXsYN+X/3Ftss4isqLA61+zu/I1aWQ0U=;
        b=AyXZMk+to8P4zEerRnWHiV0yOQQVEBm8KwIfRqMTRBHhBMjsbxzS6EWv6LSnPqcaH8
         JEq4DJsZCvfHRdc3urNUtmr2C/Sqt02+wDYL4BdX+oqPMIuNmAIB8Im254SxXJM9Ts6F
         eIWDur4gptHLfmnwpW3R9fuMbw6nUnV1B2e3J8XhwGfWN/CDhV8VEbI2B+NE+G/0vX3y
         t3psXbbMuDNaNpEjE94wkA/7XHE6mYZMmRkXLgawpKG+xvCPpeXtHKzlnwxMf/HjbScN
         qy+iRuTf4KN5rahAIQH2s+UMutMlLrn3u0ulOmOpher93ZtZEpUMBgUSlnQH0DM1Nzwq
         oABg==
X-Gm-Message-State: AOJu0Yw8a5gP3Ipe31nRHfA8yabwMEQgz4gshFNqQx4kNuykCWgALpMe
        4S5OFWAIQqODdb6lXyPHk02D5feEZARAtkqdFV6xFQ==
X-Google-Smtp-Source: AGHT+IFMFAzxBuhZzCF9WgaG4Oz7Pn4oxAWJujJPgARqocYz2wB6R6DOiPzYZq1+4pIIm8QnLFfmbA==
X-Received: by 2002:a05:6e02:1d1c:b0:358:a6e:71b7 with SMTP id i28-20020a056e021d1c00b003580a6e71b7mr4939454ila.0.1698422795405;
        Fri, 27 Oct 2023 09:06:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l14-20020a056e021c0e00b0034e2572bb50sm567844ilh.13.2023.10.27.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 09:06:34 -0700 (PDT)
Message-ID: <ed3c5450-3dce-4f6a-9a8c-04fcdba1cbf2@kernel.dk>
Date:   Fri, 27 Oct 2023 10:06:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lockdep: holding locks across syscall boundaries
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <a99a7fbe-ec31-4e31-87c7-1b7ae1dd1a5a@kernel.dk>
 <20231027155949.GA26550@noisy.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231027155949.GA26550@noisy.programming.kicks-ass.net>
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

On 10/27/23 9:59 AM, Peter Zijlstra wrote:
> On Fri, Oct 27, 2023 at 09:14:53AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> Normally we'd expect locking state to be clean and consistent across
>> syscall entry and exit, as that is always the case for sync syscalls.
> 
>> We currently have a work-around for holding a lock from aio, see
>> kiocb_start_write(), which pretends to drop the lock from lockdeps
>> perspective, as it's held from submission to until kiocb_end_write() is
>> called at completion time.
> 
> I was not aware of this, the only such hack I knew about was the
> filesystem freezer thing.
> 
> The problem with holding locks past the end of a syscall is that you'll
> nest whatever random lock hierarchies possibly by every other syscall
> under that lock.

Can you expand on that bit, not quite sure I follow. Do we reset the
locking dependencies between syscalls?

>> This is a bit of an ugly work-around, and defeats the purpose of
>> lockdep.
>>
>> Since I've now got another case where I want to hold a resource across
>> syscalls, is there a better way to do this?
>>
>> This is for inode_dio_start(), which increments an inode int count, and
>> inode_dio_end() which decrements it. If a task is doing
>> inode_dio_start() and then inode_dio_wait(), I want to trigger this. I
>> have a hack that does this, but it disables lockdep_sys_exit() as
>> otherwise I just get that warning rather than the more useful one.
> 
> Suppose syscall-a returns with your kiocb thing held, call it lock A
> Suppose syscall-b returns with your inode thing held, call it lock B
> 
> Then userspace does:
> 
> 	syscall-a
> 	syscall-b
> 
> while it also does:
> 
> 	syscall-b
> 	syscall-a
> 
> and we're up a creek, no?

Should this not get caught by the usual lock ordering rules? Because
that is obviously a bug, ordering would have to be consistent, just like
if we have:

	syscall-a
		lock(a);
		lock(b);

	syscall-b
		lock(b);
		lock(a)

-- 
Jens Axboe

