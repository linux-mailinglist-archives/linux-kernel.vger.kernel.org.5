Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88DB7798AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbjHKUlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjHKUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:41:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF685FD;
        Fri, 11 Aug 2023 13:41:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 579504A2;
        Fri, 11 Aug 2023 20:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 579504A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691786497; bh=/YYTBPBsvnnEDBqkt39NNerVI8DJxHWtMXm50CQP0WM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FwLNNBXfOjaEKXdOqXkrktj8Oo9ZqAIV9qkfIzbeoo51h9mJrHY2X7Senu5O2h3NO
         Y91Leax8n/ZLcPTPcif1VRn7KYsb0GGbLgXLJKnqpRq0UT7m+vFtZVc2v6kXfZV5Yo
         H7K98GTHZwk4xR9n9kZJVs2KthoWdSxryQTHet2fk5b3jH3fWyi7hvHa5PkYkluvcs
         96ohbSkJ/3DVr6+D04MlwPiMn1Gb6/hDLGUmn+MMmSbd7Xb84YZr2BhY2FBIi2aPyt
         /g7xs0a1ZRQA20wuFz8CcnltxMeIfZII9Lm6fqNHD1rhA31KHZgkMTD+EovBXfgqwm
         asM2BbPjrGk0w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res@email.cn>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: sparse: convert TW sparse.txt into sparse.rst
In-Reply-To: <20230811153554.84571-3-minhuadotchen@gmail.com>
References: <20230811153554.84571-1-minhuadotchen@gmail.com>
 <20230811153554.84571-3-minhuadotchen@gmail.com>
Date:   Fri, 11 Aug 2023 14:41:36 -0600
Message-ID: <87a5uxxqf3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Min-Hua Chen <minhuadotchen@gmail.com> writes:

> Follow Randy's advice [1] to move
> Documentation/translations/zh_TW/dev-tools/sparse.txt
> to
> Documentation/translations/zh_TW/dev-tools/sparse.rst
>
> [1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@inf=
radead.org/

So the right way to do this would be to simply say something like
"Convert sparse.txt to RST", then add a Suggested-by: tag to credit
Randy.=20

> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>  .../dev-tools/{sparse.txt =3D> sparse.rst}      | 31 ++++++-------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
>  rename Documentation/translations/zh_TW/dev-tools/{sparse.txt =3D> spars=
e.rst} (71%)

You're not adding this new document to a toctree anywhere; that will add
a warning and this file won't be a part of the docs build.

> diff --git a/Documentation/translations/zh_TW/dev-tools/sparse.txt b/Docu=
mentation/translations/zh_TW/dev-tools/sparse.rst
> similarity index 71%
> rename from Documentation/translations/zh_TW/dev-tools/sparse.txt
> rename to Documentation/translations/zh_TW/dev-tools/sparse.rst
> index 6d2d088b1060..2f632f6ce8e8 100644
> --- a/Documentation/translations/zh_TW/dev-tools/sparse.txt
> +++ b/Documentation/translations/zh_TW/dev-tools/sparse.rst
> @@ -1,33 +1,22 @@
> -=EF=BB=BFChinese translated version of Documentation/dev-tools/sparse.rst
> -
> -If you have any comment or update to the content, please contact the
> -original document maintainer directly.  However, if you have a problem
> -communicating in English you can also ask the Chinese maintainer for
> -help.  Contact the Chinese maintainer if this translation is outdated
> -or if there is a problem with the translation.
> +=EF=BB=BFCopyright 2004 Linus Torvalds
> +Copyright 2004 Pavel Machek <pavel@ucw.cz>
> +Copyright 2006 Bob Copeland <me@bobcopeland.com>
>=20=20
> -Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
> ----------------------------------------------------------------------
> -Documentation/dev-tools/sparse.rst =E7=9A=84=E7=B9=81=E9=AB=94=E4=B8=AD=
=E6=96=87=E7=BF=BB=E8=AD=AF
> +.. include:: ../disclaimer-zh_TW.rst
>=20=20
> -=E5=A6=82=E6=9E=9C=E6=83=B3=E8=A9=95=E8=AB=96=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=85=A7=E5=AE=B9=EF=BC=8C=E8=AB=8B=E7=9B=B4=E6=
=8E=A5=E8=81=AF=E7=B9=AB=E5=8E=9F=E6=96=87=E6=AA=94=E7=9A=84=E7=B6=AD=E8=AD=
=B7=E8=80=85=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=E4=BD=BF=E7=94=A8=E8=8B=B1=
=E6=96=87
> -=E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=9B=A3=E7=9A=84=E8=A9=B1=EF=BC=8C=
=E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=90=91=E7=B9=81=E9=AB=94=E4=B8=AD=E6=96=87=E7=
=89=88=E7=B6=AD=E8=AD=B7=E8=80=85=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=
=9C=E6=9C=AC=E7=BF=BB=E8=AD=AF=E6=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=99=82=
=E6=88=96
> -=E8=80=85=E7=BF=BB=E8=AD=AF=E5=AD=98=E5=9C=A8=E5=95=8F=E9=A1=8C=EF=BC=8C=
=E8=AB=8B=E8=81=AF=E7=B9=AB=E7=B9=81=E9=AB=94=E4=B8=AD=E6=96=87=E7=89=88=E7=
=B6=AD=E8=AD=B7=E8=80=85=E3=80=82
> +:Original: Documentation/dev-tools/sparse.rst
>=20=20
> -=E7=B9=81=E9=AB=94=E4=B8=AD=E6=96=87=E7=89=88=E7=B6=AD=E8=AD=B7=E8=80=85=
=EF=BC=9A =E8=83=A1=E7=9A=93=E6=96=87 Hu Haowen <src.res@email.cn>
> -=E7=B9=81=E9=AB=94=E4=B8=AD=E6=96=87=E7=89=88=E7=BF=BB=E8=AD=AF=E8=80=85=
=EF=BC=9A =E8=83=A1=E7=9A=93=E6=96=87 Hu Haowen <src.res@email.cn>
> +:=E7=BF=BB=E8=AD=AF:

So you are removing a fair amount of text here, much of which I cannot
read.  Why are you doing that?  In any case, that would appear to be a
change that is independent of the format conversion, and should thus be
in its own patch.

Thanks,

jon
