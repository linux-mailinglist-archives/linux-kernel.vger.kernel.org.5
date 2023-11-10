Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670D7E80F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbjKJSUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjKJSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AAC2AD37
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:00:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc9784dbc1so16421085ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699614038; x=1700218838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jwNwfpxjtptLy1F0nwNpWWvyagycEyL720lh2jZDW0=;
        b=eoUGjp4FTDg+HB/16CVgv2JwICrQcsRG3yt1MykKUsRfNMU5cttanjw7mXmIwKags/
         s9q4CHbcyDctyFh97dgjA9lkNAoMsNxNsCcN1vw/j5KazNu3dewkzlA2jKpD2i+zAl+R
         i5RlYLCF7x6VsT/qqVlFz+sl7axGJge2IqA1c65a4aiMdt6R/JNzfXhR3Gf1cm8yxPgk
         ym3AgrW9GDqA43InzII6MKTnTln0IoNaqLxbzZ2sSkKwKxB2nEcutlbXLICjsjO7oREK
         bCbM/G6ilurJKzZ0SxuBw0g8X0YlRFfSwaBTpSUkT775J26Gh/j02MeJDBVwz4jsmoAN
         Igsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699614038; x=1700218838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jwNwfpxjtptLy1F0nwNpWWvyagycEyL720lh2jZDW0=;
        b=Fw/3AzswQXzaFmaV8xIkZi5LLtMcWhYBVKauMmzdbc9rUEle1zMCgpZyvYJhxNLm0X
         wExE26nCjW1KwMzIAZK2mfGx9l0ByKNI4qK6/CkSAuIafMqdRmmnxQBJaZhNe+Md387m
         gLruUb+O6F9SjZpleeDF5rLXzUyps1Xp1d9qqg/CQrqQxiMgeiHGiGCdasxzheWT3Z48
         2E9XFFWDDRvkHsFHU/o0cpCXElHK0lOvJ5GeyK249K0DBIF8Gd7WJVxjZnBsWWN3nqGy
         BLNgswrGC9LAeZcGawumafNRDxXUSg3UHs9nQdQ68gR4TW85Fop3+6OxkuCOQf5iSYL/
         vBKA==
X-Gm-Message-State: AOJu0YxkDhBD8CnrJfmM+AX/2D/CMaZp6mdZJKwLrcEWn1YeJNb5M9+C
        hj3LF7VGsOJ7M7kHxXth9CfKhQ==
X-Google-Smtp-Source: AGHT+IFZ2GRY0U1BKY37Mj49LbEaENLVUdoY2xSW0blo37BoRDQewBGLoIMWIG8wm12aPGielaJTIA==
X-Received: by 2002:a17:902:dacb:b0:1c9:e765:e14a with SMTP id q11-20020a170902dacb00b001c9e765e14amr9169334plx.1.1699614038017;
        Fri, 10 Nov 2023 03:00:38 -0800 (PST)
Received: from [10.54.24.52] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001c9b8f76a89sm5082132plh.82.2023.11.10.03.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 03:00:37 -0800 (PST)
Message-ID: <89bd35a9-ea64-4974-af8e-a033b93d005a@shopee.com>
Date:   Fri, 10 Nov 2023 19:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/rwsem: Remove unnessary check in
 rwsem_down_read_slowpath()
To:     Tang Yizhou <yizhou.tang@shopee.com>
Cc:     Waiman Long <longman@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
References: <20231108105639.70088-1-haifeng.xu@shopee.com>
 <6da49b39-653a-1eda-2d21-1f1b50cb14f0@redhat.com>
 <5086cd5b-a832-4250-9927-4b300d2f611e@shopee.com>
 <CACuPKxnSKQuyWWCtjmmNWP0apja28jWpdYWaKWouArsQA02axQ@mail.gmail.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CACuPKxnSKQuyWWCtjmmNWP0apja28jWpdYWaKWouArsQA02axQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/10 14:54, Tang Yizhou wrote:
> On Thu, Nov 9, 2023 at 11:17 AM Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> reader          writer                                  reader
>>
>> acquire
>> release
>>                 rwsem_write_trylock
>>                         set RWSEM_WRITER_LOCKED
>>                                                         rwsem_down_read_slowpath
>>                         set owner
>>
>> If prev lock holder is a reader, when it releases the lock, the owner isn't cleared(CONFIG_DEBUG_RWSEMS isn't enabled).
>> A writer comes and can set the RWSEM_WRITER_LOCKED bit succsessfully, then a new reader run into slow path, before
>> the writer set the owner, the new reader will see that both the RWSEM_READER_OWNED bit and RWSEM_WRITER_LOCKED bit are
>> set.
>>
> 
> For the above example, it won't cause a problem. When the writer
> successfully sets RWSEM_WRITER_LOCKED, the reader, when reading rcnt
> through rwsem_down_read_slowpath(), will see that rcnt is 0 and will
> jump to the queue label.
> 
> Thanks,
> Tang

In this case, rcnt is not 0, it's 1, because rwsem_read_trylock() has add RWSEM_READER_BIAS, so if more than one new reader comes,
it could be the case.

reader		writer					reader									reader

acquire
release
		rwsem_write_trylock
			set RWSEM_WRITER_LOCKED
							rwsem_down_read_slowpath						rwsem_down_read_slowpath
			
								...									check RWSEM_WRITER_LOCKED bit(rcnt=2)
								

								count = atomic_long_add_return(adjustment, &sem->count);

			set owner
