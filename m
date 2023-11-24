Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF57F7700
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjKXOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKXOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:55:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBFE19A8;
        Fri, 24 Nov 2023 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700837675; x=1701442475; i=wahrenst@gmx.net;
        bh=MGJoLdIJ4b3gS02fNyae9jTdxCk07HvijAvt2pTRhQ4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=QG3pg+mDJJ0hhMk/UZ/jr73ct86jleYBys0UoOtGR7/xQlFmGat8nFEHKxf0x4gU
         g9U/3K7fWZbo32IEOcqeaAoJ6byPn1kGfNiMc1jXg291cHUNblWt/oapim4PwYfug
         M8AA0ZFOAMsCfTD+nKiTDRt9snwwPPMD/O2imJhHAR8ttlrVoR8oShC9RgQurwBHb
         VgEEemMrQ9GhdfkvHaqANL48IMiE0xxq2gIeAvyuFuLfG1H4zHW+quMcxYqdi0u93
         Qyk+Scc5VHff0RnWglhL4kMJYem2MkBOaD4Pno0RN7hTZhjnNEx6tP2/cTNYNEft/
         5wfCJhIcfiKIQLqOOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9uU-1qpYxF1cyg-00IBn6; Fri, 24
 Nov 2023 15:54:35 +0100
Message-ID: <dab03c60-caa9-47e3-9dac-fa499227b67b@gmx.net>
Date:   Fri, 24 Nov 2023 15:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Add waveshare 7inch touchscreen panel support
Content-Language: en-US
To:     Shengyang Chen <shengyang.chen@starfivetech.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, emma@anholt.net,
        thierry.reding@gmail.com, changhuang.liang@starfivetech.com,
        keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231124104451.44271-1-shengyang.chen@starfivetech.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231124104451.44271-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XPJgdC3RB9K5a7xfMbmwhaguntSiG+JsdR8ThSlBVnEdHH7OlZ6
 GzgaDPFE6LuPGjCIfCnR7UC1WzYCxsice4aPbTwtl4G03axlVTqyJzMMi8gxsFKB93KKgOp
 RX3V7WhFXT1fnfBg/V8IOqPDWlcXnEbOQFOa2tNHhyyr6Za9Phr9eMsq8k7eBK1btzjz+Xb
 XG0HXHVFeOUMidjfTSswA==
UI-OutboundReport: notjunk:1;M01:P0:LI0QlHMq6gM=;oyJjU91oOyd7xgd5qFErx8TshFT
 ztHgVOIYU1vKyGT3iwOQeRs7HJ3sKMkQ73MI20LG5PbQnm6G3YxiT6kbcebUyaFmxNDdPJ0+W
 VgaAgYGh4c1xzC61nk9wnyQQz6sJCuR4ngabq93YBibu/BxZMjbeB14VJ4Lt5aLRrUxuRA8ss
 mEnF/on9k5HKX6ujWOg7tjBHt1pDnwxKEBg6NCkE117lrpTruB+3zEf2XXM2oyg3VKwdCdqgh
 GENA3RCUAGgeV83dE+Skb2DczjdfpAjrZpAw9puoiJk5i0wQ6zV21TtViOq9s+9m9YPRaCtnx
 kixBm65R3gH5+/8Fe5J5OjLcBiwVdWnJ9Z9KtIzLw7J9Ub2HCqiSshq4fM3g9fe0VdqdOgwYJ
 lrbbeT2GfHwu/CvzBX30S8xxRYkCTTY/6EoCEVNfNe49XUVIzcSHjayjiMctFyx8TRP8YCJGX
 Pq8pv/Yg2AXhHOhsDQc8QnU4Y48z+nRskdJljEQy+SMu5Kl4Di2ROFOo7mNW67XZ7l7XK4SxI
 1Pm0YIrfFJtW8LbfCooqU3YTEJpCwhAGO5MWgWHCNkX5Hpw6ZDjYoFCrvon52PzbUdYBuMDdk
 rJYmrmsXMFEagU3rrLRf8lcTLuvAB5x/eh7BNjH/hoXH8t/x9HAn8H10QAGwlHystVdMc13xf
 q/QzpNszQk26xt3Mm5lEKmq8DVlLpU9250UVSgJT3f/fYKaGqhgx82pFAw5n1SR9puPgqJ99K
 UZ7n8ixP0SOEgEXkNfLJ1LEHSfFuZUfcBoF5srTvrhlhqnSjYGlDvUeM3mIio8RAXbrAiwrTW
 hdmGl5zSjwyBuiC1AP+HSmiB6nJqkNoxni9dWrDQtR5eezTmpcBss63BQJBR5kDOo4oyUEDbH
 0zWMgk9AlQOXpa4ZVM6TC/xtchjD3/HyenYj9H2YedeBxmXEaxPI+68T0MES7ufIY3gCsKj9Q
 v9UL6A==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengyang,

[fix address of Emma]

Am 24.11.23 um 11:44 schrieb Shengyang Chen:
> This patchset adds waveshare 7inch touchscreen panel support
> for the StarFive JH7110 SoC.
>
> Patch 1 add new compatible for the raspberrypi panel driver and its dt-b=
inding.
> Patch 2 add new display mode and new probing process for raspberrypi pan=
el driver.
>
> Waveshare 7inch touchscreen panel is a kind of raspberrypi panel
> which can be drived by raspberrypi panel driver.
>
> The series has been tested on the VisionFive 2 board.
surprisingly i was recently working on the official Raspberry Pi
touchscreen and was able to get it running the new way.

What do i mean with the new way. There is almost nothing special to the
Raspberry Pi touchscreen, so we should try to use/extend existing
components like:

CONFIG_DRM_PANEL_SIMPLE
CONFIG_TOUCHSCREEN_EDT_FT5X06
CONFIG_DRM_TOSHIBA_TC358762

The only special part is the Attiny on the connector PCB which requires:

CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY

So the whole point is to avoid writing monolitic drivers for simple
panel like that.

There is a WIP branch based on top of Linux 6.7-rcX, which should
demonstrate this approach [1]. Unfortunately it is not ready for
upstreaming, but it has been tested on a Raspberry Pi 3 B Plus. Maybe
this is helpful for your case.

Actually i consider panel-raspberrypi-touchscreen.c as a dead end, which
shouldn't be extended.

Btw there are already DT overlays in mainline which seems to use the
Raspberry Pi 7inch panel (without touch function yet) [2].

[1] - https://github.com/lategoodbye/rpi-zero/commits/v6.7-7inch-ts
[2] -
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/ar=
ch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtso?h=3Dv6.6.2=
&id=3D6b4da1354fd81adace0cda448c77d8f2a47d8474

>
> Shengyang Chen (2):
>    dt-bindings: display: panel: raspberrypi: Add compatible property for
>      waveshare 7inch touchscreen panel
>    gpu: drm: panel: raspberrypi: add new display mode and new probing
>      process
>
>   .../panel/raspberrypi,7inch-touchscreen.yaml  |  4 +-
>   .../drm/panel/panel-raspberrypi-touchscreen.c | 99 ++++++++++++++++---
>   2 files changed, 91 insertions(+), 12 deletions(-)
>

