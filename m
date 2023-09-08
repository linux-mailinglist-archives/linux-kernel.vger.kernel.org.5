Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED6798927
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbjIHOqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjIHOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:46:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795201FC6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:46:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401b5516104so23194665e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694184399; x=1694789199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50mXa465mShhKVUN1OGI3rygnwhndhPpodqJwLNFdlM=;
        b=bhFinwQ5g83mgNnOkbpMscmC/dSyZyx0QB1RScScb/J/NZufmm+BsO3e1fl7kq7Z+i
         xhIT8eBip63hhbz0GDRMswGs925yScA7shhwEEsUF3JV00wHrTHqJVM8KFDB2CjTOlJd
         UwrneKpmvP4ZXj66lSddCQUhJaAj0PCrNL9x6UykH+NTYcQss3bJ7mPnSt9nUUysKEzk
         WRRbv5Y4k1XZB2FrHMTkkG9HWWMOB/DgQkxHrJVRoC4exLhUzJVj4GQybOUOM7sEDTRz
         2Gyewqj+VWs8a1/ylhSaZf7Rntu1E19G2IFkaqUjm8kydqJaGuRgSXFe3G7MI+olpusG
         7yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184399; x=1694789199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50mXa465mShhKVUN1OGI3rygnwhndhPpodqJwLNFdlM=;
        b=MLfCHaU53y9txy4Gmmr/n5/TNZDDVXsxZyka+aGhuHlDNNd+uHfgKvvXGBhDCDpvs8
         dfngj6xcfDzZo6mXYtA0ueL/sP1+l4zsbaod3V6wP0wU869WZ/ckTxozo9AOk2iES0Be
         +7d3BPfZ2+6mTl7WQjwXCt9yDwUC3ptefrRsNt3gj+4JE5Q5/h5/Sv9Dh30asK+mCMw7
         EGC3In1eX7afvfJgum0efCLaDhTg/SnErEpXW4frd+UL1yFvzDJtdzx6T+mDKjYjPuap
         qEtORIW381T3TqK/jlfamWWelRr/uVycz3/yElMWDNnt/oMTucjE+Vk5fcVBCToRl/y8
         Md2A==
X-Gm-Message-State: AOJu0YxJAErtuyJeUMZsBbmPAAr2LmUYWfWxKg4yaJuaDVW072LrroAW
        umulgkp4tXfHP+F6sV319Y+tfA==
X-Google-Smtp-Source: AGHT+IHb2TqDDN9vNv3gtrYNiF8FJajaAj3lPwgPP4md4tkkbeomT6Xa+WZAc1HIbBfi+QbTBKX21w==
X-Received: by 2002:a7b:c3cd:0:b0:400:6b36:ee2a with SMTP id t13-20020a7bc3cd000000b004006b36ee2amr2173610wmj.26.1694184398886;
        Fri, 08 Sep 2023 07:46:38 -0700 (PDT)
Received: from [192.168.69.115] (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b003fee849df23sm2160771wmk.22.2023.09.08.07.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 07:46:38 -0700 (PDT)
Message-ID: <59cc930c-3efd-d31e-49c3-2778914ea9ae@linaro.org>
Date:   Fri, 8 Sep 2023 16:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/5] Use nth_page() in place of direct struct page
 manipulation
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
References: <20230906150309.114360-1-zi.yan@sent.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230906150309.114360-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/9/23 17:03, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> On SPARSEMEM without VMEMMAP, struct page is not guaranteed to be
> contiguous, since each memory section's memmap might be allocated
> independently. hugetlb pages can go beyond a memory section size, thus
> direct struct page manipulation on hugetlb pages/subpages might give
> wrong struct page. Kernel provides nth_page() to do the manipulation
> properly. Use that whenever code can see hugetlb pages.

How can we notice "whenever code can see hugetlb pages"?
 From your series it seems you did a manual code audit, is that correct?
(I ask because I'm wondering about code scalability and catching other
cases).

Thanks,

Phil.
