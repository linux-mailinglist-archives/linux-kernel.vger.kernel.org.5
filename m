Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674F97EFB87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbjKQWky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:40:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D2D7A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:40:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso3565508a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700260846; x=1700865646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYOkd23trY47vveFxv330t7Ge1uledMtX51VxhQZTxY=;
        b=XhDUMgroHLMUKQKUQyHYe2vV9gTNg4xVcbkmFqUzv46ciP+LyA+r57twDOGAbzhlQo
         Jog3uzlKF24lITkgZRrm7UpI4P1//Jl/civoLfZ94Y6RWZfkZzn6DAIIsUF8aHyiX4Aq
         /mrJ1CQcJVEJYJffdNrDdYUf2CCcbzbpEhcJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700260846; x=1700865646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYOkd23trY47vveFxv330t7Ge1uledMtX51VxhQZTxY=;
        b=AdV9UdEuSsMIBaJW78xZtAzWqt9+Gnmbtt0Mc2ePSmqms2ozyZ6xi9mDY7TQ9j23Q8
         mnLwQahSjLu0dh2/sQbkCmtO1BBhFgtLU8fVlQEnoNZBsmJCfod2Hi81xe5t7/QByIwP
         4gWfNee5LCbbvEAUYQJc7h8HhMx9dzeTccObhIJaG1pjvjvzRAFP2AymOmoNriY33Jom
         aYJfDzjlXQRWRO3/wk6iJFHvsJuvwHRoGFpxjUzByJg7oDvV4+P33xTYpfaayHFQfvH1
         omAu1yYFwOeqITgKy+arKWYcqaR3qwo85JdjXqKD6UgFIcyl1xUnuelgDOsNnp+8+jDg
         qlYg==
X-Gm-Message-State: AOJu0YwF1NbD2jJw1F900R/czSEn6AqLTt7oFgXB9I9D8uOo25bCFFb0
        SLI6gAp9JMbOZLYDFy9EzpbNTd3ImvKR/J2RMntt4Ss5
X-Google-Smtp-Source: AGHT+IGUaU2IVPZCXXx8fl+U8N2/0kKqPljGp+bo3yDzGSSu8GRxNc2VsWcCG4gzPeuXCNoV1Ak3tQ==
X-Received: by 2002:aa7:d648:0:b0:543:74e6:9da2 with SMTP id v8-20020aa7d648000000b0054374e69da2mr341535edr.0.1700260846064;
        Fri, 17 Nov 2023 14:40:46 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7d88a000000b0052febc781bfsm1121223edq.36.2023.11.17.14.40.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 14:40:45 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so1317a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:40:45 -0800 (PST)
X-Received: by 2002:a05:6402:c41:b0:544:e249:be8f with SMTP id
 cs1-20020a0564020c4100b00544e249be8fmr67977edb.1.1700260844963; Fri, 17 Nov
 2023 14:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117215056.1883314-1-hsinyi@chromium.org> <20231117215056.1883314-3-hsinyi@chromium.org>
In-Reply-To: <20231117215056.1883314-3-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Nov 2023 14:40:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XYs2_zUU0BcrR2tK6tt5HbE03-VUn0UgkmZksQHE2AqQ@mail.gmail.com>
Message-ID: <CAD=FV=XYs2_zUU0BcrR2tK6tt5HbE03-VUn0UgkmZksQHE2AqQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] drm/panel-edp: Add auo_b116xa3_mode
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 17, 2023 at 1:51=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Add auo_b116xa3_mode to override the original modes parsed from edid
> of the panels 0x405c B116XAK01.0 and 0x615c B116XAN06.1 which result
> in glitches on panel.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v6->v7: split usecase to another patch.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
