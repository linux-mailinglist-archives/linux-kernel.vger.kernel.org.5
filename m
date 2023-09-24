Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695967AC6E7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjIXG6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIXG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:58:46 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE9CA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 23:58:40 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8939540E01A4;
        Sun, 24 Sep 2023 06:58:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OIZG3CxY3QiH; Sun, 24 Sep 2023 06:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695538715; bh=JQx2a5DCpRZ2mUcfhKMyhmVFtYnUgvB8/O8a2tP77BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgD1K8jLwlN+H0WQB7p8pQyKUiKaz9Agog6/AEVUYdoc6wvDZk2OpkCfcv7hYMwJZ
         GByLsiGZyBnujjRSrq2ElOdJHvS7FRVWk9Ta9JCm/csE8XvPzV3/DneprzIzaD6mVI
         QEbpsDBOoWOsaFVSbsyIbO88nLvgoXd3AFMLvyl8mGpBUl2WMAEWZy8sK5kifExdhu
         fFbqessk3GVGt6ic+Ub4rUzR8eUrvdXgEYCV6XCArUmGgNXsvh6X71diF8aedbG7CT
         I+DagfIL6wwVnLXYf/WJiKw1HMCrqx62GKH2sX3w/8kN0FiujkWVr/4wsBr/+1b7OO
         8UMsXFTdTkq4vTdCn3u/cR3dLQRm6SRLIPAcquL5QtxnTGmu/4fBk5AMbEBCheiNP6
         bOj1K0rLALiqbRv3NHX9tQFEXvlgn1nV3ISLNcP0St0P2Sl6YR5idq4XM8t3iq1wNK
         /NrrN82yj8FJCV/mBnFhMpj2HYJ1g0ya+vBX05RZk0mDbmHitiZP50fJHPlVOcxviT
         wSjjWE++G7QqtT2SEkmIyW6ZwYwNPVu7YjqDIp4KVVwctmrthT8jXNB4EaAGHmn1v7
         SC+WJNYlnoYL386hjjCV5Beg8mYF09fvPgIKyXQySb6WJfRU4nGV0Mgf8EuCOIUip+
         XAU7Hcz3jqUPxOA5+gjNvPPo=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C459040E01A2;
        Sun, 24 Sep 2023 06:58:29 +0000 (UTC)
Date:   Sun, 24 Sep 2023 08:58:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 23/30] x86/microcode: Provide new control functions
Message-ID: <20230924065824.GNZQ/eEKAO8IaCcUJU@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.202675936@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.202675936@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:20AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The current all in one code is unreadable and really not suited for adding
> future features like uniform loading with package or system scope.
> 
> Provide a set of new control functions which split the handling of the
> primary and secondary CPUs. These will replace the current rendevouz all in

rendezvous

In the comments below too.

> one function in the next step. This is intentionally a separate change
> because diff makes an complete unreadable mess otherwise.
> 
> So the flow separates the primary and the secondary CPUs into their own
> functions, which use the control field in the per CPU ucode_ctrl struct.
> 
>    primary()			secondary()
>     wait_for_all()		 wait_for_all()
>     apply_ucode()		 wait_for_release()
>     release()			 apply_ucode()
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/cpu/microcode/core.c |   86 +++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> ---
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -357,6 +357,92 @@ static bool wait_for_cpus(atomic_t *cnt)
>  	return false;
>  }
>  
> +static bool wait_for_ctrl(void)
> +{
> +	unsigned int timeout;
> +
> +	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
> +		if (this_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
> +			return true;
> +		udelay(1);
> +		if (!(timeout % 1000))
> +			touch_nmi_watchdog();
> +	}
> +	return false;
> +}
> +
> +static __maybe_unused void ucode_load_secondary(unsigned int cpu)

s/ucode_//

ucode_load_primary() too.

> +{
> +	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
> +	enum ucode_state ret;
> +
> +	/* Initial rendevouz to ensure that all CPUs have arrived */
> +	if (!wait_for_cpus(&late_cpus_in)) {
> +		pr_err_once("Microcode load: %d CPUs timed out\n",

Make that look like "microcode: Late loading: ..."

And I think we should use "Late loading" or similar prefix for all those
operations here so that it is easily greppable in the logs.

> +			    atomic_read(&late_cpus_in) - 1);
> +		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
> +		return;
> +	}
> +
> +	/*
> +	 * Wait for primary threads to complete. If one of them hangs due
> +	 * to the update, there is no way out. This is non-recoverable
> +	 * because the CPU might hold locks or resources and confuse the
> +	 * scheduler, watchdogs etc. There is no way to safely evacuate the
> +	 * machine.
> +	 */
> +	if (!wait_for_ctrl())
> +		panic("Microcode load: Primary CPU %d timed out\n", ctrl_cpu);
> +
> +	/*
> +	 * If the primary succeeded then invoke the apply() callback,
> +	 * otherwise copy the state from the primary thread.
> +	 */
> +	if (this_cpu_read(ucode_ctrl.ctrl) == SCTRL_APPLY)
> +		ret = microcode_ops->apply_microcode(cpu);
> +	else
> +		ret = per_cpu(ucode_ctrl.result, ctrl_cpu);
> +
> +	this_cpu_write(ucode_ctrl.result, ret);
> +	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
> +}
> +
> +static __maybe_unused void ucode_load_primary(unsigned int cpu)
> +{
> +	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
> +	enum sibling_ctrl ctrl;
> +	enum ucode_state ret;
> +	unsigned int sibling;
> +
> +	/* Initial rendevouz to ensure that all CPUs have arrived */
> +	if (!wait_for_cpus(&late_cpus_in)) {
> +		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
> +		pr_err_once("Microcode load: %d CPUs timed out\n",
> +			    atomic_read(&late_cpus_in) - 1);
> +		return;
> +	}
> +
> +	ret = microcode_ops->apply_microcode(cpu);
> +	this_cpu_write(ucode_ctrl.result, ret);
> +	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);

Do that update...

> +
> +	/*
> +	 * If the update was successful, let the siblings run the apply()
> +	 * callback. If not, tell them it's done. This also covers the
> +	 * case where the CPU has uniform loading at package or system
> +	 * scope implemented but does not advertise it.
> +	 */
> +	if (ret == UCODE_UPDATED || ret == UCODE_OK)
> +		ctrl = SCTRL_APPLY;
> +	else
> +		ctrl = SCTRL_DONE;

... here, after having checked ret.

> +
> +	for_each_cpu(sibling, secondaries) {
> +		if (sibling != cpu)
> +			per_cpu(ucode_ctrl.ctrl, sibling) = ctrl;
> +	}
> +}
> +
>  static int ucode_load_cpus_stopped(void *unused)
>  {
>  	int cpu = smp_processor_id();
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
