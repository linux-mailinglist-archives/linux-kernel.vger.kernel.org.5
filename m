Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63561784D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjHVXFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHVXFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:05:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1685CD1;
        Tue, 22 Aug 2023 16:05:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso665568266b.1;
        Tue, 22 Aug 2023 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692745517; x=1693350317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl1tPAJsY+6HeQIjw/xN1e5yMc1WTSncxxsEvTVmB8M=;
        b=J3AHJmH5FH5EWYJY8LWPuAdZqR9BdWQ9dx2Mj9W8vbp91TJ1UXiMgOCaUxI2aniiPB
         f1leJ9g1sr121JreOI3n55cXPjQ7zA4o+tr/7Xj74XSjU5xhQVWLAfv65/vuYbr+kS+Q
         /ovh7L4fXD1jtqk7udukzQ4S+YSX4HiRJ6H32pFUdajFJgi8zouIDKUDCUd8weXZcFy5
         ZQdQmjTtG2icVUMVYzlmKfRIHEZx+3QyGoKxKz9zH+LFSEbggDHgyj35mT8loDz5Q5Ms
         keThPZVmZN3bIb4H+MsLBJ3MXYDN+EbaYcEO8+DwlnB7dfUrh5WDAO80g84MD1k1IB9r
         87Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692745517; x=1693350317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl1tPAJsY+6HeQIjw/xN1e5yMc1WTSncxxsEvTVmB8M=;
        b=bpSOXZCQg6AZilc/N7UwfYo6CMI5GyuDYWHKNCf4thadvtQALvap6CJBcGhdgeqIvB
         S8o0UmgLb5kxrGl1EfpTLpEWp0lnOJyqCrg2vmFZeh4aIAiNxTMfKMiBb0HbzlR4ydjd
         1qTjkMJENfkE63zRPgW6b5S3O77V1Y8mGgzSJUuk4TDqR2UKPaYamneOg4cmYfP1c/w4
         xsaYmN4u0p30VQ7SrtUgmon4SAVQYC809iozizgvm6E2+QPFX14547BwRuUAriLbNsdM
         CeaQSCQN1UUdNfwU98bdbVLgcYvFixiOMeIbORC6hSQJUhqfo8h3IMLRqFteQzzBHHLK
         LqJA==
X-Gm-Message-State: AOJu0YxYtLzzTfNGMX3IY729jIJbyoNMLxD/V0MXn4lJUzRs2UuW3nUJ
        fu/8kYC60E2ZSpoO+0hfY6IHRc1dMi+tvxti4h0=
X-Google-Smtp-Source: AGHT+IGc4vnfO5SO2rv82RsYq+TW7/uByZDfWyswWgwX0GX8iv3xt75IkRdZmjAU5aKwi0tBJtJFC8zrCiSUE6S0eJg=
X-Received: by 2002:a17:906:535d:b0:98e:f13:e908 with SMTP id
 j29-20020a170906535d00b0098e0f13e908mr9494142ejo.60.1692745517251; Tue, 22
 Aug 2023 16:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174702.4059100-1-robh@kernel.org>
In-Reply-To: <20230714174702.4059100-1-robh@kernel.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 22 Aug 2023 18:05:06 -0500
Message-ID: <CABb+yY0ZEkU2fEoFcihDM0GPuNBkCJHYXfkq-+bLJY1xtbf5Jw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:47=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
>
I thought I was to pick the patch. But I see you intend to do it. Np.

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

thanks
