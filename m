Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8407BE706
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377310AbjJIQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376588AbjJIQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:54:26 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814A92;
        Mon,  9 Oct 2023 09:54:25 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 41F8340E01AA;
        Mon,  9 Oct 2023 16:54:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Eg-mIj4-9Y-F; Mon,  9 Oct 2023 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696870461; bh=8/VIaB2dsUmSUa5umukeymyvERJHKFx4z55N2OwnzdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrPrMyP2D5AGbbxKJZ8TqX/VIZcIlbiKRxHCmGOdDauTEqRdAWobkmpt5TCV9Ot6M
         RlegexBi2QP+gl4N8QQQ/CgbHx5jP8yCq4rn+ihvuC8JUi51q56HPmCkFjTFtjFJ97
         XOONr5AzjLwd7ILeuzEH9Hjr72J42698oO3qJBdo3mGU2Fj7wJ1+oM7vEhBTDB5vS+
         ADzfMpPX/ozYyezMAQACjjtgCcw/sw4wx9Ni1JeBySMoFuXtll0Nhd/JYsyT6/RWE5
         fPKMpQC3B8pV4sq8JPbY7dZ2+P6NWBK85i9l7zDxztloAwciVTJXHt01WAZu4QI8yP
         cpW40gJgFZ29yqbIpWUDyutFK3RdTJdImbWYvwDnRwoiOt2M65RB+33YH4UltUcdER
         DC3xitTaGwcxA0G5SHh5rRQ4AEm1HJFKI4RRtQ0OoPgaBa32YbgmfG9Y9WMBjMU/HF
         J6qRy5yNTUC4EKZT6NVdaxz6VWg6cEwUZ8oj/iPwYCcNytRhG3z36UlMjeWN938Drm
         UwLuyu2LaQikRuZ5h2+YxScBs51cEsICatQJq72b2rtZuuiwwLbXodX0ij9UYV6F2K
         VThQtcLXMRFAUekmKB5X0tmLsK/LqXWi/09sqE7CcF41yDJeI3uK7zoy4TTLYAAHDy
         1iHPm1PkwVW3tKJfB65pnrSk=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5447640E0187;
        Mon,  9 Oct 2023 16:54:09 +0000 (UTC)
Date:   Mon, 9 Oct 2023 18:54:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, corbet@lwn.net, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v4 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Message-ID: <20231009165403.GCZSQwKwjGifBIQTpq@fat_crate.local>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <533ccc1b-7566-444e-8549-184fd272f666@intel.com>
 <20231009124033.GBZSP0wcAT494wHWqG@fat_crate.local>
 <0587b6f5-51d7-4d5a-9114-6c836b12f6f9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0587b6f5-51d7-4d5a-9114-6c836b12f6f9@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 08:32:07AM -0700, Reinette Chatre wrote:
> This is just a term I made up for when a series is deemed ready to be 
> considered for inclusion by x86 maintainer team.

Aha. :-)

> I believe that Babu's series is ready for inclusion and can be merged first.
> It is at:
> https://lore.kernel.org/lkml/20231003235430.1231238-1-babu.moger@amd.com/

Ok, lemme look at it.

> Maciej is already planning to send a new version of this series and can
> rebase on top of Babu's work at that time.

Ok, you'll get the tip-bot notifications and then you'll know when and
ontop of what branch to rebase.
 
> Thank you very much.

Thanks too!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
