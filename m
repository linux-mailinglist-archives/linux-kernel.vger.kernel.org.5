Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418DC75439F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjGNUQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjGNUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:16:08 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A430F4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:16:07 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-346434c7793so1727085ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689365767; x=1691957767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNY+xxXCfFBcBepVpeHabRtwwd3/Siq6cG/86cKW+SI=;
        b=kzWkkRBAXLZfBLHht0qUeq9+gp/dNNfcXFKYK+80PpFNtC2uKnVcVInc3BjXMHr5Ut
         vPe0LqYPwROZVlJ/Ij85MAC+h5kTkrfNtU32gR6ZBqxgD5vPeBGbIjGrHwK5dFB0d8du
         A6l7Tur/c/KVES85hY4Upq/qdaTUaDNW2nwgxmDAcroqaJeccn1xdQyo4P/FpFfzEHJS
         pRj1EDej2HG1sOcWV16VEOeZY6NzpJEYvt5OKXChVg7PeW9ZN4YYEZnJTPEIBr5ilAEu
         irt1iPDwF0gW0PtoCVNWuq3ugIxuyt0C4R4d1uw8dmc8kU+3LH6TM4IwR4PMcdqgoOON
         u9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689365767; x=1691957767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNY+xxXCfFBcBepVpeHabRtwwd3/Siq6cG/86cKW+SI=;
        b=gajquEQ9/RnpqGmp/nne5hqc3fOVEl06LGpnKAKVlUFRrtEbsjvuTIf0Wp2UsBk1LZ
         B622Hx3LlVm+q5FEz9g7Ge6Tm6XnCxEx4yNHUIgQOuDY0u0A9EBLnP3PHs30Cfv1ACI7
         kO0ZA41TL95nJwJY3zQDjl2BVjib0lkxKyoSmHPM3sW2ssLvs5wWuCEEaT4XhjiXD/Lr
         c3zrPX8Y1nf0UpanjsuQ7HBDWhT8hiuxcIU0R+Va7RXG41qcYfYgB1Aj9kHmM4CoQO4P
         FfoJbYnyy8KiZGrVkeqbVgFtxd1FR+7Sgd/kI1iTYTifcpRlVmv/Ev7ufkXqaB2C1Q0E
         mqEg==
X-Gm-Message-State: ABy/qLZbsR+wYEAm88L6VylV/qHwqD+sOA3Fa6cl5GLxdYLUSKZSQKNs
        7c1dxJmYQC+FDD/lDnuE9Qrp0kVm4k6LJlrO+lg=
X-Google-Smtp-Source: APBJJlHPiCVoXM10XSAJ8CXoM5kiLik0Eoib9ubiQ7teTIg2vx2E4Jcd/SwHJRBrlwDvcfp35opSNg==
X-Received: by 2002:a05:6602:4a07:b0:780:cde6:3e22 with SMTP id eh7-20020a0566024a0700b00780cde63e22mr206280iob.0.1689365767348;
        Fri, 14 Jul 2023 13:16:07 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g6-20020a056638060600b0042b599b224bsm2889933jar.121.2023.07.14.13.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 13:16:06 -0700 (PDT)
Message-ID: <fbdea234-b8cf-7ac7-7c26-b593cb7f5427@kernel.dk>
Date:   Fri, 14 Jul 2023 14:16:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] exit: add internal include file with helpers
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
References: <20230711204352.214086-1-axboe@kernel.dk>
 <20230711204352.214086-5-axboe@kernel.dk>
 <20230714-lachen-gelassen-716cd90a9a0c@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230714-lachen-gelassen-716cd90a9a0c@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 9:38?AM, Christian Brauner wrote:
>> diff --git a/kernel/exit.h b/kernel/exit.h
>> new file mode 100644
>> index 000000000000..f10207ba1341
>> --- /dev/null
>> +++ b/kernel/exit.h
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#ifndef LINUX_WAITID_H
>> +#define LINUX_WAITID_H
>> +
>> +struct waitid_info {
>> +	pid_t pid;
>> +	uid_t uid;
>> +	int status;
>> +	int cause;
>> +};
>> +
>> +struct wait_opts {
>> +	enum pid_type		wo_type;
>> +	int			wo_flags;
>> +	struct pid		*wo_pid;
>> +
>> +	struct waitid_info	*wo_info;
>> +	int			wo_stat;
>> +	struct rusage		*wo_rusage;
>> +
>> +	wait_queue_entry_t		child_wait;
>> +	int			notask_error;
>> +};
>> +
>> +bool pid_child_should_wake(struct wait_opts *wo, struct task_struct *p);
>> +long __do_wait(struct wait_opts *wo);
>> +int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
>> +			  struct waitid_info *infop, int options,
>> +			  struct rusage *ru, unsigned int *f_flags);
> 
> I know this isn't your mess obviously but could you try and see whether
> you can expose a nicer, dedicated struct and helper suited to io_uring's
> needs instead of exposing the messy kernel/exit.c format?

From a quick look, I think the wait_opts is pretty much what we need,
not much to cut from that. For waitid_info, we can make do with just a
forward declaration, we don't need the whole thing.

-- 
Jens Axboe

