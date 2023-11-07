Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4017E49F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbjKGUfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjKGUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:35:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E007A2;
        Tue,  7 Nov 2023 12:35:38 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 915E26607488;
        Tue,  7 Nov 2023 20:35:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699389336;
        bh=asHZXnIpLuqbzC1uJm5vpUFSXjcPsLIOLAJt8cxZxR0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EqghnVwFCmWfliLwu00buab1tBUdjAJPaQqTTbHY+qo39KqM542ZjygpsT07o5JPU
         aEZZzcUPAi3jmAMtx6xtN2atlkfxKxZSjmbSNKC9kGf9kKnKvnzWFWHWvRtZXETXJW
         Vjr+dSdB/RlLTOBne5Qf3bAjICl+0wFgdwprvOq0JFOWHVxGEpGfMSFD7KNTQeeWRp
         6GloQ5oQs+4r5avado93k3dkvYeWfFL1mT+VFgHW6jtLy3az0BxQ2K2RYg+6o/vAWb
         Dk2CkR9u+xHIhiKRJCBVc9v9uhAWt0dMyhkN0L82IcneUZyNweu8e48Ii0fKtsQaDV
         kzIioQBFypzcg==
Message-ID: <2cca0360b0a2a7d4032b02a16ae8f5c2a83283ef.camel@collabora.com>
Subject: Re: [PATCH] media: cedrus: Update TODO with future rework plans
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>
Date:   Tue, 07 Nov 2023 15:35:26 -0500
In-Reply-To: <20231107200628.485227-1-paul.kocialkowski@bootlin.com>
References: <20231107200628.485227-1-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 07 novembre 2023 =C3=A0 21:06 +0100, Paul Kocialkowski a =C3=A9cri=
t=C2=A0:
> The current TODO list of the cedrus driver is now outdated as most of the=
 points
> it mentions were already tackled. In addition it is no longer considered
> relevant to wait for a stateless encoder driver to move it out of staging=
.
> The hantro/verisilicon driver was already unstaged without this condition=
.
>=20
> However the driver suffers from a bad initial design that showed to be ve=
ry
> limiting. It was also not a very good fit for a video codec driver either=
.
>=20
> Since a rework of the driver was already carried out for the purpose of a=
dding
> encoding support, update the TODO list with a description of the rework.
> This reworked driver will be published soon and transitional commits from=
 the
> current driver will be submitted upstreamer after that.
>=20
> It seems best to wait for the rework to land upstream before unstaging th=
e
> driver, since a major rework is best operated on a staging driver instead=
 of a
> fully upstream one.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/staging/media/sunxi/cedrus/TODO | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/TODO b/drivers/staging/me=
dia/sunxi/cedrus/TODO
> index ec277ece47af..00aa304a7e36 100644
> --- a/drivers/staging/media/sunxi/cedrus/TODO
> +++ b/drivers/staging/media/sunxi/cedrus/TODO
> @@ -1,7 +1,16 @@
> -Before this stateless decoder driver can leave the staging area:
> -* The Request API needs to be stabilized;
> -* The codec-specific controls need to be thoroughly reviewed to ensure t=
hey
> -  cover all intended uses cases;
> -* Userspace support for the Request API needs to be reviewed;
> -* Another stateless decoder driver should be submitted;
> -* At least one stateless encoder driver should be submitted.
> +This driver suffers from a bad initial design that results in various as=
pects
> +being intricated, making it difficult to scale to new codecs and to add =
encoding
> +support in the future.
> +
> +Before leaving the staging area, it should be reworked to clearly distin=
guish
> +between different aspects:
> +- platform, with resources management, interrupt handler, watchdog,
> +  v4l2 and m2m devices registration;
> +- proc, with video device registration and related operations;
> +- context, with m2m context, queue and controls management;
> +- engine, with each individual codec job execution and codec-specific
> +  operation callbacks;
> +
> +This will make it possible to register two different procs (decoder and
> +encoder) while sharing significant common infrastructure, common v4l2 an=
d m2m
> +devices but exposing distinct video devices.

