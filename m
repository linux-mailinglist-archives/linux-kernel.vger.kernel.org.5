Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6D17DEE8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbjKBI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjKBI70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:59:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC0FB;
        Thu,  2 Nov 2023 01:59:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so1031343a12.0;
        Thu, 02 Nov 2023 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698915562; x=1699520362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5qQKbvv7SKoVpUvpHTTkPODQXD8ZvaiMX+6i5oIpsIQ=;
        b=a1hfWYCDkRLF2Z5EHBhROlA5RY8DcadypzGnVVs9dxpcWdKbb4+Nqr6ELXacVPsIvG
         St2TkIXGuuZcWKa27zscSalDaQAN6O0R2Ljuu49s5WXYjBCt+Fh6YAwjaPNAXlTEcS6B
         n/uFATs3VzesyXbNZOiWeGDf/9ino/mBZvlIiyUCGo7De7SalQYX+RvQ0PBV1UB7ao7f
         yrFqQth2x5hbHw3UQA65GN0iRta9HwONi4yUf6i07j56wsaWUODMx/3gzTS0o2vtdowo
         +aPEQDERYyakXETPim8O3X43IJ8ERmvKUzbNQreP3yPRzNjqbbzs06hapDvjOtjcT/j/
         4Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915562; x=1699520362;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qQKbvv7SKoVpUvpHTTkPODQXD8ZvaiMX+6i5oIpsIQ=;
        b=SnldxNDmfvcpwQ+Qse7JKU44m4LrB0tLdozojUGRU6jNno80OjQ/Is41XW+z3QbiSQ
         tsU1JyqRn/g352kupbjO1g630sjO6mN0LahzJBRUWvynB1pksYqLmZZw1QXSoIpR92K2
         hdleVmX66WibpwhQGwJ2iwjA3qhbtP7DzKWKKFvTBeFbqvQrQVQPv1FdZtjuN27UEX7T
         lKm467qKQuA3QFAN2tqa1vxVZys4UOk/Ii77az38kF16Or2i6elki3NWwclbMvJe67W9
         wGmGHjUbfGsuRNKj2KQL/FrAkqfqva5K9D/+CmEAQh5f8UEp0BpYJMaMxYfkoC6dJmkO
         IRHQ==
X-Gm-Message-State: AOJu0YziZbfuz5iALhoYFlFYcu1tQkVdhXd/87a1OWwfk9NlgtgL84TM
        Hk2CIXtpJV+/wATvs/TYY7o=
X-Google-Smtp-Source: AGHT+IFS54sVTvjFoyPXZ2FI39idPC94wI+egGSzkzfgRkmXSqYwtHwWeCQ78tFTGleRNimZj7kOMw==
X-Received: by 2002:a05:6402:3586:b0:53d:d879:34f3 with SMTP id y6-20020a056402358600b0053dd87934f3mr17994455edc.1.1698915562188;
        Thu, 02 Nov 2023 01:59:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:361b:8f29:1cbf:5e69? (p200300f6ef1b2000361b8f291cbf5e69.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:361b:8f29:1cbf:5e69])
        by smtp.gmail.com with ESMTPSA id s28-20020a50ab1c000000b0053dfd3519f4sm2070630edc.22.2023.11.02.01.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:59:21 -0700 (PDT)
Message-ID: <3ea3d92db5c4c077a76b29dc5a89c4d491695752.camel@gmail.com>
Subject: Re: [PATCH] iio: triggered-buffer: prevent possible freeing of
 wrong buffer
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Nov 2023 10:02:15 +0100
In-Reply-To: <20231031210521.1661552-1-dlechner@baylibre.com>
References: <20231031210521.1661552-1-dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
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

On Tue, 2023-10-31 at 16:05 -0500, David Lechner wrote:
> Commit ee708e6baacd ("iio: buffer: introduce support for attaching more
> IIO buffers") introduced support for multiple buffers per indio_dev but
> left indio_dev->buffer for a few legacy use cases.
>=20
> In the case of the triggered buffer, iio_triggered_buffer_cleanup()
> still assumes that indio_dev->buffer points to the buffer allocated by
> iio_triggered_buffer_setup_ext(). However, since
> iio_triggered_buffer_setup_ext() now calls iio_device_attach_buffer()
> to attach the buffer, indio_dev->buffer will only point to the buffer
> allocated by iio_device_attach_buffer() if it the first buffer attached.
>=20
> This adds a check to make sure that no other buffer has been attached
> yet to ensure that indio_dev->buffer will be assigned when
> iio_device_attach_buffer() is called.
>=20
> Fixes: ee708e6baacd ("iio: buffer: introduce support for attaching more I=
IO
> buffers")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/iio/buffer/industrialio-triggered-buffer.c | 10 ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
> b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index c7671b1f5ead..c06515987e7a 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -46,6 +46,16 @@ int iio_triggered_buffer_setup_ext(struct iio_dev
> *indio_dev,
> =C2=A0	struct iio_buffer *buffer;
> =C2=A0	int ret;
> =C2=A0
> +	/*
> +	 * iio_triggered_buffer_cleanup() assumes that the buffer allocated
> here
> +	 * is assigned to indio_dev->buffer but this is only the case if this
> +	 * function is the first caller to iio_device_attach_buffer(). If
> +	 * indio_dev->buffer is already set then we can't proceed otherwise
> the
> +	 * cleanup function will try to free a buffer that was not allocated
> here.
> +	 */
> +	if (indio_dev->buffer)
> +		return -EADDRINUSE;
> +

Hmmm, good catch! But I think this is just workarounding the real problem
because like this, you can only have a triggered buffer by device. This sho=
uld
be fine as we don't really have any multi buffer user so far but ideally it
should be possible.

Long term we might want to think about moving 'pollfunc' to be a per buffer
thing. Not sure how much trouble that would be given that a trigger is also=
 per
device and I don't know if it would make sense to have a trigger per buffer=
?!
Ideally, given the multi buffer concept, I would say it makes sense but it =
might
be difficult to accomplish. So better to think about it only if there's a r=
eal
usecase for it.=C2=A0

On thing that I guess it could be done is to change the triggered API so it
returns a buffer and so iio_triggered_buffer_cleanup() would also get a poi=
nter
to the buffer it allocated (similar to what DMA buffer's are doing). But th=
at's
indeed also bigger change... Bahh, I'm likely over complicating things for =
now.
Fell free to:

Acked-by: Nuno Sa <nuno.sa@analog.com>


