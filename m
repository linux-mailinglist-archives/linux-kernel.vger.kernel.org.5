Return-Path: <linux-kernel+bounces-81496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DB98676B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41D3288540
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13771292C0;
	Mon, 26 Feb 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVeP1i/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6BF1BC43;
	Mon, 26 Feb 2024 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954532; cv=none; b=Vb9whDmSr81yTxnHA9kzAm58fnXzlj2lUA3Df/vu1UlanwW+vqZnWhfep+GAjK1fyyFSMizF9PDU7MLA6qlN2im8McK8o7LJUF/D3pFFaOkmzxjxtA1TF0j6VmI/NmQ+tvRebVnZuOx4ipn9hIG4IcATpagS75H9xLK1i1ZSEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954532; c=relaxed/simple;
	bh=XS1neCkWPoPljIEQbwRt980RilF+BhhhXaZaIXAH2fA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qzi0Ton7VpFf7Nls4LXz3Flu78eyPqt392ElbTDo6w/gfm7xHOeBvt591OopQ0qspL1oQa30JW4+ZuMNUD7t5xkqRd5kAaiFKSPw45kn9OvcMkij9tMzbIE8d4HV6ZoBMsno9geDCNcIkuFL2QiS1Q3Yb0zhi4EaizH7MS1/ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVeP1i/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F62C433C7;
	Mon, 26 Feb 2024 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954532;
	bh=XS1neCkWPoPljIEQbwRt980RilF+BhhhXaZaIXAH2fA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VVeP1i/l/3ad5qyNtST/friOyK4IhqPqSnJUeVqVY51RimcikAIC0+2syENeKG3g8
	 ihYyvoHKQCh2JvT1o4WhL8eBsQYqK6OdgKvWpjMiM80saLjtVlrc91oezM8q+T95TR
	 8BHgVS2IYkA1IuuV0+QlIA4jwyFr5z1T1v3P2A5/vSwuz973NHPnJSO/R6E+UEQibG
	 Ho4RmhbEQ1bn6LGDRzptQ+iQhn4xhW+Fi0uS4dhg2tFv9cVD+wjaqYpV0pTa3WKgLL
	 WMRSIPATUD6E+IDCdLpXCEVD50XMZ5whrryDreyyil7w22YOSAuAjFGnm9nUJ0BjCN
	 ZnF5RdRPDwbNA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1reb8j-006sTv-BW;
	Mon, 26 Feb 2024 13:35:29 +0000
Date: Mon, 26 Feb 2024 13:35:28 +0000
Message-ID: <86edcz2vrz.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/8] arm64: KVM: Add iflag for FEAT_TRF
In-Reply-To: <20240226113044.228403-6-james.clark@arm.com>
References: <20240226113044.228403-1-james.clark@arm.com>
	<20240226113044.228403-6-james.clark@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.clark@arm.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, suzuki.poulose@arm.com, acme@kernel.org, oliver.upton@linux.dev, broonie@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, miguel.luis@oracle.com, joey.gouly@arm.com, ardb@kernel.org, qperret@google.com, javierm@redhat.com, mark.rutland@arm.com, arnd@arndb.de, vdonnefort@google.com, ryan.roberts@arm.com, tabba@google.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 26 Feb 2024 11:30:33 +0000,
James Clark <james.clark@arm.com> wrote:
> 
> Add an extra iflag to signify if the TRFCR register is accessible.

That's not what this flag means: it indicates whether TRFCR needs to
be saved. At lease that's what the name suggests.

> Because TRBE requires FEAT_TRF, DEBUG_STATE_SAVE_TRBE still has the same
> behavior even though it's only set when FEAT_TRF is present.

This sentence seems completely out of context, because you didn't
explain that you were making TRBE *conditional* on TRF being
implemented, as per the architecture requirements.

> 
> The following holes are left in struct kvm_vcpu_arch, but there aren't
> enough other 8 bit fields to rearrange it to leave any hole smaller than
> 7 bytes:
> 
>   u8                         cflags;               /*  2292     1 */
>   /* XXX 1 byte hole, try to pack */
>   u16                        iflags;               /*  2294     2 */
>   u8                         sflags;               /*  2296     1 */
>   bool                       pause;                /*  2297     1 */
>   /* XXX 6 bytes hole, try to pack */

I don't think that's particularly useful in a commit message, but more
relevant to the cover letter. However, see below.

> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  4 +++-
>  arch/arm64/kvm/debug.c            | 24 ++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 21c57b812569..85b5477bd1b4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -569,7 +569,7 @@ struct kvm_vcpu_arch {
>  	u8 cflags;
>  
>  	/* Input flags to the hypervisor code, potentially cleared after use */
> -	u8 iflags;
> +	u16 iflags;
>  
>  	/* State flags for kernel bookkeeping, unused by the hypervisor code */
>  	u8 sflags;
> @@ -779,6 +779,8 @@ struct kvm_vcpu_arch {
>  #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
>  /* vcpu running in HYP context */
>  #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
> +/* Save trace filter controls */
> +#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))

I'd rather you cherry-pick [1] and avoid expanding the iflags.

[1] https://lore.kernel.org/r/20240226100601.2379693-4-maz@kernel.org

Now, I think the whole SPE/TRBE/TRCR flag management should be
improved, see below.

>
>  /* SVE enabled for host EL0 */
>  #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index ce8886122ed3..49a13e72ddd2 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -332,14 +332,30 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>  	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
>  		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>  
> -	/* Check if we have TRBE implemented and available at the host */
> -	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
> -	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
> -		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
> +	/*
> +	 * Set SAVE_TRFCR flag if FEAT_TRF (TraceFilt) exists. This flag
> +	 * signifies that the exclude_host/exclude_guest settings of any active
> +	 * host Perf session on a core running a VCPU can be written into
> +	 * TRFCR_EL1 on guest switch.
> +	 */
> +	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT)) {
> +		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);

Can we avoid doing this unconditionally? It only makes sense to save
the trace crud if it is going to be changed, right?

> +		/*
> +		 * Check if we have TRBE implemented and available at the host.
> +		 * If it's in use at the time of guest switch then trace will
> +		 * need to be completely disabled. The architecture mandates
> +		 * FEAT_TRF with TRBE, so we only need to check for TRBE after
> +		 * TRF.
> +		 */
> +		if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
> +		    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
> +			vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
> +	}
>  }
>  
>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>  {
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>  	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
> +	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
>  }

Dealing with flags that are strongly coupled in a disjoined way a
pretty bad idea. Look at the generated code, and realise we flip the
preempt flag on each access.

Can we do better? You bet. The vcpu_{set,clear}_flags infrastructure
is capable of dealing with multiple flags at once, as demonstrated by
the way we deal with exception encoding.

Something like:

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index addf79ba8fa0..3e50e535fdd4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -885,6 +885,10 @@ struct kvm_vcpu_arch {
 #define DEBUG_STATE_SAVE_SPE	__vcpu_single_flag(iflags, BIT(5))
 /* Save TRBE context if active  */
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
+/* Save Trace Filter Controls  */
+#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(7))
+/* Global debug mask */
+#define DEBUG_STATE_SAVE_MASK	__vcpu_single_flag(iflags, GENMASK(7, 5))
 
 /* SVE enabled for host EL0 */
 #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb00a..f9b197a00582 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -339,6 +339,6 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 {
-	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
-	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	if (!has_vhe())
+	    vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_MASK);
 }

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

