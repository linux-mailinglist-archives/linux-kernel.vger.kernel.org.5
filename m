Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289967F6725
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjKWTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKWTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:33:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29558D47;
        Thu, 23 Nov 2023 11:33:28 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c876f1e44dso14938081fa.0;
        Thu, 23 Nov 2023 11:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700768006; x=1701372806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/hq7LNXGTuldiV4ecttMMHQLmxEW4ioDA8UB5OvVq6I=;
        b=FAGRUWPCXyj6exxd8QaqT3B9IdqRb54vWGM/tMjKTawkrYUcK7C0tSoTGfbsMjVpRo
         4dVDLMpwFBZQpjuPUShK62PMEP1VHEEGr0mVWO0x0NvQKTvBd+D2BZoDhY3Thq5DfNdr
         TCBAqMqQAi740vulbw7u15kw/5GH6MlN0H9sDjnlBw+I5xWMo0niJEIJCB7gGRnNX/he
         1t9ZpzDLeNUpsXYByRdwOlwD7+7nMCdaljBAwRQ4spqfyEhoSzDP/Ews2UUrqbgC4XYP
         J/ZRBOKqtdB1R3foyTwpnfz4yiUhTpmw9xQGVuOHeBPkgUe5OPQNoIGYiL9x6NvZe3U+
         kExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768006; x=1701372806;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hq7LNXGTuldiV4ecttMMHQLmxEW4ioDA8UB5OvVq6I=;
        b=ORI4NU2QgMN1qQegL3AtgOX+2BKRogKqJKavZb+ECssQfxpBTmzfHcxfYnv/KS17xy
         SL4/hUySM/TJ2pczrDTXyKuZ2DNp926o1rbqEt+/D4Vbq7YMgGT5xpyhIW4DPF8iYWMb
         RoiSDNRntk3DesphtOQE+TtCHGorHLguIV2Bj+h95IZ08MZGcesbpY57d7+3vCGPVKf8
         DsmsLaWeFeNJVC9G/ZXVhdlQdXiO+qpMvJutviJsf00Rb4DMLX88Yixwnrcku4TyMA5V
         1MRxejgHWqOiTrBVLOl5Cv0Q9L36cbSpwHUHsTIChLHAjoJRiO7A+zdJjaulpXUt4/my
         UJaA==
X-Gm-Message-State: AOJu0YwHs1yDMG98avfdHWwMinNzTFy3HnTxdbPEmlUBkSw2Nl3U2UcR
        o92CbHoTQcStMVegHaKltKg=
X-Google-Smtp-Source: AGHT+IEpZV8AAS3AX/kSyCq/TvjTy4lvHHyqL6QV8NqZ0ODQESSmWB93J1AVOkRbP2EeuZ27xtYNUg==
X-Received: by 2002:a2e:3a0f:0:b0:2c8:7962:cdc2 with SMTP id h15-20020a2e3a0f000000b002c87962cdc2mr223068lja.3.1700768005622;
        Thu, 23 Nov 2023 11:33:25 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b0033130644c87sm2442265wrp.54.2023.11.23.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 11:33:25 -0800 (PST)
Message-ID: <655fa905.df0a0220.49d9b.7afd@mx.google.com>
X-Google-Original-Message-ID: <ZV+pAo5jt0N9/AE2@Ansuel-xps.>
Date:   Thu, 23 Nov 2023 20:33:22 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Jie Luo <quic_luoj@quicinc.com>, Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet
 PHY package nodes
References: <20231120135041.15259-4-ansuelsmth@gmail.com>
 <c21ff90d-6e05-4afc-b39c-2c71d8976826@lunn.ch>
 <20231121144244.GA1682395-robh@kernel.org>
 <a85d6d0a-1fc9-4c8e-9f91-5054ca902cd1@lunn.ch>
 <655e4939.5d0a0220.d9a9e.0491@mx.google.com>
 <6a030399-b8ed-4e2c-899f-d82eb437aafa@lunn.ch>
 <655f2ba9.5d0a0220.294f3.38d8@mx.google.com>
 <c697488a-d34c-4c98-b4c7-64aef2fe583f@lunn.ch>
 <ZV9jM7ve3Kl6ZxSl@shell.armlinux.org.uk>
 <e32d5c84-7a88-4d9f-868f-98514deae6e9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e32d5c84-7a88-4d9f-868f-98514deae6e9@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 03:57:58PM +0100, Andrew Lunn wrote:
> On Thu, Nov 23, 2023 at 02:35:31PM +0000, Russell King (Oracle) wrote:
> > On Thu, Nov 23, 2023 at 03:27:05PM +0100, Andrew Lunn wrote:
> > > > Just to be more precise qca807x can operate in 3 different mode:
> > > > (this is controlled by the MODE_CFG bits)
> > > 
> > > > - QSGMII: 5 copper port
> > > 
> > > 4 slots over QSGMII, plus the second SERDES is connected to the MAC
> > > using SGMII/1000BaseX?
> > > 
> > > > - PSGMII: 5 copper port
> > > 
> > > 5 slots over QSGMII, the second SERDES is idle?
> > > 
> > > > - PSGMII: 4 copper port + 1 combo (that can be both fiber or copper)
> > > 
> > > 5 slots over QSGMII, with the second SERDES connected to an SFP cage.
> > > 
> > > Are ports 1-4 always connected to the P/Q SGMII. Its only port 5 which
> > > can use the second SERDES?
> > 
> > I think what would really help here is if there was an ascii table to
> > describe the configurations, rather than trying to put it into words.
> 
> Yes.
> 
> And also for ipq4019. We need to merge these two threads of
> conversation, since in the end they are probably the same driver, same
> device tree etc.
>

For everyone that missed Robert response in patch 12 let me quote him
also here.

"
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
support so that you could still use SoC-s with QSGMII and SGMII support only.

So there is no way to control the SerDes-es individually, only the
global mode can be changed via
the Chip configuration register in the Combo port.

You can see the block diagram of this PHY in this public PDF on page 2[1].

[1] https://content.codico.com/fileadmin/media/download/datasheets/qualcomm/qualcomm_qca8075.pdf
"

-- 
	Ansuel
