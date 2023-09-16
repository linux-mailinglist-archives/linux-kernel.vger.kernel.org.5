Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6127A2FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjIPMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjIPMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:06:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3257CE9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:06:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765B1C433C7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694865966;
        bh=pym0uMbgIIU9FmgXRD1TcUJqDfsFiCpt/LN+3YIJd8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r4E+xR82uxlkGBbGxYlasgHFa1KHXtG0ywFryFi3oS12gyF7+kRNf1Qf/1rv8rR7A
         8xGslYSj79NVk+JzAWnjSIpmvFQs5hRaahwEMuxorqVCCS29q2J4EiQscaOrrO/wF3
         ROaqDdJX0yivHiaU0Cjz86MuKCY5/ey/k0zG70ZRFQ6CbDvbO3OJEF/9MpGn4LQWzP
         K+X4u/b0NnbtgBgpAr2goiag+XAcAQwIzNdJZL+chFcMaqXNvzSxkA5G1DTysbWj2g
         Vhp9fn4i0OAnw2avs2iOQT/KV1oTGIcgtlWRyy/+F1K0jpROdtOQymahvop4/7sDUj
         +prhG9Lun/1lA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso4856575e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:06:06 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx5Sx2Gl7xfgyXhh5KfB6qtxH0+lJoYHrTCi/o+2aQ8l0TMwEgn
        vJT1ACXrb8OgrDrYq1+sVeKT7o3KYSlSEmL2ljw=
X-Google-Smtp-Source: AGHT+IE2eeeJ1Keo+h3txEbl7/sMqm9XFoJy7MP77Kn6JL7m1U3peD8m4tOXk6YZGShW4GuX+BqJXucLOZmfgj93XtE=
X-Received: by 2002:a19:6d16:0:b0:500:b14a:cc63 with SMTP id
 i22-20020a196d16000000b00500b14acc63mr3011464lfc.12.1694865964636; Sat, 16
 Sep 2023 05:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
 <CAAhV-H6Q0sirFEDdc1v4BSfDY94eZvJazy0XLKM8V94GMJvQnQ@mail.gmail.com>
 <ZQNWh2DY319jGbfq@smile.fi.intel.com> <CAAhV-H66LUWHP-eGp6VGvs0F+QD=QJ69uR3_1A3SqH9cyPUPoQ@mail.gmail.com>
 <ZQWCeI6E7rm8Akbt@smile.fi.intel.com>
In-Reply-To: <ZQWCeI6E7rm8Akbt@smile.fi.intel.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 16 Sep 2023 20:05:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6dakVH0a4Mt9MdcY8OO3gdne6rW0Z1kK6YRq9hDLP05w@mail.gmail.com>
Message-ID: <CAAhV-H6dakVH0a4Mt9MdcY8OO3gdne6rW0Z1kK6YRq9hDLP05w@mail.gmail.com>
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

On Sat, Sep 16, 2023 at 6:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 15, 2023 at 08:36:24AM +0800, Huacai Chen wrote:
> > On Fri, Sep 15, 2023 at 2:53=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Sep 14, 2023 at 11:25:22PM +0800, Huacai Chen wrote:
>
> > > > Thank you for your patch, can this patch solve the problem below?
> > > > https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ-lkp@int=
el.com/T/#u
> > >
> > > Nope, this just adds missing includes.
> > > No functional change, so warnings will still be there.
> > But I think a patch should solve a problem.
>
> No, that problem is static analyser concern, not the compiler nor linker.
>
> > If we don't get a build
> > error or warning without this patch, does that mean the 'missing'
> > headers are actually included indirectly?
>
> I might be missing something, but I do not see any build error in the abo=
ve message.
Hmm, then I think I will take the second patch only.

Huacai
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>
