Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69CC7A1DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjIOL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:56:46 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5BA19BC;
        Fri, 15 Sep 2023 04:56:41 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A47DC40E01A5;
        Fri, 15 Sep 2023 11:56:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MMcr_PbPERky; Fri, 15 Sep 2023 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694778994; bh=175g7SJNtbpOYi+dD8u5/4xm31IXiQXwUxLxD1MYjIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8cGtnXKRVnjSChN1O93tW/N8vt0QAh93FG4TQdEexN19JVHu7blFR45aKl0IZE8c
         vZiSFDoCH5J8Mw7vTJHC3RN6WSxvRNF5gdm0mf3cNCP1K+UeXTrVwOHMg7mcYhPFdN
         yH/RYP3EydpidbKUe5FvPGa73bw+o01dwTBvXD89DY6Apc+Rd4PaBuxuVGXzv67D+C
         /YmKJMLjLt46xdkm5Ee1k24SG7MHmsBOypgZayFAJlt9JhO7SDaOKc3MfFGnQhXdmH
         Eee9EwbdMi9OcWzl2injyZKxSnI2uw//oaw9crg93KYaLs0vmfCGm7L95RBAgbySi5
         Kg4EEgppr0hbq1T3Zhc7AOL6Tgh2GHvWYqsb7dcRB+FouKvx0Twar5S4GxNmZbfTRG
         Gt2kUB6bcAfWtFP6hCq2gvu8V/H+fvpuBjJ8dxnyOMse9WIkMwYFMPXKbOkExSVPBQ
         TaEsRU8VaEgSorXyGofCgd0lakGGQYtrAcyof9HXUWj6j+DChqJUV43SVWrcDl13vF
         VXM75IbseVEE9danBltA1OPFBaxHwgWPuJELnLnmTSEN72ZBlrQNQ3Iw+oJL8qbv2S
         wRDFXRABn56akHvNDIpN/wg1c70r30x8ySAqNSRMokqAWH1IU4m+fqkHQiJdo46MKk
         9snXBFN2o5WwZkjZeLWZNMV8=
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 99F6E40E01A3;
        Fri, 15 Sep 2023 11:56:24 +0000 (UTC)
Date:   Fri, 15 Sep 2023 13:56:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Elliott Mitchell <ehem+xen@m5p.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        smita.koralahallichannabasappa@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, rric@kernel.org,
        james.morse@arm.com
Subject: Re: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Message-ID: <20230915115631.GAZQRGb0vCmEnUcaZI@fat_crate.local>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
 <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
 <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
 <ZQM8jRx8uKEbEo00@mattapan.m5p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQM8jRx8uKEbEo00@mattapan.m5p.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:02:05AM -0700, Elliott Mitchell wrote:
> Indeed.  At what point is the lack of information and response long
> enough to simply commit a revert due to those lacks?

At no point.

> Even with the commit message having been rewritten and the link to:
> https://lkml.kernel.org/r/20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com
> added, this still reads as roughly:
> 
> "A hypothetical bug on a hypothetivisor"

If "Hypervisors likely do not expose the SMCA feature to the guest"
doesn't explain to you what the problem is this commit is fixing, then
I can't help you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
