Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70C7F5D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345023AbjKWLUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345014AbjKWLUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:20:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BD1BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:20:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28396255b81so621657a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1700738436; x=1701343236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cna4B9OkGYaAGZnmz7auaJoanPikLRaFUkJT1PNzdCg=;
        b=UiMaSLy2jUmtlcZLLy/PgYN/k+XpFsV1tkwSFncyGjYr8bCBPwMuMtZ1/9c/mBZxK9
         5EorwiG6ru/NpzWSM6KPvolIBPf1MCOE0OqdHY2HC9YGGMWBwTF8dbD7XrhOJM73cVAU
         YTDhAvLTMwfTDVtaulg96oZHQ8YKydtr9E9fb5a848+8UWav7eaa0cXg8hJBjQHF31PH
         rkYvuFmUK1OKjPNPa/2PmFMUMuf37pgkhu90Mfx5QcizTpmhFZGo1d1taWhZEVFotDPb
         7v3vV1WFiAeSCmYuLtQBLXrdohRp3FFeC88ac72NyowDpJI+ZFy2govyfjQ2OHARq5pf
         fAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700738436; x=1701343236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cna4B9OkGYaAGZnmz7auaJoanPikLRaFUkJT1PNzdCg=;
        b=XLoKsigHHaM8KEIGn/eicBND9Ft2jfeCSi+QufvcQYRNtR52sfByTw9h5VfJwVCNfo
         l1lsjnSnBJjtlPccE34/kcLykPS3KTQvty61iE/u6bB8BtHOJZz+QseyXMGt7q7Vel9H
         9o1aR/0RN1IV9TzmE8g0rVYyYADaSt3ZxezSNC74J0piHSbQ+HSOyE27zi9tFk6AhGl5
         vzO3mTyLVmkiTPpi7JCgUijQZUGhYZ4tPwdOdSHgPA/4escK5qzNdfVu6yd50JM09AhC
         yN8jH0fjaRzm7/McPo9mHyiauVdHPIkbokmk805X3v2KcjNRNt9DtDseTHnujSKwfDl2
         L5Lg==
X-Gm-Message-State: AOJu0YwZ40JBX+tc49t5bppiQRlnTnPZL26oqdal8QdiKg/BGtmYc3gD
        yHFwJOBM1JqDcuawIWLd5YkEYWMJ4SstZcA72fxJGw==
X-Google-Smtp-Source: AGHT+IHpAi31AQJzfI++IcN15h2i2fjElwAR2+A2cq4nCMgOSMsdXf8at6TXQhpec1XOEn9ZPz1TGslnfGloZZAtd7g=
X-Received: by 2002:a17:90b:3014:b0:27d:dc9:c67d with SMTP id
 hg20-20020a17090b301400b0027d0dc9c67dmr4905828pjb.36.1700738436187; Thu, 23
 Nov 2023 03:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20231120135041.15259-1-ansuelsmth@gmail.com> <20231120135041.15259-13-ansuelsmth@gmail.com>
 <6593e6ae-3ae7-49e2-a6e9-c37f5a887fe3@lunn.ch>
In-Reply-To: <6593e6ae-3ae7-49e2-a6e9-c37f5a887fe3@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 23 Nov 2023 12:20:24 +0100
Message-ID: <CA+HBbNFjmwtfJAON_BX9c9hqcBTsReMPm9ajPjFF_2z+LbARnw@mail.gmail.com>
Subject: Re: [net-next RFC PATCH 12/14] dt-bindings: net: Document Qcom
 QCA807x PHY package
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 3:15=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +  They feature 2 SerDes, one for PSGMII or QSGMII connection with
> > +  MAC, while second one is SGMII for connection to MAC or fiber.
>
> Can you connect 1/5 of the PSGMII SERDES to the SGMII SERDES? So
> making use of the PHY as a media converter to connect to an SFP cage?
> I assume the SGMII serdes can also do 1000BaseX?
>
> How do you describe what the SGMII SERDES is connected to?

Hi Andrew,
I think that the description is confusing.
QCA807x supports 3 different modes:
1. PSGMII (5 copper ports)
2. PSGMII (4 copper ports + 1 combo port)
3. QSGMII+SGMII

So, in case option 2 is selected then the combo port can also be used for
1000Base-X and 100Base-FX modules or copper and it will autodetect the
exact media.
This is supported via the SFP op-s and I have been using it without issues
for a while.

I have not tested option 3 in combination with SFP to the copper
module so I cant
say whether that works.
From what I can gather from the typical usage examples in the
datasheet, this QSMII+SGMII
mode is basically intended as a backward compatibility thing as only
QCA SoC-s have PSGMII
support so that you could still use SoC-s with QSGMII and SGMII support onl=
y.

So there is no way to control the SerDes-es individually, only the
global mode can be changed via
the Chip configuration register in the Combo port.

You can see the block diagram of this PHY in this public PDF on page 2[1].

[1] https://content.codico.com/fileadmin/media/download/datasheets/qualcomm=
/qualcomm_qca8075.pdf

>
>   Andrew
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
