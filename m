Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC17D382E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjJWNel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjJWNej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:34:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1559B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:34:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c2a0725825so488700466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698068075; x=1698672875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSMtukRJLaelWKQ1/VahTETmU3icr64cjwsvIMkAsxk=;
        b=fA6jEnpPa33BGCR4iIvYLMA8tQCwgc/DLTNR/GXzy6C5XowVbmYqZFeH/V9+Wj2eNw
         8GnW4Akpez04V0Sm83xdQbw9PepIDppmiIQuFot6xZMIxH9upXMmG9uqYR3hfWjBH4Qw
         v/Y9ISIk9WrkWd1My9wKLaI8FycoV3pkLrpLG86JsKFObv6F/n5puTyiX1gnwOMkKoy7
         EuVxKdfrRyApqE+btNTdiYWr8RRFILyb6+rTQUP3EfVe44A0ww0CMYpVeTgr7uG+NeTp
         hbQJmDvs14GqgXm1okM9Sy3fd9zTFIRhom3dGl0PayTCJSUXAOrGNJuqwkXkWu+QbQHu
         54Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068075; x=1698672875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSMtukRJLaelWKQ1/VahTETmU3icr64cjwsvIMkAsxk=;
        b=tyOADgNhjOcZVNxV1VHkEs3q+ktOABgnFAAwzLjrHv029zO14eqXJiEb2zjz4E70zO
         I69oOFtEw6oq7EWKmhxsYHnh2IChG3JjFTPNiK3D2g7aztx4Ioi/KdRZwFx/BWANlLsH
         S5yYZzlzjSQ7e7zq9njiawV67p/bHDivP+YwhLJK8u5kBdbboI+pMjCmAk0uw7b/21O9
         Ybxa2wIwoSeJma56S3XI+pf09J2UaINCMWD6GKccp4HoH2rfRBfkD+IjAb2ZqcDQxvcn
         ybeLu3b7n23cS+pjmFAbzVsYOOiKjFS6oFaKkF+KTBdOge6KjL2Wc4CM2vRxP5y/Bjhr
         0YSQ==
X-Gm-Message-State: AOJu0Yzp935YDph1OGhxo5c9Dfr/3Qy6N0XwxeOmLufli8DcBWbbiTKW
        rc1MfLIF1m7gPPmPUGGmu3Yf3ZqCKw9eZmoxlnQ=
X-Google-Smtp-Source: AGHT+IG7IkAy7oKNze4eMx8+psqO05yDnWfqRaPedXZYF3Zsz9w+MHB1DhPydniZw3wAzBA75uJhKstaSBipUg7JGtM=
X-Received: by 2002:a17:907:3e9f:b0:9be:e79e:c75f with SMTP id
 hs31-20020a1709073e9f00b009bee79ec75fmr6808331ejc.18.1698068075321; Mon, 23
 Oct 2023 06:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
 <6675c47a-d258-41ae-b506-88d7ae74b551@infradead.org> <CAOx-CDVn7Ub31yiRpoZh4RhJBCvgZhb8Ca=cH9b0xWPjk5FNQA@mail.gmail.com>
 <89f666dc-e7b3-44ad-846c-b1f1ee278940@infradead.org> <CAOx-CDWzJWqYGhoJ4HPhio5-5zE025jYrmVpocryyxMfwfwsxw@mail.gmail.com>
 <ZTZb0AndJBwnAOYT@debian.me>
In-Reply-To: <ZTZb0AndJBwnAOYT@debian.me>
From:   gmssixty gmssixty <gmssixty@gmail.com>
Date:   Mon, 23 Oct 2023 19:34:23 +0600
Message-ID: <CAOx-CDU6N5oEys8Qgoy3A1jHHDi-KHjS3XBk1f9jYU_5j=qtuQ@mail.gmail.com>
Subject: Re: How can I add "busybox sh" as init during boot of the custom kernel?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 5:41=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Mon, Oct 23, 2023 at 05:06:38PM +0600, gmssixty gmssixty wrote:
> >
> > What would I write in /sbin/init? I mean, what will be the content of
> > /sbin/init? Should I write: "exec /bin/busybox sh" in /sbin/init? Or
> > should I write "/bin/busybox sh" in /sbin/init?
>
> Since you have Busybox system, /sbin/init should be a symlink to
> /bin/busybox.
>
> >
> > BTW, what is top-post?
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

I have not installed bash. In that case, how can I run "busybox sh"? I
have tried linking /bin/busybox to /sbin/init. After boot, it prompts
to press Enter to activate console. But after pressing Enter, it
prompts the same message again.
