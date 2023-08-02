Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68B576C8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjHBI61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjHBI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:58:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4D115
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:58:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso70436085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690966700; x=1691571500;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKacoYBhafR10JvvkyZ4j4gyiT1DNxLnWoSCLRFnVfU=;
        b=AWa/iPaFw5XFT+9QkWWjxhWsUN0N71PxFxhwMv0R1UjwWQh1WSdpAbd/e/x2vpSpNP
         XyiZuFlUUyfL2yY+dPymzAfV9X+cngqRA7B71vyUMV/p45GwrwkitHFj/RdSy2rHksx0
         TGZ0NO2jhexdYc+S0++842cB+vRZqpRwgcgYWFJX/s2SBiM1tbvGYZYLTSvpIodxTpmM
         5rYajw1fAgK/rfR7nt9q1BGMbXYCmzurtinzjZs3nDFv4xGY3oJanB9aBcRSuPur0tyK
         1QlLJznshobNG+fE8zQrNhZzE+g/NxX9ZIzf6ZLEcMC5HV66H2VTukKXE0nznmcQVDJB
         2aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690966700; x=1691571500;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKacoYBhafR10JvvkyZ4j4gyiT1DNxLnWoSCLRFnVfU=;
        b=duXzTMCoOrRo304FCgiYOswCBnvJUCCtyTWqoH+xWa2C1nqt+XxwiDbeQD8XJE7BMB
         n6EUsy0A67wyEAcaMkoDD0QhQKuJmXqJYf9PfE/996uEARf7dAC6bUqxAkZgoiPuLCin
         dSiml4nIJDLBdWgs9V8YZmZwkmZdjLtym1fKwlOUE4EHiwlXJRVQS1ICyw2c27Rl7+bZ
         GoUkF8qi0fp1483LKR6xoRc8hTW1PqG/cqwK1wIdeCeWkDwEoYigsbZtpU7URtYP8Ijm
         On49XzZ8wEh+JQDhCq1DuTbV4+6QFweoj51kwFyVQ9231Ai26ZOOfMFXjIubH7M5jkEW
         xs9A==
X-Gm-Message-State: ABy/qLaL0pQDNmD4Fybtm+1q+5nTocquQB/4X+touCiEBmH91aTFKUQR
        g0z0ekSgqICsBgVxNoM3nNiJvw==
X-Google-Smtp-Source: APBJJlEdnBHU7cqzNc3pMckBNKjRN95SYy691YYhfyhVJaDEzM/thCfEvh7gkb2/LJ9duF0czLeMaA==
X-Received: by 2002:a05:600c:220a:b0:3fe:2b76:3d7 with SMTP id z10-20020a05600c220a00b003fe2b7603d7mr2763113wml.10.1690966700562;
        Wed, 02 Aug 2023 01:58:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c2a4800b003fe29dc0ff2sm1094874wme.21.2023.08.02.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:58:20 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230802-gt5-panel-dtable-v1-1-c0a765c175e2@trvn.ru>
References: <20230802-gt5-panel-dtable-v1-1-c0a765c175e2@trvn.ru>
Subject: Re: [PATCH] drm/panel: samsung-s6d7aa0: Add MODULE_DEVICE_TABLE
Message-Id: <169096669979.1696778.2368037632749809262.b4-ty@linaro.org>
Date:   Wed, 02 Aug 2023 10:58:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 02 Aug 2023 11:41:22 +0500, Nikita Travkin wrote:
> The driver can be built as a module, however the lack of the
> MODULE_DEVICE_TABLE macro prevents it from being automatically probed
> from the DT in such case.
> 
> Add the missed macro to make sure the module can load automatically.
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/panel: samsung-s6d7aa0: Add MODULE_DEVICE_TABLE
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c71b7aa8619a0c9700132d0733e33999fb614339

-- 
Neil

