Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059F679D97E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbjILTYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjILTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:24:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5C199;
        Tue, 12 Sep 2023 12:24:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF55C433C8;
        Tue, 12 Sep 2023 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546646;
        bh=bSeMPRZdOhqkBgklu+WQU2Wv24CUcxj6J17hMG5Lse0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=PuI6NTqXJU1+0eeCQYHD6rSEuEYw4ZnM7mBwYquu/sX0RvZH+Jhs7y9VRQkXhAbyL
         xBvBsyU+FexIyvaMBqcQoJ6f+2C0zRl+2rA+gk/kPp2QYtl/oQ3HuUV2k1eTYpyz7p
         G+fwu6SXNVSexF23NKb+yri94kKCM6DLC2PUHoRXBgfOrC3CrFJHRyQGLM+M5kSsXT
         /w27UER/0O/7DX9XtgOxXptOnlh3oq3lui/4zirGGH/q0WXC035zHXSPWzoeabA0nM
         wyMWxvI5fFipZfe1Csmf3y2PeV2dOS0fC1lm5wCCfIVauFamAMBjbOUEwEecN1jxny
         VVALdgkrEmIlA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 22:24:02 +0300
Message-Id: <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
Cc:     <kexec@lists.infradead.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <dhowells@redhat.com>, <vgoyal@redhat.com>,
        <keyrings@vger.kernel.org>, <akpm@linux-foundation.org>,
        "Baoquan He" <bhe@redhat.com>, <bhelgaas@google.com>,
        <lennart@poettering.net>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
In-Reply-To: <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 9:56 PM EEST, Jan Hendrik Farr wrote:
> > What sort of bottleneck does the EFI stub have so that we need yet
> > another envelope?
>
> Well I can come up with a few advantages of UKI compared to normal bzImag=
e with builtin initrd and cmdline.
>
> 1. You already identified this one. Using addons to adjust your cmdline

It is not a benefit as this is already possible today.

> 2. I can use my normal initramfs generation tooling. Just install my
> compiled kernel, my distros install script will generate the
> initramfs. Then I package it up as a UKI. This will be a lot more
> awkward with a builtin initrd.
> 3. Measured boot. You can place PCR signatures in the UKI using
> systemd-measure. This will sign the expected PCR values for booting
> this UKI. I think with normal bzImage this will be a lot more
> difficult. If you place those PCR signatures in the builtin initrd
> this will change the kernel image which means now the values you
> signed no longer match (depending on how you measure the kernel; I
> don't think the normal EFI stub even measures the kernel in first
> place, but I could be mistaken about this)
> 4. UKIs are automatically recognized by systemd-boot

These are sort of "tautological" arguments. There must be some
objective reasons why this architecture was chosen instead of
other (i.e. using what already pre-exists).

BR, Jarkko
