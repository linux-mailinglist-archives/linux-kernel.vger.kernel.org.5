Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2857CF371
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbjJSJCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJSJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:02:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B84312A;
        Thu, 19 Oct 2023 02:02:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-777719639adso180183885a.3;
        Thu, 19 Oct 2023 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697706144; x=1698310944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk9NQQyJeBXT6Ol7GG+VsgF3Sb2L3l2NxoYE0zAyB7Y=;
        b=XBmsi3ugdFmtjgaaaqxGewgMvjah8ALh+ojOFpIpgujGYnwMav513m7o7p1j1riTJf
         Bw7B1FRlJGSwXuejzIuhNj8JRGD8HlIj3bJ45HSq3qAJjCh6U0fK+UVVPC5EVHiEhchx
         6720Nhjq8GFZ4AgJtp6TXsYs7aoZMYw/Xaj0uXlRVgp0vsRA9GnZXaBAq2f9G+gyTRGx
         c3sNX1hu1WJug192PCemjYGA+wXBXyEByyzs6wS21p6CZw26Bg+4EdFGtYqULeMze3yh
         XMYwcHrvLTxpjHR52QTx2K3My3FNEHD+4bzF27OXbGcO7fM5UekanZbxWT8TmQYkK+6s
         +ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697706144; x=1698310944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk9NQQyJeBXT6Ol7GG+VsgF3Sb2L3l2NxoYE0zAyB7Y=;
        b=hlr65v3HO8/4Zy5EKcHeQ363sCMtwCAdmtEhMOHngfsZ1Li1Msu6MJRjaupRcwixzI
         LjpVqzk3lAaOnVG7mirhuAPfUGbBYIE3zWgRtmKNa6GPs/73Ss62fOQk/Eldy83k4Uw+
         W4ITATQCYkJbI90vlRyTrelpWyV0L/hz8FOgm53W1T/lFF4IBS84/F4o1hcReND6tPhZ
         gPiSOLKkKS48AQYz6pyjdh2n3hT9mOCf6j4rurAeDLY5GfrkCDFG6w5umnyTL9xKiWsc
         x8VHn0vpFyXgBnzyjxSiNfmJCgPxs43V/DtQTAIsz+r7EvyK9xk8jo8Yom8Ja7Ut9WbA
         QhqQ==
X-Gm-Message-State: AOJu0YyhPKxQnwJxrojdRhJAXvHt8HdeDZ9OuuL9NYbu/5MyiT+uPM4k
        uvZqgFEqjd1Vc/K9stauTiVI5VrbVWWY7kUXTrU=
X-Google-Smtp-Source: AGHT+IEkwz3nH9dOruaO1NEUCt0OBItrJ53vHuOwtCxwOfN7piQjEzoeY6VF8XfRjIQJmiAe07nLOHfOuR5PVr4GjRU=
X-Received: by 2002:a05:6214:2421:b0:66d:10fd:4abb with SMTP id
 gy1-20020a056214242100b0066d10fd4abbmr1782016qvb.16.1697706144215; Thu, 19
 Oct 2023 02:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231018182943.18700-1-ddrokosov@salutedevices.com> <20231018182943.18700-5-ddrokosov@salutedevices.com>
In-Reply-To: <20231018182943.18700-5-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Oct 2023 12:01:48 +0300
Message-ID: <CAHp75VeTVU-1mSzAX4j7s9bbDGxDR_FwgFL7dnC4_6OhsN8kpw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] leds: aw200xx: calculate dts property
 display_rows in driver
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 9:30=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> From: George Stark <gnstark@salutedevices.com>
>
> Get rid of device tree property "awinic,display-rows" and calculate it
> in driver using led definition nodes. display-row actually means number
> of current switches and depends on how leds are connected to the device.

Still the commit message does not answer the question why it's safe
for the users that have this property enabled in their DTBs (note B
letter).

...

> +       device_for_each_child_node(dev, child) {
> +               u32 source;
> +               int ret;
> +
> +               ret =3D fwnode_property_read_u32(child, "reg", &source);
> +               if (ret || source >=3D chip->cdef->channels)

Perhaps a warning?

    dev_warn(dev, "Unable to read from %pfw or apply a source channel
number\n", child);

> +                       continue;
> +
> +               max_source =3D max(max_source, source);
> +       }

...

> +       chip->display_rows =3D max_source / chip->cdef->display_size_colu=
mns + 1;
> +       if (!chip->display_rows) {
> +               dev_err(dev, "No valid led definitions found\n");
> +               return -EINVAL;

So, this part is in ->probe() flow only, correct? If so,
  return dev_err_probe(...);

> +       }

...

> +       if (aw200xx_probe_get_display_rows(dev, chip))
> +               return -EINVAL;

Why is the error code shadowed?

--=20
With Best Regards,
Andy Shevchenko
