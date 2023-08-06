Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FA771727
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 00:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHFWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 18:03:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C83171E;
        Sun,  6 Aug 2023 15:03:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6873f64a290so1136137b3a.0;
        Sun, 06 Aug 2023 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691359410; x=1691964210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOidpmVp/xxSwpWie7WoIKgwL7vUHi8JHFlasqVV/3k=;
        b=qB1ZzoWxyRO/EWeLEM6mlkLLQxOPMdyJDyDTIyv2NnJU050hHOqIckTPbpsqKBLtgY
         Am59hbg3B4qfJ4RQf9sRuy/QX/nuXb2CA6aX1Zl8CXgJHii+Lk1jTFoo+lT50h4ojcrg
         CsvXDD5uGK9mC9I27eSZVL5O4wLql1ioYgM75kvtKzMHjLbEg3NpZuMeKAyelPA3PkhA
         Ok/8C0vXWQAIidTYLsqSXwMuuzdpB6qmga4D/xZhOKWABSEG0MfHSE/VRoN0WaK9BeOa
         hS7G2wLZd1qqRhLnHEVRpNQwXEBtHGfyr7XxEMkAUWPCg0Qem0AQZMv78afnHYVcLWoa
         yPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691359410; x=1691964210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOidpmVp/xxSwpWie7WoIKgwL7vUHi8JHFlasqVV/3k=;
        b=krVqyuXTI1rdv8+YbUNkCVI8Ecj+1gvYleeoIyzZwnDFIKwj40NIQXMhtthIzRjqvY
         TNsyyow4uV0UpjF4XYv4ywhHuOt0+gwA5q7t0ueEDETmpCdHzWYJZSockKHLuLEmQ3aw
         4UypHOwZPRia4nESlKhaKOcZQTSO7RN2Lj7T026Ad3YvHy0bi9/Z9F5D8WJds9SXISIH
         zo0H4dZlPUacvdOu69q/5cH5Dgl/xoMJZp75DHXuu07En9l+l9FgJ2vlHoS0oDl6IkE9
         /hBHWIGxn1gpTyO7rrbmQfFTTdRtELKSuwRzy2vPV9+eK/b9l7+d5Z1SwOIAHemaqkVm
         BS3Q==
X-Gm-Message-State: ABy/qLaYW2s+5niqftKUURv12pNJUtIoToL7u52lJSb3sGBFs/FZQKsP
        iIeTYEvwWLN/XQKJoMoQgfIHIneto6chlgIDd5k=
X-Google-Smtp-Source: APBJJlGlqzQusrwUjZ7NEaibag3Y54D/uIkAvi6T260pbFuuxukhMEGvFyYAYY81WV9mzk/eh0/rKwg9Tr+XrRAssGU=
X-Received: by 2002:a17:90a:7282:b0:263:f36e:d610 with SMTP id
 e2-20020a17090a728200b00263f36ed610mr22428701pjg.0.1691359410236; Sun, 06 Aug
 2023 15:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230806190622.505887-1-aford173@gmail.com>
In-Reply-To: <20230806190622.505887-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 6 Aug 2023 19:03:19 -0300
Message-ID: <CAOMZO5DfZufEDfjGDj2toMN-AT84O8u5qh5z_MVC4-6iyjy0CA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref Clk
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        cstevens@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
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

Hi Adam,

On Sun, Aug 6, 2023 at 4:06=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:

>  &pcie_phy {
> +       fsl,clkreq-unsupported;
>         fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> -       clocks =3D <&pcie0_refclk>;

Should the pcie0_refclk node be also removed? It seems to be unused
after this patch.

> +       clocks =3D <&pcieclk 1>;

Isn't clocks =3D <&pcieclk>; (without the extra 1) enough?
