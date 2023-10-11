Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3D7C5D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjJKS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjJKS5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:57:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C853894
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:57:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso2412a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697050652; x=1697655452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxkPm2B1OBi9iYXN9MuYvqMChLrgNkYVTRTGG0T2fWU=;
        b=Znfct9J5uEgMZVS1t6P08/oENe6hb2X2cUn4rUHygOG4K4hSUJyA46KYMfvuMVvnNC
         YBOg90xjmdMPkrghJIlAI1sFi3qYnzIvOAFlLJlt0SkPZIgITJf0aEdqZlk33s27PL0/
         rTu+SQsfw9ESzD7QWQ2+5kvmW63c2uUtP0j3a7r2Ght46DlR0kUS+pLaOLfxxr1DgVT7
         wPYLtGItYZiDYhtRIvID7Wq9EACmVar0wTdyCmGKI5VNywMahzf6bOBVV6tqXtj5vc5Q
         S8qW30qGBXXJn2rRFxe4jS9ZhMVHRHKerR93I0WeFeJRYsMx9fSk/rVjmwO8q2Be+3RY
         Zjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050652; x=1697655452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxkPm2B1OBi9iYXN9MuYvqMChLrgNkYVTRTGG0T2fWU=;
        b=SPhpmhhCYWnUAKTLfIEq2C+BpFgYLzww1Q/dq0ILiy8ypFdftNhpD2x2bw7ITAeT9a
         qo6Vl5qEYwNJMm70N6PkT73KxizJ/qUJUs8kpYTyRkIRINp6993mQuD1/jQjsYMc/xmu
         AMohyfMhlQhMj5coRX8CnTTy0GJnwxbNXIt2lK7gDrUPysUXXFEq3IU67kWu5+rte8WX
         pvMODnv1BCjc35Mb/bIJ1Qitlq7DbEHS4BJnwlTM52KiBYJUzasDRr29lsuu9P3pXHA9
         e0XPRhY/MReiUvpryF2HZid4RcN5P1OB4DmG2NT47/ucEokGc1+jdxR7+Ml2j4TggoRZ
         ERBQ==
X-Gm-Message-State: AOJu0Yz7fM/Xo5ReHDUZbb8YOHZWZl8+mqFACPV3RZFgMOqxBj+I9fFI
        F4A12muLa/SAU0EgkVJre6E51exWqfO9jdI0TWj8kg==
X-Google-Smtp-Source: AGHT+IFc/89I7Y+6rUKwx8XNGrZ9m5vt94TlXkrFXEIM0Zdkve1IgyQhh4RAedFUg2xtXtVh8L8xDVXSIjlO7zGT0M0=
X-Received: by 2002:a50:c35c:0:b0:538:50e4:5446 with SMTP id
 q28-20020a50c35c000000b0053850e45446mr140284edb.5.1697050652003; Wed, 11 Oct
 2023 11:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <1696965810-8315-1-git-send-email-haiyangz@microsoft.com>
 <20231010151404.3f7faa87@hermes.local> <CAK6E8=c576Gt=G9Wdk0gQi=2EiL_=6g1SA=mJ3HhzPCsLRk9tw@mail.gmail.com>
 <PH7PR21MB3116FC142CAECCD5D981C530CACDA@PH7PR21MB3116.namprd21.prod.outlook.com>
 <20231010191542.3688fe24@hermes.local> <PH7PR21MB311616744CBE08375C52C2B8CACCA@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB311616744CBE08375C52C2B8CACCA@PH7PR21MB3116.namprd21.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 11 Oct 2023 20:57:18 +0200
Message-ID: <CANn89i+DWa-xbBToc2-Zr2YyZ_axbeo6poyLp9t-XqGr2EzOPA@mail.gmail.com>
Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Yuchung Cheng <ycheng@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "morleyd@google.com" <morleyd@google.com>,
        "mfreemon@cloudflare.com" <mfreemon@cloudflare.com>,
        "mubashirq@google.com" <mubashirq@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "weiwan@google.com" <weiwan@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 8:49=E2=80=AFPM Haiyang Zhang <haiyangz@microsoft.c=
om> wrote:
>
>
>
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Tuesday, October 10, 2023 10:16 PM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Yuchung Cheng <ycheng@google.com>; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; corbet@lwn.net; dsahern@kernel.org;
> > ncardwell@google.com; kuniyu@amazon.com; morleyd@google.com;
> > mfreemon@cloudflare.com; mubashirq@google.com; linux-
> > doc@vger.kernel.org; weiwan@google.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next,v2] tcp: Set pingpong threshold via sysctl
> >
> > On Tue, 10 Oct 2023 22:59:49 +0000
> > Haiyang Zhang <haiyangz@microsoft.com> wrote:
> >
> > > > > If this an application specific optimization, it should be in a s=
ocket option
> > > > > rather than system wide via sysctl.
> > > > Initially I had a similar comment but later decided a sysctl could
> > > > still be useful if
> > > > 1) the entire host (e.g. virtual machine) is dedicated to that appl=
ication
> > > > 2) that application is difficult to change
> > >
> > > Yes, the customer actually wants a global setting. But as suggested b=
y Neal,
> > > I changed it to be per-namespace to match other TCP tunables.
> >
> > Like congestion control choice, it could be both a sysctl and a socket =
option.
> > The reason is that delayed ack is already controlled by socket options.
>
> I see. I am updating the doc and variable location for this sysctl tunabl=
e patch
> as suggested by the reviewers, and will resubmit it.
>
> I will also work on a separate patch for the setsockopt option.
>
>

I am not sure about adding a socket option, and finding room in the
socket structure.

See our recent effort reshuffling fields in tcp socket for better
performance (stalled at this time).

I would rather experiment first with a sysctl.
