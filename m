Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E97F4756
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbjKVNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbjKVNEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:04:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AD2191;
        Wed, 22 Nov 2023 05:04:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3316bb1303bso3198662f8f.0;
        Wed, 22 Nov 2023 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700658260; x=1701263060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJjddlN5DWmcfRDHEC6/9b8JvAgpRUucLVE+7RqzHnw=;
        b=M1DHttSBGUJzPyCQKNKC4hnsP4zS5F+BqZiD4veQ0l+fTyva9DjxhCLtoxM6a+TZGE
         LVNyDfdEBnwkg6AMRSAtko/hPjwyAyqhEE2Ecp6v+G2hIGHFCfS8h1Ge0XG203VelbOC
         YvKHCcL47kE63fjyzsr9T9nsEv+b/Mn3n8BQlGBgxCvNVJ/Ak/sW31EtHHJHf6/CF0+n
         ZoEKhICB/dy3yD0KId56S7608jbctdk47DTuyx8qp/1LP7UZeosDBFTm8sD5sUjcumge
         FRprVwtVTuvvKYwkuW4Uv/WlyEouyhTZhNi2+WeDsDIwDyI/k+caK/pLsoYxKghPDIlI
         pPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700658260; x=1701263060;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJjddlN5DWmcfRDHEC6/9b8JvAgpRUucLVE+7RqzHnw=;
        b=pbsqjyQ0nNvqObyLb+IiFS93f5BMB7SDz1yek+mSGXXLcZD35iIQdLoVBuP/Nc1KI5
         3hQl4kcvafReCh+7vx2xehL1c+YBkK7fW5OA5SZpIqJyxzgVBlkdKwo7l3u+J9nG8FN/
         JNxD45Gt/O1mmMPFLRouM1tFGeLI727DkYDuaqwo/LEVx8h9MVMcfj6Ut3jX/JXZbPkM
         oyl4/Iv3Jx9BmhgbzUGApe0qiTnQDFTZG2Q9i00gRncuapP+p53Q4T8m+9wZDA1itJPX
         jNpuB9OcZSAa1U5dsm40G1uLAG9LxihPEQwV05/BtWZUTBcUkLsUNYv8KpaBC/ObZRGO
         rhPA==
X-Gm-Message-State: AOJu0Yyhif57uLPY5BzFRvHBOXGBw6UtS7XqHniKjy72f6pTPEzpyGeO
        ZWBEKXxLP+hItFtJvp66mB3M1WR70utAxg==
X-Google-Smtp-Source: AGHT+IHLgoMBmKHkrPnhF7Fed9ID2E4d78OF7gRmurHDCdnOfUW+7Hk+5s6yML9wIU3rMEGN9AXNuA==
X-Received: by 2002:a5d:6146:0:b0:331:6d97:bd3f with SMTP id y6-20020a5d6146000000b003316d97bd3fmr249880wrt.20.1700658259698;
        Wed, 22 Nov 2023 05:04:19 -0800 (PST)
Received: from [10.95.134.92] (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id cm4-20020a5d5f44000000b00332d3b89561sm1115351wrb.97.2023.11.22.05.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 05:04:19 -0800 (PST)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <6a7695f7-e946-4e5f-8da1-a59ac7df7734@xen.org>
Date:   Wed, 22 Nov 2023 13:04:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v9 04/15] KVM: pfncache: add a mark-dirty helper
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122121822.1042-1-paul@xen.org>
 <20231122121822.1042-5-paul@xen.org>
 <e8beb0b9879062d6593f089b8c8c6a84485d28ad.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <e8beb0b9879062d6593f089b8c8c6a84485d28ad.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 12:24, David Woodhouse wrote:
> On Wed, 2023-11-22 at 12:18 +0000, Paul Durrant wrote:
>>
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -1367,6 +1367,16 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
>>    */
>>   void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>>   
>> +/**
>> + * kvm_gpc_mark_dirty - mark a cached page as dirty.
>> + *
>> + * @gpc:          struct gfn_to_pfn_cache object.
>> + */
>> +static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
>> +{
>> +       mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
>> +}
> 
> This doesn't rescind my existing ack, but it's probably worth asserting
> that gpc->lock is held here?

Yes, a good idea. If a v10 is needed, I'll add it. Otherwise I can do it 
as an incremental patch.

   Paul
