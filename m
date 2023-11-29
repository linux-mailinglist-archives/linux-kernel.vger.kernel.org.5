Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C47FD46C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjK2KiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjK2Kh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:37:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB94C1BE8;
        Wed, 29 Nov 2023 02:38:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b34563987so4416105e9.1;
        Wed, 29 Nov 2023 02:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701254280; x=1701859080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YVL5H5p6npDvqHk3KuIbfLoOW3Jt9rDFhXjL2FY1/7A=;
        b=aC/TSEwYg2ct+BswmB+zs6laCh3+AXJQaAaLOjfV9uLb0AfxUfjW/a++6FaRDcJguh
         c4hjXMbYGywmEkHwWMfoE8fdAhnLWT5B8taaqx3CLE1fnznXEUVGM/OgGsOT0ZFqxQVW
         j7iccUW11F4x7XscRR/eLDoj5xjrNghytZ8tXFA5c9BbPIFawKrZyDXyviIxSCClPnPO
         v94gqrSn8ZLNNm0UI05WmuliYLSJcEZzzJU/oGt5IgRbFoBy8UjNC4wB/B9wjUrQtyYN
         y/FddduyWAWonMVwPqdKC1YJOJKMuZgraduvrKVYZm5mBGFBVCPVFEZ01Uhfx5cowcul
         SRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701254280; x=1701859080;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVL5H5p6npDvqHk3KuIbfLoOW3Jt9rDFhXjL2FY1/7A=;
        b=to6MUvXz28dbD6oYEP7qIdD4rDe2kaJV15EXPW9a+VaP177UO4otfhzlgTrm0pIq0T
         v9OBHcXnwXs5CujIBz2Xk+WEY28qSGEb+B/5Q+diWnwYdzZO0m1+GXnz//TAUdU2GmR4
         gps51hSlm8qdkLGdBSDcdyQvGn9OXzYW2MZgL5Kn3cdlGp8vhWJ4/uPz318YnLkBv4Wb
         40hAxBRO3FazwhlVsHCbae4xVft7BMT+pqImnEbyI7mAJs48K6Zp1uqE7+GRjWLe7O6A
         7OaXHTWDYbXaBdSFSt08bjEt4yYkQ3+STF9dZk9dQzldIat2l7ijGuDvGZWt+ntPuhA5
         nPUA==
X-Gm-Message-State: AOJu0YxwrccsGRTvnh34jGRAHL1Cap3glZdun4w+l3j4HXlnfOsVQvK7
        DDigWcAePhULzRvpoUyMZGo=
X-Google-Smtp-Source: AGHT+IGodQG0XJPz39Mx5TxzQu6q/QOj+i059+FByFuRGFamgl53a/rgDV/3RkLMIJYMXDWblGiZYA==
X-Received: by 2002:a05:600c:138d:b0:40b:2afd:1a9 with SMTP id u13-20020a05600c138d00b0040b2afd01a9mr18428597wmf.15.1701254280093;
        Wed, 29 Nov 2023 02:38:00 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040b43da0bbasm1711731wmq.30.2023.11.29.02.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:37:59 -0800 (PST)
Message-ID: <65671487.050a0220.dae78.45f0@mx.google.com>
X-Google-Original-Message-ID: <ZWcUhLK8BdDYhRwc@Ansuel-xps.>
Date:   Wed, 29 Nov 2023 11:37:56 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 13/14] net: phy: qcom: deatch qca83xx PHY driver
 from at803x
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-14-ansuelsmth@gmail.com>
 <ZWcJ/OgC1+cbFvhk@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcJ/OgC1+cbFvhk@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:53:00AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 29, 2023 at 03:12:18AM +0100, Christian Marangi wrote:
> > diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
> > index 6a68da8aaa7b..43e4d14df8ea 100644
> > --- a/drivers/net/phy/qcom/Makefile
> > +++ b/drivers/net/phy/qcom/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-$(CONFIG_AT803X_PHY)	+= at803x.o
> > +obj-$(CONFIG_AT803X_PHY)	+= at803x.o common.o
> > +obj-$(CONFIG_QCA83XX_PHY)	+= qca83xx.o common.o
> 
> These PHY drivers can be built as modules. You will end up with several
> modules - at803x.ko, qca83xx.ko and common.ko. You don't mark any
> functions in common.c as exported, no module license, no author, no
> description. common.ko is way too generic a name as well.
> 
> Please think about this more and test building these drivers as a
> module.
>

Had some fear about this...

What would be the preferred way for this?

Having a .ko that EXPORT symbol or making the PHY driver .ko to compile
the common.o in it?

Honestly I would like the second option since I would prefer not to
create a .ko with shared function and EXPORT lots of symbols. On SoC it's
expected to have only one of the PHY (at max 2 when the qca807x PHY will
be implemented, with the at808x also present) so the size increase is
minimal.

(just to be more clear, talking about this makefile implementation)

at803x-objs			+= common.o
obj-$(CONFIG_AT803X_PHY)	+= at803x.o
qca83xx-objs			+= common.o
obj-$(CONFIG_QCA83XX_PHY)	+= qca83xx.o
qca808x-objs			+= common.o
obj-$(CONFIG_QCA808X_PHY)	+= qca808x.o

For name of common.c, is qcom_ethphy_common.c a better name?

-- 
	Ansuel
