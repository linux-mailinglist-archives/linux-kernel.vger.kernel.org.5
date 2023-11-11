Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6457E86F4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbjKKAep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjKKAen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:34:43 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACE74212
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:34:35 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d2f3bb312so16213596d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699662874; x=1700267674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C7o/f+L7uo4NWltZBaeo9zpZA8oTQ6ntV0FIDWJnuE=;
        b=Ho54tjUpUKbdxBbCVVqR/aaQUnf9PTE7mnNH2tpNC4jgX6O+B0Yky3VdkaRsh1ZPdH
         Bbn4g0ksGLabaagIPOgIj/Bkd2a9IwCZxF24Is7YqdMGG3jKxY1tybXXvvHZIwmy3/tH
         4qHEcxOzBOuwLqO1y1aabB3giXkZcZyWZjcnXMy+NXqFftorh18cHUoNJcfeC695md8K
         hw0nUboKqGQoRiYHVB6B+FxEZ3ABjBrEgLSUa0bX25rpCPV+tHhdm2fW57f3M70YLkas
         1NyR967nxf9mcN8RiRY7ptrFFeXqOBWqbM/4KPcixDzLkpcRxBIBSkhinAx1x7tg7VXM
         pqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662874; x=1700267674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C7o/f+L7uo4NWltZBaeo9zpZA8oTQ6ntV0FIDWJnuE=;
        b=dX6Oan8cPe/IgPT1Z2Y0ChF55fk1wAH9IJh0yIdiWKWKlmIlC4KZTKl40ZfY/zQmcr
         ixAWblcPKugwC5cjDypeMGI04x3JXOIIt17htGz6eQNjJadE3LBSTGj9FvYgjok20Tfu
         Yq/HyVBBTiSn2JIomHv4OFv8VIDGw0hLOhwEfq1mZrX2jY3Rh1uJosVphQBwWipiTD+b
         GrTLb4AxFY8GVWDe44VgCYivWsfB3a+nnQmVnV/ci5i7wZ+G4krIR8zkFEAQePGZMknY
         fVOb/pkgQjEKwbajAyw64VtrVm5NFOm9lUDYg19p4tPnq35rRW2LBzCvyWJ02LaUwvO8
         XF7Q==
X-Gm-Message-State: AOJu0Yx38YlEe5JO1SPorMraTVb1ipZk794eFLaLoD9GvZv5KN46Xs00
        +HWPgfwy+/Rye9B25A5xZU6pY8Ep0ldE7Rkxbt2j/z8VEWPHyg==
X-Google-Smtp-Source: AGHT+IHIh4UqMHAwsou0uBfJPV39V5EK2cOgk5wYssTsPnP1IxmFVRcptuEsKm9ZjEGxa7vIVMqs4/KdSxwhmNe4HUI=
X-Received: by 2002:a0c:e805:0:b0:670:710f:2042 with SMTP id
 y5-20020a0ce805000000b00670710f2042mr939501qvn.15.1699662874672; Fri, 10 Nov
 2023 16:34:34 -0800 (PST)
MIME-Version: 1.0
References: <1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com>
 <20231110182240.65426-1-sj@kernel.org> <20231110103122.21d5fb5f3d60f1f4f5bd143f@linux-foundation.org>
In-Reply-To: <20231110103122.21d5fb5f3d60f1f4f5bd143f@linux-foundation.org>
From:   Hyeongtak Ji <hyeongtak.ji@gmail.com>
Date:   Sat, 11 Nov 2023 09:34:24 +0900
Message-ID: <CAFY0u4RTPbx1qYgESignpnLb71oVqLg8xZoqfO8genoOnSJf5A@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of schemes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 3:31=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 10 Nov 2023 18:22:40 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> > Hello Hyueongtak,
> >
> > On Fri, 10 Nov 2023 14:37:09 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com=
> wrote:
> >
> > > The function '__damos_filter_out()' causes DAMON to always filter out
> > > schemes whose filter type is anon or memcg if its matching value is s=
et
> > > to false.
> > >
> > > This commit addresses the issue by ensuring that '__damos_filter_out(=
)'
> > > no longer applies to filters whose type is 'anon' or 'memcg'.
> >
> > Nice catch, thank you!
> >
> > checkpatch.pl shows one warning, though:
> >
> >     WARNING: From:/Signed-off-by: email address mismatch: 'From: Hyeong=
tak Ji <hyeongtak.ji@gmail.com>' !=3D 'Signed-off-by: Hyeongtak Ji <hyeongt=
ak.ji@sk.com>'
>
> This can be addressed by including an explicit From: line at start of
> changelog.  Which should we use?

Please use <hyeongtak.ji@sk.com> if it's possible.

>
> > >
> > > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> >
> > Reviewed-by: SeongJae Park <sj@kernel.org>
>
> I'll add
>
> Fixes: ab9bda001b681 ("mm/damon/core: introduce address range type damos =
filter")
> Cc: <stable@vger.kernel.org>
>
