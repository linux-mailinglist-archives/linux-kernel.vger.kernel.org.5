Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF4A75A223
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGSWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGSWn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:43:56 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487C1FE6;
        Wed, 19 Jul 2023 15:43:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9c9089d01so122221a34.3;
        Wed, 19 Jul 2023 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689806635; x=1692398635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjiDxr1nXNWtgDkK1YQqGF6vepU1fThitQZLPVNjH2s=;
        b=a8EWUNEHbKaI2dWxEqqYHcy/MKh86lVXbPCclaaJYYp806S+gH8Jdbs96/7PTzqi2L
         tHPid87EpJFcmnP4oQoZsjRFcD8LjsyB341jJFJ9BhgxOXSdh8mXz92qvMcpFcJimns4
         9Z4JMDsG3VDmU5JD5XatuR7T9VBlUgrltpFgZ7CZ7p/rolqw14gUxaW1bUA/ZS4qcBiP
         GDBDsEMdtvd7nCbtDovAy5FVquILzVsEjwcrRMOh8x/4V+Kp+kufoBC3wAuJJDeZJzIw
         MSnNjoBQN1rYWJNqAR8Rvdfj7oGnCm3f2b1fu1VNsebjjxZgRjqlH/kfKuWGpEJ/5Thw
         90Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806635; x=1692398635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjiDxr1nXNWtgDkK1YQqGF6vepU1fThitQZLPVNjH2s=;
        b=KSZva9NNf9iyHjBX5aLJ0jQGFV5CE4qBkGs9IFCaYGVrrG2c5Orc2CICHhc4hB4hZt
         5iZizmpn6f1hUaseTmWia3AzkZKqOuuV1YpOLqyAPUeINXpiTPZLF5Z3xk3wdJaw6/NK
         AtZVjla1FruWe8qV2EItSTezSLOZmUoRhbei4QPckZVk0/5XpC+UV929ucroY2VaU4Fk
         r1OjLOyEZr3Qw1+gUCUBOb5P1veWaZsJc7Yh0OD+qM8ap+h63HIQ0tMXwGEQP22Gz5VK
         JNmgkv9Uw1yv4mPZ+yLQi4QEukAJa5B+h4VYp2VWNCHpFxLAa5+HoNGUzvJTHlub9Qpv
         lWFA==
X-Gm-Message-State: ABy/qLaTHa65aWDlhCetJ3NDnK1nIA4i0qxv9b7TWLDO5+d/w+qg28NG
        H7PmS8bWhEbQU3gZwtPdUiUgjnI9uDVgJMeAl5SqkUyoirkxhQ==
X-Google-Smtp-Source: APBJJlHtF6KGL5L0+PSVX0OP5opYr3x6DMPcTKzipI2nqzUGgLF8+FRWshPhjFrk7vPcMCTrp/4gWmbm64g2U+reWWg=
X-Received: by 2002:a05:6870:7022:b0:1a9:8606:dfcd with SMTP id
 u34-20020a056870702200b001a98606dfcdmr897051oae.0.1689806634818; Wed, 19 Jul
 2023 15:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230719160048.2737423-1-james.hilliard1@gmail.com>
 <20230719160048.2737423-2-james.hilliard1@gmail.com> <CAOMZO5C_BFm+P=9uizL0buSJ9a33PM6hNgG5OcZ3B4YxD=h_6w@mail.gmail.com>
In-Reply-To: <CAOMZO5C_BFm+P=9uizL0buSJ9a33PM6hNgG5OcZ3B4YxD=h_6w@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 19 Jul 2023 16:43:42 -0600
Message-ID: <CADvTj4piksWhua5W6CMr3ZpkRJcFvR=545hsQhW16KL4gQb4pw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
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

On Wed, Jul 19, 2023 at 1:32=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> > +
> > +               pinctrl_ipu1: ipu1grp {
> > +                       fsl,pins =3D <
> > +                               MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_=
CLK      0x10
> > +                               MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15   =
         0x10
> > +                               MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02    =
         0x10
> > +                               MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03    =
         0x10
> > +                               MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04    =
         0x80000000
>
> No 0x80000000 please. Use the real pad ctl value instead.
> This applies globally.

How would I determine what the value of these should be?

The vendor device trees are using 0x80000000 for these values from
what I can tell.
