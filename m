Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F187B8335
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJDPK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjJDPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:10:57 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B599C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:10:54 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34f69780037so2385805ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696432253; x=1697037053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C69F3lfYPZfWya2s0YKz4GByRnZ5Ctgmmx3+hZ0nKFU=;
        b=Rxqub+LpZGZrabiexnEUlN7UpR5qTpHyuca2UkwxvNqg/LECrgu4ikQBsNJ8N2t77L
         klncdK5yuUG7DYtVpvnFjfD/iTUWRmH8nUttR04c0Jnrx5HonqOINtbyVYfWJr6I7WYW
         MO8vM1fKBEBU0aOPbTDVgqLFfUBpuF3S1Vb8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432253; x=1697037053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C69F3lfYPZfWya2s0YKz4GByRnZ5Ctgmmx3+hZ0nKFU=;
        b=s4//r1wLpV//l5IcruNP4d/M1dpplZ1oV/yyxYmKqgW8k51VjeImXEE1uY88k59JP4
         0cr1S4+dk4Tbt6m9aaG69Mx0cjddOFsMexdwUEz42nLGpGNW7ih/MUaCv2NHEMA+rrmn
         mkDCvSUoH5HB4BVJHIX+LK/gLOJ/W3L44ZqVy7SKsfM15MXgga56irAKiE2Aeb26CIkS
         xP/jKKvHIR03PYJphtizRq/y62Tm1OlFlpSGxgU5HlqQ1aQokVuPqdmuUsfkWGDc/RUj
         rRrntSz3Y1bf8+wM40k9dOvPRftOtwzhojk+3LKPv2I7u46fpqk2KxAprdHBVa1hxSsW
         bjgg==
X-Gm-Message-State: AOJu0Yy91n6+ZSgfkWURVLtxrW6iIbOaGz8d+XD1DNubKXWQvtYQAIlA
        wHXnSS0H++wOrfyYqud4uDZHAQ==
X-Google-Smtp-Source: AGHT+IE8S6v4LjV8p+bGtXEmlQpI4WXVAQiKALZAEdIJF4UQu1DIXJj3KRca+G8xcVz293Z3CTR1ig==
X-Received: by 2002:a05:6602:1a07:b0:79d:1c65:9bde with SMTP id bo7-20020a0566021a0700b0079d1c659bdemr2973947iob.1.1696432253280;
        Wed, 04 Oct 2023 08:10:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ep10-20020a0566384e0a00b0042b09bde126sm990869jab.165.2023.10.04.08.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:10:52 -0700 (PDT)
Message-ID: <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
Date:   Wed, 4 Oct 2023 09:10:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, cleger@rivosinc.com,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
 <20230925230829.341-3-beaub@linux.microsoft.com>
 <20231003205908.391d17f5@gandalf.local.home>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231003205908.391d17f5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 18:59, Steven Rostedt wrote:
> 
> Note, this doesn't seem to apply to my tree so I only added the first
> patch. I think this needs to go through Shuah's tree.
> 
> -- Steve
> 
> 

Yes. I sent a fix up for rc4 - I can pull these two patches into
linux-kselftest next

Steve! Does that work for you?

thanks,
-- Shuah

