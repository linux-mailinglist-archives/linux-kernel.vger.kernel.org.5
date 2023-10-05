Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F917BA932
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjJESe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjJESe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:34:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991CA90;
        Thu,  5 Oct 2023 11:34:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27730028198so255565a91.1;
        Thu, 05 Oct 2023 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696530865; x=1697135665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGn6Wwb5qvDmdYfjW+R5PN97+Yo51fQfpV62EwsRm48=;
        b=ao7WS7R6lIejBwexql4XCD4g8nhCtlSnDFIJMWJ0yXWEQb9dM5Rf6QS2Jn64m2fwUe
         RZiw2oD13dE4MJzHH8yIlp50jdUZKiC23Og71lJBmZgNavlTyW6BbQSymcHEfVAYUiYn
         B3ELm21h1F4Bi54dRAMEkK3MLtZzkm4gcnhS4Iaan0dOJNdGo8lvO/xiKsxJCHczqKJR
         S8x1dVxwKF2TizehUub+BLU4cPiq9dvLu4l4hMTBt/r4Vh3Q3EVnvnTkMG560tMM27Xc
         35bCH9zvbN6tanIOVM95K8W5zuU+fiuBaBWL6ox32teAxrmcSdi9FIbdphbYBsqofWIQ
         uaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530865; x=1697135665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGn6Wwb5qvDmdYfjW+R5PN97+Yo51fQfpV62EwsRm48=;
        b=bK4KnQZSqjadBUo68TRR4HtD37DUawIhlUycyE7eovlkx6SUPEPjf79Rf/JqBDfCM6
         3mlx0Okn+Zb+S3qODS83XGGLB3adP86K9BBe3i+C8v/FzfFU4ZsTgY8Fx4U+aKKKYcQA
         MPt+u/igbhA/Rscc/d1kEWXM2v0vpPhvULv0lW+azktiL13Sh/haK3CqkURwcQbb4Kfn
         i+plsLWDDo4mCZyZOyWaq4J9IQfyx9u8Mjz1otlZQomtoejJVELDOZIOGw0RZtcdC3L0
         CCXKIsKZga6x9COo83cC7GW2/YmcSEwXxoZ2mTGp3WSK4aebHeZJUGi6i9wKJ8qpSKbO
         3D4g==
X-Gm-Message-State: AOJu0YzdZbkH945Iz0MSMySoE0VdBEqxNz/mZr7sOsZ3eJDaLwgXqKsw
        iLJeGtSsYvKRQeM1PrwzGNHK1fqHiqUP/XNC7uY=
X-Google-Smtp-Source: AGHT+IFy+vCgLsq4yxKClTrfwZDFUe04AdgZ8lXYlj/qBYiTgKq7C5sXSD6rD4py/KyyPQLThymkzTp/l3tKRcowwXI=
X-Received: by 2002:a17:90a:6848:b0:26d:4ade:fcf0 with SMTP id
 e8-20020a17090a684800b0026d4adefcf0mr5514306pjm.4.1696530865039; Thu, 05 Oct
 2023 11:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231004234657.44592-1-aford173@gmail.com> <20231004234657.44592-3-aford173@gmail.com>
In-Reply-To: <20231004234657.44592-3-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 5 Oct 2023 15:34:13 -0300
Message-ID: <CAOMZO5ADyNg3bMSH_5G3oHCoC6RdnrgMYxbAom2fgU8MDL-+iw@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] arm64: dts: imx8mn-beacon: Add DMIC support
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 8:47=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> The baseboard has a connector for a pulse density microphone.
> This is connected via the micfil interface and uses the DMIC
> audio codec with the simple-audio-card.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

There is a missing --- line here.

> V2:  Rebase and remove sound-dai-cells since it's been moved to the SoC.

This causes the changelog line to appear in the commit log.

With this fixed:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
