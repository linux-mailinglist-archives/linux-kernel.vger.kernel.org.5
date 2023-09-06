Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01D794098
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbjIFPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjIFPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:42:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0231733
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:42:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52c9f1bd05dso5664063a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694014963; x=1694619763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KJHngntgSXNMxKxt0DzBdQdlXtnfRcyHVCesrJpXWM=;
        b=XGIWAkL55RKpTAGHjYC2nHRfBB9IbhTyH1UhVoe9fCL370/vZFacDb+504JvUynNLB
         S56X1aznuXVzHX7JZTB4C4hZZAuaKIk7imsVYm2vTZdYNBINeyLNwtbxAji0OYxhqO8F
         ngyHIhYoRx1GViiwd50L2IP1bCy9y7Lwy2L0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694014963; x=1694619763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KJHngntgSXNMxKxt0DzBdQdlXtnfRcyHVCesrJpXWM=;
        b=GbkYPTMVgC9wDQpUcIeTDpGPsPZP2TVmwzb3HhB9HiScAxPKcWw6f6StMzSmG9u3m4
         b/hl2/ZG+f1EarF9CRd1XccAD8XH8VzoPKP6/dGhCE+IA93IDR3RUqhucIgDy4+QcU0x
         0JOqin4L+Dk+yu7bNpy3b5mnx6jnxIMD166ZiIvHgHzaEO17Ngd+rFQt/iLbBSFMbq/p
         2udh39YxzED5lpuxxBqgYUO2hTpqUDgRG63AyfbFTplLJ8d/QFDv56O1Tup+MoLp5NeQ
         kA+qrSCrXMjHv/fiOdsZsFZ5XE1zgjcSnsKntVUFl74SOecaEzTHVeDg+C34HsKcbJpp
         a/Lg==
X-Gm-Message-State: AOJu0YwRv13gcq4mrIppCGsmTZfNs54MqM0z6saqobGm++RYD11mI2t+
        BrXbgsEgDyyfp3cVn87W+JROa/FyEr79OTxKvfgEh5Be
X-Google-Smtp-Source: AGHT+IF9h5QAb+a++mtA2C9WtJsDGYOYcoUb/uTuBacczMjqMLb/3/xr8evkblBMANonfSL7b8QgZw==
X-Received: by 2002:a05:6402:1819:b0:523:5012:63d5 with SMTP id g25-20020a056402181900b00523501263d5mr2814294edy.16.1694014963703;
        Wed, 06 Sep 2023 08:42:43 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7d508000000b005236410a16bsm8610599edq.35.2023.09.06.08.42.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 08:42:43 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so16715a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:42:42 -0700 (PDT)
X-Received: by 2002:a50:c047:0:b0:523:b133:57fe with SMTP id
 u7-20020a50c047000000b00523b13357femr150283edd.1.1694014962171; Wed, 06 Sep
 2023 08:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com> <20230831080938.47454-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230831080938.47454-5-biju.das.jz@bp.renesas.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Sep 2023 08:42:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFuTion7w4maxVVWZmzoRGXcoUjp9NV9xE3_Kf2ZCvTA@mail.gmail.com>
Message-ID: <CAD=FV=UFuTion7w4maxVVWZmzoRGXcoUjp9NV9xE3_Kf2ZCvTA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] drm/bridge: panel: Drop CONFIG_OF conditional
 around *_of_get_bridge()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Thu, Aug 31, 2023 at 1:10=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Drop unnecessary CONFIG_OF conditional around devm_drm_of_get_bridge() an=
d
> drmm_of_get_bridge() as it is guarded with #if..#else blocks in
> drm_bridge.h.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6:
>  * New patch.
> ---
>  drivers/gpu/drm/bridge/panel.c | 3 ---
>  1 file changed, 3 deletions(-)

Just to be explicit, I'm _not_ landing this patch though I've landed
patches #1 - #3 from this series.


-Doug
