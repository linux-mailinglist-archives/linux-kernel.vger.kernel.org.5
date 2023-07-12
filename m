Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA6475116D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjGLTmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:42:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B6E1989
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:42:28 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 245CA1EC06A9;
        Wed, 12 Jul 2023 21:42:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689190947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MqG9ghzNC1L1Rt66JyPet71PESTc6oNMjVZeBIyo1Pk=;
        b=UvrZuWtinVHKGmPGQfm/+hpAsPvdT4zy2Bklrnpbjt8rO6IP/hVR+R/EUJguPmrOyvBaEi
        cYujG9TYNxK2jw4TsPTmZ+ZXucm1vjKmP1pJxr3bK6WOTn0u6tXxkj1TU1XNeq0LlFSMwi
        +LOrzDEJdj5qxxDqxuK3Aah5zqx2zbk=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XIjqmpvKzZxU; Wed, 12 Jul 2023 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689190944; bh=MqG9ghzNC1L1Rt66JyPet71PESTc6oNMjVZeBIyo1Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eO1RdkWKAydo7z+EfExIXDOZNDN2knbljM4Z3e27vbcfmD1zRY1rUbn7UBwW5KYnf
         NuajpBE5k4UV6k3m0t1qkygOyzMbLvhLbCI0lWoNPUDUgbCiRe57t0ry0OdDWszkKd
         Z0RlBKOdq9mQlGC9IdxGBFSPXjaNGqeBfkq1IaosBR5WrU32f75P2wK32iglA4jNfK
         E0plgWlMx7jtIz2HAclYarsoMQtY7kDO7KRLXcIPVUnVrUyiZKJ0nJbFb24IV5koay
         uOGyqTVhvB8Kg2WX2ixRP17gQXvIlwKLmP76Fl9wLEvu0ClHfuWTz4cOy6AKjOLYw7
         p5zFoL+Ml9pqqF/i82krZnMaGb+p9XOLx9+ishGOTnrCQrQ/aapK87L4jLMHNNQOyu
         pDM9vetTROijDxIeWGuQaphiaiD9L5gjY5hjBO83ldF9M/EphAp16EdWPV2YnW+nTW
         v+VvlU6gJwM4AVdxaCeuC6DNz44bHJUTfPHC1eFTVvNkxUZt/LJyNVMcovdsjVNhPh
         lV9jQVM517uOQdsybx0g4ZeCvPlO6OjwiM6seOUaLxy8VJ5ox1lLy8oFHJrX2zkjnY
         rNVA9dCAAfdVnyAqA/TsqDRXpZb0Bj6zF/r++rw6bWqjSTA+4GBIUsChdpWVO4m1qY
         nv6cToorVeDl07a5GL7alryE=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05F6340E0034;
        Wed, 12 Jul 2023 19:42:07 +0000 (UTC)
Date:   Wed, 12 Jul 2023 21:42:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <20230712194202.GNZK8CCj4yacgFMgfB@fat_crate.local>
References: <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
 <ZK6hLZcuAH9jXKuL@redhat.com>
 <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com>
 <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh>
 <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh>
 <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:35:14PM +0100, Luca Boccassi wrote:
> No, all will not be fine, because stable branches exist, so it would
> not be _one_ kernel version but N, with monotonically increasing
> values of N. That doesn't work, and the reason for that are explained
> in the protocol documentation that was linked in the initial mail.

Lemme give Peter's example from earlier today:

Bugfix A -> number 2
Bugfix B -> number 3

Tree backports only Bugfix B. Which number do you use?

And so on and so on. 

Patch your own trees - this doesn't belong upstream.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
