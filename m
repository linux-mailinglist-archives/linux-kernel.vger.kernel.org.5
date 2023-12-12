Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6F80F1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbjLLQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjLLQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:07:37 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF39A;
        Tue, 12 Dec 2023 08:07:44 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3FEAB40E00CB;
        Tue, 12 Dec 2023 16:07:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2m3sbeLmrXGA; Tue, 12 Dec 2023 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702397260; bh=rgF4Bgt2FHI1I0QLn6tARPDHJomiCukB+MTc8kUTHCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byJ8D8FsTyNpvxUZjs4ALFLRufhgmqjViMKCOkAEp3MN2VbLsxqMvEycxTSFi1Qjh
         SkaVPhWr7Beyu2L9Kv2+JsLa7fyowipiGd79zvxWi320JYgncpS1pDIpR+Y0+DSd1y
         6cX0tkbSN4GV4PPTuxWkwc598pqxiMOwdTinIjdYhJ36/sp5POHv7JZfWBJ9Sa+dSZ
         PBshqXXLOAxZli6UqaWf9pjCDnpd/T5GZcsGMaUlcU+jeeoR5h9u6OHNGrOzSQ6J71
         jreQSHBTNVo1dHM4FCQjyPlI6tccI9W/zRQTk1hu7SNHQwlanmmbnsg5kbYcZaJ3+e
         sqY2Jx5fBWadZYw1ADwRY7HIDNOhnY6TFpNkddDboUy+MhQwNWTNEnIiQvEchD7MP+
         G2pXbS3CJmI4FUPoc89jO0pGfZZHuisLSIuu5KoK+2uY8XO3qfiqGXE+rkCGef8yBv
         hh7Ex7YTQ+0qHGLSVKppVL19jbd/DJg4QtOnMvzzxLDs3NtlWIVNyflVJ+q/hLbbJX
         g+HjTI+Vt4ZxF9d1i4Bbn2VRtIBcFllKQK9pcUQyUzjqveVTjKO5encLCludSGFwIu
         TXF9keHxu7l3dMniCyTPs9TJEyiIJlmytsoi6C4rONXNnu9xsknmjV8sshrLmx1lfo
         5J+R73fjrQliO4AY5dzotRPQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 050FD40E00CC;
        Tue, 12 Dec 2023 16:07:30 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:07:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231212160725.GFZXiFPSeoGwmRenpq@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231212132907.GJZXhgIyss9eT1MsNb@fat_crate.local>
 <a3305a97-4936-4cfd-b706-10b7792acdad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3305a97-4936-4cfd-b706-10b7792acdad@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 09:33:44AM -0500, Yazen Ghannam wrote:
> That's mostly how it was in the previous revision. Should I go back to that
> then?

Yes please. We should avoid doing homegrown stuff and use the kernel
facilities which are already there.

> Okay, can do. This can drop the assert_*() helpers like the comments above.

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
