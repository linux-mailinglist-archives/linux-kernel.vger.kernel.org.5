Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE937940B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbjIFPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjIFPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:48:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCBBC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:48:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso5342051a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694015283; x=1694620083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YnkA1hdOlu7MrSYVoA9DXoUNwGSQiK/yVg4K+jIqsI=;
        b=cII62tIbFEtEVfxzYyNPpudhsB+CS+5vDuGWZrf1MEfjPbxRlYCUjtxdtmrJV2FSb0
         MBi+ck4svwg5PN8Tp4mcP8vAtobWoHrSZqg7YmCKZ4veAWvQJx4fWU3ij6tAUR3yC567
         8cQQ59Yfxi+Ya/29I03fXZEUK/ukZ1tMW7YBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694015283; x=1694620083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YnkA1hdOlu7MrSYVoA9DXoUNwGSQiK/yVg4K+jIqsI=;
        b=i2zU2GGdQQRkiA6XNLxCfyhBRSEvx/ixXymQFJ5wUEuL+PKGrFzenim/ZMSttqRcfD
         03qjsSTffmQXNalYS5r+tPvBe3VoR0ToMbnMxfHMAetuhjXxXSfBIMbpbAJpcKj3UOn6
         YHP9lUjls6T/US6sTX9srT5jE6k/OCS4QX92h2EuMfaWp6uCapeTx51c6siUTnfPRZhr
         gJTYtVkV6XGJQdC9N/CVMT+TJGF6nhC8yEsw7KIISSwSkRX4yLqZdCpzML3gZ66sd27S
         sNeDEyU3wvipuoCDX/G67AVtJCGyhNkmhxlntdgQYtQNuaD+Kmg7EhV9GIzPEjLdu1JX
         Dw7A==
X-Gm-Message-State: AOJu0YzJMbiDa24ZB00KbTjjyKSDS25fNVAvssrKy7rP1ksC+LxflVRh
        UAjtt2bO1bJwy6Aij2GiHHXp1f/xvx8iqLqvnetcISrm
X-Google-Smtp-Source: AGHT+IGsdNOQB4qsaaPN8BX49yT2yZON7TjbILdh/YGUqM3w8XJm1xFi2wq+nahI0r3XGHxOET6KxA==
X-Received: by 2002:aa7:d5ce:0:b0:525:69c8:6f51 with SMTP id d14-20020aa7d5ce000000b0052569c86f51mr2556136eds.35.1694015283438;
        Wed, 06 Sep 2023 08:48:03 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id s8-20020aa7d788000000b00527e7087d5dsm8455650edq.15.2023.09.06.08.48.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 08:48:03 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so16794a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:48:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:3fe:e9ea:9653 with SMTP id
 l20-20020a05600c4f1400b003fee9ea9653mr156513wmq.4.1694014937894; Wed, 06 Sep
 2023 08:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com> <20230831080938.47454-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230831080938.47454-3-biju.das.jz@bp.renesas.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Sep 2023 08:42:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-Mft_FjqfkgyMf--03tqrAoCVsG23v-4CBR0sQZFjAg@mail.gmail.com>
Message-ID: <CAD=FV=V-Mft_FjqfkgyMf--03tqrAoCVsG23v-4CBR0sQZFjAg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] drm/bridge: Drop conditionals around of_node pointers
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 31, 2023 at 1:10=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> This patch is based on commit c9e358dfc4a8 ("driver-core: remove
> conditionals around devicetree pointers").
>
> Having conditional around the of_node pointer of the drm_bridge
> structure turns out to make driver code use ugly #ifdef blocks. Drop the
> conditionals to simplify drivers. While this slightly increases the size
> of struct drm_bridge on non-OF system, the number of bridges used today
> and foreseen tomorrow on those systems is very low, so this shouldn't be
> an issue.
>
> So drop #if conditionals by adding struct device_node forward declaration=
.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
> v5->v6:
>  * Updated commit description.
>  * Added Rb tag from Douglas Anderson and Laurent
> v5:
>  * Split from patch#2
>  * Updated commit description
>  * Added struct device_node forward declaration.
> ---
>  include/drm/drm_bridge.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I think this has had enough time to marinate, so landed to drm-misc-next:

d8dfccde2709 drm/bridge: Drop conditionals around of_node pointers
