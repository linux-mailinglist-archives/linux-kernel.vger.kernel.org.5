Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD5801AED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 06:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjLBFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 00:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 00:53:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13FA119;
        Fri,  1 Dec 2023 21:53:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d0538d9bbcso11361225ad.3;
        Fri, 01 Dec 2023 21:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701496412; x=1702101212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCRPOdv+OSBaDAjSYHQJOdrd35/mwGfAAGpy6ypFu/U=;
        b=WoTmxtPc3xgCzCIFowgk3qBM6Y1NrzIyewMqdY02rogPWp2mBSiE04tVcBABxwFjpH
         H1pni99U6yCrIdKggYuJV4geAepZVtEFZW3zJZaE5+FTOI+B1eve7y7fneFFP/e+sOvH
         yxqTxz8JURt80wXCN1XUF9ERGCk8sJmJh3SSj4ottu3dqbW+6KqugU/Jeo4SuWUjoyGf
         JuRVN1soiiy52F9UQW5Jt3eRSFBRn36culxFFwJStVK8ZOxBbm99IAV9sFhJRTN6wvyi
         PSQX/lzTXlzFpk2DKo1LVGuq89Azz/0Y/e6Zh4srsU4J5xqcfELERYLFDR+izcVbjvjy
         zovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701496412; x=1702101212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCRPOdv+OSBaDAjSYHQJOdrd35/mwGfAAGpy6ypFu/U=;
        b=Da5oNr2F2YumIp8I9UWKnfKAv2ZADu+zJ5Cdx7XIwWdh/8NJR0op9SXVYOQgg+ppVm
         a72KAU6fOxV0EPyaPRMW3feSCpTwbR6nHLgXA/xTQae/IzfXia04GpHDy4NR0Ggz9lwr
         D9EPWdhHlxFl942fHn9E8fN/DIwjt0Y3TCwvOjo5F/93p+vkiIQYWHdwO+h/vvndVCYn
         bqjmlSW2EoZhojVrSIr2nq/V5/LdGxk3yitFXjXUi4cJ/qgExQAHjS6TIuMlZXTowwkv
         8a30ewUY74XivhVgZsz2Bdo2/ppxI8q5yz+4WBtiyqF0bQOQTwJ3+xufVnhyTvvD7C/s
         ZJuQ==
X-Gm-Message-State: AOJu0YxAmbP/kHZvPl9Mk5uhmMKgr9UmP7m9L+5gKHlnaKRpe37jnJ9r
        46zlH6K8S4xeRCVzK/YkOauK6C2w3jUTIg==
X-Google-Smtp-Source: AGHT+IGGj6z2rDhAJOroxjJ73Spkhaw9LeUO+j5FAzbMTsNW53fktbd5lxl+Vi+q76cyep8sG3uh3A==
X-Received: by 2002:a17:903:32c1:b0:1d0:6ffd:e2c8 with SMTP id i1-20020a17090332c100b001d06ffde2c8mr814674plr.98.1701496412419;
        Fri, 01 Dec 2023 21:53:32 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001cfd2c5ae6fsm2627264plb.25.2023.12.01.21.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 21:53:31 -0800 (PST)
Message-ID: <523f0517-fdbf-488b-87d1-f611c97ef810@gmail.com>
Date:   Sat, 2 Dec 2023 12:53:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        kernel-team@cloudflare.com, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Attreyee M <tintinm2017@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux CGroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <ZWqPBHCXz4nBIQFN@archie.me>
 <436e96d1-29eb-49ec-a463-2ed420757ce8@redhat.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <436e96d1-29eb-49ec-a463-2ed420757ce8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 09:56, Waiman Long wrote:
> 
> On 12/1/23 20:57, Bagas Sanjaya wrote:
>>> -void mem_cgroup_flush_stats(void)
>>> +/*
>>> + * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
>>> + * @memcg: root of the subtree to flush
>>> + *
>>> + * Flushing is serialized by the underlying global rstat lock. There is also a
>>> + * minimum amount of work to be done even if there are no stat updates to flush.
>>> + * Hence, we only flush the stats if the updates delta exceeds a threshold. This
>>> + * avoids unnecessary work and contention on the underlying lock.
>>> + */
>> What is global rstat lock?
> 
> It is the cgroup_rstat_lock in kernel/cgroup/rstat.c.
> 

OK, I see that. Thanks!

-- 
An old man doll... just what I always wanted! - Clara

