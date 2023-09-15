Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929397A12E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjIOBXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjIOBXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:23:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9992100
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:23:29 -0700 (PDT)
X-QQ-mid: bizesmtp75t1694740940t8kew929
Received: from [192.168.70.112] ( [125.75.40.56])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 15 Sep 2023 09:22:17 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: znfcQSa1hKY4h3agG1U0orjKrbIsys7Af2fhfVGMjIYYI96qPTRd00OoX5Ahh
        s/Hwo3MO4iRDUbk6kFmosuZiDx4uxSfgvGHRXnv3HXrw25f0HM6I97R0zojs3pNvZG/8Vlz
        dmK7ZtXOlrpe6K+Fh7XGkx4JV0DkWlPy0BHXkqQxkv8mbYCryolZbTQ8VJAUDn1yH44Yms6
        V+ljQNiEXhb9JqHWZa13vkJdIyUuyZrjfptTEUDBh2/pdtXPUQX4uIb+jXoW5xyYUu2hkDi
        LHQOa6frdnm3Iu0vKxw0mUB5pv7fxf7JtVSPA/AawI5rSh+B2e5tsaL+3E7PhxIYTw0TdS7
        c/cYJtQCWEZHUXFTuY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13761634547373889057
Message-ID: <B4EC5520E6B64383+2324a0e9-db14-421b-876f-2d4f2f2f746d@tinylab.org>
Date:   Fri, 15 Sep 2023 09:22:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] Kconfig: Add dependencies of POWER_RESET for x86
Content-Language: en-GB
To:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, falcon@tinylab.org,
        w@1wt.eu, linux@weissschuh.net
References: <cover.1694687048.git.tanyuan@tinylab.org>
 <0f2cbd3026357a3936c0853057ed41b63db83d59.1694687048.git.tanyuan@tinylab.org>
 <f2642936-75b7-6c64-f3d6-ef3bf7fd8a31@intel.com>
From:   Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <f2642936-75b7-6c64-f3d6-ef3bf7fd8a31@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/2023 12:09 AM, Dave Hansen wrote:
> On 9/14/23 03:36, Yuan Tan wrote:
>> x86 and x86_64's power off depends on ACPI and PCI to work. Enable them
>> when POWER_RESET is set for convenience.
> I'm a bit confused by this.
>
> Which code is this referring to, exactly?  Are you saying that no x86
> system can power off or reset unless it supports ACPI or PCI?

Yes, after testing on qemu-system-x86_64 and qemu-system-i386, I found 
that x86 can only power off when it enable ACPI and PCI.

I wanted to test nolibc based on tinyconfig and found it hard to find 
the dependence to enable poweroff.


