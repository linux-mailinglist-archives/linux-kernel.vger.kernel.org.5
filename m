Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAC75E4A5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGWTyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGWTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:54:11 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0B1B0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:54:10 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ca4a6e11f55so2947943276.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690142049; x=1690746849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZi7468TmEqGbvwfshCak5drGfAiGWilfpY0t8frKx8=;
        b=YbU8ghtzDZunCrfBBFNOElDn8UxWFPR/dSjzoE/nGX8HFJEN4N2M2z+xEGZP6q3sqK
         5mXqS9oYYlS4tsZ08AOWdDvk7XMHa5Fve2qSOkNaRxXEjg0DivUNoRa0ioqerp2d1Mzr
         0NLPJ9Hm9gNwIERIE/vuo27z5l+K4QtPaWubFswrTFz2G+b6bW40ad/VYVZV8P4lNuKd
         GnLbfJRxbNHMVm9tYmrW4ptIuYr7PHP7I+0+BIGq/G5t1v2lduFl01e48f9lPsw/xJ4P
         NmVkaCXun+SWBlDbJsirKQDOczuXsimNAW3f9fah1IIZp33JjV/9EPnE5wchQY2fLXcO
         pRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690142049; x=1690746849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZi7468TmEqGbvwfshCak5drGfAiGWilfpY0t8frKx8=;
        b=dwHBqF6Hhy13PJraoXdKUrcJvM1OIR/NR/prdzkY+ivUfHynQ5gTarCuJQm++E2Di4
         lkUuJHjlXHez19tK/TOYiE8TqXZZkiT0fQBbiox0XsaRMfmE6oSmDg8Hf5SDRRrfF6PN
         vM/b/AM3l2dHT9vCbf6myTZJC4sR/9ZVBD1lUG/3zxvPcaDvbTu5AkdKIlW07aVrqe49
         eedubEv7socoNQteFTVgOd73q3w/NiyPcthRQOzHU3fWeEkNgtMmHi92xRYG8gIkTiow
         ho6y6bhVb0HK0mUctc4l8dbK2fiGnc2ytHA6xucTX3Xy1pxSwVw/b4dvxUgMfnboEt72
         shAQ==
X-Gm-Message-State: ABy/qLY/C5GVLPL34s9FMWp1HAxaZYs6maiuGlw+6mFPzLZ85lRQ/Guu
        myM/kmlwA0ynqVgkaZLeIWGGayUDLqITP4rXDoL13w==
X-Google-Smtp-Source: APBJJlHCrNKcdl6M0XijMLnAWdpY3ZIUf/mGSsTJSobtPuKk8YHnjonlzIno5tYiyor1jK3+RJp0FdjJibfBa2CtPSU=
X-Received: by 2002:a25:f50c:0:b0:ced:271:9508 with SMTP id
 a12-20020a25f50c000000b00ced02719508mr5279310ybe.52.1690142049012; Sun, 23
 Jul 2023 12:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230719110344.19983-1-quic_shazhuss@quicinc.com>
In-Reply-To: <20230719110344.19983-1-quic_shazhuss@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 23 Jul 2023 21:53:57 +0200
Message-ID: <CACRpkdY1S9fJxp039LwwWRP_8ASJQ8RyELKdN0xLcpCSeN92HQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sa8775p-tlmm: add gpio
 function constant
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:05=E2=80=AFPM Shazad Hussain
<quic_shazhuss@quicinc.com> wrote:

> Alternative function 'gpio' is not listed in the constants for pin
> configuration, so adding this constant to the list.
>
> Fixes: 9a2aaee23c79 ("dt-bindings: pinctrl: describe sa8775p-tlmm")
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>

Patch applied for fixes.

Yours,
Linus Walleij
