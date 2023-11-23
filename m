Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0D7F5CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjKWKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjKWKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:51:26 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B51BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:51:32 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c87903d314so9296761fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700736691; x=1701341491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwmrQxHTU1CAY1ik/8lG526otmBtdlTxUGsXkGRD6CI=;
        b=k0dIWGdyCNSRc9jCtYdKWRp7xFeEkqVxOsptra5DyH9AIu0NxKT0Os8NctAOrJZU/B
         5RuSWBWaaaGUvYYuf+6jbzF8SuYBVuFoOTUctkeVkL73Tx7aBIVcB6s+bkr8jC3PNsnd
         OBdRB8vItg1MwQMlOaldLOjX5+6rNN73wjStaT3nj3C+SJCOrgq6JhGiucaPKPcNRwqs
         Fq2gB4wDT9MnXk4qnPlulqvG1D6OCezhy/RPzXGbu+uQpPw/Bs5G4WcvJCFpXtSBV9Dc
         o3djXpX6lrLj7T3KmzoHq9h6QAnrSj4kingaOr/fnlfXg8pl7bV503PrXKNyd55sUVT9
         +Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736691; x=1701341491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwmrQxHTU1CAY1ik/8lG526otmBtdlTxUGsXkGRD6CI=;
        b=ATWM3Z+oFlId+j4wumXyxjOXxc4S2eRZoPWpSq9ktZcxSSXrh92h6Ay6s3j7sYm545
         HpxCeElWDXERzxBB9iq38Je+KsZDdIbyHCWkn6pC0wP/Ht4MzcoW91IcRSTdVDaGsu1c
         oG28UoHcigQ59751X6aW/RnQ4pcL7014Mk2KZsgwQIZ3x4nAurelAsiGdBHU21xtzaHx
         ok0dJ2fJbLKPZJpA8D5PloBY4XS0r+Z/wHmK4G0oRi3CuBIMQY3u5PUHtew6ewrjSGlh
         fFntuzQi6BFeKWleXcx3JY0MRXF8ky/M+VH6bfKHZuioHytP8sw58to+5psG9juPa3KR
         20jQ==
X-Gm-Message-State: AOJu0YzZHMOfoPxmos9rDi1GCXC/IiTH0C24ArXkVlpry64O9riwYvsV
        DzorR4tCyknglcPHCdl0WwIjco2njm0U/u/OLe8=
X-Google-Smtp-Source: AGHT+IG/bNRUZnDOK8JBHt6VPrcbVxdIHI6XPaKwYdXRcBEqiwDsjykl6EI0sBO9H1n+8AIlxzyLn24s3GHw/rvOVBg=
X-Received: by 2002:a2e:a988:0:b0:2c6:c3ea:af7b with SMTP id
 x8-20020a2ea988000000b002c6c3eaaf7bmr3896551ljq.5.1700736690883; Thu, 23 Nov
 2023 02:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-7-ryncsn@gmail.com>
 <CAF8kJuO_ztE=M3EF-7pSkUL73tL8kfi2KqQPsYVC2VE-J_nu6Q@mail.gmail.com>
In-Reply-To: <CAF8kJuO_ztE=M3EF-7pSkUL73tL8kfi2KqQPsYVC2VE-J_nu6Q@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 23 Nov 2023 18:51:13 +0800
Message-ID: <CAMgjq7A2uMyYAkpp_ZYYhVw9wZenv-2t7xOO-MJc613o-o27iA@mail.gmail.com>
Subject: Re: [PATCH 06/24] swap: rework swapin_no_readahead arguments
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Make it use alloc_pages_mpol instead of vma_alloc_folio, and accept
> > mm_struct directly as an argument instead of taking a vmf as argument.
> > Make its arguments similar to swap_{cluster,vma}_readahead, to
> > make the code more aligned.
>
> It is unclear to me what is the value of making the
> swap_{cluster,vma}_readahead more aligned here.
>
> > Also prepare for following commits which will skip vmf for certain
> > swapin paths.
>
> The following patch 07/24 does not seem to use this patch.
> Can it merge with the other patch that uses it?
>
> As it is, this patch does not serve a stand alone value to justify it.

Yes, I'll rearrange this.
