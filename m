Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F977B3AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjI2T0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjI2T0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:26:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20111B6;
        Fri, 29 Sep 2023 12:26:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so11522393b3a.0;
        Fri, 29 Sep 2023 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696015602; x=1696620402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUXNI3po+/Vt9bmTMIbiovU5fq/gYt/VDXf8G28gpWU=;
        b=nOD6ZcTys8jfGWMzBsCZ4wCuJhyWhONS+FwBwWIcRI2DwMDatyx4FyL6S77rdlHc6q
         x6pqJAcyMQwDRokn8/Iy0MZvUXYA3L+YJwQxJhA63vLTr8SpgQ63G3KfNF9k2c4N+Qcp
         23a8ogUYpBsMHomy5nioycr509EbctA6ICTgzZJKrhkI4OuskKhMAsReAKcpZYR4+CWl
         tBrca7wJFUeskF5nVE1WHM6tb099SDd4Df3+C/E0jOteOLgj//0Tm9flc2qNYGqvrvf2
         pzGwG4H1cYa6ZVNRMKz/CJUxbdzur3SHgXyv27RqZ5mY/OovaizWgwz+zVjeJPca4Bdj
         25Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015602; x=1696620402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUXNI3po+/Vt9bmTMIbiovU5fq/gYt/VDXf8G28gpWU=;
        b=gmE4nMWo5aC1BWIs3hDhYi0HZhNckv958rhaplX/mL7dqJlv5WUFJZyoRXYv6n8jFF
         quJvhNa50qVkb4O6sL59/iQHDUr+7/o6z3T7ZmJJCxYpAFRlKpM8llR7HyF0N4oYKPB7
         gZYval4pKeDC218n7p4KKFwu1VQIrebT81a3/S5gRUMmzwm+VKbWZXxbWdbmkkVNczN2
         H7RKaWs1PlT0DZ9k3V24c2iK+eQNAjtwnbUWxn4UDZQMBqYe06w9t1/jTUO9M7bPg/3+
         yaFruhv6+Q6PvH7TTVrvL6KjK1L/wRdaid+/RHa7Vc/3J4fxmJQ1QFBvPaVDimT4ebT5
         GOeQ==
X-Gm-Message-State: AOJu0YzZlIuv8joQEukmIASwhPxdNV/U/hmtB+9zcg+gxF0MvGAodyKN
        KGJwPh6AdHjDzK3o3jslcNP4HIVFZEgpmBDUDf8=
X-Google-Smtp-Source: AGHT+IGOL4Zp8n7ERGHWHF4XXF/UhMFa1Bp8s5jSqDxTmHUO3QCvbKFN/BV4m7ib5I4oSPH/zbODv8J8bcvZCAWNcPE=
X-Received: by 2002:a05:6a21:328c:b0:15c:cde5:fb02 with SMTP id
 yt12-20020a056a21328c00b0015ccde5fb02mr5818476pzb.52.1696015602168; Fri, 29
 Sep 2023 12:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230928151631.149333-1-jcmvbkbc@gmail.com> <20230928151631.149333-2-jcmvbkbc@gmail.com>
 <69902af8-103-38a8-c438-87f7a047497@linux.intel.com>
In-Reply-To: <69902af8-103-38a8-c438-87f7a047497@linux.intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 29 Sep 2023 12:26:30 -0700
Message-ID: <CAMo8Bf+pXvSZGd0gkXbBd75gKb4dAJ1iNCxufxtud8yUdT5pyw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] serial: core: tidy invalid baudrate handling in uart_get_baud_rate
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:34=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> While looking into this, I found this old commit:
>
> commit 16ae2a877bf4179737921235e85ceffd7b79354f
> Author: Alan Cox <alan@linux.intel.com>
> Date:   Mon Jan 4 16:26:21 2010 +0000
>
>     serial: Fix crash if the minimum rate of the device is > 9600 baud
>
>     In that situation if the old rate is invalid and the new rate is inva=
lid
>     and the chip cannot do 9600 baud we report zero, which makes all the
>     drivers explode.
>
>     Instead force the rate based on min/max
>
> But for some reason it does not work as advertized here? What is the exac=
t
> cause for that?

In my case I see that tty_termios_encode_baud_rate() is called with
ibaud =3D=3D obaud =3D=3D 9769, but it finds the closest rate 9600, which i=
s
within 2% of the actual minimum, but is outside the min/max range
supported by the hardware.

> Is something wrong with how min/max have that +1/-1 there or what?

--=20
Thanks.
-- Max
