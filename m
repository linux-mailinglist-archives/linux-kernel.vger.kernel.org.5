Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3780578B6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjH1SDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjH1SDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082C10D;
        Mon, 28 Aug 2023 11:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 164B863B78;
        Mon, 28 Aug 2023 18:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61393C433C8;
        Mon, 28 Aug 2023 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693245817;
        bh=fD0aEQmXcmctWDnpYL4vRvHCqYkAfJIMUPSSSlGyof0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZ1d5azlTAXaMimAqoSzlFNu6PhGzlI/X9NBULyTb01WmvJ1beGAoFyBvQVrdZOcJ
         pAlSduRhW0LR5FD3v4PZyaHFd8iudEWOT7F+oMrC5xVDuk6BEaa1kyrDB3a9XtDvLR
         58TT7uca/GOutciavzn2XjmQAJZP0eWBgm3rTaO4ObL+6r4d8tMoU5oZzdKxf0lBDi
         wiz/yOBAbMkjq8LbCuif/A+5RitNdKCpyVsr2/yIX93X/50vncf5UgccuvwPd86mEM
         Se6gYb1VHh89thyqOsRWK1QjtCHHM1eao11LjM/KBVdjeFX6IcSG5NhIADpOJr06sJ
         Gi2MzIgBdIFbg==
Date:   Mon, 28 Aug 2023 19:03:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Ramona Bolboaca <ramona.bolboaca@analog.com>, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Add new channels for adis16475
Message-ID: <20230828190359.4d4ceb6d@jic23-huawei>
In-Reply-To: <2505544e4b5fdd5280b3f8406b223cebae6086df.camel@gmail.com>
References: <20230808075059.645525-1-ramona.bolboaca@analog.com>
        <2505544e4b5fdd5280b3f8406b223cebae6086df.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 15:16:10 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2023-08-08 at 10:50 +0300, Ramona Bolboaca wrote:
> > changes in v5:
> > =C2=A0 patch 1: added documentation for all supported attributes
> > =C2=A0 patch 2: added documentation for all supported attributes
> > =C2=A0 patch 3: no changes
> >=20
> > Ramona Bolboaca (3):
> > =C2=A0 iio: Add IIO_DELTA_ANGL channel type
> > =C2=A0 iio: Add IIO_DELTA_VELOCITY channel type
> > =C2=A0 iio: imu: adis16475.c: Add delta angle and delta velocity channe=
ls
> >=20
> > =C2=A0Documentation/ABI/testing/sysfs-bus-iio |=C2=A0 45 +++++++
> > =C2=A0drivers/iio/imu/adis16475.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 165 +++++++++++++++++++++---
> > =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A05 files changed, 199 insertions(+), 19 deletions(-)
> >  =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20

Series applied to the togreg branch of iio.git but given timing I plan
to rebase that on rc1. In the meantime I'll push this out as testing to
let 0-day see if it can find anything we missed.

Thanks for persisting the fiddly ABI definitions in this one!

Jonathan
