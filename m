Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19B2757CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjGRNIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjGRNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:08:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD51BE4;
        Tue, 18 Jul 2023 06:07:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so9077019e87.1;
        Tue, 18 Jul 2023 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689685658; x=1692277658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GA6QwU20lGhp2Bev/70UXYufsOZZR1jEJ5AU1SEFOiQ=;
        b=q3z5eTwcNE4siHOx4yyXpbx3/eKKVNk0SJyP4BZVLNpByDlJGHQOChuJSOlnkIWsix
         cFYsbSugckBau4cOp68VS9trIkBZ0nU74Yf4lTQ7hjhKuJEGXvLTI0ucAIh4lRA3+43D
         cEm/BlYntgJesDxUHBkOQ/X0GN4oC67yMs+qrMHubEOWDZtto+/RXv5Epeod/xqQ0ioK
         AO4eah06jsKr1rX2tJrD7kYYrcoQ7+KelC3RT7KAHqJ0c5NUO4w3IFxoE8MfQ2QUD7vY
         3xi/Ktaefi24MzhSYfC6KeB8sW2wd6coFzyw4C8UaV/YMJsjJV/oCRr3HR+rLbWCVRtF
         pWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685658; x=1692277658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GA6QwU20lGhp2Bev/70UXYufsOZZR1jEJ5AU1SEFOiQ=;
        b=DBngB2VUtUJ4wuG2LzYlIlYpHLQytYW7We5RnxgCv/vCA8vYLkiQZi4wqBJJ7mqrzj
         T1LdA5a62qmiaKfcguuh21TZMHGyLg+wu72hMPfwVSlfvmw/IOcPZbvAP/hzss28Ef2C
         DZHfyWp+S521Ryy+Medl4z0T9TRsM62n1FfmunkGNglZ8tXmL0cAU/DmaYccjZQ5rgb0
         z+Mt/gZO8StxHXpPD0jWctXB7ldlJ9IAN06+oKaZk5+I7WoeOqjyLvNynXT0SRcF9AmA
         IgtNzmev5IVN99FUiQkfIDXRvhpI3Ne1ctJ1kjhXUsb6vMzb1fGrl3jAEsStLHjMLN1Y
         gNHA==
X-Gm-Message-State: ABy/qLbOsJ6h+nN78k5kGQ6RKYhPr9N2hB/1xMcRvUqnE7nOgB3JGgxm
        a7yYydVXo6U+WmWMn/GJ9YgMHPbv+0SKK2s9zkY=
X-Google-Smtp-Source: APBJJlHkU1AeRsmyGGYifR4UECYS+DLo/3SPD/NocVe/DcpSI0WmlGIH+LOT7eJEbiOW53qYeyQTag==
X-Received: by 2002:a05:6512:3d89:b0:4fd:c23b:959d with SMTP id k9-20020a0565123d8900b004fdc23b959dmr4198501lfv.34.1689685657725;
        Tue, 18 Jul 2023 06:07:37 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:4ac8:4223:8b53:53c1? (p200300f6ef0587004ac842238b5353c1.dip0.t-ipconnect.de. [2003:f6:ef05:8700:4ac8:4223:8b53:53c1])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7d34f000000b0050bc4600d38sm1211045edr.79.2023.07.18.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:07:37 -0700 (PDT)
Message-ID: <4a5d6ca0e2c9529d5eb0bbacbaed56e2645719c6.camel@gmail.com>
Subject: Re: [PATCH] iio: core: Prevent invalid memory access when there is
 no parent
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Milan Zamazal <mzamazal@redhat.com>, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue, 18 Jul 2023 15:10:07 +0200
In-Reply-To: <20230718120700.132579-1-mzamazal@redhat.com>
References: <20230718120700.132579-1-mzamazal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-18 at 14:07 +0200, Milan Zamazal wrote:
> Commit 813665564b3d ("iio: core: Convert to use firmware node handle
> instead of OF node") switched the kind of nodes to use for label
> retrieval in device registration.=C2=A0 Probably an unwanted change in th=
at
> commit was that if the device has no parent then NULL pointer is
> accessed.=C2=A0 This is what happens in the stock IIO dummy driver when a
> new entry is created in configfs:
>=20
> =C2=A0 # mkdir /sys/kernel/config/iio/devices/dummy/foo
> =C2=A0 BUG: kernel NULL pointer dereference, address: 0000000000000278
> =C2=A0 ...
> =C2=A0 ? asm_exc_page_fault+0x22/0x30
> =C2=A0 ? container_offline+0x20/0x20
> =C2=A0 __iio_device_register+0x45/0xc10
> =C2=A0 ? krealloc+0x73/0xa0
> =C2=A0 ? iio_device_attach_buffer+0x31/0xc0
> =C2=A0 ? iio_simple_dummy_configure_buffer+0x20/0x20
> =C2=A0 ? iio_triggered_buffer_setup_ext+0xb4/0x100
> =C2=A0 iio_dummy_probe+0x112/0x190
> =C2=A0 iio_sw_device_create+0xa8/0xd0
> =C2=A0 device_make_group+0xe/0x40
> =C2=A0 configfs_mkdir+0x1a6/0x440
>=20
> Since there seems to be no reason to make a parent device of an IIO
> dummy device mandatory, let=E2=80=99s prevent the invalid memory access i=
n
> __iio_device_register when the parent device is NULL.=C2=A0 With this
> change, the IIO dummy driver works fine with configfs.
>=20
> Fixes: 813665564b3d ("iio: core: Convert to use firmware node handle inst=
ead
> of OF node")
> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
> ---

LGTM (just one minor question below...)

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-core.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index c117f50d0cf3..229527b3434a 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1888,7 +1888,7 @@ static const struct iio_buffer_setup_ops
> noop_ring_setup_ops;
> =C2=A0int __iio_device_register(struct iio_dev *indio_dev, struct module =
*this_mod)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev_opaque *ii=
o_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fwnode_handle *fwnode;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fwnode_handle *fwnode =
=3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!indio_dev->info)
> @@ -1899,11 +1899,12 @@ int __iio_device_register(struct iio_dev *indio_d=
ev,
> struct module *this_mod)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* If the calling driver =
did not initialize firmware node, do it here
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev_fwnode(&indio_dev=
->dev))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fwnode =3D dev_fwnode(&indio_dev->dev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (indio_dev->dev.parent=
 !=3D NULL)

Maybe this is odd enough that it could have an explicit comment referencing=
 the
iio-dummy device? Not sure if there's any other place where this can actual=
ly
happen...

Apparently there are also some dev_err() on the parent device (even though
dev_err() handles it) but yeah, unrelated with this.


- Nuno S=C3=A1
