Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41ED781DFF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjHTNtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjHTNs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:48:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A68F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:43:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf48546ccfso8720575ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692539037; x=1693143837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIc6ZgR3jaW2rTLhnT91fRRNt6h6j7md3wuAMtiDu1Y=;
        b=f6d09OqsK3KI72hr+oLpBiWLs19u4qrlaFRXzE9H80N/dVnTFN4I5KmSSVBBLfTrXv
         EsmQSTcz6OcA8U2WHnU47u/179AKYbZSaHWicv7OmsFSkpXiWRGO7XALKBIU8g9YBXn7
         CT1DNUV7MZAURk8DlrDiqiWhA7Lw7TrL17gBM3Z4mGwZCBeq+TSVhrcpfkdYMzsOXGUj
         hDuvd+gkU8hQgOq6+x6UPP2FcTfDiMWTSq8bNrc9w0AYVJe5nO7mT+hjCUQJHOGR1aFC
         Cmvo7Ww7KXiyA+ZJfsxSVI+mgG1kD8Zv4gJWNvmP8WiPOMdlEAKewgSXx0s5AQHxJyiu
         cwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692539037; x=1693143837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIc6ZgR3jaW2rTLhnT91fRRNt6h6j7md3wuAMtiDu1Y=;
        b=JwWqUaWhtOqJWIzypQc0XAJkDqXoNSG+/kmYM8LILivfFTL2nVtqCbn6DUwxpU4TEp
         EkhpXS5E+sBQtJ3kMMSSt+5eNB1bX+heA5fXjXRhnJ9xFDz7A4jnGWvrpNVgP31/Ei3s
         n81d3Rym56kGUoltqDexLSl0yGe0247b1ay4v2P3Mae7GwMtrlfJ3rkbZzaF+x3ZEoCN
         E2mwTn1Q22k9K8nfsai/8YpLXP/yJIZXEOyZhFARqXMZv97nu5imPn2cVB1jfqph6iSx
         WaDCns5/QRJl+Qvxw+Y7fNhO37yzhpF+HYYioo5eKPL0vMkt0uaUwbTwnNlYfkYqnbW1
         C6bw==
X-Gm-Message-State: AOJu0YzQH662py9oOdm68j+Kdt+J83Iqhdfdy+Hmay4ZuZ/thw9XjkbE
        6YoEfi3xKr8VLziQOCdAQSk=
X-Google-Smtp-Source: AGHT+IHAycM2Mi8Cc+F3dGF+HT//EpUe+8fNUyOkqX+v9g+xe3qaKMj2uX4E23CsfHy4deM51XuXPQ==
X-Received: by 2002:a17:902:70cc:b0:1bc:9c70:b955 with SMTP id l12-20020a17090270cc00b001bc9c70b955mr2315532plt.28.1692539036968;
        Sun, 20 Aug 2023 06:43:56 -0700 (PDT)
Received: from [192.168.50.127] (awork083154.netvigator.com. [203.198.87.154])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001bc6fe1b9absm3550133plw.276.2023.08.20.06.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 06:43:56 -0700 (PDT)
Message-ID: <f93c210b-6b55-98b1-9b72-a0a5a81b9046@gmail.com>
Date:   Sun, 20 Aug 2023 21:42:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: move fiemap to use iomap framework
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>, chao@kernel.org
Cc:     daehojeong@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <791fbf71-093e-3ef5-b02b-6d6bba72b57f@kernel.org>
 <20230807023823.49564-1-bo.wu@vivo.com>
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <20230807023823.49564-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On 2023/8/7 10:38, Wu Bo wrote:
> On 2023/8/6 10:05, Chao Yu wrote:
>
>> On 2023/7/31 9:26, Wu Bo wrote:
>>> This patch has been tested with xfstests by running 'kvm-xfstests -c
>>> f2fs -g auto' with and without this patch; no regressions were seen.
>>>
>>> Some tests fail both before and after, and the test results are:
>>> f2fs/default: 683 tests, 9 failures, 226 skipped, 30297 seconds
>>>     Failures: generic/050 generic/064 generic/250 generic/252 generic/459
>>>         generic/506 generic/563 generic/634 generic/635
>> Can you please take a look at gerneic/473 ?
> This generic/473 case is failed on xfs too. It's an issue of iomap.
>
>> generic/473 1s ... - output mismatch (see
>> /media/fstests/results//generic/473.out.bad)
>>      --- tests/generic/473.out    2022-11-10 08:42:19.231395230 +0000
>>      +++ /media/fstests/results//generic/473.out.bad    2023-08-04
>> 02:02:01.000000000 +0000
>>      @@ -6,7 +6,7 @@
>>       1: [256..287]: hole
>>       Hole + Data
>>       0: [0..127]: hole
>>      -1: [128..255]: data
>>      +1: [128..135]: data
>>       Hole + Data + Hole
>>       0: [0..127]: hole
>>      ...
>>      (Run 'diff -u /media/fstests/tests/generic/473.out
>> /media/fstests/results//generic/473.out.bad'  to see the entire diff)
> The layout of the test file is:
> fiemap.473:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..127]:        hole               128
>     1: [128..255]:      5283840..5283967   128 0x1000
>     2: [256..383]:      hole               128
>     3: [384..511]:      5283968..5284095   128 0x1000
>
> And the test command is:
> xfs_io -c "fiemap -v 0 65k" fiemap.473
>
> So the difference is about when to stop traversal the extents.
> The iomap stop when the length beyond it is requested from fiemap command:
> ...
> xfs_io-7399    [001] .....  1385.656328: f2fs_map_blocks: dev = (254,48), ino = 5, file offset = 15, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> xfs_io-7399    [001] .....  1385.656328: f2fs_map_blocks: dev = (254,48), ino = 5, file offset = 16, start blkaddr = 0x3400, len = 0x1, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
>
> While previous logic is that stop traversal until next data extent is found:
> ...
> xfs_io-2194    [000] .....   116.046690: f2fs_map_blocks: dev = (254,48), ino = 5, file offset = 15, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> xfs_io-2194    [000] .....   116.046690: f2fs_map_blocks: dev = (254,48), ino = 5, file offset = 16, start blkaddr = 0xa1400, len = 0x10, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> xfs_io-2194    [000] .....   116.046691: f2fs_map_blocks: dev = (254,48), ino = 5, file offset = 32, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> ...
> xfs_io-2194    [000] .....   116.046706: f2fs_map_blocks: dev = (254,48), ino = 5, file offset = 48, start blkaddr = 0xa1410, len = 0x10, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
>
>> Other concern is, it needs to test this implementation on compressed
>> file,
>> since the logic is a little bit complicated.
> To be honest, all the complex logic is try to handle compressed file situation.
>
> I used enwiki8 dataset to test compressed file:
>      mkfs.f2fs -f -O extra_attr,compression f2fs.img
>      mount f2fs.img f2fs -o compress_algorithm=lz4,compress_log_size=3,compress_mode=user
>      touch compressed_file
>      f2fs_io setflags compression compressed_file
>      cat enwiki8 > compressed_file
>      f2fs_io compress compressed_file
>      f2fs_io release_cblocks compressed_file
>      xfs_io -c fiemap compressed_file | awk '{print $2 $3}'
>
> enwiki8 download url: http://mattmahoney.net/dc/enwik8.zip
>
> And the result is:
> --- a/orig
> +++ b/new
> @@ -1750,8 +1750,8 @@
>   [111872..111935]:323448..323511
>   [111936..111999]:323488..323551
>   [112000..112063]:323520..323583
> -[112064..112087]:323560..323583
> -[112088..112127]:53248..53287
> +[112064..112095]:323560..323591
> +[112096..112127]:53248..53279
>   [112128..112191]:53256..53319
>   [112192..112255]:53288..53351
>   [112256..112319]:53328..53391
> @@ -2078,10 +2078,8 @@
>   [132800..132863]:65408..65471
>   [132864..132927]:65448..65511
>   [132928..132991]:65488..65551
> -[132992..132999]:65528..65535
> -[133000..133007]:65528..65535
> -[133008..133039]:69632..69663
> -[133040..133055]:hole
> +[132992..133007]:65528..65543
> +[133008..133055]:69632..69679
>   [133056..133119]:69664..69727
>   [133120..133183]:69704..69767
>   [133184..133247]:69744..69807
>
> The first diff is I count the space of COMPRESS_ADDR belong to the head of one
> compressed cluster while previous count at the rear of cluster.
> The secound diff show the previous print a 'hole' in one cluster. I think a
> compressed cluster should not include a 'hole', so there may have a bug before.
>
> Also, as discussed in this thread:
> https://lore.kernel.org/linux-f2fs-devel/ZJmBmt3WmUpWR3+2@casper.infradead.org/T/#t
> If f2fs can support async buffer write, the performance can be greatly improved
> when using io_uring.
>
> I think it's time to move f2fs to iomap framework. And really looking forward
> to hearing your opinion on this.
>
> Thanks
