Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53517C5E47
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbjJKUWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJKUWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:22:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C390C91;
        Wed, 11 Oct 2023 13:22:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fa7e33573so12032539f.0;
        Wed, 11 Oct 2023 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697055740; x=1697660540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06sOBn0H8fsTEJwn7dqizfbOY/TNiP+tRW6jXj5CetM=;
        b=CH1WRZqitMLHUi8CEIAm4w3TzO+VJi6WkNg8kO9vIeI2AL2PSNaAPAlYLCBC88aXvX
         fBPydkhvG0Ztj+Ts6reOcf/sBiiLsZlRLtR/ZPBhO+j56r6UKrdL17Gn5tnAcqC/6VFc
         bztLUie9Ri/U8F4ssaMH/zWN1acya9Nam2Im42rTPywPrEHBnHwwrHjQ6lPzhQQ2p2uX
         4wuP4DTxZE75do4BHV4aMWX42iotx7mVhjtEiAZVW9q8ffTqql5p660s7POVoBqHPgEh
         m64fCqMoWufMz0qwmAP0DiI2rBydKHPh3ckQYhFCWu6nAQeJDa/dRVv8kWJlUgSFbuq4
         Q5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055740; x=1697660540;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06sOBn0H8fsTEJwn7dqizfbOY/TNiP+tRW6jXj5CetM=;
        b=vUdVT9XYB6HcBx/JFYm8hcwP9cVZnhBKYKat3eazhw/DkFcuO9mVmp7g3p5LV1wZ3h
         G+/RFFdjoMpi7RAHB+zpx2FdpumcD3XLr51qfn7zbKnrw/Hup9XFESZiQLIur3r36AQF
         pJYXQ2jTIn+H/Mz/Zs1tUS4SpmlQWvom8Yrb4OECYfStfFplfm6X84EZD01DUT589k/O
         HsmPLx4UuRQu3fbWYIjgw+tcC2Ay0nl+Cd6l8/YcshE/yvFyQRsABd5osAH5rWTzHSAv
         Z4fQKoUBoOl79CGlwpxj0y5v8Vf8bK5HHGCD+LgH/KUOgrLQYYpDs3Z5xoUpL3fZBwG2
         NozQ==
X-Gm-Message-State: AOJu0YxMDjugDpBuTw+TCqsoPBv29RtDjqhQfH42ZQtpQyrJwrH1/MrI
        Ef94ZzlT9Bfx/c2WJGdx/7NkN9Bxmyre
X-Google-Smtp-Source: AGHT+IEvdAaCLC7MQtHa0VYl053C5MLMJy9jHP1E3DVNf0oUwXc2ScSfI5aRQHYNFZb7MV0IOz1+eQ==
X-Received: by 2002:a6b:700a:0:b0:79f:ce11:c1b0 with SMTP id l10-20020a6b700a000000b0079fce11c1b0mr25109095ioc.6.1697055740065;
        Wed, 11 Oct 2023 13:22:20 -0700 (PDT)
Received: from [192.168.1.3] ([161.97.241.227])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm3695962ioh.27.2023.10.11.13.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:22:15 -0700 (PDT)
Message-ID: <e92f5091-4e50-9241-5b60-39be101e70d6@gmail.com>
Date:   Wed, 11 Oct 2023 14:22:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5] arch/x86: port I/O tracing on x86
Content-Language: en-US
From:   Dan Raymond <raymod2@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com,
        Steven Rostedt <rostedt@goodmis.org>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
 <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
 <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
In-Reply-To: <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/2023 11:56 AM, Dan Raymond wrote:
> Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
> available on x86 via CONFIG_MMIOTRACE but that relies on page faults
> so it doesn't work with port I/O.  This feature uses tracepoints in a
> similar manner as CONFIG_TRACE_MMIO_ACCESS.
> 
> Signed-off-by: Dan Raymond <raymod2@gmail.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> V1 -> V2:
>   - create header file for prototypes to silence new compiler warning
>   - reduce CPU overhead to 2 instructions (no branching) when tracing disabled
>   - fix imprecise IP logging by retrieving the IP off the stack instead of using
>     compile time labels
> 
> V2 -> V3:
>   - restore missing semicolon
> 
> V3 -> V4:
>   - make GPL licenses consistent
>   - change pointer arguments from (long) to (void *)
>   - eliminate include guard checks and use -DDISABLE_TRACEPOINTS instead to
>     disable tracepoints in arch/x86/boot/*
>   - fix compiler warnings due to signed/unsigned mismatch in arch_cmpxchg64()
> 
> V4 -> V5:
>   - add -DDISABLE_TRACEPOINTS to arch/x86/realmode/rm/Makefile

Can I get reviews on this please?
