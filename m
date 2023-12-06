Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CD806E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377752AbjLFLnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLFLns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:43:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9BD8F;
        Wed,  6 Dec 2023 03:43:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28647f4ebd9so4541349a91.3;
        Wed, 06 Dec 2023 03:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701863035; x=1702467835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FskP6Tcyso/BvrhInHyE19EqzBIb+M3DVcP4qDTnmbo=;
        b=iLicdjpJ5HiyJf2hF5Xy6vEH8zmSvxLwIKgQLE2f6lWOMm/Q/JPpO6UKMF3b691qbb
         V/mKVe3P2c2aG8IW11WF6nsLr8kntGC/SNWf09aCZhXmHhOPRWv5+OWI19M3XZDKwxWl
         Ajo05plEI6we6dpfaAPEX2+HunN2RSyhHwV0siyeSJE4kCFFHslAH1DG1cKFtmEeIEc1
         tnRnDjC+95JWrGWRkAJTEjrOZhPYh4CCAdj3vcdrs/a7ql6HFUhmuDibvQd0nbZEEP/n
         E//QlvlTnujWUDgGXe2BL0gNX8wiuA7wX9IWFM//4OQGboPh8ZEBQSha+zIGMbCcjJQz
         SBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863035; x=1702467835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FskP6Tcyso/BvrhInHyE19EqzBIb+M3DVcP4qDTnmbo=;
        b=A6CxAmhOdp/QM7dKx5BOCTwbS+WAmR/63tw+2OYnrTr/9gpoBWwRyfI1raa8uIjyiO
         EeletBw3zbUeAemCzeYOUSqShyMc1X2fRffNQ7ew0xoJ+veCCzxDMAIy/Epn+/y0gFio
         LiaKmQw1V2mzVb0O258noKxcFeKeMN8BgsdfF2pQ8Q+KartM1O1PnihkFq5TujqkmaVk
         keWVXiscz9oY7QU7Elf8PKAdvtEe2Cc1mkY8HVxRSoph9cpWJ+H5iVocNslJTYnwHebb
         hd4mPHuOcnEHCm6GraWNH6d+mCkXM7wMe4CO9+snuvk0ZqWDIHLwMy1a/TtHKGN5WLTv
         5FfQ==
X-Gm-Message-State: AOJu0YzUgOJccm9tepxDyn4EbD49QPCaIXR07yW6g0XzWEMIo7MjzkDp
        dsbz/o0bt8HGDXKFS/vcAxOmt9awuuCSEzECr40=
X-Google-Smtp-Source: AGHT+IH89gC21/pnQQIk9gERyRAG/HzH0EvNaTRDDhniP3jL3wxZJeZNXYO6du/iRzWS/NSLwXen7cT7N0NlZh/5vwU=
X-Received: by 2002:a17:90a:18f:b0:286:6cc1:5fb3 with SMTP id
 15-20020a17090a018f00b002866cc15fb3mr554714pjc.54.1701863034627; Wed, 06 Dec
 2023 03:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
In-Reply-To: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 6 Dec 2023 05:43:43 -0600
Message-ID: <CAHCN7xLgOVPMhFWty8Yofsy4F-rFgTT=PuzD4UrA3kOsPQaYUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] media: rkisp1: Fix IRQ related issues
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:12=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> These fix a few IRQ related issues I noticed when testing i.MX8MP. These
> are based on Paul's recently sent "[PATCH v4 00/11] media: rkisp1: Add
> support for i.MX8MP" series, but could also be rebased on top of
> mainline if needed.
>
I applied the whole series on top of your DMA patch and the series
from Paul porting the rkisp1 to the imx8mp and ran the camera for 15
minutes streaming to my monitor.  I didn't see any glitches or video
distortion at 640x480.

For the series...

Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v2:
> - New patch: "media: rkisp1: Drop IRQF_SHARED"
> - Update "media: rkisp1: Fix IRQ handler return values" according to
>   Laurent's comment.
> - Drop "media: rkisp1: Fix IRQ handling due to shared interrupts"
> - Update description for "media: rkisp1: Fix IRQ disable race issue"
> - Link to v1: https://lore.kernel.org/r/20231205-rkisp-irq-fix-v1-0-f4045=
c74ba45@ideasonboard.com
>
> ---
> Tomi Valkeinen (4):
>       media: rkisp1: Drop IRQF_SHARED
>       media: rkisp1: Fix IRQ handler return values
>       media: rkisp1: Store IRQ lines
>       media: rkisp1: Fix IRQ disable race issue
>
>  .../media/platform/rockchip/rkisp1/rkisp1-common.h | 11 ++++++-
>  .../media/platform/rockchip/rkisp1/rkisp1-csi.c    | 14 +++++++-
>  .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 37 ++++++++++++++++=
------
>  .../media/platform/rockchip/rkisp1/rkisp1-isp.c    | 20 ++++++++++--
>  4 files changed, 67 insertions(+), 15 deletions(-)
> ---
> base-commit: dd19f89b915c203d49e3b23ca02446d4fb05d955
> change-id: 20231205-rkisp-irq-fix-e123a8a6732f
>
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
