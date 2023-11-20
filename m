Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E077F0E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjKTJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjKTJJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:09:07 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E988AA;
        Mon, 20 Nov 2023 01:09:03 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D20540E0191;
        Mon, 20 Nov 2023 09:09:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NIZxxt3lKTWI; Mon, 20 Nov 2023 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700471340; bh=1PeZhKr9FNO+V97mL9x/+VpJfeePD/XPT8/+rHdaj3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnLufiubUKKmAmitL3/r/UjPfjPAN0+KObrW+hWDYQQ6Qfu4pIsXXIU6dZ6S2BMFn
         jzFJIq6kqIa9/QPT9KcVqMH9b7o30Jje30LWzBl26JNM/1s2a//5yZ9rGy138k7k9H
         rP3PvvXUwH3YkgtX91fgywjuc+UaqcRgX22O3aIgNmxMYxNg/qiC3By+sMg2hYojwS
         IKW0UZt1YZD3O0Q2hvXfsnHCoevv6m48Pcq1q5gADkVSRlVbVQg7SPp3c6/E4TfOLZ
         HThyhkBGieWH8Ugpd/AkUO+2+XTmTpw9ny5mIspUmSGz9isgIelzufcyNyqWfy1GBT
         Req3VC61pg18LHuTJCvSLaQ1JdOo5trC1jMqV9HU29QfkWrxwYwsBXAzvXwMHT+4I9
         +YE/pAjTGTuO1HBWkOTKWCQ57AHImYkQPWcKf9RPSlIBmempislgKqMydqqIM/cld7
         yVNcNZxgd4ffHEX1tWg0kln9jQJrabZ4zGgUndEMpIP5X3tcfxL98Id5XU5DT+hcoG
         OYbPDCby8j0C0WqHRN9a7jb1yZZ1QpCIwlBVik2DMwhe88/Y3VaVLZV4jHFeHhzoYE
         DUaEYm68EYwA1Gc9EX5sWg7J0xlNCq8JG0Q+PT/fBX2bTcicyn2NUBartPsPQqNCzX
         QOanwVRKr2Rv7AmzBEz4rQ5U=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCB9640E0030;
        Mon, 20 Nov 2023 09:08:51 +0000 (UTC)
Date:   Mon, 20 Nov 2023 10:08:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] EDAC: altera: Use device_get_match_data()
Message-ID: <20231120090846.GBZVsiHstd6fCuFaQy@fat_crate.local>
References: <20231115210201.3743564-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115210201.3743564-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 03:02:01PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/edac/altera_edac.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
