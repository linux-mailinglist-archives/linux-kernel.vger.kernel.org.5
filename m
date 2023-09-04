Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5232791D61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbjIDSrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbjIDSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:47:10 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA92CC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:47:07 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a751d2e6ecso1405237b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693853226; x=1694458026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaTRr5UMKxcVsZRJAV9XvJRS8SqRW/bF8mzq2cA6680=;
        b=UOSo+UpVuXdHyeXkSqIxPGOtHDky7BF1LiNyWB5UEDz3dWbMEt7mN4pvSddfUVV66v
         AhmQh391rlYv/T3XeM8Yf0gUx5Tw7CAoIDjFBrRuz06jkjuzsS2++BvR7iSQ6hu0xZnf
         rgJ+Eg/R/4+NM39bqEsG4zsNalRaXQ1TkZCrLUv2jquhiz3s1l795EpPa7FoQVgotoYx
         /tVupvGoHc8OpIz8F7FNIdy+qACptrJQBhT7IzZOu8R6GFOJypu91Q1AC87p/5W/pvh2
         BaB8mKJgKBKt68z2+WCt6fNBQ4oh53IFz36X4XlY2Xp/fmpJh8ORXNFwBSHHaDINokuF
         5/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853226; x=1694458026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaTRr5UMKxcVsZRJAV9XvJRS8SqRW/bF8mzq2cA6680=;
        b=hQ7aXTY8PbOD2gNhvihzsyI8+ymF3jIbvOFM50nE/xHn1kmG09Vcnw+adkidszSbeu
         eKOr5LMa45RbPuX2cUuDXykO/whgFlu+9OB4YIrB/X0MjMQA9/RWNZgnCRZciaVCLvC8
         zoL1Uyafkp4KD9RNW+kQu8KzKO9g5gBLfnjgdSHl/WJJ+v2CHr3qU/EzDyqPT3HmswZV
         8SEt4bxFsPuI6P9MK5qv+vIrGw+Wj7UhXILdGqDCmqbO5DtPE8mm+BriZDuOn7A1+5mc
         pIvbUqIr89F0J4PgoAP5ilAraFsxZ1XPpu4oDRNvwUNIJXEkFYRJMFkXD3guoWyM0xsU
         nozA==
X-Gm-Message-State: AOJu0YysbQGf9oJIPfJDZAJ8Uxzi7fVGmXlFO0p0CnDV44Fc7O1Nr3Wx
        HI2haVYapFs2xZJRXeYHIynL0XQD+m/qaZfPmgE=
X-Google-Smtp-Source: AGHT+IFrQyYxf9mu6OQJRkwxZtP3BPLAaDIXHK+koZWFterk3y8MxXzDIjkVjeslWbyfx2KCHtTSMmK3hl0952XzYDU=
X-Received: by 2002:a05:6808:14c7:b0:3a9:c2d6:41ef with SMTP id
 f7-20020a05680814c700b003a9c2d641efmr14490048oiw.43.1693853226412; Mon, 04
 Sep 2023 11:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
 <bb2f8a4f90432452822326b927e8cab58665cd09.camel@mediatek.com>
In-Reply-To: <bb2f8a4f90432452822326b927e8cab58665cd09.camel@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 4 Sep 2023 20:46:55 +0200
Message-ID: <CA+fCnZc-3_bDaSaa0u-EYfkvP=580bYMiHRtm99=XRypRCVXDA@mail.gmail.com>
Subject: Re: [PATCH 12/15] stackdepot: add refcount for records
To:     =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
Cc:     "glider@google.com" <glider@google.com>,
        "elver@google.com" <elver@google.com>,
        "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "eugenis@google.com" <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 3:06=E2=80=AFPM 'Kuan-Ying Lee (=E6=9D=8E=E5=86=A0=
=E7=A9=8E)' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> > @@ -452,6 +455,7 @@ depot_stack_handle_t __stack_depot_save(unsigned
> > long *entries,
> >       /* Fast path: look the stack trace up without full locking. */
> >       found =3D find_stack(*bucket, entries, nr_entries, hash);
> >       if (found) {
> > +             refcount_inc(&found->count);
> >               read_unlock_irqrestore(&pool_rwlock, flags);
> >               goto exit;
> >       }
>
> Hi Andrey,
>
> There are two find_stack() function calls in __stack_depot_save().
>
> Maybe we need to add refcount_inc() for both two find_stack()?

Indeed, good catch! Will fix in v2.

Thanks!
