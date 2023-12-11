Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D280C431
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjLKJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjLKJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:16:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE4FC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:16:16 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso44500815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702286175; x=1702890975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W68af/91Atj1zDTUN4IE+pQHHryD09cfa+2lKqJ1RE0=;
        b=bkPsSXA2xvV0L0ozvXYdNvuxwhDUnmtuL1mKSIMmJmuSTA1VhCDYONRYH/Udc5cLJr
         GHMoJ2XFqjGyYZNwFAzfuiKcqhmUNYi4irejfNHZN8EPyj0GDCxI9ZMMCOaDC9MT7FeY
         alR7VRkO4nMN0JrivvV/QHswtoVRtrOPVOkbaRBuHsFAI0RkamUvOIRy5tWEfY2eZVKj
         DmCcNt5vuDXCBxcWsorv8T6d+2VSTebqRb/t45k4b/E4jR7k8n/Km2LrtM3QR6RALHEs
         gALSMIii3DMPx8eU8qCIsQ1ZfR/oICKq2gFZALNPGTOX4/mT+aaLL/VF0NZloS/BMwox
         k4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286175; x=1702890975;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W68af/91Atj1zDTUN4IE+pQHHryD09cfa+2lKqJ1RE0=;
        b=QJOQJJE6b98hzhDLM4/q/5kWV132hE+llEcMTEbVV27ij2vzoHCzt09kYmhP2YzE6D
         EU4RdzMnnXGZKdF1GxSB0PRHyNLIAwfOsSI72a2A6JFYqYY4pbRG5zmpdKVCgLOCp5YV
         KCep5oZ8a7AyehBQImtsyxmps2cKXnDJGCJ6bFTVMZkMyrged4+KgPlD7uIB0zwe1k42
         Tl20zgkFgLlXgs3aBTmSiA0AUFq4drljcXggDNss61l+cKLQisI/AgynX5qXNMsmdx6D
         JYGDNsl8g4CjGg+6QHbPzlivLYyszyKDTI9+yorSAIDPu8yxJcXUvmz6stPiFH8AlLEN
         DGxQ==
X-Gm-Message-State: AOJu0YwGBJf8sIGahDQ4tVoTrWTRe6ldjUgZtBvFNbVOHkOZ5/HTky47
        ObGK3ojW9L2sTumP35W3vsppdw==
X-Google-Smtp-Source: AGHT+IGc7ZBXK1VFhnwmlIkMnqFbV5XQIhopbQq2WBKyxWy0zx/bRn3t4fW3cKNsLP/owsKA6iuFHA==
X-Received: by 2002:a05:600c:492f:b0:40c:3464:f816 with SMTP id f47-20020a05600c492f00b0040c3464f816mr1942464wmp.51.1702286175116;
        Mon, 11 Dec 2023 01:16:15 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm12398470wmb.8.2023.12.11.01.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:16:14 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, John Watts <contact@jookia.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231210-fs035vg158-v5-0-d75adc75571f@jookia.org>
References: <20231210-fs035vg158-v5-0-d75adc75571f@jookia.org>
Subject: Re: [PATCH RFC v5 0/7] Add FS035VG158 panel
Message-Id: <170228617410.2409693.12184151943497966820.b4-ty@linaro.org>
Date:   Mon, 11 Dec 2023 10:16:14 +0100
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

On Sun, 10 Dec 2023 17:55:48 +1100, John Watts wrote:
> This RFC introduces support for the FS035VG158 LCD panel, cleaning up
> the nv3052c driver on the way and documentating existing panel code.
> 
> This revision is mostly a resend and ask for more feedback.
> I have tested that it works on next-20231208.
> 
> John.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/7] drm/panel: nv3052c: Document known register names
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f48dee9ed7c992eaf6a3635db304a61ed82827b3
[2/7] drm/panel: nv3052c: Add SPI device IDs
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=095e3a99e793767ca6c0483d31fb5d4087966d51
[3/7] drm/panel: nv3052c: Allow specifying registers per panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=2e6b7be84d88c0af927967418a56e22d372ce98c
[4/7] drm/panel: nv3052c: Add Fascontek FS035VG158 LCD display
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bf92f9163097dc717518d598116c1e385004b5ce
[5/7] dt-bindings: display: panel: Clean up leadtek,ltk035c5444t properties
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=43cc1ce456b57ad48220393bbb7fac6e32369233
[6/7] dt-bindings: vendor-prefixes: Add fascontek
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8fcb387a210cfc30a3b61abae21d5c8c4a55e470
[7/7] dt-bindings: display: panel: add Fascontek FS035VG158 panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=267624378ed6bebd733b4917452d78780db032dc

-- 
Neil

