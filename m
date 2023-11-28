Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABD87FC410
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376305AbjK1TMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbjK1TMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:12:32 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA031988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:12:38 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BFE7B40E01A5;
        Tue, 28 Nov 2023 19:12:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DOsTME6jvWU0; Tue, 28 Nov 2023 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701198751; bh=S1yFySh0fGHIs/7UN//rzspDxtpRP6EaFnY0h1+BSNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaRE+7JfwCF+PVjYAq1ES04OkDsU4YIV/20aXXYOkck+SGBMWQiJw/aqriEGlIeO5
         mTdUQMCCNgTbrICti24Vd4Uyc8da8NqJyrFeiHnH3ajQJtvx5lA7bEF+LRvNr5F4Ko
         QSBEeKHeItGPoh6ABadpIWAse0OKba5ZsPgeFCKKG7d8Am32vQPm0e3Q7QDANDoRNW
         1NGt69cYH61wJ9jZ571aXkMtLcEhOqqCf7aBPzxqTJdFEsqbMC3C9jaIoYs9pG6sAJ
         xQZc822h9irM0+4af4KJnF/ckqW/J/OyzdTDV6IeHc/Fw3R+1TU3SJTb/Dwr1vMW1P
         NxZqYzGF1cVa7uatUaPCfmrGo0mIPKaxVXkgLFcYJF0gM9K/5Vl2MvW7DvdOwjudAX
         wGkLDI4anAOKRsI3foxBO2bC8LJSlg5Bjzxlyoqg3Bf1amxIQjMwWh6rtZMYa3wJok
         ZSmR2fL++peudeaN6IIDq33FCFkR5hrvaQmvB006YdrakJPy/GcuQHtUoZ0Ep3srV0
         hc3ApB4G6GIGARXhs5BmfAtjclfGkRdCt45oXadBXbLj2swb4UYCpbdkh38Mriw5RX
         2PaODXezDzd7aCdj6ivtE4WsIdQbef9Eo0BhnxNvExcnjxQiEBPhBj3QPL3YwcIP6u
         LIISpzGwhUmh+kUe9TeJTgG4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D723840E014B;
        Tue, 28 Nov 2023 19:12:23 +0000 (UTC)
Date:   Tue, 28 Nov 2023 20:12:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Update power flags
Message-ID: <20231128191217.GDZWY7kYC9bE9Qkg25@fat_crate.local>
References: <20231128-powerflags-v1-1-87e8fe020a3d@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128-powerflags-v1-1-87e8fe020a3d@weissschuh.net>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 07:54:54PM +0100, Thomas Wei=C3=9Fschuh wrote:
> As described on page 99 of
> "Processing Programming Reference (PPR) for AMD Family 19h Model 61h, R=
evision B1 Processor".
> (AMD Documentation Hub Document 56713)
>=20
> Tested on an "AMD Ryzen 7 7840U w/ Radeon  780M Graphics".
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  arch/x86/kernel/cpu/powerflags.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/powerflags.c b/arch/x86/kernel/cpu/pow=
erflags.c
> index fd6ec2aa0303..0c98405aeae2 100644
> --- a/arch/x86/kernel/cpu/powerflags.c
> +++ b/arch/x86/kernel/cpu/powerflags.c
> @@ -21,4 +21,7 @@ const char *const x86_power_flags[32] =3D {
>  	"eff_freq_ro", /* Readonly aperf/mperf */
>  	"proc_feedback", /* processor feedback interface */
>  	"acc_power", /* accumulated power mechanism */
> +	"connected_standby", /* connected standby */
> +	"rapl", /* running average power limit */
> +	"fast_cppc", /* fast collaborative processor performance control */

No need.

The beginning of Documentation/arch/x86/cpuinfo.rst tries to explain
why.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
