Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5217ED356
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjKOUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjKOUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:49:28 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC557BD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:49:24 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45da062101bso13649137.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700081364; x=1700686164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRhBv/dMeG2FZyRF2fwjhSdAhbpeg8H/eHSis9G2sOg=;
        b=NT5j3XLdwAA1cHJLp30uodQ5MKp1Wk6wtVKzIEXFkQZTO6Jp5KnMu9FWIPGz5O2IyN
         HlKtnnpJZi6d5lFu6ZO5KDi7OGuWcL2FHKgcITP9UANQ+HC28TU79nErZMevhQCM1+9H
         UP4QRwprn5OQoeVFho0SfB6ZveyRAvvcNQ6YIoATfb79zqgvCowp6TjHQ7+ens1New6q
         lTGyEW06EWC24uaRAxxwAwN4kPj0R1xECZ3YHdjJU3AbM0EDnPd4I9XWl8OxYV2cY9Wu
         8bnPTku7dv0UwpVJr7I2MVUAwj/I4qqqYkNq8b83rUN9ae+xP6yWySFQfHGAswGtcmBC
         +kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700081364; x=1700686164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRhBv/dMeG2FZyRF2fwjhSdAhbpeg8H/eHSis9G2sOg=;
        b=dJZnVqMCX0Pjwzo8CjgzYQOKYidR4jXz0DvKIfq86L7anYWuo88LpoPyIuAUrOrprD
         yCeKTECtFHhQQZiY+J/vYL4B3SmP1ZFfHbNSGTGmhbv3pIDufepW90RzJ3IHEAhkGu8d
         mDtBDzB/TllOgA6LreC1sgV/2P3Qb28e97QMG3HMAHqsFVLLMTzSYV/K1hYSAmRmIz0v
         il7NJN2q5IdsQX4FYDkvLbZRfGPAWP/CEQFz6gZMEBjME7g3H0cZjEVNFyRqh2JGG2gW
         NsaQY5G960t39mzR2k3wC8VKS9MuoZ5R+L6hTPgIZfhOpXhU8UvKJir9HZ0sktGzFD+a
         Vanw==
X-Gm-Message-State: AOJu0YwDJ9zCrSt5hOC2JKAutXg9jf72xX/YWMqkJgvTKDD4G4f5sVc7
        +RoZcJgXwIIvtgpD8nbOYsvAxhf5B281N/yKC9o=
X-Google-Smtp-Source: AGHT+IEwTvGiLp38CnLVNL8JAzedvIIaLhCkTSSxe7Ctyudv2L577GJOnOevUvbMcLbZLMupaZyImGFlb9E38rJxsE8=
X-Received: by 2002:a05:6102:298a:b0:45f:a41:b405 with SMTP id
 dl10-20020a056102298a00b0045f0a41b405mr13496470vsb.21.1700081363746; Wed, 15
 Nov 2023 12:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
In-Reply-To: <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 16 Nov 2023 04:49:11 +0800
Message-ID: <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     David Hildenbrand <david@redhat.com>
Cc:     steven.price@arm.com, akpm@linux-foundation.org,
        ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com
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

On Wed, Nov 15, 2023 at 11:16=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 14.11.23 02:43, Barry Song wrote:
> > This patch makes MTE tags saving and restoring support large folios,
> > then we don't need to split them into base pages for swapping out
> > on ARM64 SoCs with MTE.
> >
> > arch_prepare_to_swap() should take folio rather than page as parameter
> > because we support THP swap-out as a whole.
> >
> > Meanwhile, arch_swap_restore() should use page parameter rather than
> > folio as swap-in always works at the granularity of base pages right
> > now.
>
> ... but then we always have order-0 folios and can pass a folio, or what
> am I missing?

Hi David,
you missed the discussion here:

https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68Mk=
hjMDw@mail.gmail.com/
https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1=
Veocg@mail.gmail.com/

>
> >
> > arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
> > who needed it.
>
> Can we do that separately?

i think it is ok.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry
