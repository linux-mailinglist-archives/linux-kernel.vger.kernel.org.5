Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1FD7C8F81
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjJMVoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMVoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:44:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0DB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:44:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405459d9a96so8415e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697233462; x=1697838262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s8RLqJudPOVEKou/gNK8vkKWsF8L5oa5Kee8jgRNMQ=;
        b=ZM5BsKEIFYc16RIyahGmK4wtThxSMBlayf7+xwkqLmVC6yJv0TqpugiQFoqHsnX/nD
         ejyr0/BtMFqVCx5r/OGuCjvPY1gzys2W7v+OpSVw0Ct2Bq/E8BWbEjmsemIBb4sdJhHQ
         E0jj9zXVLH1TytiLFez7gnVQ+GWFGSFq6/OrCKb4ykDbDeEcUDxmCu2hOdJGIpNjIyvj
         pk4zlS2E/VETEwPjvGZaWZElU2i7tylsgJkxTfLw0m+u3CU7nCiTKKsbdrtOr8yMeVCB
         GHXLUd9RJ7hnd0ZJADszxuiPw+j4Pppu1cXRHgSWwAPBrFhUMjX7v4OjO4XKjY4Ges0j
         D5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233462; x=1697838262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s8RLqJudPOVEKou/gNK8vkKWsF8L5oa5Kee8jgRNMQ=;
        b=n5/zFtuXxhWZRVx7thdPA8UeWJkAtoWUL49d/y3FsYtPGyrWtmQZwoXeMN+RAXptlw
         +3wmXFKWiOkFCBtLegwgLChzMCXYqtVH7Ixef1dmiGPK9iUL12uscr6/5ow+D9Th4RjI
         wbMGipes6J0xJjtJ1L98bIGNN5qvoYG2j+j8LLuRgxJL73JQpeZzhOByqGZzZMxeobRb
         ke7YQrYRH7qAjzUaTZb673qiR+RneCHA3W9snV+9fXkh54iRX1zjw1zMRcaqslFEiE4f
         dpEeg/8OFycbRTmXIzVjcmhmdMiPKp8OCQcscdKP1McR/gsF5ijSlOnQ5P2srjv6ELyU
         pzHg==
X-Gm-Message-State: AOJu0Yy6B4JvGwy9GObhcwKK1WUDsDXeIw5QycT8Nc2PCsNZF5OHV5Jw
        79+1POymEny+4mckh4ArcEvZxPxY/Vo1iuhUfe/9hw==
X-Google-Smtp-Source: AGHT+IEjFS5qOpUFylLrVrg7uywESSfY/S8UcGaU/2pbJM5f4+Msw5+qhuL3MAAU4IGBMXjmKEa1ETnPmWnmDO5b+DU=
X-Received: by 2002:a05:600c:1551:b0:400:c6de:6a20 with SMTP id
 f17-20020a05600c155100b00400c6de6a20mr4283wmg.3.1697233461839; Fri, 13 Oct
 2023 14:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091844.804310-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231013091844.804310-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 13 Oct 2023 14:44:05 -0700
Message-ID: <CAD=FV=Wu7aDaocnXiUg-5k+LodDvQQNh=noJ8s5jP3R46PBWsw@mail.gmail.com>
Subject: Re: [v4 0/3] Break out as separate driver from boe-tv101wum-nl6 panel driver
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 13, 2023 at 2:18=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Linus series proposed to break out ili9882t as separate driver,
> but he didn't have time for that extensive rework of the driver.
> As discussed by Linus and Doug [1], keep macro using the "struct panel_in=
it_cmd"
> until we get some resolution about the binary size issue.
>
> [1]: https://lore.kernel.org/all/20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9=
432c755@linaro.org
>
> In [v1 2/2], Doug suggested move the ili9882t_enter_sleep_mode function
> to ili9882t_unprepare. I tried this scheme and the test failed. I will
> continue to investigate the rootcause with ilitek, which may take a long =
time .
> So if possible, apply this patch first. If there are new solutions later,=
 I
> will continue upstream.
>
> [v1 2/2] https://lore.kernel.org/all/CAD=3DFV=3DXtqPJ77dx8uRb0=3DtMvC3Cvg=
H5X+7mUJeXgcG228kZfUg@mail.gmail.com/
>
> Changes in v4:
> - PATCH 2/3: Change usleep_range(50000,51000) to msleep(50);.
> - Link to v3: https://lore.kernel.org/all/20231012121004.2127918-1-yangco=
ng5@huaqin.corp-partner.google.com/
>
> Changes in v3:
> - PATCH 1/3: Remove "init_cmd_length" and "linux/of_device.h" .
> - PATCH 2/3: Change usleep_range(50000,51000).
> - PATCH 3/3: Add a little background for commit.
> - Link to v2: https://lore.kernel.org/all/20231010121402.3687948-1-yangco=
ng5@huaqin.corp-partner.google.com/
>
> Changes in v2:
> - PATCH 1/3: fix Doug comments,define "_INIT_SWITCH_PAGE_CMD" and remove =
the "shutdown".
> - PATCH 2/3: Modify ili9882t_switch_page function instead of hardcoding.
> - PATCH 3/3: Enable new config in defconfig.
> - Link to v1: https://lore.kernel.org/all/20231007060639.725350-1-yangcon=
g5@huaqin.corp-partner.google.com/
>
> Cong Yang (3):
>   drm/panel: ili9882t: Break out as separate driver
>   drm/panel: ili9882t: Avoid blurred screen from fast sleep
>   arm64: defconfig: Enable ILITEK_ILI9882T panel
>
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 371 ---------
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 779 ++++++++++++++++++
>  5 files changed, 790 insertions(+), 371 deletions(-)
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c

I think the series is well-reviewed now. I'll wait a week and target
applying next Thursday or Friday unless something comes up.

-Doug
