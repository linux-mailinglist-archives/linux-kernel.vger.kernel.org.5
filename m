Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6018A809A22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573056AbjLHDQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjLHDQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:16:53 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD52171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:16:58 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce4fe4ed18so204943b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 19:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702005417; x=1702610217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Rux8vsdKkM8nJouugwOO5GuiDS1SIZxc5Vu7ejUgpg=;
        b=kiokj3Cvkjuh6K6kaPMkRewYJfU3w76aX5w5wmeAVRKVmf0fG63b8As81aqJwLS8Ym
         /NU6pPAj7qvc6Y6z+bqUiMdUlNb63WQoULePOTxhnrIzSm3pWwUXUuZ47feGpdANRy6l
         d6Rm0Ahj2pUFGrINR3AJ4gSgcKopIg4zHVw+YSondoXswF1Ghn1Ro7Ay/5apnjwA0iWR
         avJmPk39lMK9S2+rEg5cP659n/hVbyR7phdrDxZAUm7Q/nH5x8YbwR5EDbZNtEXMIvRO
         fjD1db9u7IcdSj3hZxJKAcBmOXrDWE89NO7iSgk6DSN6xrfPkNyPb1v3Z5dyaOAXWzL5
         /x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005417; x=1702610217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Rux8vsdKkM8nJouugwOO5GuiDS1SIZxc5Vu7ejUgpg=;
        b=sbAOULYQtyHI/mlJDzv8vvzLaODNalB2yYt0zJ9t14p52KiPCs1MAqVDYzXnkUBV/0
         4wFJPqNhyjvc0R4IrX2s67ebEvqAeEnjMdCKJQZ/NABjbuplfkNj1rSn7EHaz8A/rJo1
         AsBpOwSj0dXcKPxs1ATzH4jdEY05MxO/q3BmDvCIFX9UQSoXFQQtjblyJA+LhejKNpud
         FOwEIXA0iNTO8TK+gdtHS3swXcPhoSkvibRjshmiushdMbrOSTfs2Rgm7NeW/j11oNLm
         P+PW0ZwUWms4qOdsJWNwT69NvLWCzlQVP4cCSJgqr3+v1S/dsBGScPYxk6d4i7td8iH5
         syug==
X-Gm-Message-State: AOJu0YxXVcoEAH1jt0RiITwD8D6Bc5jAkKJcLJHTosbz1rsHu2yjheL2
        JfBlXzW2QG7lXFGVJJCRVVQflQ==
X-Google-Smtp-Source: AGHT+IG9jHTBY0aV5Yr24U5BQ3/Hg69SHwR+uuZY0ZALqq+TUk7qPMqJeWLxOi0f4Ti5W5yPHBr6Gg==
X-Received: by 2002:a05:6a00:194f:b0:6ce:2de2:fe4d with SMTP id s15-20020a056a00194f00b006ce2de2fe4dmr7543886pfk.1.1702005417512;
        Thu, 07 Dec 2023 19:16:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b006ce5c583c89sm532425pfn.15.2023.12.07.19.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 19:16:56 -0800 (PST)
Message-ID: <c86faa98-937f-42e6-8c05-60112fd95966@kernel.dk>
Date:   Thu, 7 Dec 2023 20:16:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com> <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
 <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 3:58 PM, Christian Brauner wrote:
> [adjusting Cc as that's really a separate topic]
> 
> On Thu, Nov 30, 2023 at 08:43:18PM +0100, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>>
>>>>> I'd like to offer a userspace API which allows safe stashing of
>>>>> unreachable file descriptors on a service thread.
> 
> Fwiw, systemd has a concept called the fdstore:
> 
> https://systemd.io/FILE_DESCRIPTOR_STORE
> 
> "The file descriptor store [...] allows services to upload during
> runtime additional fds to the service manager that it shall keep on its
> behalf. File descriptors are passed back to the service on subsequent
> activations, the same way as any socket activation fds are passed.
> 
> [...]
> 
> The primary use-case of this logic is to permit services to restart
> seamlessly (for example to update them to a newer version), without
> losing execution context, dropping pinned resources, terminating
> established connections or even just momentarily losing connectivity. In
> fact, as the file descriptors can be uploaded freely at any time during
> the service runtime, this can even be used to implement services that
> robustly handle abnormal termination and can recover from that without
> losing pinned resources."
> 
>>
>>>> By "safe" here do you mean not accessible via pidfd_getfd()?
>>
>> No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
>> intra-process transfer using /proc, but I'm hoping for something nicer.
> 
> File descriptors are reachable for all processes/threads that share a
> file descriptor table. Changing that means breaking core userspace
> assumptions about how file descriptors work. That's not going to happen
> as far as I'm concerned.
> 
> We may consider additional security_* hooks in close*() and dup*(). That
> would allow you to utilize Landlock or BPF LSM to prevent file
> descriptors from being closed or duplicated. pidfd_getfd() is already
> blockable via security_file_receive().
> 
> In general, messing with fds in that way is really not a good idea.
> 
> If you need something that awkward, then you should go all the way and
> look at io_uring which basically has a separate fd-like handle called
> "fixed files".
> 
> Fixed file indexes are separate file-descriptor like handles that can
> only be used from io_uring calls but not with the regular system call
> interface.
> 
> IOW, you can refer to a file using an io_uring fixed index. The index to
> use can be chosen by userspace and can't be used with any regular
> fd-based system calls.
> 
> The io_uring fd itself can be made a fixed file itself
> 
> The only thing missing would be to turn an io_uring fixed file back into
> a regular file descriptor. That could probably be done by using
> receive_fd() and then installing that fd back into the caller's file
> descriptor table. But that would require an io_uring patch.

FWIW, since it was very trivial, I posted an rfc/test patch for just
that with a test case. It's here:

https://lore.kernel.org/io-uring/df0e24ff-f3a0-4818-8282-2a4e03b7b5a6@kernel.dk/

-- 
Jens Axboe

