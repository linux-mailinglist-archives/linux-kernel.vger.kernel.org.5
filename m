Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C47620B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGYR6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGYR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:58:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9E1BE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99b78fda9a8so652775966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690307879; x=1690912679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42J2rYX3ygekl+Lm1gBSOe+L4cZsEBuPyMx4AtD46Z4=;
        b=X8Cth7TDXv7+PAUN1Yhi4ZyUQGtY/znGHjsI9oaJQ+ngh/9kS2dpBimjXxVTm+2LES
         rC3rce7v71stZ9gm+u1t4SdN3+GtXtEsdlJ5D6LqkUmUBcu4x9nxXkT+RQu7tvo4dq4M
         9caP86PyNEoZk9Lq7fnS71kjm5cQti5ZS6OTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307879; x=1690912679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42J2rYX3ygekl+Lm1gBSOe+L4cZsEBuPyMx4AtD46Z4=;
        b=dDSCOELRHeanpez9Y+82Q3qyIhowZSjjMLtoBLCawTaoZZS2kJ9d8M47/o9p2OHqOV
         YHJ3rF/odxBIPArTiZ1vzBeW9SqoqLhqySc5MaT6mrwDdrQS4otvWB39OvAfzkCy0Jp+
         igfHxNARiXjQD64/lut9EhvrUz39FzE9NrrpFjXlRXYqblgqs5XpYA4BeWe8yO/Z8Mza
         JGd7oio+KZRiiPVZrlyz8XFXCgr0ZrD18V8i8kO3okgK9cNsm4UfnDzN5c3UyzZ2zC1Z
         0Xa13btHUNngw+oo6EgrNJXGwEG17Ke+NF2ERbC9eVL7PzyA6Hf8RPYmnovNm4b7Atyp
         MYmA==
X-Gm-Message-State: ABy/qLb5NLkoACY8+yMqmrimCv04gL7IBmYKiLEA+TMx89hOn7110zGK
        qthcDsoolGkDcpvH+hoiYP4aqAiS3WESJF2izZKsbw6w
X-Google-Smtp-Source: APBJJlG17JGIHZfSWtqMYvC7XBNIVKTF4+R6xPdCeQs6KBpvUwkM0b7aSM/rFqaZvJUBLOuvjtWX4A==
X-Received: by 2002:a17:906:778f:b0:994:3207:cde3 with SMTP id s15-20020a170906778f00b009943207cde3mr14689020ejm.49.1690307879585;
        Tue, 25 Jul 2023 10:57:59 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id kd7-20020a17090798c700b00992a8a54f32sm8380322ejc.139.2023.07.25.10.57.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:57:59 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1510a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:57:58 -0700 (PDT)
X-Received: by 2002:a50:d6de:0:b0:522:4741:d992 with SMTP id
 l30-20020a50d6de000000b005224741d992mr145840edj.4.1690307878480; Tue, 25 Jul
 2023 10:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com> <1690285689-30233-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1690285689-30233-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 10:57:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wh76-1JNsaC-++9mkg1dswAgpN=ynHwNdJ997g0hCRew@mail.gmail.com>
Message-ID: <CAD=FV=Wh76-1JNsaC-++9mkg1dswAgpN=ynHwNdJ997g0hCRew@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: spi-qcom-qspi: Ignore disabled interrupts'
 status in isr
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 4:48=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> During FIFO/DMA modes dynamic switching, only corresponding interrupts ar=
e
> enabled. However its possible that FIFO related interrupt status register=
s
> get set during DMA mode. For example WR_FIFO_EMPTY bit is set during DMA
> TX.
>
> Ignore such status bits so that they don't trip unwanted operations.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 3 +++
>  1 file changed, 3 insertions(+)

Things are pretty broken without this fix, so it definitely needs a
Fixes tag so it can find its way to mainline as soon as possible:

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")

Looks good to me and also works fixes the problem for me. Thus I'm
happy with any of these tags:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
