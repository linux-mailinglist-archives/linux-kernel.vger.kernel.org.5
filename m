Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE117FC9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjK1WnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbjK1WnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:43:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE241BC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:43:17 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bc21821a1so892312e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701211394; x=1701816194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6v70Jfc8nqkrgav4bbcQA6HZL6P4J2VUNvwOzUy5eU=;
        b=AeCv6QvseDe8MeYt9NAQR2tw1vFckTWXLY4H5WkS8PtoX1Z4vffKEpMjzjEWzSrQqs
         qIxovs7AHcRKc8ZOKPrfULJlIu5BDssivccYWjL+cR9v0vLinI9m9qA8FLXAZZpcoQf7
         h7k2bjAEZs+rLN+ewOTgZ9v7m8Y4ZjgRQP1L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211394; x=1701816194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6v70Jfc8nqkrgav4bbcQA6HZL6P4J2VUNvwOzUy5eU=;
        b=ezPpq4GYXcUbnFmLYi0+lvBlMlbeDI39YvIIrkZKc9nXrS1i9/I3kyGdcirNz84Xsk
         fcB7aw2ofVZ2I1a2hoC3rjw9jHQoXXY7w/6Zdhhb418NA9Xn5vjXpYe2Iyu0WsW6SRV/
         T4Jy9sr0M5eAlKvBfJGiZxu9hJVSp9MxpVjmAr+FXlTlf4pxRtyTIL+C3nurSI/s46N0
         SU2633VhNoQueq4LWPxiu9wYZI400mv7llisVUeAOcfV1BZAekUIdCt92L8XNkB68SRN
         Y0YNuj3Q40HC8OoKj2iB77luk+o8mmJAehGcXt0KF2AOq5IyICSePGVm7aR1NYKCVxl+
         eezg==
X-Gm-Message-State: AOJu0YzP4lak9usL53rCLbRj9HRpOO+NdkOzqUNgJWfFZfUTMci4XvEh
        KLuAIQTSBopSuzwPCDZFRiFRvxjvi+xoD6CKjH8l8FHh
X-Google-Smtp-Source: AGHT+IG9it+sG4DSoIt7KnoCkqplhnNZYX22rSYFxXx3uf+PoViF2m43XZ8P4pUF7gwmwSvfotCr8w==
X-Received: by 2002:a19:7413:0:b0:50b:bc4d:9f36 with SMTP id v19-20020a197413000000b0050bbc4d9f36mr1710275lfe.29.1701211394420;
        Tue, 28 Nov 2023 14:43:14 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id u26-20020a50951a000000b0054bc9759e45sm316567eda.28.2023.11.28.14.43.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 14:43:13 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b35199f94so27395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:43:12 -0800 (PST)
X-Received: by 2002:a05:600c:206:b0:40b:443d:9b78 with SMTP id
 6-20020a05600c020600b0040b443d9b78mr400913wmi.0.1701211392581; Tue, 28 Nov
 2023 14:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20231117215056.1883314-1-hsinyi@chromium.org> <20231117215056.1883314-4-hsinyi@chromium.org>
In-Reply-To: <20231117215056.1883314-4-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Nov 2023 14:43:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V33tTjKYvaqUayNh81ksFf2SkUsS0oB0SrfsFe38triQ@mail.gmail.com>
Message-ID: <CAD=FV=V33tTjKYvaqUayNh81ksFf2SkUsS0oB0SrfsFe38triQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] drm/panel-edp: Avoid adding multiple preferred modes
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 17, 2023 at 1:51=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> If a non generic edp-panel is under aux-bus, the mode read from edid woul=
d
> still be selected as preferred and results in multiple preferred modes,
> which is ambiguous.
>
> If both hard-coded mode and edid exists, only add mode from hard-coded.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v6->v7: no change
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Pushed to drm-misc-next:

fb3f43d50d9b drm/panel-edp: Avoid adding multiple preferred modes
