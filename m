Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEAE7DA6B1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjJ1LX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJ1LXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:23:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9FD9;
        Sat, 28 Oct 2023 04:23:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083f613275so21596785e9.2;
        Sat, 28 Oct 2023 04:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698492228; x=1699097028; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=inkVXt8mNRsPeNjfeXHVk0mmWOAzErBsUID4u2QruF4=;
        b=D1Y1aDfDLJwIPLuUBbTnslxAO+52jb/NtWkBnZAOqhYfRL+qO3zvYG/95X7gT5yvpJ
         /Tc3lmAe7JUCNEuPbkoG1W2PpOU3UXndpUAVE1FcK8pHrphw/we00snRnWYmMedIv6uA
         Tqgv2FijJXChGFBJMkQgdI/OC4FzJF1wXdu6d3bCXIPREzkeCseVpGCSa1J9zW/PIC7w
         8qIOyRTksP3wBDC5XtR2Vr3TzsZTH1UA0f5OxHr/Rzjkl47iR0/XXh9mC4UbeiobiB86
         +kb73n8Yu5FerKUl0sH5nDm1olPI16I6UIoz2Ry1LQeSkaqMJzdTQUQJSSh2RUsD0tyh
         EJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698492228; x=1699097028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inkVXt8mNRsPeNjfeXHVk0mmWOAzErBsUID4u2QruF4=;
        b=LS7W7qYAfDKxaP3QUSDkDGP9cU+TI3l7CTMMxVrqc6VgRlXh3ouxb2rLiDsOOCn3Th
         nXT1NcnZOZ49WQc8/X0tv5LbIWwtHPJIECEGvSzmuMqf1R8SgI5K5uKV/oqP9a9JA1/X
         ZfadfL+m21LHy1ncl5Eb54SMXnM0uuVWqJUUNwep+u0doYehD6xE9PkaNMsamGnJYf/V
         3t+9t9K97LIERVDvkJXuqsVZLY48ou9R2FoMDyjs8lagOOrl8nx7aMEiCnXRG7UfcAdr
         rdNK5R6kNYfJgoM3Jqf2dARsghtPMbxPZMQar1a91a2sfcjuL6Pl0cdu+nsOYznDp7t2
         CnfA==
X-Gm-Message-State: AOJu0YwBltZQx9Z0Gbbt6+EGsHJFHT/grbwlM3boih8jBoXn63msq7V/
        husd6lwUPfrZg1+Rd0piJZM=
X-Google-Smtp-Source: AGHT+IEEFA9l8QD0pR5Se8YVz8kj7afROVeCB03xCjYKtp22lS22SEJmqZZzv6je83H6Y4auL9pW2w==
X-Received: by 2002:a05:600c:1c8f:b0:406:478e:9e2d with SMTP id k15-20020a05600c1c8f00b00406478e9e2dmr3851621wms.26.1698492227963;
        Sat, 28 Oct 2023 04:23:47 -0700 (PDT)
Received: from thinkpad-work.lan (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b004063ea92492sm3785933wmq.22.2023.10.28.04.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 04:23:47 -0700 (PDT)
Message-ID: <2a5ccee0ce33b2918e8b32b25ff1cd7221d01892.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Allow multiple chips id
 per family of devices
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Sat, 28 Oct 2023 13:23:46 +0200
In-Reply-To: <20231027144625.36cc694c@jic23-huawei>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
         <eade22d11e9de4405ea19fdaa5a8249143ae94df.1697994521.git.ang.iglesiasg@gmail.com>
         <ZTZYNjq/1X95ijXh@smile.fi.intel.com>
         <20231027144234.0ad6c7b6@jic23-huawei>
         <20231027144625.36cc694c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-27 at 14:46 +0100, Jonathan Cameron wrote:
> On Fri, 27 Oct 2023 14:42:34 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Mon, 23 Oct 2023 14:25:42 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >=20
> > > On Sun, Oct 22, 2023 at 07:22:20PM +0200, Angel Iglesias wrote:=C2=A0=
=20
> > > > Improve device detection in certain chip families known to have var=
ious
> > > > chip ids.
> > > > When no known ids match, gives a warning but follows along what dev=
ice
> > > > said on the firmware and tries to configure it.=C2=A0=C2=A0=C2=A0=
=20
> > >=20
> > > I would rephrase it a bit:
> > >=20
> > > "Improve device detection in certain chip families known to have
> > > various chip IDs. When no ID matches, give a warning but follow
> > > along what device said on the firmware side and try to configure
> > > it."
> > >=20
> > > ...
> > > =C2=A0=20
> > > > +	for (i =3D 0; i < data->chip_info->num_chip_id; i++) {
> > > > +		if (chip_id =3D=3D data->chip_info->chip_id[i]) {
> > > > +			dev_info(dev, "0x%x is a known chip id for
> > > > %s\n", chip_id, name);
> > > > +			break;
> > > > +		}=C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=20
> > > > +		dev_warn(dev, "chip id 0x%x does not match known id
> > > > 0x%x\n",
> > > > +			 chip_id, data->chip_info->chip_id[i]);=C2=A0=C2=A0=C2=A0=20
> > >=20
> > > If the matching ID is not the first one, user will have an unneeded
> > > warning here.=C2=A0=20
> >=20
> > Could be a dev_dbg() but I'd just drop it entirely.
> >=20
> Given that was all that came up, I've hopefully saved us all time by
> dropping the bring and changing the patch description as Andy suggested.
>=20
> With that done, applied.
>=20
> Jonathan
>=20

Sorry for the extra work Jonathan. Next time I'll be quicker checking the i=
nbox.

Thanks for your time guys.

Angel

> >=20
> > > =C2=A0=20
> > > > =C2=A0	}=C2=A0=C2=A0=C2=A0=20
> > > =C2=A0=20
> >=20
>=20

