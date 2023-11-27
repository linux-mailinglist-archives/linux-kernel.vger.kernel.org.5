Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDA7FA7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjK0ROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjK0ROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:14:43 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B25189;
        Mon, 27 Nov 2023 09:14:49 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9C47640E014B;
        Mon, 27 Nov 2023 17:14:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TjHxyBW3GjS7; Mon, 27 Nov 2023 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701105285; bh=1XsCHVs3G1AK8quCu6PRq/dRGJyYh/0vS/L9fgr5Dsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYnUBMxlUm/TeOHT5vbel+mUEYciMKpvvy+i3YEyhxclh1vMaMbB9Wdcrfgn0+Cr+
         GIKWaOh16XC0T5xDMYAyjF10xt41gjmE4hMY6xzxao5+KbzngfJUuXQzobZDxr0SS3
         R7YIYl8jGA+haI1u/73qjzSrfRQm+PCqOKnmwGrmZdCYpkENE/by7jpVjJYBqAeUlz
         QtIs88mTZvYi7uE/oMoM/8xaZmCf4Nk2KzokmUhX7kCQOqD2P43jNGEtNV/MsWy4qA
         EOyYJhLmgKNgvzl86irhK8LEDW1xi0f84Q3huE5tSN4WZhbKrH1Zi05fyhOoFva0L6
         y7vGf2RDhrV2SRxhVPTmnMFI/235COquRZeyX/piq3v/ughSaGrvViR0oX/gO+dKE1
         wQgt8I9CZADCeSsv+1gCPT1zxQErPcA0nsfqD+Wl94yxknBrBl/rnkhCE+Tz/3xoTf
         +qJ27ibC2ldTHPbR1NckGyOSile12D0Dxx38HipK+75l14qJ2CxFVTy0bAXTaMiyn4
         qKJswJarSLRRalEwOjHZs1cgHBzKcOI1MBSe3/lWorYuVnRf2J6Nj1KdGUphYMxs2M
         mpv0w9U4kgcVFHtNfsSJqOzcSqSSW2a1rADflw2Go9zmbIqORCExdBVhXXytbJjRn5
         87FeZVC+5BF6ZSqdTDwErw68=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9BC740E0031;
        Mon, 27 Nov 2023 17:14:36 +0000 (UTC)
Date:   Mon, 27 Nov 2023 18:14:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Message-ID: <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 02:51:57AM +0530, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.

And that is a problem because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
