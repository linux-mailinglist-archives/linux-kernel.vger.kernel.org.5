Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE38781448
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379972AbjHRUYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379962AbjHRUXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:23:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F83A94;
        Fri, 18 Aug 2023 13:23:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso20559121fa.0;
        Fri, 18 Aug 2023 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692390219; x=1692995019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOlW06YHCo1VtV0isYJeKxtwhLv5Wk/3esBMuXVTsrc=;
        b=bcfraQ5kQMLKRMn2KCdxgJUkJ3TBMJRzc804qMD49UUNGV7qUPjkU/zeQRqP3G1EGr
         Q/tS1psbOSW6T1jlfXUiyuE1yBTTXIfMQCx1NkeMXOlYBCHOl+SsqcCMRKo/OPNUPjDz
         +hHnul4kKiJ9zbh/GKl3jZpA3obNVHi9wiT3D27JUenl+IBdsCYbiOsUbE5pChlB9D63
         2yDIZmFgsvC9Cll5H9JdV/Hly3/3UaaMzzju9FmKrQSBbVtsIjtlxsEbzWd0WuEgCAbr
         SeDmwAsqf1CQ0bY0JJcE/5jX6X2KgaPiYJVPnikVZRfX0S7sVlGUALSDfToWO0AJxqrM
         YTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390219; x=1692995019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOlW06YHCo1VtV0isYJeKxtwhLv5Wk/3esBMuXVTsrc=;
        b=F2gSPDWL7dHcCleufbZPhJxgaAHPFZmWflyeNQemwxe4fyjIFkUxa5QM4NHPi72Ixd
         1EmoOKy+Ds4Tz5sM7OyCcS0M3xUe6EtAoeb8LrCYdeO7rDcu0Sba3DhZ5qFDEItbH9+D
         6S1ithbAjKpNiDhEQC8e5hGM9KcvXt3RbKZHePExlUF1ZUXt5CU0BsIvqWsOw0o7XgFW
         WpeWui7jo6AwsL44aZXCaXduCNHzJ5Ovgvf+rGol3kzgFR/ueHJ7Ky/BW+coiJLNI7I1
         7C71lHbS40e1PcHFyRkxcmnZsTZO6H2DPyZ/R0b4eTegkAVIDKvfBHQ+S6gfM4So8a7M
         ITxA==
X-Gm-Message-State: AOJu0Yy8IXOLKM/3PZyBesbq3ZDwEfa+iQhO6ncayMoAGeB+ArtTm5iE
        0A/7SNLTvPCCBCpb6JujLPA=
X-Google-Smtp-Source: AGHT+IG+PhG8uv73Q+58Gj/7vFMe2TdxkNlTGkuh/gddOo82LjtoObuJJPBKAxMmF+RzzeDb1t+2fg==
X-Received: by 2002:a2e:8916:0:b0:2b9:e304:5f81 with SMTP id d22-20020a2e8916000000b002b9e3045f81mr249279lji.23.1692390218585;
        Fri, 18 Aug 2023 13:23:38 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id i9-20020a2e8089000000b002b724063010sm616535ljg.47.2023.08.18.13.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 13:23:38 -0700 (PDT)
Message-ID: <14effeaf-f22c-461b-b1d3-4396f50ad4e6@gmail.com>
Date:   Fri, 18 Aug 2023 22:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <bd5feeb3-bc44-d4d2-7708-eea9243b49a4@gmail.com>
 <0f9d0cd6-d344-7915-7bc1-7a090b8305d2@gmail.com>
 <CAMuHMdXPB+nSHUTPufiaRP0cxvk2_raEHavwTouaiWibdQtCTg@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CAMuHMdXPB+nSHUTPufiaRP0cxvk2_raEHavwTouaiWibdQtCTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2023 11:04, Geert Uytterhoeven wrote:
> Hi Rafal,
> 
> On Mon, Aug 7, 2023 at 1:11 PM Rafał Miłecki <zajec5@gmail.com> wrote:
>> On 4.08.2023 13:07, Rafał Miłecki wrote:
>>> I triple checked that. Dropping a single unused function breaks kernel /
>>> device stability on BCM53573!
>>>
>>> AFAIK the only thing below diff actually affects is location of symbols
>>> (I actually verified that by comparing System.map before and after -
>>> over 22'000 of relocated symbols).
>>>
>>> Can some unfortunate location of symbols cause those hangs/lockups?
>>
>> I performed another experiment. First I dropped mtd_check_of_node() to
>> bring kernel back to the stable state.
>>
>> Then I started adding useless code to the mtdchar_unlocked_ioctl(). I
>> ended up adding just enough to make sure all post-mtd symbols in
>> System.map got the same offset as in case of backporting
>> mtd_check_of_node().
>>
>> I started experiencing lockups/hangs again.
>>
>> I repeated the same test with adding dumb code to the brcm_nvram_probe()
>> and verifying symbols offsets following brcm_nvram_probe one.
>>
>> I believe this confirms that this problem is about offset or alignment
>> of some specific symbol(s). The remaining question is what symbols and
>> how to fix or workaround that.
> 
> I had similar experiences on other ARM platforms many years ago:
> bisection lead to something completely bogus, and it turned out
> adding a single line of innocent code made the system lock-up or crash
> unexpectedly.  It was definitely related to alignment, as adding the
> right extra amount of innocent code would fix the problem. Until some
> later change changing alignment again...
> I never found the real cause, but the problems went away over time.
> I am not sure I did enable all required errata config options, so I
> may have missed some...

I already experiented some weird performance variations on Broadcom's
Northstar platform that was related to symbols layout & cache hit/miss
ratio. For that reason I use -falign-functions=32 for that whole
OpenWrt's "bcm53xx" target (it covers Northstar and BCM53573). So
this aspect should be ruled out already in my case.
