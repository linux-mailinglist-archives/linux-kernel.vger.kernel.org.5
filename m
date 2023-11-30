Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6564B7FE6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjK3C1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3C1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:27:49 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB47D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:27:55 -0800 (PST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 87DE73FA50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701311273;
        bh=51BH6r3NTeuU80Og8+pDQ4LBdHK0XIdfBAWZqxE/rY8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mJJqGCXh5F/pRX3tjvzsjpKHzxd0RGGbqO9u1MdxhdjWcdlkCAPYahX1ElKDf9yBH
         HK7lkceBMm7caFeZD3mzv7Pxwr8Wc/+TqFzbTWKThy8Q3DSBJDvKRJhZFgp3+VO0tU
         TAS7Pnv4jHzf+DK/qLURvvPglEUJ+vboO78BSkHSTJ3msFKtjspiuCr8frUtp8pq20
         fiO/O5wBrfLmQgV3eqba67l2jWz2jsYXvSqzQE64ElQ5BQeh8PpAdwOSzRhIdEv689
         yl7UEgX0pOjhHZNK9SBVaN+o3eyBd93aR+5xX/xwPutt/WiEqZ2Nv8bIGu36S4rdyO
         IeFi6584GwKUA==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5cbfcf3ae48so12833977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701311272; x=1701916072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51BH6r3NTeuU80Og8+pDQ4LBdHK0XIdfBAWZqxE/rY8=;
        b=JvnZWvBwTl/4ELn6Y8RVUW/2j0dfj/eKPBsk8sES+4KDXISig4l+ooVLwtC6uLSusU
         CuERp+tmA/5hbEu2lDup6UWLkU+bat4KIpkmFuQvTsHfytNpxofWw5XZpVRovtZ1FHFG
         RrHSvTiHjFEOW/Fba4BLhf3GcUq4XB2z6V2J1bHWWcTPAGUJOXgXDvhtwZK8LnTIa5uV
         9Ihe6lwlTUYP4fEM6sF+7qtgS0oePaNZRazTRr9AvwoYGfY9t7EOp9Vwed4Mfti4jJpo
         JqHvdI2SFHWizmziJIWJzq92KkJ9QV0OCm/ne2tqbIAzBfp3ix5IS2Kaj1qFhaPz4uRI
         Y5xA==
X-Gm-Message-State: AOJu0YxX8SqAnczmfAJ7w/B9uOqNVccHKO3hqinnjFf6tzm0TvmX3CgH
        o13C6D5eR8gtexJmwUNnPnBm9z1NeDQwFDBIf2dMC5KxVtgCyDeVOGnCXZrshjOUXC+U6NXilwb
        FeUfbNmR1jVKd+dz0Uvc4gFy2HEzxYmMwpkgc1uzXn61k/DCzznR4hz5Q9w==
X-Received: by 2002:a25:75d7:0:b0:db3:fa4e:5b80 with SMTP id q206-20020a2575d7000000b00db3fa4e5b80mr19047540ybc.20.1701311272349;
        Wed, 29 Nov 2023 18:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU+/+cZbTSn4ReKApKLD82OGBkDM2LrmtNnHt3yCLXIOaJ5oVUUQwfztQHQlCy4aFlUeyNvfUi8DlF3WBb+EM=
X-Received: by 2002:a25:75d7:0:b0:db3:fa4e:5b80 with SMTP id
 q206-20020a2575d7000000b00db3fa4e5b80mr19047524ybc.20.1701311272067; Wed, 29
 Nov 2023 18:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20231129064311.272422-1-acelan.kao@canonical.com>
 <20231129064311.272422-2-acelan.kao@canonical.com> <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
 <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
In-Reply-To: <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 30 Nov 2023 10:27:40 +0800
Message-ID: <CAFv23Qk6Qpxu+ROou5Uzdwu_0jSF-EYZPHynUps_5GOAakuJvQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2023=E5=B9=B411=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=885:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Nov 29, 2023 at 07:46:02AM +0000, Tudor Ambarus wrote:
>
> > You haven't specified who shall take these patches. Is it fine for you
> > if I take just the SPI NOR bits? If you want Mark to queue both:
>
> I can certainly take both.  I guess there's no build time dependency so
> we could each take the subsystem specific patch, though there'd be some
> bisection drift if that happens?
Hi Mark,

It'd be better if you could take both of them.
Thanks.
