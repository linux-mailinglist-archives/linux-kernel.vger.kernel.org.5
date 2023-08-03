Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26A576EB14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjHCNqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjHCNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:46:30 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73671211E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:45:06 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AD30A40E00B3;
        Thu,  3 Aug 2023 13:37:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6XU9kDetqqwI; Thu,  3 Aug 2023 13:37:28 +0000 (UTC)
Received: by mail.alien8.de (SuperMail on ZX Spectrum 128k, from userid 117)
        id A20DE40E01CA; Thu,  3 Aug 2023 13:37:22 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B8F8640E00B1;
        Thu,  3 Aug 2023 10:05:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OMFkjFNzcHVe; Thu,  3 Aug 2023 10:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691057104; bh=UjxnnKxI+pBYWgMX9Yia362F5TLE0tiia0W5oe2xJ8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+P7D1prh92bMbqls54TkuJvdqaKTQayUqmtAENTUxvV7f3PZhkHAG1juZkRpfjYZ
         3G+FrrkNZjyjg1GydFdpf+gILgLtAtgDLgaMIy88m+WwMM5r7HwHgEAV6OdqvpHKLG
         zT/1LZC9RKhf//mhlhr9v58tB19gA6Rk+7kfwRyRu2wBEP+kvOMb7S6QzYLpWNriQR
         NC6E+yL+jI0psjlUPAuSEo5LV2u1czuNC71DymJT/AVhn218kWYJNDLKQgnXkAgSzi
         4wmobWnu9e42eZEVvSV/LtxVvWPg8VYXx8q2ahRmqWdU2CpobRL9wD11kTCPT87/PP
         DIheMpu/7dpg/MZqCHwCpIjLo0nk9gmIFVp53AJULrSKh2ke6wuwhSfGGokymHJYj2
         JdPSHuNZaxwGPilCliFOiv0jwHS9oy4r1PfJd7mAC79uVO15f971YiqnigKiA/kpHB
         2vGxQlbiG/n/145jKOkNhnXok07Ztbh5QZpUu4o91hBHlEY+cndibbDtJD5Ottd4/6
         A+jdNLYQweeEjjadZ6Jgx6JrUFKcXLi+sDPq3S8u3r32oorchJ4mdRxUtlvibucfQK
         OcWweDVB6GKYHIxjrzEOeoHmFycMbFVEYaCWwFuUxwxAduPZz0GvAqY6l51hRiJ0H+
         n6Wabt0MEXn0AwXzW/BpYItY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04DDF40E00B0;
        Thu,  3 Aug 2023 10:04:56 +0000 (UTC)
Date:   Thu, 3 Aug 2023 12:04:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/7] x86: remaining -Wmissing-prototype warning fixes
Message-ID: <20230803100456.GDZMt7yEGbtbdDxezx@fat_crate.local>
References: <20230803082619.1369127-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803082619.1369127-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:26:12AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is almost the same as before, and should let us turn
> on -Wmissing-prototypes by default. I'm still unsure whether
> we need to do this per architecture as some other ones still
> produce a lot of warnings, or we just enabled it for everyone
> and let arch maintainers deal with it now that the major

Yeah, might wanna ask them first.

I definitely want this finally enabled so that we can finally put this
one to rest.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
