Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBEC768139
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjG2TJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjG2TJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:09:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211E2696
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:09:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686efa1804eso2362145b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1690657790; x=1691262590;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQVKecxzaLTrR3Ye1xYfH6ooI3nAezhojIch+SfrkzU=;
        b=CQUgVi+d6HSVGlR5roN/0RlP7797ndqR6cxnL06/IM+phCkvixdNa14FOiEEYLcdyo
         zVUYhrTuymyldzR6R7IRx+83MJk3GqD/X9VA3C9uyryXnQBhPg+x3Tn7RBHRhFAc8Dp9
         162elLlPSOEs5FS3qY5HWCSRhTvV2RbH8yn1frwQJ+GFQIkp3RyCzb3G4SL6ofS8Sy8Z
         xSSXLEnaeHdoPDShNGQmzqeJ0dpmr9H8SXjz90Hmg8aWBVWb1VFUNjiqpM2l+2cK3vcD
         N/vGy3ftC1GQ8Qq/B6KOx42N2HheFeeKACrKDF6IMT3cEfL2hZUljX80PVJ9Uv39Mqnp
         WljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657790; x=1691262590;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQVKecxzaLTrR3Ye1xYfH6ooI3nAezhojIch+SfrkzU=;
        b=gNLtznQ/VuUwMrWKsVwhHyx9KarVeOTBC/y7KDPQU11VsBb4C7rEj5qYmDu2DqOZes
         o3UVPOYwHl/syiN8LFwPf0UUYsvcnr0HUU8ZrYhnzlMHRm+IJGrdjCeYl2fd4e9fCITR
         uxA+zMGuj7YV/y13rZkBWKYATNBUiUytr9SUWEZ4t/9UnHQWeMYJJTb8Tq8/Oo6SxVLq
         ceJ4aWL3cNFCkalN2WJBKgg0SDXKEpIveDyNOAtcNy6IGJtk4Ub4LtimpmD1ZWM5JoiG
         vlimmA0R/zyKoYAVXxyYUd9xVfT4+Htc8172eYrw5dFXtMtD24YYeB4rveiYESlQUMdY
         gA+w==
X-Gm-Message-State: ABy/qLb+W3YGc4imULwhzmaaTI83Cq/KEqoGla4NszNW3uT03fvuFb9S
        68GCgRY7RSOtLR0n/EJCSHk35Q1l6WvO2yaueso=
X-Google-Smtp-Source: APBJJlF4hlTB4xSrBbtSNP/nSEg8xMlW1jQtc40MNVrEWg7D4e4WqeUyKSs/xQQzaizwqHyefmCDyg==
X-Received: by 2002:a05:6a21:4988:b0:12d:f1ac:e2cd with SMTP id ax8-20020a056a21498800b0012df1ace2cdmr5192198pzc.32.1690657789895;
        Sat, 29 Jul 2023 12:09:49 -0700 (PDT)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x18-20020aa793b2000000b0067a50223e3bsm5000483pff.111.2023.07.29.12.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 12:09:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ext4: Fix rec_len verify error
Date:   Sat, 29 Jul 2023 13:09:38 -0600
Message-Id: <8B200C7E-F6D1-4395-9776-4B521319CD8F@dilger.ca>
References: <20230729061357.1702891-1-zhangshida@kylinos.cn>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
In-Reply-To: <20230729061357.1702891-1-zhangshida@kylinos.cn>
To:     zhangshida <starzhangzsd@gmail.com>
X-Mailer: iPhone Mail (20F75)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 29, 2023, at 00:14, zhangshida <starzhangzsd@gmail.com> wrote:
>=20
> =EF=BB=BFFrom: Shida Zhang <zhangshida@kylinos.cn>
>=20
> with the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 millon files were directly created
> under a directory:
>=20
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: d=
ir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxx=
x: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxx=
xx: Directory index failed checksum
>=20
> when enough files are created, the fake_dirent->reclen will be 0xffff.
> it doesn't equal to blocksize 65536, i.e. 0x10000.
>=20
> But it is not the same condition when blocksize equals to 4k.
> when enough files are created, the fake_dirent->reclen will be 0x1000.
> it equals to blocksize 4k, i.e. 0x1000.
>=20
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k. To address this, a special condition
> was introduced to handle it properly.
>=20
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
> fs/ext4/namei.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..a422cff25216 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -458,6 +458,9 @@ static struct dx_countlimit *get_dx_countlimit(struct i=
node *inode,
>            root->info_length !=3D sizeof(struct dx_root_info))
>            return NULL;
>        count_offset =3D 32;
> +    } else if ((EXT4_BLOCK_SIZE(inode->i_sb) =3D=3D 65536)
> +        && (le16_to_cpu(dirent->rec_len) =3D=3D 65535)) {
> +        count_offset =3D 8;

This should be moved up to the first if-block that is checking the block siz=
e:=20

=00=00=00=00=00=00=00=00        if (le16_to_cpu(dirent->rec_len) =3D=3D EXT4=
_BLOCK_SIZE(inode->i_sb) ||
             (le16_to_cpu(dirent->rec_len) =3D=3D 65535 &&
              EXT4_BLOCK_SIZE(inode->i_sb) >=3D 65536))
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00                count_offset=
 =3D 8;

since this is really the same case.=20

Ecen better would be to use ext4_rec_len_from_disk() to check the
length so that it keeps this large PAGE_SIZE logic in one place, and
does not add overhead on systems with smaller PAGE_SIZE:

        int blocksize =3D EXT4_BLOCK_SIZE(inode->i_sb);

        if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) =3D=3D blocks=
ize)
                count_offset =3D 8;

Cheers, Andreas

>    } else
>        return NULL;
>=20
> --=20
> 2.27.0
>=20
