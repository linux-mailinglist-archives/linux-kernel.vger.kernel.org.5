Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12B80985A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572880AbjLHBDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHBDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:03:40 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEA61708;
        Thu,  7 Dec 2023 17:03:43 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b6f4330598so48710739f.1;
        Thu, 07 Dec 2023 17:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701997423; x=1702602223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFmGbo8fhXTr6Pczms9GfEwRxaNflz7F0LyZ8zkEvYE=;
        b=PCuScKAk1OX6xK7/E7A4aW5apNTR/EUyuM4ju2F0J3Xj+0Z5sXw6E5Y2qadyK0qLwe
         U5qrZYZErCyMLRzaHJyUuXvsxJV+5/nmE3eTUBrOmo4CGKc+kj3iO9Q07Jnm0P16HZb/
         iSYnXOyh1XdmKsIVtvnOaU9vJXITTOTt3lx9iiYVghiVSpsBNl1QXMsBKihHBHRyESER
         X8vHXQL4cQOZZ28yIGumF0484j1gfIJVzLBPb0z2xhFIkKcsaOmJGN++Jt2UvX1wzonw
         YVSusNajqhmRUXD15xzYkJCehD2QSxRUbxj6EkZdg/+t07v/sWC5zL06JMFi1avkGcd3
         8Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997423; x=1702602223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFmGbo8fhXTr6Pczms9GfEwRxaNflz7F0LyZ8zkEvYE=;
        b=gsLD6xoNyopNdpUQ6jRHVs9jzWXu8G62xgk7OLHijQI5kSkNeEjuXKUUeScYOSQ9Kf
         tS8IBIPq47Y3P47t6nlqTI2Mk6lTeTIAdiovVTB+r5J1PnJJcuCOq2daPVixIbNFHPWR
         nt8QZwzjgNZy9au9zXKaZzZbOW/1saT0ZNvDEKju92p5LoM9JvbVZs8X7+2ioGTeZI4x
         uQ5CLWBgnHN6XLKUXC1Embaj5sOrkQjSlDA/zuk6OVk4A3nSFLnT2BHJEzimPC7LZczJ
         FYFD9Y8cYcuavkyhc9KLw+ScDpBdBFX4/Gb8zLz4lROsJkvayHTZNrnIy6/EhT18npEo
         UJSA==
X-Gm-Message-State: AOJu0YxCNaVTFrV+6QrU4u5Tu1Lzn1FxIcqUF4S+Le4kZDybiEQKzMV4
        8/OdiIjuECtXLDKYtJlmaxway5YiZwflAzZt9UI=
X-Google-Smtp-Source: AGHT+IFwX1Howrjsss3Fc41+vp34/Dggj/8S1JvGY4jfBi0ZC9zOlRS/1JlBCsDJQwhae0D1y2gEjkvL2as9w954e24=
X-Received: by 2002:a6b:cf16:0:b0:7b4:28e4:8509 with SMTP id
 o22-20020a6bcf16000000b007b428e48509mr3612735ioa.11.1701997422578; Thu, 07
 Dec 2023 17:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
In-Reply-To: <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 7 Dec 2023 17:03:31 -0800
Message-ID: <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
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

On Thu, Dec 7, 2023 at 4:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhat,
>
>
> On Thu, Dec 7, 2023 at 11:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > During our experiment with zswap, we sometimes observe swap IOs due to
> > occasional zswap store failures and writebacks-to-swap. These swapping
> > IOs prevent many users who cannot tolerate swapping from adopting zswap
> > to save memory and improve performance where possible.
> >
> > This patch adds the option to disable this behavior entirely: do not
> > writeback to backing swapping device when a zswap store attempt fail,
> > and do not write pages in the zswap pool back to the backing swap
> > device (both when the pool is full, and when the new zswap shrinker is
> > called).
> >
> > This new behavior can be opted-in/out on a per-cgroup basis via a new
> > cgroup file. By default, writebacks to swap device is enabled, which is
> > the previous behavior. Initially, writeback is enabled for the root
> > cgroup, and a newly created cgroup will inherit the current setting of
> > its parent.
> >
> > Note that this is subtly different from setting memory.swap.max to 0, a=
s
> > it still allows for pages to be stored in the zswap pool (which itself
> > consumes swap space in its current form).
> >
> > This patch should be applied on top of the zswap shrinker series:
> >
> > https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@gmail=
.com/
> >
> > as it also disables the zswap shrinker, a major source of zswap
> > writebacks.
>
> I am wondering about the status of "memory.swap.tiers" proof of concept p=
atch?
> Are we still on board to have this two patch merge together somehow so
> we can have
> "memory.swap.tiers" =3D=3D "all" and "memory.swap.tiers" =3D=3D "zswap" c=
over the
> memory.zswap.writeback =3D=3D 1 and memory.zswap.writeback =3D=3D 0 case?
>
> Thanks
>
> Chris
>

Hi Chris,

I briefly summarized my recent discussion with Johannes here:

https://lore.kernel.org/all/CAKEwX=3DNwGGRAtXoNPfq63YnNLBCF0ZDOdLVRsvzUmYhK=
4jxzHA@mail.gmail.com/

TL;DR is we acknowledge the potential usefulness of swap.tiers
interface, but the use case is not quite there yet, so it does not
make too much sense to build up that heavy machinery now.
zswap.writeback is a more urgent need, and does not prevent swap.tiers
if we do decide to implement it.
