Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF275DF99
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 03:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGWBxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 21:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWBxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 21:53:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7A10C3;
        Sat, 22 Jul 2023 18:53:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9d80e33fbso18552475ad.0;
        Sat, 22 Jul 2023 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690077187; x=1690681987;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKZZooP5Tqb4FSRzariy9hdj9iiKxz8JJHswoxOWIJo=;
        b=aJZxi+myzcWLazBvQmBwM4+rEIXCWJ0ad8nAcxsEQw/sDyrFRFj5YXeiIWW1mILAcn
         9GWqDXVYzlSztPG9FHrXsESBqVOvgIbqEAVWJMnTeMGAoDWscsMukBzdeWcVud5v3lII
         7K/xdj5E/ldMb522arABX+M+KvmTGT5Q3mwJ2YS2yd+koNP/DutC9xYLcZGcyJoOqjiD
         GppRH3xsdJSeKLoLvpGxQZjP3jQD8QFKRds9PD5EZTTp+yEo+3v58+QFK404BZuDIbQS
         1FRenYl7wWDnXxqqAA5ZBh0b8ZikxnSlBMMr6gtT93gN69ZfZsUh35mQ5MWZoSFnLXhG
         RDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690077187; x=1690681987;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IKZZooP5Tqb4FSRzariy9hdj9iiKxz8JJHswoxOWIJo=;
        b=JRqgWhB9u+033OmaykTvzu/HSbSE+L9x9GYoEB+mB3mCCRgGNrlwwFg+Ebmc+ZGsTQ
         pvP7a0P/Q6eyrNlI+rCAoY/yuywnDdG9IwI6hwWHtlUGu6B0QnA28R1rp7ltJKbC7o6G
         EMyMDUeMNZv7iFlG3tnBEkcrjAIdyYo0zFmYOjwRgLXgQpCNDzqcgmurHB0V4eD6YcrF
         p86F0Y9q1C0yqXk9OrzXyRDISc+eY5Q6MMBykWfG+VHtBkduz3bh89vJChls8HkKs0lA
         LwrCxhAzhYVuOFLYiH07sXfZP+XWEPGO5gzT1GJWTD6mX/i/sUBr6oBVri5tbqzdaBA2
         cOZA==
X-Gm-Message-State: ABy/qLZduDR+nlOV42UqHhb4Roi8eCsiFwaobFXDNumhBCZLa3C3J0cq
        v1V1XU/fvZFl/vvV2RAhIBIuBk8N41GiFQ==
X-Google-Smtp-Source: APBJJlEn8LnFbN41kHVAtsqhbJfTIlq5RkWHAYJcq5gEbsKRiLzu7Ssx7PCgYJ4l2bSOda8Le6fp2A==
X-Received: by 2002:a17:902:f802:b0:1b8:8dab:64e8 with SMTP id ix2-20020a170902f80200b001b88dab64e8mr4349426plb.36.1690077186468;
        Sat, 22 Jul 2023 18:53:06 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001b9f7bc3e77sm5994744plr.189.2023.07.22.18.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 18:53:05 -0700 (PDT)
Message-ID: <bba66a5f-3605-e36b-2bf3-f25a48307a46@gmail.com>
Date:   Sun, 23 Jul 2023 08:52:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Max Froehling <Maximilian.Froehling@gdata.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: bpf: bpf_probe_read_user_str() returns 0 for empty strings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Overview:
> 
> From within eBPF, calling the helper function bpf_probe_read_user_str(void *dst, __u32 size, const void *unsafe_ptr returns 0 when the source string (void *unsafe_ptr) consists of a string containing only a single null-byte.
> 
> This violates various functions documentations (the helper and various internal kernel functions), which all state:
> 
>> On success, the strictly positive length of the output string,
>> including the trailing NUL character. On error, a negative value.
> 
> To me, this states that the function should return 1 for char myString[] = ""; However, this is not the case. The function returns 0 instead.
> 
> For non-empty strings, it works as expected. For example, char myString[] = "abc"; returns 4.
> 
> Steps to Reproduce:
> * Write an eBPF program that calls bpf_probe_read_user_str(), using a userspace pointer pointing to an empty string.
> * Store the result value of that function
> * Do the same thing, but try out bpf_probe_read_kernel_str(), like this:
> char empty[] = "";
> char copy[5];
> long ret = bpf_probe_read_kernel_str(copy, 5, empty);
> * Compare the return value of bpf_probe_read_user_str() and bpf_probe_read_kernel_str()
> 
> Expected Result:
> 
> Both functions return 1 (because of the single NULL byte).
> 
> Actual Result:
> 
> bpf_probe_read_user_str() returns 0, while bpf_probe_read_kernel_str() returns 1.
> 
> Additional Information:
> 
> I believe I can see the bug on the current Linux kernel master branch.
> 
> In the file/function mm/maccess.c::strncpy_from_user_nofault() the helper implementation calls strncpy_from_user(), which returns the length without trailing 0. Hence this function returns 0 for an empty string.
> 
> However, in line 192 (as of commit fdf0eaf11452d72945af31804e2a1048ee1b574c) there is a check that only increments ret, if it is > 0. This appears to be the logic that adds the trailing null byte. Since the check only does this for a ret > 0, a ret of 0 remains at 0.
> 
> This is a possible off-by-one error that might cause the behavior.

See Bugzilla for the full thread.

FYI, the culprit line is introduced by commit 3d7081822f7f9e ("uaccess: Add
non-pagefault user-space read functions"). I Cc: culprit SoB so that they
can look into this bug.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217679

-- 
An old man doll... just what I always wanted! - Clara
