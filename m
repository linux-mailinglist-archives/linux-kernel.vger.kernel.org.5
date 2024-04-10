Return-Path: <linux-kernel+bounces-138240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E641089EE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158951C203F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C95159560;
	Wed, 10 Apr 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNLUDLxp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F75156C69
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740536; cv=none; b=h7QL8cuIyCQ1j2ANlpj0RLcS7sZGAx84XeM9jgqMGfPlHysaBgO0AlzPcoZYWgWJW8rMgluo+YXaoOW8Kqb6g4vGJLdav+KQ+AoREQy1XR2iNbTresly3X9zuWxhIGKYmZAs7po+D8UJRII127nzratGYczXrfN2SYO/ZreDV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740536; c=relaxed/simple;
	bh=8IGEkHVnTFNiTPePBcBdEHImxzk/mvEc8vQlWHZ3o24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvw2DQ69XGx3ZzmV1p+YikbC9ZcfBZWxYoZjD6XvOQ7VUTirc9flJLRsHFRBjA9dFhFTWQU/C8ZRD7qxKMeVL4YDLR/Pb4MUNAXy8DeFMvL/jPzwvcsfx3C9HnOGzZ6Li1tOMyTqshaM/VZAlImcGmepFkQ6aEG4MD+r6xO1WK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNLUDLxp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so52125e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712740533; x=1713345333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mo5yUXNBd3ZqPlawfQyQwNue5di0stprqcnUautikic=;
        b=YNLUDLxpPtvrnB3+HKa6wtXy83+XZ/DM3/xCpwKmQnU9Css7mgjnoc3f9tGx0UJ7EM
         SZYPgOX3lBjA1kVakkWf29eas2tHRcuwe1sPnTzEHEnHaTFP3FfqIUDfhT9gXK2xnI+w
         lt7jxX0QuJP1AiyqK7Er8lBLlUliPtMKhKgUs4Y1evVcTm+z3gxfnrmv3/KybGZ69HLh
         l2F/8zBH5KA2LZiGv23yGmm3DSOEiQsFus757zcSyUyG72bXTLkVdq2oHf0DokLhLSDp
         Q49tbR2gkRQRjQcREAaS3UxZaYAV5t59X6wczsbCZ6ghKOeVi8fctt3Pu4cI/vZK+Ff5
         YEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740533; x=1713345333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo5yUXNBd3ZqPlawfQyQwNue5di0stprqcnUautikic=;
        b=NwKJ78sLfDdUc2IGUv667buvd+n4/PgKWWakpCIFWyTill3N9b1NWf3GYCp9hK0ljW
         q/0cqPl5GysuiTlf2vy+3u9b00Gr6SKdmQAHGAMjIPh0BGh3xQjksLXXDkgeImeaFQqE
         yHuVTMVAyQk7kHbBszWdkOyA1/F1haxOtSDEf/1yZgi2kvmatjiCZ5S+EBBIxLoDg+V8
         JFau5yL2J6QkcRkIRL5FbBNUcCr1DYwXEOEtTcskbjJ4tpV1SP4Q0RQkg3G6cIJS7Y3X
         lcJSvrPTTc7WuyMH2wSIlSuK+QzR4oMVYx/YGnKuKD57tAdvJnnQMqdSKolIUcq7E5Vt
         sbSg==
X-Forwarded-Encrypted: i=1; AJvYcCV9BA89+o2Gj9f77VQP74z2CVgpZD4VP7ugQ87HXTj517Cg2cttLqbXbRqc9EYXfTjHa6H9aFncQLYf00T9spBr+++astAJzCPFlvrz
X-Gm-Message-State: AOJu0YzETrzMtggfeOfhIg4zhBJZeSbVWKogqIFebkRsn09epiLl43UF
	YovpLCPljv+XKyhsa7Zxf0eoFTmAryCLVPj9bSWXfx/YMkbx0LRQ7hslJUuLyQ==
X-Google-Smtp-Source: AGHT+IEBtQIBTBIKC8UbwL32JAPKT7O7PWWE97mAxwT/AQp+UyPWzOdg2/EhifcyhKX5pP1qVudzgw==
X-Received: by 2002:a05:600c:5113:b0:414:daa3:c192 with SMTP id o19-20020a05600c511300b00414daa3c192mr161451wms.0.1712740532752;
        Wed, 10 Apr 2024 02:15:32 -0700 (PDT)
Received: from google.com (248.199.140.34.bc.googleusercontent.com. [34.140.199.248])
        by smtp.gmail.com with ESMTPSA id di3-20020a0560000ac300b00341c7129e28sm13315653wrb.91.2024.04.10.02.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:15:32 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:15:30 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <ZhZYsuqggl_Hzv8X@google.com>
References: <20240409151908.541589-1-sebastianene@google.com>
 <ZhVpmF2js1NJp1qF@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhVpmF2js1NJp1qF@google.com>

On Tue, Apr 09, 2024 at 05:15:20PM +0100, Vincent Donnefort wrote:
> Hi Seb,
> 
> On Tue, Apr 09, 2024 at 03:19:08PM +0000, Sebastian Ene wrote:
> > Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
> > and copy the response message back to the host buffers. Save the
> > returned FF-A version as we will need it later to interpret the response
> > from the TEE.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 49 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 320f2eaa14a9..72fc365bc7a8 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -67,6 +67,7 @@ struct kvm_ffa_buffers {
> >   */
> >  static struct kvm_ffa_buffers hyp_buffers;
> >  static struct kvm_ffa_buffers host_buffers;
> > +static u32 ffa_version;
> >  
> >  static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
> >  {
> > @@ -640,6 +641,49 @@ static bool do_ffa_features(struct arm_smccc_res *res,
> >  	return true;
> >  }
> >  
> > +static void do_ffa_part_get(struct arm_smccc_res *res,
> > +			    struct kvm_cpu_context *ctxt)
> > +{
> > +	DECLARE_REG(u32, uuid0, ctxt, 1);
> > +	DECLARE_REG(u32, uuid1, ctxt, 2);
> > +	DECLARE_REG(u32, uuid2, ctxt, 3);
> > +	DECLARE_REG(u32, uuid3, ctxt, 4);
> > +	DECLARE_REG(u32, flags, ctxt, 5);
> > +	u32 off, count, sz, buf_sz;
> > +
> > +	hyp_spin_lock(&host_buffers.lock);
> > +	if (!host_buffers.rx) {
> > +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
> > +		goto out_unlock;
> > +	}
> > +
> > +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> > +			  uuid2, uuid3, flags, 0, 0,
> > +			  res);
> > +
> > +	if (res->a0 != FFA_SUCCESS)
> > +		goto out_unlock;
> > +
> > +	count = res->a2;
> > +	if (!count)
> > +		goto out_unlock;
> 
> Looking at the table 13.34, it seems what's in "count" depends on the flag.
> Shouldn't we check its value, and only memcpy into the host buffers if the flag
> is 0?
> 

When the flag is `1` the count referes to the number of partitions
deployed. In both cases we have to copy something unless count == 0.

> > +
> > +	if (ffa_version > FFA_VERSION_1_0) {
> > +		buf_sz = sz = res->a3;
> > +		if (sz > sizeof(struct ffa_partition_info))
> > +			buf_sz = sizeof(struct ffa_partition_info);
> 
> What are you trying to protect against here? We have to trust EL3 anyway, (as
> other functions do).
> 
> The WARN() could be kept though to make sure we won't overflow our buffer. But
> it could be transformed into an error? FFA_RET_ABORTED?
> 
>

I think we can keep it as a WARN_ON because it is not expected to have
a return code of FFA_SUCCESS but the buffer to be overflown. The TEE is
expected to return NO_MEMORY in w2 if the results cannot fit in the RX
buffer.

Thanks,
Seb

> > +	} else {
> > +		/* FFA_VERSION_1_0 lacks the size in the response */
> > +		buf_sz = sz = 8;
> > +	}
> > +
> > +	WARN_ON((count - 1) * sz + buf_sz > PAGE_SIZE);
> > +	for (off = 0; off < count * sz; off += sz)
> > +		memcpy(host_buffers.rx + off, hyp_buffers.rx + off, buf_sz);
> > +out_unlock:
> > +	hyp_spin_unlock(&host_buffers.lock);
> > +}
> > +
> >  bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
> >  {
> >  	struct arm_smccc_res res;
> > @@ -686,6 +730,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
> >  	case FFA_MEM_FRAG_TX:
> >  		do_ffa_mem_frag_tx(&res, host_ctxt);
> >  		goto out_handled;
> > +	case FFA_PARTITION_INFO_GET:
> > +		do_ffa_part_get(&res, host_ctxt);
> > +		break;
> >  	}
> >  
> >  	if (ffa_call_supported(func_id))
> > @@ -726,6 +773,8 @@ int hyp_ffa_init(void *pages)
> >  	if (FFA_MAJOR_VERSION(res.a0) != 1)
> >  		return -EOPNOTSUPP;
> >  
> > +	ffa_version = res.a0;
> > +
> >  	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
> >  	if (res.a0 != FFA_SUCCESS)
> >  		return -EOPNOTSUPP;
> > -- 
> > 2.44.0.478.gd926399ef9-goog
> > 

