Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B190779D850
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjILSGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjILSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:06:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E561E59
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:05:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so2271a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694541956; x=1695146756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYqDUs3nkzy+99JdbqiBWkMenPxzjtYzz/eA+mvCidk=;
        b=pEdgLNOfVB/fRhmxx8BGsFlFx3MoU7VDnEDB/S+Y3W9CJW04mevLIHVX3HsorF5U6R
         2V5jgW8g9AiD6yru9aaaLFh8fXC35dz0nR0GS/dQz5bdy0itnBt91HVlMjglk2tJS2Nc
         v671pgDG5oL9ootYL1U3L756IKxPQ6z4ViZ7iwq2QcG9trkO3AC/JdBwxl88Nrh+etWH
         GkNfzhv/NJwvPAw4q6GSD6Oi8188Yn9t4xT9GYDhAlmKd5muJcWuadcDPLuOd+UodnYr
         YrfSySnqyA3Id4tNKisgfBvY9QcB2DQYdU+sRBgEff+3e82ItGT6espRlAIFytmFGTUh
         l3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541956; x=1695146756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYqDUs3nkzy+99JdbqiBWkMenPxzjtYzz/eA+mvCidk=;
        b=C7/izoMEZBDCbL9ieestClhJMNcMkxE+T1AyTe869i5Tdjlf3GxqiHeB1jzZbgi68o
         PsRYrefgcu2C0+Ohl+Yz3dtN2P/7lOrA938UNhIPwZBviIzxOwJtgi6n3BDIdGqLhvsj
         7ameD8lSCzi/IGowbWMcmO9eqVs2GcIk/sNmDCOhDQ+rKkO4wIKaNGqfcEC/I2r0AX3+
         hlvzflSp3qdFJSmGpn6iNNmZu1O9l44KIpY5U1wJY93sv2zBlHQFhqiUGsbgU/eRvyN4
         FIOSjfF0YBMezFk8ui51VwGLx0QD5AwxQD6/Ol9XzCuAIgU3krw+gs8BOdg7ep9lphP0
         RVpw==
X-Gm-Message-State: AOJu0YyjyIFpXcIcY45kcVUq99DuhX/OrGtPqDhiiGr1vaU1unYP/okC
        QNKDpT5R5hi5zlagb7fCUVTy0CSz/4G03eb/1GD7CWk7f48ii4pqJnJlnA==
X-Google-Smtp-Source: AGHT+IEYr0P1WStyJpUE0/XWzPhwSlxaxamU9zj8epty3cb1jYzzDn81j9YUAjkSKqC+XdwL4wOnkp4W/jFg8vp3Jx4=
X-Received: by 2002:a50:cd59:0:b0:522:4741:d992 with SMTP id
 d25-20020a50cd59000000b005224741d992mr12316edj.4.1694541956322; Tue, 12 Sep
 2023 11:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <CANn89i+W1iAQmOhunLbqpvHu8EUO6uawv6Uvx7qimyBa_PBNCg@mail.gmail.com>
 <f3e84a37-3218-0d52-e7ed-2d215fed58e3@intel.com> <CANn89i+AwmpjM-bNuYRS26v-GRrVoucewxgmkvv25PNM4VWPGA@mail.gmail.com>
 <39c906f6-910d-01c7-404a-8fe6a161ef2e@intel.com> <CANn89i+QSPoXphaLzfKCqCHxjsD20ifr8YPJM_fZ_H5kFZ7dwQ@mail.gmail.com>
 <8bc6c1cd-50bb-44ef-5979-3bb50a70afcb@intel.com> <CANn89iL6HVvRegORfP49prJV4EJU2-AbD4YXB-eo_vwU1JG1ew@mail.gmail.com>
In-Reply-To: <CANn89iL6HVvRegORfP49prJV4EJU2-AbD4YXB-eo_vwU1JG1ew@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Sep 2023 20:05:42 +0200
Message-ID: <CANn89iKbn97Rbjc+3uZMpUi0tqCuhj88UdFZhhnqpC6nJRLC=A@mail.gmail.com>
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 8:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:

> Sure, this was what was suggested (perhaps not _very_ precisely, but
> the general idea was pretty clear).
> v2 seems ok, right ?
>
> It seems we are all on the same page.
>
> +static __cold struct net_device_core_stats __percpu
> *dev_core_stats(struct net_device *dev)
> +{
> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_all=
oc() */
> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_=
stats);
> +
> +       if (likely(p))
> +               return p;
> +
> +       return netdev_core_stats_alloc(dev);
> +}
> +
> +#define DEV_CORE_STATS_INC(FIELD)                              \
> +void dev_core_stats_##FIELD##_inc(struct net_device *dev)      \
> +{                                                              \
> +       struct net_device_core_stats __percpu *p;               \
> +                                                               \
> +       p =3D dev_core_stats(dev);                                \
> +       if (p)                                                  \
> +               this_cpu_inc(p->FIELD);                         \
> +}                                                              \
> +EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)

Oh well, I just read the patch, and it seems wrong indeed.

netdev_core_stats_alloc() is the one that can be cold.
