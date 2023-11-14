Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA947EB453
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjKNQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:02:03 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CDFE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:01:59 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9beb865a40so5935103276.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699977718; x=1700582518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fndB5KSZHnHBu08KuHV8EeEo0E7HNwgttkkgS68SA2I=;
        b=WfuyknYixIL2YHMOCpVeuzzhfqwIqmfnqSKaizm3JSTwZpjLrBuqzvTWJE5OuKC8t2
         J5hnkP+qU6pu5zpJkU/1dV5NwDZoZdZblFoT5ki5jZqL3WlL20mjwy/LiEBilxBN4iSI
         VEjOwLOGm+tqScameiMiPX6lUAfRCj9/6jzRErO9zKAc7U1PSBCXWEMukDjpAbEjjGS9
         IBY76d3udwu6Jn6+yHvX3+SSxsA2AqE6ZjJ99IEBygAiEWO9SAG64pRTiz7thdHcq0mh
         xR1c8wyFQhFinw0xFbhjJKYPct1p5lxIbpOmub6TWucdRV6OcWI4FYt4eQIbvywPmc9w
         9MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977718; x=1700582518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fndB5KSZHnHBu08KuHV8EeEo0E7HNwgttkkgS68SA2I=;
        b=ADXe/dhoAe601aj+GLeOHDYOI8oJmAGGxIaKnqY9KAd1dJkk04pjYHFX0GcldjROYK
         Wz6O/6T8/oZHXvym/wDbDDvgm7onzgLSRJoiVi7+CRzZt3GqCnHNNKNh/scJOII/r9QL
         7VEJ4A98nD8Fru0PyBgA6PbMVLQU9UAGfy96ocl5GZAue8OWufe2w57UphkhJGh/sAGR
         yzCFXsexu8h7K/5HZbPvypUwsA7nsoq5YClZOjQgJslG79T+bQSnwn6wEkMd1MyPfbyL
         6KdJ4qYcDjbMxg6XKdlSdH8hzpsJS3e1UxsaQ5itrjycJ9ysR6bZk3YvSp+QYIhvJ7eF
         iu6Q==
X-Gm-Message-State: AOJu0YxsO4ro3omd6TjdTCg0LGCIyzxq2exNFKTEgxyZr8wduEbYUf/1
        Y7VwA5pTSWk4pZiA9jlbw93naXUEvb9jJG9fsQoRTA==
X-Google-Smtp-Source: AGHT+IHsevervoQJYVTNCoLk1NXeNiVOY3Shw0OrWY/m6yICDDktyuOZ2Wig21e0oPgniacjjKXoc7GyOir3X9amtTk=
X-Received: by 2002:a25:cacc:0:b0:da0:ccd6:b8a2 with SMTP id
 a195-20020a25cacc000000b00da0ccd6b8a2mr11767481ybg.19.1699977718516; Tue, 14
 Nov 2023 08:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev> <20231114150130.497915-3-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-3-sui.jingfeng@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 18:01:47 +0200
Message-ID: <CAA8EJpqHt4KX_yvq8DtRi2z7Y7RS5soSk=C_=00qyt9jTMEu4g@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/bridge: it66121: Add bridge_to_it66121() helper
 and use it
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> Instead of using the container_of() directly, which avoid the code lines
> too long in horizontial. Just trivial cleanup, no functional change.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)

-- 
With best wishes
Dmitry
