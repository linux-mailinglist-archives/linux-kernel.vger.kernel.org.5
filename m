Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F53C76CBF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjHBLrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjHBLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:47:16 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461382695
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:47:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686b879f605so4550684b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690976835; x=1691581635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VY3CwLeeFL+w/eySez9e+xGTeCEfKyGFVnZ00Q7RfZU=;
        b=Vny3mbDMw7q/ssnfYjctbBd3CIipCZXnNYA5QTgweLyYzansSIxAV9ED1EUSBco30D
         v7RauWrVghF1PXGTJtkJ7zrSnGgWySj8r1qtXClJqPy53px7Ay50GV+oMZQ9YT8BoMXB
         CCczaVHXtb87XnCnUKTk15pQ0M6/2aw7k5X7WENbUebJw+JLzGSUtPa0i9U36UtlvyKg
         VSY0EoW/awqblJJbifNw0eHHlSXzP6rhpCPRtz2MfySGM1MabFOEr7IcPqByYH5qRgmE
         16u1a7+oIvscHnjJgFUFWvGl2RQLkxr4kerfLii3Y4P6h9ZnzQF1oedU43+Xi4+OOsgK
         NafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690976835; x=1691581635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VY3CwLeeFL+w/eySez9e+xGTeCEfKyGFVnZ00Q7RfZU=;
        b=M+EYyw/A4zlpAyoiuD9/P9f4gi8TdU/Sqy6M22kFAi/WfJcITFJT38myvqlz7NCG7q
         B7oLXTUyUphoH0aBViRPgabOgylL3tHFDOUbtXkHH3ez+3y55iQZFpUZdDb6QMwU+ssz
         JsiLAKJsAQjQnDLTXJPnLK9NZu1fC1gKjAqXFirJduG59NA0RgNipLLRSeNjziqu48+t
         LZP5BbygKmOua+1MPfEpSXCUjmoLqxo5WFI5xhWhQJ8mU2S2FtnpxmAuxMTA/VrGk2+o
         dVckmVy4ZPCcr4wKOBR1lKJQ7RAUolK5WWpJ/dr1xVJ4IfUbLRYmrGTPiOS5zZi3rgmA
         6jgg==
X-Gm-Message-State: ABy/qLbKV6EwGsEIwFpFDNz/gxAWO6/hnSgaERh0Kdl1mxoZoeRysWk/
        iSK0AuwYiav1BNZmePz6Nf3stVSZSlk=
X-Google-Smtp-Source: APBJJlEpUfLURkH4ozeq4gDIqhcXfZws4XX4fNnlLu6cBXCAquozJUcCFvAbdc02zQ9k9ve7oerakA==
X-Received: by 2002:a05:6a00:390f:b0:682:4de1:adcc with SMTP id fh15-20020a056a00390f00b006824de1adccmr16139531pfb.12.1690976834708;
        Wed, 02 Aug 2023 04:47:14 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78c14000000b006871fdde2c7sm7127677pfd.110.2023.08.02.04.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:47:14 -0700 (PDT)
Message-ID: <307e4377-f52f-40dc-23ec-90a75668cb99@gmail.com>
Date:   Wed, 2 Aug 2023 18:47:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: Kernel memory management bug at mm/migrate.c:662 when
 flushing caches
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco <rodomar705@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <428d8fe9-8c19-ddba-b36e-7db5524e8d04@gmail.com>
 <32c3d93c-c320-0f88-87db-003f51bfc039@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <32c3d93c-c320-0f88-87db-003f51bfc039@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 18:25, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 02.08.23 13:08, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> I hit this kernel bug on the latest 6.3.9 kernel after executing this script to cleanup hugepages from the kernel before booting up a Windows 11 VM with QEMU (otherwise I don't have enough contiguous memory to allocate the pages to the VM)
>>>
>>> snip
>>> if [[ $VM_ACTION == 'prepare' ]];
>>> then
>>>     sync
>>>     echo 3 > /proc/sys/vm/drop_caches
>>>     echo 1 > /proc/sys/vm/compact_memory
>>> endsnip
>>>
>>> Attached is the full QEMU script that I used. I do use ZFS as a root filesystem, as you can see from the loaded modules.
> 
> Bagas, FWIW, I'd totally understand if developers will ignore this
> (remains to be seen if that is the case, maybe we are lucky and somebody
> will take a look), as I think you for now shouldn't have forwarded this
> for two reasons:
> 
> * 6.3.y is old and EOL; testing mainline or at least a fresh 6.4.y
> kernel) would have been a must here.
> * with out-of-tree modules like ZFS anything can happen, the user is own
> its own.
> 

I have already asked the reporter to try reproducing this with
"officially-supported" other filesystems (e.g. ext4, xfs, or btrfs).
The reporter also stated that he was now trying the mainline (but not
rc release, just latest stable).

> As I can see from the bug both things will likely clear up soon, hence
> waiting would have been wise here.
> 
> Please in the future do not forward such bugs, as developers might
> otherwise start to ignore mails wrt to regression tracking -- which we
> really need to avoid, as that will make things a lot harder.
> 

Thanks for another tip!

-- 
An old man doll... just what I always wanted! - Clara

