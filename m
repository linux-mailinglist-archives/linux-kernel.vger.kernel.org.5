Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1675DA99
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGVH23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGVH20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:28:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C872211E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 00:28:25 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B26011EC08F6;
        Sat, 22 Jul 2023 09:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690010903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8T8TO+EdV9MuiZ/DWNvr7MD3Fbbt9LUbGUrj3WCQ3+k=;
        b=V5ipMTxt3hetqwpNC3h4t3IO4fyeWkp4BVrLhTxY8wY1EkfiYaFSWo+ZpgvA+jEvKrcyIj
        WqKY3SfQndF/AfDyV6Qz2OdmbAAXIeZuwtIdX6k763lWpyAeJN3GgdhlF1BP8uB1ybztTA
        pDYOgYC1T2lViWKA4mgW3Z5VB9gCzS4=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VVL13rjSZrOt; Sat, 22 Jul 2023 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690010900; bh=8T8TO+EdV9MuiZ/DWNvr7MD3Fbbt9LUbGUrj3WCQ3+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdhiQe0Sq1rznvgq1E7txEJryVstIVyLQeacqlXEWoyhZeCPH4S/2KAQXEXlgq8RQ
         VXrTK5+rVKscHsp85/xRzgiJWKOYPexV8wWk4wRkAqmKbTb2tb1+oxosrMKl0wUnIQ
         ZSIdtZtN0l1ndc+2l0Zut81e2B80pTkPBuSIn7e6M0GWUImr90bOZeyviilE7Vvx+K
         unjifHqDLhjCTd3UeT/zLRN+oqzkN5CmJF3sec5l9MoeHjLjpuLi4644c9h4g3lvO/
         RiQwNyahd5VvdZHeS6Ho50mO0got46P5iZi9qNO0c3/BWWy4ETgm0+LzY/sTaRTytf
         kwtbQFtt/ju4VVyjAhGDxGXc33Pwo4a5wDP5NYWzGQdxOtxD4K2EwG9vfejULkffY8
         stVJN+cnPFlFtGZCXV2Ak8ezqnJaXCsBzIbYqoxP1LCiR3qPXPqirUOSPjH/9139SX
         Pmtq5dGz+RsgJT6LMVT7UW8ax9twm9dsp+w3dW2PkZFFBPllbPTkjOBZLPs975Wuit
         CEEwJwfEMHHE8Xg2gYQz43KYhVHvYzcvSLELvyReSZSSgvTDSqvXdTVKoSFfnFG48K
         ua+mUvbfftIg4CG5h0SFpZeW9IgWAToUvK4ympJY2zOMitSBiWzQuOKndBD468vZ6/
         cVjklKDACznId60dYQ4vsrNw=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CDF640E0185;
        Sat, 22 Jul 2023 07:28:14 +0000 (UTC)
Date:   Sat, 22 Jul 2023 09:28:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     John Allen <john.allen@amd.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Message-ID: <20230722072813.GBZLuFDb2aimfOoZh2@fat_crate.local>
References: <20230720202813.3269888-1-john.allen@amd.com>
 <20230721154942.GBZLqpFkZoWn1Um+bq@fat_crate.local>
 <ZLq1W9en/2jroDGB@johallen-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLq1W9en/2jroDGB@johallen-workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:42:03AM -0500, John Allen wrote:
> Yes, this appears to be working on my machine as well.
> 
> Tested-by: John Allen <john.allen@amd.com>

Thanks, I'll queue it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
