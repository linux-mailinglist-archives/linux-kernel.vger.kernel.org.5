Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750DF7837E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHVCYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjHVCYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:24:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C8DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:23:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf095e1becso6962855ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692671037; x=1693275837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W03XGKDZt4A/A7A9W9W876L5kqnKwABEmw+x28hU8A8=;
        b=ORO4av4ILDMlLB1hi7zs8WlX+Yon0TkkOM1kHhBP4PzMJ/Qp7Ae2WambeS0BIpdNev
         2yuLzHiLXzMArqjVCeJisd2a0VopoaCWSmRAwOgeYTo0uMMfXgCeLKI/EWBxUfdRujbj
         M/ofg/7TFHZwZ+gEbQSb5Mv4D/LhiSSnSkD2U712cILAfVKmeHa4+3tIHQnvae+CJwea
         yQufXmvbqJd6S/jiF4UVzsi2QiFIvW4WnEatAAZxwBYoqhFRxfsI2Vv9UNnO0qZymRxT
         PtuCBLV/Eg5B+G5gj66b7H4penlPSkf6bSHUSrt9LeXfTDzbRn9GkzKKOEUw1zPKVi3A
         voQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692671037; x=1693275837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W03XGKDZt4A/A7A9W9W876L5kqnKwABEmw+x28hU8A8=;
        b=LKwlE4Di2QQtPyfY74r1+22CYV5C+vPlxUJfWslweeeFcVAtgNjKnAAkWuwKjwjF1X
         SMCM08169+Lu9ZHTn2LWCvYhTKKK+OxnU1ZmYjNHYT59fcWWvCY5ElSD7wdUhnQ4nDHb
         kGtWvHxZDA9kA6qIEEiSprc3U0Tjzi4UtQUHxHFBLEm2a7gvLEhXQIYAd93/ffOsxpXK
         o7r7KYC6PF4RQLw/7FSnQjP2ySHisWFeFZVu42TNkzBLkkBbeps4OvQ8Phw4PH+Wzh64
         414iR/zCrL4IWCFfou/wcJviIaW4YyNlmH509pvGlLHid2KSMV7aeMRaXr6qLF9DvpC1
         n1dg==
X-Gm-Message-State: AOJu0YxiuRagpYBJ/wi1+EZYAeCn+Bf++KIfd0VX9GxnDx9OZHjSATuq
        CXUkLdVfoD9nUjH1veZLAwUJZQ==
X-Google-Smtp-Source: AGHT+IFQnxc5JOY//a/H1zAFxZ7DF4ck67L/fnxvtZaeVnR8wsw9YC0DJ99GVLwLLA/DS978FpLEvA==
X-Received: by 2002:a17:903:1d2:b0:1bb:c2b1:9c19 with SMTP id e18-20020a17090301d200b001bbc2b19c19mr9690840plh.6.1692671036851;
        Mon, 21 Aug 2023 19:23:56 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001bc6fe1b9absm6147149plw.276.2023.08.21.19.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 19:23:56 -0700 (PDT)
Message-ID: <f2c01373-5639-865e-1e51-f699372c4088@bytedance.com>
Date:   Tue, 22 Aug 2023 10:23:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] arm64: mm: use ptep_clear() instead of pte_clear() in
 clear_flush()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        pasha.tatashin@soleen.com, wangkefeng.wang@huawei.com
References: <20230810093241.1181142-1-qi.zheng@linux.dev>
 <20230811110311.GB6993@willie-the-truck>
 <CAOgjDMi6kTZUjEianbO670RQxJ8=JhHxkeci9NspSCRT5rPhYw@mail.gmail.com>
 <20230811112107.GE6993@willie-the-truck>
 <CAOgjDMgVZXbEeA6O2yPR9N27JWCMNR3D7cgHJbmbfYYUdKF3eQ@mail.gmail.com>
 <20230821132119.110668fde87a29443f0bff28@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230821132119.110668fde87a29443f0bff28@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/22 04:21, Andrew Morton wrote:
> On Fri, 11 Aug 2023 19:28:41 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> Will Deacon <will@kernel.org>于2023年8月11日 周五19:21写道：
>>
>>> On Fri, Aug 11, 2023 at 07:16:20PM +0800, Qi Zheng wrote:
>>>>     Will Deacon <[1]will@kernel.org>于2023年8月11日 周五19:03写道：
>>>>
>>>>       On Thu, Aug 10, 2023 at 09:32:41AM +0000, Qi Zheng wrote:
>>>>       > From: Qi Zheng <[2]zhengqi.arch@bytedance.com>
>>>>       >
>>>>       > In clear_flush(), the original pte may be a present entry, so we
>>>>       should
>>>>       > use ptep_clear() to let page_table_check track the pte clearing
>>>>       operation,
>>>>       > otherwise it may cause false positive in subsequent set_pte_at().
>>>>
>>>>       Isn't this true for most users of pte_clear()? There are some in the
>>>>       core
>>>>       code, so could they trigger the false positive as well?
>>>>
>>>>     No, the PTE entry in other places where pte_clear() is used is
>>> non-present
>>>>     PTE.
>>>>     The page_table_check does not does track the pte operation in this
>>> case,
>>>>     so it will not cause false positives.
>>>
>>> Are you sure? For example, the call from flush_all_zero_pkmaps() in
>>> highmem.c really looks like it's clearing a valid entry. Not that arm64
>>> cares about highmem, but still.
>>
>>
>> Ah, this is init_mm, not user mm, page_table_check does not care about this
>> case.
> 
> It's unclear where we stand with this patch.  An ack or a nack, please?

Hi all,

Any comments or suggestions here?

Thanks,
Qi
