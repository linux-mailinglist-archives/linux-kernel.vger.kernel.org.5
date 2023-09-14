Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30BE7A0EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjINUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjINUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:13:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C726BC;
        Thu, 14 Sep 2023 13:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694722205; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FAS7zdACzRHWmLR7cLoAvFQ43ghukVQXh17nFYmGlRH6fE8LI8XbQrq2OKieKwKWre
    eivFfAQt2gVn+Cd6OCv9J29nA/A/Rf3fDvZTZD6ww9lJbuoSANCAtzNR+9XyeAqN5UNF
    3yNNV3M29ZiY16j2Hnz9IMpOMrYaZCy4uavZ4jUJ7Ar/OMFuyWX2uO6QHJRKl20mcfES
    W+1x9UHYplCqsCofztVLlGPmgF3w74fuidj0xvHFM7dAI1L9Lw5ZXGL/fD7trWHB8zwU
    Y6sYuoYEPWJAcgnJBSaEDfvQRWb8EhIq95VcbSPCiKoQEVpQz6IarYfxbpitDVODuclF
    TjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694722205;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fXRjlNaEDcLO+Ds2VeBoLb7X+/j4pybZ+EP92kizZOY=;
    b=TbOcUlgjvi/x3Un8MJ43ISmVx2OlH6bgjpKlDoic5EnS1zBfadOHx/idn+wN7HNWhF
    EgWdSJwjTKfXVA6Ecxu071LLPxYWPWmzmXXLsMERdKPpD3/ungErKsVjYoplKmElPFb1
    EUYDoLKOTGEnRvddyiNJEOoMIk0k6nK3JOQlQuxUMAoMWmUkoSrtioZPWPOVi9pPtk2w
    WgWKG1NbV01fZkDBDVBpi/dWkjiSrg3+id1ZIDuDKsgsqHTTL/WhjQrtjUBQ4wTyOhKj
    n73yO9AgUSe7LkY6fJTAnJurONXv97BaL9gYkEPY7gWWXZpVCW19UFWJJN/QGcC0S6XG
    FMiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694722205;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fXRjlNaEDcLO+Ds2VeBoLb7X+/j4pybZ+EP92kizZOY=;
    b=H24+b2H6ZtJW2UnrEJSPVpBeGyPG+l7aCmkA07duIeE6vcxVaZC+u3ae5oqgs4qwV7
    2aKowJgOOZ0tQiBX1C3RrtzZS78yFu9Wpp7/Tl/rJoC0qe7ok6nG50pAwmHNVQ8DxP6T
    n3WuuPtxckA0lRjBnLpcngizDFKyep5MOBnQgNSuzx2kXJn7A+bAftr1K+EKMVazCgXy
    N/TDRUBP0kONCZxbnwMHatU5bY0fHUtScwo/xOdAOFepWSs3HYSOySFOOIO0QUHqz1jq
    2CW/x9aX+7dgXcnnfVyZkzA4Jwo1qVwDR5fm+gGXpmxz8dRl+FiEkpESTodRr4GlvWTN
    z73Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694722205;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fXRjlNaEDcLO+Ds2VeBoLb7X+/j4pybZ+EP92kizZOY=;
    b=ZECWWwnz2ZHzrdA3jdzN3H86sADaPHOOND7YQwZfK1BxLU0gpnCOJsJYT4GCrx08MQ
    o6nxYnylNuObH5TeRPCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAbhC22VTSyB8cMmLdLpWPYurOsVc7IfjM2CVzE="
Received: from p200300c58703581babbe27afdf2433f1.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z8EKA4DY8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Sep 2023 22:10:04 +0200 (CEST)
Message-ID: <29a418ef8d4f1be398420aa58474184febe26433.camel@iokpp.de>
Subject: Re: [PATCH v1] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
From:   Bean Huo <beanhuo@iokpp.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 14 Sep 2023 22:10:04 +0200
In-Reply-To: <CAPDyKFrt4r88RhCg1XigFtd8xSrLLbHeD31ZAEA0aUDkNzRxGQ@mail.gmail.com>
References: <20230913185735.459661-1-beanhuo@iokpp.de>
         <CAPDyKFrt4r88RhCg1XigFtd8xSrLLbHeD31ZAEA0aUDkNzRxGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 15:59 +0200, Ulf Hansson wrote:
> On Wed, 13 Sept 2023 at 20:57, Bean Huo <beanhuo@iokpp.de> wrote:
> >=20
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > Micron MTFC4GACAJCN eMMC supports cache but requires that flush
> > cache
> > operation be allowed only after a write has occurred. Otherwise,
> > the
> > cache flush command or subsequent commands will time out.
>=20

Hi Uffe,=20

Thanks for your review.=20

> This needs some more explanation I think. What does "after a write"
> really mean?
>=20

"After a write" means that the cache flush command is only
meaningful/allowed or necessary when the data write command occurs.=20


> According to the changes below, we are tracking only whether a write
> has been done and then we set host->card->written_flag =3D true - keep
> it like that forever.
>=20
> What happens beyond a power cycle for example? Like in the recovery
> path or in the system wide suspend/resume path? Does the flag need to
> be reset in those cases too?
>=20

Yes, during recovery and system/runtime suspend/resume we want to reset
this flag and set it again when a data write command occurs.

 we found that on some systems,  the cache will be flushed after the
system power on/reset,  the cache in the eMMC is actually empty at this
time, and cache flush is meaningless. But for this eMMC device,
flushing the cache before writing data causes problems. This is what
this quirk meant.

However, after writing, and then doing a cache flush, similar to the
following, the cache flush will work even if the cache is empty. So, we
only care about just-boot/reset/resume.


Kind regards,
Bean

> Kind regards
> Uffe





