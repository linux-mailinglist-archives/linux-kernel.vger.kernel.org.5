Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92019805403
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345070AbjLEMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbjLEMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:23:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF9D7;
        Tue,  5 Dec 2023 04:23:20 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so28042166b.0;
        Tue, 05 Dec 2023 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701778999; x=1702383799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMhBj0PFcNsp7ddu4+x1EUxsSq8BTDuggzzUZ8nA8Vo=;
        b=hWHuxdWf3f/v7yccbhzi0QVFphGHaxMpa3tU2F5P7baGvWpHw9GDrJMx20UpO8gK1o
         a64u9sk8CEhVuGANDFfc8ufTQBjacGaVS0K+SlhoOXhhiSHxvtrYu8sWSls4NnGAeyxq
         TTK+BnhvCMXNH4NfxzA9AYrj4vfH+9A5RbEt4o7aYbT1QUDImz+txYomn8xcasuHJcNz
         1aR0LN7ug2Cy0uJkEvtmIB2kzkok2AwJ2Fzn636wiiHiiv1Kmq2yfn/35L9t36Zpq0j+
         z5VFmvUgc1W/yZ1fAoQ6ALOPaMtpIG8MbPJVgb99zyA/ED30DVET/JkREJ+5kI1VhO/k
         U4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701778999; x=1702383799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMhBj0PFcNsp7ddu4+x1EUxsSq8BTDuggzzUZ8nA8Vo=;
        b=bbI98sX8lnP+mvwNMihOoF3w9LfheH/30a+IJBKIyI2dh00bKHtel3iUS41szaH9Rv
         66uMPAJ24lFY0znWNXXUBJ1WYxbVUb0qmLxDDyv23w+TyhT0dORgBvpg+pIQZlZLNEM7
         vFBKcQlg8tGa+KQtN+okfA4gA6LRxDeljRbnjagq/TW2GUfaedrn683tcPcUWpTOSuOl
         k5OLRxLLoIR8sSkKFd6JSMF064+xJ6NC/09wYhvsAtZdkeho3mJw4IMr+l/w2+Lga1+n
         zsce8FQ8oztxImL0RYfszA6oHWaLDTnbYan4lczWbNVHQc5DDUx1P9xVAK+6M9R7K4du
         fYvA==
X-Gm-Message-State: AOJu0YwSVr/exAl47ph9hrSOkU6v3nknymBjG22IqsHz88hWuZjZP3LO
        B8cRB3WOPNTLpwRnxhLaQ/A=
X-Google-Smtp-Source: AGHT+IHXa16mYQRzXdXsaQ0F8tsGp0lBaqOkdzuQ8VVSVqrPVczhzIUkL1oJDasQLcddWAUvhLTuAA==
X-Received: by 2002:a17:906:3f5c:b0:a19:a1ba:da6a with SMTP id f28-20020a1709063f5c00b00a19a1bada6amr3859595ejj.145.1701778998985;
        Tue, 05 Dec 2023 04:23:18 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906128b00b009ff8f199f21sm6726467ejb.19.2023.12.05.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:23:18 -0800 (PST)
Date:   Tue, 5 Dec 2023 14:23:16 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/16] net: pcs: xpcs: Add generic DW XPCS
 MDIO-device support
Message-ID: <20231205122316.ihhpklv222f5giz3@skbuf>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-11-fancer.lancer@gmail.com>
 <20231205111351.xjjuwpbf7kwg3vuh@skbuf>
 <uivunnjv5vi3w3fkc5w2f4lem5bingrgajgjfsu2ih7fuhz6hd@3naeubr5spak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uivunnjv5vi3w3fkc5w2f4lem5bingrgajgjfsu2ih7fuhz6hd@3naeubr5spak>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:35:46PM +0300, Serge Semin wrote:
> Omg, thank you very much for testing the series straight away and
> sorry for the immediate trouble it caused. I'll need some more time
> for investigation. I'll get back to this topic a bit later on this
> week.

Don't worry, I got suspicious when I was CCed to review only a one-line
change in patch 11/16. It's never about that one line, is it?)

Anyway, the NULL dev->p is a symptom of device_add() not having been
called, most likely from mdio_device_register().

I'll be honest and say that I still don't quite understand what you're
trying to achieve. You're trying to bind the hardcoded mdio_devices
created by xpcs_create() to a driver? That was attempted a while ago by
Sean Anderson with the Lynx PCS. Are you aware of the fact that even in
the good case in which binding the driver actually works, the user can
then come along and unbind it from the PCS device, and phylink isn't
prepared to handle that, so it will crash the kernel upon the next
phylink_pcs call?

The pcs-rzn1-miic.c driver puts a device_link to the MAC to at least
tear down the whole thing when the PCS is unbound, which is saner than
crashing the kernel. I don't see the equivalent protection mechanism here?

Can't the xpcs continue to live without a bound driver? Having a
compatible string in the OF description is perfectly fine though,
and should absolutely not preclude that.
