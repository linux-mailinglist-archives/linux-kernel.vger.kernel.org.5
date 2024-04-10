Return-Path: <linux-kernel+bounces-138827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C563089FACF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B69C1F271C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D3316F0C8;
	Wed, 10 Apr 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQfFcOP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE116EC1A;
	Wed, 10 Apr 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761046; cv=none; b=WPMm7YDFlVrfhF+9m84DOlpWVItduaYqpTj1Q9FHDK+r/NHVj55yatd8ojYomCEElrR/xgDafMUQJgw4tEbw5GnQB88CF9oxB+hPBlKKaJt3KekBkgKjEYcpcihK6L/fTPD2VqtGQtQ0aQpAwZWezWS/IjYhIKjXwsrGAt9wLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761046; c=relaxed/simple;
	bh=rgAigV0Mg7k37J0oxZCOZaSDtr64xfw5j/3UZIQubQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fibwHyOfu3E4lm1vY/itXkrCwozUA+3vDuBrZVvEy18DwppC5DjGxflrHyqyptk6YRtyMD2mBz9ZpUYI+xWEnu9nb6d50x0iF4s/26F53qoNog8JWDNAY4Z5nXFQ27/bq0uHGVsJGSLKYpZYm0ivIsAWcR2l5QbKoxT04QdIQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQfFcOP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78DAC433B1;
	Wed, 10 Apr 2024 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712761045;
	bh=rgAigV0Mg7k37J0oxZCOZaSDtr64xfw5j/3UZIQubQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQfFcOP+qX85PmQnBPLvccqEywoUWIxkynIP914BonF6qpPr0WgGNqLRbviZLfGPD
	 Bomu75zNlFrOE2Ke1UznjFkoNd9/pRLwGGHZlVwENl21OmBPEInkv8LqYfisZLOSpi
	 XpAVCdsAW8pZSBx5AqH9adPA41I3sfdmbW8uDodY5wPxmdoc/6MCsRnfqTMLsTEUGE
	 BKojfOFIlt2MvygHWzEUSXsdc6Ra7ZJRdThgiGOs+HFxFuaJ0/QalfSZXkTdF0ZDKJ
	 gCrg8Ipm35MwoNSCvH0ollDCHBWxYJEEzKHXZHZaFeQY52ZlWeDs1+G2PLnfmmrNSm
	 MUcRXbGTuWgKg==
Date: Wed, 10 Apr 2024 16:57:19 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com,
	vdonnefort@google.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <Zhaoz9E/sw6jVnci@lpieralisi>
References: <20240409151908.541589-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409151908.541589-1-sebastianene@google.com>

On Tue, Apr 09, 2024 at 03:19:08PM +0000, Sebastian Ene wrote:
> Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
> and copy the response message back to the host buffers. Save the
> returned FF-A version as we will need it later to interpret the response
> from the TEE.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 49 +++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 320f2eaa14a9..72fc365bc7a8 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -67,6 +67,7 @@ struct kvm_ffa_buffers {
>   */
>  static struct kvm_ffa_buffers hyp_buffers;
>  static struct kvm_ffa_buffers host_buffers;
> +static u32 ffa_version;
>  
>  static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
>  {
> @@ -640,6 +641,49 @@ static bool do_ffa_features(struct arm_smccc_res *res,
>  	return true;
>  }
>  
> +static void do_ffa_part_get(struct arm_smccc_res *res,
> +			    struct kvm_cpu_context *ctxt)
> +{
> +	DECLARE_REG(u32, uuid0, ctxt, 1);
> +	DECLARE_REG(u32, uuid1, ctxt, 2);
> +	DECLARE_REG(u32, uuid2, ctxt, 3);
> +	DECLARE_REG(u32, uuid3, ctxt, 4);
> +	DECLARE_REG(u32, flags, ctxt, 5);
> +	u32 off, count, sz, buf_sz;
> +
> +	hyp_spin_lock(&host_buffers.lock);
> +	if (!host_buffers.rx) {
> +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
> +		goto out_unlock;
> +	}
> +
> +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> +			  uuid2, uuid3, flags, 0, 0,
> +			  res);
> +
> +	if (res->a0 != FFA_SUCCESS)
> +		goto out_unlock;
> +
> +	count = res->a2;
> +	if (!count)
> +		goto out_unlock;
> +
> +	if (ffa_version > FFA_VERSION_1_0) {
> +		buf_sz = sz = res->a3;
> +		if (sz > sizeof(struct ffa_partition_info))
> +			buf_sz = sizeof(struct ffa_partition_info);

We are copying buf_sz but (correctly ?) returning res->a3 to the caller,
which is allowed to expect res->a3 bytes to be filled since that's what
firmware reported.

Technically this is not a problem at present, because the caller
(ie the FF-A driver) and the hypervisor rely on the same descriptor
structures (and buf_sz can't be != sizeof(struct ffa_partition_info),
anything else is a bug as we stand); they must be kept in sync though as
the firmware version changes (*if* there are changes in the partition
descriptor - eg fields are added).

An option would consist in just copying res->a3 bytes as firmware reports
(obviously keeping the RX buffer boundary checks for the memcpy).

It is just a heads-up because I noticed it, no more, I will let Sudeep
comment on this since he knows better.

Lorenzo

> +	} else {
> +		/* FFA_VERSION_1_0 lacks the size in the response */
> +		buf_sz = sz = 8;
> +	}
> +
> +	WARN_ON((count - 1) * sz + buf_sz > PAGE_SIZE);
> +	for (off = 0; off < count * sz; off += sz)
> +		memcpy(host_buffers.rx + off, hyp_buffers.rx + off, buf_sz);
> +out_unlock:
> +	hyp_spin_unlock(&host_buffers.lock);
> +}
> +
>  bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>  {
>  	struct arm_smccc_res res;
> @@ -686,6 +730,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>  	case FFA_MEM_FRAG_TX:
>  		do_ffa_mem_frag_tx(&res, host_ctxt);
>  		goto out_handled;
> +	case FFA_PARTITION_INFO_GET:
> +		do_ffa_part_get(&res, host_ctxt);
> +		break;
>  	}
>  
>  	if (ffa_call_supported(func_id))
> @@ -726,6 +773,8 @@ int hyp_ffa_init(void *pages)
>  	if (FFA_MAJOR_VERSION(res.a0) != 1)
>  		return -EOPNOTSUPP;
>  
> +	ffa_version = res.a0;
> +
>  	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
>  	if (res.a0 != FFA_SUCCESS)
>  		return -EOPNOTSUPP;
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

