Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6A80F5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376886AbjLLS6X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 13:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376866AbjLLS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:58:22 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A081101;
        Tue, 12 Dec 2023 10:58:27 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5907e590360so257778eaf.0;
        Tue, 12 Dec 2023 10:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407506; x=1703012306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPYriBv9JdGAxc4g5llpBrr+G3FF3YwLNGYDVmKF1sY=;
        b=c89c5GbTiDwFi2I+mWEQRJOYE392CP/qaGMzJmofbgZQ3bpS7NukbX4L5AvLLQdyDW
         u9hlkqppZxmGWbknnmB+5NAqFEoljFIjcDtpAfSritPC6UZVaLMm/KvMmoxhefVbejmF
         pGTCjdx1MuTNteMFCcaF0buz1/1Xdvcgb0LvRi/Xh38Rrl4T9wl+40Pgk1I73eQwO9kL
         ODekuT+k4gn/mm/3f79fbcP07K9LQseIJ4sk8zsxb8aFnTO2KfJrMtk9DALLAR/N6u2X
         yyxcjAFkd0Cdvkv7/p9dpDiVAgZ4SfM9g+8DokPCfd6iXmup7mRQ3lboMIt9xDt9QXIK
         ERUg==
X-Gm-Message-State: AOJu0YwsxtTvcJeCORYtDm/SsXZTKzMeEIecGS96mUOXQfKiX5T5fFSX
        zFgKjg1GfBYSppOx4L9W55jyC3oJIsqr8Z6mLobOs1cD
X-Google-Smtp-Source: AGHT+IHtz+5DBWpAxTkoaTmokFPX5X69YmTTEjoUWwmlmBR15Sg6PxcmTcFi6La1GF3s62mtKpY8h+Id//85cvT0USU=
X-Received: by 2002:a4a:e9ae:0:b0:591:4861:6b07 with SMTP id
 t14-20020a4ae9ae000000b0059148616b07mr597011ood.0.1702407506285; Tue, 12 Dec
 2023 10:58:26 -0800 (PST)
MIME-Version: 1.0
References: <2709306.mvXUDI8C0e@kreacher>
In-Reply-To: <2709306.mvXUDI8C0e@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 19:58:15 +0100
Message-ID: <CAJZ5v0gjwBcvpDRU+2UbhKZk_u2nXheYKVhpqWDOP=pGfnofaA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Drop redundant __thermal_zone_get_trip()
 header
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 8:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The __thermal_zone_get_trip() header in drivers/thermal/thermal_core.h
> is redundant, because there is one already in thermal.h, so drop it.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

From the lack of comments I gather that this change is fine with
everyone, so I'm going to queue it up for 6.8.

Thanks!

> ---
>  drivers/thermal/thermal_core.h |    2 --
>  1 file changed, 2 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -120,8 +120,6 @@ void __thermal_zone_device_update(struct
>         for (__trip = __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip++)
>
>  void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> -int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> -                           struct thermal_trip *trip);
>  int thermal_zone_trip_id(struct thermal_zone_device *tz,
>                          const struct thermal_trip *trip);
>  void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>
>
>
>
