Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333ED7A43F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbjIRIIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjIRIIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:08:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5341AD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:06:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35444C433CA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695024364;
        bh=AxhP1qUZ6L8D85WygjwNWOG3OogI8UwnrtK6B11kuho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ev0bMudmfGo1Sm5fm2k7W1Pz9Sc41I8Oxj/tg9dQLDH7oPS5/rQ4HI9q/QIHbNO0s
         5q++zG0X6c9MOEeie/uiQpP/r6N0nV2eeKlsyR88/4DbBWPEg8hy9+ca71B63dtff3
         S1tl/9Y+iLS4JX3qBNFzoYwRPiphVu5Hy/ASiA9RCueATCjs7QCE0tqiViSpGk2/O6
         jBsKHDSKJzTADQcKxVowR/d885gHV2qWq+xWHNgwMkNDDrvn4HzEFJcz6WbxHCul8n
         QWZD2liOEkKooGwXIMDWixVcWy9baVErtS12qGXdgk4cJ4wy5YIiZeu5uhUPXAKnWg
         rzlrDp51xZBpA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so4795204a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:06:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpcpbUCG4KZn8gahbGzLgbvtCGbLvr+sypzFlLmAsQRqR78Lbt
        1RlncLcr5bJP6NDBOaLCQcTdA3g++PbPWSULtwo=
X-Google-Smtp-Source: AGHT+IHUuSYye6BWA93KBT5rLo5F4a0/T5b7KQein1/mOTRyb192Farkzy4tF6PxQyNKGpHh3XWDfwzJA1lW5D5wqIU=
X-Received: by 2002:a05:6402:14c4:b0:530:4fc4:50f8 with SMTP id
 f4-20020a05640214c400b005304fc450f8mr6228588edx.29.1695024362563; Mon, 18 Sep
 2023 01:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
 <CAAhV-H6Q0sirFEDdc1v4BSfDY94eZvJazy0XLKM8V94GMJvQnQ@mail.gmail.com>
 <ZQNWh2DY319jGbfq@smile.fi.intel.com> <CAAhV-H66LUWHP-eGp6VGvs0F+QD=QJ69uR3_1A3SqH9cyPUPoQ@mail.gmail.com>
 <ZQWCeI6E7rm8Akbt@smile.fi.intel.com> <CAAhV-H6dakVH0a4Mt9MdcY8OO3gdne6rW0Z1kK6YRq9hDLP05w@mail.gmail.com>
 <ZQfzDXc0WRHCUeIq@smile.fi.intel.com>
In-Reply-To: <ZQfzDXc0WRHCUeIq@smile.fi.intel.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 18 Sep 2023 16:05:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4HkA=SZAb-4q5QVdyDB1MsEsmjVO_N8h30MkSXzpzimQ@mail.gmail.com>
Message-ID: <CAAhV-H4HkA=SZAb-4q5QVdyDB1MsEsmjVO_N8h30MkSXzpzimQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: Add missing headers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy,

On Mon, Sep 18, 2023 at 2:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Sep 16, 2023 at 08:05:52PM +0800, Huacai Chen wrote:
> > On Sat, Sep 16, 2023 at 6:27=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 15, 2023 at 08:36:24AM +0800, Huacai Chen wrote:
> > > > On Fri, Sep 15, 2023 at 2:53=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Sep 14, 2023 at 11:25:22PM +0800, Huacai Chen wrote:
> > >
> > > > > > Thank you for your patch, can this patch solve the problem belo=
w?
> > > > > > https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ-lkp=
@intel.com/T/#u
> > > > >
> > > > > Nope, this just adds missing includes.
> > > > > No functional change, so warnings will still be there.
> > > > But I think a patch should solve a problem.
> > >
> > > No, that problem is static analyser concern, not the compiler nor lin=
ker.
> > >
> > > > If we don't get a build
> > > > error or warning without this patch, does that mean the 'missing'
> > > > headers are actually included indirectly?
> > >
> > > I might be missing something, but I do not see any build error in the=
 above message.
> > Hmm, then I think I will take the second patch only.
>
> Thanks, but can you shed a light why?
>
> The rule of thumb is to include the headers we are direct users of, we ha=
ve not
> to imply any other inclusions done by others, unless it's kinda same fami=
ly of
> headers (like types.h always includes compiler_types.h). Since in your ca=
se
> the const.h is included the other two are missing and it's even worse, as=
 I
> understand you rely on the specific headers to be included _before_ using=
 this
> one in the users.
I agree with you more or less, but I doubt there is another rule: no
break, no fix. Please see:

https://lore.kernel.org/loongarch/20221024070105.306280-1-chenhuacai@loongs=
on.cn/T/#t

Obviously static_key is used in page-flags.h and it really causes
build errors once before, but at last I removed the inclusion of
static_key.h to get that series merged.

Huacai

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>
