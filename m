Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E877C250
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjHNVTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjHNVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:19:25 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A121E77
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:19:24 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3A6DC40E0195;
        Mon, 14 Aug 2023 21:19:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dvptk4UKOvm6; Mon, 14 Aug 2023 21:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692047960; bh=THtstVOo3mX6y84XOLZR9gE12XPJ4h+X2+3I5OcNURo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYWXVzWwhsBkhrHJudL2JO0xYb/EyMN8dbs/WuafDvRciXD2dEVgYf3jsNJYDHBg4
         rTDlcqhpeoBn5P9SHMce2vwwEKy/CyOcMTxANj7+DzE1p3or/id5Px6ie3CeV0oSEX
         Uo1+RgCIJsmyraEBQIaYar8cJojM79a1orm9BUE7KEZy08kcfY12f1SEbEMpjVeVFR
         zAQboSvRk+7VGYixfY8rTpv6oHqHjSn2TiVhhOvbd1mOJXKW7hqe5tHfNQ3FxV1Hp8
         +yxG7KJSO8slFS/dApWs8xv58j9YBGaxa28I6YbWqvs16QasWy0iSBQuuZ5HzG60dA
         TwwPzu4Y/+2WEMnE1vYG1CUlohfb0lnJiQGQujLDdHdbxgzmLXnCDH+SjHkgrAVc5Q
         S9G7LWvcEaAwKr4jg+DwPAK2ETpWqX4ieUnpbJ0r5trja9JhF0X7KX8W/x7NDYgEKK
         E23SrPzjZIgFj0CeFJtRB8M8bNwqjpaKnOX4NLAGFv2ETBYfgR1KzLxsLTIxTvyHEi
         sdLAmonJxs+X5/xP6Ygdm9rdZbkaoDSIozk/KiTATUKd9ohT7tMPlqJgzT0VGQMlfR
         0oBzx/1h3N+x2e79DUTcooGZcHO8oPK8l37azdkOlSQcvUz6ZtofKz0gQf2JJhschF
         abDw6t8J5F0rZc7sJi6dkMj4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4539540E0140;
        Mon, 14 Aug 2023 21:19:13 +0000 (UTC)
Date:   Mon, 14 Aug 2023 23:19:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V2 02/37] x86/microcode: Hide the config knob
Message-ID: <20230814211912.GMZNqaUD6FriYo1wOo@fat_crate.local>
References: <20230812194003.682298127@linutronix.de>
 <20230812195727.660453052@linutronix.de>
 <ZNqWD2CKFfa0nSqS@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNqWD2CKFfa0nSqS@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:01:03PM -0700, Josh Triplett wrote:
> I'd be happy to help keep this case building. Would you consider
> accepting a patch atop this series re-introducing minimal support for
> disabling this?

And a couple more KBs of builtin code is a problem because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
