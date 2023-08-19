Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CE78175C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 06:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjHSEgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 00:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjHSEfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 00:35:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8F4211;
        Fri, 18 Aug 2023 21:35:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so23708751fa.3;
        Fri, 18 Aug 2023 21:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692419749; x=1693024549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9RDO+mu4zOwSEJ716yo61Qz/xnDxFXm4Etyq0Z0RWE=;
        b=R4WVLmz85gXbiZSANPHdMu3UK92btPoCkKlfVsdjxVVHj6uivXpvlPi5UT3us0hoOX
         MBVKgDBpK+nW/qskN1URjcKwyFtND6PwzOWxXIHDu1qxQEMRq5Pjdf15bbw3CF5GSENN
         cIc24CNROHF3jUvsO/ec03liqyq/xlomEoxULxBkzQASEgT7mywYpkmE5/aSRaE01iY+
         LJ6gOl+qipqLVYfQLrQcYz2mGM5fxUjPNlmwRzRFB9Yf3OVkS9bHsvhPI4ge+bHmhzDJ
         vbQIr9AZK5y2jZbuO9EIYwTvilo4YDGi/eSDf/anSKRqF3PlnH3KS5VqXitqdXQpJ12S
         XFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692419749; x=1693024549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9RDO+mu4zOwSEJ716yo61Qz/xnDxFXm4Etyq0Z0RWE=;
        b=cNqXh91ChG0V9f8ZiDC0ed8OIXKf6pUj1iGyTFVnqcetUacKH8dnmP9skULinkPOt7
         jzA1xNaFePG2cUBsi4uSjcirXwo4NsqMI7J4gkI/P7xDq6GF3DS5sQiunl4MzOSrBREM
         XQZY9dRI/ZZjRIC8zjsR99AhWZr4vnQBew+mAcekdf1IbYMN8XirnkqQ4/1H4P7jpX6A
         6xVL8mBVnZby4T5S6BjkSwSyV6E3p3yFqqKmbwlJFFb4M29/KTXgJU4ZFVOiUp5tNDUS
         XkXjPhPlfYZsgdg/80lV4nlSRzNhaI4m0x4w1QwAOr+whXVrVwy8yCAY+ksvSHIakKcU
         piFQ==
X-Gm-Message-State: AOJu0YyGHdvsq61RdbsMhXZVeqWD+xWbA3RGz+98UbOLITkSfZeHyb1Q
        AQybsemTcQd5PijA+Hc95Y47o/fXns3iPSr7Pjs=
X-Google-Smtp-Source: AGHT+IF8OAfn7lkBb+InQvpKMkIb+K37Z90E3TnGBaNlzHc4x7WwpS2lzxlJ6a5y0qpTlajnEBSjEwvtr99f082U4GY=
X-Received: by 2002:a2e:a309:0:b0:2b5:68ad:291f with SMTP id
 l9-20020a2ea309000000b002b568ad291fmr777624lje.19.1692419748974; Fri, 18 Aug
 2023 21:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230817002232.80079-1-linux@treblig.org>
In-Reply-To: <20230817002232.80079-1-linux@treblig.org>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 18 Aug 2023 23:35:37 -0500
Message-ID: <CAH2r5mtQCJZj7THQ7Kenx5sRS9frQNsJ7qkG0eKKy31JPcxiPQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] dedupe smb unicode files
To:     linux@treblig.org
Cc:     dave.kleikamp@oracle.com, tom@talpey.com, pc@manguebit.com,
        linkinjeon@kernel.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        krisman@collabora.com, "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tentatively merged to cifs-2.6.git for-next pending additional testing

Let me know if anyone wants to add RB or Acked-by to any of these or
spots any issues

On Wed, Aug 16, 2023 at 7:22=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> The smb client and server code have (mostly) duplicated code
> for unicode manipulation, in particular upper case handling.
>
> Flatten this lot into shared code.
>
> There's some code that's slightly different between the two, and
> I've not attempted to share that - this should be strictly a no
> behaviour change set.
>
> In addition, the same tables and code are shared in jfs, however
> there's very little testing available for the unicode in there,
> so just share the raw data tables.
>
> I suspect there's more UCS-2 code that can be shared, in the NLS code
> and in the UCS-2 code used by the EFI interfaces.
>
> Lightly tested with a module and a monolithic build, and just mounting
> itself.
>
> This dupe was found using PMD:
>   https://pmd.github.io/pmd/pmd_userdocs_cpd.html
>
> Dave
>
> Version 5
>   Add some (wchar_t *) casts to keep sparse
>   happy, as spotted by kernel test robot
>
> Dr. David Alan Gilbert (4):
>   fs/smb: Remove unicode 'lower' tables
>   fs/smb: Swing unicode common code from smb->NLS
>   fs/smb/client: Use common code in client
>   fs/jfs: Use common ucs2 upper case table
>
>  fs/jfs/Kconfig                                |   1 +
>  fs/jfs/Makefile                               |   2 +-
>  fs/jfs/jfs_unicode.h                          |  17 +-
>  fs/jfs/jfs_uniupr.c                           | 121 -------
>  fs/nls/Kconfig                                |   8 +
>  fs/nls/Makefile                               |   1 +
>  fs/nls/nls_ucs2_data.h                        |  15 +
>  .../server/uniupr.h =3D> nls/nls_ucs2_utils.c}  | 156 +--------
>  fs/nls/nls_ucs2_utils.h                       | 285 +++++++++++++++
>  fs/smb/client/Kconfig                         |   1 +
>  fs/smb/client/cifs_unicode.c                  |   1 -
>  fs/smb/client/cifs_unicode.h                  | 330 +-----------------
>  fs/smb/client/cifs_uniupr.h                   | 239 -------------
>  fs/smb/client/smb2pdu.c                       |   4 +-
>  fs/smb/server/Kconfig                         |   1 +
>  fs/smb/server/unicode.c                       |   1 -
>  fs/smb/server/unicode.h                       | 325 +----------------
>  17 files changed, 342 insertions(+), 1166 deletions(-)
>  delete mode 100644 fs/jfs/jfs_uniupr.c
>  create mode 100644 fs/nls/nls_ucs2_data.h
>  rename fs/{smb/server/uniupr.h =3D> nls/nls_ucs2_utils.c} (50%)
>  create mode 100644 fs/nls/nls_ucs2_utils.h
>  delete mode 100644 fs/smb/client/cifs_uniupr.h
>
> --
> 2.41.0
>


--=20
Thanks,

Steve
