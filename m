Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23E7B6E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbjJCQ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJCQ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:26:52 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB43A7;
        Tue,  3 Oct 2023 09:26:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC98F381;
        Tue,  3 Oct 2023 16:26:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC98F381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696350409; bh=IBvkFHuLs7Wi6TX96w1SnUqNKL/17QZjl0LUq5B4kms=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vxke7ieBPJjkhK5TTGXr+rNB+2CrNKv83G2iPVXMj/uX1/OwkyZaeRHI9VYiFW1yB
         ZMAJsqidKcvzTKPmUq3B3qBAtY2NI5CxckPvQn5BGxNpdef6ModwWyBHAraMz6//B/
         Cp7K7RSQKVvU24wLcSC8/JAv3cMExwXV0Wv0mpIOdbXwDfpDaVGNG87yLJyw/ZKyXf
         fC6d9HCSwvGPvBmcBkHqNvsndcu3Xq+i2IZ110zOn9vx+tLHwB8aC2atbhK/p/UY/N
         jaDVJClmVxcBZqvSD/16O91jAqsAzirrgeieSnoZ34mf2HEUO+1x64z/J4zpT4wxJn
         KJIPVyLbYra/g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res@email.cn>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: Re: [PATCH v3 0/3] convert TW translation sparse.txt to RST
In-Reply-To: <20230902052512.12184-1-minhuadotchen@gmail.com>
References: <20230902052512.12184-1-minhuadotchen@gmail.com>
Date:   Tue, 03 Oct 2023 10:26:48 -0600
Message-ID: <8734yrekon.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Min-Hua Chen <minhuadotchen@gmail.com> writes:

> These patches move TW sparse.txt to TW dev-tools and
> convert TW sparse.txt to RST, based on [1].
> Add the RST to toctree [2].
>
> Randy said [1]:
> "
> it would be good if someone would update/modify this
> sparse.txt file to be in Documentation/translation/zh_TW/dev-tools/
> and convert it to sparse.rst (IMO).
> "
>
> [1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@inf=
radead.org/
> [2] https://lore.kernel.org/lkml/87a5uxxqf3.fsf@meer.lwn.net/
>
>
>
> Min-Hua Chen (3):
>   docs: sparse: move TW sparse.txt to TW dev-tools
>   docs: sparse: convert sparse.txt to RST
>   docs: sparse: add sparse.rst to toctree
>
>  .../translations/zh_TW/dev-tools/index.rst    | 40 +++++++++++++++++++
>  .../{sparse.txt =3D> dev-tools/sparse.rst}      |  2 +-
>  Documentation/translations/zh_TW/index.rst    |  2 +-
>  3 files changed, 42 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/translations/zh_TW/dev-tools/index.rst
>  rename Documentation/translations/zh_TW/{sparse.txt =3D> dev-tools/spars=
e.rst} (99%)

So this series introduces a new warning:

WARNING: Unparseable C cross-reference: 'int'
Invalid C declaration: Expected identifier in nested name, got keyword: int=
 [error at 3]
  int
  ---^

That is ... somewhat unhelpful.  I eventually tracked it down to this
piece in sparse.rst:

> =E6=89=80=E4=BB=A5=E6=9B=B4=E7=B0=A1=E5=96=AE=E7=9A=84=E8=BE=A6=E6=B3=95=
=E5=8F=AA=E8=A6=81=E9=80=99=E6=A8=A3=E5=81=9A=EF=BC=9A
>=20
> 	typedef int __bitwise pm_request_t;
>=20
> 	#define PM_SUSPEND ((__force pm_request_t) 1)
> 	#define PM_RESUME ((__force pm_request_t) 2)
>=20
> =E7=8F=BE=E5=9C=A8=E4=BD=A0=E5=B0=B1=E6=9C=89=E4=BA=86=E5=9A=B4=E6=A0=BC=
=E7=9A=84=E9=A1=9E=E5=9E=8B=E6=AA=A2=E6=9F=A5=E6=89=80=E9=9C=80=E8=A6=81=E7=
=9A=84=E6=89=80=E6=9C=89=E5=9F=BA=E7=A4=8E=E6=9E=B6=E6=A7=8B=E3=80=82

That needs to be a literal block to be parsed properly.  I have taken
the liberty of changing the first line above to:

> =E6=89=80=E4=BB=A5=E6=9B=B4=E7=B0=A1=E5=96=AE=E7=9A=84=E8=BE=A6=E6=B3=95=
=E5=8F=AA=E8=A6=81=E9=80=99=E6=A8=A3=E5=81=9A::

...and the warning is gone.

Thus: series applied, but please properly build-test changes like this
in the future.

Thanks,

jon
