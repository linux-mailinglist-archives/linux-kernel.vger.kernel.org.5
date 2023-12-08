Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9840480AF17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjLHVzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574828AbjLHVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:44 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63F1708
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:50 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5673040E00C9;
        Fri,  8 Dec 2023 21:55:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vDhaLx8APbbW; Fri,  8 Dec 2023 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702072545; bh=QDPC5sOpnKXgPf6ACBXsRnDVgJ5DYh12hkI7/XrN3iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TowCKRffBi8rpFPRNYrvsc1Nhloh8f8OFKkkx/gOv/hn5eUvoERdqOB+RU1kIVHrn
         /o3Q0ZKTaZTIkUxPva/ZZE0QO+cRSyr39swPhAwSGXV2Cb60CxEQTg7pGWrCorm6Bv
         CbJia9u0DjkhWmUaJtFsSLyNXZ39j0HJhZiAcfiKGx1eBDuPGRPfjfBKaTngUgATnm
         HxwpKycoIYBhipObXZaCUM0wYpKBAGSiqXcINURBc+qI0pDYbttqCzBSP0oBH+gJ2p
         CQG5SB9IUUnIlp5xvJbtlfhMTTK9BzVxeuY0QGmOUnR54/e/31HN1wDMDvOK5nuucL
         Uo6VmFWqEEiwMtUgjnKG9sYWnBTEmR/Z8pXbdu63hsxD0e9MKDfxayFz0GY3DyIGf1
         8FJsat+zRraQeXNHZ1Q57MCu1346PC/GO13cgba8gfb8ZAHrXD5JCHrItPnf+5Y71g
         XWxuRvSjoy9/qYfJS6oAgXnT3xdEWZQua6KfClCDS/io9x0CBEFpzUtKU8Qdukk5sG
         A/BF5jtbh3NJm7nE24WRck4DeBztR1vWsqzxepoa6z0MFo16d2MXSkuOZxx02Cp6Nj
         oK/BS1mnAk9W9l457rIfyT8MGTOiZAY06Jpj0bDve6R1Em9tBBxV3J0uMEv037lV/6
         bcVHPBkupCHYuBMpwrRi76RU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CB9C40E00C7;
        Fri,  8 Dec 2023 21:55:42 +0000 (UTC)
Date:   Fri, 8 Dec 2023 22:55:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/x86: Document what /proc/cpuinfo is for
Message-ID: <20231208215537.GDZXOQ2TKjOZJlflUz@fat_crate.local>
References: <20231129101700.28482-1-bp@alien8.de>
 <4afd33ba-6b7c-415f-b9ef-964a2fc840d8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4afd33ba-6b7c-415f-b9ef-964a2fc840d8@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:20:31AM -0800, Dave Hansen wrote:
> > +And even if it doesn't show a particular feature flag - although the CPU
> > +still does have support for the respective hardware functionality and
> > +said CPU supports CPUID faulting - userspace can simply probe for the
> > +feature and figure out if it is supported or not, regardless of whether
> > +it is being advertized somewhere.
> 
> 		^ advertised

"In a rare show of solidarity, both British English and American English
spell advertise with an s in all forms."

LOL: https://grammarist.com/spelling/advertise-vs-advertize/

Agreed with the rest, v2 coming up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
