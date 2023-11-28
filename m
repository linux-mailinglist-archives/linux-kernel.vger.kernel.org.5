Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92C7FC9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345254AbjK1WnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjK1WnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:43:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF3419A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:43:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso840117166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701211387; x=1701816187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMaZbAerACdlkvgT9TKXxbixHEibkUu2cUgc5bnvXQo=;
        b=WcdBshVkc5vzACY6jMBKQG/pS3US9cRcdCSjFXDaR27CgOQBzfTwEM6ckDmS3eFfnu
         dvtcDO6yiTCumP0ul9Z1cuVH1FGZ1Sgqfu2uaIOKiVTLbOOJs/XuMIo5W8aCRzqcModD
         ov/w8yofxavZDnWYOKb4roDRnH6cyF/8YCAqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211387; x=1701816187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMaZbAerACdlkvgT9TKXxbixHEibkUu2cUgc5bnvXQo=;
        b=QFcChORBgEJs1JDGcO1X2MhU9DkMw4K7SjRhsrCvD9LbVSXOtTvkfk+ZAtbeHVl4vG
         iQeiF2dqEM7KDx54ZuEkc4oGk3PHZTxRtk1PrTsntmuRBT7QXbDXZN/3W7kRxsmMEgP2
         tIf6Kpl0LYUtyVVpFpSwqycxGH8BUyQ82wwaMrm3BK0M0vyMu0zMrHlRLgjNbBDThQ90
         mUd8CjRjrbmGnRJxo1Y5NMs+qQkAdiOjWhqt0iKLR9vu2AHJetATqrm7Sr+0qRLA/ZG4
         Z9zJVq02f4RNBZdpg2qXzVQsWJLayCdyXXYgZ6R36N9Uj/qOb///93fPpGVMRMfnyGfS
         faDg==
X-Gm-Message-State: AOJu0YzodRom+V3I9mMBlWUoNIqdFnmIlZCZPUHsgXloqWOPLnUdyGjz
        24Zvh2nzWADkhwR6A7pvLGS7zKk9is0RJWR5tbSY+abK
X-Google-Smtp-Source: AGHT+IGmK1nr95cVQptGvnLUZj7gNyHLiILsfcPEYMwZEtETMZsmPeO1lE8Tsf/5acns9L8wowVfog==
X-Received: by 2002:a17:906:af13:b0:a00:53cc:8590 with SMTP id lx19-20020a170906af1300b00a0053cc8590mr11388888ejb.40.1701211387499;
        Tue, 28 Nov 2023 14:43:07 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id dc9-20020a170906c7c900b00a0ac350fd57sm5094281ejb.86.2023.11.28.14.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 14:43:06 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso8575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:43:06 -0800 (PST)
X-Received: by 2002:a05:600c:3b03:b0:40b:33aa:a2b9 with SMTP id
 m3-20020a05600c3b0300b0040b33aaa2b9mr799601wms.4.1701211386445; Tue, 28 Nov
 2023 14:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20231117215056.1883314-1-hsinyi@chromium.org> <20231117215056.1883314-3-hsinyi@chromium.org>
In-Reply-To: <20231117215056.1883314-3-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Nov 2023 14:42:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VwFNjfem-pEqqfqQ70uLkOFOftpJY5K5jTOdPsiTRt+Q@mail.gmail.com>
Message-ID: <CAD=FV=VwFNjfem-pEqqfqQ70uLkOFOftpJY5K5jTOdPsiTRt+Q@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Pushed to drm-misc-next:

70e0d5550f5c drm/panel-edp: Add auo_b116xa3_mode
