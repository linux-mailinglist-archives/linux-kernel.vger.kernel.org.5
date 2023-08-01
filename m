Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21476BBFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHASKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHASKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14A10E;
        Tue,  1 Aug 2023 11:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80FA6166F;
        Tue,  1 Aug 2023 18:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53358C433C8;
        Tue,  1 Aug 2023 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690913435;
        bh=k+dw7L8vyhlKn9VUzSf3b0oQlhLBaS6C3SxWnN9fOtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CYBT9DHsBKKt9Bi/j8BCn+CAiaCy7IlCYCqH9uG+v13meObZ99nkdddt8wMex3qH7
         YHKoGShoUTU/K8cNCDrigmfM4AAZwh346CH/bF1Uv21pSo+t9oM/pfqqFVNcacKilT
         wKuJsr3d2qUSLoZoHXrCkMS6JM2zWRUUeq5h+6xY9eDIb1gJeo3r0L9KCO8WqOoqOo
         z2d08kkwlGECnUiwWBN1/vfiIC8x26d7vwGAgEw7sB5WS4lSyXhmpSBkugV3+9vrdK
         dyd8JkyZLhgDf5TmzU0mdtd8h4X6/4A6IJ3+xAlLYSXYVqRak/B3RofT+jeCg+tcXA
         6aMYt/R6Vq7gw==
Date:   Tue, 1 Aug 2023 19:10:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Svyatoslav Ryhel" <clamor95@gmail.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Samu Onkalo" <samu.p.onkalo@nokia.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] misc: adps990x: convert to OF
Message-ID: <20230801191026.02512438@jic23-huawei>
In-Reply-To: <c7526061-2f4e-4843-825c-98d9494af625@app.fastmail.com>
References: <20230731110239.107086-1-clamor95@gmail.com>
        <20230731110239.107086-3-clamor95@gmail.com>
        <a16db5ac-2b9a-45ab-b693-2f459d689c7d@app.fastmail.com>
        <7C51AA15-DEBE-486B-9788-F84B260F8880@gmail.com>
        <c7526061-2f4e-4843-825c-98d9494af625@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:38:59 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jul 31, 2023, at 16:58, Svyatoslav Ryhel wrote:
> > 31 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80. 16:18:16 GMT+03:00, Arnd=
 Bergmann <arnd@arndb.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=
=BB=D0=B0): =20
> >>On Mon, Jul 31, 2023, at 13:02, Svyatoslav Ryhel wrote: =20
> >>> Add ability to use device tree bindings keeping existing setup. =20
> >>
> >>I see that there are no more in-tree users of the old
> >>apds990x_platform_data, so I think it would be best to completely
> >>remove that codepath and merge that structure into struct
> >>apds990x_chip, to simplify the probing and avoid the extra
> >>allocation. =20
> >
> > Thank you very much for your review, but is it mandatory to drop pdata=
=20
> > in this particular patch set? To be honest this driver needs serious=20
> > upgrades and refactoring, and I have no dedication to invest my time=20
> > into refactoring it, moreover, I am not a maintainer of this driver,=20
> > nor a full time kernel maintainer of any kind. I am doing what I am=20
> > doing only because one of my devices uses this als but it is not=20
> > something crucial. =20
>=20
> We have a lot of drivers that are lacking the cleanup I'm asking
> for, so I don't think I'd mandate it at this point, but I don't
> actually expect the patch to be any more complicated in the end,
> so just try it out.
>=20
> I think at the minimum, please remove the include/platform_data
> header and move the contents into the driver itself, I'd be fine
> with that. If you can easily do further cleanup by dropping
> the separate allocation and folding the apds990x_fw_probe()
> function back into apds990x_probe(), please do that, just stop
> at the point where you feel it gets too complicated.
>=20

It's a long shot, but this looks pretty close in register map to
the apds9960 in IIO.

Maybe try adding the ID to that driver and cross your fingers?

There is some stuff going on around the register address / commands
that I haven't figured out but it looks similar for the byte access
path and that may be all the IIO driver is using.

If you are fine testing, it's possible someone else might do the
leg work (if me I'll emulate just enough to convince myself I didn't
break it too badly). Won't be high on my list, but maybe I'll get
a boring wet weekend sometime...

Jonathan

>     Arnd

