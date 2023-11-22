Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8F7F3A99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjKVAHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKVAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:07:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F48CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:06:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c194b111d6so4748452a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700611616; x=1701216416; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xKwgkeAtzmkKnSz03T4DxgRKcvAVmHnZ/2Ynp93sTY=;
        b=gDFGmFkxvMYe/+g8IaR9wO1ST1vpvZr8sVCTgbdFhauqr/VI4WObylzQuxepKNAnZi
         Cdjsarl+q/ZwcpMrvEo7c/SDTCtt6fiz7RWaQzDJS1UO8wnruS0LlhbfN9yqhRRTnhI3
         xAo4Ub5RQEP8Pcwv0gQ2HfEHthmgjo9bUfKE0RMWv8/CFbva9yeui50EmCfNr84fguKq
         ZLBDPzxnQhvXqISslYDIQmK+XyYJe9WGVUa5bMAV3WDpTOsp8/PojS5xqeRdfVINo+kg
         StmyOpfChir2sSftsTfkGSLJwmObl31OdkRqwsA5RQmNbYlMQY30urcQrMsYLXinoqgd
         tv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700611616; x=1701216416;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/xKwgkeAtzmkKnSz03T4DxgRKcvAVmHnZ/2Ynp93sTY=;
        b=MkfznlPf862b7wtGA1vIyG3yI8RzxHNbLsQew4ykordzSm88FhYJtrFKJkv9D82qhB
         nK4dn18iguiofkTHkkJs6JY2piMU+LXiKcZBCLoeFFpUQh9CKjBhVdSvW6Z2FOMTRnsj
         027OvFDMSJwallFPGvgxaB3UI+tivds7zsfBePiGdL6/XECHiTeivbd3FOpKerBEOz5x
         hXSnYRcD9pkzJQjHRy/+8GuMo8odOZ4zTJKy2nMz9Au2R4xwE5Cn9n1y/nMWP/7YZor9
         fZ0MrYR/+WmB7bCX5f8/2lhgfh2oBwxPgU2sgxXUMoaKTkGMlmPkG/DynzHFw7ZvyPzT
         azlA==
X-Gm-Message-State: AOJu0YwnJ1ihRNzhOnGhp9rAQpD8aCOFA2slB4Ctgyhuiu0K1NCcXLAQ
        HMEJG/UAGJY9CLx43LoamWbHq2HeV7Ct7A==
X-Google-Smtp-Source: AGHT+IGFvSNUofC0ROKmiE0mKp1xMZ8d51fhDYVhtQKX8ZN/1XWxm8S+k3uuwHWRUMjbRvHDmBVm9g==
X-Received: by 2002:a05:6a20:431d:b0:188:f3d:ea35 with SMTP id h29-20020a056a20431d00b001880f3dea35mr764739pzk.50.1700611615823;
        Tue, 21 Nov 2023 16:06:55 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b006cb95c0fff4sm4424630pfe.71.2023.11.21.16.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 16:06:55 -0800 (PST)
Message-ID: <9057d7de-f2e0-44ba-bec7-8b0861b2a850@gmail.com>
Date:   Wed, 22 Nov 2023 07:06:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Nouveau <nouveau@lists.freedesktop.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        River <shibedrill1@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Kernel 6.6.1 hangs on "loading initial ramdisk"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> After upgrading from 6.5.9 to 6.6.1 on my Dell Latitude E6420 (Intel i5-2520M) with EndeavourOS, the boot process would hang at "loading initial ramdisk". The issue is present on the 6.6.1 release of both Linux and Linux-zen, but not the 6.5.9 release, which makes me think this is somehow upstream in the kernel, rather than to do with packaging. My current workaround is using the Linux LTS kernel.
> 
> I have been unable to consistently reproduce this bug. Between 50 and 30 percent of the time, the "loading initial ramdisk" will display, the disk activity indicator will turn off briefly and then resume blinking, and then the kernel boots as expected. The other 50 to 70 percent of the time, the boot stops at "loading initial ramdisk" and the disk activity indicator turns off, and does not resume blinking. The disk activity light is constantly flashing during normal system operation, so I know it's not secretly booting but not updating the display. I haven't been able to replicate this issue in QEMU. I have seen similar bugs that have been solved by disabling IOMMU, but this has not had any effect. Neither has disabling graphics drivers and modesetting. I have been able to reproduce it while using Nouveau, so I don't believe it has to do with Nvidia's proprietary drivers.
> 
> Examining dmesg and journalctl, there doesn't appear to be ANY logs from the failed boots. I don't believe the kernel even is started on these failed boots. Enabling GRUB debug messages (linux,loader,init,fs,device,disk,partition) shows that the hang occurs after GRUB attempts to start the loaded image- it's able to load the image into memory, but the boot stalls after "Starting image" with a hex address (presumably the start addr of the kernel).  
> 
> I've been trying to compile the kernel myself to see if I can solve the issue, or at least aid in reproduceability, but this is not easy or fast to do on a 2012 i5 processor. I'll update if I can successfully recompile the kernel and if it yields any information.  
> 
> Please let me know if I should provide any additional information. This is my first time filing a bug here.

See Bugzilla for the full thread and attached grub output.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.5..v6.6 https://bugzilla.kernel.org/show_bug.cgi?id=218173
#regzbot title: initramfs loading hang on nouveau system (Dell Latitude E6420)

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218173

-- 
An old man doll... just what I always wanted! - Clara
