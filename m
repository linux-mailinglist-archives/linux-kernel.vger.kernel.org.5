Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFF7D844D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjJZONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbjJZOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:13:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306501AE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:13:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D9C433C8;
        Thu, 26 Oct 2023 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698329581;
        bh=R9KYlxKWJB6gGknm8vcTM/7d21Ua9yVnP7SPGGNg3F8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I+pbggTwVY91xNv6JzPJe0+EhGE8yqPwCyN35wXhk0kpS8Z5wL8DvoBhVSCpQGsU/
         mseFpitVquPjtup7BzOhKG0+8vzJDQ0M2S9uVE39GOC3iB2uGkkMbONH5TVjO/g9no
         pvoRuFWAvthmfQufhMai5On3siiWdFDtL/PXLOI0=
Date:   Thu, 26 Oct 2023 07:13:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
Message-Id: <20231026071300.e12dab3be1edd26007db85ee@linux-foundation.org>
In-Reply-To: <CAHVXubi5C0hBaXx5tqVHZAJSd1zvHRqoxUEkk9ZbmZ5mq2=mAw@mail.gmail.com>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
        <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
        <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
        <CAHVXubi5C0hBaXx5tqVHZAJSd1zvHRqoxUEkk9ZbmZ5mq2=mAw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 10:57:27 +0200 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:

> On Tue, Oct 3, 2023 at 6:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 3 Oct 2023 17:43:10 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
> >
> > > +cc Andrew: Would  you mind taking this patchset in your tree for the
> > > next rc? This patchset depends on a previous fix for arm64 that you
> > > merged in rc4 which is not in the riscv -fixes branch yet.
> > >
> > > I saw with Palmer and he should ack this shortly.
> >
> > Well I grabbed them into mm.git's mm-hotfixes-unstable queue.  All
> > being well I'll move them into mm-hotfixes-stable within a week then
> > into Linus shortly after.
> 
> Those fixes finally did not make it to 6.6, I was hoping for them to
> land in -rc6 or -rc7: for the future, what should have I done to avoid
> that?

They're merged in Linus's tree.

6f1bace9a9fb arm64: hugetlb: fix set_huge_pte_at() to work with all swap entries
935d4f0c6dc8 mm: hugetlb: add huge page size param to set_huge_pte_at()
