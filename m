Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEFB7EB115
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjKNNoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjKNNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:44:32 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD3E132;
        Tue, 14 Nov 2023 05:44:29 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b3f55e1bbbso3651905b6e.2;
        Tue, 14 Nov 2023 05:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969469; x=1700574269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVoXranZuhbJagmViZ0Bh2J7LLpRAZVBS/w9Sa8ohYo=;
        b=oo3i4EJBDK9xmtwN/AlOKqnnWDKzSPtkTocPTsjX04qmfBhVx6FV9NG6wFtNmsby6F
         VFj/shDxp4BoARd+HtkFMQRiAEt606G3HRrGUa+aV6/Yp2dLAAu1ARG6RY8W9QHEkN/5
         CzFpM8uK0cqYORRxxI+hHEQlIOSeH+lPEgdb91t+CQ7NKhYrciFweE/1hzErio0YLizB
         OuuyGndR6mB88SkNWePgJ/rtAaEC40Ee0c67dOQjU1ZrnVF4C7wAKXHJiVfTfi6VG8/2
         SQUx+2Ok/ULD3N8zuR0/6z5M/2qT4IPt1i2BjGfBkb+sp6GnJ6vqnNhuiVASHkpUw911
         XC0w==
X-Gm-Message-State: AOJu0Yzg5AII6t289z+IAcSEGKXIHjpAERh3xqCUT+psDv+KdQdprLCC
        ftiI4pmH5cBSYQ5XHaT+0g==
X-Google-Smtp-Source: AGHT+IEa2yiGK/vrgIGrYDQftkP/r/QgCl5oWffc3V6kN1weHVqSkoufro4lODlc4XqFTDIWhqoefQ==
X-Received: by 2002:aca:f07:0:b0:3b6:cc01:aba2 with SMTP id 7-20020aca0f07000000b003b6cc01aba2mr10713866oip.55.1699969469146;
        Tue, 14 Nov 2023 05:44:29 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k13-20020a54440d000000b003ac9e775706sm1115062oiw.1.2023.11.14.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:44:28 -0800 (PST)
Received: (nullmailer pid 1651909 invoked by uid 1000);
        Tue, 14 Nov 2023 13:44:27 -0000
Date:   Tue, 14 Nov 2023 07:44:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 1/8] dt-bindings: phy: mediatek,xfi-pextp: add new
 bindings
Message-ID: <20231114134427.GB1645963-robh@kernel.org>
References: <cover.1699565880.git.daniel@makrotopia.org>
 <924c2c6316e6d51a17423eded3a2c5c5bbf349d2.1699565880.git.daniel@makrotopia.org>
 <797ea94b-9c26-43a2-85d7-633990ed8c57@lunn.ch>
 <ZU1nBgdspMtsI5aS@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU1nBgdspMtsI5aS@makrotopia.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 11:11:02PM +0000, Daniel Golle wrote:
> Hi Andrew,
> 
> On Thu, Nov 09, 2023 at 10:55:55PM +0100, Andrew Lunn wrote:
> > > +  mediatek,usxgmii-performance-errata:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      USXGMII0 on MT7988 suffers from a performance problem in 10GBase-R
> > > +      mode which needs a work-around in the driver. The work-around is
> > > +      enabled using this flag.
> > 
> > Is there more details about this? I'm just wondering if this should be
> > based on the compatible, rather than a bool property.
> 
> The vendor sources where this is coming from are here:
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/a500d94cd47e279015ce22947e1ce396a7516598%5E%21/#F0
> 
> And I'm afraid this is as much detail as it gets. And yes, we could
> also base this on the compatible and just have two different ones for
> the two PEXTP instances found in MT7988.
> Let me know your conclusion in that regard.

I'd go with a property in this case unless you think there may be other 
per instance differences.

Rob
