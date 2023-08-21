Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C18782EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjHUQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbjHUQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:51:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE24FF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so5400815e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692636654; x=1693241454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9fodBt04c536LJWMoMDjUdEcEJp/A4h9B/3P+dVr/w=;
        b=L4K1/yuC13QeQPEZEH++k6DTUyC5VFBGXvs/DHvyVBvBZZNdsUgEgbDEGpgXTZr8Bi
         pa0S+XAVz7r5xxUeRE2cawnJ2085GBhNXj0YkPfEwTzwN17DohTxM633BQS6ZEIfviQC
         B/PcXQvp5ihCkSXwN846E6Ac5NrR7auLEFCc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636654; x=1693241454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9fodBt04c536LJWMoMDjUdEcEJp/A4h9B/3P+dVr/w=;
        b=bjyibdif37smuAbFkUO8v061GVqX78bh9BTwe4eWljqCa4twxookOEsOJgI7frIpvX
         /MZe2E3XWAyJqe6UmxlCXEhUdwmOG4I6/dGtXQB0dzgY2s6WzUX4Ed3JaDoIIdPWW7I8
         IaygHcbOytD8cuMwyIGpfjUuDA5bsaLz9atOS1qQHtX2+i6KAdSIp2XjR7pUYFXpaYPY
         IFaQd5G0HtZgWOG8hVAOReQ3xd7s/Cvwvex8yaTI7t6cIgf4IY7GyNuQ2vypGOmFi6Qo
         sUBjBkMgOG/nZmZRjye0sDPlaOsWbjqq27YlvT9L9+O9NwIyflO8vOVXN06tH0hNsl1S
         qPHw==
X-Gm-Message-State: AOJu0YwT6+/ueo9GgbaUSyEWQsUrRKSk2KOtb01LY/Vs2ZBrgqvRsRKg
        5Ys6zsgDCbp5VQ9dgkhA3f2gAq9h/kd+lLIrGM8b1DZU
X-Google-Smtp-Source: AGHT+IHKHACGmYUai/fKJSE4iNHnPpuyYNgZiKoH/TGK3POYmSwiT0moICS6aZ+0bTr4O+KweBnmQg==
X-Received: by 2002:a05:6512:20c2:b0:4fe:ca4:7cd3 with SMTP id u2-20020a05651220c200b004fe0ca47cd3mr4034982lfr.23.1692636654691;
        Mon, 21 Aug 2023 09:50:54 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id i1-20020a056402054100b005255ddb67c7sm6260505edx.40.2023.08.21.09.50.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:50:54 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so2735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba0:b0:3fe:dd72:13ae with SMTP id
 n32-20020a05600c3ba000b003fedd7213aemr6498wms.0.1692636654089; Mon, 21 Aug
 2023 09:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <a50c32692cfecfa0449ef4943388e9ad9bf4615f.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <a50c32692cfecfa0449ef4943388e9ad9bf4615f.1692484240.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 09:50:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLmnOnZns5kEwRPm8=MS21i8kuApAq7y1zT7iS3r395Q@mail.gmail.com>
Message-ID: <CAD=FV=XLmnOnZns5kEwRPm8=MS21i8kuApAq7y1zT7iS3r395Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] regulator: core: remove `goto`s from resolve_supply()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 19, 2023 at 3:46=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:
>
> Since 14a71d509ac8 ("Fix lockdep warning resolving supplies") the `out`
> label is just `return ret;`. Inline it for easier reading.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c

Please also remove the initialization of ret to 0 ("int ret =3D 0;") at
the start of the function. Then:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
