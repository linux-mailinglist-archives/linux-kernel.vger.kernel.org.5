Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1777BF66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjHNR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjHNR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:56:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B7195
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:56:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c47ef365cso631112666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1692035766; x=1692640566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFzY+3o5iyiZNR4axHbUipth5s9dsXWAEbX8x/y0bSs=;
        b=VvuZCIgyGDswMEd57lh8eCRqznErox9a+3qXCVw6XOLpEnr+qVsJim5THwVS88J0Dm
         6XQETgkMQrTUmjYs0RTdDZznEqxy7AC9Ghxd/lP+/VRoUFnJS2gpu6FKQJmBjmAgX6gS
         WB7a2cE3lLOBM+KJjGSKDcKLoEJsyQVDWKlCEo3xSD0QJ3N+UZBp71SgwYqLZ3uMXJrZ
         V/RoEGs2lSuyGzzsz5md6Y3sasUnZZJ6GWkGSeEnFMOz9zqNbXeIunIp/lP5US5cRshE
         aT+KBj9gVjEhZ1UAak/kiS7QZSBalg9Aww7ZYfOZBxs1NSD2QlLq/O7ZwDLQWWArm4Eq
         brJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035766; x=1692640566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFzY+3o5iyiZNR4axHbUipth5s9dsXWAEbX8x/y0bSs=;
        b=MKo80+L5ywk9I/8l750WCGaBNNFWgD0TBQ0X4Te6q2k4tBzyw2qRlfuxoD410p+l46
         N07VckcQoalB6zBgyE+lk6FAmhBbvI+7gIZcnhGfmSp8kJxqpJNcg5MIL9RxQQygvEkh
         5lRdUNoWlBumbUuaBrXXVwgJ2DVDdp5fNMt5sYf2WMerxOjI1ef3KuY7UHVTs9VUt1YY
         aAmn5864srwGup4bpoWxKPgTy2OpVwyvGJrWfq6QvLaj9FUwf9REVRBy7qBalM72xfs4
         x9TA7aXPvwzqTI8E6F5ikqcNVCxXvOD7iKbtFo7uNgwXhV9nbbJEhYsY64u+0uAtqH+I
         Nz9w==
X-Gm-Message-State: AOJu0Ywlo19ykMvmtiYXNezmK6tDLnRGr1ixTozYRPXN8M+lH1FW6god
        LZKUHcdEHr2fgo3t3YJ26MlZiQZJeIEf5WpMSaqslg==
X-Google-Smtp-Source: AGHT+IGgfxvXjmSfHVrcDeGhQilM7aaIkidzxzEjSXmxxLG7h8txfZ7ybxQsnlCFLAr4hYjOOEt9f0Kf+JOL9WQeYl4=
X-Received: by 2002:a17:907:2cd1:b0:99c:c8ec:bd4a with SMTP id
 hg17-20020a1709072cd100b0099cc8ecbd4amr8073369ejc.60.1692035766424; Mon, 14
 Aug 2023 10:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230711221518.2127861-1-tharvey@gateworks.com> <CAOMZO5ByzpUoirrTKz=x+00F2_oi6UK12wvLw9jFu6p7S+LWwQ@mail.gmail.com>
In-Reply-To: <CAOMZO5ByzpUoirrTKz=x+00F2_oi6UK12wvLw9jFu6p7S+LWwQ@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 14 Aug 2023 10:55:53 -0700
Message-ID: <CAJ+vNU1W+DTJrVxPFTFmStL4Z5TSVZE3Adr3g9T527LUchLEhw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-imx219
 overlay for rpi v2 camera
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:52=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Tue, Jul 11, 2023 at 7:15=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > Add support for the RaspberryPi Camera v2 which is an IMX219 8MP module=
:
> >  - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
> >  - has its own on-board 24MHz osc so no clock required from baseboard
> >  - pin 11 enables 1.8V and 2.8V LDO which is connected to
> >    GW74xx MIPI_GPIO4 (IMX8MP GPIO1_IO4) so we use this as a gpio
> >
> > Support is added via a device-tree overlay.
> >
> > The IMX219 supports RAW8/RAW10 image formats.
> >
> > Example configuration:
> > media-ctl -l "'imx219 3-0010':0->'csis-32e40000.csi':0[1]"
> > media-ctl -v -V "'imx219 3-0010':0 [fmt:SRGGB8/640x480 field:none]"
> > media-ctl -v -V "'crossbar':0 [fmt:SRGGB8/640x480 field:none]"
> > media-ctl -v -V "'mxc_isi.0':0 [fmt:SRGGB8/640x480 field:none]"
> > v4l2-ctl --set-fmt-video=3Dwidth=3D640,height=3D480,pixelformat=3DRGGB
> > v4l2-ctl --stream-mmap --stream-to=3Dframe.raw --stream-count=3D1
> > convert -size 640x480 -depth 8 gray:frame.raw frame.png
> > gst-launch-1.0 v4l2src ! \
> >   video/x-bayer,format=3Drggb,width=3D640,height=3D480,framerate=3D10/1=
 ! \
> >   bayer2rgb ! fbdevsink
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Hi Shawn,

I think this patch got missed. Was there something I need to do here?

Best regards,

Tim
