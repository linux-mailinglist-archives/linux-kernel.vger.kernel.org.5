Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5280A7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjLHPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjLHPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:41:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFAE19B3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:41:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d2eb06ab11so7199755ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702050100; x=1702654900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1E9d4ZCyxDs2I8Fmuzv+F6C7pJm1TGZqWQ9mMucS+jA=;
        b=Kr++1GN/tVijP9+K5eAVJ8Zh530soxLiPy1UMFDyQjCn0qqikVWhoUdi1LA/nluN/e
         UrZAR/2pWNJI5TLmdZDb6QgeFUs8mfEnknMCdyOkewKlgLq6qUO06R5peFyqZvoG4OW0
         7r/9ND+7y1wum9KLCbrrYlC+5gONMiXYFIFK3Uss9RA/RHixA2GQpn9lPWgfUTQaJsbO
         9qwa6U15LQF0Hx7Ou93k8pd369zZLtA1TxQaIgFXxBcsoDTNRZh3hj0+wM1MjY73Qq4p
         w9Qxah8c8v1w1VAmth99MIUOIa8AWLjCFtAEnbn8SYf6tlZhVDs5x+1HvcGNRJi4ux3g
         9kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050100; x=1702654900;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1E9d4ZCyxDs2I8Fmuzv+F6C7pJm1TGZqWQ9mMucS+jA=;
        b=NHTjfVPn9yq0CO4lU2ZuIbZT0bi7q2v41DmVV697jEvDfyxKuk5y51owYi1+wzr9DC
         BrPfNAV8XpDYYwrS1YAW8NpUCEhra95CdqaPd2uMgRHerJ3KeE+iBn9Nakp62V/FbC2R
         EKEUPxta9UsrPkPtc9/GjklR9BqKRKROZcgP6xvsVpdXMw2kg7lLrn3XkLsBnEtALCAD
         2/R1klZ9yIhvQraKgINteEGdgJ8w81EsiRtCxHMPH7Tgt8tTW43p7W9gA1RRM1fhcjT5
         zqV0vifgDTEy7HVpq9KFuQ8bIW49bRj4JOViiH4Cv5MdNbgiMP29+j1pnMXvw+1/seMe
         KepA==
X-Gm-Message-State: AOJu0Yzl6K0/yUduigSzAKIYaV6TavCGOKNaAwnJP5lwl+Egc5e+kequ
        TWZFiSletW1b7XtaS2pw3IAn3A==
X-Google-Smtp-Source: AGHT+IGJfvmrPJwyCawGxJHud5fZ2Zbt4ByzGPXIwtHn9bfTKIBH8HCQlj6HdZlqNy4B3oqp/h1trA==
X-Received: by 2002:a17:902:6848:b0:1d0:8383:742d with SMTP id f8-20020a170902684800b001d08383742dmr203436pln.37.1702050099735;
        Fri, 08 Dec 2023 07:41:39 -0800 (PST)
Received: from [10.4.166.75] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001d0c1281ef5sm1837836plg.89.2023.12.08.07.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 07:41:39 -0800 (PST)
Message-ID: <f8a4ea64-ea6a-4291-9523-51a382f03e62@bytedance.com>
Date:   Fri, 8 Dec 2023 23:41:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
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
 <6bf18314-7749-476e-aece-064ecfb0dffc@bytedance.com>
 <CAKEwX=NX5T1AL6jXuW0oonW_GtPOos+oXdWGAE3hxdWQyavBPA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKEwX=NX5T1AL6jXuW0oonW_GtPOos+oXdWGAE3hxdWQyavBPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/8 02:15, Nhat Pham wrote:
> On Thu, Dec 7, 2023 at 7:18 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2023/12/7 11:13, Chengming Zhou wrote:
>>> On 2023/12/7 04:08, Nhat Pham wrote:
>>>> On Wed, Dec 6, 2023 at 1:46 AM Chengming Zhou
>>>> <zhouchengming@bytedance.com> wrote:
>>>>> When testing the zswap performance by using kernel build -j32 in a tmpfs
>>>>> directory, I found the scalability of zswap rb-tree is not good, which
>>>>> is protected by the only spinlock. That would cause heavy lock contention
>>>>> if multiple tasks zswap_store/load concurrently.
>>>>>
>>>>> So a simple solution is to split the only one zswap rb-tree into multiple
>>>>> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
>>>>> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
>>>>>
>>>>> Although this method can't solve the spinlock contention completely, it
>>>>> can mitigate much of that contention.
>>>>
>>>> By how much? Do you have any stats to estimate the amount of
>>>> contention and the reduction by this patch?
>>>
>>> Actually, I did some test using the linux-next 20231205 yesterday.
>>>
>>> Testcase: memory.max = 2G, zswap enabled, make -j32 in tmpfs.
>>>
>>>                       20231205        +patchset
>>> 1. !shrinker_enabled:   156s          126s
>>> 2.  shrinker_enabled:   79s           70s
>>>
>>> I think your zswap shrinker fix patch can solve !shrinker_enabled case.
>>>
>>> So will test again today using the new mm-unstable branch.
>>>
>>
>> Updated test data based on today's mm-unstable branch:
>>
>>                         mm-unstable     +patchset
>> 1. !shrinker_enabled:   86s             74s
>> 2.  shrinker_enabled:   63s             61s
>>
>> Shows much less optimization for the shrinker_enabled case, but still
>> much optimization for the !shrinker_enabled case.
>>
>> Thanks!
> 
> I'm gonna assume this is build time since it makes the zswap shrinker
> look pretty good :)
> I think this just means some of the gains between this patchset and
> the zswap shrinker overlaps. But on the positive note:
> 
> a) Both are complementary, i.e enable both (bottom right corner) gives
> us the best result.

Right, both optimizations are complementary, to make zswap perform better :)

> b) Each individual change improves the runtime. If you disable the
> shrinker, then this patch helps tremendously, so we're onto something.
> c) The !shrinker_enabled is no longer *too* bad - once again, thanks
> for noticing the regression and help me fix it! In fact, every cell
> improves compared to the last run. Woohoo!

It's my pleasure! Thanks!
