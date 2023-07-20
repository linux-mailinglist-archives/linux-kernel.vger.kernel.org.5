Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2A75B09F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjGTOAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjGTOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:00:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6095A123;
        Thu, 20 Jul 2023 07:00:09 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA02C1EC0A74;
        Thu, 20 Jul 2023 16:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689861607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GufZZBpbEIyc9rvPAU9mLnlsTu37ExeuJKK0HsUapNo=;
        b=aA/mxGf3eFlXD4KGCLNQy0f74KKVxypoQOtoBHT0xAf2SvteMF+jtK7+GFv/yks5i1rvlj
        2Dcid1l6yRYmEWzv48AiZmP0FoVtLOEJnG0GCb/0kwVg1CdLQ5LhNNbsZVJfAUKpKpqUP2
        DLYA09b9sN3RhMJlp8zy65TayJO4KQY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L3muqDto_c3S; Thu, 20 Jul 2023 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689861604; bh=GufZZBpbEIyc9rvPAU9mLnlsTu37ExeuJKK0HsUapNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cl6YHjwjnsgYFFmsIJxw8gRzavxNPSH1P6dx/KGTiLz8ukTeIe7PDbfru02wO8fHc
         GNoP5gbgBTwO9HcEbqWrqJtacxudL3KUszJwlQH4/s5pfY9xxMYm3VDl7gNzmb1W3X
         o8TORyVUzuIeTcJvg2gKIXQQQelOZoGCXKVYdQcaXnIJfvrb08xeNOeXCTQjm4iskM
         jakM1jInsJGcVLmcNQUU0lWOttCYaPcKdn6CIuRuBy0fIDUt65oNZOV+ie94FGe8gL
         rFAbNb2ZMiHNnxihPBStZQtNNCvF9HUZushmsIXfM0YgHjyZ3KQNP42s5FkQboypFb
         iX1qjqeTgy8oH+dBgxT2jkEg2vwnq5bltXzl47aBhPKs2EMibswcQmg11H5NAJHUef
         JhCNMBOVPkDUoTKkn0MmzbT1USjSXVWW+goBprz1WPt0erlE/GPtkgxUcy2EmH+3Wn
         ARIUGHQ2QyWZaL/B/HtSL/m9M4H/JpZZSFh14D315e7u0sy8qfAV8rLaN5H3vtxxnY
         pXWMx7QJwEfjPX7d6Ehjr3ErcLXRB4uFkBFut/Zrm7Tw4XlZuoXBce2/+N/ZdSZDv4
         +7L93NkVAt10ubmlyVWAdxH39BnCY7+HSOTBaaY9GD7yOM6YOif6ZivBtXfZphTdo/
         W0/l76UHXm53uRQpJOJcTgTc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7702740E00F4;
        Thu, 20 Jul 2023 13:59:55 +0000 (UTC)
Date:   Thu, 20 Jul 2023 15:59:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, yazen.ghannam@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 2/7] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Message-ID: <20230720135950.GHZLk91jGbX7l+7AMz@fat_crate.local>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-3-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720125425.3735538-3-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:54:20PM +0000, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> On AMD systems with Scalable MCA, each machine check error of a SMCA bank
> type has an associated bit position in the bank's control (CTL) register.
> 
> An error's bit position in the CTL register is used during error decoding
> for offsetting into the corresponding bank's error description structure.
> As new errors are being added in newer AMD systems for existing SMCA bank
> types, the underlying SMCA architecture guarantees that the bit positions
> of existing errors are not altered.
> 
> However, on some AMD systems some of the existing bit definitions in the
> CTL register of SMCA bank type are reassigned without defining new HWID
> and McaType. Consequently, the errors whose bit definitions have been
> reassigned in the CTL register are being erroneously decoded.
> 
> Remove SMCA Extended Error Code descriptions. This avoids decoding issues
> for incorrectly reassigned bits, and avoids the related maintenance burden
> in the kernel. This decoding can be done in external tools or by referring
> to AMD documentation. The bank type and Extended Error Code value for an
> error will continue to be printed as a convenience.
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/mce_amd.c | 480 -----------------------------------------
>  1 file changed, 480 deletions(-)

This needs to stay until rasdaemon has support for decoding errors - and
I've told you already.

Lemme tell you again, maybe it'll stick this time.

In any case, NAK.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
