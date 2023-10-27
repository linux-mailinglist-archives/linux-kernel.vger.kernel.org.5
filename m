Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0E7D99D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbjJ0NaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbjJ0NaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:30:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9718F;
        Fri, 27 Oct 2023 06:30:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93F8C433C9;
        Fri, 27 Oct 2023 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698413412;
        bh=WhLHybGvjXg6KH83VHDPsIL/bPZh52vmPBOUFL8UsHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G/BKEHw8qA2TK0n5/ruuZBbJ39DIAXA/pZJGtcKodXPkNfp8T8woPEed/iVvjuxD2
         uSdWJ7Ee8yA6kBr7f33+5hBjsF2JXMcIbcEbqlcOF15fRwHFflunwNLvPPIrf4KlpW
         8V0oh4uITqpT2sD+O3FybSwgjCWK62cUrpRrx1Yn16PezmPdr3Ry3aOo+nCHtIjjMJ
         qIp2r2Dt+xI7svCU8jGGcyrKrCiQubkbgVfMgveEDuHXx5I4NEG37d3o6zja2vPeUe
         vwArUo0kZDtjdXVdrbQLH7dVEORrFZbJvbxT0TYsKEfdwJuAt3s2Xm7Tfh1g3mM4t6
         xO9knVzOskiMg==
Date:   Fri, 27 Oct 2023 14:30:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: correct file entry in BOSCH SENSORTEC
 BMI323 IMU IIO DRIVER
Message-ID: <20231027143010.2d49c82d@jic23-huawei>
In-Reply-To: <CAM+2Eu+yjguvkZLzAw6u+Y3PxT5JDuOEWtJSfv-U-C5mdmvL+Q@mail.gmail.com>
References: <20231025091550.21052-1-lukas.bulwahn@gmail.com>
        <CAM+2Eu+yjguvkZLzAw6u+Y3PxT5JDuOEWtJSfv-U-C5mdmvL+Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 01:19:51 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> On Wed, Oct 25, 2023 at 2:45=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmai=
l.com> wrote:
> >
> > Commit b512c767e7bc ("iio: imu: Add driver for BMI323 IMU") adds the
> > MAINTAINERS section BOSCH SENSORTEC BMI323 IMU IIO DRIVER and refers to=
 a
> > non-existing device-tree file.
> >
> > Probably, this mistake was introduced by copying from the BOSCH SENSORT=
EC
> > BMA400 ACCELEROMETER IIO DRIVER section and missing to adjust the file
> > entry properly. This is however easily caught, as the script
> > ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about a br=
oken
> > reference.
> >
> > The related commit 77583938740e ("dt-bindings: iio: imu: Add Bosch BMI3=
23")
> > adds bosch,bmi323.yaml, so refer to that intended file instead. =20
>=20
> My apologies for the silly mistake, and thank you for fixing it.
> Reviewed-by: Jagath Jog J <jagathjog1996@gmail.com>
>=20
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

