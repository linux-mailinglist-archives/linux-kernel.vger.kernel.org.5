Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D480CF80
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbjLKP1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjLKP1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:27:45 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13314E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:27:51 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67ad891ff36so31033956d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702308470; x=1702913270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iN9bN85mkk9gb8ZXTbv0vDp/cwGaFm0XvPZtFw0AYAo=;
        b=UKp6rh8CnuHz0jgiqwVFFlJgFcKB4QvVlUSVcZWbMHD50jR+sOvxWX42GB0H2DGrae
         hAf0KWjtS4DlPsGr8b1OyP1pa04X1ckgfItxFhUz9NqYb8vy1ezdjwAtpTPJfMtCtQdc
         CCnvgzggXlmUILLhjy3a2YdaRIgVOFD24epzbZmAZVgH91G34MfbRpG4Ua+kWUclaWdt
         IOh1MO/TBeG0ebOAPRTIJ1FbtrAj7QM3HD2KICFP5fy9/ulX6ae1WpnulyJS/CzUVb0W
         RiEtHOEcBy4NR96cAe2KpT4GWR93tGHRoq7OVfaSQGmOzTIvPJ/6IWQ6LrCotTQF1pS7
         DbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308470; x=1702913270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN9bN85mkk9gb8ZXTbv0vDp/cwGaFm0XvPZtFw0AYAo=;
        b=sBhb0WSs24+xXg1nOwzeqISb3d9dL+4VNfieojqf5fitzK/J0R6hgK4rjSkg+Rf+CN
         qK31n4CfQX/OUIQqWnlN3Lm42LaAZxTm+hYWwCYyVOJxsSryb3/XgOfn0YtFuIBHslJB
         MBlVeHobEUCcy8zY5erbTVj9RQbWTavFBY2mMKEAeb+wk187XAIFN48ADrFirlkzD0NS
         A4lcegLCP/DOayprmlB90/DM9sLZS6kah9uJpx/Id8Nx//B1lbabdOOjv+v7qtWF95TT
         kCIosyY3fLVJMwhrkKVXshKbHlz1eohKJXTberSINxM9dGSbkAvGudt8iqLlNpak8SHR
         PWzw==
X-Gm-Message-State: AOJu0YxUSAyGm9zHz4R1z+V//NkPcYQCXml4hfiLYaXIOL0Ul3UCVSld
        O/EbIuZJAtschFepw9Lr7BKRMw==
X-Google-Smtp-Source: AGHT+IGVodSbepAQwKoZ95nkl+0HFnF1yHOk1xm8E0xgTkFXuMvl+0Rpg/a165J2vySkq7RuQhuJnw==
X-Received: by 2002:ad4:4352:0:b0:67a:9b59:8af7 with SMTP id q18-20020ad44352000000b0067a9b598af7mr5530003qvs.2.1702308470068;
        Mon, 11 Dec 2023 07:27:50 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e? ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cfa91000000b0067a56b6adfesm3362804qvn.71.2023.12.11.07.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 07:27:49 -0800 (PST)
Message-ID: <b9292e35-6870-4c6d-8831-c9b15a33f52f@sifive.com>
Date:   Mon, 11 Dec 2023 09:27:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: pgtable: Enhance set_pte to prevent OoO risk
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        willy@infradead.org, david@redhat.com, muchun.song@linux.dev,
        will@kernel.org, peterz@infradead.org, rppt@kernel.org,
        paulmck@kernel.org, atishp@atishpatra.org, anup@brainfault.org,
        alex@ghiti.fr, mike.kravetz@oracle.com, dfustini@baylibre.com,
        wefu@redhat.com, jszhang@kernel.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
References: <20231208151036.2458921-1-guoren@kernel.org>
 <CAHVXubjfuKZ1PBYQ8By41OX65YpAma3_kmSL7urT8L0PmMxFnQ@mail.gmail.com>
 <CAJF2gTSB-4hDo8ncSLVKvbnOOEwLSrV716kQM9d9HrzXFs7D8A@mail.gmail.com>
 <CAHVXubiK0TXMuhZhYjLq7tyk_dhFP9W2uReacECWDC7HToYuXA@mail.gmail.com>
 <CAJF2gTSCZ4ytzkenibT+38TzqoYKjBebRRabzn7YQ79bY5yp3g@mail.gmail.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAJF2gTSCZ4ytzkenibT+38TzqoYKjBebRRabzn7YQ79bY5yp3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-11 5:36 AM, Guo Ren wrote:
> On Mon, Dec 11, 2023 at 5:04 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>
>> On Mon, Dec 11, 2023 at 9:41 AM Guo Ren <guoren@kernel.org> wrote:
>>>
>>> On Mon, Dec 11, 2023 at 1:52 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>>>
>>>> Hi Guo,
>>>>
>>>> On Fri, Dec 8, 2023 at 4:10 PM <guoren@kernel.org> wrote:
>>>>>
>>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>>
>>>>> When changing from an invalid pte to a valid one for a kernel page,
>>>>> there is no need for tlb_flush. It's okay for the TSO memory model, but
>>>>> there is an OoO risk for the Weak one. eg:
>>>>>
>>>>> sd t0, (a0) // a0 = pte address, pteval is changed from invalid to valid
>>>>> ...
>>>>> ld t1, (a1) // a1 = va of above pte
>>>>>
>>>>> If the ld instruction is executed speculatively before the sd
>>>>> instruction. Then it would bring an invalid entry into the TLB, and when
>>>>> the ld instruction retired, a spurious page fault occurred. Because the
>>>>> vmemmap has been ignored by vmalloc_fault, the spurious page fault would
>>>>> cause kernel panic.
>>>>>
>>>>> This patch was inspired by the commit: 7f0b1bf04511 ("arm64: Fix barriers
>>>>> used for page table modifications"). For RISC-V, there is no requirement
>>>>> in the spec to guarantee all tlb entries are valid and no requirement to
>>>>> PTW filter out invalid entries. Of course, micro-arch could give a more
>>>>> robust design, but here, use a software fence to guarantee.
>>>>>
>>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>> ---
>>>>>  arch/riscv/include/asm/pgtable.h | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>>>> index 294044429e8e..2fae5a5438e0 100644
>>>>> --- a/arch/riscv/include/asm/pgtable.h
>>>>> +++ b/arch/riscv/include/asm/pgtable.h
>>>>> @@ -511,6 +511,13 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
>>>>>  static inline void set_pte(pte_t *ptep, pte_t pteval)
>>>>>  {
>>>>>         *ptep = pteval;
>>>>> +
>>>>> +       /*
>>>>> +        * Only if the new pte is present and kernel, otherwise TLB
>>>>> +        * maintenance or update_mmu_cache() have the necessary barriers.
>>>>> +        */
>>>>> +       if (pte_val(pteval) & (_PAGE_PRESENT | _PAGE_GLOBAL))
>>>>> +               RISCV_FENCE(rw,rw);
>>>>
>>>> Only a sfence.vma can guarantee that the PTW actually sees a new
>>>> mapping, a fence is not enough. That being said, new kernel mappings
>>>> (vmalloc ones) are correctly handled in the kernel by using
>>>> flush_cache_vmap(). Did you observe something that this patch fixes?
>>> Thx for the reply!
>>>
>>> The sfence.vma is too expensive, so the situation is tricky. See the
>>> arm64 commit: 7f0b1bf04511 ("arm64: Fix barriers used for page table
>>> modifications"), which is similar. That is, linux assumes invalid pte
>>> won't get into TLB. Think about memory hotplug:
>>>
>>> mm/sparse.c: sparse_add_section() {
>>> ...
>>>         memmap = section_activate(nid, start_pfn, nr_pages, altmap, pgmap);
>>>         if (IS_ERR(memmap))
>>>                 return PTR_ERR(memmap);
>>>
>>>         /*
>>>          * Poison uninitialized struct pages in order to catch invalid flags
>>>          * combinations.
>>>          */
>>>         page_init_poison(memmap, sizeof(struct page) * nr_pages);
>>> ...
>>> }
>>> The section_activate would use set_pte to setup vmemmap, and
>>> page_init_poison would access these pages' struct.
>>
>> So I think the generic code must be fixed by adding a
>> flush_cache_vmap() in vmemmap_populate_range() or similar: several
>> architectures implement flush_cache_vmap() because they need to do
>> "something" after a new mapping is established, so vmemmap should not
>> be any different.
> Perhaps generic code assumes TLB won't contain invalid entries. When
> invalid -> valid, Linux won't do any tlb_flush, ref:
> 
> * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
>  * TLB flush will be required as a result of the "set". For example, use
>  * in scenarios where it is known ahead of time that the routine is
>  * setting non-present entries, or re-setting an existing entry to the
>  * same value. Otherwise, use the typical "set" helpers and flush the
>  * TLB.
> 
>>
>>>
>>> That means:
>>> sd t0, (a0) // a0 = struct page's pte address, pteval is changed from
>>> invalid to valid
>>>  ...
>>> lw/sw t1, (a1) // a1 = va of struct page
>>>
>>> If the lw/sw instruction is executed speculatively before the set_pte,
>>> we need a fence to prevent this.
>>
>> Yes I agree, but to me we need the fence property of sfence.vma to
>> make sure the PTW sees the new pte, unless I'm mistaken and something
>> in the privileged specification states that a fence is enough?
> All PTW are triggered by IFU & load/store. For the "set" scenarios, we
> just need to prevent the access va before the set_pte. So:
>  - Don't worry about IFU, which fetches the code sequentially.
>  - Use a fence prevent load/store before set_pte.
> 
> Sfence.vma is used for invalidate TLB, not for invalid -> valid.

I think the problem is that, architecturally, you can't prevent a PTW by
preventing access to the virtual address. The RISC-V privileged spec allows
caching the results of PTWs from speculative execution, and it allows caching
invalid PTEs. So effectively, as soon as satp is written, software must be able
to handle _any_ virtual address being in the TLB.

To avoid the sfence.vma in the invalid->valid case, you need to handle the
possible page fault, like in Alex's series here:

https://lore.kernel.org/linux-riscv/20231207150348.82096-1-alexghiti@rivosinc.com/

Regards,
Samuel

