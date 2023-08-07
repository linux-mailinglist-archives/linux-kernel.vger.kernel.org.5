Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC5E772795
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjHGOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjHGOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:23:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14329C2;
        Mon,  7 Aug 2023 07:23:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso6306109a12.2;
        Mon, 07 Aug 2023 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691418224; x=1692023024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTflw2x77oizGZVYhSaej804cS88CNB3gsQx6H6fr5Q=;
        b=MqybVASJYhgq/Xq7m+ZAuezyoXZACwS5eBEdQPUIkbzFWAKcsaR+nwVDE4Ooryxw/X
         mwREGJlS+jpJHArqK77sSl8+aQZg1YkPrODDVeSv+F3K1NXy4kI8nqmTRtilZRDblAZS
         7vQ8wW8cKqxFC1v/PRSBVdUC3GVJo8ePUMdQC0x7haytzDEIUig6wG7APXEX6E1KCFhi
         57Wl0+zi7OWXl/og9JFmGNNyHgiiX97ihfR0Vyf0s42SNArubWj31XWWX0iyOc0kkiRM
         /RloG7Eh6DtmcRUVPynL8/6Ne/ukGE9Ptsnl5xIuTxkgxokwcR+mzV2a3xFvPVSuKzKU
         RO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418224; x=1692023024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mTflw2x77oizGZVYhSaej804cS88CNB3gsQx6H6fr5Q=;
        b=e/KgK2VRzcPCTlvUqaUNOt0yChFupqz0fofAGx86qZiG8NZ0pJPD2iSXDGRNoVqWgz
         C1kqaBH5cRGtLzgoDIcu4hQhqcWTFJ4rxRu7iS1KVNdfWJiXUFUpfwodbgmU2DGDwamB
         lm5P6C6HxMeptwbdW3/KFY0msCNZnPaEDI0XcWgUrtpNdEwkgQmzpAmkSY7AGgwZ78/Z
         WVZ3zEdkVXz10zMT5zxopjBdqXt5eJCeOPaFvc9N4g/3iCoCB6dty6sDfK+5NSNv3Lk1
         +DcZUE0qt05kSSN7MrBeuQ/Xll8P3sEtQu32qTxY2iKA9kJGu+T9UPfRHgD1INffS/+s
         ecyA==
X-Gm-Message-State: AOJu0YznGBgIk+av8UimTvam0OMrWWAwH1TzvgOelzNCcjW58k9Z6Bdi
        /SBJZgfVA89Edne7ny6RMek=
X-Google-Smtp-Source: AGHT+IEdQumEhOAGOcUm1qDuqulTJZk9s7geXGLWSWuBIsER5LzI+EeEObSbLOQn5QYAzVCDQK/ieA==
X-Received: by 2002:a50:fa8e:0:b0:523:4014:4e81 with SMTP id w14-20020a50fa8e000000b0052340144e81mr226778edr.35.1691418224242;
        Mon, 07 Aug 2023 07:23:44 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef09:a500:ffed:38f8:59e7:f38e? (p200300f6ef09a500ffed38f859e7f38e.dip0.t-ipconnect.de. [2003:f6:ef09:a500:ffed:38f8:59e7:f38e])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c692000000b005224d15d3dfsm5215809edq.87.2023.08.07.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:23:43 -0700 (PDT)
Message-ID: <cef38375a5259e7df0111821b112341ed670e682.camel@gmail.com>
Subject: Re: [PATCH v4 1/3] iio: Add IIO_DELTA_ANGL channel type
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Aug 2023 16:26:17 +0200
In-Reply-To: <20230807111227.374371-2-ramona.bolboaca@analog.com>
References: <20230807111227.374371-1-ramona.bolboaca@analog.com>
         <20230807111227.374371-2-ramona.bolboaca@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
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

On Mon, 2023-08-07 at 14:12 +0300, Ramona Bolboaca wrote:
> The delta angle is defined as a piece-wise integration of angular
> velocity data. The delta angle represents the amount of
> angular displacement between two consecutive measurements and it
> is measured in radians.
>=20
> In order to track the total angular displacement during a desired
> period of time, simply sum-up the delta angle samples acquired
> during that time.
>=20
> IIO currently does not offer a suitable channel type for this
> type of measurements hence this patch adds it.
>=20
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
> =C2=A0Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
> =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A04 files changed, 18 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index a2854dc9a839..32675fa7dc6f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -279,6 +279,20 @@ Description:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0but should match other such assignments on device).
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Units after application of scale and offset are m/s=
^2.
> =C2=A0
> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/sys/bu=
s/iio/devices/iio:deviceX/in_deltaangl_x_raw
> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/sys/bu=
s/iio/devices/iio:deviceX/in_deltaangl_y_raw
> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/sys/bu=
s/iio/devices/iio:deviceX/in_deltaangl_z_raw

I wonder if we also need to add these to the scan element specific bits? Fr=
om a
quick look, it seems not all supported attributes are in there so I'm not s=
ure
what's the policy in here :)


- Nuno S=C3=A1
