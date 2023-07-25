Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEE17620BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGYR6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGYR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:58:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69F91FDE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9922d6f003cso987259366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690307906; x=1690912706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaGwDr9AOa0YcSew23uPTw15yDAJZfLiLPUyBUI4SsE=;
        b=X7k/1bByTsLMMhsIwtBnrzwdTCTf1IwGXQYG+xZIdDX7M+VLZGYvQNswEkvA6mhFdV
         dL/LmPdIgTKidtd2KTNYb+ktJISP/CDARSUzo4MPWb8eNpO2eWxZnt13WvGEo9J+jSs5
         R4bek6Xcn3mh2cXlvPKHPZtc2I3bkF5Fz+IXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307906; x=1690912706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaGwDr9AOa0YcSew23uPTw15yDAJZfLiLPUyBUI4SsE=;
        b=Qfh/ZXwmbdZE4s9p02B5uGplK0ZcyFhjtqh9GXHzW6HzbIAYNAE9MqJx3GDR43fVCU
         /7XUqahgDvQ7kXixeIZwPBofKnsOXVJ8kygUOTNdHC5G/N/RO8ozDUiayZpi8728udlJ
         5Zjjkp03bmmOKzqKAwiu+pzwPouslx2KQqrzNCHeKhASHN7y3hbhDJjUiHaqeP4uIaRu
         mt4zJUG8uf9HVo5RJu6XQTjKZaEE3JlGip+FCbFSeTpwr0cmoTbefOJLfgqHiBFoL9o+
         148mNi7l1dyDTnIqKtMevkVvqStDDDUWYgZgF6PhIDJ/Y4rfmcUaBdDfMIvPs37EEX9B
         AkqA==
X-Gm-Message-State: ABy/qLaGwBwcIeK9LtGk8AapVe5wVdSinhwHEJ98EHXvLSJ8FzzdUvXr
        geOEppQDXcQ8M6tAhb/8FYtciKE7tyHECSulw51yWXq1
X-Google-Smtp-Source: APBJJlHuQaWhoEfMHgE4g3rRRwOvFS3p8C34yWONdxIT2Y8EPDWw3rBgk8h85e3W+9BbZ7XFwbwhDw==
X-Received: by 2002:a17:907:7625:b0:99b:4d3c:d7e4 with SMTP id jy5-20020a170907762500b0099b4d3cd7e4mr13113333ejc.63.1690307906319;
        Tue, 25 Jul 2023 10:58:26 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709062a4900b0098748422178sm8481197eje.56.2023.07.25.10.58.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 10:58:25 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so1691a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:58:25 -0700 (PDT)
X-Received: by 2002:a50:d6de:0:b0:522:4741:d992 with SMTP id
 l30-20020a50d6de000000b005224741d992mr145884edj.4.1690307905506; Tue, 25 Jul
 2023 10:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <1690285689-30233-1-git-send-email-quic_vnivarth@quicinc.com> <1690285689-30233-4-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1690285689-30233-4-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 10:58:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZFXiT6R=RBy=Mj4TEewHPYpz9cG6wE_SeE8=KrBVVVg@mail.gmail.com>
Message-ID: <CAD=FV=VZFXiT6R=RBy=Mj4TEewHPYpz9cG6wE_SeE8=KrBVVVg@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
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
> After setting up dma descriptors and before initiaiting dma transfer, cal=
l
> dma_wmb() to ensure all writes go through.
> This doesn't fix any reported problem but is added for safety.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This looks right to me.

Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
