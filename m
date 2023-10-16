Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389D97CA341
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjJPJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjJPJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:03:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E233AAB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:03:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so7287320a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697446979; x=1698051779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7srnczgRawpx38hr/UBZkw9BkbuoP3OVHfP2ooZqsfs=;
        b=YazkJlLW+Co7YRqP15DDVZTd90b8B5X4CXysOSqIt0pASyPlm0/GiNiLsWk3VqT+tN
         QWoyvMfKhbHdkBOPruElphiv5lbxsz9Cm4qxbzuBgJy4iAvOKXXxXPPcGpqeuVXZZm2L
         4dskCuQ/wljh+/1UJeROMLK4uMv8oGub4vzIBFkHddzuP/89/yzYCR4HghPknVRLh5Fh
         WIxTC/0UtHK/B/ETUJn9K4hFhH3LU76FOaY4TT+OKYRJGjM+WXkmxLeCMuXyvMQ2NFl5
         Fri6qPqRsLGkg48W9L+C2gjzHrDWtWYs6BEfbbZjPxNjNKFfnaBJ6YMpieG0VmFt9idU
         2YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697446979; x=1698051779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7srnczgRawpx38hr/UBZkw9BkbuoP3OVHfP2ooZqsfs=;
        b=s/GuvYSzeWDxIOvMFoNiIoS7IWTukLpzoMIqVOrqfQvNHPSz/kBKQjPvQ4P0434XSp
         DqNxy+Ek94jeQc8QvkjOhGbRCHJ695MN9ZQ+fV7bvciQEwDXI9+5+pvvzsRUoGx5FCHp
         FHgPNWQ0WTM3Erh6ztvNL5xxfB7Y38Zy/Asj6mScN2CyHVoWvnoPUi/8krmGha0smp9Y
         56nanvEqPQdScJmA+l31DPL1Wi9Nmdjv9SaiAvO8td4+0ezWKVvc9mV8+QhEOLw/MdAQ
         gAy23l+oGyeJ2dpGAsOm/Xux5oY0i47egd/h8yV+rjbe6yr1n/LB02Z8TDxLMUkfj1zT
         rnlw==
X-Gm-Message-State: AOJu0YxLx0PvAicvtWzm9qThwzQ5MNTH1DpF2UQxnTnm41VBXneupXXk
        Sbx00/7rLjtx5X7VJnpUpza8oldSSf/qDzoHX4NW+l+nwqs=
X-Google-Smtp-Source: AGHT+IGTuzMF+kaLgulyD/Pi5k7gUXqsLRBL7hI18qBO8zB+xnaftx6sdgpW+RFfzWvTQN0tSV2gwQU5ZMQF+dzi2P8=
X-Received: by 2002:a05:6402:2293:b0:53d:7be0:4a93 with SMTP id
 cw19-20020a056402229300b0053d7be04a93mr15251802edb.11.1697446979146; Mon, 16
 Oct 2023 02:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <1697194703-21371-1-git-send-email-zhiguo.niu@unisoc.com> <1880a7c4-9ab9-8e6d-f1d4-c2172a99685c@kernel.org>
In-Reply-To: <1880a7c4-9ab9-8e6d-f1d4-c2172a99685c@kernel.org>
From:   Zhiguo Niu <niuzhiguo84@gmail.com>
Date:   Mon, 16 Oct 2023 17:02:47 +0800
Message-ID: <CAHJ8P3J+Rnx4dUDGesdrtajDdP_SxDaM6yyYbHRt4ij_wVGhsg@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 3:37=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/10/13 18:58, Zhiguo Niu wrote:
> > SBI_NEED_FSCK should be set for fsck has a chance to
> > repair in case of scan_nat_page fail in run time.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>
> Hi Zhiguo,
>
> Can you please check below update?
>
>  From 9a3459d2d62a12f8708d72aa7808a1def9f9d92f Mon Sep 17 00:00:00 2001
> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Date: Fri, 13 Oct 2023 18:58:23 +0800
> Subject: [PATCH] f2fs: fix error path of __f2fs_build_free_nids
>
> If NAT is corrupted, let scan_nat_page() return EFSCORRUPTED, so that,
> caller can set SBI_NEED_FSCK flag into checkpoint for later repair by
> fsck.
>
> Also, this patch introduces a new fscorrupted error flag, and in above
> scenario, it will persist the error flag into superblock synchronously
> to avoid it has no luck to trigger a checkpoint to record SBI_NEED_FSCK.
>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/node.c          | 11 +++++++++--
>   include/linux/f2fs_fs.h |  1 +
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index a2b2c6c7f66d..57d9dd3a43bc 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2389,7 +2389,7 @@ static int scan_nat_page(struct f2fs_sb_info *sbi,
>                 blk_addr =3D le32_to_cpu(nat_blk->entries[i].block_addr);
>
>                 if (blk_addr =3D=3D NEW_ADDR)
> -                       return -EINVAL;
> +                       return -EFSCORRUPTED;
>
>                 if (blk_addr =3D=3D NULL_ADDR) {
>                         add_free_nid(sbi, start_nid, true, true);
> @@ -2504,7 +2504,14 @@ static int __f2fs_build_free_nids(struct f2fs_sb_i=
nfo *sbi,
>
>                         if (ret) {
>                                 f2fs_up_read(&nm_i->nat_tree_lock);
> -                               f2fs_err(sbi, "NAT is corrupt, run fsck t=
o fix it");
> +
> +                               if (ret =3D=3D -EFSCORRUPTED) {
> +                                       f2fs_err(sbi, "NAT is corrupt, ru=
n fsck to fix it");
> +                                       set_sbi_flag(sbi, SBI_NEED_FSCK);
> +                                       f2fs_handle_error(sbi,
> +                                                       ERROR_INCONSISTEN=
T_NAT);
> +                               }
> +
>                                 return ret;
>                         }
>                 }
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 07ed69c2840d..039fe0ce8d83 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -104,6 +104,7 @@ enum f2fs_error {
>         ERROR_CORRUPTED_VERITY_XATTR,
>         ERROR_CORRUPTED_XATTR,
>         ERROR_INVALID_NODE_REFERENCE,
> +       ERROR_INCONSISTENT_NAT,
>         ERROR_MAX,
>   };
>
> --
> 2.40.1

Thank you for your updates and these updates are more reasonable based
on the latest code.
In addition,  I also modified the following code after I checked the
related flow of f2fs_handle_error.
ERROR_INCONSISTENT_FOOTER is reused here,   any suggestions for this?
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d9e6087..94f5c7f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1467,6 +1467,7 @@ static struct page *__get_node_page(struct
f2fs_sb_info *sbi, pgoff_t nid,
                          ofs_of_node(page), cpver_of_node(page),
                          next_blkaddr_of_node(page));
        set_sbi_flag(sbi, SBI_NEED_FSCK);
+       f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
        err =3D -EINVAL;
 out_err:
        ClearPageUptodate(page);

If you have no other suggestions, I will update the "PATCH V2"
Thanks!
