Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B96794090
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjIFPmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjIFPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:42:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C1E7C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:42:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso5423662a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694014931; x=1694619731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jqWPBKKZ0w/uAPmZAAT8U8XfT3/SMs+PhVUdbN+Ymo=;
        b=jJIo6m6Jj75nxVVZyW6/CEz5lS+XYexgRooWzBLDFNUYxvHganJO3YqG642uRonXBJ
         WDw3greLQNzxa9fYbWE5fbXIUxYzqxzOiqN5moFzLjaofQME0F6+l7eMUDo07zFPlekB
         hXd4e3bq5phIU7fS1EQ2UOiVVDiSkxV2zVF5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694014931; x=1694619731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jqWPBKKZ0w/uAPmZAAT8U8XfT3/SMs+PhVUdbN+Ymo=;
        b=JENj9VR7tRx4wRbLK9XzlZAeQ+F5x/CwjsgaLQbaG57sKu207Kg71wmjdTFS8s9Mfr
         70g+7yl95npkHDuV2Bm0uW/bDZ0d1X9tFD+uOzS00F4gfdAqsYJnWpI96OKfpHUOL3sl
         vtn/qE2BbXGbN4vsBjMpNNGLwcMS9oe+5AZc+yonxKKUmBFPPBRJcM0FYHJ/APMVcd0F
         8tNVRMupYPttO90l53ifFotkoTw/1yci433l6XqwBqnZadnyrklMCILwjem4zkOiIPqz
         +MJWI+itkKfEXYA6eGEK9SbyHBhSyTP4axUuYeaNRurU0t04LoMZ5cZjjgdt6eF5adxD
         /P7g==
X-Gm-Message-State: AOJu0Yz0M2sFZxrDPqfTDnDu0jY75tA28TwGauz+s9LbOrCirzQTbypC
        fOm6hTq9/0dglOOv12TpaBlZ9y4VKx/QYcFFxHWjuobh
X-Google-Smtp-Source: AGHT+IGMRPbHQxfrg8xvEweiYHTVeJFh/e4PybMUGUx2gD0wxsForxegy/zyLZimu+l/wjw5Es1BZw==
X-Received: by 2002:aa7:d615:0:b0:525:5ed2:abed with SMTP id c21-20020aa7d615000000b005255ed2abedmr2808628edr.30.1694014931259;
        Wed, 06 Sep 2023 08:42:11 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id d38-20020a056402402600b0052cdc596652sm4978817eda.23.2023.09.06.08.42.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 08:42:10 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-402c80b71ecso105825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:42:10 -0700 (PDT)
X-Received: by 2002:a05:600c:5493:b0:3fe:eb42:7ec with SMTP id
 iv19-20020a05600c549300b003feeb4207ecmr129217wmb.1.1694014930015; Wed, 06 Sep
 2023 08:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com> <20230831080938.47454-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230831080938.47454-2-biju.das.jz@bp.renesas.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Sep 2023 08:41:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSmtc=jaHghXYmdPi2VKtfi+AAZEmkbk_AbWRfHxawRA@mail.gmail.com>
Message-ID: <CAD=FV=XSmtc=jaHghXYmdPi2VKtfi+AAZEmkbk_AbWRfHxawRA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] drm/bridge/analogix/anx78xx: Drop ID table
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Zhu Wang <wangzhu9@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Helen Koike <helen.koike@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 31, 2023 at 1:09=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> The driver has an ID table, but it uses the wrong API for retrieving matc=
h
> data and that will lead to a crash, if it is instantiated by user space o=
r
> using ID. From this, there is no user for the ID table and let's drop it
> from the driver as it saves some memory.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Helen Koike <helen.koike@collabora.com>
> ---
> v5->v6:
>  * No change.
> v4->v5:
>  * Added Rb tag from Andy and Helen.
> v3->v4:
>  * Added Rb tag from Laurent and Douglas Anderson.
> v2->v3:
>  * Updated commit header.
> v1->v2:
>  * Dropped ID table support.
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 7 -------
>  1 file changed, 7 deletions(-)

I think this has had enough time to marinate, so landed to drm-misc-next:

39e0b96d61b6 drm/bridge/analogix/anx78xx: Drop ID table
