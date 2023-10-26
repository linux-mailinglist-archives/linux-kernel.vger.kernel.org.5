Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A006F7D84BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbjJZOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJZOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:30:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5830D9C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:30:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3362D2F4;
        Thu, 26 Oct 2023 07:31:29 -0700 (PDT)
Received: from [10.1.36.151] (XHFQ2J9959.cambridge.arm.com [10.1.36.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3673F64C;
        Thu, 26 Oct 2023 07:30:46 -0700 (PDT)
Message-ID: <36aa1ec7-df13-4741-be09-c53a05f3d591@arm.com>
Date:   Thu, 26 Oct 2023 15:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
Content-Language: en-GB
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
 <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
 <CAHVXubi5C0hBaXx5tqVHZAJSd1zvHRqoxUEkk9ZbmZ5mq2=mAw@mail.gmail.com>
 <20231026071300.e12dab3be1edd26007db85ee@linux-foundation.org>
 <32d9627c-821a-48f0-b430-0532a47b8699@ghiti.fr>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <32d9627c-821a-48f0-b430-0532a47b8699@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 15:15, Alexandre Ghiti wrote:
> n 26/10/2023 16:13, Andrew Morton wrote:
>> On Thu, 26 Oct 2023 10:57:27 +0200 Alexandre Ghiti <alexghiti@rivosinc.com>
>> wrote:
>>
>>> On Tue, Oct 3, 2023 at 6:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>> On Tue, 3 Oct 2023 17:43:10 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>>> +cc Andrew: Would  you mind taking this patchset in your tree for the
>>>>> next rc? This patchset depends on a previous fix for arm64 that you
>>>>> merged in rc4 which is not in the riscv -fixes branch yet.
>>>>>
>>>>> I saw with Palmer and he should ack this shortly.
>>>> Well I grabbed them into mm.git's mm-hotfixes-unstable queue.  All
>>>> being well I'll move them into mm-hotfixes-stable within a week then
>>>> into Linus shortly after.
>>> Those fixes finally did not make it to 6.6, I was hoping for them to
>>> land in -rc6 or -rc7: for the future, what should have I done to avoid
>>> that?
>> They're merged in Linus's tree.
>>
>> 6f1bace9a9fb arm64: hugetlb: fix set_huge_pte_at() to work with all swap entries
>> 935d4f0c6dc8 mm: hugetlb: add huge page size param to set_huge_pte_at()
> 
> 
> Oops, sorry, I missed them this morning!

Those two patches that Andrew highlights are the fix I did for arm64. Weren't
you referring to the corresponding patches you did for riscv, Alex?

> 
> Thanks,
> 
> Alex
> 

