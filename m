Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0382805328
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442117AbjLELjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbjLELjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:39:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B985;
        Tue,  5 Dec 2023 03:39:26 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bdec453c8so4459750e87.3;
        Tue, 05 Dec 2023 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701776365; x=1702381165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6buYNz993iCGb+jfBAh+xTF839hKLJuyBWYlwBk8YQ=;
        b=JXdQ3aPCGvspU+SqH42lcZn2eQBtXdMIyhQeN2pO6+1F0unGhjiYYgqhKhvmOi7ZCV
         pTxvAX2k/mhUWsMj1nAUSTwY6Ys0N1rPiF3K1rMMvjInTwhml5Fz7mJH+hiUir/Lkl0D
         5rjzOr4zTItQoN0AIIvfb/EKOcVXu8LpMDKk6K6BpHrPHGUJYjtyiI8ImLmQ1cAsndg+
         eU50tr8tznujQeM5vlL7qvRaKjzSjW7yLA/yAHLtvbV3JFn9Alud2Hyo8WrImaadS7y/
         MoN/kRQqdglgHzAFgdQt3tJBvPX7pd2IPn7SVZepmlCLGPJQG4Mqg9pm4rga4DlPW4XF
         Ky3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701776365; x=1702381165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6buYNz993iCGb+jfBAh+xTF839hKLJuyBWYlwBk8YQ=;
        b=GHyA0+uqUhFhi1kBpI1Zc3otudqZekvSSO+LfTgYC3iY6d7ctZWnBfQKbaFxT6xOX/
         tgEkaFOc4LjTRvrLkKz3Zft/h9SBumBArZ87s8v0Pv8Q0SgERvyrh+cmJDrWtB3aeRrk
         U+i8AiIzxv8Ds1lORKydTYguXZLFAAlP536Co5gQoiB8KlkCXP43Uz0yQXGT5QD29qKK
         KvPgM4O/EJ7WY4cOPo11algxPD4wIx3U3P6MTIXt0aU/kFQrBmH16RfCEcPAl/QyRLUX
         Oa/zL4iq28vJ0r1Rlz0my3atCgraohTog+tP2tewgutxnkP2ntVclH7f4CR56v78Zws8
         PtlQ==
X-Gm-Message-State: AOJu0Yz9J1epxldZ0ZXj0E9eEUr0WBMj0HHTntKo+xyQMSrAK56EuYMd
        Glka0cywJ6LtDnSxeiiFzCg=
X-Google-Smtp-Source: AGHT+IHdLSTpHvIGV+soo8O6/Z+FCsJYVpGnEa7erjBtlciJpMf8bljF17p1tFZGlBWyR34QMQeAZQ==
X-Received: by 2002:a05:6512:3d8e:b0:50b:e637:b319 with SMTP id k14-20020a0565123d8e00b0050be637b319mr2982528lfv.14.1701776364975;
        Tue, 05 Dec 2023 03:39:24 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24bc5000000b0050c017fffe4sm210928lfq.122.2023.12.05.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:39:24 -0800 (PST)
Date:   Tue, 5 Dec 2023 14:39:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
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
Subject: Re: [PATCH net-next 01/16] net: pcs: xpcs: Drop sentinel entry from
 2500basex ifaces list
Message-ID: <xuwdtvep7iiqhptiraldr56us5zmgoripzo3kzy3ntrtlf2rxe@5a5qyqfrt2t3>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-2-fancer.lancer@gmail.com>
 <20231205112429.bp6lpvj4klrfrrim@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205112429.bp6lpvj4klrfrrim@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:24:29PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 01:35:22PM +0300, Serge Semin wrote:
> > There are currently two methods (xpcs_find_compat() and
> > xpcs_get_interfaces()) defined in the driver which loop over the available
> > interfaces. All of them rely on the xpcs_compat.num_interfaces field value
> > to get the number of interfaces. That field is initialized with the
> > ARRAY_SIZE(xpcs_*_interfaces) macro function call. Thus the interface
> > arrays are supposed to be filled with actual interface IDs and there is no
> > need in the dummy terminating ID placed at the end of the arrays. Let's
> > drop the redundant PHY_INTERFACE_MODE_MAX entry from the
> > xpcs_2500basex_interfaces list and the redundant
> > PHY_INTERFACE_MODE_MAX-based conditional statement from the
> > xpcs_get_interfaces() method then.
> 
> It would help the readability of the commit message if you would split
> it into multiple paragraphs.

Yeah, creating sometimes overcomplicated log messages is my eternal
problem.) Ok. I'll split it up.

> 
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks.

-Serge(y)
