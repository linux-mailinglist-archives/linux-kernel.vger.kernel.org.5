Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B2077EA74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbjHPULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbjHPUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:11:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C6CD;
        Wed, 16 Aug 2023 13:11:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ff88239785so3152005e87.0;
        Wed, 16 Aug 2023 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692216685; x=1692821485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/mQ8xEIhV/BLHZm8bwv+ao+PfN4HncxfEYIWfMO7+c=;
        b=soc7W5VNkEBZRu4V+6OiKZ2sstEEQCcntOm5NBNX8qOvFQvCH8bJQt/YTmDDLewRKD
         4izRRUwSuAidjtoGy7CYqmTP6OSQXkC6MRlRnIcXoYRW6Y5jo1K7KWHwYHaMEMIoROE0
         6rryKKvbP2A1Gdsnm86rgUrG1EtZF3+MMXWqROpd7/3R6VC3ADWpWNEg1Oy4s+SCXn/8
         FW+rGjf3LdKkDe52Z9hxO7AHIFD5Za6sEGd6KpIin7S02dctINLUYCejSZ24+aRtsddU
         SoVz2uHtE1t8Fr72t565c35K6vECWP6VtyhtnYFivOPPDCBRD7MsnHmjmLXmkSm+F3Li
         S+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692216685; x=1692821485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/mQ8xEIhV/BLHZm8bwv+ao+PfN4HncxfEYIWfMO7+c=;
        b=ALEFAWdRa6M/0EYOuH4LPBY6XqQsrMq1Rv7MLajHK3PWK95M2PVgv7vqkjBSfq0mJj
         9Jz4uJNV3/dgKlKekJujQxUyPNym13IuI3MwW6wr19oTWCgPEBN3lVy58zFAJcqgWwcy
         ONybrnBdg0dbgaTsMgxoV20Y5XvQkzEObUUzxWGUhQAEwJqIOJy3dUZXPb8kPd+4LqDV
         6h+JAsm+HeKFEMJkezUsIu1p/xZ1vBi6qI3bwF3NtMObBPXMZf46HBSrFC2XpOcdCav8
         MTw3rnnOgeYIvpe7yEfIwF2+gcWSGNRsZBd7rEqxwjIWu9HSOMwfw/HGt0xulTG5mAvq
         rfzg==
X-Gm-Message-State: AOJu0YzSqY8lRIXxXlt3kUx3gwfCEjg3HszQm8qqnIrLC91AHBQCWQBF
        scQEUtHTvENs8TMDEg3rh4Y=
X-Google-Smtp-Source: AGHT+IFxRDgy+6OlsYVjtxLitGdXoe3Kpwl0ydbpf13DtxUU/2QvUK2FT+pCle3tJUHbiuDEuLeRTg==
X-Received: by 2002:a05:6512:a91:b0:4ff:8d18:a153 with SMTP id m17-20020a0565120a9100b004ff8d18a153mr3260591lfu.52.1692216684886;
        Wed, 16 Aug 2023 13:11:24 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id l5-20020a19c205000000b004fb745fd22fsm3016749lfc.32.2023.08.16.13.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:11:24 -0700 (PDT)
Date:   Wed, 16 Aug 2023 23:11:20 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio: mdio-bitbang: Fix C45 read/write protocol
Message-ID: <kqg5jsbtkc2247fceccdjekthrmbfchjx4ggwe22esd4asipif@gg6s6iebp4r4>
References: <20230816180656.18780-1-fancer.lancer@gmail.com>
 <898c8b42-c3ad-4c2c-8903-c25f58a4d079@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898c8b42-c3ad-4c2c-8903-c25f58a4d079@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:39:37PM +0200, Andrew Lunn wrote:
> On Wed, Aug 16, 2023 at 09:06:52PM +0300, Serge Semin wrote:
> > Based on the original code semantic in case of Clause 45 MDIO, the address
> > command is supposed to be followed by the command sending the MMD address,
> > not the CSR address. The commit 002dd3de097c ("net: mdio: mdio-bitbang:
> > Separate C22 and C45 transactions") has erroneously broken that. So most
> > likely due to an unfortunate variable name it switched the code to sending
> > the CSR address. In our case it caused the protocol malfunction so the
> > read operation always failed with the turnaround bit always been driven to
> > one by PHY instead of zero. Fix that by getting back the correct
> > behaviour: sending MMD address command right after the regular address
> > command.
> 

> I'm actually surprised we have not got more reports of me breaking
> MDIO with this patchset. I did test bit-banging, but only for C22.

Yeah, I was also surprised not to find any fixes or reports for more
than a half of year in the mailing list or in the commits log. I was
sitting on 6.4-rc1 when the problem was discovered. Seeing the problem
was easily reproducible I decided to get to the latest kernel before
get to debugging it. It didn't help. The problem remained in 6.5-rc4
too.

> 
> > Fixes: 002dd3de097c ("net: mdio: mdio-bitbang: Separate C22 and C45 transactions")
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks.

-Serge(y)

> 
>     Andrew
