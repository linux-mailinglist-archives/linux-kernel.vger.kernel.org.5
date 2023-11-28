Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFED57FB088
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjK1CpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1CpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:45:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5A18B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:45:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so213162a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139520; x=1701744320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBgIx66JgbxS00z7d61Bmc74Zo2vZIf9EdPtiYw/aXQ=;
        b=m91MnMx/rtBLAwu6R8f0W/0nNOLu5RfsFZ+iFiFAgqQnoCfCTDWPDnk7NR2YSposUp
         qK2gbkvX5XpzTPD6TbxMlOXh7r6/jsHJBliQhlBs4UkLzHc4Q6z1OVSHjKScz61fAVzV
         Q47pjmvSwn8Z93zewNvU6sgO1uyBBNBXxvmMeFP+JR+/bctYTozxgQZPXVsTm6vz9hvt
         0Qi5/QxXFOGOA7CYt141pVYUOvJXA+9F6iOkaU/GBRZQz2oYQmoNETz8ms+yjM70DlGn
         7oEnVa+S7AKf8AlLI5aAxr3gVuQTFBm3cJ8oGCTq/DU0SKbLZC8AsYWRIq3yYzrFWCaj
         jDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139520; x=1701744320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBgIx66JgbxS00z7d61Bmc74Zo2vZIf9EdPtiYw/aXQ=;
        b=b2WuUIBJF33OXyFCGqRd17/vvfNupU63tzJsDl6cY5Wcn5KU6b/GVys546iB5iOgcz
         JSK08h4DzE8OjuwX/gNCzXXAkoz2oSOjWIGC8KuZb2srhJJRoerrn2eZ0885F3N4ry4z
         GAQ/Wdu4+uqKNfqNX3vMebeLyXzKiMZFOReDYXuPbXq4slQ27etoE2oJfgNR5qoqUnaK
         bUYQ8+q9AR2VjPXZ93D0rXhDZp0lTf1njQdXutAPXrQu9jGsan8n2l46gAWdY3k+tH60
         6ZrPMYtbdTd9uoHrD2Dkkg6d1xFLU/9t2J+NxxoaOTNylHVWw92d/SOwo1BwVePFMlQi
         2acA==
X-Gm-Message-State: AOJu0YyDRVi3vcCJnBAMt/U121U1x3c3nXb1kxM8Ci0WQNHnmPFnNUKw
        T+Y0pR7iFJFUlKMT7M1O8ral04xg+jxGIn/c+5g=
X-Google-Smtp-Source: AGHT+IE2bi4/9uI/r5EaOAI59CM1P1izJgE/zvms19wepvIPOGOZvv3/TjLCEEJMxLC3aqrg/z+agGX+NiBrEEZ3ilg=
X-Received: by 2002:a05:6402:3585:b0:54b:592c:c318 with SMTP id
 y5-20020a056402358500b0054b592cc318mr4986308edc.34.1701139519706; Mon, 27 Nov
 2023 18:45:19 -0800 (PST)
MIME-Version: 1.0
References: <1700788128-29002-1-git-send-email-zhiguo.niu@unisoc.com> <a9d45834-1ccf-8387-6b90-a88e0cc0772e@kernel.org>
In-Reply-To: <a9d45834-1ccf-8387-6b90-a88e0cc0772e@kernel.org>
From:   Zhiguo Niu <niuzhiguo84@gmail.com>
Date:   Tue, 28 Nov 2023 10:45:08 +0800
Message-ID: <CAHJ8P3LUOAwam=S_1jaqspQkmxWZTL1cjY+RApox76n-V4XNqw@mail.gmail.com>
Subject: Re: [PATCH] f2fs: show more discard stat by sysfs
To:     Chao Yu <chao@kernel.org>
Cc:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Chao,

On Tue, Nov 28, 2023 at 10:13=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/11/24 9:08, Zhiguo Niu wrote:
> > The current pending_discard attr just only shows the discard_cmd_cnt
> > information, which is not very meaningful. More discard information
> > can be shown so that we can check them through sysfs when needed.
>
> What about adding this entry to /sys/fs/f2fs/<dev>/stat/?
I think it is ok!
The purpose of this patch is to obtain f2fs discard related status
when necessary.
Because sys/kernel/debug/f2fs/status cannot be used on the user version,
I will change it according to your suggestion.
>
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   fs/f2fs/sysfs.c | 21 +++++++++++++++------
> >   1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 417fae96..f98e680 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -134,13 +134,22 @@ static ssize_t cp_status_show(struct f2fs_attr *a=
,
> >       return sysfs_emit(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_f=
lags));
> >   }
> >
> > -static ssize_t pending_discard_show(struct f2fs_attr *a,
> > +static ssize_t discard_stat_show(struct f2fs_attr *a,
> >               struct f2fs_sb_info *sbi, char *buf)
> >   {
> > -     if (!SM_I(sbi)->dcc_info)
> > +     struct discard_cmd_control *dcc =3D SM_I(sbi)->dcc_info;
> > +
> > +     if (!dcc)
> >               return -EINVAL;
> > -     return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
> > -                             &SM_I(sbi)->dcc_info->discard_cmd_cnt));
>
> It's better to keep the old one for any potential user.
>
> > +
> > +     return sysfs_emit(buf, "%llu, %llu, %llu, %u\n",
> > +                     (unsigned long long)atomic_read(
> > +                             &dcc->discard_cmd_cnt),
> > +                     (unsigned long long)atomic_read(
> > +                             &dcc->issued_discard),
> > +                     (unsigned long long)atomic_read(
> > +                             &dcc->queued_discard),
> > +                     dcc->undiscard_blks);
> >   }
> >
> >   static ssize_t gc_mode_show(struct f2fs_attr *a,
> > @@ -1016,7 +1025,7 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_a=
ttr *a,
> >   F2FS_GENERAL_RO_ATTR(encoding);
> >   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
> >   F2FS_GENERAL_RO_ATTR(main_blkaddr);
> > -F2FS_GENERAL_RO_ATTR(pending_discard);
> > +F2FS_GENERAL_RO_ATTR(discard_stat);
>
> It needs to adjust Documentation/ABI/testing/sysfs-fs-f2fs.
>
> Thanks,
>
> >   F2FS_GENERAL_RO_ATTR(gc_mode);
> >   #ifdef CONFIG_F2FS_STAT_FS
> >   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> > @@ -1074,7 +1083,7 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_a=
ttr *a,
> >       ATTR_LIST(discard_urgent_util),
> >       ATTR_LIST(discard_granularity),
> >       ATTR_LIST(max_ordered_discard),
> > -     ATTR_LIST(pending_discard),
> > +     ATTR_LIST(discard_stat),
> >       ATTR_LIST(gc_mode),
> >       ATTR_LIST(ipu_policy),
> >       ATTR_LIST(min_ipu_util),
