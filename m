Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE47F118D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjKTLPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjKTLPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:15:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86BD69
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:15:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so51573041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700478921; x=1701083721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGvdee3TQIpF1SI724cXO2Msx6guU5EDf9Sws5t+jG4=;
        b=YbmJ7QrQrfj/G1mNLxxa/icKwO9bmyfbl2z7ikDSTQ8ib6FOXwTN5/YG4QqlWGazJp
         LMS4xh0L34z02iBlPloGfFX8yidBYxRxAE/bI9C5dLaa8YuOOHS2nLraYjWpOdJKvEQd
         0yOSpfQ2q+NE8uIEqYemxXuPYdgb9SQcF11wGib5ThrMT2h/kYt5MyASLOzpRaCpI+Dp
         v+ScGKd3o9IHVsR9xWCgm4OB+o4236i3SpS2deb806GWvS3kp8acZ3J0ejGBjc+AAIgG
         e5Rg7NvYE8QTKU+9x9J7CLXEveCycGFL5Az4twBf/LDIZujrm/rF4g0uX9j4q5oKj4TZ
         WFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478921; x=1701083721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGvdee3TQIpF1SI724cXO2Msx6guU5EDf9Sws5t+jG4=;
        b=Q17a0dLQYK4Mnqfeav3TdWQW8/zmlEEbT9QCImdNmWVws7dMikZ2AXzevPDjzoCuGQ
         TZdcJzZgH9a3HJZHaVgcNDZJIxjrj4WUFinRpEb5azxu0f65RH/rGjkiN/xUBw5CluNK
         n887cA4Jw73QvBERuxC9P0zNwjMb1bdrdUTCSA4+NQIXuwnnn4bbzoVMW9UMesscoSjR
         OiZlV3netyX6L//AgG/BdWPJBFWmqtY1tF+AnGeIko4W7Wn4aP48ykQdUnZMnjKjDMVg
         zzG6jbUa5iSo4IvWvTRv98dnklRsJ+ROnkwwknrUojDfZ0DRtkeRGl4s1SsmD53xouOv
         V96A==
X-Gm-Message-State: AOJu0YxLRDxc9SakyzjjK1qez1ennS1KTGahdnBX0sOTrSaXxUnSZc2u
        rueVvzvarwhn1yTAD5hlZJWFlUgf21uZS5XmGVg=
X-Google-Smtp-Source: AGHT+IEkwW8gqxESIIlgmnHShYOfxdcUpZ6R5NoJDIQXIwyCfF3drMe5rnNL4qDW6gsr7j4ZaZEVaM8BwvHfRAKqUUs=
X-Received: by 2002:a2e:bea0:0:b0:2c5:56b:cbcb with SMTP id
 a32-20020a2ebea0000000b002c5056bcbcbmr5989090ljr.9.1700478921255; Mon, 20 Nov
 2023 03:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-2-ryncsn@gmail.com>
 <ZVp2UE+MqkifJG4B@casper.infradead.org> <CAF8kJuOGUQNyZesw5BY3dfwBNhL6_RG_=tXc1ZQ4VRGRtGPuMw@mail.gmail.com>
In-Reply-To: <CAF8kJuOGUQNyZesw5BY3dfwBNhL6_RG_=tXc1ZQ4VRGRtGPuMw@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 19:14:59 +0800
Message-ID: <CAMgjq7CO_9tXfwd2at-tT+O_JU-NGoG=9OWcqwkc9M3iL1Ga1A@mail.gmail.com>
Subject: Re: [PATCH 01/24] mm/swap: fix a potential undefined behavior issue
To:     Chris Li <chrisl@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
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

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=80 11:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Kairui,
>
> On Sun, Nov 19, 2023 at 12:55=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Mon, Nov 20, 2023 at 03:47:17AM +0800, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > When folio is NULL, taking the address of its struct member is an
> > > undefined behavior, the UB is caused by applying -> operator
>
> I think dereferencing the NULL pointer is undefined behavior. There is
> no dereferencing here. It is just pointer arithmetic of NULL pointers,
> which is adding offset of page to the NULL pointer, you got NULL.
>
> > > won't lead to a real issue, still better to fix it, also makes the
> > > code less error-prone, when folio is NULL, page is also NULL,
> > > instead of a meanless offset value.
>
> I consider your reasoning is invalid. NULL pointer arithmetic should
> be legal. This patch is not needed.
>
> Chris

Hi, Chris and Matthew.

Thanks for the comments.

Right, it's just a language syntax level thing, since "->" have a
higher priority, so in the syntax level it is doing a member access
first, then take the address. By C definition  member access should
not happen if the object is invalid (NULL). Only a hypothesis problem
on paper...

This is indeed not needed since in reality it's just pointer
arithmetic. I'm OK dropping this.
