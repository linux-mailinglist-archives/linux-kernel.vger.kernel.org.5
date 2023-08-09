Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B05776471
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjHIPyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHIPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:54:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15341BD9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:54:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so13023a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691596475; x=1692201275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdmr0eHwzB3gy4lSLkjDEf6JX0g8QfGgY6ypL8PteMk=;
        b=5sCJRA0xk2bFTWzmVh9KanEzPTQGLI7BhMV5unfFun8KBoGmOGWZOT1RteY/6cqQcv
         xCNRRiSBeHuWgQnzZNjBb5W4u3d2M0AfO5rEueLDUCbfyQ1ta/dd2T0uBgTWQw7/aF1D
         uz2vJ/1N1bAsiG/PWCVPspArYVRAfjeotfMmC6zEODCb/7VssMb/x3MND7nS36J2szUL
         /E4X+Twg44bE3O90GTcxJu/tRFj7sfLgosABiFtiRLjRVYQ3fHKhJwUGowg1lQzTNgpt
         djXEO7aciJ2w5PCVk0J37eFnoxSUn0RGJi0MFotLnZQ3iZCJ7iYgD0IltBCojV/0icLS
         W2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596475; x=1692201275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdmr0eHwzB3gy4lSLkjDEf6JX0g8QfGgY6ypL8PteMk=;
        b=k8RdvWnrj2YPRk6E9+7bhoQ2ef2y4exEXzkKjBuDWLivUUDNRK7rvzkfP/HdMHM89L
         q8JSnJ0N9xxQY6nyZTknVyeQEoxfwFPs/QCTCrVQ9G3IkHYFnGQ0xzvku5JZPI9EGbU3
         xzam+EWYJkX1grCe7MMfVZE1LtE6TFyipmeDa1DB/GnKmdg3Rk4cjT+Z0rhIow01KTLk
         prE15o8/B4BBv+vaO+DzkrdbmA2m/8J161YPeWf/pSkMw96UZlBS5xUiv+yoCNKwGye5
         n3Xxw9TTLpaAJDEj+8VghPx2fMgLJXrZteiAOGe8CIGbhBT2kCer9CGSIic5n1dEy+nu
         YUDw==
X-Gm-Message-State: AOJu0Yx8lkwihloLw24QcZFD1Kn916ISSvG56qJ7AaR/Egq/Brsa3dQ+
        9+bCTYCU5vMoBQ/Fb+azk2BfMVPBkX0Ix2/KveugtQ==
X-Google-Smtp-Source: AGHT+IG24u9n4GEFcr1pL3uOsvjjN7DlSKmSu6n2isxk0z3q/ypHFWVcnYyMQB6rFBS1AmV3jvDTR/T11GCrS8SWh1Y=
X-Received: by 2002:a50:9f4f:0:b0:523:ee1:8d27 with SMTP id
 b73-20020a509f4f000000b005230ee18d27mr101997edf.1.1691596475039; Wed, 09 Aug
 2023 08:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <1691568344-13475-1-git-send-email-quic_charante@quicinc.com> <9d109a43-78a3-dee4-5aaa-385bdfe4bcb3@redhat.com>
In-Reply-To: <9d109a43-78a3-dee4-5aaa-385bdfe4bcb3@redhat.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 9 Aug 2023 08:54:23 -0700
Message-ID: <CAC_TJvckhxwz9TxXgMSaiihHddY+AnEGqjLxvO6qF0eqTb5U8Q@mail.gmail.com>
Subject: Re: [PATCH] Multi-gen LRU: skip CMA pages when they are not eligible
To:     David Hildenbrand <david@redhat.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, zhaoyang.huang@unisoc.com,
        yuzhao@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 7:00=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 09.08.23 10:05, Charan Teja Kalla wrote:
> > This patch is based on the commit 5da226dbfce3("mm: skip CMA pages when
> > they are not available") which skips cma pages reclaim when they are no=
t
> > eligible for the current allocation context. In mglru, such pages are
> > added to the tail of the immediate generation to maintain better LRU
> > order, which is unlike the case of conventional LRU where such pages ar=
e
> > directly added to the head of the LRU list(akin to adding to head of th=
e
> > youngest generation in mglru).
> >
> > No observable issue without this patch on MGLRU, but logically it make
> > sense to skip the CMA page reclaim when those pages can't be satisfied
> > for the current allocation context.
> >
> > Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks,
Kalesh

> > ---
> >   mm/vmscan.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b4329f9..6cbe921 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4943,7 +4943,7 @@ static bool sort_folio(struct lruvec *lruvec, str=
uct folio *folio, struct scan_c
> >       }
> >
> >       /* ineligible */
> > -     if (zone > sc->reclaim_idx) {
> > +     if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> >               gen =3D folio_inc_gen(lruvec, folio, false);
> >               list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
> >               return true;
>
> Makes sense to me.
>
> --
> Cheers,
>
> David / dhildenb
>
