Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF8180C436
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjLKJQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjLKJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:16:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305CA100
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:16:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3333074512bso2701018f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702286177; x=1702890977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i92w0H7T5cIJREEPTTsPXzjdkkN3FCVq9uA4lCfv1LA=;
        b=unCM+QCjThdnQ32XOZSTfoyq6ktVic0r/YbdcBxFAKaHcDfpKXLaDZWqDYlmzV1emn
         LG7pBTOjtal1qC0BmLjMRXPmhwyfXx7U70PX84IH7DPb/NM0KxtYXUhSW+ocgPWqjxuH
         8Vj+GzmC5iJDHHsYul2yeFFT6ZX+XS+kUUnf25MGv2M/rN7V7J7XokjnfxwYOUGFmKGt
         EJeQPDJTSsgIc50wMIMcYVzzHWVyLiEY2k4yuemwsBFC7Ambm90D5dZuB78mcIGuUXJY
         QMh/u2whabTcfdfy7TGzgVtAwBwNaSrj45tIuWyNBXMaiS7fEzg4Hv4SO3nOWpwxNRMw
         NOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286177; x=1702890977;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i92w0H7T5cIJREEPTTsPXzjdkkN3FCVq9uA4lCfv1LA=;
        b=gRbUJvfOO3pCR86IH530hM8SM2Q4+4Jc1vtkjAGWT3q24R0rUzf1W4Cv3vhVRng1/D
         U0SdXFN+0063dVP11tsknU1Xsh9fCjR1vCbyIYHnfuQkhLHUYo9MGflKNgI1UcMKx5v+
         QyD4c+86k5rttMd5PM9qq86uEtd6LTakm1nw0OGI10OJeIQlkB/NClaNj7iZUPWDSPX9
         mbZWn/811A6lT+HSDf3MlFa38wyZs1zqh91SN/yQN4Htr7n1BVQnHzaNYAM3fcKKZvQV
         JveT3J1HplICsGN/35XR+xDinDaVbXu1Fa2dPjac12dk9fz8vrRiiF3yFNBf2MuzQEil
         Dlsg==
X-Gm-Message-State: AOJu0Yx+b9x9z14EIWZSkOXi9wx8IEbJumeyB0EL0sBRZBRNEoy3UYk1
        Raer/ZIAv84a/g79vrehLnI7hw==
X-Google-Smtp-Source: AGHT+IE1Y3s47FyeYwxBMhMeqlNT8+HKhqIsiKFRswD7iG2IJiOPDvdZF+8n1xssCubPjCtjT+n+5A==
X-Received: by 2002:a05:600c:11c8:b0:40b:5e56:7b51 with SMTP id b8-20020a05600c11c800b0040b5e567b51mr2033425wmi.154.1702286177549;
        Mon, 11 Dec 2023 01:16:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm12398470wmb.8.2023.12.11.01.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:16:17 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
Subject: Re: (subset) [PATCH v5 00/10] Add displays support for
 bsh-smm-s2/pro boards
Message-Id: <170228617622.2409693.12899768447819855539.b4-ty@linaro.org>
Date:   Mon, 11 Dec 2023 10:16:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 07 Dec 2023 15:16:29 +0100, Dario Binacchi wrote:
> The series adds drivers for the displays used by bsh-smm-s2/pro boards.
> This required applying some patches to the samsung-dsim driver and the
> drm_bridge.c module.
> 
> Changes in v5:
> - Replace a 'return ret' with a 'goto fail' in the r63353_panel_activate()
> - Add 'Reviewed-by' tag of Krzysztof Kozlowski
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[06/10] drm/panel: Add Synaptics R63353 panel driver
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2e87bad7cd339882cf26b7101a1c87dab71962c9
[07/10] dt-bindings: display: panel: Add Ilitek ili9805 panel controller
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=549240c98e50207244bc1ac182622b8daba89a89
[08/10] drm/panel: Add Ilitek ILI9805 panel driver
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=edbf1d506ebe8c0857c406bd5d5b81d46ffd8437
[09/10] drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 panel
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b1fcb7ee3707290466b2cc4956325fb91f09f13b

-- 
Neil

