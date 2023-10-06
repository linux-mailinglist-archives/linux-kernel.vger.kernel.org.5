Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354137BC128
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjJFVcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjJFVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:32:32 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD7BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:32:30 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f7cc71e2eso32696897b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696627949; x=1697232749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7nhNrrcEioXD0TPvV1pN7kd7gJMiVym43CUY/dMMZM=;
        b=wDuI+2jcAn3wsh7XgXl6U2TkZx5jEf2Hmi0273zvlD0pNffroaL6zS5hld1Z1iQU7I
         NImuZCJfXtaC7rEWg78JT49wfoe74p0WdlCdwMnrqOA5ZmA2FMU3TM6kaKrQ8srrkxCn
         R0HtMiEdstP6RW77watFRzEpFpj/VcU68S4m0xMCGWuAtmT9TwVhcZDbu7vQk/ugs9bT
         4bXBqw55OWvFkixdyTB0xWrUU+h//lWi/+LpTI8XBgRrQ1Z3WEDh04zPnjxErS/2X5q5
         gstDZXSr+NGcrvxRm/K00yCawMlKE+oEYYsDP0SJ50AyvVLQgT69dIJrAGglGySAlBQ+
         pFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627949; x=1697232749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7nhNrrcEioXD0TPvV1pN7kd7gJMiVym43CUY/dMMZM=;
        b=c97273zrNSZGhSKb/PctjDeO9NYcnXn4EMSC8xEvJ0lxrxreVuZ1Ps1oHsJk9CBUr9
         ACa8rvhpkJ5Ip2KvwdQl318eo+hNSzjl8xwELmM9q7X7xOl0pNZ5PasdzUqXYlNwIyhd
         pg2XolLtm5VyWeGH42GqAHUwEHQxFdpxw1nau3kQNcA2kJpbLZ4Zn2JCQ5OVezXRYDYv
         O3xLk0TLiApuPCh1TcvwbuEcKXBrpt1AmLRuJ6EOeK6HMhnMRRt0QDWdRFZrGL67fKiE
         FQvCqUmPv8RvDNoZPW7yzebUJPROMZ4haVv2HQa76yFE4w0Zlft46mr3uFDe0QvIdJ0q
         2mfA==
X-Gm-Message-State: AOJu0YxfjbCech9wEIFdf2DE5dPlCVfUPjpg0OZoI9eXEbRSdjDsiL33
        FeMfwUg1KvYKFmoHECTUDhuc750sKAUPDvQtBXISTw==
X-Google-Smtp-Source: AGHT+IFNpoSi4VeIsa9zfB3rqLPoPdfRSLaaGEwTNK5oWcXngp98EkgmA/haYR4GP0iIgDVJRjgR58wej7BM9q+PMWA=
X-Received: by 2002:a81:8494:0:b0:59f:728b:ac0f with SMTP id
 u142-20020a818494000000b0059f728bac0fmr9816573ywf.6.1696627949389; Fri, 06
 Oct 2023 14:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com> <CAJuCfpFx3zxv1ZgkLh4dkafOCHvL_674cysJiuQPQhKXX9BuzQ@mail.gmail.com>
 <20231006140834.07110f7008677c646af1694d@linux-foundation.org>
In-Reply-To: <20231006140834.07110f7008677c646af1694d@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 6 Oct 2023 14:32:16 -0700
Message-ID: <CAJuCfpETk0=meVBHO0wfchm12eYZk2j7NcjJYxvh=qJOe4ySqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
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

On Fri, Oct 6, 2023 at 2:08=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 3 Oct 2023 09:21:22 -0700 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > > @@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
> > >
> > >                 remove_next =3D true;
> > >                 vma_start_write(next);
> > > -               ret =3D dup_anon_vma(vma, next);
> > > +               ret =3D dup_anon_vma(vma, next, &anon_dup);
> > >                 if (ret)
> > >                         return ret;
> >
> > Shouldn't the above be changed to a "goto nomem" instead of "return ret=
" ?
>
> It looks OK to me as-is - dup_anon_vma() leaves anon_dup=3D=3DNULL
> when it returns error.

Yes, I realised that after sending the question and didn't want to
create more noise than I already did... All seems good.
