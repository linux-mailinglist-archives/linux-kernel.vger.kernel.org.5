Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64782766314
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjG1EW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjG1EW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:22:56 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F919B;
        Thu, 27 Jul 2023 21:22:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9d68a7abaso1432007a34.3;
        Thu, 27 Jul 2023 21:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690518175; x=1691122975;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV0P9pUy9vYqeeF+U2QGC4EBJiwKPd9OR6nuiKq0Vrk=;
        b=bI34xHbV8wsJQ7rk1eHO42aSS7+10Qzi771SDCDenpeB4/aut5cyPDX5s8oNu+VbbO
         yGaF/yan7iTQ+C5Fdd4I7mz9DfTNfsRYXPD/bthFMW0B7/CHmWtVxeTDYktoGq/3Cog+
         bwEsOfBUFiXbBTADVSNHJc0f1HstfcApi+bpxWrRL5gHc7HxHsr6ttFEzFiBgbq15O6I
         Oxpjg3sU/RdZL3fVQpsvBjQiAHrN+2FZ/fmD364KYWvnNeHDsDyRolejOwNT//LNV1zg
         SjxD1dPK2K3tGazBe9dUyv2ywgf8Fdcp1/HPemi9YTALgLQ3wKaGY4euBPvX6xAQzsRW
         k5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690518175; x=1691122975;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV0P9pUy9vYqeeF+U2QGC4EBJiwKPd9OR6nuiKq0Vrk=;
        b=H5Pvt7ny+aI3PWjabFduCzzhnuHqA4VXoESCE9AowNJD6ou/oSGHzooaDrvZ7qWHgq
         ag+087oJDiELIX9+i+rAqQACUV+aaZnSDpADpvCwALHw+SkuT2PMg5hJVP+OQ+V69add
         9kOS5lTIYKZ1h1VtjIS8DSXd8Z55N3inUvjtpThUT4yMcWvWUV1lHmvfSmZNTb/X/ONT
         +HQnicaZyYI9fk5SxO6zNi6UOV5Ct/Fjrb7UQS7JkfOBridQgxfMb56xNF+0PHqTEqYE
         bmae4+xhIfFSk6VDeG3mYFDleY8EDKiMX/be17lAmz+Dx5NPUKUDGH05tdkYtSGz8gZf
         +gaQ==
X-Gm-Message-State: ABy/qLZ6NQkKY8I3WpFs+nb9bfp7ZHglXaWCBZBnaH/qWU98FR6iBdUe
        ZYmcxTMAmyeeMQARAMWe8Y4=
X-Google-Smtp-Source: APBJJlEtTA3SL1VfbQWXbttnJZZZvzurq0mKggh2iAIIW7LSOdqSbTrwvYptvfod0y4fGuBgU/WsOg==
X-Received: by 2002:a9d:6285:0:b0:6b9:182b:cccc with SMTP id x5-20020a9d6285000000b006b9182bccccmr1375585otk.33.1690518174744;
        Thu, 27 Jul 2023 21:22:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o29-20020a63731d000000b0054fe6bae952sm2403714pgc.4.2023.07.27.21.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 21:22:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6d45f1d0-25e5-8603-0fbb-73374be00503@roeck-us.net>
Date:   Thu, 27 Jul 2023 21:22:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
References: <ZMJWet00+9yIl/9c@duo.ucw.cz>
 <78722041-D1F7-45FA-BA1C-41B92209BA6C@joelfernandes.org>
 <0751f5a8-2727-4a08-8bb8-50bbd4244c9c@paulmck-laptop>
 <67eba84a-ae24-2983-a756-463f39f3ca71@roeck-us.net>
 <ebe4a969-8a24-4bb8-8dbe-f77db89f65c9@paulmck-laptop>
 <2f4b012e-1f95-30aa-3f43-c31e84cb2c42@roeck-us.net>
 <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
In-Reply-To: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 13:33, Paul E. McKenney wrote:
[ ... ]

> So which of the following Kconfig options is defined in your .config?
> CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
> 

Only CONFIG_TASKS_RCU. I added another log message after call_rcu_tasks().
It never returns from that function.

[    1.168993] Running RCU synchronous self tests
[    1.169219] Running RCU synchronous self tests
[    1.285795] smpboot: CPU0: Intel Xeon Processor (Cascadelake) (family: 0x6, model: 0x55, stepping: 0x6)
[    1.302827] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    1.304526] Running RCU Tasks wait API self tests

... and then nothing for at least 10 minutes (then I gave up and stopped the test).

Qemu command line:

qemu-system-x86_64 -kernel \
      arch/x86/boot/bzImage -M q35 -cpu Cascadelake-Server -no-reboot \
      -snapshot -device e1000e,netdev=net0 -netdev user,id=net0 -m 256 \
      -drive file=rootfs.iso,format=raw,if=ide,media=cdrom \
      --append "earlycon=uart8250,io,0x3f8,9600n8 panic=-1 slub_debug=FZPUA root=/dev/sr0 rootwait console=ttyS0 noreboot" \
      -d unimp,guest_errors -nographic -monitor none

Again, this doesn't happen all the time. With Cascadelake-Server
I see it maybe once every 5 boot attempts. I tried with qemu v8.0
and v8.1. Note that it does seem to happen with various CPU types,
only for some it seems to me more likely to happen (so maybe the
CPU type was a red herring). It does seem to depend on the system
load, and happen more often if the system is under heavy load.

Guenter

