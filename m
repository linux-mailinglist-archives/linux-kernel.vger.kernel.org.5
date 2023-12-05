Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF7805E30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbjLES5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLES5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:57:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A8CC6;
        Tue,  5 Dec 2023 10:57:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d03f90b0cbso11355095ad.1;
        Tue, 05 Dec 2023 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701802648; x=1702407448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tevZ8UT2m5FuLuMDQ9ysXxP+PUvVdIyb8mMOrUfUXmE=;
        b=HzdBN6M29X5ZCHyZgWomWjLpaVR9snQaoRscmLKa4KzF0SZUlEKDjSJrAAwVr98gBc
         bbSZUjg5lVD3tKrilZlLgS/vykPvSdlLdv4zY5a/7Bh9dRz7DPOvipMkt+/NQ1lzyCGb
         g0wfXZy6FE1f+TbehGDvm+UXPrlA58iuLk4OT5McvZGvPB8whksTIL0WTVGSkbmxL52n
         q6NkAZJLbD/m4+Xx/tfdXzLK0AMPyaJr6ROTSEjdtJ+3S6WOdDRdcEYwwW3E3a/G2VA4
         RRykU41X3hRUiEDzmH+k4B0i7X+jp1AMzCsStk05YPth2mjuyg7Nm3dNNlvza30n/CeZ
         fqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802648; x=1702407448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tevZ8UT2m5FuLuMDQ9ysXxP+PUvVdIyb8mMOrUfUXmE=;
        b=SNfKu7e8uH5fsjbTaWNnWk4T+LYgTDy9gvSTY7s1e+o4m5o1AtB49CM1S3uJmYPKVu
         DVu40z1MVzdZ1W68KuyqW2JX7fHMnM1OaT5Luehdwwsm6ABGsO4Cda1IPI172cWZc7Oh
         Gx7YPJd86uwfCPIHVxroogkBU0Kh8sKmnlGSBvrUmGuCusBOWXuAXcp/p11PlbTMFoi/
         7j/EDcYZRVGh79O0oDUskWMkTISCGfqxIqwb8fQqvz+vqqwI0juDmortU7FyUrM79NkP
         AMacgesz8pWrBsxd9XZGkHw1k0US5VfWcj5JkXj71gl5NfCbATUAhduktoCWf1r2H3DV
         K+JA==
X-Gm-Message-State: AOJu0Yy5i9rkaYy1Gpvekvm/YwHRJV4e5BeEX3Nqrgeup4PN6FbS+U02
        IO/xGeAPrdcS/Biuxypy0sfDCNIwymaEKAj+m6E=
X-Google-Smtp-Source: AGHT+IEc7ie+iZwnxI8QRTTNI16dcqfV0yF8NX/A4xD6jvv/ItHDeZ+zdy4uH7nahij/EoLO4oKI2AgP6VqIaHfHPRk=
X-Received: by 2002:a17:90a:a10f:b0:286:4055:63e0 with SMTP id
 s15-20020a17090aa10f00b00286405563e0mr16091799pjp.0.1701802647829; Tue, 05
 Dec 2023 10:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20231205182241.2550284-1-tharvey@gateworks.com>
In-Reply-To: <20231205182241.2550284-1-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 5 Dec 2023 15:57:16 -0300
Message-ID: <CAOMZO5AWsytgARbfMdva31Yo3nB=BkjfkhQiXHY=nmWUGe3-DQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7: Fix pci sub-nodes
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Tue, Dec 5, 2023 at 3:22=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> Several schema warnings were fixed in commit
> d61c5068729a ("arm64: dts: imx8mm-venice-gw7: Fix pci sub-nodes")
> however the node names and the ethernet NIC node were not quite correct.
>
> Fix the node names as the ethernet device should have a node name of
> 'ethernet' and remove the device_type, #address-cells, #size-cells, and
> ranges properties that should only be on busses/bridges.

I sent this one to address the remaining issues:

https://lore.kernel.org/linux-devicetree/20231130225242.988336-1-festevam@g=
mail.com/
