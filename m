Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EDB80DDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbjLKWCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345618AbjLKWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:02:00 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2AD65
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:01:49 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-42598c2b0b7so32941cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702332109; x=1702936909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYuCFWZ1VmS4Lp7mhYmBi3WLT2kfEMP1dhisfQvZFgw=;
        b=jbQc/FzoQskB9snNjp2zLzlHoN5UMppr5uib4DOWTPTVjxAWvzM4pPsMkAELFUn4KW
         ihg04OskZ9vwxupwWsWXj2cFkGjHuT+4CpqpktX/SopU3iTJ334rhhoP13bD2AyKPRbn
         mUUBMjRPg9r9i8xCSRbPvpMsY/KID4/L+HSwu/C5aJX016g+dEdQW7+banoOwyu8gzpL
         IPA0bNb0EfBHVMLo4PXMCz+vkxM+uj8kLk2x0bEjibTC2ut/W40yUCs6JCnwpkZ3lxij
         OENM6rxnCRFHfDJCAQ+BdOHL3vcz5wZAnYgTdyFy2jIZQDLIygi0i90nUcnr3z68/kxn
         /E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332109; x=1702936909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYuCFWZ1VmS4Lp7mhYmBi3WLT2kfEMP1dhisfQvZFgw=;
        b=l8XEn61wdytRjJG6Aw4MuvA02W1aUmsxnslnN2AS87omHfz2m8vAkJvLclJdsXtMeO
         O+GderxWAuod4C4ardEAjbPk8fLoQHl+scXcoTvCwuYUN3wS0dcuhlZ9cHnNEao2K+QR
         xnBctpbZz965ZObclPPx92eP5R4XFaxPi9pMJtAafroeaT/iNzfGBS4WrnRp1hsmRx9P
         gNMMXl6aMiGBgC0OvVdeKKWoitBUT08MtUPdMvzWEdJOk+3dKUFyo2ii5siz1kwKTLea
         iVmzcE+bd3zKZXBsgQJ4HP6v4Rux3KqQarJumcz3BWDTc7IvIMNs3Uix7FxjbSgmh9Tf
         hfBg==
X-Gm-Message-State: AOJu0YzScnD3whCj89CfJzLAnUFSAuyfL4dLZ6HPkf5WbgqduWsEVaAl
        /Iu6I6W6z+ceC9KCRZeUumv63R8BE9tTW69xI+jL8A==
X-Google-Smtp-Source: AGHT+IH2IiHUqiS+hDMAihXMhQybFlm8Q+pUYtSDNA+K//Qg9HawPEM7ueM0PxZfERfjiArm+ASOh3BFax4JtNQiks4=
X-Received: by 2002:a05:622a:1b91:b0:41e:2bad:f3c5 with SMTP id
 bp17-20020a05622a1b9100b0041e2badf3c5mr823643qtb.9.1702332108841; Mon, 11 Dec
 2023 14:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <20231208061407.2125867-2-yuzhao@google.com>
 <20231208110011.102-1-hdanton@sina.com>
In-Reply-To: <20231208110011.102-1-hdanton@sina.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 11 Dec 2023 15:01:11 -0700
Message-ID: <CAOUHufacCTtUE6y1x5j+6Hp3SGtWu1-u38JHTR1z6JqU4cU8_Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 2/4] mm/mglru: try to stop at high watermarks
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 4:00=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Thu,  7 Dec 2023 23:14:05 -0700 Yu Zhao <yuzhao@google.com>
> > -static unsigned long get_nr_to_reclaim(struct scan_control *sc)
> > +static bool should_abort_scan(struct lruvec *lruvec, struct scan_contr=
ol *sc)
> >  {
> > +     int i;
> > +     enum zone_watermarks mark;
> > +
> >       /* don't abort memcg reclaim to ensure fairness */
> >       if (!root_reclaim(sc))
> > -             return -1;
> > +             return false;
> >
> > -     return max(sc->nr_to_reclaim, compact_gap(sc->order));
> > +     if (sc->nr_reclaimed >=3D max(sc->nr_to_reclaim, compact_gap(sc->=
order)))
> > +             return true;
> > +
> > +     /* check the order to exclude compaction-induced reclaim */
> > +     if (!current_is_kswapd() || sc->order)
> > +             return false;
> > +
> > +     mark =3D sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERI=
NG ?
> > +            WMARK_PROMO : WMARK_HIGH;
> > +
> > +     for (i =3D 0; i <=3D sc->reclaim_idx; i++) {
> > +             struct zone *zone =3D lruvec_pgdat(lruvec)->node_zones + =
i;
> > +             unsigned long size =3D wmark_pages(zone, mark) + MIN_LRU_=
BATCH;
> > +
> > +             if (managed_zone(zone) && !zone_watermark_ok(zone, 0, siz=
e, sc->reclaim_idx, 0))
> > +                     return false;
> > +     }
> > +
> > +     /* kswapd should abort if all eligible zones are safe */
>
> This comment does not align with 86c79f6b5426
> ("mm: vmscan: do not reclaim from kswapd if there is any eligible zone").
> Any thing special here?

I don't see how they are not: they essentially say the same thing ("no
more than needed") but with different units: zones or pages. IOW,
don't reclaim from more zones or pages than needed.
