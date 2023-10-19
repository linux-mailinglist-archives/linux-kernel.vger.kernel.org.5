Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87837CFCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjJSOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbjJSOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:33:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CA10D1;
        Thu, 19 Oct 2023 07:33:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9becde9ea7bso189019866b.0;
        Thu, 19 Oct 2023 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726003; x=1698330803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrv248iIGnORc/aLVwJ/mT01KzctNwPjkrZfMrdn3lQ=;
        b=SyC0VWj7owqEHcus2/SSdzIpy5fzRvS9em7WA7cGBOac3pkAXvG+DfgQZfSdGijn80
         xp9NibyZZYNP8opBYgKhu1xxt7fz0IOuVeWcmqxPADREZk1YeYyo4LyycLpxDbYIEBIl
         6CDf2mMK/EgqiGNXjjMzHV3OyNODVis7Mqc8Xq7qiGECQMRqtoilYiM9GhKN3ad0W/3I
         pNAisz4645b/0PshELpxHbpCPjl5yN2b0Sw0FuWOceZXm+0CnzAbwAjV0y3lb/AEIFyF
         5hNlq1CkTu+J2WLU6r6PEYBkyH8XXJOQfbDc4kIcxjHcOsuazrQlRXDFQdzp7JHGUEdF
         UWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726003; x=1698330803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrv248iIGnORc/aLVwJ/mT01KzctNwPjkrZfMrdn3lQ=;
        b=O2TY/wepY40WTAwjHWBdtR7mel4D6cUUcU/1HgPLZx8MOUD54hnwfr22qQ4nkHB/rV
         FiWYnoPU6NxIx2myMM0siqyP90ykpOnPypqrWnRaSc9GiCB+LayBrRAZYTclx4LDuuMM
         W4OHfJi4jwYye24WWL1X1py2PAClLhozMlfgMk3JWBHgY4yF7nGr43HjMxXmkffGYcqa
         x0B0pcuzMZbkC7McO19k8SCDZb2mSUP98YKkboTa+/33vkoGS2K2GP6Yb1xIYSbqInPi
         eYoKzQ+mGxQXq5MzdHOHSvtvoBcGfRtpsYXvOmavNW7SS8fhJhQTX3WhFBBY34UKm21j
         hsYQ==
X-Gm-Message-State: AOJu0YyoDy9H2cMFh3jTgUw88tqSj633m6M0PfUC1t3aJxsxQydWG+4T
        zuU46A0Rj+DIG4q/UD2fsyw=
X-Google-Smtp-Source: AGHT+IE/slEx+SucegtsJq83SYRyf5FrLEDbKdu4yUyk4rn0z04QTKnb6N7nr6Scwlr3CDrVG+MVcA==
X-Received: by 2002:a17:907:7f16:b0:9ad:f60c:7287 with SMTP id qf22-20020a1709077f1600b009adf60c7287mr1733856ejc.28.1697726003181;
        Thu, 19 Oct 2023 07:33:23 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id u27-20020a170906109b00b0099bcd1fa5b0sm3603511eju.192.2023.10.19.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:33:22 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:33:20 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/7] ARM: dts: nxp: Fix some common switch
 mistakes
Message-ID: <20231019143320.hobwb3qegrs46gqj@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-4-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-4-3ee0c67383be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-4-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-4-3ee0c67383be@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:03:43AM +0200, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - switch0@0 is not OK, should be switch@0
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Same comment as on patch 3, prefer ethernet-switch and ethernet-ports.
