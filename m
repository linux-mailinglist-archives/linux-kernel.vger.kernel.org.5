Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893AD790900
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjIBRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjIBRpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:45:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D98B6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 10:45:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5657add1073so63075a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693676731; x=1694281531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+CEe1kQgL3CtWd7NtdDdKsaq4sRrpDW37EyXWEdo+I=;
        b=M06Yrxn+C85COQlEb7ldV1xJ9Ew53h2ki8/JAE7+0CIa0qbKML0IrjVGC0aCSwAFTz
         Zvc1883v0NG98TgRVYxqFP/mo/ndRKem2H30nvnWE8hNVuWMezSRz4B0YyhdYhl6TskV
         +xCmUTCbZ49JAVzEGoc/rb2X0mTASUXAXjYgZ9ChLmJGPC9qZ4KP/+T03rftsp4NQPVa
         3K7EtXVKaIz9IS6dvJVJi413Z6FAoJqVToJLRvS0jjzQGEn1uMnTY7dtoIcxZ4UrKYCm
         P7xmRQ4h2Kdylory7lcf12h9LMPwNTJAiMUgLF2fHYvpDuAsbVeyiOieU5gSRYIZv2bq
         ULoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693676731; x=1694281531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+CEe1kQgL3CtWd7NtdDdKsaq4sRrpDW37EyXWEdo+I=;
        b=XLbo5GZiCLcbTsNNZHlsEnT3sivJ+j6Hwwlbh2YECkRktkzWJ7AODlh6Iqaa6QkZWl
         mXtUPg3DeZnfKdoYcJQNCmyugxl2PCnt8XPv6B8yBN6Q7KQvkC6qAEyinHNoP8XHGq8X
         R2ubxVnu6xZTT7E8h7F8oFwjcHIH0SbL5bpz1spTeC3BQfYw5YXkDLcGoU2AVKPEN79f
         ZxxYbvAOPLwqugBKXoL/cXsWERKv7K/64J8+6IDNxr2bvw4wpl+v9XjYi4oNU1IS/+y4
         TrxmIsRzckSo9UKJViHQJpplj31XxYgkhCnXzCnOKzPBmLzkec5I9d/s+kJ7WQS9Rpd9
         piFg==
X-Gm-Message-State: AOJu0YyIEEaqzVm9CtXApjW8y8qRuVb4qqB6yrhmFOb+tTiMZRMt/EsN
        iXDf/5Ltdd3v1adTGjeoaNe+kzlnOjau7fLWJtk=
X-Google-Smtp-Source: AGHT+IHcW13GWHmbrC7g20OUYOCfiODO7gIhf43SwkGdC5kUnbwO3HluVe9PQ4GHWH47f6DSUCa7Rw==
X-Received: by 2002:a05:6a20:2591:b0:14d:6a82:d7ea with SMTP id k17-20020a056a20259100b0014d6a82d7eamr7049410pzd.13.1693676730977;
        Sat, 02 Sep 2023 10:45:30 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id e13-20020a62aa0d000000b006889664aa6csm4817511pff.5.2023.09.02.10.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 10:45:30 -0700 (PDT)
Message-ID: <5dd9b332-49e3-877d-125b-1de5b46af4d5@gmail.com>
Date:   Sat, 2 Sep 2023 23:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbFindLeaf
To:     Dave Kleikamp <dave.kleikamp@oracle.com>, shaggy@kernel.org,
        liushixin2@huawei.com
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
References: <20230829165244.460154-1-ghandatmanas@gmail.com>
 <e62dbf53-9d74-45e5-b44e-53140672b8b5@oracle.com>
 <ae6ce935-96eb-3d40-f252-54fff7eb0ea9@gmail.com>
 <f9475918-2186-49b8-b801-6f0f9e75f4fa@oracle.com>
Content-Language: en-US
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <f9475918-2186-49b8-b801-6f0f9e75f4fa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I was talking about the stree attribute of dmtree which is 
present in both dmaptree and dmapctl.

Link : https://elixir.bootlin.com/linux/v6.5.1/source/fs/jfs/jfs_dmap.h#L168

Since it is an array we can add a check for the size of array like the 
code below.


+            if (x + n > (sizeof(tp->dmt_stree)/sizeof(s8)))
+                 return -ENOSPC;

On 01/09/23 22:38, Dave Kleikamp wrote:
> On 8/31/23 10:19AM, Manas Ghandat wrote:
>> I was wondering if we could implement a get_tree_size macro wherein  
>> we could find the tree size so that we can do the comparison. SInce 
>> the tp->dmt_stree is an array we can get its size and fix the out of 
>> bounds. Would this thing work?
>
> dmtree_t is a union of two nearly identical structures that both 
> contain an stree. The only real difference in the structures is the 
> size of the stree, so dbFindLeaf doesn't really know which is being 
> used by the caller.
>
