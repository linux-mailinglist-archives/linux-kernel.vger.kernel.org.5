Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F147ACF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjIYFmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIYFmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:42:43 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B9E3;
        Sun, 24 Sep 2023 22:42:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so85117681fa.2;
        Sun, 24 Sep 2023 22:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695620555; x=1696225355;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AM8xf06ortIoaNZfjeOnh5namlrNCFJtvnAj3OYNhdU=;
        b=ZIewqxc/SvTISSr+nKIswgRcgX6CzCYdbY67EsMM91io2H8FlvkgnJQQ7iD1JyIrMZ
         HLTE4D+qfK801B23piwguDoYL+HDP1MNlO3BZzGffkG8HyWNi8jCkj0fZc5TS37JGL4Q
         3E9r5+FfTBIE3Z62DDNuE6BqGWgoNQK2K3Uppw7+aRGfwZx5hhtd2b198WiLhIUcmAqc
         j0KdGdBShAZPEIm/sw6HUvPQOBEf25KroXG5r8jNbL+kfpcEr+XGXwpQ60w5zJWkUHm+
         vfPFlJBuuEaIGs5wn5mv60e7M2b5aILmrzat5VTR1sEJiHKsnm+DP8VdxbMxyazoyzig
         GGlA==
X-Gm-Message-State: AOJu0YyO7zpOSwQ3dFa4Rjb9aevbkUs+w2e+DWPleGLopkOXttp41Rht
        lZL7kF3SGzCzMzPFqGiDJ47NhIsoXfQ=
X-Google-Smtp-Source: AGHT+IFQnv2r1g0JrzUUzcwW31wl0YJGIg1HRM6mZBO9WAtWqhzoNgZcyZu1BjNWtL23Rhwxl+D3Ew==
X-Received: by 2002:a2e:3607:0:b0:2bc:dd96:147c with SMTP id d7-20020a2e3607000000b002bcdd96147cmr4918014lja.34.1695620554849;
        Sun, 24 Sep 2023 22:42:34 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d12-20020a1709064c4c00b0099bd86f9248sm5829347ejw.63.2023.09.24.22.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 22:42:34 -0700 (PDT)
Message-ID: <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
Date:   Mon, 25 Sep 2023 07:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING at drivers/acpi/platform_profile.c:74 in
 platform_profile_show()
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, hmh@hmh.eng.br
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 09. 23, 7:35, Jiri Slaby wrote:
> Hi,
> 
> according to logs, since 6.3 (up to 6.5.4 now), I repeatedly see:
>  > WARNING: CPU: 14 PID: 962 at drivers/acpi/platform_profile.c:74 
> platform_profile_show+0xb1/0x100 [platform_profile]
>  > Modules linked in: ccm michael_mic ...
>  > CPU: 14 PID: 962 Comm: power-profiles- Kdump: loaded Not tainted 
> 6.5.4-6-default #1 openSUSE Tumbleweed (unreleased) 
> dd37106c593be78644bb80e3c1534d801bf4cb36
>  > Hardware name: LENOVO 21CRS0K83K/21CRS0K83K, BIOS R22ET60W (1.30 ) 
> 02/09/2023
>  > RIP: 0010:platform_profile_show+0xb1/0x100 [platform_profile]
>  > Code: d0 a8 ...
>  > RSP: 0018:ffff9c1ac0b97db0 EFLAGS: 00010296
>  > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000008fc35be0
>  > RDX: 0000000000000000 RSI: ffff9c1ac0b97db4 RDI: ffffffffc0a8b0a0
>  > RBP: ffff8955ca540000 R08: ffff895b9f1ed180 R09: ffff895559ea1bc0
>  > R10: 00000000031a400e R11: 000000000003f680 R12: ffff895b9f1ed180
>  > R13: ffff9c1ac0b97e50 R14: 0000000000000001 R15: ffff9c1ac0b97ee8
>  > FS:  00007f71b0e71900(0000) GS:ffff895b9f100000(0000) 
> knlGS:0000000000000000
>  > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  > CR2: 00007fe402ea3400 CR3: 000000012004c000 CR4: 0000000000750ee0
>  > PKRU: 55555554
>  > Call Trace:
>  >  <TASK>
>  >  sysfs_kf_seq_show+0xab/0x100
>  >  seq_read_iter+0x123/0x480
>  >  vfs_read+0x1b8/0x300
> 
> It's:
> WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> 
> So I put there one more print:
> dev_warn(dev, "profile=%d profile_get=%ps\n",
>           profile, cur_profile->profile_get);
> 
> and I see:
> : profile=-1883022368 profile_get=dytc_profile_get [thinkpad_acpi]
> : profile=-1510173440 profile_get=dytc_profile_get [thinkpad_acpi]
> : profile=-1510173440 profile_get=dytc_profile_get [thinkpad_acpi]
> : profile=-966231712 profile_get=dytc_profile_get [thinkpad_acpi]
> : profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
> : profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
> : profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
> 
> where the profile values in hex are like:
> ffffffff8fc35be0
> ffffffffa5fc9500
> ffffffffc6687960
> 
> Looking at simplicity of dytc_profile_get(), I wonder how that can happen.
> 
> I also wonder about dev passed to dytc_profile_get() having empty name 
> (nothing before colon above)? Is that expected?

I forgot to add:
   cat /sys/firmware/acpi/platform_profile
correctly returns:
   low-power

without any WARNING. It looks like the warn often (but not exclusively) 
happens around:
PM: suspend exit

> Any ideas?

Ah, convert_dytc_to_profile()'s retval is not checked in 
dytc_profile_refresh(). That's likely it, let me add the check and retry.

> thanks,

-- 
js
suse labs

