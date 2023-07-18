Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE19758171
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjGRP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjGRP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:56:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9790A9;
        Tue, 18 Jul 2023 08:56:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so8148001a12.3;
        Tue, 18 Jul 2023 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689695784; x=1692287784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xl9bZKgSzS15J7X7my6aXFKONUtvaDuDxqByit5t6Q=;
        b=EmOhnUMO+7tMBy/jkg7S0CAz8HDl9naZAONo2wPwnViMQTIbb5Fv7zLpXBhU6CbCVW
         VlddVe3zA8Dd/zSmHZZe9EdQsj2d2y7kxo11f8uX8ynFjRwrLZ9qVNCA2tFopHIwCA6B
         yDYUSGnZ2CtM6NKVK6kdNZx804ko4s5YWej1S1aLXwchkO2GVTH6eMIZikPHyGfLusHj
         B41Bkgo7w4O2pJWaWEzJdH9TRg6W/Jq5t4AWM1rhaUy5BKvSU2oOAYnMa3kHx+OKbhA/
         mH7lg/DQyPf9MRzi9Jz5eOl4A895bP74sSmi9/gyqf9weU0r8opPCl0o9dhD4FV6UlRu
         JmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695784; x=1692287784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xl9bZKgSzS15J7X7my6aXFKONUtvaDuDxqByit5t6Q=;
        b=TWCGlsKEXNvx8umPDzh4G5aa1IwLtix6vzY53Jug9yulPExrG4Tjazf2o7JTNZDeVG
         IuBp67n+rD7dNCFs94HRHKjlAhZ6U5TQBOG0dIFEWEbZLY1WPRuYISOn/LyPINSttI0b
         0n7BmUcRVed0Z6hs2Pz2AL85UtT8G9JP06zgmjNDItC9zXfwlS+9Gai+bABTwT1kN8ut
         4fQGqUBoAKpbWXGT6DVF/eTInCGb6t2oTo21sD9NL6oTsiIJZw8E+T4uLDDp6V0Ao/Bx
         cE+yejvZaUnR9N6YS70+msOPl6+w595Ck7beEluenCnG+pM+1v7tWkO2Tct2FKQxbqC4
         HwVw==
X-Gm-Message-State: ABy/qLY/pbk3T8BQtv/H72XxjhlLcS/yCbGn8cIiHQwHihDmXx5C8F01
        znuDCgojgXy7d4Q9BPol8zo=
X-Google-Smtp-Source: APBJJlGY5EUXk+L0bGBzfzBP2tkksipSow3COZNEwQuFLJEE4Ab/VBrBxfzD6Kz/SZmeGQdzJ5hMIw==
X-Received: by 2002:aa7:d043:0:b0:521:ab99:89f9 with SMTP id n3-20020aa7d043000000b00521ab9989f9mr141431edo.14.1689695784191;
        Tue, 18 Jul 2023 08:56:24 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id l25-20020aa7d959000000b0051a4c1dc813sm1378842eds.82.2023.07.18.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:56:23 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:56:21 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <20230718155621.3jenfn7rqtgouny7@skbuf>
References: <20230718150133.4wpnmtks46yxg5lz@skbuf>
 <20230718152512.6848-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718152512.6848-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:25:12PM +0200, Ante Knezic wrote:
> > > > It does not apply cleanly to net-next. Please respin. You can retain
> > > > Andrew's Reviewed-by tag.
> > > 
> > > Respin might need a complete rework of the patch as with the
> > > conversion of 88e639x to phylink_pcs (introduced with commit
> > > e5b732a275f5fae0f1342fb8cf76de654cd51e50) the original code flow
> > > has completely changed so it will not be as simple as finding a new
> > > place to stick the patch. 
> > > The new phylink mostly hides away mv88e6xxx_chip struct which is needed 
> > > to identify the correct device and writing to relevant registers has also
> > > changed in favor of mv88e639x_pcs struct etc.
> > > I think you can see where I am going with this. In this sense I am not sure 
> > > about keeping the Reviewed-by tag, more likely a complete rewrite 
> > > should be done.
> > > I will repost V3 once I figure out how to make it work with the new
> > > framework.
> > > 
> > 
> > Can't you simply replicate the positioning of mv88e6393x_erratum_4_6()
> > from mv88e6393x_pcs_init()?
> 
> I don't think so. The erratum from the patch needs to be applied on each
> SERDES reconfiguration or reset. For example, when replugging different 
> SFPs (sgmii - 10g - sgmii interface). Erratum 4_6 is done only once? 
> My guess is to put it in mv88e639x_sgmii_pcs_post_config but still I 
> need the device product number - maybe embedding a pointer to the 
> mv88e6xxx_chip chip inside the mv88e639x_pcs struct would be the cleanest way.
> 
> 

It needs to be implemented exactly as posted here? After mv88e6390_serdes_power()
is called on any port/lane, mv88e6390x_serdes_erratum_3_14() needs to run
for all lanes? That might be a problem.

Do we know if the register writes are disruptive for the ports which are
already up and running?
