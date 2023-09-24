Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2577AC99B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjIXNe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjIXNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:34:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8325BB2;
        Sun, 24 Sep 2023 06:31:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FAAC433C8;
        Sun, 24 Sep 2023 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695562294;
        bh=KveCRAs1LoJni9u7gqSBDeeyR594fRjMZ0VKUh3HuTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tvP/kyHVcBgDcIb1swnDJNE/fOz7HjVcg/pB+d/7wJfGLwogawl5gglPb4O+t/798
         cy5TCM0kdkfEJKp4ncOcPZ2TI+6D8Lyuzg34ccTRTvnGeUl+4BLke3O74PUss/8cAU
         fFJhpsQd91VPeDPeTtHcv6A8SC9OLFh0Bl56HC2RPFzOG4ee9fms3MVIZ/8psUpElR
         OtbgcZ+cDBs2JSqprUH3H4AuvJvqLdmaSHVGCiqCIUibseaAHiXcN8wQufI5Y+tdWd
         5hpdvUbA/7IsjXF3pNiei/MjVtjRnKEXFP6uEhtdl4Uj6nESVfn1wldRQWJzccLecb
         NskgZwpbX9ICw==
Date:   Sun, 24 Sep 2023 14:31:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
Message-ID: <20230924143126.60a142c4@jic23-huawei>
In-Reply-To: <CAM+2Eu+R6M7U+t4z5K0Cty736ybAzis7xnrT1edk4-y6B=JAOA@mail.gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-2-jagathjog1996@gmail.com>
        <b27b58d9-9e55-b803-dd61-dd86a78e7c5c@linaro.org>
        <CAM+2Eu+R6M7U+t4z5K0Cty736ybAzis7xnrT1edk4-y6B=JAOA@mail.gmail.com>
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

On Tue, 19 Sep 2023 22:14:40 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Krzysztof,
>=20
> On Mon, Sep 18, 2023 at 5:55=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 18/09/2023 10:03, Jagath Jog J wrote: =20
> > > Add devicetree description document for Bosch BMI323, a 6-Axis IMU. =
=20
> >
> > I don't know why this is RFC and cover letter does not explain it. Shall
> > I just ignore it? Patch is no ready? Recently at least two times someone
> > was disappointed that his code marked as RFC received my review. =20
>=20
> Thank you for reviewing. This was the sensor's first patch series,
> so I initially submitted it as an RFC. I will mark it as "Patch"
> in the next series.

Have more confidence!  RFCs need to have clearly stated questions.
If you don't have any then you are putting forwards driver for review
in ordering to get it merged upstream - so PATCH is appropriate.
As you'll see many IIO drivers go through a 'few' revisions once they
are posted (hopefully not too many!)

Krzysztof is great at reviewing whatever shows up, but in many
cases reviewers won't look at an RFC (unless a big discussion starts) becau=
se
they aren't interested in open questions, just code that the author conside=
rs
ready.

Jonathan
