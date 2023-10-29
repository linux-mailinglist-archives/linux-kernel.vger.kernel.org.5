Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147197DAEDB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjJ2WxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2WxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:53:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F2DBA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 15:53:14 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d84f18e908aso3193942276.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698619993; x=1699224793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kh1Npdiagr0GsC7dWj3DYaf78y40AqHKeo0ZRGU7CBs=;
        b=VlQgeqvSRTf/o7F2EdJe2PhnBNeq/SCab7ZX2bvzi+7pZTPlAnegbsFxnco5CkM3dw
         4Qw7RmEfQpDnBgZV2HPcLWUG3n3eb+sPEG9Zl7ovKquZwwQ+UojQ8QHtfJuek34mvptX
         XD1hBIamFvxNqVOEqR06/HVu7nCCxIIb2tRNaVLT9c9rFJDtpUYBNhqJ+K0h3Cc2e21+
         suAp4ZFG4VRpeX5Kk05aFsPWAt9MvrNSRZS8B9fME9WF/WmpixOQ1WjDSl0mD+3uhz8A
         FFhLfMHBuowuc3NT7ORvtnkNFvjI8eBtbAG4/Nlz5GADaFtfvcxfzTdjO0pWERrDhXyU
         ZM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698619993; x=1699224793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kh1Npdiagr0GsC7dWj3DYaf78y40AqHKeo0ZRGU7CBs=;
        b=An0tfRT5rkb48a5BBw7/zKkufRdubngjGU9ygpTfPqHm7qEcP0CGfSa9UOti6kUqhY
         BBTiPif2RgoAJi8A3ox1GJr83+nW8EBR41uweTeGgaWD1sa2adp+gT+n0y/X7hNU75It
         9Iba/XSznN1wJpCz7G8W/JTeJioj+qoSfMneNYZjV7XYUos/83ToYzNGvL2L9daLNHkx
         ejoJa1WUhMTiauHWm21I0XBeHKErUQxlEew6/49VAvU7IRrK50hCE7Cd9z89b5ulHPP2
         T434IeyaRMvtz1I4wGt9CYF1zggpvfQwXlDJ48K3ILRtb1Xj5n9Eqwe3sGmmTDsdSryY
         /1lQ==
X-Gm-Message-State: AOJu0YxiDOhic1n6+3XV3EsW9Ma0/Th1SvRlA83YTuHzYr+ubYrfiwyh
        ewshlOxljV6lPBDbXp5sMAhMkaJD+4FbNFS96ti2muO61wYETRtsJvxXig==
X-Google-Smtp-Source: AGHT+IGBAn0VTDre1BNe31QlXIqIMrTmze5z1Qucpkj+uPYH0stMj4Dok73dgBpsfcxDJB9isHerVJybeWlqqdee2H0=
X-Received: by 2002:a25:824e:0:b0:da0:6179:95ac with SMTP id
 d14-20020a25824e000000b00da0617995acmr6813067ybn.48.1698619993219; Sun, 29
 Oct 2023 15:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231029194607.379459-1-suijingfeng@loongson.cn> <20231029194607.379459-3-suijingfeng@loongson.cn>
In-Reply-To: <20231029194607.379459-3-suijingfeng@loongson.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Oct 2023 00:53:01 +0200
Message-ID: <CAA8EJprjQXcTgxnC1POaBjVBzyVBvKpmKyJcCR5ExRUhVxtYoQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/loongson: Introduce a drm bridge driver for
 it66121 HDMI transmitter
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 at 21:46, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>
> The IT66121 is a DVO to HDMI converter, LS3A5000+LS7A1000 ML5A_MB use this
> chip to support HDMI output. Thus add a drm bridge based driver for it.
> This patch is developed with drivers/gpu/drm/bridge/ite-it66121.c as base.

Please use the original bridge driver instead of adding a new one. If
it needs to be changed in any way, please help everyone else by
improving it instead of introducing new driver.

>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/loongson/Kconfig            |   1 +
>  drivers/gpu/drm/loongson/Makefile           |   2 +
>  drivers/gpu/drm/loongson/ite_it66121.c      | 749 ++++++++++++++++++++
>  drivers/gpu/drm/loongson/ite_it66121.h      |  19 +
>  drivers/gpu/drm/loongson/ite_it66121_regs.h | 268 +++++++
>  5 files changed, 1039 insertions(+)
>  create mode 100644 drivers/gpu/drm/loongson/ite_it66121.c
>  create mode 100644 drivers/gpu/drm/loongson/ite_it66121.h
>  create mode 100644 drivers/gpu/drm/loongson/ite_it66121_regs.h


-- 
With best wishes
Dmitry
