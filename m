Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4567F0F92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjKTJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:58:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEA59E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:58:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso5952766a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700474289; x=1701079089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx8KGcst8hZnUB0atywBnApo9bOB5kKeKwi0TRtSy2w=;
        b=QBFaV1y/9ql5ORVwAxxWAYO49p68Zap9yEVbFeq1Ei190T44P1qs+LlwldNQhHIQsu
         cN85E+7tumyMzcJlneuiydcq8pqJE5dcdIwpsTiuofBfLuExRAwo3KyJmTS5uRmHf022
         O+mknHHfCQjWBQE5AKVcV/r2zVaBXEE/P82t4kjFLz6xNCfQpxqTe3kaF9sSnkgmLWzv
         U7LT8/1VDByWkRQd2uOxaWpT2boBaIcx9ySfMmOd1oLuzgWTCdCBfvLV0j2wY/u7HAca
         nHEohCrYTk7ziVxTDmI3aBnJW7HlyVnK/S8JR2l4TuZ79L0yViCMYzMudjYKOJj/QJYs
         QvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474289; x=1701079089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx8KGcst8hZnUB0atywBnApo9bOB5kKeKwi0TRtSy2w=;
        b=i3EjKK86UhsN+c4Dr2YMtwYPGYktZwcRwN7xGJt3MaUS+JJTC7/thcFjb1R1KN0ygc
         Zu5pr8Rrwmpe488cfr6qWSBTD+LxLeMWW226TGEUE6mgfcNDTVeB4RxmTGtrU3dqpK7T
         +v9FpDvL4hh8rH4XfLQL4tfSgM81zZnDG9lmGTY2aYGUq7VaTV5g/f9M4qcJMxvEi8/z
         uL22qqnm4K25kD/CRi9fTiFwKV9xsTGqy0XwutEzOTQIZKwRqF7IiXB6s9T4Bqy+rgdu
         g8Kt+MK6QHcHxILX3t4m2qHxJbJA9bRTrW2BtTs+6vylmR2MTXv9Oqk9MtJFFcwVc3dy
         NjXg==
X-Gm-Message-State: AOJu0Yxy31Vs527fUkeeyZfBs8PZ9PS1t5yLcf49qFn//WvgnmpCDf2Y
        h5JWjcLewKVCR8KAqQ1Shphtu3TllOI6ZNkau8NssUSx7tfClA==
X-Google-Smtp-Source: AGHT+IGE1+uZH2w9ZEXVg+Vvn0R0pdA5KZgF+DVi3C22NcbI+PLG2Hwpgza/u8FK/NadtggaoT3ouXzwkHgGuamnAQU=
X-Received: by 2002:a50:fb0c:0:b0:53d:eca9:742e with SMTP id
 d12-20020a50fb0c000000b0053deca9742emr4790550edq.9.1700474289055; Mon, 20 Nov
 2023 01:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20231117163900.766996-1-daniel.baluta@oss.nxp.com> <874jhh2g8s.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874jhh2g8s.wl-kuninori.morimoto.gx@renesas.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 20 Nov 2023 11:57:56 +0200
Message-ID: <CAEnQRZBb0ZJk7aTaji-xH2jEs7QiTaoXTuS5_K-ruSaxpEnWdw@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        iuliana.prodan@nxp.com, shengjiu.wang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Morimoto-san,

On Mon, Nov 20, 2023 at 6:36=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Daniel, Mark
>
> > We can specify DAI id using reg property. When dts
> > node has only 1 DAI simple-card always assumes that DAI id is 0.
> >
> > But this is not correct in the case of SOF for example which adds DAIs
> > staticaly (See definition of snd_soc_dai_driver in sound/soc/sof/imx/im=
x8m.c)
> (snip)
> > -     args.args_count =3D (of_graph_get_endpoint_count(node) > 1);
> > +     args.args_count =3D (of_graph_get_endpoint_count(node) >=3D 1);
>
> If my understanding was correct, for example you want to use 2nd DAI
> but your DT has only 1 port (thus, it is using reg property) ?

Yes.

>
> Current simple utils is assuming (1) DT has all DAI settings, (2) having
> reg property is option.
>
> But current DT requests reg property.
> So maybe it is good time to remove non-reg-property support ?

I have no problem removing non-reg-property support. This will work
for me. Will later send a patch.

I want to understand how current non-reg-property support works.

I'm looking at commit 73b17f1a65c881fc ("SoC: simple-card-utils:
support snd_soc_get_dai_id()").

So, the reg property was introduced for cases where we can have ports
of different types? E.g
In the case of HDMI we can have Audio ports and Video ports? And we
need reg property in order
to get the correct DAI id?

I don't understand how DAI id is currently computed if we don't  have
the reg property and also
we have Non HDMI sound case:

Here is the code:

=C2=BB       /*
=C2=BB        * Non HDMI sound case, counting port/endpoint on its DT
=C2=BB        * is enough. Let's count it.
=C2=BB        */
=C2=BB       i =3D 0;
=C2=BB       id =3D -1;
=C2=BB       for_each_endpoint_of_node(node, endpoint) {
=C2=BB       =C2=BB       if (endpoint =3D=3D ep)
=C2=BB       =C2=BB       =C2=BB       id =3D i;
=C2=BB       =C2=BB       i++;
=C2=BB       }

=C2=BB       of_node_put(node);


So, this code assumes that the DAI id is exactly the number of the port, ri=
ght?
But this is wrong if we have a component (port) with multiple DAIs attached=
.

Daniel.
