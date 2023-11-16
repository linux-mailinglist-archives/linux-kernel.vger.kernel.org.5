Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACDC7EE9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjKPXe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345566AbjKPXey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:34:54 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95398E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:34:50 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bde80aad05so1129375a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700177690; x=1700782490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkULf3scFhzjS1dsneFzkF5D5dL5G0jCH8/xfWwP8Cg=;
        b=k74gpbnjC+xhbCxGrf4pWuTh0+cfiNoquVXF4zieKW+I8r/qfBK2IBF2X84aeY/8WE
         zt/uPkKRsmTcN/zZgaQpxbHg9ODs5aoaUOhMWFrwg9KvnZ9SutjHjL8YYOMgSF5gg35q
         zy4lCk2bJzq81XH8AbxI0jXzIV9A0F4xAOjy9uOlLZHKtE7IgjPpz9nl0717ZfQGsv7i
         f/oJiloA5m9LBDdY7Oh7HxB3qbf5GBvSpfFUUGSsON4xhNBc4x/cKW3P4vHxht0QltRq
         6kSTe+GUIdgGJ/mq6Oo63gi7DZxc9CFGtVFouqm6qIFICJf9F2bihINEfNfTMNbZ5pDj
         dldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700177690; x=1700782490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkULf3scFhzjS1dsneFzkF5D5dL5G0jCH8/xfWwP8Cg=;
        b=WFRGgW+T525i+IPlgc7yJWe6vgSWshnB8uB8slXqCjtpBGz2a0+efYT+QLyRt6udaq
         Fu8G0ZLm9ftKIohzDyNhZMxJ92nFjqbBAZF+9eB6gKNbEIx++18cjGYspEzS3CfJYhh2
         WWkLlJT3HrbxPyZneJUPYVSfynjliiKkF4lmg/eqiI9FORQ6Kx/uG2JMXWiv8Wkd9Oin
         bIOyY1a/0+al8Ch2tuanP9bUng/XX/oDojkRGfD19hnc8abGzK+LDUgFu/lps6IUBhQY
         rvMGBqNufSPBEHqj6X/mS/imfF09G9VcmXNR9dB9nP02ti2RmrWJ2pfMoIlLUzKkHMRV
         62FA==
X-Gm-Message-State: AOJu0Yyr2Tv0ckCnmjvQUBRFxoaDFvRMxyyDJBVdq0hjpEGRO2ivGLEr
        Ewl95Awjo8MuxGIRZAQ6CZU=
X-Google-Smtp-Source: AGHT+IGGiCqLobfk0raoyD84ZNfIddYDfl8PqLow7tpR0awROI6jEQVNZwuOYWn087SjRblRYfWRTA==
X-Received: by 2002:a05:6a20:8f19:b0:187:afb0:c2f5 with SMTP id b25-20020a056a208f1900b00187afb0c2f5mr4278845pzk.3.1700177690176;
        Thu, 16 Nov 2023 15:34:50 -0800 (PST)
Received: from [192.168.50.127] (awork111197.netvigator.com. [203.198.94.197])
        by smtp.gmail.com with ESMTPSA id du24-20020a056a002b5800b00686b649cdd0sm272060pfb.86.2023.11.16.15.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 15:34:49 -0800 (PST)
Message-ID: <faa90acc-c03e-2913-c19a-bd50fd93d197@gmail.com>
Date:   Fri, 17 Nov 2023 07:34:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] f2fs: fix fallocate failed under pinned block
 situation
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231030094024.263707-1-bo.wu@vivo.com>
 <c181256e-9f6e-d43e-4d02-a7d8d5286d56@kernel.org>
 <670ce4a6-f00c-dbe9-86e2-366311221cf3@gmail.com>
 <a69b7544-2312-486c-d655-8b86e370c55e@kernel.org>
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <a69b7544-2312-486c-d655-8b86e370c55e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/11 12:49, Chao Yu wrote:
> On 2023/11/8 21:48, Wu Bo wrote:
>> On 2023/11/7 22:39, Chao Yu wrote:
>>> On 2023/10/30 17:40, Wu Bo wrote:
>>>> If GC victim has pinned block, it can't be recycled.
>>>> And if GC is foreground running, after many failure try, the pinned 
>>>> file
>>>> is expected to be clear pin flag. To enable the section be recycled.
>>>>
>>>> But when fallocate trigger FG_GC, GC can never recycle the pinned
>>>> section. Because GC will go to stop before the failure try meet the
>>>> threshold:
>>>>      if (has_enough_free_secs(sbi, sec_freed, 0)) {
>>>>          if (!gc_control->no_bg_gc &&
>>>>              total_sec_freed < gc_control->nr_free_secs)
>>>>              goto go_gc_more;
>>>>          goto stop;
>>>>      }
>>>>
>>>> So when fallocate trigger FG_GC, at least recycle one.
>>>
>>> Hmm... it may break pinfile's semantics at least on one pinned file?
>>> In this case, I prefer to fail fallocate() rather than unpinning file,
>>> in order to avoid leaving invalid LBA references of unpinned file held
>>> by userspace.
>>
>> As f2fs designed now, FG_GC is able to unpin the pinned file.
>>
>> fallocate() triggered FG_GC, but can't recycle space.  It breaks the
>> design logic of FG_GC.
>
> Yes, contradictoriness exists.
>
> IMO, unpin file by GC looks more dangerous, it may cause potential data
> corruption w/ below case:
> 1. app pins file & holds LBAs of data blocks.
> 2. GC unpins file and migrates its data to new LBAs.
> 3. other file reuses previous LBAs.
> 4. app read/write data via previous LBAs.
>
> So I suggest to normalize use of pinfile and do not add more unpin cases
> in filesystem inner processes.
>
>>
>> This issue is happened in Android OTA scenario.  fallocate() always
>> return failure cause OTA fail.
>
> Can you please check why other pinned files were so fragmented that 
> f2fs_gc()
> can not recycle one free section?
>
Not because pinned files were fragmented, but if the GC victim section 
has one block is pinned will cause this issue.

If the section don't unpin the block, it can't be recycled. But there is 
high chance that the pinned section will be chosen next time under f2fs 
current victim selection strategy.

So if we want to avoid unpin files, I think change victim selection to 
considering pinned blocks can fix this issue.

> Thanks,
>
>>
>>    And this commit changed previous behavior of fallocate():
>>
>> Commit 2e42b7f817ac ("f2fs: stop allocating pinned sections if EAGAIN
>> happens")
>>
>> Before this commit, if fallocate() meet this situation, it will trigger
>> FG_GC to recycle pinned space finally.
>>
>> FG_GC is expected to recycle pinned space when there is no more free
>> space.  And this is the right time to do it when fallocate() need free
>> space.
>>
>> It is weird when f2fs shows enough spare space but can't fallocate(). So
>> I think it should be fixed.
>>
>>>
>>> Thoughts?
>>>
>>> Thanks,
>>>
>>>>
>>>> This issue can be reproduced by filling f2fs space as following 
>>>> layout.
>>>> Every segment has one block is pinned:
>>>> +-+-+-+-+-+-+-----+-+
>>>> | | |p| | | | ... | | seg_n
>>>> +-+-+-+-+-+-+-----+-+
>>>> +-+-+-+-+-+-+-----+-+
>>>> | | |p| | | | ... | | seg_n+1
>>>> +-+-+-+-+-+-+-----+-+
>>>> ...
>>>> +-+-+-+-+-+-+-----+-+
>>>> | | |p| | | | ... | | seg_n+k
>>>> +-+-+-+-+-+-+-----+-+
>>>>
>>>> And following are steps to reproduce this issue:
>>>> dd if=/dev/zero of=./f2fs_pin.img bs=2M count=1024
>>>> mkfs.f2fs f2fs_pin.img
>>>> mkdir f2fs
>>>> mount f2fs_pin.img ./f2fs
>>>> cd f2fs
>>>> dd if=/dev/zero of=./large_padding bs=1M count=1760
>>>> ./pin_filling.sh
>>>> rm padding*
>>>> sync
>>>> touch fallocate_40m
>>>> f2fs_io pinfile set fallocate_40m
>>>> fallocate -l 41943040 fallocate_40m
>>>>
>>>> fallocate always fail with EAGAIN even there has enough free space.
>>>>
>>>> 'pin_filling.sh' is:
>>>> count=1
>>>> while :
>>>> do
>>>>       # filling the seg space
>>>>       for i in {1..511}:
>>>>       do
>>>>           name=padding_$count-$i
>>>>           echo write $name
>>>>           dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
>>>>           if [ $? -ne 0 ]; then
>>>>                   exit 0
>>>>           fi
>>>>       done
>>>>       sync
>>>>
>>>>       # pin one block in a segment
>>>>       name=pin_file$count
>>>>       dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
>>>>       sync
>>>>       f2fs_io pinfile set $name
>>>>       count=$(($count + 1))
>>>> done
>>>>
>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>> ---
>>>>    fs/f2fs/file.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index ca5904129b16..e8a13616543f 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -1690,7 +1690,7 @@ static int f2fs_expand_inode_data(struct inode
>>>> *inode, loff_t offset,
>>>>                .init_gc_type = FG_GC,
>>>>                .should_migrate_blocks = false,
>>>>                .err_gc_skipped = true,
>>>> -            .nr_free_secs = 0 };
>>>> +            .nr_free_secs = 1 };
>>>>        pgoff_t pg_start, pg_end;
>>>>        loff_t new_size;
>>>>        loff_t off_end;
