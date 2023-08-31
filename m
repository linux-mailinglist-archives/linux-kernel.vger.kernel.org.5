Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB41878E7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbjHaIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbjHaIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1538EEE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:09:26 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-KeXIulV2MQqbl8ZH5Kr2WQ-1; Thu, 31 Aug 2023 04:09:23 -0400
X-MC-Unique: KeXIulV2MQqbl8ZH5Kr2WQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5007f3d3255so772742e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693469362; x=1694074162;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0ofhpazPjwKjea88CcdW/OVZwJHwubosedHXv1QjBs=;
        b=Osc8ZWDGcZhiW+LNYGtIRRuF2x08VuXUSadklWMVBZdrdfFJngj5QkVTPNCCN6k5/6
         cP5sJtsBzA5HWUOXJ/b4h9cpScHLe+04IEqBhIaj3p4IHsNtec66NUh5KR1z5uyXgO3Z
         F+jHbYrVi6loHbbldmIZbAeTr+4ereGwS8sorve1TZ3jbuoK2MiD4Dmi8iWvuYkZIdJ4
         Rzuvi+wfHMw7rY6oP98Rp7aJV91IFE/Gj7Vj7JSZY9GNOmQGAMx37VlvFc2qBYOib7nk
         owlbASonmPx6S0hnXvWg/tYx2U5+B8S0d0FNXeGcviGq6xV01623swyjuzbmhc3pnZGJ
         yi+w==
X-Gm-Message-State: AOJu0YxO1k2Dgn4UjfVesGglrt+2RlKWrIZiGnRhVr1oxkcbQC1XpB7Q
        RTc5Lm53CAqKkQn4Ov0PJTZMdQ/y6/wnb+zijVZRlFPVdKAa4tRzkEAkCKJ2Bz7DZ46iQjAvMPg
        AdxEFOB52r8lRGla2tLZYcSun
X-Received: by 2002:a05:6512:52f:b0:4fe:af1:c3ae with SMTP id o15-20020a056512052f00b004fe0af1c3aemr3126422lfc.15.1693469362300;
        Thu, 31 Aug 2023 01:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbwaEbzS0C90AS2MC0WV7pkbdVAR2o61qG9h2rNGTcqhh7JTUilAK4ff+DZB/AAaSv5eO8sQ==
X-Received: by 2002:a05:6512:52f:b0:4fe:af1:c3ae with SMTP id o15-20020a056512052f00b004fe0af1c3aemr3126391lfc.15.1693469361790;
        Thu, 31 Aug 2023 01:09:21 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b00401e32b25adsm1193765wms.4.2023.08.31.01.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:09:20 -0700 (PDT)
Message-ID: <d71d9b4d-5ea7-2387-d27a-8fcd9384da52@redhat.com>
Date:   Thu, 31 Aug 2023 10:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
 <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
 <747deb43-68c8-449f-b41a-91864820a699@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <747deb43-68c8-449f-b41a-91864820a699@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.23 10:02, Yin, Fengwei wrote:
> 
> 
> On 8/31/2023 3:57 PM, David Hildenbrand wrote:
>> On 31.08.23 03:40, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> On 15/08/2023 22:32, Huang, Ying wrote:
>>>>> Hi, Ryan,
>>>>>
>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>
>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>>>> allocated in large folios of a determined order. All pages of the large
>>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>>> counting, rmap management lru list management) are also significantly
>>>>>> reduced since those ops now become per-folio.
>>>>>>
>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>>>> which defaults to disabled for now; The long term aim is for this to
>>>>>> defaut to enabled, but there are some risks around internal
>>>>>> fragmentation that need to be better understood first.
>>>>>>
>>>>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>>>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>>>>> where fallback (>) is performed for various reasons, such as the
>>>>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>>>>
>>>>>>                   | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>>>                   | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>>>> ----------------|-----------|-------------|---------------|-------------
>>>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>
>>>>> IMHO, we should use the following semantics as you have suggested
>>>>> before.
>>>>>
>>>>>                   | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>>                   | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>>> ----------------|-----------|-------------|---------------|-------------
>>>>> no hint         | S         | S           | LAF>S         | THP>LAF>S
>>>>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>
>>>>> Or even,
>>>>>
>>>>>                   | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>>>                   | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>>>> ----------------|-----------|-------------|---------------|-------------
>>>>> no hint         | S         | S           | S             | THP>LAF>S
>>>>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>
>>>>>   From the implementation point of view, PTE mapped PMD-sized THP has
>>>>> almost no difference with LAF (just some small sized THP).  It will be
>>>>> confusing to distinguish them from the interface point of view.
>>>>>
>>>>> So, IMHO, the real difference is the policy.  For example, prefer
>>>>> PMD-sized THP, prefer small sized THP, or fully auto.  The sysfs
>>>>> interface is used to specify system global policy.  In the long term, it
>>>>> can be something like below,
>>>>>
>>>>> never:      S               # disable all THP
>>>>> madvise:                    # never by default, control via madvise()
>>>>> always:     THP>LAF>S       # prefer PMD-sized THP in fact
>>>>> small:      LAF>S           # prefer small sized THP
>>>>> auto:                       # use in-kernel heuristics for THP size
>>>>>
>>>>> But it may be not ready to add new policies now.  So, before the new
>>>>> policies are ready, we can add a debugfs interface to override the
>>>>> original policy in /sys/kernel/mm/transparent_hugepage/enabled.  After
>>>>> we have tuned enough workloads, collected enough data, we can add new
>>>>> policies to the sysfs interface.
>>>>
>>>> I think we can all imagine many policy options. But we don't really have much
>>>> evidence yet for what it best. The policy I'm currently using is intended to
>>>> give some flexibility for testing (use LAF without THP by setting sysfs=never,
>>>> use THP without LAF by compiling without LAF) without adding any new knobs at
>>>> all. Given that, surely we can defer these decisions until we have more data?
>>>>
>>>> In the absence of data, your proposed solution sounds very sensible to me. But
>>>> for the purposes of scaling up perf testing, I don't think its essential given
>>>> the current policy will also produce the same options.
>>>>
>>>> If we were going to add a debugfs knob, I think the higher priority would be a
>>>> knob to specify the folio order. (but again, I would rather avoid if possible).
>>>
>>> I totally understand we need some way to control PMD-sized THP and LAF
>>> to tune the workload, and nobody likes debugfs knob.
>>>
>>> My concern about interface is that we have no way to disable LAF
>>> system-wise without rebuilding the kernel.  In the future, should we add
>>> a new policy to /sys/kernel/mm/transparent_hugepage/enabled to be
>>> stricter than "never"?  "really_never"?
>>
>> Let's talk about that in a bi-weekly MM session. (I proposed it as a topic for next week).
> 
> The time slot of the meeting is not friendly to our timezone. Like
> it's 1 or 2 AM. Yes. I know it's very hard to find a good time slot
> for US, EU and Asia. :(.

:/

Yeah, even for me in Germany it's usually already around 6-7pm.

> 
> So maybe we still need to discuss it through mail?
I don't think we'll be done discussing that in one session. One of the 
main goals is to get some input from the wider MM community.

-- 
Cheers,

David / dhildenb

