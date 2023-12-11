Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF680D34F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjLKRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKRKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:10:30 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E5C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:10:35 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4258b8632f4so37249261cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1702314635; x=1702919435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVwpXrg5GrAiosSC6uTLQ5GLZb1kq4d2s7vH0wRu8vc=;
        b=cGwKieTBVsUK/jzxGSaslGatL6BGqmABUjh0qM7SwVk42ENuBemOa9Yjxv9hLegkzH
         7ZXalBPdQZ/9bPPa+ucVmWrAmkW1muk1ZDVNq1cQOLSQFQCCPNSI2042G03BhvHNp65S
         Xw66AudqaJDr0JWHahLgp4iffoFmolXM9vOYjRCpyu8wXOjjyJfaRNjQZh5B3wsG8cWy
         oCRnENPoAT1OuW8Ag7TAlwfpBRIIaycMXtX+IEu19JyMl9RV/NZuwgUUQexBjEsCrDBb
         8vAUKQOxZTYrjItv5UQfA9/OwxBzgJQCOlEeT395gMfZ1CdbqlnRKAQpCg/dLVJRCuJ5
         Aypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702314635; x=1702919435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVwpXrg5GrAiosSC6uTLQ5GLZb1kq4d2s7vH0wRu8vc=;
        b=E6nsaegJAJPt28dx0A7DCYBnGhsK3QuQx7uePZhuYVlvZS8zq2g6LxZrM0SJHxJU4V
         VrbDKTLkQqXKMGyu7/nl/Os7OQJeexj6kC/UYzvnMQ3qrpOyJgY2f7sl2R4hwM2Fqe7F
         wF4+LdSkA2OVU+Uci+pJzWpmKK13+mDcTAAfglPLdRe1sL7d2dvcstNsrJmj8XgEq+1a
         SepIqIBIYC4pv9EiClUE6YFAC1IkPpODoNp1/SohGTsqxU35vPPcnqY4b3b0dWkN0jAn
         HBLHNb0lEyfhRzrbYgHJeONQVlZsAD7ng7GOgPqdb1t5oNGFVEuz5LIHu2S+1XxBqXAd
         KHjw==
X-Gm-Message-State: AOJu0Yz5j7ixUQjekH07MLJKeelK+aixl5oJGP0oabnGPwW/Ldik/kNw
        UVY8RHTc3cnURL0XCrcyQfeUKIXLKDl+I3mPx9YdW/ws0sgjWm2HDCA=
X-Google-Smtp-Source: AGHT+IEWA5j2rxU2s7GXnHN22sWHK1yBm26s38obXicdqOGWHUUAbuOhImNg2g09egt6OVEVMwL5e799O3ygWCXSyMg=
X-Received: by 2002:ac8:4e92:0:b0:425:4043:5f2e with SMTP id
 18-20020ac84e92000000b0042540435f2emr7945001qtp.108.1702314634830; Mon, 11
 Dec 2023 09:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com> <ZXdAOroKNce1r+TZ@casper.infradead.org>
In-Reply-To: <ZXdAOroKNce1r+TZ@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 11 Dec 2023 12:09:57 -0500
Message-ID: <CA+CK2bBnPc=Z4SOPbnMqnDA1X9oLsq_rzsEnAcxNsA5ZWCUWwQ@mail.gmail.com>
Subject: Re: [PATCH] vmstat: don't auto expand the sysfs files
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 12:00=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Dec 11, 2023 at 03:46:44PM +0000, Pasha Tatashin wrote:
> > +++ b/drivers/base/node.c
> > @@ -520,26 +520,34 @@ static ssize_t node_read_vmstat(struct device *de=
v,
> >       int i;
> >       int len =3D 0;
> >
> > -     for (i =3D 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
> > -             len +=3D sysfs_emit_at(buf, len, "%s %lu\n",
> > -                                  zone_stat_name(i),
> > -                                  sum_zone_node_page_state(nid, i));
> > +     for (i =3D 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> > +             if (vmstat_text[ZONE_STAT_NAME_IDX(i)].flags & VMSTAT_SHO=
W_SYSFS) {
> > +                     len +=3D sysfs_emit_at(buf, len, "%s %lu\n",
> > +                                          zone_stat_name(i),
> > +                                          sum_zone_node_page_state(nid=
, i));
> > +             }
> > +     }
>
> This seems overly complicated.  Why not do:
>
>         for (i =3D 0; i < NR_VM_ZONE_STAT_SYSFS_ITEMS; i++)
>
> and have assertions that this number doesn't change (and require people
> to add to the list after that point)?

This is what I wanted to do at the beginning. But, the problem is that
vmstat_text[] contains names from a number of different structs of
stats:  zone_stat, numa_stat, node_stat, lru_list, writeback_stat,
vm_even. Therefore, we can't simply count the number of
NR_VM_ZONE_STAT_SYSFS_ITEMS, as the new items can be added in the
middle of vmstat_text[]  when for example numa_stat is expanded.

Pasha
