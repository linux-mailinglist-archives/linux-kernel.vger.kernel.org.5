Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214EA7D8455
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbjJZOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbjJZOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:15:47 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D52128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:15:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE5F11C000E;
        Thu, 26 Oct 2023 14:15:39 +0000 (UTC)
Message-ID: <32d9627c-821a-48f0-b430-0532a47b8699@ghiti.fr>
Date:   Thu, 26 Oct 2023 16:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
 <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
 <CAHVXubi5C0hBaXx5tqVHZAJSd1zvHRqoxUEkk9ZbmZ5mq2=mAw@mail.gmail.com>
 <20231026071300.e12dab3be1edd26007db85ee@linux-foundation.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231026071300.e12dab3be1edd26007db85ee@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n 26/10/2023 16:13, Andrew Morton wrote:
> On Thu, 26 Oct 2023 10:57:27 +0200 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
>> On Tue, Oct 3, 2023 at 6:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>> On Tue, 3 Oct 2023 17:43:10 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>
>>>> +cc Andrew: Would  you mind taking this patchset in your tree for the
>>>> next rc? This patchset depends on a previous fix for arm64 that you
>>>> merged in rc4 which is not in the riscv -fixes branch yet.
>>>>
>>>> I saw with Palmer and he should ack this shortly.
>>> Well I grabbed them into mm.git's mm-hotfixes-unstable queue.  All
>>> being well I'll move them into mm-hotfixes-stable within a week then
>>> into Linus shortly after.
>> Those fixes finally did not make it to 6.6, I was hoping for them to
>> land in -rc6 or -rc7: for the future, what should have I done to avoid
>> that?
> They're merged in Linus's tree.
>
> 6f1bace9a9fb arm64: hugetlb: fix set_huge_pte_at() to work with all swap entries
> 935d4f0c6dc8 mm: hugetlb: add huge page size param to set_huge_pte_at()


Oops, sorry, I missed them this morning!

Thanks,

Alex

