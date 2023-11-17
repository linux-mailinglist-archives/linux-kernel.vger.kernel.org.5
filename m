Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B37EF8C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjKQUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:36:59 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC39D6C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:36:55 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4ac1988ca66so1386628e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700253415; x=1700858215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzYXTXSYUx9/iqFjPtSq2xLz7NOgAnCJ2rvjt32VRgI=;
        b=CtCvTByqEiwLhRejQNK2RXGNyodMfEf2xGtequwV0cnQ9gk5jILQP3KN1d3V0e2fyv
         yx2oF+m4bTErTeExajRZ5Vu6DG8c23t/JIyVaJ/0nEASlqaDehcaSlgEJnGV/mGMVJey
         Pv1EGvCxQbn7nNUplSx/jMkC1fLncm7zWeDH+vqzUvXCLaCPLPXv/QsdRLRYPeD1EgrD
         WY1lVIk9bgISJdM5IbX+SkIwVCYuni9v5TMrhWyo6N9AUhWgZD2YEuDWmXqtIG74hSDW
         dgnEuAb07/6soodwHwBWiDwC3r/fE9LpYLLFyLvP1D+1eprbGw6jNB+5NwremYedLkRg
         H6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700253415; x=1700858215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzYXTXSYUx9/iqFjPtSq2xLz7NOgAnCJ2rvjt32VRgI=;
        b=W1xPzer2C4SZHAR41lMdcypS0ogD2/sg1aBO9Nnq5ZgxxcngPY/g7qxI5yfNVemu6w
         no9uQNqBYvLFBi80+Ibi4Kjbp5VFu3C5ROYx5qGzLgOxeTS5c6Ae2zi+JJ+SOPeAgsA1
         FmZpMvotyuEGJkCuAZCcNGsqc9zgA5COUbWK8u4h7rSE541lr+bXciq4MY2lTMkiH3OE
         G4gjqMA1Q32unF51OjzDpm6aBGlMZOQxb02Gp/lPJBYYfQ70rYi+p+SxRmHWcfKbT36A
         n+blag+s9M7XlEz4QeUVqSBnGg4ZkG+HUCTRKBPx9V4qxoikz9kxo8jUPy34ifjnXW0+
         rC1g==
X-Gm-Message-State: AOJu0YxOa0YZuzQuxEbMcq52E5QRs3SuKc1G8nB2Kmp7cP5DsfxN90kc
        ZX2ePLKUbRdEQE6xABcEc9GjdnkhqDV/mDsEISc=
X-Google-Smtp-Source: AGHT+IENUD2GrMxqMfEDk5+EkA9jPkK5Ut8FWiaZyqra5fbxwFZEGji9Fo5q2dv0cqN1TerRWAK59iBRfNalJiE7lJI=
X-Received: by 2002:a1f:e442:0:b0:4ab:ebf3:e518 with SMTP id
 b63-20020a1fe442000000b004abebf3e518mr324396vkh.1.1700253414898; Fri, 17 Nov
 2023 12:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
 <864489b3-5d85-4145-b5bb-5d8a74b9b92d@redhat.com> <CAGsJ_4wsWzhosZJWegOb8ggoON3KdiH1mO-8mFZd7kWcn6diuw@mail.gmail.com>
 <ZVfA2Z8XyD3qtTMZ@casper.infradead.org>
In-Reply-To: <ZVfA2Z8XyD3qtTMZ@casper.infradead.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 18 Nov 2023 04:36:42 +0800
Message-ID: <CAGsJ_4w0f+1-8o+5-Vaj2xfO1Q5tm=AJQVrsST50nWihf02ynQ@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>, steven.price@arm.com,
        akpm@linux-foundation.org, ryan.roberts@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 3:37=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Nov 17, 2023 at 07:47:00AM +0800, Barry Song wrote:
> > This has been discussed. Steven, Ryan and I all don't think this is a g=
ood
> > option. in case we have a large folio with 16 basepages, as do_swap_pag=
e
> > can only map one base page for each page fault, that means we have
> > to restore 16(tags we restore in each page fault) * 16(the times of pag=
e faults)
> > for this large folio.
>
> That doesn't seem all that hard to fix?  Call set_ptes() instead of
> set_pte_at().  The biggest thing, I guess, is making sure that all
> the PTEs you're going to set up are still pte_none().

I guess you mean all are still swap entries in ptes. some risks  I can see

1. vma might be splitted after folios added into swapcache, for example
unmap or mprotect a part of large folios from userspace

2. vma is not splitted, but some basepages are MADV_DONTNEED
within the folios.

3. basepages in the large folio might become having different permissions
on R/W/X.

for example, if a large folio has 16 basepages, as userspace is still
working at 4kb, userspace can mprotect RD_ONLY for a part of them,
in this case, 16PTEs will still be swap entries, but the re-use for
write fault can't work at folio granularity.

I need to consider all the above DoubleMap/split risks rather than simply
checking PTEs as userspace is still 4KB.

>

Thanks
Barry
