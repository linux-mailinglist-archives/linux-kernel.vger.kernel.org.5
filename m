Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131EF77E704
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbjHPQyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345031AbjHPQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:54:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF45272E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:54:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so62533095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692204853; x=1692809653;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1FlQ3OUT9sdhoraSxgyWLKrGJemxIcdoIm3bMY/fyY=;
        b=zMVD4UnEmCBrtXvxNxx/nf9QK/ZGbiTpePnBbkU+17ZOHbRfvb4Y/E6p8Fo3P1j1vs
         X2+DCLUOlgBt4cnV+c2ikMmlyp93oxRpdRokfzePa6I3g2wfZtJuDJgU9jvHOQVUQioa
         gROGVbV5zEqKW/VNccfHds6Hs7m7kuu+dh3BCzKeK1XE73U5H6tbkZN20GjUirGa9qS2
         rjkd9kDLI2XzfHkZGvpJwox5XP449D5p8/GkfDeWkODD8yet2iMLfk+9XtstqX7YxTjY
         /lSUbfaCN9sF1zFoJF4l7nZYxQqPVhBpPXvwcfiNTYorZYIsZy0HThALKm18b53sgTI9
         58TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204853; x=1692809653;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1FlQ3OUT9sdhoraSxgyWLKrGJemxIcdoIm3bMY/fyY=;
        b=ZwLLRPGdV0ZxeJE6dGNPcpgAPEy0nnCgFu0+GmPyUBdCEtkFE4aetAS35PLPlhDTuz
         scQkb3QN88i2kmUq/xYcGkr8BwFI5bHB+qB1Ebcx/5MdNK8GwgMOEi2wPNXGjz/3h1Bg
         v6zoC2V2Qzbr7yeCUSzX//jMYApBLBMgsGT+qx4Cla8W/7q4PhJ89REtW6ekhbvkuUCY
         blYO63ESFVW6T8w/9CWrPJnKPs0/SVi3G0y16y7V9osIsrM5TFEfZ0Coxo+EK73GmySy
         DP4ZoYc/XQXGUyHtwP18x4U70EO2BOuq0VRHhBJ3Mk4Is7bVVmbhXdIbAzpfi2NI8yj2
         8B9w==
X-Gm-Message-State: AOJu0Ywc1/T2vGjOSssRsGMOiMquVdNsjJClYzswAm3dDUmnswa3mvvv
        YvGcZaBGu8IGUl9IclbglH4vXw==
X-Google-Smtp-Source: AGHT+IE9s027KIYi6owabCjf/8FiMgf5Q19gDYbGExDgyCLbPrk+0TF4xCTXJ3ZMV2MmaWjV3Njd5A==
X-Received: by 2002:adf:e489:0:b0:319:6e5b:c7d7 with SMTP id i9-20020adfe489000000b003196e5bc7d7mr2337956wrm.30.1692204853664;
        Wed, 16 Aug 2023 09:54:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id r7-20020a5d4947000000b003197a4b0f68sm10233279wrs.7.2023.08.16.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:54:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
In-Reply-To: <20230814134024.397739-1-luca.ceresoli@bootlin.com>
References: <20230814134024.397739-1-luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2] drm/panel: simple: Fix Innolux G156HCE-L01 LVDS
 clock
Message-Id: <169220485242.2959125.4727047434360696027.b4-ty@linaro.org>
Date:   Wed, 16 Aug 2023 18:54:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Aug 2023 15:40:24 +0200, Luca Ceresoli wrote:
> This panel has been implemented in commit 225213f24c79 ("drm/panel-simple:
> Add Innolux G156HCE-L01 panel entry") with a higher clock than the typical
> one mentioned on the documentation to avoid flickering on the unit
> tested. Testing on a different unit shows that the panel actually works
> with the intended 70.93 MHz clock and even lower frequencies so the
> flickering is likely caused either by a defective unit or by other
> different components such as the bridge.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/1] drm/panel: simple: Fix Innolux G156HCE-L01 LVDS clock
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=438cf3271ca116253cffb8edce8aba0191327682

-- 
Neil

