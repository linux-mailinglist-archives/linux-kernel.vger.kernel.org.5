Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539E876676B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjG1Ikv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjG1IkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:40:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B83C35;
        Fri, 28 Jul 2023 01:40:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5223fbd54c6so2497542a12.3;
        Fri, 28 Jul 2023 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690533600; x=1691138400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1UwagyW03dnnLJ1SD7xabw19GGR5reLkqkRibuvm0Ik=;
        b=UnDAsqT8CS6uNUbVkQ5NPZxpUnAJfJuwE//pjpC4Ghi2CQc9Bqni07cI1TdfskGBXy
         CEWG2ej3tdw8JOTmlD0nrUE9c2ZugtcoAFPiKu8RzPkI2az1VWZE0t5GTrzYOAn/UP+r
         8yZvJ6n2UAhy7RVTEB2AjmKENHr6Z3nEme8WxBPMcnIe/CR68vjRKKxGYybhykTOtvWj
         8X3cwDR03VQGfvElA867iCQIA9STIQAhiM2tmDJER/34eFejqtYtaRUXjdM3k5y1scyN
         xTOQWuCk37EKazcmnQ8aUk175qPEk/qQyCh/c17Tzw4ajDc/c+Y4ZayB1TZqEHGpYyfK
         oSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690533600; x=1691138400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UwagyW03dnnLJ1SD7xabw19GGR5reLkqkRibuvm0Ik=;
        b=Xr486/9cgOu9+G0aRjeNtsA7u4qwTjyBYU8c92uYvcVc2i+sPbePvlCBqHE+zhZ0Zp
         9rnSoha/5U+XNw7l8xnuuCdbl8aSO1r9kYjnnctnnASc+Ngl3/tiWJ9iuHHXKEHp2/9B
         sw+YIOThShea8UTIJf9zFByZffxSvyvz47qwh6SyZGSzuK1FP1Q5V8wL077zcJojB4x9
         vrm5pDDYthFtagSbmIZ2VcnEq/VgauKA+wUBMXRErwnk1XYrn/ShlWLcn2ppi+BLJ0oT
         +tOCy2jkBjKvpti4jwSFEyqRPhu+4odNZ3BzoFW2hJyznJ07eRpBOvPeTLTqHdiFhjTj
         BiTQ==
X-Gm-Message-State: ABy/qLZPa2ZflWv9EnXBe7Gh4646iT4qVQGoKPjuq0aXSJkHQmHVx6jC
        VG5NrNbQONek+MTwCs/Df7g=
X-Google-Smtp-Source: APBJJlFonOXXfoQIrxcDPCDeBKCjfDtsJVWgLn2ZoOhdNa66LqE5u8MaREtOBqH3OOotQZUXrbi0jA==
X-Received: by 2002:a17:906:5a67:b0:99b:ca5d:1466 with SMTP id my39-20020a1709065a6700b0099bca5d1466mr1672998ejc.66.1690533599453;
        Fri, 28 Jul 2023 01:39:59 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id x20-20020a1709065ad400b00988be3c1d87sm1784420ejs.116.2023.07.28.01.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:39:59 -0700 (PDT)
Message-ID: <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Fri, 28 Jul 2023 10:42:31 +0200
In-Reply-To: <20230727150324.1157933-2-olivier.moysan@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
         <20230727150324.1157933-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
> Add a new device type in IIO framework.
> This backend device does not compute channel attributes and does not expo=
se
> them through sysfs, as done typically in iio-rescale frontend device.
> Instead, it allows to report information applying to channel
> attributes through callbacks. These backend devices can be cascaded
> to represent chained components.
> An IIO device configured as a consumer of a backend device can compute
> the channel attributes of the whole chain.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
> =C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/industrialio-backend.c | 107 ++++++++++++++++++++++++++=
+++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 56 +++++++++++++++
> =C2=A03 files changed, 164 insertions(+)
> =C2=A0create mode 100644 drivers/iio/industrialio-backend.c
> =C2=A0create mode 100644 include/linux/iio/backend.h
>=20
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 9622347a1c1b..9b59c6ab1738 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -5,6 +5,7 @@
> =C2=A0
> =C2=A0obj-$(CONFIG_IIO) +=3D industrialio.o
> =C2=A0industrialio-y :=3D industrialio-core.o industrialio-event.o inkern=
.o
> +industrialio-$(CONFIG_IIO_BACKEND) +=3D industrialio-backend.o
> =C2=A0industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffer.o
> =C2=A0industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trigger.o
> =C2=A0
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> new file mode 100644
> index 000000000000..7d0625889873
> --- /dev/null
> +++ b/drivers/iio/industrialio-backend.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* The industrial I/O core, backend handling functions
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/property.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/backend.h>
> +
> +static DEFINE_IDA(iio_backend_ida);
> +
> +#define to_iio_backend(_device) container_of((_device), struct iio_backe=
nd,
> dev)
> +
> +static void iio_backend_release(struct device *device)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *backend =
=3D to_iio_backend(device);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend->name);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(backend);
> +}
> +
> +static const struct device_type iio_backend_type =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.release =3D iio_backend_relea=
se,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "iio_backend_device"=
,
> +};
> +
> +struct iio_backend *iio_backend_alloc(struct device *parent)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_backend *backend;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend =3D devm_kzalloc(paren=
t, sizeof(*backend), GFP_KERNEL);
>=20

No error checking.=C2=A0

I guess a lot of cleanings are still missing but the important thing I want=
ed to
notice is that the above pattern is not ok.=20
Your 'struct iio_backend *backend'' embeds a 'stuct device' which is a
refcounted object. Nevertheless, you're binding the lifetime of your object=
 to
the parent device and that is wrong. The reason is that as soon as your par=
ent
device get's released or just unbinded from it's driver, all the devres stu=
ff
(including your 'struct iio_backend' object) will be released independent o=
f
your 'struct device' refcount value...

So, you might argue this won't ever be an issue in here but the pattern is =
still
wrong. There are some talks about this, the last one was given at the lates=
t
EOSS:

https://www.youtube.com/watch?v=3DHCiJL7djGw8&list=3DPLbzoR-pLrL6pY8a8zSKRC=
6-AihFrruOkq&index=3D27&ab_channel=3DTheLinuxFoundation

- Nuno S=C3=A1


