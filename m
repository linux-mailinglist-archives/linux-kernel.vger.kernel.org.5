Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1BA7BB429
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjJFJ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjJFJ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:27:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C895;
        Fri,  6 Oct 2023 02:27:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c735473d1aso14932225ad.1;
        Fri, 06 Oct 2023 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696584471; x=1697189271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qd8PELAk6On3fpApQm8hLN5EGlr4n91DxF8C8aXw5Uk=;
        b=P9Nl687RnKNOMgNwaDAya9QiCOKu7pLhhheuZkVnL3OtkN8bAGi/VtVLvB6sFmJtl3
         LF8Y5KCSm7CRz1itGXPBgr1aN1aMou4ZbRbFNYM/zyDKMVLWH649lPR52dAuaW4hK6Ez
         RA8c6duxCDvPGozL2i8ojJtqc4uWBsT56nP27ploFvig312ce9n095v9I+/cD4hRdUfD
         dySlGxHTmeiXz28yJh6k8yFtOelO+hlXYaQEkQAWN9T7mdiUjgxXm3jNZjnBa+XbaUJa
         3/Uir4c4jVZnxDk7Hd/XmycpDt6T28evHauvaTm9Q4fWQ31oaKekU4YIc6v5OMCrVOth
         FzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584471; x=1697189271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qd8PELAk6On3fpApQm8hLN5EGlr4n91DxF8C8aXw5Uk=;
        b=NlVj9SaiUK5AQQO4B2yHFLJ/33YCdThaMdSo7dcXFK2nXy3PU8X7GnGsMEkTT6A75d
         m2EHrZkLQmq4ULwQq3i8oqy7PEUG3dZjUPSLa8ud1xHd9iNzkxWdBxAyvk1fawCETN3K
         jlrrYQptOF8Nv1U76PvtACHzALmyErmaxJW5Hf+RZ3F0VMBXIuCbO6mCa/77BHTr/cEV
         LT4o2RFuPvEjKktnj+IBZquurbOFsM+iB4WeSWRCK/iJyKtxMQsZ9oob5woA1kUBwWK4
         LPAQsEGZQkgdXSfB1uHzPVWX8JFrXiXD+gw1rCbSmcefBmeK3/ZHuFgv6WHx1Mrjz94f
         pAHw==
X-Gm-Message-State: AOJu0YxdFmTmegmPDg0tvgQHWXiY6dq7cYDHE1A3fNtoClxL7KKrgHBA
        PvFIRrZ1B168oNVb4SH7JyE=
X-Google-Smtp-Source: AGHT+IFE3+eJ4cgE1olPLOlFYEDjaAcXkz86sb6eE2ajYLliRdanEX9PMpRbM09FPQsCy2nHMOSeeQ==
X-Received: by 2002:a17:902:7790:b0:1c4:56c8:27f8 with SMTP id o16-20020a170902779000b001c456c827f8mr6052803pll.68.1696584470813;
        Fri, 06 Oct 2023 02:27:50 -0700 (PDT)
Received: from [172.22.12.30] ([123.51.235.123])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001c76fcccee8sm3303741plg.156.2023.10.06.02.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 02:27:50 -0700 (PDT)
Message-ID: <b08d6cf6-cd48-86d7-a959-290fc4de092c@gmail.com>
Date:   Fri, 6 Oct 2023 17:27:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] watchdog: eiois200_wdt: Add EIO-IS200 Watchdog Driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1696495372.git.advantech.susiteam@gmail.com>
 <d7df3c7b-730a-4d09-8f15-3cc8591c8092@roeck-us.net>
Content-Language: en-US
From:   Wenkai <advantech.susiteam@gmail.com>
In-Reply-To: <d7df3c7b-730a-4d09-8f15-3cc8591c8092@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Guenter Roeck 於 10/6/2023 11:02 AM 寫道:
> On Thu, Oct 05, 2023 at 04:51:18PM +0800, advantech.susiteam@gmail.com wrote:
>> From: Wenkai <advantech.susiteam@gmail.com>
>>
>> This patch series aims to add support for the Advantech EIO-IS200
>> Embedded Controller's watchdog timer to the Linux kernel. The EIO-IS200
>> is a widely used embedded controller, and this series introduces a
>> native driver for its watchdog timer functionality within the Linux
>> ecosystem.
>>
> I am not going to review this patch series. This is just ne watchdog driver.
> One patch is sufficient.
>
> Guenter
Hi Guenter,

Advantech's EIO-IS200 watchdog supports 5 output pins: RESET, Power
Button, SCI, IRQ, and GPIO. The most traditional scenario is that the
Pretimeout triggers IRQ, and the timeout triggers RESET.

However, unfortunately, for industrial usages, there are various use
cases, which require certain mechanisms and logic to manage which signal
is output when Pretimeout and timeout expire. I am concerned that
consolidating all these features into a single patch for upstream may
lead to confusion and make the source code less readable and
understandable.

Therefore, I have divided the implementation into 5 separate patches,
aiming to make the code more comprehensible and acceptable. If it's
acceptable to you, I am more than willing to provide a single patch as
per your preference.

I would also like to note that this watchdog driver is part of the
EIO-IS200 MFD (Multi-Function Device) driver family. It serves as one
of the child-drivers of the drivers/mfd/eiois200_core core driver. It's
important to mention that without the presence of
drivers/mfd/eiois200_core, this child-driver eiois200_wdt cannot be
compiled or used.

Should we wait until the core driver (drivers/mfd/eiois200_core) is
successfully incorporated before upstreaming the watchdog child-driver,
or would you prefer to proceed with these patches independently?

Best regards,
Wenkai

