Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07577D24DC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjJVRW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:22:56 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD151EE;
        Sun, 22 Oct 2023 10:22:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 334B240E0187;
        Sun, 22 Oct 2023 17:22:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0m_Nz9RcShwH; Sun, 22 Oct 2023 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697995369; bh=Ypyxcgpgo+gvmGmnX0RaofSjlLoMxp6+F/3ibCWhm7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoi18bnKRHzOU9VSco8hMM1qnSzSR64qk+C+SSU3fVeBCgYRQbylBW2RjsVUZXgIH
         AV0FKLnyfYhYca5MD783YGyYh8pSQ4efiAwDwED9X7cCc9Ue1RSJ+SxD7iyqnC/Krx
         rzzgG8iHFaub6ySZUOixUw97P9BvDm3mkPIcNGOVHq2T1/KCooqZUo373lxvSGLWA8
         o14FXAGthymD3rAqwK4ftUSqeUk3atOH6doNSqKuEOq+uc01ThfrY/Tg2C3X4d8StQ
         CkH372TtoRU+u1z40K27mUWwea3Jf9pv6jvTSl/sz5LtaH3mLa8BmykfUCpiDoHaY/
         nq5/cPMYPOZEM6IsCxlJvdK4IDuBI8W9CBPfJ6gVtoD4HPDixlWmx+/r5JgaLHWxmD
         QDeITZUXwLqFEbzkzTAxKiR0J6GkgQ6AHrn6nH7qUbjQci+JGU6I5M/pRecTo/FvFJ
         auUFdB1R90+yyuMAxeRyLCLUYl5GDeMy+yF0jwjTz1DWsJ5ArE8v8atW+M410AQ4h4
         jt5FpzcuvDt4/hCMcigbIV2rxqDLCQptoD9/sCNBC/G96FsmRQQmjhNTq+RBWKFRBE
         exQ0jY+BbMs9RLZxyzQHJ1mYEDL+PO0gCcu8gv4mujd1Ek3W/GDJHo4c2cWFFeYLRB
         BQGGRjwsWDvr2wPFbHUWOB5I=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 519CC40E0177;
        Sun, 22 Oct 2023 17:22:45 +0000 (UTC)
Date:   Sun, 22 Oct 2023 19:22:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Julian Wollrath <jwollrath@web.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Oops with v6.6-rc6+
Message-ID: <20231022172240.GBZTVaYH1Ext47Z5o4@fat_crate.local>
References: <20231022172700.48c515cf@mayene>
 <20231022161847.GAZTVLZ74T8B79v87p@fat_crate.local>
 <b4ebea2eeb63aaa7ba0877cee0c9ca966af9eae0.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4ebea2eeb63aaa7ba0877cee0c9ca966af9eae0.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 01:06:25PM -0400, James Bottomley wrote:
> How to reproduce would be helpful.  Was this a cat of /proc/scsi/scsi?

Probably some tool did something weird:

CPU: 2 PID: 13243 Comm: colord-sane Not tainted 6.6.0-rc6+ #9
			^^^^^^^^^^^

judging by https://www.freedesktop.org/software/colord/intro.html

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
