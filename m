Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB17E581E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjKHNtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjKHNtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:49:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6F51BEC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:49:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc0e78ec92so47367665ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699451348; x=1700056148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOVQvjAd30bPlrgwF/zoJUn8J/52P5ntF/Um+egF0hQ=;
        b=VuycCNvMymM/h1Qvw+w78BGidpJXgnTovcl50r7aYU8kXdqfH3wXKOksOwxg+6cPEp
         kYUzvGOy9xfguva/2p8/EGFx/6TBNcJISq3h3Ie5C4AlzDlra8oS2gfoJDVYlRnZAgpv
         nF1VmTkXyYDZRgTAZZmhUE/8PmJmDJ8qlr7lKd0M8VIV64Q8pQUf/DafeGDIJrUZOvY4
         zn7dbiSc2SJZ6pxSQ3tM8dZtTn5Ye090Hqu7b0rODNfFxj93LM4LDsNvUZx6Zg3xyvwC
         cubTvJ99A1LrID8ttmQnkG2RVrIy+r/OOl2lWxN7bTRcpDrgZAIQwNGI67+BzqLJeqnQ
         sRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699451348; x=1700056148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOVQvjAd30bPlrgwF/zoJUn8J/52P5ntF/Um+egF0hQ=;
        b=rB8tyZ6wBjnWAxrAdJXKwieHYHeS3oAvrb0VhwYWt0H8jtaDwZlz6BX3uM3+AYZWUP
         5kKHZlLG7ILdLojsNbqQXMXOwQ69QebJumzWBD/7jeF5i78hKvqAR6CFC9xdUzsnbn3R
         UqMZ6efYR8dsysboD/GtPdRvVZjzNH8+5wq7sbWRLvx8mj7+ey4R8I+lKuEQrHlHqU2m
         CIMCxwvUtiA+VvqPzXT3md/VsgJBZ5tgf5B29PiTNOxcbrogW43G8rHx09brLMfyi+8X
         wlRVdIChnGubOhbmcEnsODhZ3L3ezA1TRQrPT06raESOJrDLPu2uEtVig1Jh4tSRVadi
         fNUw==
X-Gm-Message-State: AOJu0YyuLzld2GS5FolmBGNBOozQ1vDhJGXqFyCONxqCtKYFeFtovZri
        4QmQcK1+OFWKl4k/Ikd+Gpv+LBo0/8A=
X-Google-Smtp-Source: AGHT+IENTLxUJKFCXpcr7DVd+xUScGlCIJEQlS19CZynEIHEZsdBattk0qL1LdRIbwXmT4J++pGgyw==
X-Received: by 2002:a17:903:41cd:b0:1cc:6fa6:ab62 with SMTP id u13-20020a17090341cd00b001cc6fa6ab62mr2087355ple.29.1699451348378;
        Wed, 08 Nov 2023 05:49:08 -0800 (PST)
Received: from [192.168.50.127] ([164.70.122.136])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001a98f844e60sm1755756plj.263.2023.11.08.05.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 05:49:07 -0800 (PST)
Message-ID: <670ce4a6-f00c-dbe9-86e2-366311221cf3@gmail.com>
Date:   Wed, 8 Nov 2023 21:48:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] f2fs: fix fallocate failed under pinned block
 situation
To:     Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231030094024.263707-1-bo.wu@vivo.com>
 <c181256e-9f6e-d43e-4d02-a7d8d5286d56@kernel.org>
Content-Language: en-US
From:   Wu Bo <wubo.oduw@gmail.com>
In-Reply-To: <c181256e-9f6e-d43e-4d02-a7d8d5286d56@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/7 22:39, Chao Yu wrote:
> On 2023/10/30 17:40, Wu Bo wrote:
>> If GC victim has pinned block, it can't be recycled.
>> And if GC is foreground running, after many failure try, the pinned file
>> is expected to be clear pin flag. To enable the section be recycled.
>>
>> But when fallocate trigger FG_GC, GC can never recycle the pinned
>> section. Because GC will go to stop before the failure try meet the 
>> threshold:
>>     if (has_enough_free_secs(sbi, sec_freed, 0)) {
>>         if (!gc_control->no_bg_gc &&
>>             total_sec_freed < gc_control->nr_free_secs)
>>             goto go_gc_more;
>>         goto stop;
>>     }
>>
>> So when fallocate trigger FG_GC, at least recycle one.
>
> Hmm... it may break pinfile's semantics at least on one pinned file?
> In this case, I prefer to fail fallocate() rather than unpinning file,
> in order to avoid leaving invalid LBA references of unpinned file held
> by userspace.

As f2fs designed now, FG_GC is able to unpin the pinned file.

fallocate() triggered FG_GC, but can't recycle space.  It breaks the 
design logic of FG_GC.

This issue is happened in Android OTA scenario.  fallocate() always 
return failure cause OTA fail.

  And this commit changed previous behavior of fallocate():

Commit 2e42b7f817ac ("f2fs: stop allocating pinned sections if EAGAIN 
happens")

Before this commit, if fallocate() meet this situation, it will trigger 
FG_GC to recycle pinned space finally.

FG_GC is expected to recycle pinned space when there is no more free 
space.  And this is the right time to do it when fallocate() need free 
space.

It is weird when f2fs shows enough spare space but can't fallocate(). So 
I think it should be fixed.

>
> Thoughts?
>
> Thanks,
>
>>
>> This issue can be reproduced by filling f2fs space as following layout.
>> Every segment has one block is pinned:
>> +-+-+-+-+-+-+-----+-+
>> | | |p| | | | ... | | seg_n
>> +-+-+-+-+-+-+-----+-+
>> +-+-+-+-+-+-+-----+-+
>> | | |p| | | | ... | | seg_n+1
>> +-+-+-+-+-+-+-----+-+
>> ...
>> +-+-+-+-+-+-+-----+-+
>> | | |p| | | | ... | | seg_n+k
>> +-+-+-+-+-+-+-----+-+
>>
>> And following are steps to reproduce this issue:
>> dd if=/dev/zero of=./f2fs_pin.img bs=2M count=1024
>> mkfs.f2fs f2fs_pin.img
>> mkdir f2fs
>> mount f2fs_pin.img ./f2fs
>> cd f2fs
>> dd if=/dev/zero of=./large_padding bs=1M count=1760
>> ./pin_filling.sh
>> rm padding*
>> sync
>> touch fallocate_40m
>> f2fs_io pinfile set fallocate_40m
>> fallocate -l 41943040 fallocate_40m
>>
>> fallocate always fail with EAGAIN even there has enough free space.
>>
>> 'pin_filling.sh' is:
>> count=1
>> while :
>> do
>>      # filling the seg space
>>      for i in {1..511}:
>>      do
>>          name=padding_$count-$i
>>          echo write $name
>>          dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
>>          if [ $? -ne 0 ]; then
>>                  exit 0
>>          fi
>>      done
>>      sync
>>
>>      # pin one block in a segment
>>      name=pin_file$count
>>      dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
>>      sync
>>      f2fs_io pinfile set $name
>>      count=$(($count + 1))
>> done
>>
>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>> ---
>>   fs/f2fs/file.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index ca5904129b16..e8a13616543f 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1690,7 +1690,7 @@ static int f2fs_expand_inode_data(struct inode 
>> *inode, loff_t offset,
>>               .init_gc_type = FG_GC,
>>               .should_migrate_blocks = false,
>>               .err_gc_skipped = true,
>> -            .nr_free_secs = 0 };
>> +            .nr_free_secs = 1 };
>>       pgoff_t pg_start, pg_end;
>>       loff_t new_size;
>>       loff_t off_end;
