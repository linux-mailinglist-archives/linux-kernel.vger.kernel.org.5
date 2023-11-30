Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB27FF7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbjK3RNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3RNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:13:50 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F910D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:13:55 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A68240E025A;
        Thu, 30 Nov 2023 17:13:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s8GQOz-K4puh; Thu, 30 Nov 2023 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701364430; bh=vzlJCOdzYY0S9xdvlV/r00h+Y+Hsy8vTAOUbTtv8S8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+pOwfVt69RJZdTA9cIV3XESp5PwKivysKj8n/TuagO85XAfDy6mxFnDdbr3MaK4g
         7DaSsXXsjGRIDoQvEbxErw7Cvv/IcTm4OmMn1oGthUTEN4aYTm6+8i/q1NNOoWq1mN
         t8lxN+knOrbL5BX1r7653OZBL+4MQ19QCMBhcNghwFhkkJ4aHqUtrrIi1U/7rCC3We
         Bg1XWSLpIM6qOTofOWLlZRDJCwQryznoKWD//8uk0HpRK9i87SWnLsqSJz86WXXaqN
         BKV6LxzLkUrVVmxLRBqLUew63HLzn+PfqBEbiZ4wxcm4bbqGePvELisSSPHvw65ZRN
         rjju3QaHYWLx7jSgOywd2GsVvdEln/WjZbgEAJWAU9fHlJyy93eZheum7pY65rXjAt
         9pxoGHZhZeMlPGhr0KX0VxLmZFcNOBK23vMowTWkYogZ8iWjKNqiZUROMHHusKtv8U
         tIRZOwKwoyXHq9lbtI6wqkAGQ4DBSZOQhowEWTb36/wcl9L5CoPCvyLNC9ydaY/XBA
         0ynh4iPLwtHeCuSzePu8YGK+U4Kq1ECRE2F+PFTNwHMFC2vTgkDZ7pbdHhy7uZRAPh
         8synulD3r6+Nokw/UIGvYRFWLGoDjUYeCG5yweGdoThw/trGBIbQit2yRI0e71Jxy0
         4Fs9gZkdCcRKL2muKmt6QR50=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE4B140E0030;
        Thu, 30 Nov 2023 17:13:47 +0000 (UTC)
Date:   Thu, 30 Nov 2023 18:13:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] x86/CPU/AMD: Add ZenX generations flags
Message-ID: <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-2-bp@alien8.de>
 <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:05:14AM -0600, Tom Lendacky wrote:
> Previously just being family 17h or 19h would get X86_FEATURE_ZEN set. With
> this, if the model check doesn't match, you won't get any X86_FEATURE_ZEN*
> set. Should you do set X86_FEATURE_ZEN here, e.g. lowest common denominator
> for the family?

My assumption/expectation is that those WARNs should never happen
because they will be caught early enough in enablement and I will get
patches.

Besides, X86_FEATURE_ZEN means only Zen1 now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
