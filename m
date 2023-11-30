Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A8B7FF945
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbjK3SZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjK3SZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:25:12 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D26E10DE;
        Thu, 30 Nov 2023 10:25:18 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cfa3a1fb58so13456837b3.2;
        Thu, 30 Nov 2023 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701368717; x=1701973517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6XaBmabZtFG50aNMROWpohKVYoF4xocW5H2FTxC+9Y=;
        b=FIB82FiF1IREPr40mhLtGjOAH5+tZ+N4fN9adfxHhRNtzuysyPh7yICx3CxV6OeT7T
         qloV/mYI8FqcVcioYXVBFeJhryRIRH20WL7RM4IJUUreeotDpdTinemIXP0263OOchPU
         +o1bj53NU1XRz7W6yR8CLnHOBMZ2J9akM8Cwm4WYb/2wUdfI9qxykn1QjAswXi+QxDhM
         zBtkODV9dSZ54f9DHY2jZH6LBtdeMS0cBH1If/bCxIxWpW628OcybI1l4OPoXEHQQsVT
         w2dXMtUMdKcGJJPCIkX/4/FL7uBmBYswlbMQEjvW4ysFGs7qAlpZ530cm9gBdW7/Web6
         4+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368717; x=1701973517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6XaBmabZtFG50aNMROWpohKVYoF4xocW5H2FTxC+9Y=;
        b=MqEV3EXPnPogqGfoNcKX6TK9NDLtukWIzA8+FlSgyI9QqNygVLwzKHpYhI1rzl4ZE1
         qgh/zT9cXwxhGGrf75soNDcmIAt/dY3YRVR2KT/i4dlFIYukWeCdihHWbBhnHoodBGpB
         DGP+Ez0i80wd45XQzTUpBfVxEwCqD3+9ZfnihkdTCYjXOhVz15WQnSqlfoVMcHNxqrfD
         VaB1KuBxeT7AxqZnXn7pWSQ3XWo1kUla4Xlhm2PaLTx5iosafmAlGGBoC5Nv3ZHvyRAx
         bAmcVOaSdIdPplyymNDhFCfZhwoLLGKzyHMP3aNWPCVeK76bEfwovQpdoPz/iYzStf1q
         Layw==
X-Gm-Message-State: AOJu0Yy9Xnk+8LFlCDwvdcaPIM2nLyt54l1xlSMcR4L0v9yYWgBI5T7K
        2I0NlXezc/I6dXWOgKfuiBaBRertt7TbBuyTrI0=
X-Google-Smtp-Source: AGHT+IECxm8oMNxT8KIHQVCeAUTR2MGh4E9JHpb63/3Y4Q2Le8BmFXxYDbE4XWEDdDdN3V+Hw01yp8c1QDzp4GKgVyg=
X-Received: by 2002:a81:9a02:0:b0:5d3:b0c5:3001 with SMTP id
 r2-20020a819a02000000b005d3b0c53001mr1430153ywg.23.1701368717599; Thu, 30 Nov
 2023 10:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20231121151733.2015384-1-tmaimon77@gmail.com> <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch> <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch> <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
 <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>
 <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch> <CAP6Zq1jVO5y3ySeGNE5-=XWV6Djay5MhGxXCZb9y91q=EA71Vg@mail.gmail.com>
 <25d0c091-3dce-4d62-a112-c82106809c65@lunn.ch>
In-Reply-To: <25d0c091-3dce-4d62-a112-c82106809c65@lunn.ch>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 30 Nov 2023 20:25:06 +0200
Message-ID: <CAP6Zq1gS_cX9t3bkvvEUAHh=GpBCW6N0vB7zfvhHMVkuxrCh7A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.torgue@foss.st.com, tali.perry1@gmail.com,
        edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, joabreu@synopsys.com, joel@jms.id.au,
        devicetree@vger.kernel.org, j.neuschaefer@gmx.net,
        robh+dt@kernel.org, peppe.cavallaro@st.com,
        linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for your input.

On Thu, 30 Nov 2023 at 19:26, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I will check with the xpcs maintainer how can we add indirect access
> > to the xpcs module.
>
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c#L449
>
> It creates a regmap for the memory range. On top of that it creates an
> MDIO bus. You can then access the PCS in the normal way.
>
>         Andrew

Best Regards,

Tomer
