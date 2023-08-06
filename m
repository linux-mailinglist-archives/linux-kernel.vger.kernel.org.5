Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B014771732
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHFWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 18:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjHFWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 18:20:32 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAB172E;
        Sun,  6 Aug 2023 15:20:29 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bb571ea965so2961667fac.0;
        Sun, 06 Aug 2023 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691360429; x=1691965229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdsLLDBCPeY3+PtcYBCsgDrwwOh5/Qz7nu7TUdmKKzg=;
        b=Khb16D4HFrSYfMy0eM5fA+Wx5cy31zq6ReWMrPjAcg+rS9R29FL6x55lcrpjqRyHKM
         Q5cN/RIRZ53JHW4Xioq2qbzRKjsOG+b58H9lLxGfYR1aTa06AhgQnDpqy8yIO9GbWXAK
         1uOsdGFMgdYexKaUAsFzBMB5kqoph8W5Ml6vf3YFbmFiUVE9XSCkwWgFDbHWuhoZnjWC
         LqlxKjTr+8qjxtlxc7vpEAxvnh/5seBrSZtG7sfZE2o2eDLrMpEJIwdEtTN4JUx12o9P
         /AudSZDvrGvTQPFkffgaJ+J5NKopZz5/rOyMDoYTkbs2okdh7+IBlqMbHrC7nXlaa1zX
         hNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691360429; x=1691965229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdsLLDBCPeY3+PtcYBCsgDrwwOh5/Qz7nu7TUdmKKzg=;
        b=JRuILqrpi81zJHjXqCVISfVhKFDkBeta49lFPcchk/RqUk22VmuUP1mZK9QzXzANjF
         ghoq0JhWl8cZb+KHqPSzeeCHAV28YRWR0/DlsT7wdrgT/622sAkFOMATOyYUxgzcWIO+
         0jis6tzjoV0KlwP38gzuV77/GyQeau64oVDiiFPkERQcR+wMJcelh7IUvIVBz9j79VUi
         uJDfz9M4q4OAWfDIfgvhJOKTJ0YDW6TH2j7hi5bfTju3I5ksSAym3miZ+aPdJ1O3VO3n
         cvkjnZmFHGQUt/9y0Ob9Sia4cMg8JOBR98BqQpt/U/DRkVUJUFJQK0uFeWFw2p0jdQa6
         Zs/g==
X-Gm-Message-State: AOJu0YxwWi13fQ90lsc2OIxbPVfFqMKpoXzJuMfrom5vQRZmHbPBQwfk
        52hYTqKAWzB7eDlsUtyf1exuMJG5oDc2vKj/AEHfq0PL
X-Google-Smtp-Source: AGHT+IFlDknmI01rekH5L7l4QMXyOMWwDEot/PJdhR3xL23EgN2q6pev2XSu7r06hKWJn2Mm+GVmqK/Ye9a/IJzMF9w=
X-Received: by 2002:a05:6870:330a:b0:1bf:13c1:b34c with SMTP id
 x10-20020a056870330a00b001bf13c1b34cmr8346409oae.15.1691360428750; Sun, 06
 Aug 2023 15:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230806190622.505887-1-aford173@gmail.com> <CAOMZO5DfZufEDfjGDj2toMN-AT84O8u5qh5z_MVC4-6iyjy0CA@mail.gmail.com>
In-Reply-To: <CAOMZO5DfZufEDfjGDj2toMN-AT84O8u5qh5z_MVC4-6iyjy0CA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 6 Aug 2023 17:20:17 -0500
Message-ID: <CAHCN7xLcZvcB0fmoxK2EuLxmPQGCtCKcfPDozhDwYSX4fJutrw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref Clk
To:     Fabio Estevam <festevam@gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 5:03=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Adam,
>
> On Sun, Aug 6, 2023 at 4:06=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> >  &pcie_phy {
> > +       fsl,clkreq-unsupported;
> >         fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > -       clocks =3D <&pcie0_refclk>;
>
> Should the pcie0_refclk node be also removed? It seems to be unused
> after this patch.

Oops, you're right.  I will send a V2.

>
> > +       clocks =3D <&pcieclk 1>;
>
> Isn't clocks =3D <&pcieclk>; (without the extra 1) enough?

The clock generator has two outputs called DIF0 and DIF1.  This
hardware uses DIF1 for the reference clock, so I need to specify
output 1.

adam
