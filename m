Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC0752A85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjGMSw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjGMSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:52:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E82D46;
        Thu, 13 Jul 2023 11:52:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51f64817809so182780a12.1;
        Thu, 13 Jul 2023 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689274375; x=1689879175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NixJWzqt1EjPHkU5qyxuUeApGxt4CQ82ymuiFFE918=;
        b=ikaR+83VfC9yF4TiOsgy7ytWMqDdUYZMTJ3+XDHpD7/BBNmR5A5DXitguXoQ+ED4hz
         Zi9dVBULac02D3tX++eGjShegtbcoPLSMKrYN2BLAS938V/jCrfBS4CdsySiiIaxktqB
         QMW8Xfp7tz1K8/CjPDfGY9CH0C2l7oQGROY62LiPIcUHoKoRm2DeoqhsNwdkU7FX/dck
         U7841corxG1iMD5sqMpK/0w7fh9OwPGrRxZRfoLpJYnyfh75s22eahO+y9hrwd5CF0zm
         6tej33YD5i+3GdQgBkdSlMqUoh+uVGATRmxVXtFNV98dna/bkb5Z8ybbDDu4g9nLgQv9
         Q/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274375; x=1689879175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NixJWzqt1EjPHkU5qyxuUeApGxt4CQ82ymuiFFE918=;
        b=VQ/q7J4mGRhz9VBIVszu61RargmMZL/EVZDiglm2y2qj2U7sOf1TCIaTR7RhsdrU36
         xs7P5WkOc1Y77baiLNsIQK34FwWhAwews7l3BcdQMDGF/Fn9v4QzA98Y5OsNDoXWLFYx
         9DADq/2HEQ80JxgaX0iAhc6JXBnt9TBVcKder6wowQ2IooKgevpBZN74i16UJbwvpTMf
         CjsDVq2y2LhcNEZakBs8l+e6lXV/1S8cK0DPn0tPZN3ObVMQNB9x5g1g7jMx6CzHkyQ3
         0isMSGR9X2ZBeb8+ii4UWA/jwCq3lwcNmMd1lP/5zNlazpZ4Q0J4077RiXpIoMo7GnrJ
         crEQ==
X-Gm-Message-State: ABy/qLakzV5ZfukgrfBC6CbDSbr2WOw4MZTRFDkTlVWc1r2aC0LicI+v
        gbXZ2PcbuNLOL4GXwxeH/CJavZO7XgjLVQmXC9Y=
X-Google-Smtp-Source: APBJJlHNd2KOozWfR2CqzSzU/1z9m/tWYsp6uMyAwLsPMAWLc7dUpvYu7xpju0YYHNUlsMKDn0OlM+ilHQCddeaBgyQ=
X-Received: by 2002:a17:90b:46d1:b0:263:a5b5:c538 with SMTP id
 jx17-20020a17090b46d100b00263a5b5c538mr2285459pjb.4.1689274375326; Thu, 13
 Jul 2023 11:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230711221518.2127861-1-tharvey@gateworks.com>
In-Reply-To: <20230711221518.2127861-1-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 13 Jul 2023 15:52:44 -0300
Message-ID: <CAOMZO5ByzpUoirrTKz=x+00F2_oi6UK12wvLw9jFu6p7S+LWwQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-imx219
 overlay for rpi v2 camera
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:15=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add support for the RaspberryPi Camera v2 which is an IMX219 8MP module:
>  - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
>  - has its own on-board 24MHz osc so no clock required from baseboard
>  - pin 11 enables 1.8V and 2.8V LDO which is connected to
>    GW74xx MIPI_GPIO4 (IMX8MP GPIO1_IO4) so we use this as a gpio
>
> Support is added via a device-tree overlay.
>
> The IMX219 supports RAW8/RAW10 image formats.
>
> Example configuration:
> media-ctl -l "'imx219 3-0010':0->'csis-32e40000.csi':0[1]"
> media-ctl -v -V "'imx219 3-0010':0 [fmt:SRGGB8/640x480 field:none]"
> media-ctl -v -V "'crossbar':0 [fmt:SRGGB8/640x480 field:none]"
> media-ctl -v -V "'mxc_isi.0':0 [fmt:SRGGB8/640x480 field:none]"
> v4l2-ctl --set-fmt-video=3Dwidth=3D640,height=3D480,pixelformat=3DRGGB
> v4l2-ctl --stream-mmap --stream-to=3Dframe.raw --stream-count=3D1
> convert -size 640x480 -depth 8 gray:frame.raw frame.png
> gst-launch-1.0 v4l2src ! \
>   video/x-bayer,format=3Drggb,width=3D640,height=3D480,framerate=3D10/1 !=
 \
>   bayer2rgb ! fbdevsink
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
