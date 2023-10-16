Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9808F7CA4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjJPJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:59:16 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F59C;
        Mon, 16 Oct 2023 02:59:14 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d77ad095f13so4279981276.2;
        Mon, 16 Oct 2023 02:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450353; x=1698055153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9GLVUGKessKoslJIZpAI7+l//jryIRXWw3bJSWd/JU=;
        b=YpDAPKeVaVk1om3qEAtzdITkpkguvsjgbnlLajX5IRwq2TkM9TxIcL1p0S0ZmmVckF
         A0x+ofvsJMYjROMp2PtTgDf1CU1Fo0Ylz+dq+We7gyYjX4h8UQH8zeTVJqsmn2DRLTJ5
         SswsTJEzJxsypsRZ2hORFL680Cc9wtTQeHWr9p40xJ5JY22csfxEAvUDsPUe6hQ4marD
         iNcRBKzq5hJ2cPl5VotwkrC1h6tCsn0EKlz5saQ29r7B2rR43Q1DSmGo/9ifiCRFj4c/
         xXIh3fEKUTDXPvJjrh3kynCkyZqINJ52l4fZcn3c+bTTZBXWPBq+EU7/rhPr3VnsPTA8
         f5lA==
X-Gm-Message-State: AOJu0Yzmn5aPl+3Sq+cW4aiMGD9x2AQwmBanQ5emqVFkWnZmXJZbenrm
        v8diF7JUoDbSZYE/rWdWJ4idOe8NfGvpAQ==
X-Google-Smtp-Source: AGHT+IHDifpYoVg377WaVlCQbyVtL075I/N8OSBwyoKSlQwbzsy4Q39TGatkdfof4lMFOPSU9W6aXg==
X-Received: by 2002:a25:a044:0:b0:d32:cd49:2469 with SMTP id x62-20020a25a044000000b00d32cd492469mr30483446ybh.24.1697450353351;
        Mon, 16 Oct 2023 02:59:13 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id s10-20020a056902120a00b00d800eb5ac2asm2501003ybu.65.2023.10.16.02.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 02:59:12 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a2536adaf3so58366447b3.2;
        Mon, 16 Oct 2023 02:59:12 -0700 (PDT)
X-Received: by 2002:a81:b661:0:b0:5a7:b9b1:c0bd with SMTP id
 h33-20020a81b661000000b005a7b9b1c0bdmr19215902ywk.11.1697450352391; Mon, 16
 Oct 2023 02:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694767208.git.geert+renesas@glider.be> <CAMuHMdWfBTKdXvZutg4LvWqBjuz-X=ZjzX0LKPqD=JxYuLoPRw@mail.gmail.com>
In-Reply-To: <CAMuHMdWfBTKdXvZutg4LvWqBjuz-X=ZjzX0LKPqD=JxYuLoPRw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Oct 2023 11:59:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUF61V5qNyKbrTGxZfEJvCVuLO7q2R5MqZYkzRC_cNr0w@mail.gmail.com>
Message-ID: <CAMuHMdUF61V5qNyKbrTGxZfEJvCVuLO7q2R5MqZYkzRC_cNr0w@mail.gmail.com>
Subject: [GIT PULL v2] drm: renesas: shmobile: Atomic conversion + DT support
 (was: Re: [PATCH v4 00/41] drm: renesas: shmobile: Atomic conversion + DT support)
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi David, Daniel,

The following changes since commit 389af786f92ecdff35883551d54bf4e507ffcccb:

  Merge tag 'drm-intel-next-2023-09-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2023-10-04
13:55:19 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
tags/shmob-drm-atomic-dt-tag2

for you to fetch changes up to 1399ebacbf590dfbac4fbba181dd1595b2fa10ba:

  drm: renesas: shmobile: Add DT support (2023-10-16 11:47:48 +0200)

----------------------------------------------------------------
drm: renesas: shmobile: Atomic conversion + DT support

Currently, there are two drivers for the LCD controller on Renesas
SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
  1. sh_mobile_lcdcfb, using the fbdev framework,
  2. shmob_drm, using the DRM framework.
However, only the former driver is used, as all platform support
integrates the former.  None of these drivers support DT-based systems.

Convert the SH-Mobile DRM driver to atomic modesetting, and add DT
support, complemented by the customary set of fixes and improvements.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/cover.1694767208.git.geert+renesas@glider.be/

Changes compared to v1:
  - Rebase to drm-next,
  - Add Acked-by.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (36):
      MAINTAINER: Create entry for Renesas SH-Mobile DRM drivers
      dt-bindings: display: Add Renesas SH-Mobile LCDC bindings
      media: uapi: Add MEDIA_BUS_FMT_RGB666_2X9_BE format
      drm: renesas: shmobile: Fix overlay plane disable
      drm: renesas: shmobile: Fix ARGB32 overlay format typo
      drm: renesas: shmobile: Correct encoder/connector types
      drm: renesas: shmobile: Add support for Runtime PM
      drm: renesas: shmobile: Restore indentation of shmob_drm_setup_clocks()
      drm: renesas: shmobile: Use %p4cc to print fourcc code
      drm: renesas: shmobile: Add missing YCbCr formats
      drm: renesas: shmobile: Improve shmob_drm_format_info table
      drm: renesas: shmobile: Improve error handling
      drm: renesas: shmobile: Convert to use devm_request_irq()
      drm: renesas: shmobile: Remove custom plane destroy callback
      drm: renesas: shmobile: Use drmm_universal_plane_alloc()
      drm: renesas: shmobile: Embed drm_device in shmob_drm_device
      drm: renesas: shmobile: Convert container helpers to static
inline functions
      drm: renesas: shmobile: Replace .dev_private with container_of()
      drm: renesas: shmobile: Use media bus formats in platform data
      drm: renesas: shmobile: Move interface handling to connector setup
      drm: renesas: shmobile: Unify plane allocation
      drm: renesas: shmobile: Rename shmob_drm_crtc.crtc
      drm: renesas: shmobile: Rename shmob_drm_connector.connector
      drm: renesas: shmobile: Rename shmob_drm_plane.plane
      drm: renesas: shmobile: Use drm_crtc_handle_vblank()
      drm: renesas: shmobile: Move shmob_drm_crtc_finish_page_flip()
      drm: renesas: shmobile: Wait for page flip when turning CRTC off
      drm: renesas: shmobile: Turn vblank on/off when enabling/disabling CRTC
      drm: renesas: shmobile: Shutdown the display on remove
      drm: renesas: shmobile: Cleanup encoder
      drm: renesas: shmobile: Atomic conversion part 1
      drm: renesas: shmobile: Atomic conversion part 2
      drm: renesas: shmobile: Use suspend/resume helpers
      drm: renesas: shmobile: Remove internal CRTC state tracking
      drm: renesas: shmobile: Atomic conversion part 3
      drm: renesas: shmobile: Add DT support

Laurent Pinchart (5):
      drm: renesas: shmobile: Remove backlight support
      drm: renesas: shmobile: Don't set display info width and height twice
      drm: renesas: shmobile: Rename input clocks
      drm: renesas: shmobile: Remove support for SYS panels
      drm: renesas: shmobile: Use struct videomode in platform data

 .../bindings/display/renesas,shmobile-lcdc.yaml    | 130 +++++
 .../userspace-api/media/v4l/subdev-formats.rst     |  72 +++
 MAINTAINERS                                        |  13 +-
 drivers/gpu/drm/renesas/shmobile/Kconfig           |   3 +-
 drivers/gpu/drm/renesas/shmobile/Makefile          |   3 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_backlight.c |  82 ---
 .../gpu/drm/renesas/shmobile/shmob_drm_backlight.h |  19 -
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  | 650 +++++++++------------
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h  |  27 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c   | 179 +++---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h   |  18 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c   |  77 ++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h   |   9 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 326 ++++++-----
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.h |   5 +-
 include/linux/platform_data/shmob_drm.h            |  57 +-
 include/uapi/linux/media-bus-format.h              |   3 +-
 17 files changed, 860 insertions(+), 813 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
 delete mode 100644 drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c
 delete mode 100644 drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
