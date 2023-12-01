Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480CC800440
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjLAHC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjLAHCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:02:21 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152F21725;
        Thu, 30 Nov 2023 23:02:27 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 9CAB36032E;
        Fri,  1 Dec 2023 07:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701414146;
        bh=T8JMiYZNsTJUoKXUtVyfyVWVbi2lERt92r3CrXZczEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWrBD8D4Wn/H8eg46GPJijn8NrOiUogrLvyhwt6MGVWraVexd/b1Rz8d8Iv7AEHLp
         mJ4SJ/+1eiUrqDasiruVR/TQiaf3X0Szq7LC/xw9ymIX//JjAYCUPJddzqCqVdDDKl
         87YYbaZNzemSW0GfGTacF/JRXqLWEa23aW/SeU1TapuiwUDq1D4d5jjZJlEzav4GQz
         4cJ0Np27jEJCSVyHUbexC9vCa0QEaISeKNcl8yF3eOuZSRWIpzPuhL4Ltn4VbYLVpp
         eOHM90yiYKtYvsRq7/BOzkVhtfQRHTLDPQtF5/hjZp9bJcRhSxTosAyKWPVs3T/Zrh
         8HBVXwX9oSTgw==
Date:   Fri, 1 Dec 2023 09:02:07 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: debug: reuse the config DEBUG_OMAP2UART{1,2} for
 OMAP{3,4,5}
Message-ID: <20231201070207.GI5169@atomide.com>
References: <20231025112136.3445-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025112136.3445-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [231025 14:21]:
> Simply reuse the config DEBUG_OMAP2UART{1,2}; there is no need to define
> separate config symbols for OMAP{3,4,5}. So, just delete the dead
> references to DEBUG_OMAP{3,4,5}UART{1,2}.

Thanks applying into omap-for-v6.8/debug.

Tony
