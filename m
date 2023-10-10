Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A07BFE49
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjJJNpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjJJNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:44:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D2198D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:44:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7b92cd0ccso13076547b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945460; x=1697550260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=Hfd6muxuY+9Eds1eZ+RBD0C2c48CH5u9Dx6Cd2hpm7k5jL8xrI3/TEKmfRwjQfrzoR
         uIv3AbVVXbCh+0OlS4InjO1VJwUuXyR1hGgQ+boH4qYdbNa0EWlzLsRA3VTQ2t2FyNP+
         xbR901yxHOr8lGLdWD1Xc3NiKXZUpx2yGDQH/mmrDC2NW9nWsgK1+ETKHLDwYqtpTd2C
         ZgqX7TgJvQxlpmjs1a/RoS/4cEaAsyJm8SSE1dRWP+oinhTk/ZvXX5eZYnVYcEnaMVYb
         QBb2I+HSQgzEqVsYdlwot2gjBXT7OEQuvJLfpWBK2ea6kkSvbxvpJ2+g/+DVbTkMZOaT
         glyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945460; x=1697550260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=jkvBkUcYJte/4vfZhX442srUC6qw3MzjpAx/hK/9YaEn4V1xj4gIGrevFbBe2WlJJ4
         zdNYpEkF5+koBYnIUAS+m7AafQnGvEJqKVK+TtbnNVj/QB6QpnvI96HU11cN2F5XnMz0
         jdmTyuMqZubjw387lYRqBJCVVUhh8Sfvg/BhmMPbSZxFpYJGsojjEGDqtPoCYCcZUefM
         M6n5++xL3OfL5QXxuhoI2y+KDYpkyKnymEUBiCD5T/GQaNWWoGEXQ2Q7tNhpaYKpnPHh
         QtEkBTr1t8+10EWHUXwDCFTJoDhYS7qvYehV1AB3+Wd3GLs80i6psJFT2UkVDpK+a1yE
         vEbw==
X-Gm-Message-State: AOJu0Yw8WOV/k928DgjJZsZqxdAmHFdCSaxunj26799PGvq8dfo15zl9
        JCzy/Y4MfU8jWJG7QLGTesx5xWzsLPWx3PorPuGntHC/RIZLRe2dtW8=
X-Google-Smtp-Source: AGHT+IGPzgwlYn1dXJ4egxXKG1Kdn0b5UQFiIXiF327ltewq5kCECA8LJ4iu/KXiC6IHbqEToMvv5nzVhLpzxUCU0lw=
X-Received: by 2002:a0d:df11:0:b0:5a7:b81a:7f5d with SMTP id
 i17-20020a0ddf11000000b005a7b81a7f5dmr3036369ywe.18.1696945460664; Tue, 10
 Oct 2023 06:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-19-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-19-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:44:09 +0200
Message-ID: <CACRpkdZ9F94MzSCcoTh99MxNuvgnns+=_WEAX3kMGaRoV0CLZA@mail.gmail.com>
Subject: Re: [PATCH 18/20] pinctrl: qcom: ssbi-mpp: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:22=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
