Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08E77AD141
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjIYHTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjIYHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:19:40 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364BEC0;
        Mon, 25 Sep 2023 00:19:34 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso719282366b.3;
        Mon, 25 Sep 2023 00:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695626372; x=1696231172;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsLwrhzYfweLc8M1iQcM7ZolsNdfbR1KtPp0lNfplQ0=;
        b=XbdTstfKlWatgn7GNr7wwnTzj1LW5bH5SOEWTBYs9Q+RHUniGnJ2dAQfzHtIOwU2uw
         +3wlCsqREy3hgg5wpRNIqcZ7QgvqILNKM7NqOteG4YPBhdDbh2vS8UsAJaCv2f5kGuHp
         DQhZJMrCjIXtJ8dzVuqCH9lf/ke10T7wj2+Hj5oS8BcQrFQ4oR72jT6HQEZdHFLh1JFM
         ti1kjHhK6r2D3YLJzmOyU8klEsuh43nAHNGN2PbW6NlbyMntqERGzQryF2/EWSCimMQD
         jWDYDNzYXP9lkujk4O+PQc5JuaCs9GeThnyahYSeE4aPTv4xwARRcVd8tH/RVfEJnk/n
         z2Nw==
X-Gm-Message-State: AOJu0YwMpAg3rbtex66KWMFehqO4iUI+0BUuJ4T/scRKYFYnraW52i8m
        df62eT/IzcG0bkTbV2QNqxyVxrApR34=
X-Google-Smtp-Source: AGHT+IEBZoJI6me1po746IG9rTNNdPNLv0VDRUTPuZ4Bv2DdhbFPVnT96hJxJpcbLDoiGF8GuAcYlA==
X-Received: by 2002:a17:906:2189:b0:9ad:ece6:eeb with SMTP id 9-20020a170906218900b009adece60eebmr4890271eju.32.1695626372446;
        Mon, 25 Sep 2023 00:19:32 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id pw15-20020a17090720af00b0099bca8b9a31sm5897534ejb.100.2023.09.25.00.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:19:31 -0700 (PDT)
Message-ID: <beeab87b-820a-475a-b0c6-99b1b8e491ea@kernel.org>
Date:   Mon, 25 Sep 2023 09:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING at drivers/acpi/platform_profile.c:74 in
 platform_profile_show()
From:   Jiri Slaby <jirislaby@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, hmh@hmh.eng.br
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
 <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 09. 23, 7:42, Jiri Slaby wrote:
> On 25. 09. 23, 7:35, Jiri Slaby wrote:
>> Hi,
>>
>> according to logs, since 6.3 (up to 6.5.4 now), I repeatedly see:
>>  > WARNING: CPU: 14 PID: 962 at drivers/acpi/platform_profile.c:74 
>> platform_profile_show+0xb1/0x100 [platform_profile]
>>  > Modules linked in: ccm michael_mic ...
>>  > CPU: 14 PID: 962 Comm: power-profiles- Kdump: loaded Not tainted 
>> 6.5.4-6-default #1 openSUSE Tumbleweed (unreleased) 
>> dd37106c593be78644bb80e3c1534d801bf4cb36
>>  > Hardware name: LENOVO 21CRS0K83K/21CRS0K83K, BIOS R22ET60W (1.30 ) 
>> 02/09/2023
>>  > RIP: 0010:platform_profile_show+0xb1/0x100 [platform_profile]
>>  > Code: d0 a8 ...
>>  > RSP: 0018:ffff9c1ac0b97db0 EFLAGS: 00010296
>>  > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000008fc35be0
>>  > RDX: 0000000000000000 RSI: ffff9c1ac0b97db4 RDI: ffffffffc0a8b0a0
>>  > RBP: ffff8955ca540000 R08: ffff895b9f1ed180 R09: ffff895559ea1bc0
>>  > R10: 00000000031a400e R11: 000000000003f680 R12: ffff895b9f1ed180
>>  > R13: ffff9c1ac0b97e50 R14: 0000000000000001 R15: ffff9c1ac0b97ee8
>>  > FS:  00007f71b0e71900(0000) GS:ffff895b9f100000(0000) 
>> knlGS:0000000000000000
>>  > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  > CR2: 00007fe402ea3400 CR3: 000000012004c000 CR4: 0000000000750ee0
>>  > PKRU: 55555554
>>  > Call Trace:
>>  >  <TASK>
>>  >  sysfs_kf_seq_show+0xab/0x100
>>  >  seq_read_iter+0x123/0x480
>>  >  vfs_read+0x1b8/0x300
>>
>> It's:
>> WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>>
>> So I put there one more print:
>> dev_warn(dev, "profile=%d profile_get=%ps\n",
>>           profile, cur_profile->profile_get);
>>
>> and I see:
>> : profile=-1883022368 profile_get=dytc_profile_get [thinkpad_acpi]
>> : profile=-1510173440 profile_get=dytc_profile_get [thinkpad_acpi]
>> : profile=-1510173440 profile_get=dytc_profile_get [thinkpad_acpi]
>> : profile=-966231712 profile_get=dytc_profile_get [thinkpad_acpi]
>> : profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
>> : profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
>> : profile=-1578420592 profile_get=dytc_profile_get [thinkpad_acpi]
>>
>> where the profile values in hex are like:
>> ffffffff8fc35be0
>> ffffffffa5fc9500
>> ffffffffc6687960
>>
>> Looking at simplicity of dytc_profile_get(), I wonder how that can 
>> happen.
>>
>> I also wonder about dev passed to dytc_profile_get() having empty name 
>> (nothing before colon above)? Is that expected?
> 
> I forgot to add:
>    cat /sys/firmware/acpi/platform_profile
> correctly returns:
>    low-power
> 
> without any WARNING. It looks like the warn often (but not exclusively) 
> happens around:
> PM: suspend exit
> 
>> Any ideas?
> 
> Ah, convert_dytc_to_profile()'s retval is not checked in 
> dytc_profile_refresh(). That's likely it, let me add the check and retry.

OK,
so adding:
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10418,7 +10418,14 @@ static void dytc_profile_refresh(void)
                 return;

         perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
-       convert_dytc_to_profile(funcmode, perfmode, &profile);
+       err = convert_dytc_to_profile(funcmode, perfmode, &profile);
+       if (err) {
+               pr_warn("%s: mmc=%u psc=%u mmc_get=%u funcmode=%d 
output=0x%x perfmode=%d\n",
+                          __func__, !!(dytc_capabilities & 
BIT(DYTC_FC_MMC)),
+                          !!(dytc_capabilities & BIT(DYTC_FC_PSC)),
+                          dytc_mmc_get_available, funcmode, output, 
perfmode);
+               return;
+       }
         if (profile != dytc_current_profile) {
                 dytc_current_profile = profile;
                 platform_profile_notify();

fixes the warning, of course.

The output is:
dytc_profile_refresh: mmc=0 psc=1 mmc_get=0 funcmode=0 output=0x1f001 
perfmode=15

So using psc mode, it retrieves DYTC (0x1f001) as follows:
0x1.... -> VSTD=1 -> STD mode
0x.f... -> CICM=0xf, DYTC_GET_MODE_BIT(12) -> dunno what it is in STD
0x..0.. -> CICF=0x0, DYTC_GET_FUNCTION_BIT(8) -> DYTC_FUNCTION_STD
0x....1 -> GOOD

But convert_dytc_to_profile() doesn't handle this at all. Do I have a 
newer DYTC interface? Or a broken one?

My DYTC for CMD_GET looks like:
    Case (0x02)
    {
        Local5 = VSTD /* \VSTD */
        Local5 |= (VCQL << 0x01)
        Local5 |= (VSTP << 0x04)
        Local5 |= (VADM << 0x07)
        Local5 |= (VTMS << 0x09)
        Local5 |= (VDLS << 0x0A)
        Local5 |= (VMSC << 0x0C)
        Local5 |= (VPSC << 0x0D)
        Local1 = (CICF << 0x08)
        If ((CICF == 0x03))
        {
            CICM = SMYH /* \SMYH */
        }
        ElseIf ((CICF == 0x0B))
        {
            CICM = SMMC /* \SMMC */
        }
        ElseIf ((CICF == 0x0D))
        {
            CICM = SPSC /* \SPSC */
        }
        ElseIf ((CICF == 0x0F))
        {
            CICM = SAMT /* \SAMT */
        }
        ElseIf ((CICF == 0x07))
        {
            CICM = SADM /* \SADM */
        }
        Else
        {
            CICM = 0x0F
        }

        Local1 |= (CICM << 0x0C)
        Local1 |= (Local5 << 0x10)
        Local1 |= 0x01
    }

>> thanks,
> 

-- 
js
suse labs

