Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18E777855
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjHJMap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjHJMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:30:43 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 05:30:42 PDT
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BA81B4;
        Thu, 10 Aug 2023 05:30:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 68D1B40E0140;
        Thu, 10 Aug 2023 12:23:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XdxG51TOhWJ6; Thu, 10 Aug 2023 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691670186; bh=sxlOpm3tyscnmVpjnj81p/XnNYwJIE085156LxuZ3NY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+NkGEi9csIUpEqRCe1925nuoX17pjhzTWny7oM37Y1+dhDYDoMHiwIhhNxhwip2u
         uAZGF53CkN1mfskcDNHA+0lIDqKP9P9OT2K2YE0bQkrtkHmtOFyPUDkd4D86jr1Wkk
         IwVoVXCf1zdYIgwnHaCWD3CkIPJfjYGzS3PDh9n5Aw5HXk0KzNSwphUo1IWdG+w62s
         z3ZId9RetOJEG7cMKXOdgtRxTSaOF9U9Nuds8DWpbN6uDRaCvgZ9+l5iC8Rgj2USAH
         YlWll5Hd7A0HcEKXJv8o1Mb5WJ8vZHoIfJ7+L65m7me7+X5XgE0PyZhzHVMR4LG1Nu
         8vnwX6yKeT0GLotf2x2sv2aSawV97en7kzdbEen2jiQ61oCYtCVqbCSJjk8A8y7fSg
         vAVf+sY9QPB+3z5XUh83Sq604EC4en2gshIaCZkF31LVBEs8QslLh/6alVFNFB6Bcl
         r8OYpvvtRKFM0UkOLqrd95hL6FWB/MK4CtAebP3b7GkywvOSXYKJvfr6vdzqTYz0Pm
         QTrs0Jn+GvgqsxEftgTAwVW/0Ykz8N6DQQu6ed1264UPbPVW/aL3W77xeE8ieMVis0
         fi3u9HS1ZfpAA+3l9h53JmVBVmuAxhN515z9SDbkixzt9i1vOVpd10CC2BrL2R/rmi
         /4hNWUKjaVdb7tAHk+trvpM0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 706BE40E0185;
        Thu, 10 Aug 2023 12:22:57 +0000 (UTC)
Date:   Thu, 10 Aug 2023 14:22:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Avadhut Naik <avadhut.naik@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        yazen.ghannam@amd.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH v2 1/3] x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based
 models
Message-ID: <20230810122252.GHZNTWnBcBquML7or9@fat_crate.local>
References: <20230809035244.2722455-1-avadhut.naik@amd.com>
 <20230809035244.2722455-2-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809035244.2722455-2-avadhut.naik@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:52:42PM -0500, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> Add new PCI Device IDs, required to support AMD's new Family 1Ah-based
> models 00h-1Fh, 20h and 40h-4Fh.
> 
> Since, models 40h-4Fh and model 20h share some design aspects, the PCI
> IDs defined in this patch for model 20h are shared by models 40h-4Fh.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
