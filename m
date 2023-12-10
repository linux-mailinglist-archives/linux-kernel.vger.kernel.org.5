Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A353780BABA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjLJMzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjLJMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:55:29 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E910A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:55:35 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2e330033fso2770092b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702212934; x=1702817734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZVT0tgK307bE/wFVEQKUID391OimB39JlVcTN0lCNs=;
        b=Ji9Izb971i1toR18EmKNQn9c3Rq/MedCP5l0Iav8x4fNEcwWYT2Ebl5zfdQMG41lYQ
         Ml69ZvFcqN+o1A0WnYDPO1KLPD2f19J7o2FSYliq5V2Lr8p7x306bfxyV9IN/w07ltnL
         xRwF/REjnGIeaBNL4BD81GhKij99w89Zl79sWsv/zpBp1Nv6TodZ6C9Oq/d0wRSaC3nL
         8cglYGoqVChohC+qehNw0jcPpgzpt3q5+wQOy/rsqVNWXriS6j+pFzK9hJjyub50iuU9
         NxzVagbFQV3myj8F81Mm1gGDpKmnDNA38w7r/i78YmbrBT92g783UvSXq6iQg3DjOSAW
         0gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702212934; x=1702817734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZVT0tgK307bE/wFVEQKUID391OimB39JlVcTN0lCNs=;
        b=s+m2cDd5stnFHrKWHkCBmlSjHIPfDhrE6jxkq7l8Ucv1xfS1as6nqtYuo0E3yvhsi3
         VgncuKkbarMzT8V91QTV1mg6cwv0FE8s/G3GH97qDBH31k5qhCqhF2/QQLtecAF1Wzfm
         ZMJl0UGoSRFIK+BtEyqUJICOD3LhtnC2D3hAS+viUBtb56jmtt+uf4YwaZBYKyNlmnf8
         QLFLbeeJuNTJUQWsOa3McHaYMpV8F8fnuY0eAqY3BAqRpoPM0AOcNTnfefNLnpTHk5YG
         Xv7wnBt9A5rUeSeO/5D24AhIJ3cc9Rna3WmPczavd699p1ZrZXe2zfZpxRlMINeC80Yt
         gaBg==
X-Gm-Message-State: AOJu0YwTXUfT34GPJ73JQbC3H0fRaf60zIV18cEL5KAnGHiRdAILDYxA
        Tc4cx3G7w47nbtxR9WqvpCoKooQcgkrhEg==
X-Google-Smtp-Source: AGHT+IFZTHVfNPuUmXro4hv7IeY7KkZonKOLh3+tfqbvjZu4jJlKPGqQ66BvTGhrqa169hkSkZVW/g==
X-Received: by 2002:a05:6808:13c3:b0:3b9:fc7c:b57d with SMTP id d3-20020a05680813c300b003b9fc7cb57dmr2625229oiw.35.1702212934317;
        Sun, 10 Dec 2023 04:55:34 -0800 (PST)
Received: from [192.168.50.127] (awork111197.netvigator.com. [203.198.94.197])
        by smtp.gmail.com with ESMTPSA id dj14-20020a17090ad2ce00b00286e8fe03c1sm5074151pjb.22.2023.12.10.04.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 04:55:33 -0800 (PST)
Message-ID: <dd72cec6-cbc9-4c00-a967-841ec614102f@gmail.com>
Date:   Sun, 10 Dec 2023 20:55:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] f2fs: fix fallocate failed under pinned block
 situation
To:     Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231030094024.263707-1-bo.wu@vivo.com>
 <c181256e-9f6e-d43e-4d02-a7d8d5286d56@kernel.org>
 <670ce4a6-f00c-dbe9-86e2-366311221cf3@gmail.com>
 <a69b7544-2312-486c-d655-8b86e370c55e@kernel.org>
 <faa90acc-c03e-2913-c19a-bd50fd93d197@gmail.com>
 <5d8726fc-e912-6954-3820-862eecff07b0@kernel.org>
 <eedad403-5754-4d5e-965d-19eff02e3d40@gmail.com>
 <09cd02dd-a8d9-4b7a-8f10-b445e2c9ea85@kernel.org>
Content-Language: en-US
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <09cd02dd-a8d9-4b7a-8f10-b445e2c9ea85@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/9 17:46, Chao Yu wrote:
> On 2023/11/28 20:51, Wu Bo wrote:
>>
>> On 2023/11/28 14:22, Chao Yu wrote:
>>> On 2023/11/17 7:34, Wu Bo wrote:
>>>> On 2023/11/11 12:49, Chao Yu wrote:
>>>>> On 2023/11/8 21:48, Wu Bo wrote:
>>>>>> On 2023/11/7 22:39, Chao Yu wrote:
>>>>>>> On 2023/10/30 17:40, Wu Bo wrote:
>>>>>>>> If GC victim has pinned block, it can't be recycled.
>>>>>>>> And if GC is foreground running, after many failure try, the 
>>>>>>>> pinned file
>>>>>>>> is expected to be clear pin flag. To enable the section be 
>>>>>>>> recycled.
>>>>>>>>
>>>>>>>> But when fallocate trigger FG_GC, GC can never recycle the pinned
>>>>>>>> section. Because GC will go to stop before the failure try meet 
>>>>>>>> the
>>>>>>>> threshold:
>>>>>>>>      if (has_enough_free_secs(sbi, sec_freed, 0)) {
>>>>>>>>          if (!gc_control->no_bg_gc &&
>>>>>>>>              total_sec_freed < gc_control->nr_free_secs)
>>>>>>>>              goto go_gc_more;
>>>>>>>>          goto stop;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> So when fallocate trigger FG_GC, at least recycle one.
>>>>>>>
>>>>>>> Hmm... it may break pinfile's semantics at least on one pinned 
>>>>>>> file?
>>>>>>> In this case, I prefer to fail fallocate() rather than unpinning 
>>>>>>> file,
>>>>>>> in order to avoid leaving invalid LBA references of unpinned 
>>>>>>> file held
>>>>>>> by userspace.
>>>>>>
>>>>>> As f2fs designed now, FG_GC is able to unpin the pinned file.
>>>>>>
>>>>>> fallocate() triggered FG_GC, but can't recycle space. It breaks the
>>>>>> design logic of FG_GC.
>>>>>
>>>>> Yes, contradictoriness exists.
>>>>>
>>>>> IMO, unpin file by GC looks more dangerous, it may cause potential 
>>>>> data
>>>>> corruption w/ below case:
>>>>> 1. app pins file & holds LBAs of data blocks.
>>>>> 2. GC unpins file and migrates its data to new LBAs.
>>>>> 3. other file reuses previous LBAs.
>>>>> 4. app read/write data via previous LBAs.
>>>>>
>>>>> So I suggest to normalize use of pinfile and do not add more unpin 
>>>>> cases
>>>>> in filesystem inner processes.
>>>>>
>>>>>>
>>>>>> This issue is happened in Android OTA scenario. fallocate() always
>>>>>> return failure cause OTA fail.
>>>>>
>>>>> Can you please check why other pinned files were so fragmented 
>>>>> that f2fs_gc()
>>>>> can not recycle one free section?
>>>>>
>>>> Not because pinned files were fragmented, but if the GC victim 
>>>> section has one block is pinned will cause this issue.
>>>>
>>>> If the section don't unpin the block, it can't be recycled. But 
>>>> there is high chance that the pinned section will be chosen next 
>>>> time under f2fs current victim selection strategy.
>>>>
>>>> So if we want to avoid unpin files, I think change victim selection 
>>>> to considering pinned blocks can fix this issue.
>>>
>>> Oh, I get it.
>>>
>>> How about this?
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 325dab01a29d..3fb52dec5df8 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1730,7 +1730,10 @@ next_alloc:
>>>              f2fs_down_write(&sbi->gc_lock);
>>>              stat_inc_gc_call_count(sbi, FOREGROUND);
>>>              err = f2fs_gc(sbi, &gc_control);
>>> -            if (err && err != -ENODATA)
>>> +
>>> +            if (err == -EAGAIN)
>>> +                f2fs_balance_fs(sbi, true);
>>> +            else if (err && err != -ENODATA)
>>>                  goto out_err;
>>>          }
>> Do you mean to call f2fs_balance_fs() to recycle one section?
>> But in this situation, f2fs_balance_fs() will return at 
>> enough-free-section check:
>>      if (has_enough_free_secs(sbi, 0, 0))
>>          return;
>
> As you said, there are lots of free segments, so I guess it's fine for
> latter 2m-aligned allocation, and for the case number of free section is
> lower than fggc threshold, we can call f2fs_balance_fs() to reclaim 
> enough
> free sections.
>
> Thanks,
Yes, this make sense. I didn't see allocation will continue after 
f2fs_balance_fs() return.
>
>>>
>>> However, the code won't fix contradictoriness issue, because the 
>>> root cause
>>> is we left fragmented pinned data in filesystem, which should be 
>>> avoided in
>>> GC-reliance LFS filesyetem as much as possible.
>>>
>>> Thanks,
>>>
>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>    And this commit changed previous behavior of fallocate():
>>>>>>
>>>>>> Commit 2e42b7f817ac ("f2fs: stop allocating pinned sections if 
>>>>>> EAGAIN
>>>>>> happens")
>>>>>>
>>>>>> Before this commit, if fallocate() meet this situation, it will 
>>>>>> trigger
>>>>>> FG_GC to recycle pinned space finally.
>>>>>>
>>>>>> FG_GC is expected to recycle pinned space when there is no more free
>>>>>> space.  And this is the right time to do it when fallocate() need 
>>>>>> free
>>>>>> space.
>>>>>>
>>>>>> It is weird when f2fs shows enough spare space but can't 
>>>>>> fallocate(). So
>>>>>> I think it should be fixed.
>>>>>>
>>>>>>>
>>>>>>> Thoughts?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> This issue can be reproduced by filling f2fs space as following 
>>>>>>>> layout.
>>>>>>>> Every segment has one block is pinned:
>>>>>>>> +-+-+-+-+-+-+-----+-+
>>>>>>>> | | |p| | | | ... | | seg_n
>>>>>>>> +-+-+-+-+-+-+-----+-+
>>>>>>>> +-+-+-+-+-+-+-----+-+
>>>>>>>> | | |p| | | | ... | | seg_n+1
>>>>>>>> +-+-+-+-+-+-+-----+-+
>>>>>>>> ...
>>>>>>>> +-+-+-+-+-+-+-----+-+
>>>>>>>> | | |p| | | | ... | | seg_n+k
>>>>>>>> +-+-+-+-+-+-+-----+-+
>>>>>>>>
>>>>>>>> And following are steps to reproduce this issue:
>>>>>>>> dd if=/dev/zero of=./f2fs_pin.img bs=2M count=1024
>>>>>>>> mkfs.f2fs f2fs_pin.img
>>>>>>>> mkdir f2fs
>>>>>>>> mount f2fs_pin.img ./f2fs
>>>>>>>> cd f2fs
>>>>>>>> dd if=/dev/zero of=./large_padding bs=1M count=1760
>>>>>>>> ./pin_filling.sh
>>>>>>>> rm padding*
>>>>>>>> sync
>>>>>>>> touch fallocate_40m
>>>>>>>> f2fs_io pinfile set fallocate_40m
>>>>>>>> fallocate -l 41943040 fallocate_40m
>>>>>>>>
>>>>>>>> fallocate always fail with EAGAIN even there has enough free 
>>>>>>>> space.
>>>>>>>>
>>>>>>>> 'pin_filling.sh' is:
>>>>>>>> count=1
>>>>>>>> while :
>>>>>>>> do
>>>>>>>>       # filling the seg space
>>>>>>>>       for i in {1..511}:
>>>>>>>>       do
>>>>>>>>           name=padding_$count-$i
>>>>>>>>           echo write $name
>>>>>>>>           dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 
>>>>>>>> 2>&1
>>>>>>>>           if [ $? -ne 0 ]; then
>>>>>>>>                   exit 0
>>>>>>>>           fi
>>>>>>>>       done
>>>>>>>>       sync
>>>>>>>>
>>>>>>>>       # pin one block in a segment
>>>>>>>>       name=pin_file$count
>>>>>>>>       dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
>>>>>>>>       sync
>>>>>>>>       f2fs_io pinfile set $name
>>>>>>>>       count=$(($count + 1))
>>>>>>>> done
>>>>>>>>
>>>>>>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>>>>>>> ---
>>>>>>>>    fs/f2fs/file.c | 2 +-
>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>>> index ca5904129b16..e8a13616543f 100644
>>>>>>>> --- a/fs/f2fs/file.c
>>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>>> @@ -1690,7 +1690,7 @@ static int f2fs_expand_inode_data(struct 
>>>>>>>> inode
>>>>>>>> *inode, loff_t offset,
>>>>>>>>                .init_gc_type = FG_GC,
>>>>>>>>                .should_migrate_blocks = false,
>>>>>>>>                .err_gc_skipped = true,
>>>>>>>> -            .nr_free_secs = 0 };
>>>>>>>> +            .nr_free_secs = 1 };
>>>>>>>>        pgoff_t pg_start, pg_end;
>>>>>>>>        loff_t new_size;
>>>>>>>>        loff_t off_end;
