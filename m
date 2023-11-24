Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABEF7F7903
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjKXQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjKXQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:31:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4919BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:31:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfa3f7fcd4so1904135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700843468; x=1701448268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2ogGIIqsJnNxaKdE/EV3GmBwVysZZUvGiQa42glbgM=;
        b=XpwUATwmYZsRKw7b3AqGMRJf5/Zw01ZkRq+FW3XghPsgnXD4G8UQi6D2NNjFaX8oP3
         6c1WsUAwtqZg8Fz872JPPGrO04iZ0E/+9jOCvV87iZipmZC+1faS1YG4DkbnBgvdQThE
         /56UaYtMv2gSUM9jqaXp1NOsZQ1YlcxH1nEa89xXpWgCwFZOgACUVas0kxXSp57BHI/c
         o28TdvxR5wY9ZVVMbKn99OTcJGvH1spVI/LTgu3U0e8+1s8s1Ngvd6KXsck32SKBteJq
         XEf5JkcUs+92MB/y0SUcw9AA1vBh/42dPa0Gbo6sKCRNvYBHcjmFNEBfwlnncXD8Tihx
         AAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843468; x=1701448268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2ogGIIqsJnNxaKdE/EV3GmBwVysZZUvGiQa42glbgM=;
        b=jqE8brDOg4/Y1DpwZL45XKMqKOKxuz2thZ/2K9jMh0AFcTipYSBhjSEE2C4juynoQY
         LFOm4HpLSDA5cVz2E+LGK4ZUglashdYi1Bq9Sejqst1grEd5TiuX2+CUOLERVtyve86x
         o1/BkrNEQFpgXntrHa4esQNrUXwPDS6Utq43K+zSZGCCjEfgIYzl/Zgb0DEgtMTfznQs
         eIHRF2GvjqMjCzznJNBzUyq/PY4xeG5wuMFEMiHMZEBS4kN7xsTfvwZ/Fm3NT6P2Lmww
         /NqlTkc69rmcfyhyus8tLHwiP2EZMgCfRKmT2Kk+ovUAMQnXA5fKtjXcdE70GbuUXHL2
         JfQg==
X-Gm-Message-State: AOJu0YzvyMQHH/o8454pQuzoWweDW576v/DSv3uilfgn2J1e0IxzUAdr
        ZdB1U6/8uuOLd8sdTOdm1aN9rw==
X-Google-Smtp-Source: AGHT+IFNObCJRl0SKfGH6WCHQp0So/whqwRMHhseJv204YOu3haZzBIwFSUaACfhr4bRIsLvfx55mA==
X-Received: by 2002:a17:902:ced0:b0:1cf:658f:d2d with SMTP id d16-20020a170902ced000b001cf658f0d2dmr3594550plg.5.1700843468319;
        Fri, 24 Nov 2023 08:31:08 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001c407fac227sm3371578plv.41.2023.11.24.08.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 08:31:07 -0800 (PST)
Message-ID: <54706535-208b-43b5-814f-570ffa7b29bb@kernel.dk>
Date:   Fri, 24 Nov 2023 09:31:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR
Content-Language: en-US
To:     Coly Li <colyli@suse.de>, Markus Weippert <markus@gekmihesg.de>
Cc:     Bcache Linux <linux-bcache@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Zheng Wang <zyytlz.wz@163.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Stefan_F=C3=B6rster?= <cite@incertum.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZV9ZSyDLNDlzutgQ@pharmakeia.incertum.net>
 <be371028-efeb-44af-90ea-5c307f27d4c6@leemhuis.info>
 <71576a9ff7398bfa4b8c0a1a1a2523383b056168.camel@gekmihesg.de>
 <989C39B9-A05D-4E4F-A842-A4943A29FFD6@suse.de>
 <1c2a1f362d667d36d83a5ba43218bad199855b11.camel@gekmihesg.de>
 <3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de>
 <c47d3540ece151a2fb30e1c7b5881cb8922db915.camel@gekmihesg.de>
 <B68E455A-D6EB-4BB9-BD60-F2F8C3C8C21A@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <B68E455A-D6EB-4BB9-BD60-F2F8C3C8C21A@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/23 9:29 AM, Coly Li wrote:
> 
> 
>> 2023?11?24? 23:14?Markus Weippert <markus@gekmihesg.de> ???
>>
>> Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
>> node allocations") replaced IS_ERR_OR_NULL by IS_ERR. This leads to a
>> NULL pointer dereference.
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000080
>> Call Trace:
>> ? __die_body.cold+0x1a/0x1f
>> ? page_fault_oops+0xd2/0x2b0
>> ? exc_page_fault+0x70/0x170
>> ? asm_exc_page_fault+0x22/0x30
>> ? btree_node_free+0xf/0x160 [bcache]
>> ? up_write+0x32/0x60
>> btree_gc_coalesce+0x2aa/0x890 [bcache]
>> ? bch_extent_bad+0x70/0x170 [bcache]
>> btree_gc_recurse+0x130/0x390 [bcache]
>> ? btree_gc_mark_node+0x72/0x230 [bcache]
>> bch_btree_gc+0x5da/0x600 [bcache]
>> ? cpuusage_read+0x10/0x10
>> ? bch_btree_gc+0x600/0x600 [bcache]
>> bch_gc_thread+0x135/0x180 [bcache]
>>
>> The relevant code starts with:
>>
>>    new_nodes[0] = NULL;
>>
>>    for (i = 0; i < nodes; i++) {
>>        if (__bch_keylist_realloc(&keylist, bkey_u64s(&r[i].b->key)))
>>            goto out_nocoalesce;
>>    // ...
>> out_nocoalesce:
>>    // ...
>>    for (i = 0; i < nodes; i++)
>>        if (!IS_ERR(new_nodes[i])) {  // IS_ERR_OR_NULL before
>> 028ddcac477b
>>            btree_node_free(new_nodes[i]);  // new_nodes[0] is NULL
>>            rw_unlock(true, new_nodes[i]);
>>        }
>>
>> This patch replaces IS_ERR() by IS_ERR_OR_NULL() to fix this.
>>
>> Fixes: 028ddcac477b ("bcache: Remove unnecessary NULL point check in
>> node allocations")
>> Link:
>> https://lore.kernel.org/all/3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de/
>> Cc: stable@vger.kernel.org
>> Cc: Zheng Wang <zyytlz.wz@163.com>
>> Cc: Coly Li <colyli@suse.de>
>> Signed-off-by: Markus Weippert <markus@gekmihesg.de>
> 
> Added into my for-next.  Thanks for patching up.

We should probably get this into the current release, rather than punt
it to 6.8.

-- 
Jens Axboe

