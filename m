Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5937B0FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjI1ARp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1ARn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:17:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C069BF;
        Wed, 27 Sep 2023 17:17:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1ff5b741cso110949525ad.2;
        Wed, 27 Sep 2023 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695860257; x=1696465057; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvZYJDFjw6AtaYjYTuzTNmQLcMXi0xxUU7gqtmd/9gc=;
        b=OXkcPr1YDDHJxxiCkh2yzz/Wtwm7bow5DDBkAtRvRKzmK+53I/MLkvbUmrJ2vYC+8J
         eW45Zw37QD47t9UuxkVBEjhwtfVzh0tASmopkSk96eWb35ijSphWsbuS+H7v7qZvCaxg
         f84ENkWqWeM3Y0dcvxrOcYSpQ867GThLVmXAjfS4g484iXyp/iLra0uhRYNTTqaHcPJW
         QyQlAdj+EAlhzbhbexRCEvJDwSKutyntaagrgK6HOlSXR/naUf9zLxpwZJCJN1sy2fId
         VqClx7xGhBjDcR2LRIE0VjOWCYkHHGJ0zEyDwtFoaoNc2NLWqCWgNcv31Zctc24vz702
         B+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695860257; x=1696465057;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qvZYJDFjw6AtaYjYTuzTNmQLcMXi0xxUU7gqtmd/9gc=;
        b=DE/CeKoMTZids8gZYE+1wtiFEhUT0MVbPNa3JyWgu8yv6LEQPXh0cnsL0sWDUpSHkP
         v1vYPDtqlsIuiw2nEgEcOyi6Jl+4JIMwP6YCTUB2pTTPrJXnr/Fo+8KNlLP52iJd6sY1
         Ig0IlHSBZT6ij02akzEY1ZLwzVe3WM0NnTFedjyda5djcxxXmZT/y7llTKCwwePAbTWr
         hcSNzhL8Gn2jvCZ18lpPBQUqTBkfUwyzwKOvIorh3x+MH/Hegala6FVyTD5wkcicsnN1
         YqstQMF7F9k7GkdsexO3usGhzH4ersQBcq2x2ewMGchEHbZgZBVamCSGLZGzjiZHi9BA
         U8DQ==
X-Gm-Message-State: AOJu0YwO6JRBwQj42MWCqkI+9pM0030aNfhRHvstiinIA+lZAJyvzzpR
        ud0IF71+QNQ+ab0NDtUcEMk=
X-Google-Smtp-Source: AGHT+IHlbfoihbCEKofpMw/0JZU0HYH2cWhIJn6F5hSC1Meu2QrWUcExGMHVTjyVpnTlXGel2ufM8w==
X-Received: by 2002:a17:902:da84:b0:1c6:183a:f4ec with SMTP id j4-20020a170902da8400b001c6183af4ecmr3632437plx.17.1695860256324;
        Wed, 27 Sep 2023 17:17:36 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c625d6ffccsm5887624pld.129.2023.09.27.17.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 17:17:35 -0700 (PDT)
Message-ID: <99b9d4d1-f7a9-4b6c-aebf-ef1d2ddee0d7@gmail.com>
Date:   Thu, 28 Sep 2023 07:17:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Todd Brandt <todd.e.brandt@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Hardening <linux-hardening@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Performance regression: resume_console takes 100ms longer in
 S2idle/S3 resume in v6.6-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Ever since 6.6.0-rc1 we've seen S3 and S2idle resume take 100ms longer because of resume_comsole. resume_console ordinarily takes only a few milliseconds, but now it's consistently 100ms. I've bisected the issue to this commit:
> 
> commit 9e70a5e109a4a23367810de09be826c52d27ee2f
> Author: John Ogness <john.ogness@linutronix.de>
> Date:   Mon Jul 17 21:52:06 2023 +0206
> 
>     printk: Add per-console suspended state
>     
>     Currently the global @console_suspended is used to determine if
>     consoles are in a suspended state. Its primary purpose is to allow
>     usage of the console_lock when suspended without causing console
>     printing. It is synchronized by the console_lock.
>     
>     Rather than relying on the console_lock to determine suspended
>     state, make it an official per-console state that is set within
>     console->flags. This allows the state to be queried via SRCU.
>     
>     Remove @console_suspended. Console printing will still be avoided
>     when suspended because console_is_usable() returns false when
>     the new suspended flag is set for that console.
> 
> We are seeing this on roughly 2/3 of our machines, both on test systems and production systems.

Then,

> The effect is most pronounced in the GigaByte z170x UD5. It goes from 300ms to 400ms because of an msleep 100 in the resume_console code. This might not seem like much but it's in series with everything else so it will always be there. Our goal is to keep both suspend and resume under 1 second if at all possible, so every bit counts.

See Bugzilla for the full thread and attached sleepgraph timelines
(in html format).

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: 9e70a5e109a4a2 https://bugzilla.kernel.org/show_bug.cgi?id=217955
#regzbot title: resume_console performance regression due to per-console suspended state

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217955

-- 
An old man doll... just what I always wanted! - Clara
