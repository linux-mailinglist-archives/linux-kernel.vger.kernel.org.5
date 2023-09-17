Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F647A35DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjIQOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbjIQOdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3A12D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694961138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fd2SQIw5RGzEP/oFXtTGteoLvZh3GLziCsZTny7nBwk=;
        b=UL9zv3gpy+BlX2HyDYUL9wuRXaprzZbeQ1zJortdHLEixXHFvp1kqBN4Z3r8s9mrQ0Ifv6
        yZGb725k32cg6+JMu9XUTYzqOM+xM5jx2qka7q0x2ZbpTwW7msboV5Ujfe+oJmHcOZ8uIn
        gr7kXKaiN/JVn10+NiFndalrV8h27GI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-mg_NxEXZM96OyBTRh7DMiA-1; Sun, 17 Sep 2023 10:32:16 -0400
X-MC-Unique: mg_NxEXZM96OyBTRh7DMiA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27489394741so2075263a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 07:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694961135; x=1695565935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd2SQIw5RGzEP/oFXtTGteoLvZh3GLziCsZTny7nBwk=;
        b=XuzXKOwaZXFjSutV0JFi9uzGyp0qOP7dhnchEqI2JGANQJlZf8UgHdNeHdxvigCVhj
         CeHvT4/LFc/XG7VgFKXyt8MpY1BN0S3YG80saM07V5VDMCy13OhqBgkUmbb/xgbt1syJ
         caxykeLpfaHM2430GxCOUmEUnj3Q1/tAJybK83eAgbqWGTWgzrE2kLdf82hGUsUg4irQ
         zlPupGhvtORw0yhj2t08JONQ+28K9RSyE1s+Nr7A8NhrYguTN1/kk9sm6I4CjHN8dNVP
         +S0q2sjj5pmNiDSP/cqCFnKjfRpHRxTEEWCJEr0ioe2h0/xtx1WkoqAQBjaJ5R09FczZ
         j0Dg==
X-Gm-Message-State: AOJu0YyYKUI2ZWnuyQvUp8v2w06KYTOGded/vXVvZ7VLYwO7hfbht+uN
        fLGrSz25R/noVO4J5OrTiwe6lUeAMZhu2JYX7pQSZ10wntsuLbSCmr7+OCw8oeVvZxFncyW5frp
        dPSvgctUMlu6CIqXuT771Xh7pF11ljB+hFRw1aYdI
X-Received: by 2002:a17:90a:31c9:b0:25e:d727:6fb4 with SMTP id j9-20020a17090a31c900b0025ed7276fb4mr4479052pjf.2.1694961135575;
        Sun, 17 Sep 2023 07:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxaKD5CAfPDp+ptbao2NQtHRlf3cdqB0MlFwsD5D8HxKapmYDbW+OyM4JgBC0g1lRVqg8MaST0ACrIZLk6h88=
X-Received: by 2002:a17:90a:31c9:b0:25e:d727:6fb4 with SMTP id
 j9-20020a17090a31c900b0025ed7276fb4mr4479048pjf.2.1694961135300; Sun, 17 Sep
 2023 07:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
 <20230917005419.397938-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230917005419.397938-1-mattlloydhouse@gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sun, 17 Sep 2023 16:32:04 +0200
Message-ID: <CAOssrKcECS_CvifP1vMM8YOyMW7dkGXTDTKY2CRr-fPrJk76ZA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 2:54=E2=80=AFAM Matthew House <mattlloydhouse@gmail=
.com> wrote:

> > +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
> > +               if (!capable(CAP_SYS_ADMIN) &&
> > +                   !is_path_reachable(r, r->mnt.mnt_root, root))
> > +                       continue;
>
> I'm not an expert on the kernel API, but to my eyes, it looks a bit weird
> to silently include or exclude unreachable mounts from the list based on
> the result of a capability check. I'd normally expect a more explicit
> design, where (e.g.) the caller would set a flag to request unreachable
> mounts, then get an -EPERM back if it didn't have the capability, as
> opposed to this design, where the meaning of the output ("all mounts" vs.
> "all reachable mounts") changes implicitly depending on the caller. Is
> there any precedent for a design like this, where inaccessible results
> are silently omitted from a returned list?

Good point.  That issue was nagging at the back of my mind.  Having an
explicit flag nicely solves the issue.

Thanks,
Miklos

