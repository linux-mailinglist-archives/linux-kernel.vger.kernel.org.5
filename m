Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F757EB450
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjKNQBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:01:35 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D802712C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:01:32 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59b5484fbe6so66354367b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699977692; x=1700582492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5Y3JJ8/zmgF2HGbnU5W0hdais0P+aEYIFnT/ibx64Q=;
        b=Kpl1/0Cddoy8NbGyaFMMnyA8h2Poz0JkXirMPpxwVdqiiJ8QZEgYdD8pMfgiqEoj7W
         9ZjPDCBwCmsyjFV6FefIZd0FtDh3WhW/BzaZrBoYRArvrLGXGI6OxJMivkMl7J/Itb0q
         4+rW0omCuryNpDvB0Jz1/fzIRjnL/3buKmCUGBWK/+Tol54h/Pt1hhFnGqI4S7mylAwm
         kv94Tcd63Z8lwY+QvTK0f0k7B6B2nAdPhJsRMKCpifaMbCs5KfcJiM+As9kmNhhXm0VR
         NNw74fCd9f+te39ZdmcKraG/jI5nty0irpq9suZVvCKwMa23jH0GiKtddGGZyAhcIEws
         iZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977692; x=1700582492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5Y3JJ8/zmgF2HGbnU5W0hdais0P+aEYIFnT/ibx64Q=;
        b=G7f0486MqRrOlwdqbtjYjMn3Y46Q3khyrMBrN//qMTCkkoB94carinLCrBhyzhFt7i
         tw3CHhI02fvLiGDHPBu+T5pNcOQ11uw658iOxO8KckJRycmY9zF+eF3GZFMiN6V9v/lc
         V2J3lR4BgD7o87N4XzMBnaMLjZ3318+LfWNbxZ5VYVmgSu6mch/m3r5+GvfqONzvBzbo
         0bOvcvzuuhou0yZYv6QUgAYTm7PViv7uLY1dXl/5GKwfngCmRi5Ve04RJKvMVdrza+oU
         hSOrkH0pdtXqXJZsO0ZY/fD8+uk17gNMB0hj8t9gezGCFT8Z/TcArnVwT1d/Kd9aK85X
         PWWA==
X-Gm-Message-State: AOJu0YyJIgyNxR3OVcCZxFqWKMYQmb2EYSvOUEGb+UVTbz9f7vZbWwmx
        rwLBwLOOhuO7/UTqq2H7PPLONQkneDmt6kzdCknaMQ==
X-Google-Smtp-Source: AGHT+IHecxpVaiCQOmZM3KI+lhjutqNiQPYA65+zdEHbDVt0erEWM9yCXirM4emtKI0DNiHmNydMTMvGrpBG/gB7buE=
X-Received: by 2002:a81:9c06:0:b0:5a7:fbd5:8c1 with SMTP id
 m6-20020a819c06000000b005a7fbd508c1mr10003170ywa.17.1699977691841; Tue, 14
 Nov 2023 08:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev> <20231114150130.497915-2-sui.jingfeng@linux.dev>
In-Reply-To: <20231114150130.497915-2-sui.jingfeng@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 18:01:20 +0200
Message-ID: <CAA8EJppE+xpb6oSP5VrCq7J0Z879j8OaRdhyQGUdAnLQqGZFFQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/bridge: it66121: Use dev replace ctx->dev in the it66121_probe()
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
> As the value of 'ctx->dev' has already been cached to the local variable
> 'dev', so keep the usage consistent. Just trivial cleanup, no functional
> change.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
