Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8424980F123
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377009AbjLLPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376877AbjLLPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:35:03 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140499;
        Tue, 12 Dec 2023 07:35:09 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9EAC640E0140;
        Tue, 12 Dec 2023 15:35:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 74Dc3dqhTvcG; Tue, 12 Dec 2023 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702395305; bh=9QGhZY9+7O9YTsSYlvi3ocDvFlyATMCASTBnz/vsMVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdupUiRGq12eZfmgRPqkqa3/deZCHK268zcWoDrTagkD5eIO9AaO6l/BV+n6r9oZM
         bl8MTuNipcr6pF2BDw5m2S51z+YASJNvjCNlalaB1sO3b3UKeCW/gU4iBqHtxVO6Ws
         eSCXLR3ntDvAsvQtQV8nhfyCZs/O9wIW47Yq4Jg4wfvO5uevUzw1asZBwjCKiEvy/B
         5HYxpRcpgOnbgSiEY6KwFgVD3l3QI7i8x35fodln0AuH4H2Ug+XR7DzGub+M3Q/fOd
         B21+04LIJsqyhfvD3V8zUzq7NKJJmVeU7XSLmLcaL6hn4ZCQep+K0O1XgUuKl6tfTE
         X+eSXbi2BMvfHEdp5rApRg4LNE33ZaXzR4yW0gS4SbY8F19dhhQZh/EUc8rgQ5wYsS
         TYCwQ4saJQXTv60E+8oGxpggMSEInI1s63o/dgUJ9SfWe+kUX30kODET7WZblZvmXG
         dOXRgx0ZwvFl1tnJFJ/4deR0Z3bWWNxMq1QSunhpS6NkC5J966msnz/8rE+dwnA8eI
         y8ProDrvkrBN7bb9xDST0CNwi76gRJ0m+8UUfCnxdTd8p3rQe/sN0nsbDON7h0N8Ho
         RfiiI2X0W7hihoRyP4e8ofsOqgw+QIM2pw/zKq06oufzUiCE4SLOMcwl3XWRTCijfq
         cNJue1SuZpod1I564fyiWFjU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5243E40E00CC;
        Tue, 12 Dec 2023 15:34:56 +0000 (UTC)
Date:   Tue, 12 Dec 2023 16:34:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231212153449.GEZXh9mSJ5epD13Dp7@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
 <295f3cc9-6140-4813-b107-8c8b60f8aaa1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <295f3cc9-6140-4813-b107-8c8b60f8aaa1@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 09:23:44AM -0500, Yazen Ghannam wrote:
> I'm thinking that the warning only happens if the "assert" condition above
> is hit.

assert usually means "assert - abort the program if assertion is false"
- from assert(3).

> In older revisions, I had all these messages as "debug" loglevel. I don't
> think there's anything a user can do to fix these issues. They're either
> coding bugs in the library or system configuration.
> 
> I'd rather go back to the debug messages if you don't mind. It's not
> difficult to enable dynamic debug messages compared to DEBUG Kconfig
> options. So I think it'd be okay to work with users on this if they
> encounter an issue.

Makes sense.

> > > +static const struct x86_cpu_id amd_atl_cpuids[] = {
> > > +	X86_MATCH_FEATURE(X86_FEATURE_SMCA, NULL),
> > 
> > I'd expect for only this one to be needed, but not those below.
> > 
> 
> Me too. Those below are to workaround a current module loading issue. I'll
> add a code comment for that.

You mean the systemdoofus crap?

Fget it - we don't fix the kernel because luserspace is nuts.

> 
> > > +	X86_MATCH_FEATURE(X86_FEATURE_ZEN, NULL),

...and those are influx - this is called X86_FEATURE_ZEN1 now and
X86_FEATURE_ZEN is set on all Zens. So you might as well match on
X86_FEATURE_ZEN only.

But you should not need it - if SMCA doesn't match then we have another
problem. ATL should load on SMCA systems only.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
