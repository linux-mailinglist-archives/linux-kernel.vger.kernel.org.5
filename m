Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FF57DC399
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjJaAah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaAaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:30:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9183FA9;
        Mon, 30 Oct 2023 17:30:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D303C433CA;
        Tue, 31 Oct 2023 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698712233;
        bh=eU47Y9bdrWkAM2wQ47yQ1EZ9mIOSZ2SZ2tOXWftfThw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=r06z65wd53sLgQSV/Bemylh/lEFfa2Mm2DgvTnvxTNghIGkMYIe6YsNfZAy9dmpQM
         GvGYs46wlYC6QFmeh5EL7PiudkLYbn5I4Gzrj0xPMPqbHUb1to7o5y2JChydZU0RR7
         CGtnzdO42wzuZ6tJYjawceYDGO31RQyYDshhBXAUj0XDwSFuzSoyZa23ct4zlmXliv
         DjcXI03XyiqEe0pyBrqqG3X9TltCUSkewDcomlj2GAkRLkDRe3m+t1GcbLoiXl0kgr
         fF+NVshwTNqFKtXIIdv6phJSeGTxAlS0eZieKpKtHnrCSxmn0cZM/FDjbtXlNgWXOY
         UApuRh26GCFKA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce291b5df9so2991875a34.2;
        Mon, 30 Oct 2023 17:30:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwR7wjl/L07zgfp0sXiRJFWgsbrxo4NycEibcQacv5QRQHUsbQM
        6WL59Ra89udESYGgd4jqEQ3GHGXiOerFy0DCLTY=
X-Google-Smtp-Source: AGHT+IEzB8DSn3bRZieEt1LUJZ17ocUHUGgtiYDEk5GdTjVlSJnN3y3S1ZxIkJOQkZGUi+nCwWKl95RRJJPb1lyf1Og=
X-Received: by 2002:a05:6830:12c1:b0:6bc:de95:a639 with SMTP id
 a1-20020a05683012c100b006bcde95a639mr12235515otq.16.1698712232452; Mon, 30
 Oct 2023 17:30:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:602:0:b0:4fa:bc5a:10a5 with HTTP; Mon, 30 Oct 2023
 17:30:31 -0700 (PDT)
In-Reply-To: <20231031112439.00d4eeab@canb.auug.org.au>
References: <20231031112439.00d4eeab@canb.auug.org.au>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 31 Oct 2023 09:30:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd91N1guM8c9eRtr3Me70k4bJy8xj6rh1Canb9D8i6CiPA@mail.gmail.com>
Message-ID: <CAKYAXd91N1guM8c9eRtr3Me70k4bJy8xj6rh1Canb9D8i6CiPA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the exfat tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jan Cincera <hcincera@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-31 9:24 GMT+09:00, Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi all,
Hi Stephen,
>
> Today's linux-next merge of the exfat tree got conflicts in:
>
>   fs/exfat/inode.c
>   fs/exfat/super.c
>
> between commit:
>
>   4c72a36edd54 ("exfat: convert to new timestamp accessors")
>
> from Linus' tree and commit:
>
>   d76271feecc1 ("exfat: add ioctls for accessing attributes")
>
> from the exfat tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I will fix it after rebase.

Thanks for your report.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc fs/exfat/inode.c
> index a2185e6f0548,edcd8a5c38d1..000000000000
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@@ -400,9 -397,9 +400,9 @@@ static int exfat_write_end(struct file
>   	if (err < len)
>   		exfat_write_failed(mapping, pos+len);
>
> - 	if (!(err < 0) && !(ei->attr & ATTR_ARCHIVE)) {
> + 	if (!(err < 0) && !(ei->attr & EXFAT_ATTR_ARCHIVE)) {
>  -		inode->i_mtime = inode_set_ctime_current(inode);
>  +		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> - 		ei->attr |= ATTR_ARCHIVE;
> + 		ei->attr |= EXFAT_ATTR_ARCHIVE;
>   		mark_inode_dirty(inode);
>   	}
>
> diff --cc fs/exfat/super.c
> index e919a68bf4a1,e7cba540c99e..000000000000
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@@ -369,9 -376,9 +376,9 @@@ static int exfat_read_root(struct inod
>   	ei->i_size_aligned = i_size_read(inode);
>   	ei->i_size_ondisk = i_size_read(inode);
>
> - 	exfat_save_attr(inode, ATTR_SUBDIR);
> + 	exfat_save_attr(inode, EXFAT_ATTR_SUBDIR);
>  -	inode->i_mtime = inode->i_atime = ei->i_crtime =
> inode_set_ctime_current(inode);
>  -	exfat_truncate_atime(&inode->i_atime);
>  +	ei->i_crtime = simple_inode_init_ts(inode);
>  +	exfat_truncate_inode_atime(inode);
>   	return 0;
>   }
>
>
