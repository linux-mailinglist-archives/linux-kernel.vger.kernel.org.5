Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5730768129
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjG2TCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjG2TC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:02:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD735B8;
        Sat, 29 Jul 2023 12:02:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99b9421aaebso446750066b.2;
        Sat, 29 Jul 2023 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690657343; x=1691262143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbwxOo0rYZaBf7rK29/+zBVbIyIuQuXZw1K3yD81hfw=;
        b=qqgKsyvm1cURFa0kmIdwXTlP4iWRb4n0WSxpNHt/XPzwWMaAwrdIRW4b2QmL3loEVw
         X8uYLYwD18cr6aq6R8+QJAuwKZirccUnOmn0Sxrb1i2dPobTOrKIzroLlTEwgGAdbpwS
         J2am7zwSVmYTk2JnPc6hkGvM2MmTy4g0qlgsWF7G0krgyvhmlmieRBkI/iMw4dHUsYjl
         7J4xdreUdwjdablWi7ce79vG+5rPllGMvNiMOnmNi5JJIP1i/WEFuFGbSocVQ21VXI+f
         NXrmKzV71NQ38IraKdOmfk7UzRORBad3bxNed2QPWNEB9udPl+6LvcXYPPTZuSXDyJ+F
         SA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657343; x=1691262143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbwxOo0rYZaBf7rK29/+zBVbIyIuQuXZw1K3yD81hfw=;
        b=Yup+F7ZCaSHCVaIat01rtbJX7BbpuiGyeqCVjlEQp5MvCLy1fCqFtmrLNGAovR2E2v
         9RbTgzIMhA5ObTgudS8mQfwbry/UEIl33+c3F2/gwmeTOn8flNgpV/R4mbBWsEwXrtVn
         ko0w2jnM78+YevMVi8cn6EAvcMWTHhhL0paYsP1NyFP+HAGf+enBFeWcpNSfAfBzKqdx
         00zVI0P4giuT/4Cb5oentbQDWsFib+QouK071dpfLFfruiIGo2YqMtHKzVUs+v3gc1RE
         6SrqzW/NIJVa/gkNLMKDsPmYa2MJ/FudKvXOiu8D1aJGVrIFupqAPr3SQqN4QKr5Bh2L
         Rbsw==
X-Gm-Message-State: ABy/qLYyg8kM4hPRhMR4SpAB6KL65oq9Ou/zUm/GKVArZdWkj4g6Ms20
        ZDGp4LQxasEW3soFg8zwWntjxANceir+5vzQ9yk=
X-Google-Smtp-Source: APBJJlHKcmz/y1QtxHjO1aYGSheR17Kiu7PBj4dt7wZEWJJm3KSZezSQA20D0SHQZNMoiudt8fsVxA7ivGeg2xJb1UQ=
X-Received: by 2002:a17:906:32cb:b0:99c:3b4:940f with SMTP id
 k11-20020a17090632cb00b0099c03b4940fmr1296569ejk.27.1690657343026; Sat, 29
 Jul 2023 12:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com> <20230727070051.17778-34-frank.li@vivo.com>
In-Reply-To: <20230727070051.17778-34-frank.li@vivo.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 29 Jul 2023 21:02:12 +0200
Message-ID: <CAFBinCAXph1VS=zYTs=7A10BFKeNJ1SCyRXorTQ9rCxXjX64QA@mail.gmail.com>
Subject: Re: [PATCH v3 34/62] mmc: meson-mx-sdio: Convert to platform remove
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 9:02=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
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
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
