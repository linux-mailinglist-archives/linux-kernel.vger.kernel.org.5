Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0795785687
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjHWLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjHWLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:13:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB587184
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:12:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so2850357b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692789166; x=1693393966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9l/C/Em55hDWEZsHiOtUwvmf9bvizEENoPNvEct/EfI=;
        b=KP1ChHFNfM0e8toOlV+hECyU3u1mwZA4fCDAIuIBoDsCINkYYwUNx/uyNtnzVS1X+W
         tLlWGrw4f31BtIWSLy/MKwD2LysTeZPQjA/pvFNsf4aOGaM2IiJuIx6O8vmDU48DTSeR
         aWmZwfKSZy8U5Nh/LRsbJvk7BdR8IE8HWUiPt3xWoyH9dH0psaU9LfYkVVMyLtqX6lEw
         En7Yz8R7yFeGrv1l0UxpDPS5An2HvGCgplhkvNEZ3w1ILVNL/DQSEMxbtTqLS3F0+gqk
         exBdyVgu/fMj9G7MQym2TQ1KNBlSOsYu30fxLGZC13pgE6zCjt/8oL4uO9nCN7o/tgDq
         hLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692789166; x=1693393966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9l/C/Em55hDWEZsHiOtUwvmf9bvizEENoPNvEct/EfI=;
        b=k1Pq6kBku0WcaCmIo6CKJsW07LBuPhDSvpnHZEGGwSP1e5kuy4SmSzd++Se9T3jIRA
         4R2K8o+GWUwDqmBGjqV2ZM0VAX7rlUGepvKPh1k7gCw/SpKWGRfEQqTNTa4+OcGgofKb
         h3CJIxWRXlufI5fuo/O1/ysuGxP74ujYXfrjqUYzYbmPxZVHRKD98wZhg05deJBcNn+l
         3wYo4XFyJSkPtGRv0yB5aJ+52ID64zXUQX91Wb3Ck9DdSXZVrtS535pwRsrshs98Zypr
         Ayw8E3bo0ICbwhXdFJ4xSQV75hcu4giDGBiOkidncBFfUYW4B6HORZgRiOMWcl+pGz83
         7i1A==
X-Gm-Message-State: AOJu0YwBlSwSXAHQ7XfuIm0a16W42uDfKAhIaRETHmVeGT3N/R/xmszg
        K7xHHEShc8HESBlRqtWGz8HONvwYuLhJiBYFduo=
X-Google-Smtp-Source: AGHT+IH6qjCXnJXfdTQcWKr9U/NGAmqaIa6a51NYKXyh+nsa4CDocmJi35FlCNTOYm6GU3g0v8EN1g==
X-Received: by 2002:a05:6a21:3d8b:b0:132:ef90:1d1d with SMTP id bj11-20020a056a213d8b00b00132ef901d1dmr13871845pzc.0.1692789166350;
        Wed, 23 Aug 2023 04:12:46 -0700 (PDT)
Received: from [10.255.208.99] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001bb99e188fcsm10702619plg.194.2023.08.23.04.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 04:12:45 -0700 (PDT)
Message-ID: <446c65f1-e5e9-4f99-467f-a64654bcf131@bytedance.com>
Date:   Wed, 23 Aug 2023 19:12:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/5] fuse: add FOPEN_INVAL_ATTR
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@jcix.top
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
 <20230711043405.66256-4-zhangjiachen.jaycee@bytedance.com>
 <CAJfpegtocWjfqVUpdnct-1-pq_DYJXUuvkBWey2N5q6+K=pL_w@mail.gmail.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <CAJfpegtocWjfqVUpdnct-1-pq_DYJXUuvkBWey2N5q6+K=pL_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/23 17:01, Miklos Szeredi wrote:
> On Tue, 11 Jul 2023 at 06:36, Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
>>
>> Add FOPEN_INVAL_ATTR so that the fuse daemon can ask kernel to invalidate
>> the attr cache on file open.
>>
>> The fi->attr_version should be increased when handling FOPEN_INVAL_ATTR.
>> Because if a FUSE request returning attributes (getattr, setattr, lookup,
>> and readdirplus) starts before a FUSE_OPEN replying FOPEN_INVAL_ATTR, but
>> finishes after the FUSE_OPEN, staled attributes will be set to the inode
>> and falsely clears the inval_mask.
>>
>> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>> ---
>>   fs/fuse/file.c            | 10 ++++++++++
>>   include/uapi/linux/fuse.h |  2 ++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index de37a3a06a71..412824a11b7b 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -215,6 +215,16 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>>                  file_update_time(file);
>>                  fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>>          }
>> +
>> +       if (ff->open_flags & FOPEN_INVAL_ATTR) {
>> +               struct fuse_inode *fi = get_fuse_inode(inode);
>> +
>> +               spin_lock(&fi->lock);
>> +               fi->attr_version = atomic64_inc_return(&fc->attr_version);
> 
> No need to add locking or change fi->attr_version.  This will be done
> next time the attributes are updated.
> 
> Thanks,
> Miklos

Hi Miklos,

Thanks for the review! As said in the commit message, increasing the
attr version here is to prevent the attr updated by staled operations. 
If such cases happen, inval_mask will be falsely cleared, and 
FOPEN_INVAL_ATTR takes no effect from the user's point of view.

The increasing of attr_version here can also be explained as the
attr has been updated from the server side.

Thanks,
Jiachen
