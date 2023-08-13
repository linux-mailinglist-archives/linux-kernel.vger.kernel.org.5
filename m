Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD06977AEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 01:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHMX1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 19:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHMX0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 19:26:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CF910C0;
        Sun, 13 Aug 2023 16:26:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f6231bdeso1067865b3a.1;
        Sun, 13 Aug 2023 16:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691969198; x=1692573998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuNbu0gbni6xXLXBo/G7aeBfgO26R2ZGnsk2uYvwiOw=;
        b=gTRv7Lyxt0jQpLY3S2vxMdR5Bswj9Dn7L/Tdq7DQqC1rIlsNAieoxQnYfj6Yd+abxT
         qI8gr8X6k2YbqDDySB/atsnK5ifyd2LlHooXjkpMh3YkALKcTt9J0XS+ki8USpqJ1xva
         lja3IFqlOFpTq0jddq73wMMQSt13kDJBN0GDsTeOd0+bmy3BCLZ/hvYCPFdhFvTBSenn
         6WjjRxPdkQ0Ep/SnH8ntZXK1xckUOjTKLDFUbcEwctiZmofdsVmJDMEZ8/ub7NyGqd/d
         MsuaA9HyJ5i4ZsUD/ZhImGnlabKt3sOfjpN9i+myHIjBh8r/JRGQH9UGsngoLweu5456
         0Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691969198; x=1692573998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuNbu0gbni6xXLXBo/G7aeBfgO26R2ZGnsk2uYvwiOw=;
        b=f6t+LyWDAhyzXp9yaUy0b3EwI3MbFdT8tURoNbF0Id9kFt9SWLqPfJ8HLPqV43Hj4P
         53kIlIE9t23sVHMLhvLe1PzcRPhZu2Xi1M9daaXc9jCUIJi0Dm6zVabxYPdntm9DHAu0
         7SalcBevFFuHCYe0BvTxI1UOa5YkpvSdgC8pg13PtvbgvyXrgOWo9K/Uu0zMws3fvOq/
         WRqtYeFUwha6t8XQ0rK2JowjhPYPc90kaKFnmql9f8n6yze9Vmd7m2hym8dM4WZsUOMy
         4mRv6H5vg1fxCe1NV8tsAhRA9AQFvM3ffnw9oSne608PIFVwXW+6HFha54mtGUrOYI7j
         5PhA==
X-Gm-Message-State: AOJu0YxILwfJ/Iese5N1DbFni9XPvfXRqXXcCCCel1oCrHi2PB7+bE84
        AjrB8n8wBAGUWt6tDFy4UQv5NVrINIRrs77gQ0U=
X-Google-Smtp-Source: AGHT+IGdBhtZ+hQTxv3eusdQZDNsm5z8qa01ROz2ftxFts8FbdAc+Zumj/zzXP0WxszQ61aZmXq9YCegUF7jtNBcjDI=
X-Received: by 2002:a05:6a21:3289:b0:137:4fd0:e2e6 with SMTP id
 yt9-20020a056a21328900b001374fd0e2e6mr11547458pzb.6.1691969198407; Sun, 13
 Aug 2023 16:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230813164003.23665-1-aford173@gmail.com>
In-Reply-To: <20230813164003.23665-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 13 Aug 2023 20:26:27 -0300
Message-ID: <CAOMZO5D-EjhDwBKcnC7Npwtbg5ezM-Ce_Yockdkak_FRTa68zQ@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref Clk
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
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

On Sun, Aug 13, 2023 at 1:40=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> There is a I2C controlled 100MHz Reference clock used by the PCIe
> controller. Configure this clock's DIF1 output to be used by
> the PCIe.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Remove the pcie0_refclk clock that the new one replaces.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
