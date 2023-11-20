Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD57F1182
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjKTLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjKTLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:15:02 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C315D9C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:14:58 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so55508821fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700478897; x=1701083697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haXSxEr8SHL2k7h4L7GLg+3o357Ly/kj2SV4CyscdCo=;
        b=auWBk+GBAfdH3quxbpBbsH8Teg4BRzXQEySBn3NgcDSadra129VoH5yx26A7//bIV8
         uwJrO3pZjuJVQimtuAdhXpvy8Bcwc+bXKkuqO60GYuNwcJgVgXPiRPOxFKeHOLgTUvcf
         EGgFlStpeAbr1fFCUlrwaPTYmvpAYkC9WC8q4p/4hjEY1phoWKvJj/mKAJPmnNuHw8sS
         47Qdk7md6njIfPMFkXGwgnwKd8v4JuGwSl3T5m8IxOs5NP9dLkNHeSMWlrkMyH3uWRH3
         AbMgQ2gGqfkAxn8ySSRbrHC7reHg8gimKDi8mNHSI6pMd+syWx1JzLdp5a1ao+59tFBX
         yk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478897; x=1701083697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haXSxEr8SHL2k7h4L7GLg+3o357Ly/kj2SV4CyscdCo=;
        b=H3t7lgc9Kx117A1rLmW9EpS6jHt2kd7pmz0v7XluNCyvLf/Wm1C4novS8s2ZardDs0
         ovfOCUSoulcxNLY1+J05WolsgrkOWW1BtNBv6KgDyzmq7pFNFnArbpQF8si3VszsQawS
         PGYSrbMFNoKs4LTpqadhWrpQ3VXwqOzDEFr0dT9oe3vVv2/Qeso6LsMYGeXF1VJBoh58
         F4OB3X0AfmLg9dWZb1kp6bjXEaXCmnAYAANv2zyGapuoi6eRMg+s6Yxd82Xkzx1qJt2u
         OAXKm5+X7TJV78t9OB+AthQ20MTsRHRzZaaMqZYirkCv1MFkfzGpAuGA4WKUY3dNmYpB
         wJKA==
X-Gm-Message-State: AOJu0YwCfGuv/ia+UauHGb5zEDM1itmdMUsFh3SmtStYDon7+vA8OhEl
        jmsWdVw2clufxhz3g/+Tdb0K6xmV5HKz8VUCDTM=
X-Google-Smtp-Source: AGHT+IHda1+XicvS0ufYq5VLBr8oYzW6t2wOCQxIXHo6dpcVZVP27gJWMDfd2kc5E5X7Z/hjw0FCVrchMV8HjQgGjWM=
X-Received: by 2002:a2e:2a83:0:b0:2c8:2e3a:e974 with SMTP id
 q125-20020a2e2a83000000b002c82e3ae974mr4676611ljq.44.1700478896638; Mon, 20
 Nov 2023 03:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-4-ryncsn@gmail.com>
 <ZVp3WR+D4Z/UZEqO@casper.infradead.org>
In-Reply-To: <ZVp3WR+D4Z/UZEqO@casper.infradead.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 19:14:37 +0800
Message-ID: <CAMgjq7A-X2EVCFXdQsrPF0tyW_JArdrBb=rLnGNbX7cAtf0d9Q@mail.gmail.com>
Subject: Re: [PATCH 03/24] mm/swap: move no readahead swapin code to a stand
 alone helper
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 05:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 20, 2023 at 03:47:19AM +0800, Kairui Song wrote:
> > +                     /* skip swapcache and readahead */
> > +                     page =3D swapin_no_readahead(entry, GFP_HIGHUSER_=
MOVABLE,
> > +                                             vmf);
> > +                     if (page)
> > +                             folio =3D page_folio(page);
>
> I think this should rather be:
>
>                         folio =3D swapin_no_readahead(entry,
>                                         GFP_HIGHUSER_MOVABLE, vma);
>                         page =3D &folio->page;
>
> and have swapin_no_readahead() work entirely in terms of folios.
>

Thanks for the review!

Good suggestion, I was actually thinking about converting more swapin
function to use folio in later series, since that involved more
changes, and this series is getting a bit too long.
I'll try to see if I can reorganize the series to cover that too in a
sensible way.
