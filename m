Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1F0800E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379347AbjLAPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379328AbjLAPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:19:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B22194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:19:42 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so229885e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701443980; x=1702048780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGODWC2uJcvDQZ7EY2xJVvkyTzj74X5vd6Vn8ASvgDA=;
        b=SnAn2aGt3/to7B2ItqBW+D6tZOt+mlVtliumgQ2fS06HOjrNO9xmgPVfn0u4fz2oAC
         Kx2q3C0V2lZnaSuW7TmdzMh5MydrCuwl//AB5+IG+AoRIbfZaJSML1OtJi3bxeUyN9gv
         2Owgdx14lZhH/3efP0OH43X0pssxh1/BTvmxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443980; x=1702048780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGODWC2uJcvDQZ7EY2xJVvkyTzj74X5vd6Vn8ASvgDA=;
        b=Ifj3/gNVwQ1aGnXeuTpnOKbYdPOJaBbIk6J0seNqRlvEhnX/vZlSEj8NlHYFtZo5ej
         9tL6lcpCSPLMbMRkkML32YUnhaM9+2cF7CgNFhFQHD6rggbx62E+8dlTO7rECfXUjRl0
         DldZOegpx7eXwY8txpGeTQAAYwwuGSMhMbd99/43s+QNIdkjUq5RckYdD0KX7xlF85LX
         tls6r2zLJZfJdv/WU32gXXfR4MDXjx8qFvZJ7NhRkAWlNcAghCyo7L7Fe3ABk36OznMX
         nm722juAAwWOaut/dl4fNXsGJ29iW9oNucKi0aV4MxD/GI7RIpmbPUtFi/2MfocYzLye
         3fPQ==
X-Gm-Message-State: AOJu0YyOzb4fi5dbSD/VD0jSrVorqLUh1qocYv0ZvyYhlqS9zXs+yPjc
        ov1QSIJOIMcbPKlKGwj+5k6F1rkxHnfmPzCRoNTM2A==
X-Google-Smtp-Source: AGHT+IFFu87fV/QqFFVzr2S5MUP2XQRT/3z2RKQdAHmPLVk6VepFXESizg0ZdQJDSlr/iWl5pF8gzw==
X-Received: by 2002:ac2:4ac4:0:b0:50b:d764:76db with SMTP id m4-20020ac24ac4000000b0050bd76476dbmr982551lfp.106.1701443979701;
        Fri, 01 Dec 2023 07:19:39 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id dk7-20020a0564021d8700b0054c6e98e698sm149481edb.54.2023.12.01.07.19.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 07:19:39 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so70245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:19:39 -0800 (PST)
X-Received: by 2002:a05:600c:3ca3:b0:40b:5972:f56b with SMTP id
 bg35-20020a05600c3ca300b0040b5972f56bmr137725wmb.3.1701443978762; Fri, 01 Dec
 2023 07:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20231201-x1e80100-drm-panel-edp-v1-1-ef9def711d8a@linaro.org>
In-Reply-To: <20231201-x1e80100-drm-panel-edp-v1-1-ef9def711d8a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Dec 2023 07:19:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XLbuOwtYiP7w+dqRK3p0QM3maumQ2TOL7+N1SXqi9f0A@mail.gmail.com>
Message-ID: <CAD=FV=XLbuOwtYiP7w+dqRK3p0QM3maumQ2TOL7+N1SXqi9f0A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add SDC ATNA45AF01
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 1, 2023 at 5:13=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> wro=
te:
>
> Add support for the SDC ATNA45AF01 panel.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 825fa2a0d8a5..467a42eddbe9 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1988,6 +1988,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ=
116M1JW10"),
>
>         EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081=
116HHD028001-51D"),
> +       EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA=
45AF01"),

'SDC' should sort above 'STA' (and 'SHP'). Each of the manufacturers
have their own "block". Since this is the first 'SDC' it should get
its own block (with a blank line before and after) between 'KDB' and
'SHP'.

-Doug
