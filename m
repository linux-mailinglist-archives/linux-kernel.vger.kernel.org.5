Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8B76CFFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjHBO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjHBOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:25:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B55271C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:25:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bded9d93dso171424566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1690986356; x=1691591156;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsVcsCDvamjl31gifaKwLNv2n2Xspa6emd5tT3prZvw=;
        b=eq9qvw/au3DtjNiInHv+/Ks+sX1tL4hda1Ymw/mKWe9H1Dn/0GH3Lkc2XHr2w4hnqh
         szW59lqw7i9lIfZLBs86jn+JmO2jiioTa1/OThHRi93xkN7nQo8rqnOgCYtBmvg7+wtd
         WF753BEgN/emMxve58EPL3p3mFOmrc8E1KGkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690986356; x=1691591156;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsVcsCDvamjl31gifaKwLNv2n2Xspa6emd5tT3prZvw=;
        b=jxPlfi453x5fK2mHKMPRj4L6UzstUhrjL4HOXEVCEvGcjeYMKgFBPB6euYSadoOk6h
         JIwVLLfIZ9vYbtMYzdnuVFUvPaI+XmpzniEGW3XEwbatEj+HrQr31YdWpaildhHXxeAT
         nvr1FeIj7hpkfkaNBqNVnvO3D9KcmkUUDQxZ0caqlK8GsIhdUyVrmnybVPU0pUdxeeip
         wQb98d/31X6VF9guf+RKVbNHSElZqg/VevowCW78ILnRp6xFK8lnJIVG5C6WrTLlKd8r
         it00dRfMnQDd2b1YJJzgadYuzhmGj/RZd+4hoenXkSfShhEVSRfvPmm6lcqRcnUqmvYe
         goIg==
X-Gm-Message-State: ABy/qLaKP9zmttGCDHCoDLw6FK1k9JfdAd4DEF11Lb03rd8Cy8co4VNx
        vdS1S9+ptObAsLnJHmWe0ULcUg==
X-Google-Smtp-Source: APBJJlEGuIJd0GEks9/vYG2PGf+sSGozgW3aVzw1hHeGDBgQvjzANdpy3n5m6RtZqxVwQKbbxW+z3w==
X-Received: by 2002:a17:906:73dd:b0:99b:d594:8f89 with SMTP id n29-20020a17090673dd00b0099bd5948f89mr10192169ejl.0.1690986355776;
        Wed, 02 Aug 2023 07:25:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id si15-20020a170906cecf00b00992e265495csm9261942ejb.212.2023.08.02.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 07:25:55 -0700 (PDT)
Date:   Wed, 2 Aug 2023 16:25:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm/panel: sitronix-st7789v: add support for partial
 mode
Message-ID: <ZMpnceQYSuyOmi+F@phenom.ffwll.local>
Mail-Followup-To: Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:31:49PM +0200, Michael Riesch wrote:
> Hi all,
> 
> This series adds support for the partial display mode to the Sitronix
> ST7789V panel driver. This is useful for panels that are partially
> occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
> for this particular panel is added as well.
> 
> Note: This series is already based on
> https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.org/
> 
> Looking forward to your comments!

Summary of my take from a fairly long (and kinda still on-going) irc
discussion:

- Where we do know the exact overscan, the kernel should expose correct
  modes and adjust the display pipeline to match if needed when
  programming the hardware. Meaning the approach in this patch series.

- For hdmi overscan there's a lot of automagic overscan happening by
  default. Drivers can mostly fix this by setting all the right
  infoframes, but unfortuantely a very big pile of infoframes is needed.
  Assuming drivers actually use the helpers I think only i915 gets them
  all, so intel_hdmi_compute_config() at the bottom would be the example
  to follow, and maybe some more code to extract from and share.

- That /should/ only leave the really old analog TV and similar horrors
  leftover. For those we simply can't even guess the right amount of
  overscan (because back then no one cared back then about really seeing
  everything), and so that's the only case where we should rely on the
  overscan properties. And that case only works when the compositor stack
  passes these properties all the way to the user, since only they can
  check when the settings are good.

The overscan properties should _not_ be used to fix issues of the previous
kind, that really should all work out of the box as much as possible.

Cheers, Sima


> 
> ---
> Michael Riesch (4):
>       dt-bindings: vendor-prefixes: add jasonic
>       dt-bindings: display: st7789v: add jasonic jt240mhqs-hwt-ek-e3 display
>       drm/panel: sitronix-st7789v: add support for partial mode
>       drm/panel: sitronix-st7789v: add jasonic jt240mhqs-hwt-ek-e3 support
> 
>  .../bindings/display/panel/sitronix,st7789v.yaml   |  1 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
>  drivers/gpu/drm/panel/panel-sitronix-st7789v.c     | 67 +++++++++++++++++++++-
>  3 files changed, 68 insertions(+), 2 deletions(-)
> ---
> base-commit: b43dae411767f34288aa347f26b5ed2dade39469
> change-id: 20230718-feature-lcd-panel-26d9f29a7830
> 
> Best regards,
> -- 
> Michael Riesch <michael.riesch@wolfvision.net>
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
