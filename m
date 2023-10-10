Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE17BFED8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJJOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjJJOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:14:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1CE99;
        Tue, 10 Oct 2023 07:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696947277; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EyMyTwP++Q+aO7Obvzjjc4DRcVanwUHlxj+fNMO67BLqkvX79/SO++54LNm+cEqfRW
    AjDl0PBfzqDuKs2SlgQxHBV44eklOT39Fe1a8/glFEFYUgbRitSzHoqfTVwW1L+4G/Y6
    yTcKOHTyOUuW4Tp00We8HRU9FMlFihYT2AsePQakJrN8l71t4aejPRoPpcLB7EGoYLoq
    0eEd8bXk5mcTSH1Y/4RuLZQgtl5PHJbsuKpHCcrXztPYXacx7c+RiNZ9yyG7dlC94JLY
    /qZqzjHNk5XOmEEXQ9A0MWoMsdFkFiyJP0Gd0VXrn09D6WVRIc9ljud+TQyW/ed2sI4k
    uhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696947277;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4uK76eA+4AbIM6l8BwN3q4oqZOJA08YYEexI9aSSkBk=;
    b=J0WVFxcyJLTL8d279+VpMrH0sCsEgKjHaW8pToIKEk7509P1FERvtYAX7CakH1Mz+/
    7sAYpfc6u37AeLTshDZbT6V0WVQ0iPua8MUSTRjlwtHqv3Nz4Mny54jBsBGwCRPvrCxb
    EAGHGbFDFup51cIT+/OfycOv6ezuVY5g5CzCQhpbXOn/ylwlLNEwCMdHWEAfWHXOLg6f
    8ReZeG4MePFouffRfD5+aO0lTzxrVvbE2uOzT2Baa6HLdh+XxhjXGx6OQDQih1qgWfDZ
    62BHMhaCVmMKgikkPYUxI8Uruo9mcvxOhhokSqjejP2TJpFp7zXyq3N/ADK0hyxnS30k
    9Eog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696947277;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4uK76eA+4AbIM6l8BwN3q4oqZOJA08YYEexI9aSSkBk=;
    b=p0WF8yWPe5yqtBUAEwAZzKcz+wJi61xJlamqCKzB5l24ByTOqo/1fcMyZ/DnoOg69A
    8KdXOz2/Hcgpfic6YxWeAjGLofyGXab57qPl3TkbYRtiDuLm5/sJVt10KNYVTrhLqatH
    /AqKR+vOAqRd331BENdx+zhjz++xrR7ejl9pvuT6jJyK1K1lPxXqGfQma+RJB0DZvRZf
    5ij+SzuqYaHpt8uVi76ZROHLmDng8NtXpR3d6XUE9eSjcv1hrildnD4+41uOC6Fx4c66
    4LGdVBUFLsqBetoJOEpu9pVl5ceQAmzSV6ab/BsAGIkGsQk86N0zqcMc1v/vwk9Nl1+0
    Ab6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696947276;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4uK76eA+4AbIM6l8BwN3q4oqZOJA08YYEexI9aSSkBk=;
    b=6ln3XSz9yzCa6FZBK4SMPHbl/aFo6so/uYpX2tKX8rXfdFntQy828IZcRB4kcxzGdq
    t/4j20qHIWvZ04zw3RAA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.234.119]
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z9AEEaKom
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 10 Oct 2023 16:14:36 +0200 (CEST)
Message-ID: <0f66769bb82bdba201ddfc7a826aacf3dc6b2296.camel@iokpp.de>
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
From:   Bean Huo <beanhuo@iokpp.de>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Tue, 10 Oct 2023 16:14:35 +0200
In-Reply-To: <f9beb373-a6c8-ba07-f3d1-c72ecc058806@gmail.com>
References: <20231001194943.658299-1-beanhuo@iokpp.de>
         <f9beb373-a6c8-ba07-f3d1-c72ecc058806@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ulf,

ping you again, have you recieved this mail?

Kind regards,
Bean


On Wed, 2023-10-04 at 21:07 +0200, Bean Huo wrote:
> Hi Ulf,
>=20
> Any comments on this version?
>=20
> Kind regards,
>=20
> Beam
>=20
> On 01.10.23 9:49 PM, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > Micron MTFC4GACAJCN eMMC supports cache but requires that flush
> > cache
> > operation be allowed only after a write has occurred. Otherwise,
> > the
> > cache flush command or subsequent commands will time out.
> >=20
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> > Cc: stable@vger.kernel.org
> >=20
> > ---
> > Changelog:
> >=20
> > v3--v4:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Add helper function for this quirk in
> > drivers/mmc/core/card.h.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Set card->written_flag only for REQ_O=
P_WRITE.
> > v2--v3:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Set card->written_flag in mmc_blk_mq_=
issue_rq().
> > v1--v2:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Add Rafael's test-tag, and Co-develop=
ed-by.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Check host->card whether NULL or not =
in
> > __mmc_start_request() before asserting host->card->->quirks

