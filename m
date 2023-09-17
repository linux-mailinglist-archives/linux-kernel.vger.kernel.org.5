Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE257A3B02
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbjIQULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbjIQULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 16:11:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B3F1;
        Sun, 17 Sep 2023 13:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694981485; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XcsXwrMZJ4WmkGraLw8tnCxf93iR/28w9SR7c7+HCSiww3BEdBHCUP3YOLbtvM9Tib
    IECw3WuoXOiu0Da/PESnntJmYoIDWA/486YGzzbDDDYsyaj8Vg/gyFLopaPw0Lu0XhBZ
    p46NBsyQJaEXrDiJsCUKDal7z/eKDlmoQTxvXp28xjWKcitYcVHg+5T8CrgGHtadXFAJ
    xWS/SvFNrS+SY8YAgGHKvghLZxHh47JdU5thxAWzhT8RNf0/NWDjBS/X8eSHe/rTJPlo
    aArkMzjRP1vmmxbAG1To1c+lQiQLVcaVEQ3mfAU6Sp5plhS0wOlcF5nRpeMsyeEvsNDl
    bwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694981485;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zGxppwIRX0Tl3MeLWQbRI04qLkWaOFo5HeDhjvTY4G0=;
    b=Ef0il6xRoac5wEKvL9zmOYkxhdTxsKQxlUA0odQNLvrDgFSRcocAHvMbbQABCLHJs2
    AIrENww6hzKbF5a2t+lEIUBuqrWSzIHBcvG0CmvYHIst7cFFkLddbB3E2LAXyV7HX6Si
    OZIVACXZFsce8I97+aMDt/3fYk5QcmXvcy0k+9cIeEn1T4IsZDZw0QvE08HjlNnKkbr2
    eeZlH0HUGRLGLVXkS1hbbBFg0cNhqAwRtsleq8UdEbgQpmtu8lgB4f/xCImZRYOiujPE
    PtkeG97lkd+ua1ar+0lOGBOVcv2YoPN01LRvra5U8lUES9P2iM2pLJzCCGtsL/2es9Zd
    He3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694981484;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zGxppwIRX0Tl3MeLWQbRI04qLkWaOFo5HeDhjvTY4G0=;
    b=OSnuotJG+MwgZLx8mfpTzwjApvKCScN0Nv4W7AJGdKKCieOo51os4/8XNZY70jR6Pd
    dldHWl+ybZP8RgVdBGRw4X/11DYdWftSIi5R8y3P8ram3+CR8qklFjyvrwC6gZ9Ttcjr
    P3zepjXk9GhZh+XQNbFzhCQd8QtaMuQmLzW1TX6+yV+7JurRBfJigDPLU34Yb5SqNaM1
    jkSXbvbZGPOlunKMbcy+Jp9kJ/NlBG/daKa06zCYpmW+JhmeoQRTSEAa/0wTiZj+CFCy
    b1bsbluFVNzbu4UyrGl6wB6D9ZMXeyO+PaRgIhTytEQd4+PGT7h7RTkOuGS0wIoiI+cp
    JnEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694981484;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zGxppwIRX0Tl3MeLWQbRI04qLkWaOFo5HeDhjvTY4G0=;
    b=42b5DEePtqlChrZhp9Op9nz7V4ylqCq3akygV8jbyjuNu14kvdlfFHQp8kNnMNcach
    VsvjSQLemRN5ottbkbBA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAbhC22VTSyBo5Bpg9wgYEqSm4NXFaofpx464Ao="
Received: from p200300c58703581b312819b392712fb6.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z8HKBOI6g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 17 Sep 2023 22:11:24 +0200 (CEST)
Message-ID: <c66810ae52446db41fd187ee4be24d04d40c1abb.camel@iokpp.de>
Subject: Re: [PATCH v2] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
From:   Bean Huo <beanhuo@iokpp.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Sun, 17 Sep 2023 22:11:24 +0200
In-Reply-To: <CAPDyKFruYooG4yQ4yqrwEcrvy4xe6hYByF2Q57eQ1g0tiUtcug@mail.gmail.com>
References: <20230914202749.470100-1-beanhuo@iokpp.de>
         <CAPDyKFruYooG4yQ4yqrwEcrvy4xe6hYByF2Q57eQ1g0tiUtcug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ulf,

Thanks for your comment, much appreciated!


On Fri, 2023-09-15 at 00:09 +0200, Ulf Hansson wrote:
> On Thu, 14 Sept 2023 at 22:28, Bean Huo <beanhuo@iokpp.de> wrote:
> >=20
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > Micron MTFC4GACAJCN eMMC supports cache but requires that flush
> > cache
> > operation be allowed only after a write has occurred. Otherwise,
> > the
> > cache flush command or subsequent commands will time out.
>=20
> For my information, more exactly, how can we trigger this problem?
>=20

This issue may be likely reproduced in this command sequence:

eMMC power-cycle/reset-->...(other operations, but no data write)...-
>cache flush-->...... ->write data, must say, it is not 100%
reproducable.

> >=20
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > Co-developed-by: Rafael Beims <rafael.beims@toradex.com>
> > Tested-by: Rafael Beims <rafael.beims@toradex.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changelog:
> >=20
> > v1--v2:
> > =C2=A0=C2=A0=C2=A0 1. Add Rafael's test-tag, and Co-developed-by.
> > =C2=A0=C2=A0=C2=A0 2. Check host->card whether NULL or not in
> > __mmc_start_request() before asserting host->card->->quirks
> >=20
> > ---
> > =C2=A0drivers/mmc/core/core.c=C2=A0=C2=A0 | 7 +++++++
> > =C2=A0drivers/mmc/core/mmc.c=C2=A0=C2=A0=C2=A0 | 5 +++++
> > =C2=A0drivers/mmc/core/quirks.h | 7 ++++---
> > =C2=A0include/linux/mmc/card.h=C2=A0 | 2 ++
> > =C2=A04 files changed, 18 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 3d3e0ca52614..86a669b35b91 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -259,6 +259,13 @@ static void __mmc_start_request(struct
> > mmc_host *host, struct mmc_request *mrq)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 host->cqe_ops->cqe_off(host);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host->ops->request(host, mrq=
);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (host->card && host->card->qui=
rks &
> > MMC_QUIRK_BROKEN_CACHE_FLUSH &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !host->ca=
rd->written_flag) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (mrq->cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mrq->cmd->opcode =3D=3D MMC_WRITE_B=
LOCK)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host->card-=
>written_flag =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I don't quite like that we are adding the above code here - as it's
> used for *all* requests.
>=20
> Seems like the flag is better set from the mmc block device driver
> instead. Somewhere in the path when we serve I/O write requests.
>=20

yes, you are correct, I will update the patch and add this flag set in
mmc block driver mmc_blk_mq_issue_rq().

> > =C2=A0}
> >=20
> > =C2=A0static void mmc_mrq_pr_debug(struct mmc_host *host, struct
> > mmc_request *mrq,
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 89cd48fcec79..a2edd065fa1b 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host
> > *host, u32 ocr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!oldcard)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 host->card =3D card;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 card->written_flag =3D false;
> > +
>=20
> According to your earlier reply, it sounds like the problem isn't
> really about the card being re-initialized, but rather that we
> actually need a write request to happen before a flush. No matter
> what, no?
>=20
> See more about this below.
>=20

Actually, it matters that the first cache flush command after
reboot/reset. means that for the first cache flush command, before
execution, the write data operation should occur,
After that, there is no problem even if there are no writes before the
cache is flushed.


> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >=20
> > =C2=A0free_card:
> > @@ -2081,6 +2083,9 @@ static int _mmc_flush_cache(struct mmc_host
> > *host)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D 0;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (host->card->quirks & MMC_QUIR=
K_BROKEN_CACHE_FLUSH &&
> > !host->card->written_flag)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return err;
> > +
>=20
> Could an option to the above, be to reset the flag here instead.
> After
> a successful cache flush has been done.
>=20
>=20

As I explained above, the first cache flush after a power cycle/reset
is important. We just want to eliminate the first unnecessary cache
flush.
We can eliminate all unnecessary cache flushes when the cache is empty.
But I don't want to change the current logic too much, only want to
focus on the first unnecessary cache flush, how do you think?

Kind regards,
Bean

