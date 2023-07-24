Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5366175F93F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGXOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGXOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:05:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B500E54
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:05:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-316eabffaa6so3107042f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690207531; x=1690812331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhFXcb6ti0iORGbpD9zt6mN2a0Mp7yrFl3s155ggPqc=;
        b=OhYIFmLihZeWDk7cucsyJsh5vQP6M3nPyAsi5bBLFaIJ2abGfAFbdwhmQQpuGiH2VT
         j7XFQcR6ocH6vKYzQ9+Lwy5UXbJFVb8kaIRBftgLgosLqkqAdpeE74Yb3diJG4ZUemY/
         i5Kjn/bCMwDssMHJ2L2Ekf0xuiEF8gk1ka8HH7W5O7Ezn3WCcfOidAowrITXwnjD2wUf
         wjE+VgVQ3xqO5AVcpgfLb43tjbdsZV+56CcewqmDOLy+TCB1ceepKIh/Vq3kQ5Amr31k
         avky5PFSorvvZ3U/psgBI703GASUxI13PcNaA8pDfLnyRmQ10t34x0Au0UuBO0NRdPjP
         Liqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207531; x=1690812331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhFXcb6ti0iORGbpD9zt6mN2a0Mp7yrFl3s155ggPqc=;
        b=FBdDvdJqAQ+zOBYg6tlvxiWJKDzJ2WYAczJymjRA3uHrNtJjHzbdvtO9/h+7YfXxsD
         XZT5KV+dbM6zdxJj9taEZcLinddG1Qf5G9oS8OAxN3hQMdUxNzRRXxqHxWIwJjdtm7j1
         tqrNT8DlZlTvqZ3a3U3iONtfT2qun9eVAWrk5ygM4TLR7SLZgAd6AxLIwARAP5CQe21r
         vwavR1usNS9VyAw/KCws2TP8kQBzk6QWANk26+vdiIvz35uxPrTdwig3K4g6fHJ7ASHC
         1ZIN+J2IzOPt/INbrXH/z0SV4nHvTzaOivvhAokNn/H0SBBR45S67/i8IOmPTkJFflta
         I8Qg==
X-Gm-Message-State: ABy/qLYEPmoMMTH1VFYW9Rm0tAEN9DWgVGl/400/aUWJ7RUsdkWgMrZc
        fJb6NwwkDA4rcMDCu+qIlxtsLg==
X-Google-Smtp-Source: APBJJlGK+fFGQ5T2oZ/hj4adgGgh9yz4i19TLptnTE//fHvORYyxZpRQL+GNVvbbRKmleRi2QxJIiQ==
X-Received: by 2002:a05:6000:4c9:b0:315:a34f:b520 with SMTP id h9-20020a05600004c900b00315a34fb520mr5889640wri.71.1690207530907;
        Mon, 24 Jul 2023 07:05:30 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:d7c4:7f46:8fed:f874? ([2a02:6b6a:b465:0:d7c4:7f46:8fed:f874])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b003143c532431sm12906253wrs.27.2023.07.24.07.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 07:05:30 -0700 (PDT)
Message-ID: <463c960e-1d3b-edc0-edbb-d5ecbf7fc3b1@bytedance.com>
Date:   Mon, 24 Jul 2023 15:05:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH] docs: mm: Fix number of base pages for 1GB
 HugeTLB
To:     Mike Rapoport <rppt@kernel.org>, songmuchun@bytedance.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com
References: <20230207114456.2304801-1-usama.arif@bytedance.com>
 <Y+NwkCsDnOBSCqVu@kernel.org>
Content-Language: en-US
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <Y+NwkCsDnOBSCqVu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2023 09:51, Mike Rapoport wrote:
> On Tue, Feb 07, 2023 at 11:44:56AM +0000, Usama Arif wrote:
>> 1GB HugeTLB page consists of 262144 base pages.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> 
>> ---
>>   Documentation/mm/vmemmap_dedup.rst | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
>> index a4b12ff906c4..689a6907c70b 100644
>> --- a/Documentation/mm/vmemmap_dedup.rst
>> +++ b/Documentation/mm/vmemmap_dedup.rst
>> @@ -1,3 +1,4 @@
>> +
>>   .. SPDX-License-Identifier: GPL-2.0
>>   
>>   =========================================
>> @@ -17,7 +18,7 @@ HugeTLB pages consist of multiple base page size pages and is supported by many
>>   architectures. See Documentation/admin-guide/mm/hugetlbpage.rst for more
>>   details. On the x86-64 architecture, HugeTLB pages of size 2MB and 1GB are
>>   currently supported. Since the base page size on x86 is 4KB, a 2MB HugeTLB page
>> -consists of 512 base pages and a 1GB HugeTLB page consists of 4096 base pages.
>> +consists of 512 base pages and a 1GB HugeTLB page consists of 262144 base pages.
>>   For each base page, there is a corresponding ``struct page``.
>>   
>>   Within the HugeTLB subsystem, only the first 4 ``struct page`` are used to
>> -- 
>> 2.25.1
>>
> 

Hi,

Was just reading vmemmap_dedup.rst for something and realized that its 
still 4096 pages for 1G, maybe this patch got missed?

Thanks,
Usama
