Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A927AB104
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjIVLiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjIVLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:38:15 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31274FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:38:09 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C01640E01A1;
        Fri, 22 Sep 2023 11:38:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SRsyE2Cjq-7Y; Fri, 22 Sep 2023 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695382684; bh=AQm9yEr8BqT/+PpZ1JkB7PoF3iVB8b0Q+lcbIZC+9I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsoL/Xd3aXEytaiM5hbYYyQxAwky4c3qr5n8GYtd3Jnj8GkdfQw2lDlSvdryi+vXZ
         7ALrIttDSEXdaXag70Hg8xxRygRRtjwccwVA1rnDXZbBurTBKzBBpHBehLM5/8VD2d
         UCR3SRVFm18lEMZJLEFOpSGrtLAZ8F48uSumXYkIDs4WkAPtq/K+xZ4jVf4eW39AAj
         A0BRXlGSCsxUI9oC7Hii1sXC4VyAYwUAcrmv67sVGiFyEUIJduv+8gnTjuTW8iG2S/
         RZE5mI8HICPK96x16WGBi8IiBDl1VulVn764iDQNu57OkfpB9f/d2/MDP9aF+F79zQ
         Hse5CkVG8s7+WE1FfCI0y80lSKQr0QidWEUFEggH9fLSFxR5FsHIm1h4H0OmaqqFiG
         R0Ol1F5DLhygZrRrgXoHllfXAcyNz6PeTHbNsnw3kSHGfiK3VZCvW/9CNb1teJFieY
         2urbThpswRMCRAOq7Vz/2ZWLWrrtfETQPGKEC8CBpokM/gxeXsi2AmmZk1Et9B1Lbr
         /HvcsAh8KM42JgYKS0ntLfX719JlEOlidpUSyMWM9HHHHbKny6FzJ46jBme6Qn9E7U
         DKGjLxM0sMaYGMA2WJWYyDA7+zC7slzolZVecKp6vcEIKMWXfMj8wAX6LzU3TiAXqe
         0ALgfsCP507ZTb29hq+Ne7ok=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F5B040E0176;
        Fri, 22 Sep 2023 11:37:59 +0000 (UTC)
Date:   Fri, 22 Sep 2023 13:37:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/cpu: Clear SVM feature if disabled by BIOS
Message-ID: <20230922113754.GEZQ18kuTDSB8W8epS@fat_crate.local>
References: <20230921114940.957141-1-pbonzini@redhat.com>
 <169537583818.27769.18320521458994415527.tip-bot2@tip-bot2>
 <ZQ1rwSJsO7A4HR8O@gmail.com>
 <CABgObfbiO5Jm-S_1TVi-NdO4GxMsJeagaEHYEFBJ_6ABFdhicg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfbiO5Jm-S_1TVi-NdO4GxMsJeagaEHYEFBJ_6ABFdhicg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 01:18:09PM +0200, Paolo Bonzini wrote:
> AMD and Hygon pretend that they are different, and use different families
> for what is effectively the same processor, and that's silly.

Not entirely true. Off and on they come with enablement which is close
but then a bit different and it is either ifdeffery or do their own
functions.  For simplicity, we've done "do their own functions" as we
cannot test the common code on Hygon.

> ... because honestly who even thinks of Hygon...

There's that too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
