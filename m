Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B2A7E8000
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjKJSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjKJSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD428B33
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:29:41 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso16988275ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699612181; x=1700216981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnpoVDYUjKd3G8MoAHqwJcbkn3YvVxdpV7jnAIYRk30=;
        b=flxy7wLdaPIV2hoMl2P9zGsGxYIYkEugXlcX2aaDFGT5jxCiwCrJxCzCl2va13k7HM
         gwfvCKetAA2eRzyniXXK7i/eIcHsBDj2rkHT5EQ5rq2sFbE0xEVh9v0BjVxHG4QTkvQ4
         9xSsR59t7wmRX0IUaoXyq3lPuWxORkNc8QTr+aiPXFPUAzxf6kCoIgMXm9+ke0NsRrSU
         ZnGlBji9Xh5g54FtDMITkBmd9YNxi11kxabJ0P/B1P/AHMxIj0iSwhfhkuGXuAmuFqat
         saRYyNDGcI+Qm+hqBCe2jnRFJUnxxM3bUYVXhdIyAEUBAXe7OAtrox+XhYrTdBBVj9s9
         llTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699612181; x=1700216981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nnpoVDYUjKd3G8MoAHqwJcbkn3YvVxdpV7jnAIYRk30=;
        b=v2rUGdNNnPkqWL6cgMeBqqxMvQIUP50OQBCvBjQbikULa7UhjST0ex+cAJtnqKgbls
         VnFQFHMEp8x2b4hK4bwed2G1hH4K8ivJfvmShpf4rQPnHHxNfcSCXs5saL9tWbKR9sL1
         CMF3WwnTW9PAPobvl/drauCqrAes1LYZyfQ96+xPKadWnATnDCHHxV+Fqd2rS820l9is
         zM4loZZmQp8goITrGV7zouI6bVlO1TvrvtcsV0nMSLZLsxrBNKopfWM+t4KhO/rFDR4d
         iudnwIjyYdn0OT0k0DdGscoh+PaqoErO20gDftUIJ7ug+DvGEanXHpSPjVXLAOWhHgdw
         ascg==
X-Gm-Message-State: AOJu0YzQmaUE8H9qRifKOXjrM3+FwiTjC5S/XxHa6bk83mTpU2p01k+D
        rDswbK1v6DsfKa0dKd3LmLriCg==
X-Google-Smtp-Source: AGHT+IGaShgv4q7rmDQV4setP1Ioo5vXHwXEr6plv9+vfdgvqbtUqJnkGbGK9nhBqlaF35N2CKkeDw==
X-Received: by 2002:a17:902:b284:b0:1cc:2469:f2ff with SMTP id u4-20020a170902b28400b001cc2469f2ffmr7458444plr.9.1699612180724;
        Fri, 10 Nov 2023 02:29:40 -0800 (PST)
Received: from [10.54.24.52] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id ba2-20020a170902720200b001cc5d23275csm4983457plb.200.2023.11.10.02.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 02:29:40 -0800 (PST)
Message-ID: <bc934b85-9371-4758-b595-814b98f9c595@shopee.com>
Date:   Fri, 10 Nov 2023 18:29:36 +0800
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

Yes, so if rcnt > 1, the RWSEM_WRITER_LOCKED bit couldn't be set?
