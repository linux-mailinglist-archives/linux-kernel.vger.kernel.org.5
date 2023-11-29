Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059D7FCFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjK2H3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK2H3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:29:31 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE7DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:29:10 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cdd9c53270so39398b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701242950; x=1701847750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6Jc4pAoAAA2vk1kv4HIQqH9+hXuX+3xL1P6NNqp0C4=;
        b=DnJ5H2+HqiZtOWs6MQhh7h1iF7GSvPSkY9cuRbtLEEsLlF1ArYI+KuRWNnR/Xbd0zT
         +EneNwyseY7tZuto+Rf6mqtT+eZfNRrYiSL510m1F3ZnVOEoAAOv+r3DZCcMrVysnqsJ
         tAdhxxfjxyRG90IfmglOXMUgmSgYbOFemU5VlOaqEXL1rzRO0Vmn7C+590uY3Gh4HVes
         KECWuROxHpimhhDdi/Q7lEy3MeQzaWEPy0XVdkaek1lURrjomhax5ERwMu1pXLutiE3U
         Q199AE5Sbvhj1h46eAgcgKSRUFxThsdU6VYGaeEC0TskYLEbPdkiAOs5mWzv4lnjEpNI
         ACrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701242950; x=1701847750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6Jc4pAoAAA2vk1kv4HIQqH9+hXuX+3xL1P6NNqp0C4=;
        b=bteDGKGZ6SDOSEKENGK1JL8WJ+IBiBSoxPL9Dp7ekxH3MaEmX4RvW4ovg9ba+OVHL3
         +jc7/A3ntbZkgaOg0iGO2lSSjgjQzeLpQGkOiq0iPteSi4LuDjtgNfMNzcu48O4fl2Tj
         iZAWEqSqNu/3eXfOKgGW23pTyUllTNA+t7mTHYd6fSxtEe/0VMn93wcdZEWcUxRe0uCu
         4J3b2FzjfhDVn3bI61piTK0weJGn9UzRUmcPiRCo8b4eKJSdCumQO0tUVrfoUOKp8WgQ
         5epnOGCfskbdiKGUL4ftTBNd3gt6OJGq9+7USUB6buGfPVMiBsN3y7fovF5nh8UdABLf
         Le7g==
X-Gm-Message-State: AOJu0Yz4MGtt/e3KNeyFHvqhg8bfaavlP/9bZRKgEy1ts93k6vZidlV0
        Rgh2iF9ALnM8JpnRMqQAsO846jzKK0tGOfPU3apECA==
X-Google-Smtp-Source: AGHT+IGJuJC14YM235AUiec+4c9mTNF4YNHTAKAtw32RNLGQIQMueSnF+1OVeBeH6ROA4hE/gKU4WTWibh1Y2Srwkis=
X-Received: by 2002:a05:6a20:8e10:b0:187:a2ca:40a4 with SMTP id
 y16-20020a056a208e1000b00187a2ca40a4mr15822055pzj.50.1701242949688; Tue, 28
 Nov 2023 23:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
 <ZWZ0qGWpBTW6Iynt@dread.disaster.area> <20231129063433.GD361584@frogsfrogsfrogs>
In-Reply-To: <20231129063433.GD361584@frogsfrogsfrogs>
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
Date:   Wed, 29 Nov 2023 15:28:58 +0800
Message-ID: <CAP4dvscaASc9Dp3xEm4gd0b2RRFxwb9SY_chwD+CcvpqANFF9A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/2] xfs: update dir3 leaf block metadata
 after swap
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 2:34=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Nov 29, 2023 at 10:15:52AM +1100, Dave Chinner wrote:
> > On Tue, Nov 28, 2023 at 01:32:02PM +0800, Jiachen Zhang wrote:
> > > From: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > >
> > > xfs_da3_swap_lastblock() copy the last block content to the dead bloc=
k,
> > > but do not update the metadata in it. We need update some metadata
> > > for some kinds of type block, such as dir3 leafn block records its
> > > blkno, we shall update it to the dead block blkno. Otherwise,
> > > before write the xfs_buf to disk, the verify_write() will fail in
> > > blk_hdr->blkno !=3D xfs_buf->b_bn, then xfs will be shutdown.
> > >
> > > We will get this warning:
> > >
> > >   XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0x=
a8/0xe0 [xfs], xfs_dir3_leafn block 0x178
> > >   XFS (dm-0): Unmount and run xfs_repair
> > >   XFS (dm-0): First 128 bytes of corrupted metadata buffer:
> > >   00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  =
........=3D.......
> > >   000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  =
................
> > >   000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  =
.D...dDA..`.PC..
> > >   00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  =
.........s......
> > >   00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  =
.).8.....).@....
> > >   000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  =
.).H.....I......
> > >   00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  =
.I....E%.I....H.
> > >   0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  =
.I....Lk.I. ..M.
> > >   XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of fil=
e fs/xfs/xfs_buf.c.  Return address =3D 00000000c0ff63c1
> > >   XFS (dm-0): Corruption of in-memory data detected.  Shutting down f=
ilesystem
> > >   XFS (dm-0): Please umount the filesystem and rectify the problem(s)
> > >
> > > From the log above, we know xfs_buf->b_no is 0x178, but the block's h=
dr record
> > > its blkno is 0x1a0.
> > >
> > > Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
> > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > ---
> > >  fs/xfs/libxfs/xfs_da_btree.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btre=
e.c
> > > index e576560b46e9..35f70e4c6447 100644
> > > --- a/fs/xfs/libxfs/xfs_da_btree.c
> > > +++ b/fs/xfs/libxfs/xfs_da_btree.c
> > > @@ -2318,8 +2318,18 @@ xfs_da3_swap_lastblock(
> > >      * Copy the last block into the dead buffer and log it.
> > >      */
> > >     memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
> > > -   xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
> > >     dead_info =3D dead_buf->b_addr;
> > > +   /*
> > > +    * Update the moved block's blkno if it's a dir3 leaf block
> > > +    */
> > > +   if (dead_info->magic =3D=3D cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
> > > +       dead_info->magic =3D=3D cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
> > > +       dead_info->magic =3D=3D cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {
>
> On second thought, does this code have to handle XFS_DA3_NODE_MAGIC as
> well?

I think the node block is not too possible the last block, but it's
harmless to add this check.

I would use Dave's suggestion to check xfs's crc-feature rather than
magic. I think it's equivalent
in this function.

We will send the v2 patchset soon.

Thanks.

>
> >
> > a.k.a.
> >
> >       if (xfs_has_crc(mp)) {
> >
> > i.e. this is not specific to the buffer type being processed, it's
> > specific to v4 vs v5 on-disk format. Hence it's a fs-feature check,
> > not a block magic number check.
>
> in which case Dave's comment is correct, yes?
>
> --D
>
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> >
