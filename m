Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC564753A78
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjGNMOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjGNMOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:14:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B3B2D68;
        Fri, 14 Jul 2023 05:14:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso3085773e87.1;
        Fri, 14 Jul 2023 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689336885; x=1691928885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wNzU1jOzNUiKRxU7gqcIT9SB28krhRHjHYXdxzclRE=;
        b=jPQt3zLyyTcTqT5ijbQq3e0L9rHwwr8SOxE3IeG2tAOaiJJYQugwzDdhW/P/UgpC8s
         VeN0uZO7SlelJM8gpuq1TT4rTe9/ssJBM3shpliPbBHLa9almmevLoIsJS6nWP6ByD/q
         jfYpnLOZx5ltlsj+KkU88i8OnjsleS0ci5lb9DXbiyz2Romth0Vl/r7TVaQrAvocZJA+
         eiq4HdeXvZW+xSAOTf+tA9MhMRJKRxClm1zliGFGWUqo/Pqc8GjV/HvqDjryIGZbZXQk
         GeReLVLjnVLRUL6g7u3gvpxZiHO6mhMHTPH/Y4hsglAmDUGcS+4THgeTfusT+tlaO1yw
         HSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336885; x=1691928885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wNzU1jOzNUiKRxU7gqcIT9SB28krhRHjHYXdxzclRE=;
        b=F+10tMxZOkbqjUkX5aofcQzTIjUOoc1QI9ifLAy6ltZP4TXpl0bmd7R/NLcPlCjQ3W
         YhiZQZjSM0muyTpdA62mqE0IOm80zDrGsEi72j+oEx3Utakd0zxb5hzr+dpe/cRMTbI7
         bL9RMd5Ev53ZGWWX4L5wC7S30Si5ZMuykMPCiKK20h5wxDARfLWyQU77Z9x08RLLTwyk
         KHqToPud3hopqruePQfQ91C3SW8+/4CzObpQjBzc7sOQVqkrL9DGJsVFaUpVc/w+N7L1
         P8QQdaR4cWvqAtTGGYXw5Q6sclWxQj9m/GWYzOQu0W9zEyMxNyK20cOI2YMjtFpiHKrZ
         gQvw==
X-Gm-Message-State: ABy/qLYyUKIxr3QRSyOv4yvXHpfBEAD35on5elmyyztCqlcG8sXIvIQ0
        kcC0wseOUBqxvlmHHBdxIGE=
X-Google-Smtp-Source: APBJJlEou3hBquZ72I9tXaAkxSKmu6ns5tLytwoP8Lson4Z4VFO/VawIygYHQlL/4B4CxJGRZ0r2Wg==
X-Received: by 2002:a05:6512:32cc:b0:4f8:62a6:8b2 with SMTP id f12-20020a05651232cc00b004f862a608b2mr4270397lfg.46.1689336884909;
        Fri, 14 Jul 2023 05:14:44 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-105.multi.internet.cyfrowypolsat.pl. [37.248.157.105])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7d150000000b0051e19bf66a4sm5680666edo.83.2023.07.14.05.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:14:44 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/2] backlight: lp855x: Fixes after c1ff7da03e16
Date:   Fri, 14 Jul 2023 14:14:38 +0200
Message-ID: <20230714121440.7717-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small fixes after commit c1ff7da03e16 ("video: backlight: lp855x:
Get PWM for PWM mode during probe"), stemming from a review[1] by
Uwe Kleine-König.

[1] https://lore.kernel.org/all/20230614083953.e4kkweddjz7wztby@pengutronix.de/

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Artur Weber (2):
  backlight: lp855x: Initialize PWM state on first brightness change
  backlight: lp855x: Catch errors when changing brightness

 drivers/video/backlight/lp855x_bl.c | 33 +++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)


base-commit: 7fcd473a6455450428795d20db7afd2691c92336
-- 
2.41.0

