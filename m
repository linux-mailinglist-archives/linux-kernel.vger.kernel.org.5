Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398C57C984C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjJOHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJOHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 03:39:33 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC35A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 00:39:32 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57b9cb05fa3so1783731eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697355572; x=1697960372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNv3jfwRRNqkt9PPVa1lvKqsr9PdWHn6W6Ue4vwk6JI=;
        b=BOdVe3CDB/sBdB6/a9864CEubPscBQc06TRVlGiyXModV/oRRZv/nBZiYi2n4FlUeC
         CR0Y557s/brEt0gJUlzrdlKlgVRyZjeMNDmOFhBzGOqlLgan4JDjmknYUczs20qKfIct
         p8NaOf4k7xMUSe4+agA0JKse97jaQwFuUlwIOAK/6A4LwNwB7oL2vXLMrd010TTCoymM
         2S1J1NDYoEBiLfBcb2qnBVMi/mMt48XaLpSN0sQrr9tbQY8byugzK+0RBratx+vogdlO
         APotIrUkTYH+qtaYj9ylzLWiZ4grPZIqFsuIIfJpIlOxnaVTTwObxX+W36zSTn0dg7OE
         2Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697355572; x=1697960372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNv3jfwRRNqkt9PPVa1lvKqsr9PdWHn6W6Ue4vwk6JI=;
        b=uY7Lfz6ZWgiZU/CPhtiPhStxfxbvXfdspqLRcKLF0vIe6/A4AxJH4cXzjv/PV+/kuH
         krGCxHHlOphxvyuseS4bw4vXAV9LJRjOWU7Tl8gsVR1K8xpDcLmsc0TiLcpKpap/cIkD
         1paZwoAX3esj8XiPhvEpPOCCGYHfstvyA426zhUDkWgLw2nWWwY2qkSoYcPgxtTmPlUf
         6tikj9FOX1V+lOoinmUJBlnMsfzHHmn9ZlpEITglKhGf4WAfqcvPNDzFcVGqA3TMNA4T
         ZL7syp7ICbhah5NIT9r7SiQB0bm/iFkYs0vfZbqMsntdnTeEJ9pZPSF/HPmfwI8s9SJV
         KrQQ==
X-Gm-Message-State: AOJu0YwBSNxvSL8FnEekuthamNxvLxztl4rITBMiniHZ5GtgWhUnQk6a
        S08+lgPQwnjxDbGsWd6fn5KTziJFsEXNrmXK10Q=
X-Google-Smtp-Source: AGHT+IHwppOyj+URsllgCK0F09WQI8i3cFdFM0q+gTOnKY+C0lrJdsFmuMueCvi4oNE4itEV4q1Ks7vTsbfQBieoo0M=
X-Received: by 2002:a4a:c889:0:b0:581:3f2b:ca53 with SMTP id
 t9-20020a4ac889000000b005813f2bca53mr2652344ooq.1.1697355571674; Sun, 15 Oct
 2023 00:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZSjpQlUcyOoYv4Yh@lab-ubuntu> <62778e4d-cc2e-4310-b334-52b54cfe7e79@kadam.mountain>
In-Reply-To: <62778e4d-cc2e-4310-b334-52b54cfe7e79@kadam.mountain>
From:   Calvince Otieno <calvncce@gmail.com>
Date:   Sun, 15 Oct 2023 10:39:20 +0300
Message-ID: <CADFX3OSqnjGrxRazmmcBuGUOyv4TuXGEJ8fqbAhR4X9j0rn6sA@mail.gmail.com>
Subject: Re: [PATCH] staging: wlan-ng: remove unused functions
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 10:38=E2=80=AFAM Calvince Otieno <calvncce@gmail.co=
m> wrote:
>
> On Fri, Oct 13, 2023 at 12:02=E2=80=AFPM Dan Carpenter <dan.carpenter@lin=
aro.org> wrote:
>
> On Fri, Oct 13, 2023 at 09:52:50AM +0300, Calvince Otieno wrote:
> > The following functions were defined in the prism2mgmt.h file but neith=
er
> > declared nor used anywhere. It is recommended that they be removed.
> >
> >       - void prism2mgmt_get_grpaddr(u32 did, struct p80211pstrd *pstr,
> >                                     struct hfa384x *priv);
> >       - int prism2mgmt_set_grpaddr(u32 did,
> >                                  u8 *prism2buf, struct p80211pstrd *pst=
r,
> >                                  struct hfa384x *priv);
> >       - int prism2mgmt_get_grpaddr_index(u32 did);
> >
>
> Could you look up when the functions were deleted and add that
> information to the commit message?
>
>     These functions were removed five years ago in commit 123412341234
>     ("delete functions").
>
> regards,
> dan carpenter

Hello Dan,
I am  not able to locate exactly when these functions were deleted.
I have checked the commit history of these files prism2mgmt.h and prism2mgm=
t.c,
but, I can't find any commit relating to the removal of the above functions=
.

--=20
Kind regards,
Calvince Otieno
