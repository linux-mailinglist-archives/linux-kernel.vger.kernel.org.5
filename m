Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9A8039C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbjLDQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjLDQJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:09:58 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6E95;
        Mon,  4 Dec 2023 08:10:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso1503881e87.2;
        Mon, 04 Dec 2023 08:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706203; x=1702311003; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXEOTOPt4KaksZ2Jf2sfO5Vl3iy+KKQQtD8/P41+pGw=;
        b=Kh5LUkE8YqnjGFJxe89IBCMf7pJZOhCxfkTX43GoIhry2vghgxm1PgqJLl6QplI4Ro
         KGmeLot6ItieAYeOVzU+a72iDdEqpOJI/E2MZCiHAALDBYwny/taOTl11m7kiGIOdVFU
         39wFJCo57B7lrUrFfHzRzAgAtM5ITLkDAyov+kfK1thyA/oQhH68J9oirr1nH9jVJVqk
         jz0L1QnUcJ/SFcC5xgP3SPiQIDlR9e3fERSdTL0615qzbqftFGFtp4mHk5BuXfTzAhB4
         dfKEvkIFlAOibpYo0qUn2trKIRuWMdvcOq6L1SJSdUz0e5ZGgVUAYslF/kWR2AFiVOHk
         UWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706203; x=1702311003;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXEOTOPt4KaksZ2Jf2sfO5Vl3iy+KKQQtD8/P41+pGw=;
        b=pDWwGdu2M/XgZbPk/jVGpG7SOHNi1oJwtKgIifOTgLuVUZtWAuHmjzFub+EINeYjiI
         gq7aylMV7fChkTiJr9IaIFOf+NH9RBKarVBSRh0vOojDawpkj7c0YMHDzHUoiIwnxYt6
         GyygEUnmD3tp927zy5rKpnn3TV3OXJMzyn5gRMKcBfcZawdS9tQsC5UfokLbR8nVmpH2
         mfx5ipIaGsDX2Bz4R3k0TvAKbZ6b5W8w7bw+nEwDy6qYdLxEPhDWjruef23KdKeL3Kj1
         9Fj1LPi2O+64o0Lmy4CT779LIKgjM+KPA9O5sqCUyaIjtV+WwHv52aQqVYjosaCU9Mo2
         wR6g==
X-Gm-Message-State: AOJu0YyS/D1pXtwI2TekagGFsJ7jRoJSbxf0iSCOihe4hUkjYih6v5qC
        MLHeaCWXY1yyK6eN4e7+ndw=
X-Google-Smtp-Source: AGHT+IGrgSTLeQgZNtNCnwebWfodvyf80a3JECT6ZZpgKiAz9YVmobqovZ1KD/dkW1dsBBl3lfBa/Q==
X-Received: by 2002:a19:380d:0:b0:50b:f110:20c with SMTP id f13-20020a19380d000000b0050bf110020cmr558107lfa.217.1701706202672;
        Mon, 04 Dec 2023 08:10:02 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b003333ed23356sm6067577wrr.4.2023.12.04.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:10:02 -0800 (PST)
Message-ID: <69a7ca77055fc57cff6d6be95fb5796723171230.camel@gmail.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct ad9467_state
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno Sa via B4 Relay 
        <devnull+nuno.sa.analog.com@kernel.org>
Cc:     nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Mon, 04 Dec 2023 17:10:01 +0100
In-Reply-To: <20231204152301.6c212539@jic23-huawei>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
         <20231204152301.6c212539@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-12-04 at 15:23 +0000, Jonathan Cameron wrote:
> On Tue, 21 Nov 2023 11:20:19 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> > are done which means we need to properly protect the whole operation so
> > we are sure we will be in a sane state if two concurrent calls occur.
> >=20
> > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/ad9467.c | 6 +++++-
> > =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 04474dbfa631..91821dee03b7 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -4,7 +4,7 @@
> > =C2=A0 *
> > =C2=A0 * Copyright 2012-2020 Analog Devices Inc.
> > =C2=A0 */
> > -
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/mutex.h>
> > =C2=A0#include <linux/device.h>
> > @@ -122,6 +122,8 @@ struct ad9467_state {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0output_mode;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct gpio_desc=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*pwrdown_gpio;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* protect against concurren=
t accesses to the device */
> Not very specific.=C2=A0 Concurrent access usually fine at granularity of
> individual read/write as the bus locks protect it.=C2=A0 What state
> is actually being protected?=C2=A0 A shared buffer or some state that we
> need to ensure remains consistent between driver and device?

At this point not any buffer/data... Just making sure things remain consist=
ent
(typical case when you have multiple reads/writes to the device). That's wh=
y a tried
to emphasize "accesses to the device". Maybe I should make it explicit I'm =
speaking
about multiple reads/writes.

- Nuno S=C3=A1
>=20
