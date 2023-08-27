Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AE789AC1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjH0BF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjH0BFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:05:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE619A;
        Sat, 26 Aug 2023 18:05:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so31909871fa.1;
        Sat, 26 Aug 2023 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693098329; x=1693703129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh08RvjtMadNV8YyJ9pJe6FtKaLPWrZmhvyrDo+tDiY=;
        b=frkaAwktoorcXwQ2lF0D4PouETVI7MnarulLVDj54omSxdzlMT/d5DfMOCYYM3uVbD
         KdI9s+TvWDyPw7dIGBxQjkHq8amEsK5D6wcd/fWDXsrukkSjeBQrNyOm2VTp9T0VSwJ+
         Nt0x7ePCJhUssJBuO3t4sl1dh4pVkW6zMfTsnSs0HQbx6b3GaHoM7g2bniZScSiy4tI0
         K6p8XVOknpAoUjjK0k9KlX0q+qwr0+74SJGoHmwm91DoZW6HcbMUFEYldPGWXUgwRQRa
         E1MuX5EziEJ+DoI79D+uLfeneuyCPvneGiyQZ+U7ZJF7t4HKF+KvRtFkpzn4m9FPVAC2
         eC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693098329; x=1693703129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh08RvjtMadNV8YyJ9pJe6FtKaLPWrZmhvyrDo+tDiY=;
        b=i79SJi1ZdRFkIughkMULsZe679ofMwJccA/XtbF7/TqbssEnwE4O53D1gsnJF5fZs8
         UTBMS0d15j/GKmx18rTlTVsqhOo6sQJku1Mqs2tu04xkCImX6uWF/mvHZ2SE5dqPYXao
         8sJ4jSW852Lm8sp1DJcydQkDMwmWv05kKMHhXisJidPYdLDgjE54dKPliSz4SoJxW/eN
         7gY8meDDSxU9tGF6WWrhAF9Zr2GEx38R04hUfNrv9oKfr30D0zbTNSKk3Z0vw6c7j5Dd
         5ZY8z7KzjAhcLdjCDiSTVcQzxAovKS09izA6F4hQAnBIjoS1vWaL/pJH1Iq8caplPwOw
         QnuQ==
X-Gm-Message-State: AOJu0YxUgco347Ow2gdHTc7t0UDomZBjjSwawvGuxi7VOaGlGFjK+rsB
        3/+TXKQ/7IWM9WoGpWk/kko=
X-Google-Smtp-Source: AGHT+IH0UZuuaxknJzE6dFxZoiFGxR4nMxrJELQhqMeeO4NGfTXq2f+Ep7uv2zM0/BtVTCJzV2giSg==
X-Received: by 2002:a2e:9699:0:b0:2bc:d6d8:fd35 with SMTP id q25-20020a2e9699000000b002bcd6d8fd35mr10569761lji.47.1693098328914;
        Sat, 26 Aug 2023 18:05:28 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id e25-20020a2e8199000000b002b702dfb510sm1000375ljg.39.2023.08.26.18.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:05:28 -0700 (PDT)
Date:   Sun, 27 Aug 2023 04:05:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: Synopsys XGMII MAC and USXGMII interfaces
Message-ID: <q325fnweuebsmjrsfi3xfnttetgjmjsssvlscgq6lftg6acjsh@zkku2kmtpbmk>
References: <ZOXmWLB4TKGKvkiE@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOXmWLB4TKGKvkiE@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:58:32AM +0100, Russell King (Oracle) wrote:
> Part 2 of the discussion...
> 
> A similar issue applies to PHY_INTERFACE_MODE_USXGMII, but is reversed.
> USXGMII supports 10M, 100M, 1G, 2.5G, 5G and 10G. Phylink allows all of
> these because that's what the appropriate standard says. dwxgmac2
> initialises config register settings for speeds from 10M up to 10G.
> However, the PHY_INTERFACE_MODE_USXGMII switch() block in
> stmmac_mac_link_up() only handles 2.5G, 5G and 10G. Shouldn't it handle
> the other speed cases - it looks like the MAC does support them.

AFAICS yes, it should.

> 
> The initialisation done by dwxgmac2_setup() does setup control register
> masks for everything from 10M to 10G, so on the face of it, it looks
> like a mistake in stmmac_mac_link_up().

Right.

> 
> If it's something outside of the MAC that doesn't support these speeds
> when operating as USXGMII, then that needs to be handled.

Based on what USXGMII is mentioned on just a single Synopsys PCS/PHY
page on the Synopsys site I guess that DW XGMAC doesn't know anything
about the USXGMII interface. As I explained in my comment to part 1 it
just exposes a multi-protocol port(s) capable of working as XGMII,
GMII or MII. Then XPCS consumes/supplies the data from/to the
activated interface and performs a respective data encoding/decoding.
On the lowest level DW PMA/PHY does the serdes-ing. See the brief
description on the Synopsys 10G PHY page (on the "Downloads and
Documentation" menu):
https://www.synopsys.com/dw/ipdir.php?ds=dwc_multi_protocol_10g_phy
it has two layers:
- Multi-protocol PCS
- Multi-protocol PHY
both are designed to provide USXGMII and SGMII interfaces. 

> 
> The other weird thing is that when using PHY_INTERFACE_MODE_USXGMII
> with XPCS, XPCS supports 1G, 2.5G and 10G ethtool link modes, but not
> 5G. So combining the implementation in stmmac_mac_link_up(), that
> means only 2.5G and 10G can actually be functional. Is that a fair
> assessment of the USXGMII situation with stmmac?

AFAICS assessment seems quite fair. If USXGMII is an external
interface then these ethtool link modes are just irrelevant. Despite
of the XLGMII case I don't just see of how USXGMII mode could be used
as an internal MAC-PCS. Since it's an external interface then the
actual link modes are supposed to be retrieved from an external PHY.
Seeing STMMAC driver doesn't support an external PHY attached if XPCS
performs C73 auto-negotiation, then the xpcs_usxgmii_features array
should have been filled with all the USXGMII-speed-compatible link
modes.

-Serge(y)

> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
