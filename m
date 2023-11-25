Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077CD7F8CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjKYSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjKYSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:07:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC05C0;
        Sat, 25 Nov 2023 10:07:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32df66c691dso1878181f8f.3;
        Sat, 25 Nov 2023 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700935639; x=1701540439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=puQH2pOXfnIbSZCHOkkIa6H+MNcLIGSdWyuSjRQdnv4=;
        b=cMLL0BjgjCDAMYizwgGmCqFZSUnjof/pRcd9Lu7K+1NtTLXMO9+96AIv+bH4BAkBvt
         eHrdra9YDwJVSIPWktFCYETb4YSw5h3DdykSkKuEu71o+Jf84KaaYELfBzvZwmshSBuy
         6IRfc3VleRIZafNUD6PnpetUQ/hplp2uNdmBM0nGYX6zByecBH2uVm99199DWKJh+COU
         SAH81JE6WzYNGRvFGAYlMf/OqvDw0hkrCI4QKSDcuaBaxPjCy0U6uWnGBURbx3RsFLgJ
         PriHEAIbzZLFNtx2m6YMIIebj/ofu6rD5dJFFY5ZDSyTvV7ILDELllUl9573gBPTb5Sw
         +kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700935639; x=1701540439;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puQH2pOXfnIbSZCHOkkIa6H+MNcLIGSdWyuSjRQdnv4=;
        b=fDywfTLymz6TVh98oi8/izD09VUP+t9RFFKLbeMh1gGMc7h4wvq2cSo/ZT4NguOM8H
         2KS15rEGyUytMo01eHI0FJR1ubaghETFZeLGJDNyWnWO35KckOGF5b2qcFgA/gdR2GsT
         L8aiF5nLzdX00y80MuUZH9SXdn14JrelXnwDKytrCT2KPRDhWiNFBIBLXQV39ZGheXpc
         yS6b2qGEN8A/k97uhQ7l7sMXh7oouJmtt/XD9kG1ZYCb2X0Xkf2O92e/oBvq7vEBckAN
         Ot1CiwGxBMVpiJkZWG6sUuGL2E1A/zqEKth007NeU4JpWD8TEUQoE4jPkMjrUxUnbJhj
         7cmQ==
X-Gm-Message-State: AOJu0Ywttj9LZtcBg2Tz+sTu3nSeQJX5WhUY3p2+MqNKnjk9aC8ogPIr
        j0HSrDRj/1fMdMJEB8N8Zjo=
X-Google-Smtp-Source: AGHT+IE8oqH78KDfOnat9E+eH4edH5VvXMcZEZWP7aUt5DnBsHQUFMDzllU13QYu7RufzNpza3wkvQ==
X-Received: by 2002:adf:eacd:0:b0:332:d607:a0dd with SMTP id o13-20020adfeacd000000b00332d607a0ddmr5953879wrn.47.1700935639149;
        Sat, 25 Nov 2023 10:07:19 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5304000000b00332eb16d215sm4100561wrv.23.2023.11.25.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 10:07:18 -0800 (PST)
Message-ID: <656237d6.5d0a0220.2c3da.d832@mx.google.com>
X-Google-Original-Message-ID: <ZWIDtR9oOu2BoLGt@Ansuel-xps.>
Date:   Sat, 25 Nov 2023 15:24:53 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH v2 01/11] net: phy: extend PHY package API
 to support multiple global address
References: <20231125001127.5674-1-ansuelsmth@gmail.com>
 <20231125001127.5674-2-ansuelsmth@gmail.com>
 <a8ce4503-c24d-4d6e-91ec-d03624b31fe0@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ce4503-c24d-4d6e-91ec-d03624b31fe0@lunn.ch>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 06:51:54PM +0100, Andrew Lunn wrote:
> On Sat, Nov 25, 2023 at 01:11:17AM +0100, Christian Marangi wrote:
> > Current API for PHY package are limited to single address to configure
> > global settings for the PHY package.
> > 
> > It was found that some PHY package (for example the qca807x, a PHY
> > package that is shipped with a bundle of 5 PHY) require multiple PHY
> > address to configure global settings. An example scenario is a PHY that
> > have a dedicated PHY for PSGMII/serdes calibrarion and have a specific
> > PHY in the package where the global PHY mode is set and affects every
> > other PHY in the package.
> > 
> > Change the API in the following way:
> > - Make phy_package_join() require a list of address to be passed and the
> >   number of address in the list
> > - On shared data init, each address is the list is checked and added to
> >   the shared struct.
> > - Make __/phy_package_write/read() require an additional arg that
> >   select what global PHY address to use in the provided list.
> 
> I think this is overly complex.
> 
> I would rename struct phy_package_shared addr to base_addr.
> phy_package_join() would then pass the base address of the package,
> which is the same as your reg property for the package in DT.
> 
> I think all current users of devm_phy_package_join() already do pass
> the lowest address in the package, so this should not cause any
> problems. Most drivers even call it base address, rather than cookie,
> which the documentation uses.
> 
> I would then extend __phy_package_read() etc to take an offset, which
> is added to base_addr, and the read is performed on that address. All
> the existing users would pass 0, and your new driver can pass other
> values.
> 
> I also think you can split this out from the DT binding. Make it two
> patch sets. One patch set is about extended the package concept to
> allow access to global registers at addresses other than the base. The
> DT patch is about properties which are shared by the package. These
> seems like two mostly orthogonal concepts.
>

Yes can be detached. Making addr to base_addr would change the thing but
can confirm, any user of the API always used the base addr as cookie, so
it won't change a thing.

Will have to make the separate commit a dependency to this series but i
expect this change to be merged before this RFC is completed. Good idea.

-- 
	Ansuel
