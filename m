Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC27636D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjGZMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjGZMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:54:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD83B19A4;
        Wed, 26 Jul 2023 05:54:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7748ca56133so60676139f.0;
        Wed, 26 Jul 2023 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690376083; x=1690980883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nypF9NHVLOaXJSPHj2PIoRQwBC4E0LVifIvHGKcCHtE=;
        b=D9g3omdONjBXXMYcUf0O6KEYiak7UGvpRF/zsEY8116/GDMzWPXWRUB5l3mYfkIsXA
         PlAZZ1qWeprT+28VZ+uDoGEoZnvrY3KzGgjfugbusQxF4KotB3iPkNLXKiJHMlJh0Lh2
         Hsfe1xi7kwzErrYZwdiL4crpUhjI8EraN02qxKCKmQoPk8IautwMpImnc/idJsTi53OM
         zxf9bn1OxCVjtwW/pCJjGwU/5/38kVAKarjblXWdWqTcWdCLU/y587mVAnlViSWiIibN
         lon7aeW0aCjovghlW76tXd/42xSqSIicsR9COdZ/YKN0n0QvhnVg3hS9zAGqzi/ethiG
         yiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376083; x=1690980883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nypF9NHVLOaXJSPHj2PIoRQwBC4E0LVifIvHGKcCHtE=;
        b=PBfEUcWRlloxcPFgbTUn7GTqns13uphm0iGIZU/GLnsQjFeF5bdJE2B4fWUTwpdhp0
         dF2EXsLOcesKTxadwoNDD2ZXoOC0r4mDJZIq5nyb3urT80B5He8ZwfGNa/6uOo8gr29A
         2VanJ5XAdB416vuN+Xvko6sTEzyF9066XcGfEltsD60a5H393ZJHpyVMIY92/4OMuqBu
         aOCR1/4ceW8A1zi+Egx184DJrRCSYVaB97gRB4oO/1cUohED4wSarGkzOF3YcjZlqDD6
         Y5Imh0IQW9IswIPqE6AowwS7k148eDpCrzy/vDDCSsRPvctf0mB/b5pYvLvloF/63rTW
         yjBA==
X-Gm-Message-State: ABy/qLaRhVLIMZf1OJLbbqXIuPz357u0otK/DWGYfe5sBUDISbp1IezE
        Qv1nJYVn9SWj4t0h4SRMJ/xMH5w4rb4kCYOtJUc=
X-Google-Smtp-Source: APBJJlGXQsHeiyQ/2qrgTv0a14/QMTqvV+VTmfjlLFi+S8pP8K0OZL1w3229Nv0NlJuAmedOkhl/7MEHqeBufUu+Dbc=
X-Received: by 2002:a05:6602:3981:b0:787:16ec:2699 with SMTP id
 bw1-20020a056602398100b0078716ec2699mr1919140iob.2.1690376083097; Wed, 26 Jul
 2023 05:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230726123747.4097755-1-james.hilliard1@gmail.com> <20230726123747.4097755-3-james.hilliard1@gmail.com>
In-Reply-To: <20230726123747.4097755-3-james.hilliard1@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Jul 2023 09:54:30 -0300
Message-ID: <CAOMZO5AdCxQsQA946R8Xp9o7SCS=+wco4aGyqJ8P2ENsvpaMmQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] ARM: dts: imx6q: Add Variscite MX6 Custom board support
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 9:38=E2=80=AFAM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> This patch adds support for the Variscite MX6 SoM Carrier Board.
>
> This Carrier-Board has the following :
> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
> - HDMI Connector
> - USB Host + USB OTG Connector
> - 10/100/1000 Mbps Ethernet
> - miniPCI-Express slot
> - SD Card connector
> - Audio Headphone/Line In jack connectors
> - S-ATA
> - On-board DMIC
> - RS485 Header
> - CAN bus header
> - SPI header
> - Camera Interfaces header
> - OnBoard RTC with Coin Backup battery socket
> - RS232 Debug Header (IDC10)
> - RS232 DTE
>
> Product Page : https://www.variscite.com/product/single-board-computers/v=
ar-mx6customboard
>
> The dts file based on the ones provided by Variscite on their own
> kernel, but adapted for mainline.
>
> Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
