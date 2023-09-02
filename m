Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC5790483
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351383AbjIBAaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:30:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55CE5C;
        Fri,  1 Sep 2023 17:30:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a520dba33so2250489b3a.0;
        Fri, 01 Sep 2023 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693614600; x=1694219400; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc6DUuHPcnNBCfBzqvAsEZg9fGqkhh0hsQ9G7lrZ5SA=;
        b=SkeaCRRCpe1dj7U6TNgM5RVQibd6haqaGGqkcSo5srlFFTGnz5ztB7/a5lmYTxcj90
         R3pzydEtCxh6mXBR9WGaO8gCbWtUyhtksuR6gJ073GTgZpYZVH4+xzowd0cOjd271PCt
         O10a2oFm50+ua124CWGSzClE433t/OYUjo4vFRjaQdWYJI3LmaKYnLdj49nmZM4kRxgX
         OOn5PtKb6rJKCMVFWEoHT/uRXTmqgHMFnq+YTQJAp5i40GZd3+Ux5QLuC8I7xJRyPQDz
         goWHojbgSIXJRk5ChD0AJhn2qCOp3Xev4eFQyDw3iHFNy2sIPVmXogcGqPeUZAYzaop9
         ONEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693614600; x=1694219400;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tc6DUuHPcnNBCfBzqvAsEZg9fGqkhh0hsQ9G7lrZ5SA=;
        b=HKSa389JSUQSe8N7GGVuhhiB7NvIZdeDyDgPxe2DOXhTfzaLViWcPFAoPLTsU0UeBf
         rhp7034lHbJi9zvERIKVLAiu73ETEyTTZmnBg0Jf/RdleG8PM6V0+SLQSc7cTzzqTkXV
         ZwPorhXKKOXjMSeQ0Ehwk/JvSQtdbOWF3uXUTZ6o/I6MZnK8ofXNlm7/vv7pvoUdW7UW
         QCVqPcA1sE8JP5T0MuIQzGP2/2+XNpThIHsSEtYZxwTr1l5YX8D4Pjbpohtw1jf1eNEq
         C/p7n8a8CtmyhhuqcUvRiHYi4T2NfuqdKYNmc6Asrow94OpX7gE8iV6EEzGPbFebx3bM
         hFZg==
X-Gm-Message-State: AOJu0Yxdum+CnDYNalEMIwMikgLWiF2iS20hXF10i9UPA3iUXi24wGLL
        9bbOZATXGtRye0ljTQtzKyVtCM4fIIY=
X-Google-Smtp-Source: AGHT+IF2aeKHHwH/dxyHQ+v39okD7qOTYGE5M2UUejMj9xAcmILEUANZ5XAUa528thxhGUuThuslHg==
X-Received: by 2002:a05:6a20:451:b0:133:71e4:c172 with SMTP id b17-20020a056a20045100b0013371e4c172mr4051792pzb.15.1693614600212;
        Fri, 01 Sep 2023 17:30:00 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id i12-20020aa787cc000000b006875493da20sm3515245pfo.3.2023.09.01.17.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 17:29:59 -0700 (PDT)
Message-ID: <c1caa7c1-b2c6-aac5-54ab-8bcc6e139ca8@gmail.com>
Date:   Sat, 2 Sep 2023 07:29:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: RCU indicates stalls with iwlwifi, causing boot failures
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> I'm seeing RCU warnings in Linus's current tree (like 87dfd85c38923acd9517e8df4afc908565df0961) that come from RCU:
> 
> WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_exp.h:787 rcu_exp_handler+0x35/0xe0
> 
> But they *ONLY* occur on a system with a newer iwlwifi device:
> 
> aa:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz (rev 1a)
> 
> and never in a VM or on an older device (like an 8260).  During a bisect the only seem to occur with the "83" version of the firmware.
> 
> iwlwifi 0000:aa:00.0: loaded firmware version 83.e8f84e98.0 ty-a0-gf-a0-83.ucode op_mode iwlmvm
> 
> The first warning gets spit out within a millisecond of the last printk() from the iwlwifi driver.  They eventually result in a big spew of RCU messages like this:
> 
> [   27.124796] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 125 jiffies s: 193 root: 0x1/.
> [   27.126466] rcu: blocking rcu_node structures (internal RCU debug):
> [   27.128114] Sending NMI from CPU 3 to CPUs 0:
> [   27.128122] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x5f/0xb0
> [   27.159757] loop30: detected capacity change from 0 to 8
> [   27.204967] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 145 jiffies s: 193 root: 0x1/.
> [   27.206353] rcu: blocking rcu_node structures (internal RCU debug):
> [   27.207751] Sending NMI from CPU 3 to CPUs 0:
> [   27.207825] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x5f/0xb0
> 
> I usually see them at boot.  In that case, they usually hang the system and keep it from booting.  I've also encountered them at reboots and also seen them *not* be fatal at boot.  I suspect it has to do with which CPU gets wedged.

See Bugzilla for the full thread and attached full dmesg output.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217856

-- 
An old man doll... just what I always wanted! - Clara
