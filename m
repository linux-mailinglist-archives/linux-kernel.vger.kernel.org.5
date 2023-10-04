Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790DF7B98BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjJDXhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjJDXhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:37:36 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3757C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:37:32 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4526b9404b0so1025222137.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696462652; x=1697067452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fORUCfyg1OYLIckpVuIRlc6CrB2QtpkrB5qEQj0FaD0=;
        b=P5RYohu26qFWpqCbuNeerkf0t4/jo2dTa9hFI7s6kjKdIENjZs4s3xgx3W75Fo+5xM
         km3AskQVc4pThi4WFBUqxxwdmjpljEI2rRlQ6tuDyGmrh4r3X4GRp0SJFsQgNXM7Jtzl
         LLAcrsmIlSQvU/DQpJtsg9llfvd31J30RBFYwAFnSu6J/ZmaqNeFzTroGDhQg0eIMGHC
         JzayCV/jC3uqQ3pck/HXiKSZnlFJWzHlLDDwxPDgH6Swste+iauPyt1zSDXU5u3/rgaM
         2mPnIbeOaS1OK8W8DUfyrXAtIkHwLYyXKgA2JdbeF7x98Lf5iiEqNByzatZuJDfG5SQ5
         r1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696462652; x=1697067452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fORUCfyg1OYLIckpVuIRlc6CrB2QtpkrB5qEQj0FaD0=;
        b=ApQL0Lv3xm40xFKu0FjklnnTcAmvtQjOBz3XQVQPDMyCQ9FJEB1bjCLuocaIYzZuSF
         3laaeUhCSxMKei14blq5QKMtuC9auOT9QrGS7vYQv/6nPfODfZ/jOjRpRAEo6MpA8zJk
         hanUGLMFRmEGu2hinVQ1wbQJBRq/AyR/aGHz1Lvfniok4Hn79gLTyUZnmXHouh1sd+2o
         2Ley5rI8HkIqKplsgpf0ZMXNA9uylBRaxqLFygnNFb+wEAESuQBIYtdRKFLfoFEIAjEa
         ibzLbZ60QoF1MjcnVn2aMwUtcJJMc9LR34LJJKAS1qVTe2rAM0R0Zc3jow1Nmg4MafXQ
         gvrw==
X-Gm-Message-State: AOJu0Yy1r9E5N3KfGJ8KhvclzkIiFQARivlfNWiar4PTNf6kASJHLxg9
        /FLgKsZXfDAIMJko5rad/vTz3QuMi6dpkW1089mnOTzB
X-Google-Smtp-Source: AGHT+IFKnn1oa+t5Dn9nijO5q6UPOuEvfOjfjTA0p/MzsUo+nnM3v/XLNwYpW1znkfZZc5U/EjbBDa41v5Y1ZoTg1y4=
X-Received: by 2002:a05:6102:40b:b0:44d:42c4:f4bf with SMTP id
 d11-20020a056102040b00b0044d42c4f4bfmr557391vsq.10.1696462652097; Wed, 04 Oct
 2023 16:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231003230155.355807-1-daeho43@gmail.com> <ZR30mNQEyRjzr0jm@google.com>
In-Reply-To: <ZR30mNQEyRjzr0jm@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 4 Oct 2023 16:37:20 -0700
Message-ID: <CACOAw_zSvAPTREb0dSv6srRuxuKxDZp4rMhLyWTk+uJ3WKSWKA@mail.gmail.com>
Subject: Re: [PATCH] f2fs-tools: use proper address entry count for direct nodes
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:26=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
>
> On 10/03, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fsck/fsck.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fsck/fsck.c b/fsck/fsck.c
> > index 78ffdb6..56a7d31 100644
> > --- a/fsck/fsck.c
> > +++ b/fsck/fsck.c
> > @@ -2894,7 +2894,7 @@ static void fsck_failed_reconnect_file_dnode(stru=
ct f2fs_sb_info *sbi,
> >       fsck->chk.valid_blk_cnt--;
> >       f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> >
> > -     for (i =3D 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
> > +     for (i =3D 0; i < DEF_ADDRS_PER_BLOCK; i++) {
>
> It seems we need to use the inode block passing by fsck_failed_reconnect_=
file().

This function is for direct nodes. Is it correct to use inode block here?

>
> >               addr =3D le32_to_cpu(node->dn.addr[i]);
> >               if (!addr)
> >                       continue;
>
> 3012                         fsck->chk.valid_blk_cnt--;
> 3013                         if (addr =3D=3D NEW_ADDR)
>
> And, we also need to skip if addr =3D=3D COMPRESS_ADDR here?
>
> 3014                                 continue;
> 3015                         f2fs_clear_main_bitmap(sbi, addr);
> 3016                 }
>
> > --
> > 2.42.0.582.g8ccd20d70d-goog
