Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1723C805376
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442333AbjLELtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347077AbjLELtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:49:40 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C31AB;
        Tue,  5 Dec 2023 03:49:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf898c43cso1994651e87.1;
        Tue, 05 Dec 2023 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701776984; x=1702381784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AcNcuzGaQBjUBsiLWETqgO5QGNFrGHbqm/wUp0AM8dI=;
        b=SEVVCGo/NXb7w7bSjOiZx0rYuK6Eyyy6rI6Gyc5cnev3w19Ma7/WpOQ9C9G4onTNPx
         wKZBDQXA/2MV4lNYaS3zuiFoFg9ZTwn5IU4kIdyvvEoBjcfpp5sgDMTr79/meJ+N6IYv
         UjIIC4dqE7/9J5S1bgpgL11toczURz8AbNHLOL+ei2tT3BaSjI7HN8xViK7X19GX+WGP
         C6L0JPvPnsIDkhCPToPi9EcxH625z74X+p5EhPiTk4mzlC7IGRpwkn2Inwfqa5kRtQ65
         5MIJCcbtwmByC2tc2nQum1LvzDC637VpJwcU3xkyess+cqPgQJmCZeI/f++hWQ3sEQec
         YJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701776984; x=1702381784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcNcuzGaQBjUBsiLWETqgO5QGNFrGHbqm/wUp0AM8dI=;
        b=DcTITSU7NLfBJDMD6ZIFR/m6G2RbEe7GUtYmWk43DpuIleGO0wSv353YaERfYvLVp6
         jFdpcqdngvznMyM4RnvbGN/X3HmVLiOQ+jENJYXdMQkHp+329JX1ka/NOqnd+fywYTaI
         19BeZ+xNU+0TwAXGQuZsXzXIAfQmzJzv29r5mfXrF2Z1HUTUvdr1/N0GbN/3geKXTfJt
         MInDixlGftEpc3duOGktoofP1bTEALPFyZMDegOlxb+YDxQy39qmHg1CzbUzb7TahBt0
         B1ogjnECDg2ZHeRKMdb60vKwx7EDa4sZ5uWuMBhzxYzsjlr8Vdeo3FkBMmiDvZlDSzOO
         72IQ==
X-Gm-Message-State: AOJu0YxBz0CE622HQ+NsnTv/VGV3pILyHe80prybPmtsDtojM77zygTD
        42aQP0rt+jCnRTYlSQmWW1E=
X-Google-Smtp-Source: AGHT+IHG01Rbi7bi2+HqRxjF1g6Uid7DKqoIjAsfnJUvTJZdfjRyLs23pzhCbhHBaCrpogRFumVNSg==
X-Received: by 2002:a05:6512:1394:b0:50c:320:f171 with SMTP id fc20-20020a056512139400b0050c0320f171mr476503lfb.197.1701776983952;
        Tue, 05 Dec 2023 03:49:43 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b0050bf0921ac1sm792193lfs.206.2023.12.05.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:49:43 -0800 (PST)
Date:   Tue, 5 Dec 2023 14:49:41 +0300
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
Subject: Re: [PATCH net-next 05/16] net: pcs: xpcs: Move native device ID
 macro to linux/pcs/pcs-xpcs.h
Message-ID: <6zejbbv6oriaztbbgyjy6r6hycccq6rvypb5ywxf7nqx3vlq7r@na5eossdsuec>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-6-fancer.lancer@gmail.com>
 <20231205103559.9605-6-fancer.lancer@gmail.com>
 <20231205112755.3am2mazwireflpkq@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205112755.3am2mazwireflpkq@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:27:55PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 01:35:26PM +0300, Serge Semin wrote:
> > In addition to that having all supported DW XPCS device IDs defined in
> > a sinle place will improve the code maintainability and readability.
> 
> single

Got it. Thanks. Seeing there are so many comments about the log
messages I'll double check them on v2.

-Serge(y)
