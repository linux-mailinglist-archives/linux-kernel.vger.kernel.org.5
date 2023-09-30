Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56577B4042
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjI3Mbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjI3Mbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:31:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596FFBD;
        Sat, 30 Sep 2023 05:31:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so12788224b3a.0;
        Sat, 30 Sep 2023 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696077101; x=1696681901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0PEuv1JE1ji/lSxoZu0EKZ3PyEQs2C6XzXKupEO4HsI=;
        b=g+zXLR7zeIamobd1EhaifgMeW3Z2kHjB58mZ4DDfMxJnRs9U66ovnop9/uRr4k83cs
         jUwx7Q6X0KywFIjbAwacCZ+oVX0YoTeUeP9NkusJGBmXZyySb4CQDqzFJGIROr24D84h
         3Z+ieegFlFeK+zWsoQfNryGd+TeE5stkgdczMJWNJGiZ+gI0cHYaie5sX9PvWFAyEbhr
         v0FvurisjzUy3o8Rw0tXDws5jDWfb/0HY+q1lcAJt3LI7fQSBenJbJudF7+UmJpdVxZu
         7ElO4wwFW/Ufj19ht26oJedSrXgZTBli3O+c6uauSUl7ghTbFsI+XcOxjYVeclooVi0p
         O4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696077101; x=1696681901;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PEuv1JE1ji/lSxoZu0EKZ3PyEQs2C6XzXKupEO4HsI=;
        b=CaHbJZpBTmp6d9/dNWnxMXKCX02k2kLtZ2D7srzi0tNvy1V2aNrixumJ/Sw46SORc+
         lGxW0028WL06D6E1BD0qHyZW+c1Er9njIdoDoeQBmf1HMFxRXDU2jlLVEbln+z0Dh8DT
         HpsYWbhvLz+TDzFTHui1+C2sH3+Ckotjwo96/lrkd7Hz3MmnZpjjOFC3vGnsuKR3bPFJ
         ISGW/IflSAAmxxmUjY3tOPm8VNi2y1upyvSu+E8nW1iikYGVR2ffs2WZNVScTw8Fj3mw
         c9jjk9WxYo5JQarSKy7JZidu/sAQ3lSUIkz9TD+XpxmDUAOUfDtroFeC3SdPL5OLAiVD
         TfGQ==
X-Gm-Message-State: AOJu0Yxdo4WaufLNc0b0GGIE1FiXi4w9rlde61M1z4mynwCo75XSuuDq
        tl4cZHAJsFIN5U989VyHQ74=
X-Google-Smtp-Source: AGHT+IEhI7eA8uS9H8VpG7zI0niIhieHYI5PZG8NgJ2DvP5MEnONifsqFETJAiDku+qqJ+SYqEFV2A==
X-Received: by 2002:a05:6a00:24c6:b0:68c:2be:67bb with SMTP id d6-20020a056a0024c600b0068c02be67bbmr7158316pfv.20.1696077100602;
        Sat, 30 Sep 2023 05:31:40 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e25-20020a62ee19000000b00690d9901ce5sm7900536pfi.102.2023.09.30.05.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 05:31:39 -0700 (PDT)
Message-ID: <da91c950-51c0-4c71-855e-ae11898a97f5@gmail.com>
Date:   Sat, 30 Sep 2023 19:31:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Performance regression: resume_console takes 100ms longer in
 S2idle/S3 resume in v6.6-rc1
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Todd Brandt <todd.e.brandt@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Hardening <linux-hardening@vger.kernel.org>
References: <99b9d4d1-f7a9-4b6c-aebf-ef1d2ddee0d7@gmail.com>
Content-Language: en-US
In-Reply-To: <99b9d4d1-f7a9-4b6c-aebf-ef1d2ddee0d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 07:17, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Ever since 6.6.0-rc1 we've seen S3 and S2idle resume take 100ms longer because of resume_comsole. resume_console ordinarily takes only a few milliseconds, but now it's consistently 100ms. I've bisected the issue to this commit:
>>
>> commit 9e70a5e109a4a23367810de09be826c52d27ee2f
>> Author: John Ogness <john.ogness@linutronix.de>
>> Date:   Mon Jul 17 21:52:06 2023 +0206
>>
>>     printk: Add per-console suspended state
>>     
>>     Currently the global @console_suspended is used to determine if
>>     consoles are in a suspended state. Its primary purpose is to allow
>>     usage of the console_lock when suspended without causing console
>>     printing. It is synchronized by the console_lock.
>>     
>>     Rather than relying on the console_lock to determine suspended
>>     state, make it an official per-console state that is set within
>>     console->flags. This allows the state to be queried via SRCU.
>>     
>>     Remove @console_suspended. Console printing will still be avoided
>>     when suspended because console_is_usable() returns false when
>>     the new suspended flag is set for that console.
>>
>> We are seeing this on roughly 2/3 of our machines, both on test systems and production systems.
> 
> Then,
> 
>> The effect is most pronounced in the GigaByte z170x UD5. It goes from 300ms to 400ms because of an msleep 100 in the resume_console code. This might not seem like much but it's in series with everything else so it will always be there. Our goal is to keep both suspend and resume under 1 second if at all possible, so every bit counts.
> 
> See Bugzilla for the full thread and attached sleepgraph timelines
> (in html format).
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: 9e70a5e109a4a2 https://bugzilla.kernel.org/show_bug.cgi?id=217955
> #regzbot title: resume_console performance regression due to per-console suspended state
> 

#regzbot fix: printk: flush consoles before checking progress

-- 
An old man doll... just what I always wanted! - Clara

