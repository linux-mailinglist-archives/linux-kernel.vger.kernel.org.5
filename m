Return-Path: <linux-kernel+bounces-94793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F787454D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6558B288789
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772264A1E;
	Thu,  7 Mar 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNbd3WtW"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141B1879
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772565; cv=none; b=PrpkIjnfOyD1IYjwPCptHQQZePE+Luv3Qu8tfOt1zfUoBbpaMhAj0EZeg+zBERzPoLcKzNVCt8k50kH0/marIKiEjUAhOItpPNr+oNUHw8yMUkRzLej614L47fDJsNxDjfU7vD7zI+f3DpFsz7saWGcKmbQQjyUHUv5bGRqPg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772565; c=relaxed/simple;
	bh=ZXHeEF1Tuz439WtPB8jKFh9bcbueJkjxcw5I0qWXpQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DetrTZEifPwpx475tLolPe+1pUH9W+cMRNh8PTmqeoarCJ631B0q/jpHXYYOGWHCUnKHczRQZ9DpP0eUZIJgBCk1Sfz+TIw5Y8sgNmuM7ZMvW56e7jxvWkqvzRbgK5gHzPKpkIOUTOAKXhy7XdkFFWOHYP/Ho4PjqZFR9oOeGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNbd3WtW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so276711a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709772564; x=1710377364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjPGiwQvnTtLunk5gRoXOklrJz8rTHIOs7mBmB6Z+/U=;
        b=fNbd3WtW9o3bkeGiMwDVTcfnuQO9U5YxjMMq15FxUPUADLMpxBk3ots+V6p8pV6iDN
         htTRSklxXQ/H0qXFl2MQIHJ97VuFvnKXj9lPXD2nhp00J01c1d7MJIBqt/TeaAULqUxW
         Gi61ZWsfXtxheC92v2DzFGB1avuYq61/1oNU8AYGc1sbr47iDRP/dNdGP+Cro0cdTAtS
         KPcZalOX5sYrqIXtRIxXp62q5J/WJfyhOfm49xusDDoQZ2r3TwhtpznqgOGMnoUAWIWm
         NytRm1PmWBC3THRl7LR0W8QU9GkGBMAlzyeikJ2Tx2D+aqA+gSkpzi9/7cgagKQYM7l7
         F3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709772564; x=1710377364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjPGiwQvnTtLunk5gRoXOklrJz8rTHIOs7mBmB6Z+/U=;
        b=i4J4QOZKxuEG3wtt/c+ansbYuqzAiiV9imQL1UJNL5tEm9HEyTVBBuXrt00cGk4gfY
         RU+cRnNgSA4/SCeKAZ8bPvoFkAHgHw9gTIKhSzywq22hAJ3BaBpPmH/PqtmPu10oIe9X
         ncuuy2CGK/Wc23Gionfq8lgzgCvJMSs6hRYlfgRMXoeoeqo2BB3pPTM2KZAQW8IHDCiE
         qpLW0VJPJcjUN618+yXlo9gK8wvTYQ4Y1PujlBw2bpvDUJmDyTPMMwg8E/z9JdZ58WqZ
         cSkSwM+683fT1B/qi20Ul6KfTsVnO5dWQqqLUpgR7DkuYUdWP1TWiMl827f085PQx9+Q
         CwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYhLQMv3SPDdC5j4HxhlYWh/ZI5RUfEF2n4I4t/AbctojvMqwJH7I5GHyRJJE8DQidQtHiif568YW15RQd2nY4jlVuDJ2DNVZeqcMX
X-Gm-Message-State: AOJu0YzgcOh57gHAhuvjWhpXBA+LwwRcc2XGa9OTsxPblL1+5m/8s6qz
	L2FPB3OAgRDz+yNyKSwslYXKfk49oC2e6Fxto7cVx1K7pszNSmtGMwILVM9YNw==
X-Google-Smtp-Source: AGHT+IGQtxeEYtT1tmzduqmZR9FFf73CQ0GVzIsakv/s4eVcBNahugTQqSN97AIf6yHqpcaURdAsCg==
X-Received: by 2002:a05:6a20:2d26:b0:1a1:4c48:5ca0 with SMTP id g38-20020a056a202d2600b001a14c485ca0mr8020815pzl.42.1709772563591;
        Wed, 06 Mar 2024 16:49:23 -0800 (PST)
Received: from google.com (61.139.125.34.bc.googleusercontent.com. [34.125.139.61])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b001db2ff16acasm13102369plh.128.2024.03.06.16.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:49:22 -0800 (PST)
Date: Wed, 6 Mar 2024 16:49:19 -0800
From: David Matlack <dmatlack@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Federico Parola <federico.parola@polito.it>
Subject: Re: [RFC PATCH 2/8] KVM: Add KVM_MAP_MEMORY vcpu ioctl to
 pre-populate guest memory
Message-ID: <ZekPD_L7vam2W-CJ@google.com>
References: <cover.1709288671.git.isaku.yamahata@intel.com>
 <012b59708114ba121735769de94756fa5af3204d.1709288671.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012b59708114ba121735769de94756fa5af3204d.1709288671.git.isaku.yamahata@intel.com>

On 2024-03-01 09:28 AM, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d1fd9cb5d037..d77c9b79d76b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> +static int kvm_vcpu_map_memory(struct kvm_vcpu *vcpu,
> +			       struct kvm_memory_mapping *mapping)
> +{
> +	bool added = false;
> +	int idx, r = 0;
> +
> +	if (mapping->flags & ~(KVM_MEMORY_MAPPING_FLAG_WRITE |
> +			       KVM_MEMORY_MAPPING_FLAG_EXEC |
> +			       KVM_MEMORY_MAPPING_FLAG_USER |
> +			       KVM_MEMORY_MAPPING_FLAG_PRIVATE))
> +		return -EINVAL;
> +	if ((mapping->flags & KVM_MEMORY_MAPPING_FLAG_PRIVATE) &&
> +	    !kvm_arch_has_private_mem(vcpu->kvm))
> +		return -EINVAL;
> +
> +	/* Sanity check */
> +	if (!IS_ALIGNED(mapping->source, PAGE_SIZE) ||
> +	    !mapping->nr_pages ||
> +	    mapping->base_gfn + mapping->nr_pages <= mapping->base_gfn)
> +		return -EINVAL;
> +
> +	vcpu_load(vcpu);
> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	r = kvm_arch_vcpu_pre_map_memory(vcpu);
> +	if (r)
> +		return r;
> +
> +	while (mapping->nr_pages) {
> +		if (signal_pending(current)) {
> +			r = -ERESTARTSYS;
> +			break;
> +		}
> +
> +		if (need_resched())

nit: Is need_resched() superfluous when calling cond_resched()?

> +			cond_resched();
> +
> +		r = kvm_arch_vcpu_map_memory(vcpu, mapping);
> +		if (r)
> +			break;
> +
> +		added = true;
> +	}
> +
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	vcpu_put(vcpu);
> +
> +	if (added && mapping->nr_pages > 0)
> +		r = -EAGAIN;

This can overwrite the return value from kvm_arch_vcpu_map_memory().

