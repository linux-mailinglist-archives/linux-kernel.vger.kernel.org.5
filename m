Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED4F768127
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjG2TCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjG2TCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:02:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF073580;
        Sat, 29 Jul 2023 12:02:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99b9161b94aso485308466b.1;
        Sat, 29 Jul 2023 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690657331; x=1691262131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRRM3V/fhfbk4swxDnRjXiwrMJ1xOP6GUPvikr85J0I=;
        b=AiS1B7fs+dGM33XXRn4MrbV+dKh0ChRaqW2YQngMkIlOch1whnjCy7fVH1b7QMUoAy
         KpLUo3jbA5/dMVYFEr6rxh7DJiDvzUrs4Wu70B3e462bFo8Pz0n1jCFnCgYMOFsskClQ
         YzFHyLJvMD1AuIj6zpj//pFVchpTn4T+bXwlHwUqsBhM2o1InQig8ETmLSrwfvlKhBhO
         gkcz17BcONg9oKfH5DDWHyjG6CM9BSMvVL66MX3jpBQ83d0fX+ZvLM92T2ID3kCsV2FX
         Um3MdmQr3mssQBDYmZXzN0nayioQWdnTqkW2gpVmWAxARhH6/oTUvuOcwVMzjL5hn4WF
         McqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657331; x=1691262131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRRM3V/fhfbk4swxDnRjXiwrMJ1xOP6GUPvikr85J0I=;
        b=G5aR+bwGwc4gkdS/DigumA0ulMJlTjnIC7PqVTfO1H57rOGsBfoZwvpAkioOGUzObh
         fuIBqsRKQlH8LWCKW1H8LpInZIJZB0txjqh/mHaFW1fSIvcd0HH33iB+rVcZvX4DeBtG
         8Lqa0EnZPXCLh6FAUhCbEl/2fU/D+pdv2Po9Do/ni3G3MRtrnENW/iCfNrRL6QRwQ4IY
         hV4DXbBO8o+FC3Y/1WFIOXnu/KiixWUsnOtA5aGusvN6aTqEvJPbFS5kYiju5972Yf/n
         GdR7Zq7m1+dA4ZLDTIxEAxnLDQ4FXBa9AgWaAIHB9l+8gleJXjem9s8bkgtACWrk6ls4
         ACBw==
X-Gm-Message-State: ABy/qLZ55VMNio8MBPdbDdx/aCmD/tRuc3bz+YzbDH5EQlD5x18/ybuR
        w43vHwNiUYemlW7PWt8DtNTeHoOZXEM2YFImDd4=
X-Google-Smtp-Source: APBJJlEXZ9ayh2OJoMb4eASEbHvDZRxUGjPivvxsURfvQuCXy+aTYhdrRqL+AAl8WxAv2JZWxF5jPwgK0RQTUVgR7A4=
X-Received: by 2002:a17:906:73d3:b0:973:fd02:a41f with SMTP id
 n19-20020a17090673d300b00973fd02a41fmr3053590ejl.40.1690657330825; Sat, 29
 Jul 2023 12:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com> <20230727070051.17778-22-frank.li@vivo.com>
In-Reply-To: <20230727070051.17778-22-frank.li@vivo.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 29 Jul 2023 21:01:59 +0200
Message-ID: <CAFBinCA+xf+nOt+E-jUxW72mW_GjCL8GXPOgxkNAM5TPbJw4kg@mail.gmail.com>
Subject: Re: [PATCH v3 22/62] mmc: meson-mx-sdhc: Convert to platform remove
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
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
