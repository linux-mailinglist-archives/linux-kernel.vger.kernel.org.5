Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7319B794513
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbjIFV2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjIFV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:27:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCDA198E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:27:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-402e7968042so2965335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694035650; x=1694640450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxYYC1e0cfCBncvIB+q/JicAk64sR5rIAn7aK80eSuk=;
        b=koEyyLO65UM+s6i04XH4BccCKGcqDL+YmWEhM+GFqQRhs4j7j9+oFhMETckt/XwNYo
         0FHlL3ZO0RMpo2+GkaphxZ5Hpp8q42gy0t1z3VfwZ5RxoWVXVLqDvv89PhXz+X5lFDsx
         X/pGlql2rNktKZP8pk+kX+8Af0M+/cX0UYHVYT8JDXTA/DoO9DbtVACvUqVeO/hLsQjQ
         JMRPLlFHb1ZGsumGHxEt/WrVoc7YNZKfHGr7lGddwTAOd1HI1XkCD8zriOUHAJTgFh9e
         fBshLE295kQIAGN2s1l1V8xDnxVhAGhLDDxYTxdgRS9JQFEgrdjqOUIAC5Q5152GllLy
         XmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694035650; x=1694640450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxYYC1e0cfCBncvIB+q/JicAk64sR5rIAn7aK80eSuk=;
        b=lKHiX1rviG8ThqlmDzyWCnEb7NudCdHQTJi/Hv4K4j38eQOw5dgbCOlgmjNZm8PyHm
         YrwsQKcx49QIfs0GVPHu4si6DetJTfNhYt2D4FeWZiIkgJksgnrxEjo7jsUfuZJI6k/h
         F2+pQLSf9wVySXwUuO1WDfXOXCJcFZz4VX7fM0GRf/DPBbt49OGOQbCGMqPLPA0zRvsQ
         u5diVPprX7qrkamuYfAQdpLx5ewjYWckrlOrTDhkarGkTusmandRVPcol6TK3sbK8uO+
         Yd2SasZG03qo4FRYaDinJYf5urdxpnyMJuentfBIgUE5ra15SoqerQWs2UyMuwe6U2Qf
         WehQ==
X-Gm-Message-State: AOJu0YwnN5hTOkvjbBQ7Fv2c4NTQlvK+8wJGayy43IV3ANFStoFFugcl
        EpJsh6ErSmZAoyGEiHIRn6E01Q==
X-Google-Smtp-Source: AGHT+IGweuxCL65GjEbvRg7LXcDrDXb/vGQIiScSnLJkVi//NfzygtqJpeTWrOEJlEkDppJMQS6/Eg==
X-Received: by 2002:a05:600c:2308:b0:401:d803:6243 with SMTP id 8-20020a05600c230800b00401d8036243mr3284465wmo.32.1694035650376;
        Wed, 06 Sep 2023 14:27:30 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b5c7:0:6274:c7ab:26e2:b113? ([2a02:6b6a:b5c7:0:6274:c7ab:26e2:b113])
        by smtp.gmail.com with ESMTPSA id k20-20020a7bc414000000b003fd2e898aa3sm995774wmi.0.2023.09.06.14.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 14:27:29 -0700 (PDT)
Message-ID: <57c8dd7f-d1a0-37c4-1d3b-d6374e92ffa1@bytedance.com>
Date:   Wed, 6 Sep 2023 22:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [v4 4/4] mm: hugetlb: Skip initialization of
 gigantic tail struct pages if freed by HVO
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
 <20230906181016.GA3612@monkey>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230906181016.GA3612@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2023 19:10, Mike Kravetz wrote:
> On 09/06/23 12:26, Usama Arif wrote:
>> The new boot flow when it comes to initialization of gigantic pages
>> is as follows:
>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
>> the region after the first struct page is marked as noinit.
>> - This results in only the first struct page to be
>> initialized in reserve_bootmem_region. As the tail struct pages are
>> not initialized at this point, there can be a significant saving
>> in boot time if HVO succeeds later on.
>> - Later on in the boot, the head page is prepped and the first
>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
>> are initialized.
>> - HVO is attempted. If it is not successful, then the rest of the
>> tail struct pages are initialized. If it is successful, no more
>> tail struct pages need to be initialized saving significant boot time.
> 
> Code looks reasonable.  Quick question.
> 
> On systems where HVO is disabled, we will still go through this new boot
> flow and init hugetlb tail pages later in boot (gather_bootmem_prealloc).
> Correct?
> If yes, will there be a noticeable change in performance from the current
> flow with HVO disabled?  My concern would be allocating a large number of
> gigantic pages at boot (TB or more).
> 

Thanks for the review.

The patch moves the initialization of struct pages backing hugepage from 
reserve_bootmem_region to a bit later on in the boot to 
gather_bootmem_prealloc. When HVO is disabled, there will be no 
difference in time taken to boot with or without this patch series, as 
262144 struct pages per gigantic page (for x86) are still going to be 
initialized, just in a different place.
