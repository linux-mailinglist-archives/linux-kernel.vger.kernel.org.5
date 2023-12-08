Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082C880A90F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573952AbjLHQeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjLHQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:34:05 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EB31995
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:34:12 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cfc3a48ab2so20125877b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702053251; x=1702658051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd6zs3d/7wlhgWaZt9MCNMWIKi0xOVjce2BdpNv9ihc=;
        b=LxJXhZ+L5y6ejsTC/7PEQwEZXt6rQ02CGAvp9f2rh+XhV/GN0qcbx4pWcOrK8HZ03F
         YMh47JYDZtIcYCXKyvmabrWPfckqPOwVNxsAds2YxEHy4gyq/mmBf+p4yohSJ8IhCJQj
         zXH6j3zVCD4YXFfpgO1q/MVD1he7po4GYniNZQdsMbUzitYK1DWx6TLEVNKFtiJWCv2S
         F5iQ0+h2KSU2PSv0FEMZYG3DVljhh07P69eNaX2GHStlQliiMJdnmao+N7uDABmh6J4X
         Db1eZIM49+MNay08Fro2Bi8OM11Ijj86qVs6VMCULWyam9nnbPHbw7UChl/54Wr7fRfz
         HuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053251; x=1702658051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd6zs3d/7wlhgWaZt9MCNMWIKi0xOVjce2BdpNv9ihc=;
        b=tUAmvSDD7mLko/ldTELzYUQyuNHVnBjQqJa3xLlbIUx7/FXmJKf0bYmHyAw0IYHjZO
         3b6EdAbVBLPQIlNRPLN9yCaNtoTAP7WW+F2xF7krwXalEgcha+rKey/3VwnfCoiIzbII
         B+zryq2EFiXjfvxGKtr8/bPqt9+gEj8pD6TQ0gOk5uruZGs+pDEihheW6TNgM3UyXm8D
         ITayhnQ/hLjIeoJ5mEZZsXo7PwMs9dLfsoxcHDoUI8AwLS0b5KEjRGG0zs/aY4vf1qqf
         xyacz4lG4El2Olo14JKalfVHdp0t0mcWf7onzZoKNOVGvoBIEZ86YtIJ1DVy4xGGuFlO
         C5UA==
X-Gm-Message-State: AOJu0Yyg8CVZ5TrmWtShK7xd7tWUkvTjLtPvsNk3S6Rju8qMvi99hrI0
        vWRrrTLG3q0Q/tZN1HObIkqM1RRkBz8SqyAPCzgRCQ==
X-Google-Smtp-Source: AGHT+IHQO4oXZri4xcfxM6GgbBiWxDFZ1/f1X3OhNr74nP8bbhu0edrkTF8ilxU6KeIllljA4k+b3dUcLwgA2RxhDeA=
X-Received: by 2002:a0d:c242:0:b0:5d7:1941:aa5 with SMTP id
 e63-20020a0dc242000000b005d719410aa5mr181393ywd.64.1702053251598; Fri, 08 Dec
 2023 08:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20231208125730.10323-1-johan+linaro@kernel.org>
In-Reply-To: <20231208125730.10323-1-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 18:34:00 +0200
Message-ID: <CAA8EJpp+wZbHwetDD5pDAXJJLVO+URoZJuW8OQavf5rSTPNWzg@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: disable UCSI on sc8280xp
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 14:56, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Enabling UCSI on sc8280xp and the Lenovo ThinkPad X13s in particular
> results in a number of errors and timeouts during boot:
>
> [    9.012421] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-95)
> [   14.047379] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
> [   14.050708] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)
> [   20.192382] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
> [   20.192542] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)
>
> Disable UCSI on sc8280xp until this has been resolved.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Johan, if you can capture message traces in
pmic_glink_ucsi_locked_write() / pmic_glink_ucsi_read() /
pmic_glink_ucsi_callback(), this would help me understand what is
causing the issue.

>
> Fixes: 4db09e7b967b ("soc: qcom: pmic_glink: enable UCSI by default)
> Link: https://lore.kernel.org/r/ZXL5jvDHr-MuxMoz@hovoldconsulting.com
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/soc/qcom/pmic_glink.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 71d8901a9389..511aa40842a1 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -342,6 +342,7 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
>
>  static const struct of_device_id pmic_glink_of_match[] = {
>         { .compatible = "qcom,sc8180x-pmic-glink", .data = &pmic_glink_sc8180x_client_mask },
> +       { .compatible = "qcom,sc8280xp-pmic-glink", .data = &pmic_glink_sc8180x_client_mask },
>         { .compatible = "qcom,pmic-glink", .data = &pmic_glink_sm8450_client_mask },
>         {}
>  };
> --
> 2.41.0
>


-- 
With best wishes
Dmitry
