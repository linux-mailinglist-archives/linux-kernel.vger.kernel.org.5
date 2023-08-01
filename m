Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D076B6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjHAOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjHAOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:05:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716EA2D53
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:04:47 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B72C1EC0103;
        Tue,  1 Aug 2023 16:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690898685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=juIp35RiH9NQiodR0EdliR9AkE0fF2qv8RGF7Xi4sAo=;
        b=R8zj4hcrJcUnpCVe9T/jZSx0Ey+2NPD9UtkycYO5l1azjAnJ1jBSREhNTIZPHXNRpQju62
        Mv+uADbabqGO64JlPkOFYLSrl21/BdMN2BZe0GRvDMkhCD+85OrDd73jlt2DRDiXsdakyX
        FrkWmAq5x97lkvJ+17+Wt2yAqT4h4zM=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1gotIvzro19N; Tue,  1 Aug 2023 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690898681; bh=juIp35RiH9NQiodR0EdliR9AkE0fF2qv8RGF7Xi4sAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjGP1euTyO3u8WOktoHpl4J811ZsNFjxBXLQcz7ybzyLT6xjNxOQfPfL6IKAA2VnT
         0h/fmE4ITBlYRmuwS2Ryw1bk4YrKtu2FGfWZuK+qG3ioqfoDQpX6o+IhIAbDFL6nsY
         c9ZnKEFRimDHCsmoBFbL2hCSZyM4Jabvsr3zY8fTME2BYUAihLj26ElGz0aAV2R+xq
         jzfJvwnQ6eICNUR1RBBFMwpuGxSczuzxcYPG3lUrDtrEH3QVBXvsrWOLaqTsCoz20+
         +PL2ZQjvi5I/YTEMKwD6184dCHPSzSrXy0jPpFeVVe9uZ2EXnEBJIzWm7u5MMpuw6L
         dOHKB++fwEl88PlEb8slFPDIc8S8JTJuwm/S4UiNMNlsqgHq/BwDaJGWhJVI8neZa4
         j4/ozzbHY8HEXjz3INIB6CaGC5a6vncEx6HjqbbV6/RWYPJbqRW+gbIU3tBhZPI6o7
         jqeaM8OeY0eWUTC9adUHltXI3cTRIZpNiZYB+TUp+Q6uNRSpqTbypN8QlXj+3RyB6q
         qisW2K00AHbywQRbWcqxaaBJFXQTce1My8oI36+2rx3EvW/0yo+bwx1k9Zi7q9z/JV
         8CB6n864B2sR4sRWgJjwDleokd9h8TQeeUIa1HmWSFpklJpxwK6VDPdGCyelu4OrVD
         oIRNZqK47HWIKkM9C769ii08=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2842F40E01CE;
        Tue,  1 Aug 2023 14:04:38 +0000 (UTC)
Date:   Tue, 1 Aug 2023 16:04:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: arch/x86/kernel/cpu/amd.c:1289:6: error: no previous prototype
 for 'amd_check_microcode'
Message-ID: <20230801140433.GIZMkQ8TwvLcCue5x6@fat_crate.local>
References: <202308012053.HaahUjPR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202308012053.HaahUjPR-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 08:44:41PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> commit: 522b1d69219d8f083173819fde04f994aa051a98 x86/cpu/amd: Add a Zenbleed fix
> date:   2 weeks ago
> config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20230801/202308012053.HaahUjPR-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230801/202308012053.HaahUjPR-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308012053.HaahUjPR-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/x86/kernel/cpu/amd.c:1289:6: error: no previous prototype for 'amd_check_microcode' [-Werror=missing-prototypes]
>     1289 | void amd_check_microcode(void)
>          |      ^~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

https://lore.kernel.org/r/20230725121751.2007665-1-arnd@kernel.org

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
