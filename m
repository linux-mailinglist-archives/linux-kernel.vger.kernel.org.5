Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFD8129E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443356AbjLNIAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjLNIAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:00:47 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC9E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:00:53 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-dbcb4747d84so2883987276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702540852; x=1703145652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hxvoxrsdJSPbjJs7z8cGp1BRDLR051KEfgQFlaNlMoA=;
        b=T3V5T0BGpghsmaF1IbQmxrIqKVH1H6SMCdCQdrHkhOaSVT4srPtpNBAk7GTRDrlY0b
         wHhF25f5l4sEPHzRd46y2RbZmGXq6tlfysBA8cLvUgM+qf9m8RrpI8Bgxa4ug99f70Xb
         Mbofp5mmzEEAqofqR5s1DIEWRAmunN+g8SB2KFxP8UlLTNLHIdGaiUmYILIn8kOeeZhZ
         UaC7kOIrPEcertiEaHzhcVcbzI8iYvV5csBmiUMMMYx/N3ORkORmMlK1K6GezPWllBk+
         Rh9Y55NISw9AAgVePgCyNRqfgKXEfCMj7sH0XLa0cPmJaZeMVIATA1MjhvNJ2v+MT2wV
         nB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702540852; x=1703145652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxvoxrsdJSPbjJs7z8cGp1BRDLR051KEfgQFlaNlMoA=;
        b=YANazM/vmb/pgd87nF1hslfELXu8cMQ49zN5EvDpKeuRAHV+D/Ysv4lGf5eckwgsb6
         BHNlm2/B4HzPZg6AxJJiHMI7qGwfe115RclnxHRDXHwWAWZ/WcXALC7DgfymQHEeGlx8
         92eqHzHGCSSiv1nBxUxctWFKC0qGj4arahvpe6uAOBGCI94niCfhrp4TY4HMnnpJ/XlT
         e6NO3zMtimd/h3YPDAbG5jQuScjwrfMmARVsy2ITs5i+bUZuNlGgwB2RCDbkCJLkJM5n
         xnF1dAsoAz9ZNGQCfwUXNyd5SoNfHEDoQSlwdejfWi73zh1+adCxo3slCd1AjFwVDP+4
         RSNA==
X-Gm-Message-State: AOJu0YwcWeqcNmvUxjo2RNIZwCQmopbcf2rtkjV+vHRSN5ni0l79qh+r
        jMKUH8ZXjXGzaTx8shQv//lrjzXSd/a1mAaD3QU9uA==
X-Google-Smtp-Source: AGHT+IEnRsZCGxPZoaC9TlxZCpwZRrhdgilZbD3aUw2tigkOCiLHSxoK/nVPHCaSKjzElObYgpZcrTxqROsqkKsWfYo=
X-Received: by 2002:a25:e20b:0:b0:db7:dacf:6ff7 with SMTP id
 h11-20020a25e20b000000b00db7dacf6ff7mr6738896ybe.127.1702540852537; Thu, 14
 Dec 2023 00:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20231212160448.883358-1-vignesh.raman@collabora.com>
In-Reply-To: <20231212160448.883358-1-vignesh.raman@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 10:00:41 +0200
Message-ID: <CAA8EJpro5Hb0yRaxPWzBQBikKjw9JnNVkUuPFvWeXjegzCuxHw@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: uprev mesa version: fix kdl commit fetch
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        emma@anholt.net, robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, 12 Dec 2023 at 18:04, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>
> build-kdl.sh was doing a `clone --depth 1` of the default branch,
> then checking out a commit that might not be the latest of that
> branch, resulting in container build error.
>
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/5efa4d56 fixes
> kdl commit fetch issue. Uprev mesa in drm-ci to fix this.
>
> This commit also updates the kernel tag and adds .never-post-merge-rules
> due to the mesa uprev.
>
> Tested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/ci/gitlab-ci.yml | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

-- 
With best wishes
Dmitry
