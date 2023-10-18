Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BC07CE76B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJRTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJRTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:11:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42AE114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:11:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a683da7be3so541239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697656294; x=1698261094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcPyQ+/UrULwm1357ULn0xgSSCQSakS/sCic+Eq/5Aw=;
        b=B+L4DSvTQXdOVdqyvfVtCjhyxr87PQ3RW2gYHCjjJzifDkR8m9NPnCHohFia4z6EU9
         FsKZ2PHFFYk4q1C3kC+oHvrC+pZFkpW0QGQKRDfdOPeHEIapTgGM95ZT0niJsfKpcVXu
         SlMtkR0TPryuk2KNb3WOykXLMcvek1Xu6AQw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656294; x=1698261094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcPyQ+/UrULwm1357ULn0xgSSCQSakS/sCic+Eq/5Aw=;
        b=hHnj0PfvFOrboeYXO4oUHC0YYJQMn5+khips4Z/6DDSXzmlv2a5IWq/hDvpTRPyqOh
         MM+Kmm57J40CGJHU9BUEWwE14k/1EOsJgMVFPKIngoplRZoV8hh1wRlEYekY5BTUab+4
         H5SFlCHj/1ninOhtXhQKNzl2Ry4/nZpBg1K6mwAdGStT0AS4DnaFFKrnvuFXYa5sypl+
         nhm4CDroEACYiUv/39Q3tq+pinGjABcLaSjt9z47QIZ6jUzl1GsgHsteo3iadtBrePER
         zp49FjAewjCekNnQduxYvc7uggeKTHpAFxGkd/pxsxBnX+bPCKj0Fo2hDuyzsidz0WRB
         /7QA==
X-Gm-Message-State: AOJu0Yxkl5AdXVcOHuLIRS8vvd0llAjoPklf06VSaNqEcgOnwyAcgkJF
        pscXuwrOPs98F25VsRESu/Geyw==
X-Google-Smtp-Source: AGHT+IGuQBIf1Mqz9feT4GSv7U5mDqohLk0Ofjex8CQtcNJ0h3X8kUil41iw8fWGuTfwGxZZBW0myg==
X-Received: by 2002:a5e:8e47:0:b0:792:6068:dcc8 with SMTP id r7-20020a5e8e47000000b007926068dcc8mr203020ioo.2.1697656294240;
        Wed, 18 Oct 2023 12:11:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k25-20020a02a719000000b0043194542229sm1379857jam.52.2023.10.18.12.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:11:33 -0700 (PDT)
Message-ID: <2d2c647a-be81-47ad-b3bf-f43155a35377@linuxfoundation.org>
Date:   Wed, 18 Oct 2023 13:11:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: futex: remove duplicate unneeded defines
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <7f6380ca-7f4e-4080-a047-6f7d427c3501@linuxfoundation.org>
 <20231016214342.GC36211@noisy.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231016214342.GC36211@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 15:43, Peter Zijlstra wrote:
> On Mon, Oct 16, 2023 at 01:21:20PM -0600, Shuah Khan wrote:
>> On 10/6/23 03:55, Muhammad Usama Anjum wrote:
>>> Kselftests are kernel tests and must be build with kernel headers from
>>> same source version. The kernel headers are already being included
>>> correctly in futex selftest Makefile with the help of KHDR_INCLUDE. In
>>> this patch, only the dead code is being removed. No functional change is
>>> intended.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>
>> Applied to linux-kselftest next for Linux 6.7-rc1.
> 
> Please don't.

Okay - will drop it.

thanks,
-- Shuah

