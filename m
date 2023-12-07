Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C794F808B97
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443254AbjLGPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjLGPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:18:34 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496FD137
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:18:17 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0c94397c0so7393825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701962296; x=1702567096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1pKODQs/mhfbgAdqmPD+EhKNUtG+NSuI4HLS28uLOA=;
        b=P96YZxgF+IDaN36P8paUGNN+ad+uGSPP7pAZaJtToVO7QK4KTFlPAEte2UYej7GbDc
         5iq5uyvUkZTxDMNZuSoxH0nMxzr2fwf9OuCf4ryh+2G7vP0CAesfi0PQmwOHfiYILtbX
         AGo0vwKLHxzB+ch6A/9UuRbeqL5bViBKe/6ZYDPtz3cZJ6RcYAgL3qCv2oufSJdSM0o2
         dUbRskhceqsWHOgN/LMGpqQpzuyRLATJlIdCfjuEP9q/4Uz69tUyygNUKdzydT/ElQXu
         QDGRj5epJ/MYqM3GHLtK0oNhdp+oWw0ozcfL87UOdQBByvEvbPN0MrW74OiXYptDtdbP
         r19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701962296; x=1702567096;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1pKODQs/mhfbgAdqmPD+EhKNUtG+NSuI4HLS28uLOA=;
        b=sBiPU+U7OKJAzK4LhOUDIACz9fmNbzKbywalileH/Eq4ox/E3X4ihXXAHLpTq/WB0q
         hSW4ri0sqphTN96VQbyuA/a+dKjpcyqSCqtR3RtKFdi6OQD7f4uJBOHMRmAVR0DL/23T
         GZBpEkT5W/bnYT3XNUGyxrRAwKUhVoEfxnMmsI6AV2X1CoZ84Z2aLM0SRUMLyQ47ZRDx
         GPrX8oeCefOXXm4LAHTDTngEAU4slvynuSP3Hxi9KmDdLB7oNmjw5NndNgSqAQDMmx6R
         N+UFbgBOY0rT+Y3r0pp/NMUOxhAOmZIThnsmpRPnrbkRZfTapbVcCgyQVkPRFe1KOTGv
         txNQ==
X-Gm-Message-State: AOJu0YzQRKnrdUv/5hgjalZCmJqGljUv3DO4YqJoEPZblknXcqx8FwTa
        gK1g9g5P5JoFN7tlY1ij3OCl8g==
X-Google-Smtp-Source: AGHT+IGRFgPS0i8wxKQBN4fbBs0uBqT/8XjR1emJtw3s7T5FsiATLmeXVmVi+dLpckIXBogPKT37MA==
X-Received: by 2002:a17:903:2386:b0:1d0:6b95:9c10 with SMTP id v6-20020a170903238600b001d06b959c10mr2094021plh.48.1701962296547;
        Thu, 07 Dec 2023 07:18:16 -0800 (PST)
Received: from [10.254.182.136] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id l1-20020a170903244100b001cfb971edfbsm1555270pls.156.2023.12.07.07.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 07:18:15 -0800 (PST)
Message-ID: <6bf18314-7749-476e-aece-064ecfb0dffc@bytedance.com>
Date:   Thu, 7 Dec 2023 23:18:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=OqMK881u3kPB99KX_9UWreddz-cUT5ArzdwpHwQjQ6yA@mail.gmail.com>
 <ee7631a5-b167-43d9-af19-a5a12dcac03a@bytedance.com>
In-Reply-To: <ee7631a5-b167-43d9-af19-a5a12dcac03a@bytedance.com>
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

On 2023/12/7 11:13, Chengming Zhou wrote:
> On 2023/12/7 04:08, Nhat Pham wrote:
>> On Wed, Dec 6, 2023 at 1:46 AM Chengming Zhou
>> <zhouchengming@bytedance.com> wrote:
>>> When testing the zswap performance by using kernel build -j32 in a tmpfs
>>> directory, I found the scalability of zswap rb-tree is not good, which
>>> is protected by the only spinlock. That would cause heavy lock contention
>>> if multiple tasks zswap_store/load concurrently.
>>>
>>> So a simple solution is to split the only one zswap rb-tree into multiple
>>> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
>>> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
>>>
>>> Although this method can't solve the spinlock contention completely, it
>>> can mitigate much of that contention.
>>
>> By how much? Do you have any stats to estimate the amount of
>> contention and the reduction by this patch?
> 
> Actually, I did some test using the linux-next 20231205 yesterday.
> 
> Testcase: memory.max = 2G, zswap enabled, make -j32 in tmpfs.
> 
> 			20231205	+patchset
> 1. !shrinker_enabled:   156s		126s
> 2.  shrinker_enabled:   79s		70s
> 
> I think your zswap shrinker fix patch can solve !shrinker_enabled case.
> 
> So will test again today using the new mm-unstable branch.
> 

Updated test data based on today's mm-unstable branch:

			mm-unstable	+patchset
1. !shrinker_enabled:	86s		74s
2.  shrinker_enabled:	63s		61s

Shows much less optimization for the shrinker_enabled case, but still
much optimization for the !shrinker_enabled case.

Thanks!
