Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE37B990D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbjJEAE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbjJEAEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:04:25 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD17EE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:04:19 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b07719089aso293831241.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696464258; x=1697069058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkg7+rczDvEf5vw76+FGOEqy3G1WsJgAGbY3dy46WG0=;
        b=jAZHMGfs/vH7lfRwrjyBz6oaFuz3C1bSEuf49kmnnmaN/1p7tImxjkU6o/4c4dx1lJ
         UoFjuCuejMcHBt4wsCfpZPDfSaDGGqjVZAnl8GK0MQrbtU59b/wblW26/+QIURRWu8IC
         Xio2N+850dp1vJW3AG5TSrezoIFRUrQa3FPEqgsvrHV+w3BnEagnkdYW5o8SrnwkEvEm
         0zmlRLvc4wAGVbV0qHEBLA33A9cLqU5wlFC8HawtQ1gglZzssIN2nIOzdONFQrBspr4p
         JJyzYKY1bQRRmjJlBLLAez9rp9mi0TMmc1Pv3F3O4fcKwZCO0I5Zie5I6lKcVxONeaWK
         B+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696464258; x=1697069058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkg7+rczDvEf5vw76+FGOEqy3G1WsJgAGbY3dy46WG0=;
        b=XVxFIe/jJBdTpTFfXRUptxXATBjQP63LbsRJouyiZjKUQlG4PwQ+9keci43geS9GwT
         BYMN3OUFGtw5UzvT4bs9QOj2RjmihbZ/RkX/1petw6Xhe8BhxXYLEQft2tqIs3mJ4ppR
         ty7BbAwMG9bIdadkU9djQVFRJAOk6yjgAHe4m5+REzyxAeq/FNj57KWISrDIBCjnmcY8
         Mr26DvMR68t2Lk7Y0ECTaTdF6g/WGj3OLkD6eu1RKaGBtf2SfmTK0WncEFCtOLg1kKtw
         VonR2Udy8dR4TbYjoSB0IeJc1kpupGasQpibYhiLXjKmM5J5zBndqZWygppZBXfgE/OS
         bmEw==
X-Gm-Message-State: AOJu0YzcgHJBlckCjelyTHeiAiPC78XFIteGIMBIkzrPmwbToa/xVHih
        kD0W3J76F2LStVbA1kznHoCRwrEBXw/+htEbiZQ=
X-Google-Smtp-Source: AGHT+IEkEy7nTZvm9Lo1GeI7LwD4zyd85KPs0KALc+yrS1+dsVdNI/ItufsM2wWbY3At4/Yvp+fWO2fpBLL86lPRrkw=
X-Received: by 2002:a05:6102:53c9:b0:455:dd1c:9653 with SMTP id
 bs9-20020a05610253c900b00455dd1c9653mr487841vsb.1.1696464258319; Wed, 04 Oct
 2023 17:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231003230155.355807-1-daeho43@gmail.com> <ZR30mNQEyRjzr0jm@google.com>
 <CACOAw_zSvAPTREb0dSv6srRuxuKxDZp4rMhLyWTk+uJ3WKSWKA@mail.gmail.com> <ZR37Xyr9HcVuLqxx@google.com>
In-Reply-To: <ZR37Xyr9HcVuLqxx@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 4 Oct 2023 17:04:07 -0700
Message-ID: <CACOAw_weaNhBUpeR9xnkPYQCu6RO-AkUZeJGJYh9tokdUtATKg@mail.gmail.com>
Subject: Re: [PATCH] f2fs-tools: use proper address entry count for direct nodes
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
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

On Wed, Oct 4, 2023 at 4:55=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
>
> On 10/04, Daeho Jeong wrote:
> > On Wed, Oct 4, 2023 at 4:26=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org>=
 wrote:
> > >
> > > On 10/03, Daeho Jeong wrote:
> > > > From: Daeho Jeong <daehojeong@google.com>
> > > >
> > > > For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.
> > > >
> > > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > > ---
> > > >  fsck/fsck.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fsck/fsck.c b/fsck/fsck.c
> > > > index 78ffdb6..56a7d31 100644
> > > > --- a/fsck/fsck.c
> > > > +++ b/fsck/fsck.c
> > > > @@ -2894,7 +2894,7 @@ static void fsck_failed_reconnect_file_dnode(=
struct f2fs_sb_info *sbi,
> > > >       fsck->chk.valid_blk_cnt--;
> > > >       f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> > > >
> > > > -     for (i =3D 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
> > > > +     for (i =3D 0; i < DEF_ADDRS_PER_BLOCK; i++) {
> > >
> > > It seems we need to use the inode block passing by fsck_failed_reconn=
ect_file().
> >
> > This function is for direct nodes. Is it correct to use inode block her=
e?
>
>  523 unsigned int addrs_per_block(struct f2fs_inode *i)
>  524 {
>  525         if (!LINUX_S_ISREG(le16_to_cpu(i->i_mode)) ||
>  526                         !(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
>  527                 return DEF_ADDRS_PER_BLOCK;
>  528         return ALIGN_DOWN(DEF_ADDRS_PER_BLOCK, 1 << i->i_log_cluster=
_size);
>  529 }
>
> If the inode is compressed, it seems it has to be aligned to cluster size=
.

makes sense. Thanks~!

>
> >
> > >
> > > >               addr =3D le32_to_cpu(node->dn.addr[i]);
> > > >               if (!addr)
> > > >                       continue;
> > >
> > > 3012                         fsck->chk.valid_blk_cnt--;
> > > 3013                         if (addr =3D=3D NEW_ADDR)
> > >
> > > And, we also need to skip if addr =3D=3D COMPRESS_ADDR here?
> > >
> > > 3014                                 continue;
> > > 3015                         f2fs_clear_main_bitmap(sbi, addr);
> > > 3016                 }
> > >
> > > > --
> > > > 2.42.0.582.g8ccd20d70d-goog
