Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB94E768125
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjG2TCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2TB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:01:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B590E7D;
        Sat, 29 Jul 2023 12:01:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52227884855so4769392a12.1;
        Sat, 29 Jul 2023 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690657316; x=1691262116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JewjP4gzG3wPRwk+PPYrVv5BM6h635y61OQNgYt1XdI=;
        b=nVdFgNkc3aXFNGd0myraj19Xcf0QZrKaVxz6cZ82aeOXKko/LDNNJQrs/W/Q1Rbv/s
         0ja+W6xk6g8p+Yft/PAQ299/y16MC/HpA57dH0uJFC+SvLAL7MVyP2N17YYXrcwFMWFu
         ZblCZLAlevbNmxt5VrxIbSvVdQkoYQI3eEFIexKNJNPEi/Xd9aIakMLqNY8Jxy8dlKAK
         eWf4QW4RwkkQkXGmxND9pn3ZB4VXaaMiTaY+T5RU8eWBwqeuYybV8kp5ND8soSkOO4u8
         5Dxqxeh3yl9e64lH2QvCed5RE+ohp8C08cw2G5+n++P1zVThOVbqrg9wLrBFGRce/wq0
         gkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657316; x=1691262116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JewjP4gzG3wPRwk+PPYrVv5BM6h635y61OQNgYt1XdI=;
        b=CPtU/c41tjmhjUQ9jA9sIyedTEQeyf7OrdixRY95dT5DOupqDxtS4S98p9f6Rr/Ncr
         hB1D5Fa0V8MOOAn3YVTTkQgr6s/Azwh665dC7NmsCcXKWGbbvzDi2H1LcbB1Q/u4gJ7+
         6GHAK3ENr31GkM0toOsPVK5VnJYoPpNRqOYgj4JzVT8g0gUovNetNP5OY8WhflK98yoj
         ROn71LeopThM6BOOK4+dPquCZ2tOmWnWFAVItQxH/KWI4lYn+X25SwJfxIAzX4qommUM
         DplHUr/TeIV4K65VqyFob9QVNOM7epAGksvWAiS0RrIw/iXubcY4WqzJHeqCp9mk3FqM
         SENQ==
X-Gm-Message-State: ABy/qLatE4Y9pmO2qp+FaTboWIRONy0G11ze8G9VEP+/g6g4Rw2j2/ZM
        7QS+8qcpQ59gPcrf28owpPQy2iD7LHL0+C/aEXk=
X-Google-Smtp-Source: APBJJlG4NN3fQvdelfE4Q81DIoY9sNO3XeylwBPfNevJI2muL57EuCWEkWM0QqzsfOyfSeiefwPBM4E53iHhNAzLT+k=
X-Received: by 2002:a17:906:8a63:b0:99b:f4df:dd56 with SMTP id
 hy3-20020a1709068a6300b0099bf4dfdd56mr3407340ejc.6.1690657315332; Sat, 29 Jul
 2023 12:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com> <20230727070051.17778-19-frank.li@vivo.com>
In-Reply-To: <20230727070051.17778-19-frank.li@vivo.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 29 Jul 2023 21:01:44 +0200
Message-ID: <CAFBinCBS+hrSSRU-BQU0sgx044X-Rap_r_-9GBsf+S14xXNgzQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/62] mmc: meson-gx: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 9:01=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
