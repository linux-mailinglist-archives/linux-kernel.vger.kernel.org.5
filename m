Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD937F096E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjKSW0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjKSW0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:26:41 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DE2711
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:26:38 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c6705515d8so28862437b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700432797; x=1701037597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tKHAEH8pm+mdyGm3S8xcZ989PK/m0lepxYWwzGVtNa8=;
        b=I4IZVNTX0ygDZDKVM/J603yMk/BFo3x27THdutavhHj5IAMmas73N4xlBnlh4mQtL0
         0+sLj3C8fj+WXELL1ue7tB0L4FiKPJqL+itsDKhD4+I3QgAhXh0KT0wLMo+h2zBkMLnc
         L7fXqJ7NzSm0CJvKxCMPMLThkG2yFfPUyxABW55wP5wM1e3T0xFIq/paV2uSutzxw1AV
         kl2qdXCKJAaIvwVstCUSWaNx9IXsOgFjjzyuBw/KTOcm5rgfYsj1TUsrAh+BT+Pl28X1
         FIzknd10AVjDSy4laEZvCEa5+CKEQb/x5kYUxV9/FWKOPNbvFoxadzyYzTQQMMsSDfTk
         GCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432797; x=1701037597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKHAEH8pm+mdyGm3S8xcZ989PK/m0lepxYWwzGVtNa8=;
        b=xKwp4+p2HVEU98NevXmdcQV7UxdiNwEInLiYO1LWC29OsmlCgD3QsB29qJdFIjG/fe
         n8seNK3ACGMRh/TIR998h/lTzxnwk+gH36n4J+ZgK801IjrL9vjBiXCdmeaQd+YGb1qC
         dHv59wTbey0cbqDc3D3NYc/NQRiBvrmp/E7N5WIVKmkroCtlXOPVz9wy8NG3XHP3RUFz
         JXyvQB8vyvkvxdrp8vGKpVO5Ww8kPFhCBAk7RWyzO7xrDBf0XWOTUih3TyXdam3z5ULT
         1y/UdHr6GmEFxXmx169v8vvDsUiFNH/b2pGeud1Dgof/oPuafVGAmGU1PCLBVaQkeWa6
         cZIw==
X-Gm-Message-State: AOJu0YzMyyxCOtWarDsIpbq7bDm5W4xZvf/yAvtT2NyGEJV2BZDOPBVe
        /3BZ87H0LZZVerdHCY8nmDqiDIlWXMhHdEd85OV1dg==
X-Google-Smtp-Source: AGHT+IEtI+WRNtdT4PtRIsdb7Gg1gy47h39hKWZ51B3OX/a2prMfArKvd71uD8hG3OuEWkkjavfqqMPGUN001gM/ruY=
X-Received: by 2002:a0d:fb86:0:b0:5a7:be61:d52b with SMTP id
 l128-20020a0dfb86000000b005a7be61d52bmr6291046ywf.24.1700432797500; Sun, 19
 Nov 2023 14:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20231119112826.5115-1-hkallweit1@gmail.com> <20231119112826.5115-15-hkallweit1@gmail.com>
In-Reply-To: <20231119112826.5115-15-hkallweit1@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 20 Nov 2023 00:26:26 +0200
Message-ID: <CAA8EJpr6uVn+MA=yzFrCybKx7j2YDXALV1i-Gh01PaR84qRkXg@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] drivers/gpu/drm/msm/hdmi/hdmi_i2c.c: remove
 I2C_CLASS_DDC support
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Clark <robdclark@gmail.com>,
        linux-i2c@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Sun, 19 Nov 2023 at 13:28, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
> olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
> Class-based device auto-detection is a legacy mechanism and shouldn't
> be used in new code. So we can remove this class completely now.
>
> Preferably this series should be applied via the i2c tree.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I'm fine with merging this patch through any of the trees that picks
up the rest of the patches.

>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_i2c.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
> index de182c004..7aa500d24 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
> @@ -249,7 +249,6 @@ struct i2c_adapter *msm_hdmi_i2c_init(struct hdmi *hdmi)
>
>
>         i2c->owner = THIS_MODULE;
> -       i2c->class = I2C_CLASS_DDC;
>         snprintf(i2c->name, sizeof(i2c->name), "msm hdmi i2c");
>         i2c->dev.parent = &hdmi->pdev->dev;
>         i2c->algo = &msm_hdmi_i2c_algorithm;
>


-- 
With best wishes
Dmitry
