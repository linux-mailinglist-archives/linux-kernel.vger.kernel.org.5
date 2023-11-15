Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631327ED787
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjKOWp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:45:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03892195
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:45:55 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c1acc1fa98so1066765a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700088354; x=1700693154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nJjkgwnquHHuOaLHOOrng4yzhJOgtCK4+wbNH+tNy8=;
        b=QdW4KQU6LpPqzA4SiMIpkmoxYUSgaBp6XagGXRBdCQ/AFe1/a7wn0gpB1S607yIJFH
         gj9Mw5JvCjYVJL0nwgf8BnJ6EBboopsglzbWrmoVq7l3+lqHKCB0EILBPvM8faiR192r
         YQ0iM6UYtAdqb80M3vKdRyO4iJ8WaLExmW886D52iEDUDCdyYxB12T6OViyJAc+qfGOF
         CFwa0XhxOZprHKsS+dNkcpRsAP4TLXRLkDItkaJdZV/PSsutuR705m973h9ldUpay4Nn
         qC6SGD3W5uJlyn+UBvsKi98XdRZ2kXO3CzG4UX5S9LcP8intW0FcXTSxhowwcRiOMYMi
         YAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088354; x=1700693154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nJjkgwnquHHuOaLHOOrng4yzhJOgtCK4+wbNH+tNy8=;
        b=gyy3fUfHtbOmxK1Yr184BmfuSp7tqLrAtTM4ZDC5iEO/W0Bn5FqoQLNsYiJealV7O+
         5yIeBYMnbB7Ro3N6XHCYohokqPDvxOBatj3g/0AuMAhLbPGcVD0vco47ArNQ90GloKWD
         JDcDuuXfetwpqoyvnXgJLhlhlQNyKgez61Nlf8198CZkRxfz4HKw4i9ZOMszM+2exHEn
         aP8boSCFIFlwMz/ihJukrseXYuSTxuAUmfvQpwphflk81h9qjCE+RbNGVODjixucXG8q
         7I9W2/+V5HP2qpPp58oX7ewH37wxsNO+6XnB/1yGWf8CgntMxgHunNNVqvHXkwtILCWK
         rB3w==
X-Gm-Message-State: AOJu0Yw9YrgWSu2msqmlWJwCV9fb4pqGBco2PHZNdm32/aC+iwlFWkXv
        P9LYpnL4orFkZk3rdhwnKSDvQS1RWAIqBcn5HlE=
X-Google-Smtp-Source: AGHT+IFWJLMP35QdB/HcbXYKW5MUQcrpjrSbORoDJin7bLHVuHfxxHIuONYZtUmWSljUE66jKlaFV8nIZgBGIwSTQb8=
X-Received: by 2002:a17:90b:1056:b0:280:8e7d:5701 with SMTP id
 gq22-20020a17090b105600b002808e7d5701mr9875600pjb.2.1700088354411; Wed, 15
 Nov 2023 14:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20231114014313.67232-1-v-songbaohua@oppo.com> <d8fd421e-00f3-453e-9665-df3fdcc239eb@redhat.com>
 <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wD9Ug=CLi6Cdw3Ve5q8-1u7MmipLtEGQTfWmU9BJFJOQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Nov 2023 14:45:42 -0800
Message-ID: <CAHbLzkoNAFGikx-pRwTVr2Bf5mvv8Xb8c6oWV5t4JZ4m0KAurA@mail.gmail.com>
Subject: Re: [RFC V3 PATCH] arm64: mm: swap: save and restore mte tags for
 large folios
To:     Barry Song <21cnbao@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, steven.price@arm.com,
        akpm@linux-foundation.org, ryan.roberts@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        v-songbaohua@oppo.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 12:49=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Nov 15, 2023 at 11:16=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >
> > On 14.11.23 02:43, Barry Song wrote:
> > > This patch makes MTE tags saving and restoring support large folios,
> > > then we don't need to split them into base pages for swapping out
> > > on ARM64 SoCs with MTE.
> > >
> > > arch_prepare_to_swap() should take folio rather than page as paramete=
r
> > > because we support THP swap-out as a whole.
> > >
> > > Meanwhile, arch_swap_restore() should use page parameter rather than
> > > folio as swap-in always works at the granularity of base pages right
> > > now.
> >
> > ... but then we always have order-0 folios and can pass a folio, or wha=
t
> > am I missing?
>
> Hi David,
> you missed the discussion here:
>
> https://lore.kernel.org/lkml/CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68=
MkhjMDw@mail.gmail.com/
> https://lore.kernel.org/lkml/CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzm=
h1Veocg@mail.gmail.com/
>
> >
> > >
> > > arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
> > > who needed it.
> >
> > Can we do that separately?
>
> i think it is ok.

IMHO keeping it in this patch makes more sense. IIRC removing
arch_thp_swp_supported() is just because this patch made swapping
large folio with MTE more efficiently.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>
> Thanks
> Barry
