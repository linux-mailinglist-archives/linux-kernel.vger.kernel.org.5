Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40B97D7DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJZHzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:55:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D78C1;
        Thu, 26 Oct 2023 00:55:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so558312b3a.2;
        Thu, 26 Oct 2023 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698306914; x=1698911714; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLDn3rLpQ35tRtUSr/CuXLt9BSn773fceZFn4OOFRR8=;
        b=TuyaoyBeb+qepd4sSvhZooWtqTV49Lz8CK5JrNEjxlopMdJJFqdm9m+8Tk3Zyw5Z/+
         N77MF/vheRwLm4M8elvbg15FqkBlis4RTWx0Iil43UFXV+nxUfdydcH+y+lYg1SHSB4d
         cL40pkVvR13JEjwhUs0EHsAVSqsYE21OfZcnbAAzeKXQ0p0tmPFMe7WeGTgakP4Tj75o
         dAdqqXCDnwV+jDU0jzBG7xu73DkdIicJ1hlZ1RxEqm9Tfp1pe4B4KAfWUfXeHEetGcr1
         IdP28sUrQzyQIPIj2NhH95NlXjJTLyYotxFisTbl9aMIxMopuRloZG6WLzPbYY6HXeux
         D3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698306914; x=1698911714;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLDn3rLpQ35tRtUSr/CuXLt9BSn773fceZFn4OOFRR8=;
        b=edYO3rEZBvSacpEPemiIIDs9f9B30nrUPtSQ9VMHblHUQIykkRw6fgktx0q0myu0l4
         WKOONnXAeHVPwEludLjw/Jggu1O85QEY0J8JojeRF62h8hlI0X/8ZLPB7t1vsNPg2AsZ
         dfspolSsk0fs0+PTtuAD2CyVwBWx+lLqtrC4rIhAlPHNZR3r6HKw3oNostu/Sca3UmtD
         e+nt4fDOF+yAvyH31Kuz/bnAKqMo/IvyTctcCxvsrHtWpPJkRKQDQzC3uYOiU6rqcxh+
         zE1btlyFTfooDzJQsbN/kTKHUNO+5Py3zzUV6gZ2YYTyujaAAPi8yM3/iAgbv5DF1VwZ
         X1TQ==
X-Gm-Message-State: AOJu0YyLKvF3TXFDQb8q7KRhsLxwpvYgr5X/xRjc3J7vT/ruId/1cIIj
        Sg9TFfiJ26mNmsyyv7sAy+VAZ5cldB4=
X-Google-Smtp-Source: AGHT+IFsmPB2JKiQfxfGDpbU5oyDS2xG9SNux9eGXY9adnwYHp3bUwV3tHeox/sA6l9jCk4TTmDykQ==
X-Received: by 2002:a05:6a00:1704:b0:6bd:8c4a:ab8f with SMTP id h4-20020a056a00170400b006bd8c4aab8fmr17763815pfc.2.1698306914133;
        Thu, 26 Oct 2023 00:55:14 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e14-20020aa798ce000000b0069023d80e63sm10553519pfm.25.2023.10.26.00.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 00:55:13 -0700 (PDT)
Message-ID: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
Date:   Thu, 26 Oct 2023 14:55:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>
Cc:     Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannes.penssel@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: sysfs: cannot create duplicate filename
 .../system76_acpi::kbd_backlight/color
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

I notice a regression report on Bugzilla [1]. Quoting from it:

> Loading the system76-acpi kernel module fails on linux 6.6-rc7. This does not seem to be an issue with system76-acpi itself, because reverting commit #5d36931f0fe51665c04f56c027613d22e6a03411, which is the only change made to this driver across the 6.6 development cycle, does not fix the issue. On 6.5.8, everything works fine. My hardware is a Clevo-based Alder Lake laptop running coreboot, roughly similar to the System76 Darter Pro 8.
> 
> backtrace:
> [  266.399036] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/17761776:00/leds/system76_acpi::kbd_backlight/color'
> [  266.399045] CPU: 1 PID: 2896 Comm: modprobe Not tainted 6.6.0-rc7 #1
> [  266.399050] Hardware name: Notebook NS5x_NS7xPU/NS5x_NS7xPU, BIOS Dasharo (coreboot+UEFI) v1.6.0 03/30/2023
> [  266.399053] Call Trace:
> [  266.399057]  <TASK>
> [  266.399063]  dump_stack_lvl+0x36/0x50
> [  266.399080]  sysfs_warn_dup+0x5a/0x70
> [  266.399088]  sysfs_add_file_mode_ns+0x11a/0x130
> [  266.399094]  internal_create_group+0x125/0x3b0
> [  266.399101]  internal_create_groups+0x42/0xa0
> [  266.399107]  device_add+0x5b1/0x8a0
> [  266.399113]  ? kstrdup+0x4c/0x70
> [  266.399119]  device_create_groups_vargs+0xce/0xf0
> [  266.399124]  device_create_with_groups+0x4b/0x70
> [  266.399129]  led_classdev_register_ext+0x1d2/0x470 [led_class]
> [  266.399149]  ? devm_led_classdev_register_ext+0x3a/0x90 [led_class]
> [  266.399162]  devm_led_classdev_register_ext+0x50/0x90 [led_class]
> [  266.399173]  system76_add+0x18b/0x460 [system76_acpi]
> [  266.399186]  acpi_device_probe+0x47/0x130
> [  266.399193]  really_probe+0x19b/0x3e0
> [  266.399199]  ? __pfx___driver_attach+0x10/0x10
> [  266.399205]  __driver_probe_device+0x78/0x160
> [  266.399211]  driver_probe_device+0x1f/0x90
> [  266.399217]  __driver_attach+0xd2/0x1c0
> [  266.399222]  bus_for_each_dev+0x85/0xd0
> [  266.399227]  bus_add_driver+0x116/0x220
> [  266.399233]  driver_register+0x59/0x100
> [  266.399242]  ? __pfx_system76_driver_init+0x10/0x10 [system76_acpi]
> [  266.399252]  do_one_initcall+0x5a/0x300
> [  266.399260]  do_init_module+0x60/0x240
> [  266.399267]  init_module_from_file+0x86/0xc0
> [  266.399275]  __x64_sys_finit_module+0x18a/0x350
> [  266.399282]  do_syscall_64+0x5d/0x90
> [  266.399289]  ? syscall_exit_to_user_mode+0x26/0x40
> [  266.399295]  ? do_syscall_64+0x6c/0x90
> [  266.399300]  ? do_syscall_64+0x6c/0x90
> [  266.399305]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  266.399314] RIP: 0033:0x7f5c11b38d7d
> [  266.399360] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7b d0 0b 00 f7 d8 64 89 01 48
> [  266.399364] RSP: 002b:00007ffe30e15b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  266.399370] RAX: ffffffffffffffda RBX: 000055a8d48d6c10 RCX: 00007f5c11b38d7d
> [  266.399372] RDX: 0000000000000000 RSI: 000055a8d3077d8b RDI: 0000000000000003
> [  266.399375] RBP: 000055a8d3077d8b R08: 00007f5c11bf6b00 R09: 00007ffe30e15bd0
> [  266.399376] R10: 0000000000000050 R11: 0000000000000246 R12: 0000000000040000
> [  266.399378] R13: 000055a8d48d6c90 R14: 000055a8d48d6390 R15: 000055a8d48d7090
> [  266.399382]  </TASK>
> [  266.399410] System76 ACPI Driver: probe of 17761776:00 failed with error -17

See Bugzilla for the full thread and attached dmesg output.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.5..v6.6-rc7 https://bugzilla.kernel.org/show_bug.cgi?id=218045

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218045

-- 
An old man doll... just what I always wanted! - Clara
