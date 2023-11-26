Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D27F925E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjKZKzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjKZKzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:55:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C916ADE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:55:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54b532b261bso309827a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700996105; x=1701600905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECypgGqHQBjY12h9Higzn7Wesb+tD2zqqv/5yygreuE=;
        b=I3m3a5cWO/Ulpj2o4yM2MhSjGkHKlRFWyB6Aqn8otNFgEIDy1EQyjNlpoFCqUVwH+U
         rsGBz4l6f/0EuF2XODIKKwoj2wpnnp7ZI9bavAcEOJ/T/iYWkx8qPVMapZZt88R5co9k
         tl9zv3es3NehsP7eZbwI6HEC8pBHrWQgL5HQ+J291AV0xtxoi3Y+q02cBu0o/AqTPl5q
         1aJnI8Jme2CjI6+riFIWQ4O7SLD/tEz15vCncpmJ23zR6mWmNApcfUydk16YmGPlaoZz
         OZAfvpqczFAAE6JAUR5dfe7ktPicdy9KmkpZxnEsy1udX9WKOufCGkqdEJjKI6ofXQSu
         tg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700996105; x=1701600905;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECypgGqHQBjY12h9Higzn7Wesb+tD2zqqv/5yygreuE=;
        b=JkvfDFTNoFN2rwKXpKAsOcgknwKTR9bCWqcXo3vhXtv39gV50PntyZHRm2GlKrLhdU
         LwVb++X2oS7GdueOyXXAD2C8uT1S2LBNIyRNJoIc0eetDX4L68sLSksoc1kg2rDWqjAP
         4f7KPlVEoijaYjA5y65EOv4Np/pouttNrVBA5HserCvVlI42CzBuZEEPQtZoFGgcj80/
         Zq+umipyafsA1/qxdLaQuBtqJmob2oZDyFPI5y9oxmNrDtyN83qp5xQS1HrIl1tSQigs
         2p5o4oEa7lilMYP1TLrSX/NLUrDwQQYL3jjSMNLIBIFkAqak4vsxiPUcyPNEfkDb8E6r
         /HuQ==
X-Gm-Message-State: AOJu0YxzQPV60i7CJUJ0/oDkDpboF9n5RSsq8nN1b8c8BP4eVxAnNb4J
        RC8Zu92mpwRq86RXgtDKvz8=
X-Google-Smtp-Source: AGHT+IGiaTC1sEjY/oPRpZNJ/wG8qGzhgZcG+LcLHsvxUX+adjVG4+rn73MntzJa0aF9TUzUUGhkpA==
X-Received: by 2002:a17:906:209:b0:9be:2991:81f9 with SMTP id 9-20020a170906020900b009be299181f9mr5808853ejd.1.1700996105077;
        Sun, 26 Nov 2023 02:55:05 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906080800b009fdc15b5304sm4437938ejd.102.2023.11.26.02.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 02:55:04 -0800 (PST)
Message-ID: <2601b669-c570-f39d-8cf9-bff56c939912@gmail.com>
Date:   Sun, 26 Nov 2023 11:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/3] Rockchip inno_hdmi update
To:     hjc@rock-chips.com, heiko@sntech.de
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combined update for the Rockchip inno_hdmi driver in a
somewhat similar way to what is proposed for the
"Create HDMI Connector infrastructure patch serie".
Keeping the inno_hdmi and rk3066_hdmi driver functions
comparable makes maintanance easier.

Maxime Ripard (3):
  drm/rockchip: inno_hdmi: Remove useless mode_fixup
  drm/rockchip: inno_hdmi: Switch encoder hooks to atomic
  drm/rockchip: inno_hdmi: Remove unused drm device pointer

 drivers/gpu/drm/rockchip/inno_hdmi.c | 56 ++++++++++++----------------
 1 file changed, 23 insertions(+), 33 deletions(-)

--
2.39.2

