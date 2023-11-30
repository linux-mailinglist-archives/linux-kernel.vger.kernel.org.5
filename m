Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553B7FFF8E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377290AbjK3Xil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377292AbjK3Xij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:38:39 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56310F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:38:44 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b37a2e6314so18488039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701387524; x=1701992324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8VSO3h3YSEqNeVJ9Fi67nw8jeBYbkM3BVJqSu9EWHk=;
        b=DqR0TeckTPH0f/xMcGeWS4IKoZaabx6L4jisrC9MW3J44g1ChAieZOWI8HNHUO2sNU
         ka+h21TdBDLx5ILIEyuke1ohSusAkQYjJ/pegmu3lJlY4l1+n9XCIVE5cEZnrnTvllo6
         qYWtTuYq/3Ie3VHgbpskXgXxWrKWHfyi5gm/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387524; x=1701992324;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8VSO3h3YSEqNeVJ9Fi67nw8jeBYbkM3BVJqSu9EWHk=;
        b=aLE94P6ATH2FfudpEhzhNLhXd1BeEYPJUbJ14uU0EQ6tJYt7jrjCHO9c/5AlGY+FJi
         hreyn+ND/HaEupEl7S3G93UF30fe3G4pQFdZ0gfQjYn850jeRhCj5+4rZ6YhGpY2t1E+
         XIlBrSpjKrgdMUCdJnWAt3Ws3lLmt3J1uL51yzypugXxWzTwNt0WotqG//oLigQOeI/3
         WbQLGn9O7q2iLTmsi3GJ8oUXCpUIi3/jKT57cliZlO+ttIJqN0d3gNFjDYpwdJxL9+A8
         5uOvx5rc/tmUZnIlwa9WIzg2aYxO+3wdkdxRnS8U9sKv+1ukdU3T+VQLpaDLgK5qULef
         r7hA==
X-Gm-Message-State: AOJu0Yxoap6xLx05E5MDUxc1I++hnkZMbtPD5LhPQvQv76Cei1R3K3y8
        rvnl7dLf4H+dcjIcbM7RWUuW/g==
X-Google-Smtp-Source: AGHT+IEYVFgFuCQ9/iSPvBP7ggc5G0uFd8cYcDJdySji0vrzDvhBu7qkO3oqJyFU8Fbgj1HNp1WU4w==
X-Received: by 2002:a6b:6915:0:b0:7b0:aea8:2643 with SMTP id e21-20020a6b6915000000b007b0aea82643mr3960976ioc.1.1701387523699;
        Thu, 30 Nov 2023 15:38:43 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ft18-20020a056638661200b004667eb7fd91sm565078jab.101.2023.11.30.15.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:38:43 -0800 (PST)
Message-ID: <7900802c-3860-4a52-aede-edc544461a57@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 16:38:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: capabilities: namespace create varies for
 root and normal user
Content-Language: en-US
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, luto@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <ZU+xkpH09xjzO5IS@swarup-virtual-machine>
 <20231111173806.16775-1-swarupkotikalapudi@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231111173806.16775-1-swarupkotikalapudi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/23 10:38, Swarup Laxman Kotiaklapudi wrote:
> This patchset fixes TODO:
> "If we're already root, we could skip creating the userns."
> 
> Change namespace creation for root and non-root
> user differently in create_and_enter_ns() function
> in this file:
> tools/testing/selftests/capabilities/test_execve.c
> 
> Test result with root user:
> $sudo make  TARGETS="capabilities" kselftest
>   ...
>   TAP version 13
>   1..1
>   timeout set to 45
>   selftests: capabilities: test_execve
>   TAP version 13
>   1..12
>   [RUN]       +++ Tests with uid == 0 +++
>   [NOTE]      Using global UIDs for tests
>   [RUN]       Root => ep
>   ...
>   ok 12 Passed
>   Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
>   ==================================================
>   TAP version 13
>   1..9
>   [RUN]       +++ Tests with uid != 0 +++
>   [NOTE]      Using global UIDs for tests
>   [RUN]       Non-root => no caps
>   ...
>   ok 9 Passed
>   Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Test result without root or normal user:
> $make  TARGETS="capabilities" kselftest
>   ...
>   timeout set to 45
>   selftests: capabilities: test_execve
>   TAP version 13
>   1..12
>   [RUN]       +++ Tests with uid == 0 +++
>   [NOTE]      Using a user namespace for tests
>   [RUN]       Root => ep
>   validate_cap:: Capabilities after execve were correct
>   ok 1 Passed
>   Check cap_ambient manipulation rules
>   ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
>   ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
>   ok 4 PR_CAP_AMBIENT_RAISE worked
>   ok 5 Basic manipulation appears to work
>   [RUN]       Root +i => eip
>   validate_cap:: Capabilities after execve were correct
>   ok 6 Passed
>   [RUN]       UID 0 +ia => eipa
>   validate_cap:: Capabilities after execve were correct
>   ok 7 Passed
>   ok 8 # SKIP SUID/SGID tests (needs privilege)
>   Planned tests != run tests (12 != 8)
>   Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
>   ==================================================
>   TAP version 13
>   1..9
>   [RUN]       +++ Tests with uid != 0 +++
>   [NOTE]      Using a user namespace for tests
>   [RUN]       Non-root => no caps
>   validate_cap:: Capabilities after execve were correct
>   ok 1 Passed
>   Check cap_ambient manipulation rules
>   ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
>   ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
>   ok 4 PR_CAP_AMBIENT_RAISE worked
>   ok 5 Basic manipulation appears to work
>   [RUN]       Non-root +i => i
>   validate_cap:: Capabilities after execve were correct
>   ok 6 Passed
>   [RUN]       UID 1 +ia => eipa
>   validate_cap:: Capabilities after execve were correct
>   ok 7 Passed
>   ok 8 # SKIP SUID/SGID tests (needs privilege)
>   Planned tests != run tests (9 != 8)
>   Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> ---
> 
> Changes in V2:
>   - Change the commit message explaining
>     why this patchset is needed.
> 

Applied to linux-kselftest next for Linux 6.8-rc1

thanks,
-- Shuah

