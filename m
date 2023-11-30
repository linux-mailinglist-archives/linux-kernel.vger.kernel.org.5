Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44DD7FFDC0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjK3VoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:44:23 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CDE10F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:44:28 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9bd3557cfso19298411fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701380667; x=1701985467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcZqiHLWoReq83Cxef52pZESC4paMXVnCulpFCcMJGI=;
        b=gGjZzwiaGXEFeRkNwS0s1Jf1Q9LfP397rmDZkkjcz467+1msr+lBUBNhldQJyqR6JO
         MXlJIJtSV7fnPmAqmFJnGh3URwijaT4sUI0GKcyyw9uadU1ZAaBMXrQTT+BhlkIljKhD
         7M+rM/MiPWyN4CpXQ3QI5umIuDDSsqsrDiBsn4CXYkoIP2DiuMlgpnBtC+YCChjhaNBz
         NyQRltzYvmupPkA/KmCvGfGr5ByVcbzwOQQf96uefxxw8658BPVqnPGJwS7ZIQf/Y4ey
         HSXhAuvy7OK5GrbZLjMWe1v7omYdj6Q1p5CdYvXhGbVLD1+KAU8GZUWq0r5xbJ8IIdbm
         jAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380667; x=1701985467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcZqiHLWoReq83Cxef52pZESC4paMXVnCulpFCcMJGI=;
        b=JuruEWswWnVUZwYLo0Qx8aEpuB/U4cVkITXVMxyKmXDtZq3qmikZkiWub/POWZWboI
         x+PY+D68vMo56So3mXwx1z5DO9esoYJn9UFAs2t+2yVClCOx5NzLvnp+xBEhWZE0PAHW
         h6vt2vmu/IEHNoo93KjUXKSWEaz3UeLjdsdINErdTsE1J9hEJwIHhb6BgeMd/RZ1RC0Q
         dn7OvkIT8AqAonjOFwQpM5V5XmHIitMB1kteyTXg9kY5dT389dD0oa9GvjFxmcWC3ab+
         ntdfT6iJUMiE3O2H2AYif3IEATbWuwkdTMBSOv0HdZEja+A43setXSk/DeU3QrNJZTyr
         x3hA==
X-Gm-Message-State: AOJu0YyOx0zQdwayYfVWx/TKQ1oKMggpLlioabbSiSCLUTcukoWyJa0r
        7L8MYDncvnZW+lDv243M+f9GAWV7RydTetuG4hiYDw==
X-Google-Smtp-Source: AGHT+IHLWvfu/I4foDw3iXqoTYiQCncxW1ovcM/HPP3NH1jlHK/mie5mYCLySX0I3tqh8iKe6sLn7oyeamwjSluzVSU=
X-Received: by 2002:a2e:a3d2:0:b0:2c9:d872:abe8 with SMTP id
 w18-20020a2ea3d2000000b002c9d872abe8mr130629lje.102.1701380666724; Thu, 30
 Nov 2023 13:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com> <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 30 Nov 2023 15:44:16 -0600
Message-ID: <CAMknhBG6Ji2JwPvmBQQkReTf2ocfypOpbVBHK1s27=myeQERTg@mail.gmail.com>
Subject: Re: [PATCH 05/12] iio: adc: ad9467: don't ignore error codes
To:     nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Make sure functions that return errors are not ignored.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 368ea57be117..04474dbfa631 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/mutex.h>

This looks like an unrelated change (should probably be in a separate commi=
t).

>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
