Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621897ACF84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjIYFfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjIYFff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:35:35 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6261E3;
        Sun, 24 Sep 2023 22:35:28 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4053d53a1bfso44278465e9.1;
        Sun, 24 Sep 2023 22:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695620126; x=1696224926;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycf6Wya8ID6XmixPWSJ0vO/RRGDPjUVO7FYG5IN3BB4=;
        b=SWdHUFVPNRfA6hQgaSnVn6lcyQpVp823siaCaS2m86iHRwXX29aK0HFKSD6iP3eZlw
         tSWE96tz5MZ/Dx1XyeqH9QcN3oW90S+x3+seNwsISLAeBhVOZGvSKYtXfTHelRx4UQ5b
         H6A3Ha+GqXsCw7yVdfMzWxHwj/qArp6I0JvWi0FGI37Y48UOFmfIiTd3CpdtZSWkZ6z0
         DIFE6sVGFyEvWzWOJu0YShlsQ40Yh4iDDppdGJP19OuA0Vr3bkNwc7dEknrQkuXkmBry
         jCJPUcEshX7VoWknOxlkvvAcAAaUfwuLVJrXkqqOUtMjkd04I14EAg5NsBq7CCynP/1b
         llSw==
X-Gm-Message-State: AOJu0Yy3THwC0ilwblNhFknH2DSWlBKeHBlDD4NePH9R/Cw/yORa8yAO
        6agp1YQaYvi0CmmWd6GY3K3eSuMOrys=
X-Google-Smtp-Source: AGHT+IEBiJpPI3V9L7bnJ0vKKLWADLc2B/KsUYrdQQriv4CldZCKNYGIcVx9fTl7Xu39XOEKuIMZjQ==
X-Received: by 2002:adf:e288:0:b0:31f:e1b4:583d with SMTP id v8-20020adfe288000000b0031fe1b4583dmr4215607wri.56.1695620126427;
        Sun, 24 Sep 2023 22:35:26 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id sd18-20020a170906ce3200b009a198078c53sm5753897ejb.214.2023.09.24.22.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 22:35:25 -0700 (PDT)
Message-ID: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
Date:   Mon, 25 Sep 2023 07:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, hmh@hmh.eng.br
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: WARNING at drivers/acpi/platform_profile.c:74 in
 platform_profile_show()
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

according to logs, since 6.3 (up to 6.5.4 now), I repeatedly see:
 > WARNING: CPU: 14 PID: 962 at drivers/acpi/platform_profile.c:74 
platform_profile_show+0xb1/0x100 [platform_profile]
 > Modules linked in: ccm michael_mic ...
 > CPU: 14 PID: 962 Comm: power-profiles- Kdump: loaded Not tainted 
6.5.4-6-default #1 openSUSE Tumbleweed (unreleased) 
dd37106c593be78644bb80e3c1534d801bf4cb36
 > Hardware name: LENOVO 21CRS0K83K/21CRS0K83K, BIOS R22ET60W (1.30 ) 
02/09/2023
 > RIP: 0010:platform_profile_show+0xb1/0x100 [platform_profile]
 > Code: d0 a8 ...
 > RSP: 0018:ffff9c1ac0b97db0 EFLAGS: 00010296
 > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000008fc35be0
 > RDX: 0000000000000000 RSI: ffff9c1ac0b97db4 RDI: ffffffffc0a8b0a0
 > RBP: ffff8955ca540000 R08: ffff895b9f1ed180 R09: ffff895559ea1bc0
 > R10: 00000000031a400e R11: 000000000003f680 R12: ffff895b9f1ed180
 > R13: ffff9c1ac0b97e50 R14: 0000000000000001 R15: ffff9c1ac0b97ee8
 > FS:  00007f71b0e71900(0000) GS:ffff895b9f100000(0000) 
knlGS:0000000000000000
 > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > CR2: 00007fe402ea3400 CR3: 000000012004c000 CR4: 0000000000750ee0
 > PKRU: 55555554
 > Call Trace:
 >  <TASK>
 >  sysfs_kf_seq_show+0xab/0x100
 >  seq_read_iter+0x123/0x480
 >  vfs_read+0x1b8/0x300

It's:
WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))

So I put there one more print:
dev_warn(dev, "profile=%d profile_get=%ps\n",
          profile, cur_profile->profile_get);

and I see:
: profile=-1883022368 profile_get=dytc_profile_get [thinkpad_acpi]
: profile=-1510173440 profile_get=dytc_profile_get [thinkpad_acpi]
: profile=-1510173440 profile_get=dytc_profile_get [thinkpad_acpi]
: profile=-966231712 profile_get=dytc_profile_get [thinkpad_acpi]
: profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
: profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
: profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]

where the profile values in hex are like:
ffffffff8fc35be0
ffffffffa5fc9500
ffffffffc6687960

Looking at simplicity of dytc_profile_get(), I wonder how that can happen.

I also wonder about dev passed to dytc_profile_get() having empty name 
(nothing before colon above)? Is that expected?

Any ideas?

thanks,
-- 
js
suse labs
