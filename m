Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0727D59E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjJXRp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:45:53 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C20133;
        Tue, 24 Oct 2023 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1698169547; x=1698428747;
        bh=HHciNy/AbfyXudhfNKmKsZ25qvRkcAc7dw1aJ5aSv7I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=qmbzoAH5CdPB4IIlR00Gcfs4zMM6zlybEScBkoyZAKc7USQS6V5k5TC6CLMrwq0ib
         QQ3RpVGfQD377Xyp5SCGl5Gz1O1qAk66xbSmzQghbBN1pEoLwK+IMDVIId+0vBvEU2
         HEcYgH/yS3xZv88m2O+Gl72kqWbdbDjLlPbA7u+v05uJLQNzaKT1el749XLtZVHbo+
         nwPuiHgWglFiHIYufX8zYkv5iTTDY4kMHP0qgZe60nK2mp5/mHn/nqWAIPCeFWEAQN
         fzmi4SvZei0ZhLHITU0EzxKNSldCHPk9i19rP8OWWpwRGCDvLF+zZeNor9Y/3fvPuK
         AAVhmNkCrcVsg==
Date:   Tue, 24 Oct 2023 17:45:43 +0000
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     linux-sh@vger.kernel.org, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Lafreniere <peter@n8pjl.ca>
Subject: Re: [PATCH 3/7] arch: sh: remove ReiserFS from defconfig
Message-ID: <4hN-jE1ySe2eSmIJ6qWQKPQtp9vdgV2x0ek_nz20azJUyv5FLi5gioHV8YnJHTHHwZKvjSkvnPBhzmFJ2gQIeNnmaRA3cJ_GyhDqz2SJJkw=@n8pjl.ca>
In-Reply-To: <ee30c656c3e3b027edcfa4bc2947cea192f5cd2d.camel@physik.fu-berlin.de>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918175529.19011-4-peter@n8pjl.ca> <ee30c656c3e3b027edcfa4bc2947cea192f5cd2d.camel@physik.fu-berlin.de>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:46, John Paul Adrian Glaubitz wrote:
> Hi Peter!
>=20
> On Mon, 2023-09-18 at 17:56 +0000, Peter Lafreniere wrote:
>=20
> > ReiserFS has been deprecated for a year and a half, yet is still built
> > as part of a defconfig kernel.
> >=20
> > According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
> > filesystem is slated to be removed in 2025. Remove it from the defconfi=
g
> > profiles now, as part of its deprecation process.
> >=20
> > Signed-off-by: Peter Lafreniere peter@n8pjl.ca
> > ---
> > arch/sh/configs/landisk_defconfig | 1 -
> > arch/sh/configs/titan_defconfig | 1 -
> > 2 files changed, 2 deletions(-)
> >=20
> > diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landis=
k_defconfig
> > index 541082090918..af1ab25227e3 100644
> > --- a/arch/sh/configs/landisk_defconfig
> > +++ b/arch/sh/configs/landisk_defconfig
> > @@ -94,7 +94,6 @@ CONFIG_USB_SISUSBVGA=3Dm
> > CONFIG_EXT2_FS=3Dy
> > CONFIG_EXT3_FS=3Dy
> > # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> > -CONFIG_REISERFS_FS=3Dy
> > CONFIG_ISO9660_FS=3Dm
> > CONFIG_MSDOS_FS=3Dy
> > CONFIG_VFAT_FS=3Dy
> > diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_de=
fconfig
> > index 871092753591..50e378adc4c5 100644
> > --- a/arch/sh/configs/titan_defconfig
> > +++ b/arch/sh/configs/titan_defconfig
> > @@ -221,7 +221,6 @@ CONFIG_EXT2_FS=3Dy
> > CONFIG_EXT3_FS=3Dy
> > # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> > # CONFIG_EXT3_FS_XATTR is not set
> > -CONFIG_REISERFS_FS=3Dm
> > CONFIG_XFS_FS=3Dm
> > CONFIG_FUSE_FS=3Dm
> > CONFIG_ISO9660_FS=3Dm
>=20
>=20
> What has been the feedback so far on this? Do most maintainer remove it o=
r not?

AFAICT, it's been picked up by mips and powerpc. I thought that it got pick=
ed up by UML too,
but I can't find any signs of that actually happening.

>=20
> I don't have a strong opinion on this, but I tend to keep it in defconfig=
 until
> ReiserFS has been completely removed from the kernel.

Is convenience more important than a slim defconfig? I don't think it is in=
 this case,
but Geert (for example) thinks it is. In the end the fs will be gone for go=
od, and
none of this will really have mattered.

>=20
> Adrian

Cheers,
Peter

