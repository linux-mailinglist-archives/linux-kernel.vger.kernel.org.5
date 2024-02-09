Return-Path: <linux-kernel+bounces-59560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE384F8E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174021F27117
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D7762E0;
	Fri,  9 Feb 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="il7iGCQt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275D745ED;
	Fri,  9 Feb 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493914; cv=none; b=KvsVv4gn/3sOVM/OF+I26m4N5E6vbA0gX0kodu6mXqtoup6D0GuiJtSWGwCmVAtAG4VPsFM94jDIpvn2AdyC3SQX9KNpYFUEiRR6K6ktJBie/dRWQBw2zvqCPVAA8I8k7hn01NRnzddvSZXkYEIn44e8McSUSqAJ4tp2fLNLTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493914; c=relaxed/simple;
	bh=KgpW4VY9CZqDo149P1qi0JCQnE48b3bQgzOYgHCZBME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPCMiX7zUlLzuIX6n/KHwckmv0wtpZU3N0rrWirxT7MHDnVwOMY3CVHLpmp4IZmzqzWbb5offJ47IyphgYlykd+bJsX1VIC1uCcywzzsr4KMQ34XDf3TVdP0XwHFhVXKRR5mXCcwE7XGz4IHzaP76VBiCNK/0BVOVjq2X+6fb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=il7iGCQt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 37D7740E01A9;
	Fri,  9 Feb 2024 15:51:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nkuBbCb5PlRd; Fri,  9 Feb 2024 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707493900; bh=4nFYw4TYmMoF9MsLkbg5jSVxGnaMvAye6HsLrHO4ya8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=il7iGCQttaGs8WKU16jbSFw4EuijBKP7R6qYt6vwe7pSpqPUYwks1l7a2qTqESigV
	 x1Uner775xxRAOpGnXwP3kNMMnD7y89ase9C1XoLNem4c7w/AdLS/oouPTdZteS3Za
	 bo1rq89Qy7Zsra7f1+KBzFAZOhNh5sJTl4Xy4r7t2uVS+f3PamatGL7d6bFDXeauqQ
	 iI0lMblqqZhMo35cjHZNIE0QszNzmk5ejk+TQtUDhzNf/4J/T1xkdJ2ro8LSxgFb3X
	 dhFNxhRc7/B5SlDwQQxqg4NFEaaPoG+lcwccdlPt69PZRBPl9SoubJsdteJaGizIGG
	 0PNGs+1oET4UyXGUjg+aOc3bqACWMZfzhAiYymn7xWIsB2wMiTjEjlXP83cFiBljNi
	 bDigYN4MlML/IYr4DiJzrJCAAXxnKMvq5JCoL1LaUQZSlPvwoo0fRngpZuKZbwdXl6
	 qD7WWGQg+Bw06WKxv9gnc7Q3fjiTixInSyHRhjZv8kOtC5bXWlpUrhGFLmON19EreF
	 9DCLt1SlA84zbMD92Sg42GQnvyr6ofZ8FIlb6B3f83lo+J9xLWcG74RgaKHY03a97v
	 snll6RtaVaxteb7Ib3SVeC2Ab4/bmSz0Nfy23qp3y/vd6bnVuzmKfErBpcam5oxNhO
	 Feg/ayjyRTMy8zSnVSerzAjk=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC60F40E01F7;
	Fri,  9 Feb 2024 15:51:27 +0000 (UTC)
Date: Fri, 9 Feb 2024 16:51:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Message-ID: <20240209155119.GAZcZJ92bTnwwO8l6Z@fat_crate.local>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.local>
 <BL1PR12MB514409256AE93E5D13556F90F7442@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL1PR12MB514409256AE93E5D13556F90F7442@BL1PR12MB5144.namprd12.prod.outlook.com>

On Thu, Feb 08, 2024 at 11:09:47PM +0000, Deucher, Alexander wrote:
> Why?

Because we have those rules, you know. You should send about once a week,
unless you've reworked your set fundamentally.

Otherwise maintainers mailboxes would be a serious mess. Not that
they're already such now...

> In this case, there have been a number of review comments which have
> been addressed in the new revisions of the patch set.  Why delay the
> new revisions?

See above.

And see below for the "whopping" differences between the last two.

> You'll ultimately get the same amount of email just with a much longer
> latency.

No, you'll have a lot less email. You send the set, sit tight and
collect review feedback, work it in and send again after a week or so.

diff v5..v6 - definitely not resend one day later just to pick up tags.
-----------
--- v5_20240207_perry_yuan_amd_pstate_fixes_and_enhancements.mbx	2024-02-09 16:43:29.487104935 +0100
+++ v6_20240208_perry_yuan_amd_pstate_fixes_and_enhancements.mbx	2024-02-09 16:42:55.671303380 +0100
@@ -23,6 +23,7 @@ Reported-by: Gino Badouri <badouri.g@gma
 Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218171
 Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory")
 Signed-off-by: Perry Yuan <perry.yuan@amd.com>
+Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
 ---
  arch/x86/kernel/acpi/cppc.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
@@ -293,6 +294,7 @@ Above message is not clear enough to ver
 
 Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
 Signed-off-by: Perry Yuan <perry.yuan@amd.com>
+Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
 ---
  drivers/acpi/cppc_acpi.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)
@@ -342,8 +344,9 @@ $ cat /sys/devices/system/cpu/cpu0/acpi_
 $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
 0
 
-Signed-off-by: Perry Yuan <perry.yuan@amd.com>
 Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
+Signed-off-by: Perry Yuan <perry.yuan@amd.com>
+Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
 ---
  drivers/cpufreq/amd-pstate.c | 57 ++++++++++++++++++++++++++++++++++--
  include/linux/amd-pstate.h   |  6 ++++


diff v4..v5 - *definitely* *not* warranting a new resend on the next
day!
-----------
--- v4_20240206_perry_yuan_amd_pstate_fixes_and_enhancements.mbx	2024-02-09 16:43:53.922961536 +0100
+++ v5_20240207_perry_yuan_amd_pstate_fixes_and_enhancements.mbx	2024-02-09 16:43:29.487104935 +0100
@@ -343,13 +343,14 @@ $ cat /sys/devices/system/cpu/cpu0/acpi_
 0
 
 Signed-off-by: Perry Yuan <perry.yuan@amd.com>
+Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
 ---
- drivers/cpufreq/amd-pstate.c | 59 ++++++++++++++++++++++++++++++++++--
+ drivers/cpufreq/amd-pstate.c | 57 ++++++++++++++++++++++++++++++++++--
  include/linux/amd-pstate.h   |  6 ++++
- 2 files changed, 63 insertions(+), 2 deletions(-)
+ 2 files changed, 61 insertions(+), 2 deletions(-)
 
 diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
-index 77effc3caf6c..874d8b663790 100644
+index 77effc3caf6c..ff4727c22dce 100644
 --- a/drivers/cpufreq/amd-pstate.c
 +++ b/drivers/cpufreq/amd-pstate.c
 @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
@@ -372,18 +373,16 @@ index 77effc3caf6c..874d8b663790 100644
 +static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 +{
 +	/**
-+	 * match the broken bios for family 17h, model 31h processor
++	 * match the broken bios for family 17h processor support CPPC V2
 +	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
 +	 * definition in ACPI tables
 +	 */
-+	if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model == 0x31 &&
-+			boot_cpu_has(X86_FEATURE_ZEN2)) {
++	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
 +		quirks = dmi->driver_data;
-+		pr_info("hardware type %s found\n", dmi->ident);
++		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
 +		return 1;
 +	}
 +
-+
 +	return 0;
 +}
 +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

