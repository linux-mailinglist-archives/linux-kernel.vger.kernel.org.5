Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B37FD61E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjK2L7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjK2L7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:59:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB46D48;
        Wed, 29 Nov 2023 03:59:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfa7be5650so12757025ad.0;
        Wed, 29 Nov 2023 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701259152; x=1701863952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiz1YQ3ex/PDqpKeO5hBnmEOTT9sa1wfkN7dL/DZS+Y=;
        b=Pli+4vUyv6yLqbp/+rxseau+x+92zdV1f/luEOMR+dPTvwrpxWob1fAOruRSiKW9JP
         xm8V3x3sHTKDPmns7NhM80+EGMx+uITXTf9u75cT/EpEIZnTAjAxbx/uQgfRGm/18sRG
         QPUQbUpmAVcYDLp/8e4clSqMRUgfpbHjfEXjZBKH1aEv44+nEx3FpTE9RNpemteHJG9S
         JTzQHlv6TClGdCNXXNwfVyTf10qVIzHTGGgHXcWMagjITHIG4K92KzNGAn/eFA23BBgU
         DKzv2ovoMpgdYqqwhkk4oX+XeWHiuW3gHh4qhnWqH4UmnIp/jySBcVZHkyCQp3HEaaGf
         XVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701259152; x=1701863952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiz1YQ3ex/PDqpKeO5hBnmEOTT9sa1wfkN7dL/DZS+Y=;
        b=Y67xAtWGjnNnEQSaXGbzr8IRKu6gaKskEjAE0n1LVhOm+8tvhrHpvZBgXyU/HDffSU
         fB3R4yTF8WcAtmdxRabu7rOgbwXv/SwgzzUq1a82D/HvhrEEcRmte19lcupPS6cLKKK8
         WFeuB8n3lrHXynduYzp+g3/nOL+eU8e0fSzEv7H5Zm71bbWj1FwtxJnId3SRfdaaywBi
         r3QyiAawgkDSI55euYBxW10wMlJZaKeiHl14Zf9jyxiImsYFBWVKy2pX2KJR+wyBHK2z
         RMcc+sxllEPREqOFD/em7XxQm5H6rkwz/3xrbg742J6Ow2wbzsDpw9L7+JKmSC6+HMQg
         5irw==
X-Gm-Message-State: AOJu0YzDfoZnIflclSnXgmgDYT9x93r0Sa1jgq4sYW6B3OB/w/2Y3twT
        y7CYcfZhYf2l8sn/f+IKKewUUt9QpAIO3KPUnQw=
X-Google-Smtp-Source: AGHT+IGB4I04tVMMJG4GvfaodrUXWkag7vDbClcKnQ9BiIsCicbs4xo0nXOib7Y7ZcEKiSQORcqcWYuP4G+lcycYwl4=
X-Received: by 2002:a17:90a:7408:b0:285:6f2b:4e82 with SMTP id
 a8-20020a17090a740800b002856f2b4e82mr18111607pjg.1.1701259151743; Wed, 29 Nov
 2023 03:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20231129093113.255161-1-paul.elder@ideasonboard.com> <20231129093113.255161-2-paul.elder@ideasonboard.com>
In-Reply-To: <20231129093113.255161-2-paul.elder@ideasonboard.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Nov 2023 08:59:00 -0300
Message-ID: <CAOMZO5BPQCyCQKPvc9HHqANk5rKic25EkUGCjBdf-d78zGDR0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add DT nodes for the two ISPs
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Li <Frank.Li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
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

Hi Paul,

On Wed, Nov 29, 2023 at 6:31=E2=80=AFAM Paul Elder <paul.elder@ideasonboard=
.com> wrote:

> +                       isp_0: isp@32e10000 {
> +                               compatible =3D "fsl,imx8mp-isp";

This compatible string is still not present in today's linux-next.

Will it be merged soon?
