Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB17CA3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjJPJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjJPJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:16:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE88AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:16:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso8795934a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697447790; x=1698052590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FwdJg2ESwHU12LbRl+SXH4clXzUSlhz/qOQqxgChOg=;
        b=Udg3+Ne+n4eqVERo5Kpy/FKQ5xkvI65GKvlMnLyfK3QdJE5G0cjP4pwaGEse+nQGaU
         5cgJTs8TPRjuSPY5a3iyVbmfiWUaIOTGveQ0kSsBIargMzYyAEiIptR38AD5CkJEwjPs
         wug2DEBb9K6qwLpnq6D5mTk954Tg8vbJfRby28bcdB3LsDDW7ju5c1eqY9yH7E0O7NIU
         GuX5YTxW+UGkYJ3Vra9azTB9G3E9E0DCVbKBGCXZqtYfv4NEF6sfxytEDB5hgTmwkW/J
         jg/Hqjh07hwf47rc1I8o82PgpdQx2cWu0Jy7gG35AGHiqZw1rT2Sm23IsL6tJrOBJBwG
         uEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447790; x=1698052590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FwdJg2ESwHU12LbRl+SXH4clXzUSlhz/qOQqxgChOg=;
        b=LScSHoFjs8jGqyyqUI/PqxKSeYQOI4yWQmsSjaNPZX8AV2bHQM07sf22uP/2Fthzym
         5IXOSzON/AIp1cdvkMq4QrvYKJYvNpyVlteLePSZxFuLom4vc3PasRmpo9nnlFEQxt7I
         +6AWiodkOagRC5HN4GUJzBrLd199XNfAIt3m5qjpr4Xpovv6uFGExuwosvzOvBj4Kt49
         fA8tKqMa8Hey7ok0uGQIWHaf9IL3PoP9x5jzgR7AGDKzJEHDgT7ExpvActD501+hSDV2
         qMqgtOts4r0oqe9R7PeG8lFXsEBntovigv2eOrhlptFd8aWLDbI34ccEwCULkZss9RdW
         Orzg==
X-Gm-Message-State: AOJu0Ywwcye5gkNrONotQigaw+Lhcq3TnZNGsgwbXhwEp5dCDGesu40f
        7UWjTshPa+E+SOHFMOnbmjHcvWBxymiP9kFmx4o=
X-Google-Smtp-Source: AGHT+IGNn3pHZquWoipKZMsvzUIeEiiGCnuz0jXKSt5Nx+h+AzFQEQGqfh7s6XMtl5w3ZkbiDQwx4RQfnnv2hns5G0s=
X-Received: by 2002:a50:c8ca:0:b0:530:ec02:babd with SMTP id
 k10-20020a50c8ca000000b00530ec02babdmr5868072edh.9.1697447790261; Mon, 16 Oct
 2023 02:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <1697194703-21371-1-git-send-email-zhiguo.niu@unisoc.com>
 <1880a7c4-9ab9-8e6d-f1d4-c2172a99685c@kernel.org> <CAHJ8P3J+Rnx4dUDGesdrtajDdP_SxDaM6yyYbHRt4ij_wVGhsg@mail.gmail.com>
 <4409f648-40f6-c28a-ebe0-d2c69ecd11fc@kernel.org>
In-Reply-To: <4409f648-40f6-c28a-ebe0-d2c69ecd11fc@kernel.org>
From:   Zhiguo Niu <niuzhiguo84@gmail.com>
Date:   Mon, 16 Oct 2023 17:16:18 +0800
Message-ID: <CAHJ8P3KK+C-4HJxnJYLH4v20QQt_Ki0_6f2exPJQFCUmPACXPg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix error path of __f2fs_build_free_nids
To:     Chao Yu <chao@kernel.org>
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chao,

On Mon, Oct 16, 2023 at 5:07=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> Zhiguo,
>
> On 2023/10/16 17:02, Zhiguo Niu wrote:
> > Dear Chao,
> >
> > On Mon, Oct 16, 2023 at 3:37=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2023/10/13 18:58, Zhiguo Niu wrote:
> >>> SBI_NEED_FSCK should be set for fsck has a chance to
> >>> repair in case of scan_nat_page fail in run time.
> >>>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>
> >> Hi Zhiguo,
> >>
> >> Can you please check below update?
> >>
> >>   From 9a3459d2d62a12f8708d72aa7808a1def9f9d92f Mon Sep 17 00:00:00 20=
01
> >> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >> Date: Fri, 13 Oct 2023 18:58:23 +0800
> >> Subject: [PATCH] f2fs: fix error path of __f2fs_build_free_nids
> >>
> >> If NAT is corrupted, let scan_nat_page() return EFSCORRUPTED, so that,
> >> caller can set SBI_NEED_FSCK flag into checkpoint for later repair by
> >> fsck.
> >>
> >> Also, this patch introduces a new fscorrupted error flag, and in above
> >> scenario, it will persist the error flag into superblock synchronously
> >> to avoid it has no luck to trigger a checkpoint to record SBI_NEED_FSC=
K.
> >>
> >> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>    fs/f2fs/node.c          | 11 +++++++++--
> >>    include/linux/f2fs_fs.h |  1 +
> >>    2 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >> index a2b2c6c7f66d..57d9dd3a43bc 100644
> >> --- a/fs/f2fs/node.c
> >> +++ b/fs/f2fs/node.c
> >> @@ -2389,7 +2389,7 @@ static int scan_nat_page(struct f2fs_sb_info *sb=
i,
> >>                  blk_addr =3D le32_to_cpu(nat_blk->entries[i].block_ad=
dr);
> >>
> >>                  if (blk_addr =3D=3D NEW_ADDR)
> >> -                       return -EINVAL;
> >> +                       return -EFSCORRUPTED;
> >>
> >>                  if (blk_addr =3D=3D NULL_ADDR) {
> >>                          add_free_nid(sbi, start_nid, true, true);
> >> @@ -2504,7 +2504,14 @@ static int __f2fs_build_free_nids(struct f2fs_s=
b_info *sbi,
> >>
> >>                          if (ret) {
> >>                                  f2fs_up_read(&nm_i->nat_tree_lock);
> >> -                               f2fs_err(sbi, "NAT is corrupt, run fsc=
k to fix it");
> >> +
> >> +                               if (ret =3D=3D -EFSCORRUPTED) {
> >> +                                       f2fs_err(sbi, "NAT is corrupt,=
 run fsck to fix it");
> >> +                                       set_sbi_flag(sbi, SBI_NEED_FSC=
K);
> >> +                                       f2fs_handle_error(sbi,
> >> +                                                       ERROR_INCONSIS=
TENT_NAT);
> >> +                               }
> >> +
> >>                                  return ret;
> >>                          }
> >>                  }
> >> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> >> index 07ed69c2840d..039fe0ce8d83 100644
> >> --- a/include/linux/f2fs_fs.h
> >> +++ b/include/linux/f2fs_fs.h
> >> @@ -104,6 +104,7 @@ enum f2fs_error {
> >>          ERROR_CORRUPTED_VERITY_XATTR,
> >>          ERROR_CORRUPTED_XATTR,
> >>          ERROR_INVALID_NODE_REFERENCE,
> >> +       ERROR_INCONSISTENT_NAT,
> >>          ERROR_MAX,
> >>    };
> >>
> >> --
> >> 2.40.1
> >
> > Thank you for your updates and these updates are more reasonable based
> > on the latest code.
> > In addition,  I also modified the following code after I checked the
> > related flow of f2fs_handle_error.
> > ERROR_INCONSISTENT_FOOTER is reused here,   any suggestions for this?
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index d9e6087..94f5c7f 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1467,6 +1467,7 @@ static struct page *__get_node_page(struct
> > f2fs_sb_info *sbi, pgoff_t nid,
> >                            ofs_of_node(page), cpver_of_node(page),
> >                            next_blkaddr_of_node(page));
> >          set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +       f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
> >          err =3D -EINVAL;
>
> err =3D -EFSCORRUPTED;
>
> >   out_err:
> >          ClearPageUptodate(page);
> >
> > If you have no other suggestions, I will update the "PATCH V2"
>
> How about changing above code in separated patch?
OK, I will do this as your suggestions.
Thanks!
>
> Thanks,
>
>  > Thanks!
