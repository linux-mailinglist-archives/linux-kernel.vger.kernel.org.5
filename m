Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFE7524F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGMOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGMOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5592733
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689257832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAEgJXo3oFHhbOe/67unGD8n1ytw1uGix+FjoJLnjGY=;
        b=Ub2vbIjFz1Pth/3F0vJM1Rngbq6Bmk7RGShTJmabL5eOadCC6mDaTB9M0gLf88OOIfETmt
        F7Nrzq9LB6zAtQnTTfWhTDc4rMJBBvBkjf2P1RQJMO1Rm61wOVeVjxwHsKf0y/H5G7tTSS
        e9bN3XEm2Yuunn3XWa55+5B6kXf5WOU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-BtqnkWWYP72XLLF69drrkg-1; Thu, 13 Jul 2023 10:16:04 -0400
X-MC-Unique: BtqnkWWYP72XLLF69drrkg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b890ca6718so3347775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257762; x=1691849762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAEgJXo3oFHhbOe/67unGD8n1ytw1uGix+FjoJLnjGY=;
        b=MNKCxo7sAdX0owpggpXg/rzx2MZlof61v/cTTBIwGQxvCAiG1HolAEI8m1HRbLLyif
         WQMy9Csn5eR/iC2SMN6StVFO7nAR5a3ieLx/xwfhwmpsJ2LKOxNKnaNwZuPwBhoBYAfQ
         GCW5gFIsO7YglKO0xySRelvo/1H82NWA5Dh8yTCVVAJAe1hdUVtaV+2Y9RUvE7iSEyHI
         8pTBQgTkQ8SBpMOV/eNQ0mur7lHuj1WoY22Mbx4YpChhlteqc74KVoRgdLUK+Qa5ceeZ
         YXz63SBwcD5oHWzjRGRPlD+lXYnROuCNMlgRY09OqPC8PIOwbGZClMZwpRTMRcEbHxRD
         K7Nw==
X-Gm-Message-State: ABy/qLYAkAGECsHrIUe32LPhXnJS7BJjWWaFsFCjwPEj0DxSPKp6caA/
        Zt/k7Ps/Rm1A6mZtzpgH78/+DygqDNSmHb0My3P1KwbdC/RhTXa/ZMB1XQm9xd1w5WLHJhjznqH
        34qOiLrBYxOj9/geBDcHWcs7QZGaFHyvfFqceyiuh
X-Received: by 2002:a17:902:aa05:b0:1b6:93e8:3ddb with SMTP id be5-20020a170902aa0500b001b693e83ddbmr1092166plb.6.1689257762252;
        Thu, 13 Jul 2023 07:16:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFBoaT6AgcpqEK/+OjOPi7omBjJbJZjmH2NbMZ6kEeX+GmTB19WcUDmjBsTSqAYSC3VtjzZfK2p0sFXLNEHGc0=
X-Received: by 2002:a17:902:aa05:b0:1b6:93e8:3ddb with SMTP id
 be5-20020a170902aa0500b001b693e83ddbmr1092153plb.6.1689257761981; Thu, 13 Jul
 2023 07:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230713135249.153796-1-jlayton@kernel.org>
In-Reply-To: <20230713135249.153796-1-jlayton@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 13 Jul 2023 16:15:50 +0200
Message-ID: <CAHc6FU6QQicrNDKWMQknP9YqKtEhhL0KbDCLACQ=v8P+tPQ5WQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix timestamp handling on quota inodes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     brauner@kernel.org, Bob Peterson <rpeterso@redhat.com>,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff and Christian,

On Thu, Jul 13, 2023 at 3:52=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> While these aren't generally visible from userland, it's best to be
> consistent with timestamp handling. When adjusting the quota, update the
> mtime and ctime like we would with a write operation on any other inode,
> and avoid updating the atime which should only be done for reads.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/gfs2/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Christian,
>
> Would you mind picking this into the vfs.ctime branch, assuming the GFS2
> maintainers ack it? Andreas and I had discussed this privately, and I
> think it makes sense as part of that series.

Yes, please.

> Thanks,
> Jeff
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 704192b73605..aa5fd06d47bc 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -871,7 +871,7 @@ static int gfs2_adjust_quota(struct gfs2_inode *ip, l=
off_t loc,
>                 size =3D loc + sizeof(struct gfs2_quota);
>                 if (size > inode->i_size)
>                         i_size_write(inode, size);
> -               inode->i_mtime =3D inode->i_atime =3D current_time(inode)=
;
> +               inode->i_mtime =3D inode_set_ctime_current(inode);
>                 mark_inode_dirty(inode);
>                 set_bit(QDF_REFRESH, &qd->qd_flags);
>         }
> --
> 2.41.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

