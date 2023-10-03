Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE37B6644
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjJCKVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJCKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:21:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F43A3;
        Tue,  3 Oct 2023 03:21:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32329d935d4so763442f8f.2;
        Tue, 03 Oct 2023 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696328488; x=1696933288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyk1y8XC/A7otYhdDr88eU8AxtqyBbvI9qOM1Ivdglo=;
        b=UFovOfJH+qEMPSXwCYfuPLowKy8V2JSdSE48yuGCyOks1EAMFKbRNo7BkZYO/yIFIw
         k9q2dF9FHSVVQ1T4fC1j9D2plNxaBRBQtpGCxAzPLeupP5kgcQONZbcNN9ZkC9fh5qP4
         AwfGJXauMXc6aXBGNe596E1jtr4WOUZyWQGeSMUg70Pr8hY1yH7S2Xdpg04zAHPSu/1J
         TsXMvZK4HEuYms0enhKgi+Mmr22p8Nass560ld9pQmInjLHTKg5Y+oBcnUurGL9t8HzL
         dOoJxAtNpG71GANS96rT7xMoz8zj12gyj8jtYWbI2j138el1oBZR528YfcubszKP9iPc
         STpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328488; x=1696933288;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wyk1y8XC/A7otYhdDr88eU8AxtqyBbvI9qOM1Ivdglo=;
        b=tG1ox+MWlbEYcLs+JGok7fhilgYjQGED/0Cukwr8SRi4HG7CNg7jkzSlGFGZgnoeUs
         czY7XcAEPsfSLbkaCME4Z+8Z8tANckmHdME2VAGGh8QIz0j1DqU3ANZ2TY+J+98sphuJ
         R/ahxC8poYfybWIVu6rwb3vIMJTftBo8Xa++y2Yyb4IZzuTyyJUfB07RTtQRcM6OfnEh
         t1X2Abi5c/usV6EIKilih5iqCw1jUmvqkWgtpLJj5SCuHos1RLYHXisdtjSeGFgtcoR4
         uTiBRnSHApTl8lL2NZOnYglZMMhrkB21XE7wN43z1BuD7JrJh+nSF9fE6R0ryp3r44UF
         kU9g==
X-Gm-Message-State: AOJu0YyC+myPH/AP9I7klxQ1rjKvEKrWeAVAOndLNOvZezQ1/faw/lvg
        3JQ9nOtgwWrrH6mzRu6LKQU=
X-Google-Smtp-Source: AGHT+IFoGSxPH67dI0pSqB17FrRseCZNLJ1HnkigQOoUBOBngTInpQ+0b6carltMEWxkHkGJaPnRMQ==
X-Received: by 2002:adf:e592:0:b0:31f:f9de:6a4e with SMTP id l18-20020adfe592000000b0031ff9de6a4emr13329765wrm.69.1696328488077;
        Tue, 03 Oct 2023 03:21:28 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id f7-20020a7bcc07000000b004053a2138bfsm9119977wmh.12.2023.10.03.03.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:21:27 -0700 (PDT)
Message-ID: <651beb27.7b0a0220.fe7ca.2796@mx.google.com>
X-Google-Original-Message-ID: <ZRvrJnPG6hTpyO1h@Ansuel-xps.>
Date:   Tue, 3 Oct 2023 12:21:26 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Robert Marko <robimarko@gmail.com>, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
References: <20230930104008.234831-1-robimarko@gmail.com>
 <df89a28e-0886-4db0-9e68-5f9af5bec888@lunn.ch>
 <651b26a5.050a0220.213bf.e11b@mx.google.com>
 <9a84642e-b4fe-4e36-bcdc-d02c84bb1dc9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a84642e-b4fe-4e36-bcdc-d02c84bb1dc9@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:07:25PM +0200, Andrew Lunn wrote:
> > This is problematic... Since this is a plain standard PHY and we don't
> > have a compatible (as it's matched with the PHY id) we don't have DT to
> > add this... Sooo how to add this? Should we update the generic-phy dt?
> > 
> > Should we create a dummy dt and add a compatible adding
> > ethernet-phy.ID... just for this properties?
> > 
> > This is why we were a bit confused about adding a DT commit to this.
> 
> Just do what other PHYs do. ti,dp83869.yaml, motorcomm,yt8xxx.yaml,
> nxp,tja11xx.yaml, etc.
> 

Thanks I prepared a DT hoping it will be good in v2.

-- 
	Ansuel
