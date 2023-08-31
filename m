Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7AC78F01C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbjHaPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbjHaPTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:19:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6E7E5E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:19:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so6856915ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693495155; x=1694099955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/oC9BzvxaceMGHbIWoQh4iOvX8/1tUpbJQYA6I/O+Y=;
        b=JcFMdo261f0dbb4oOZQHGJ8WjIk/nFA+q7zP7DX5AO4tFhGVlAJmV9ZnATi+ykeNoQ
         II1xVIRkiDBxSSwHymgIkJXfOFHLTnft84jD8ULJMy3CGTKPu7vPih7+2lNvG+36v4H7
         zZdUvLspEENiy8uTS607Tzg6ISbnlK4sgGyC3RhD7YfYwyn+AcIZRCi8fVlAKR7BHKsK
         2J998XIHl/W37Hf5Nf9a9FBsf4f95rsHWuOE6Q55z83NqXTsNC7yosz0r+TXFO4J5S/d
         CAYFTeS07E1rEGQruQ3OmS2ys7YJqc99MK7gneYxaheEpvawNfUhKK/ymVRVaOKG7P5T
         LLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495155; x=1694099955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/oC9BzvxaceMGHbIWoQh4iOvX8/1tUpbJQYA6I/O+Y=;
        b=NHBS/9ozGRtM2Q+CqYux5lBc6CDDFWUs4aSF7wtuxDpqLmHO7AlsAcu1hjE3xdZc7K
         YZQXzVjrV8MBBopZmGUDjf05W2VkBwnYKQp6n2subFaMzNId6IiAszLWjB5tSf2jpAbT
         qWwgeOHThsKIFirIGP/nnWZrJrxzYeTn2InUsGNK3HdrL9SfD/spS9v6Ne8A/nD6dSiF
         HfU1baoOC2jK4fAIRrRuIwAqVRv38bql7z943kyjKpoVUyo49y5YAJrDFO3gyZyjSHkv
         iVjWLGufIP5BkazRUZIsDE74dKC9N+rHEz1UlYXRFSmjexXAEpYPM+SaSJ5JPRACfZml
         EueQ==
X-Gm-Message-State: AOJu0YzsUYT+KbP7Sp46dIcUQTV7m74ThUedYR55ijrS45WtLiPBtUPy
        YohFmEPlkul5EBbzpPoX4Lw=
X-Google-Smtp-Source: AGHT+IGIS7G4ToDoe5lC2A/vLDNcKjVwvaUH594eytpS3UknzaXcdyY+egAjDfEufcTx0oRO6EbQFw==
X-Received: by 2002:a17:902:e744:b0:1bb:b226:52a0 with SMTP id p4-20020a170902e74400b001bbb22652a0mr13952plf.44.1693495154610;
        Thu, 31 Aug 2023 08:19:14 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170902efd400b001bdc6ca748esm1386625plb.185.2023.08.31.08.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 08:19:14 -0700 (PDT)
Message-ID: <ae6ce935-96eb-3d40-f252-54fff7eb0ea9@gmail.com>
Date:   Thu, 31 Aug 2023 20:49:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbFindLeaf
Content-Language: en-US
To:     Dave Kleikamp <dave.kleikamp@oracle.com>, shaggy@kernel.org,
        liushixin2@huawei.com
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
References: <20230829165244.460154-1-ghandatmanas@gmail.com>
 <e62dbf53-9d74-45e5-b44e-53140672b8b5@oracle.com>
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <e62dbf53-9d74-45e5-b44e-53140672b8b5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if we could implement a get_tree_size macro wherein  we 
could find the tree size so that we can do the comparison. SInce the 
tp->dmt_stree is an array we can get its size and fix the out of bounds. 
Would this thing work?

On 30/08/23 00:08, Dave Kleikamp wrote:
> This won't work. dbFindLeaf() can be called from dbFindCtl() with 
> struct dmapctl whose stree index can be as high as CTLTREESIZE which 
> is larger than TREESIZE. A check against CTLTREESIZE might be better 
> than nothing at all but won't necessarily detect an overflow. 
> Currently, dbFindLeaf doesn't have anything to tell it which tree it 
> is working on.
>
> We could pass in the treesize as an argument to dbFindCtl() if we 
> can't come up with something simpler.
>
> Shaggy
>
>>
>> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
>> Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
>> ---
>>   fs/jfs/jfs_dmap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>> index a14a0f18a4c4..5af17b2287be 100644
>> --- a/fs/jfs/jfs_dmap.c
>> +++ b/fs/jfs/jfs_dmap.c
>> @@ -2948,6 +2948,10 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, 
>> int *leafidx)
>>               /* sufficient free space found.  move to the next
>>                * level (or quit if this is the last level).
>>                */
>> +
>> +            if (x + n > TREESIZE)
>> +                return -ENOSPC;
>> +
>>               if (l2nb <= tp->dmt_stree[x + n])
>>                   break;
>>           }
