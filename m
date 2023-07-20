Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541775B9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGTVwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGTVwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:52:19 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5CA2711
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:52:17 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-799761430c2so475148241.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689889937; x=1690494737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f35tkTBQLyNly1foiMY+2ToQ19rqtqe3836KlosE5Q=;
        b=QeNV46QIMAh0R8pWQJFfod5SDhn4OB8HERngnDTX22TMIpInMfsFnVhktP14bDKXsm
         BsPPc4wfR5BfLbYXH0hpNmSVqcwdp6zIZgBerpw95bkYi0pp3LBYfQ/Jen1mJzW86MJg
         mDpppryBh/cxpWU0AvJJaF+5+2qLDMt1WvPJf7IwN42yimgdLfKXeMDZOaYU+I+hXHK0
         t75WWeyYBoPv10a0MFYlyUqWPUzID1ZDMy1QZBcn0yJllufKeu9FnskSlE9jDe9LHI55
         Wl+HIX+zsFGDQZlbVAliptkvrzjhvF9dqZYk1h2rWrSQAnxO5clSEor+pfdHjhxKDefS
         vPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889937; x=1690494737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f35tkTBQLyNly1foiMY+2ToQ19rqtqe3836KlosE5Q=;
        b=k4vaJZvv0q+5gd+bk4/34aPG8k7DxQGarNT3yBp8UYVV8qR9UxOdhF99lO7+DY/Sh5
         naKEsi3c8gHQGIzv95Z3FDLrUxmec8NEK4YmNA53gfwEpIv6VcjNbp2m6Et27n80S6oG
         KHZ9nLIfTyJ2SOSw2p/Vafbj3XOtZVkzRKZz6xXLgPrVE+z7qtCA03lKEWt7QHb1tm82
         s5Y0yOPXRYU5IY7PCYRXRGanYwEkKyuhqKbx5728HbclRfF3mu3iXUP2wYNIyrJ13wPJ
         INs8fn+ZWK14Za1iBG5BL3IO7kiaZzqdWB3g0f0yBHOcpH03J+/jtEcFluPWA3E2FcEl
         61lQ==
X-Gm-Message-State: ABy/qLZreI1eaZVkytUlUsNzr1MMS7SE3+7PmvFsdFo2WImCqQCjUvWy
        gEpEwaxVFApkzlM9JWO1YTXjVnOLtDHRVfiXKT8=
X-Google-Smtp-Source: APBJJlF7a2WOTF1++m6SiWRDzvn49KStYyADTTuVEQycA2DCyW/yuBCyOKYlOG6U0CeWmE0BAtVs/pJMjwxAq+1W9T4=
X-Received: by 2002:a67:efd8:0:b0:443:6afe:e842 with SMTP id
 s24-20020a67efd8000000b004436afee842mr13885vsp.35.1689889936684; Thu, 20 Jul
 2023 14:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230713042037.980211-1-42.hyeyoo@gmail.com> <20230720071826.GE955071@google.com>
 <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com>
 <CAB=+i9QUNVbc+pEZD5vG_DUTcLrco5JNOrkkRDdcAfj08u7vVA@mail.gmail.com>
 <CAJD7tkbO0W4woJtidbQU0F2iOCQcDG024c6EZ1ZOb2sLOG1ovg@mail.gmail.com>
 <CAB=+i9R+BnePZWJGm-5xi+2HEiM=_5EBZtFGmaHye+iZvVR2Vw@mail.gmail.com> <CAJD7tkaXKLgWhOnGPXhs513kEZERyD6eX7btuU7f5dXuhWY62g@mail.gmail.com>
In-Reply-To: <CAJD7tkaXKLgWhOnGPXhs513kEZERyD6eX7btuU7f5dXuhWY62g@mail.gmail.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Fri, 21 Jul 2023 06:52:05 +0900
Message-ID: <CAB=+i9Quz9iP2-Lq=oQfKVVnzPDtOaKMm=hUPbnRg5hRxH+qaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 6:39=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> <snip>
> >
> > > > > It seems to me though the sizeof(zsdesc) is actually 56 bytes (on
> > > > > 64-bit), so sizeof(zsdesc) + sizeof(memdesc) would be equal to th=
e
> > > > > current size of struct page. If that's true, then there is no los=
s,
> > > >
> > > > Yeah, zsdesc would be 56 bytes on 64 bit CPUs as memcg_data field i=
s
> > > > not used in zsmalloc.
> > > > More fields in the current struct page might not be needed in the
> > > > future, although it's hard to say at the moment.
> > > > but it's not a loss.
> > >
> > > Is page->memcg_data something that we can drop? Aren't there code
> > > paths that will check page->memcg_data even for kernel pages (e.g.
> > > __folio_put() -> __folio_put_small() -> mem_cgroup_uncharge() ) ?
> >
> > zsmalloc pages are not accounted for via __GFP_ACCOUNT,
>
> Yeah, but the code in the free path above will check page->memcg_data
> nonetheless to check if it is charged.

Right.

> I think to drop memcg_data we need to enlighten the code that some pages
> do not even have memcg_data at all

I agree with you. It should be one of the milestones for all of this to wor=
k.
It won't be complicated for the code to be aware of it, because there will =
be
a freeing (and uncharging if need) routine per type of descriptors.
