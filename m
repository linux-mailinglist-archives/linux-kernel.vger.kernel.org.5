Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30437D41B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjJWVaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWV36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:29:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAABD;
        Mon, 23 Oct 2023 14:29:56 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7a6774da682so158611539f.3;
        Mon, 23 Oct 2023 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698096596; x=1698701396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoTQ/KfDqFWYoDK3YaNrWba0skgnCglUsMepDshCCaM=;
        b=IYAF9q2x3OQcG+eOGkyWH9xhD3OeCu7Ti5BuptdtWVRS2Rz4hCLV950aTKCCZDF6i7
         Nlixd2YvfNkP0Vs1fqDYBT3CcHIM8KZMQvimABcLKl3aCFIyRRvbkZ6VOjge9/T4kZ96
         PKsMc1p3fwUe0hh4Tjq/1lhOmuolvPJB0P/TUR0kK1mcIANi1OHqu2IDfnUa1R0EbisH
         wEZWC7tclpDrB6kH0XJ5LlpxbRhVZ+gqcuYaH/ueuVYaWfF1sKcwEqBQGVbVYIgRXlXr
         W2ePf8kuZx1vY+Ap3USvaW3U5lkvDgPJdGFxU5MlJE8+eeX08OHq+1SI0wH25qJPww/O
         t5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698096596; x=1698701396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoTQ/KfDqFWYoDK3YaNrWba0skgnCglUsMepDshCCaM=;
        b=kLj7vsDSjF+BEyGq6JKAn7JgFEzSpwO9YQrFxrai1mq51KdfHFLoz9qQO3fo4cT1/w
         zQpwInfkFsNGBv5CH+Aom2oQMWUT2z8Z4h9RLJ/hF1DcgFJ+v0azJcq3urvXt+MGnFPI
         shNB7IONu35yCPViyrOtgcnj61l5DRYWAlDZ6kd7vrba+/nXiVxnz/FWUkA3BemsD/cr
         9gh9N9sZ5srOxcbfAU/NQuUTxYWbhERsAdRId8BxralDTa0Y9KsfITbzZraY9uTD08gf
         l63YmT6QXAySyZKDcrfTOLOYBskMBDG4INAqTHqmMrvLavjMCEroxvqFyr2f0V2NM0iw
         V27g==
X-Gm-Message-State: AOJu0YzXJJ66f+4/6iznRihNWTSIqR306ES0BPeugtPQlEjs0OuoEya4
        8zzB6NQJqiZp+GqXNy8Vzw==
X-Google-Smtp-Source: AGHT+IFWtFxd1g5W6/dz3htmkRiJFUxSNTpnlE3BXhqWBU1XXb1Og80FeZDQghqWwCQ8L0DypSsZng==
X-Received: by 2002:a05:6602:2c46:b0:7a9:63fd:e277 with SMTP id x6-20020a0566022c4600b007a963fde277mr3666300iov.14.1698096595791;
        Mon, 23 Oct 2023 14:29:55 -0700 (PDT)
Received: from [192.168.1.3] ([161.97.241.227])
        by smtp.googlemail.com with ESMTPSA id q11-20020a6bf20b000000b0079199e52035sm2691160ioh.52.2023.10.23.14.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 14:29:55 -0700 (PDT)
Message-ID: <78787d18-0f30-4be0-9e7c-1b6dbf142fec@gmail.com>
Date:   Mon, 23 Oct 2023 15:29:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arch/x86: port I/O tracing on x86
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
 <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
 <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
 <2023102122-diabetes-trend-57d0@gregkh>
 <20231021161503.382e3d2e@rorschach.local.home>
From:   Dan Raymond <raymod2@gmail.com>
In-Reply-To: <20231021161503.382e3d2e@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2023 2:15 PM, Steven Rostedt wrote:

>> Why are these needed to be changed at all?  What code changes with it,
>> and it's not mentioned in the changelog, so why is it required?
> 
> Agreed, if this has issues, it probably should be a separate patch.

As I mentioned to Greg, this fix is needed to avoid compiler warnings
triggered by this patch.  If I submitted this separately it would have
to be merged first.  Isn't it easier to combine them since this is
not a functional change (it just makes a cast explicit)?

>>> -#ifdef CONFIG_TRACEPOINTS
>>> +#if defined(CONFIG_TRACEPOINTS) && !defined(DISABLE_TRACEPOINTS)  
>>
>> Why this global change?
> 
> Yeah, DISABLE_TRACEPOINTS does not currently exist. If this is to be a
> new way to disable TRACEPOINTS it needs a separate patch and be able to
> disable tracepoints everywhere (maybe include/trace/*.h files also need
> to be modified?), and also be documented somewhere in Documentation/trace.

It's only needed to suppress compiler errors when building arch/x86/boot/*
and arch/x86/realmode/*.  Those source files include various x86 headers
such as <asm/msr.h> and <asm/shared/io.h>.  Those x86 headers include
<linux/tracepoint-defs.h> which references static_key_false() in
<linux/jump_label.h>.  DISABLE_TRACEPOINTS eliminates that reference and
hence suppresses the compiler error.

I didn't intend for this macro to be used by developers adding new
tracepoints so I didn't document it as such.  As far as creating a
separate patch: again this is a requirement for this patch and it doesn't
cause any functional changes so can't we combine them?
