Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13BA7BC535
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjJGGyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJGGyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:54:35 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0693CB9;
        Fri,  6 Oct 2023 23:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696661660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UiB+d09rD4OyIAgNWYHja+MKqH0TviUsihNkSF9rW75dPsdZi+xmeyCt8GUYLPOG9t
    HfSwYtwqsi7GXj93AxS9hISUQGl7r81dWx4FpBeICTzhhBB/wUD2o+iomPqjzZajuLO8
    tO7d2gx6yv3EL0gnCgia8jviin4zStCdQ+ESIPSIqz7JPxwekC0qHzfpgI5t7+siL6yG
    gGkeXHmLXymTXDRpWE/SwGNsLuq0YlNuuwRNo7b416wpUYtRKPv0HnmchUuumGwUGWCJ
    h68P+VBVoygtxc6Au9wNxXYGjDavJI6/nbXCmiq8t9So6Tv08aVbouJgWkBGg5vmcT0j
    RB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696661660;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=eFqOHJLcYTjblJDokQ4HqA1V2rRB1+qjwpvCB3uxOg0=;
    b=Ctr7r9Zr2pLcMMhJaQ8p1DNbEU9k+ZRd+00PNfdlBtdCo2L1nOgk3Wx1wkrrOLYX0Y
    dm9P/89NtSgnJpqChqptqJ153Q27ttB3jbtEWFTg8TvoDsrdxBcPUVshF2swaY5miL2P
    QpzlDEt8EBE1njUPpNnXNHyGRvt5EdzkykxJPtwWKLuiIaUkONeUjHT/xMUBrjfUmd2H
    3GPEHizpOhEFnwCtvPIYZjR/PIqpfp2hJSNYYu4jmt6x2G0Pxpoav1eQjthADz9dlK/Q
    x34/XWtDqm8eezoLIsXqqAikakpQdYvtfKVyo3lcR2Gv/MhVR1Q/nuJagbBsPjcjfb2g
    eeSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696661660;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=eFqOHJLcYTjblJDokQ4HqA1V2rRB1+qjwpvCB3uxOg0=;
    b=Gmym8YjOtf8ci5Htcei4DHy5vl8lp8sFhOfTo/6VYIqzXGRmlnlsCcAaEn8j+VpTyV
    lbSKnYLMp46azAirS0RFafeMsrPiA8fHG1xtr5vledAIoGutOGnE1xOMdU7et0j/osER
    sSTjJe40BU4sNAN8Qc1dr6Bt/tym26bhpw+3wq+nqNucAUMFevh/4zI34z2JKJpGPoD8
    H9KYe0zIvGpht8E70QkXORiSirJ0NI5xmbphY6Q8h9Q2EnoUJsFhLjRB0PBTqoS1QHM6
    rLk/7e+lm3JrnVenFBqPu7spGQ5UqHOZRL0YNNcL+cNJ1bht6nZvlLwTkBeMk6DV73bz
    uu4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696661660;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=eFqOHJLcYTjblJDokQ4HqA1V2rRB1+qjwpvCB3uxOg0=;
    b=+hpHDNBksOhA5/6twPm+b2l41xBtUWe0NGVq8rf+eyVVH5Tp9kSN7YD75hxpqX//9C
    ZGLhHXFoNw0h03JPOBAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZhzY="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id Y04dd7z976sKsY9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 7 Oct 2023 08:54:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Drop superfluous omap36xx
 compatible
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20231007064439.GN34982@atomide.com>
Date:   Sat, 7 Oct 2023 08:54:19 +0200
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D2A2AA0-759A-4AF8-967A-ED6FE2F6C1BB@goldelico.com>
References: <20231004065323.2408615-1-andreas@kemnade.info>
 <12323F42-3611-4685-8981-F6A18C4A5862@goldelico.com>
 <20231004130353.01228376@aktux>
 <FF3A3F35-E264-4D28-AFAC-EFA2ADB69F40@goldelico.com>
 <20231004135449.591b3f6c@aktux>
 <42806B60-E48B-4AA9-B375-E9F65F59AB87@goldelico.com>
 <6B245439-F9FE-4931-A0DE-81F825BB5FE5@goldelico.com>
 <20231007064439.GN34982@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> Am 07.10.2023 um 08:44 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [231004 12:50]:
>> What about the PVR/SGX driver. This needs a compatible that can =
distinguish
>> between the DM3725 and DM3730. The first is w/o SGX and the second =
one
>> with. Having all summarized as omap3630 does not allow to load the
>> PVR/SGX driver based on the board specific compatible entry.
>>=20
>> AFAIR this was the original idea behind=20
>>=20
>> 	compatible =3D "goldelico,gta04", "ti,omap3630", "ti,omap36xx", =
"ti,omap3";=20
>=20
> I think we already handle this, see drivers/bus/ti-sysc.c and search =
for
> DIS_SGX and similar flags for other accelerators.

Ah, ok. This means that the kernel module isn't loaded if the flags of =
the chip
are not available. Then we will indeed have no need to describe such =
variances
in the DTS.

> So I think this patch is
> safe to apply?

Looks so (especially as I only have omap3630 based devices with SGX).

BR and thanks,
Nikolaus

