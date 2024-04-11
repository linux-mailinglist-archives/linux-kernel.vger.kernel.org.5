Return-Path: <linux-kernel+bounces-141520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0228A1F54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75441F2A461
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716814A83;
	Thu, 11 Apr 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ji3XyGUr"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3514610E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863075; cv=none; b=pZL0fEmtaERPuOk6LreX7/x+yGAS7CW+wFF3hu01MiigHunr9MgDTIPHn5urZuls0i6rIcIAFo4MJqmsz62iFkCaMNy4mlbFEM7THu+VTvQUXXYhT/R9i3lWRmRQM2LkTVz1tNKSApmA43z+7JNzqFAdTKmV/HzUUKNEpwAcA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863075; c=relaxed/simple;
	bh=sD4t/uLxUXQneloPRvioqFpGGr++WQw2Vhn8idLNvnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aK268+UbdnlaoFJtVoDUQS5q5Eg4+OgfGJtoTXAQTeT56koHFGV9HnZ7ldH+TB7lR18dN0On2HEEO9H3ImXVXWIrsOYG7mPQpLZAEfl1WapbbI9zW1sPaEtVHSzqxnn5cTsK2Rox+UNqpl1Uc0a/2STj5FDU3NSE3jfYy3qG3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ji3XyGUr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so159747a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712863073; x=1713467873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMIixoIt6lY2SkR94o/u4nUsQeakPmVSC2HlUkV0a60=;
        b=ji3XyGUrxqhwI1zj90rfih7kd0TW0YjfCRz3T346bA7OGtMLhT8NjY06BjnAlzBUw+
         OxmiuMvYQsMKttH0jSge8uOcp1izuIXfV0D95sHdFR4wdoPqy2XYPE90nxjtX5K/VzIu
         e9LDyPKnA5GBaAjeLP5jhU6cynBesB37QYvftHmbNu56NLvDWcpX6JEaoK+0qo5bafBT
         1VpIOOmXkSLuX0rzH+ZkkbGOV9LVJROgKSDeOb2EEU5gqmMd2NE+TfCHetXQvjPTOX50
         r9OljLwy2I+wPKi8np1FQUxXuqOCRZBD/k+uC8XIUeAvFRtiONSfzONu1P20xbkYsYkl
         XwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863073; x=1713467873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMIixoIt6lY2SkR94o/u4nUsQeakPmVSC2HlUkV0a60=;
        b=ZTqx+yQMDv6bPr29C7ARfeGbKfWaD9FdpDNBl0xfsc0z1lxvhHB3brnb1RsdQQHoYH
         WwOmh7mYy8U65dVuzWXDiX8SQO7Em3F+wAKPDm66AOruR2cMT6fVGK8SB0ur1KiTiRkL
         x1EAKVNUq/5yIL/1XuYbEAR7TOUPkDVl5yJOdeHoN1vmzRI4R5DZ+TFg2s8BYopmglJs
         5OzEBxxNeo1GS7SeyMZHY7pbLe982iobg7sr4uzyz/hKTYxMEJSgxIXUjMao5Nn+EH/m
         lIpC9OtL1Dwr/r+rRQtKrRtT5A8p7YOEZ0t834UBITLct/sONiJj/mKquKbHIFGw/l5s
         eUkA==
X-Forwarded-Encrypted: i=1; AJvYcCXHqmqOnl1AnNSYfudWc//Y9iFCL+DBgIuXUM4qMz2CQL4xhKMmfaCVbfcheQO0BLYK1E4zPnDxGNnLjPEdGcRmCYYskDCobkY6vlhO
X-Gm-Message-State: AOJu0YwFmWTngQwfkkC53osYHNhgqC5wQMK1Ednw/uFNoN/dIrKG2VK/
	Vom6qzcWJGu54Bf/tQIm8nbq9LqzFzqdW1Ec+NxEKaSFv4R4s2vYLd6VZduImKVNg9oU6raw3At
	fmQ==
X-Google-Smtp-Source: AGHT+IFguQvCmFsdS9wZt2947ESaktoib4WjScGApUlH985d9Wk7VnVVsEw7G9iuNo+2wFb72ko/YplirSU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1761:0:b0:5e4:292b:d0eb with SMTP id
 33-20020a631761000000b005e4292bd0ebmr1192pgx.2.1712863073071; Thu, 11 Apr
 2024 12:17:53 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:17:51 -0700
In-Reply-To: <20240126085444.324918-7-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-7-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhg3X_5A6BslIg-u@google.com>
Subject: Re: [RFC PATCH 06/41] perf: x86: Add function to switch PMI handler
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Xiong Zhang <xiong.y.zhang@intel.com>
> 
> Add function to switch PMI handler since passthrough PMU and host PMU will
> use different interrupt vectors.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/events/core.c            | 15 +++++++++++++++
>  arch/x86/include/asm/perf_event.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 40ad1425ffa2..3f87894d8c8e 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -701,6 +701,21 @@ struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data)
>  }
>  EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
>  
> +void perf_guest_switch_to_host_pmi_vector(void)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	apic_write(APIC_LVTPC, APIC_DM_NMI);
> +}
> +EXPORT_SYMBOL_GPL(perf_guest_switch_to_host_pmi_vector);
> +
> +void perf_guest_switch_to_kvm_pmi_vector(void)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR);
> +}
> +EXPORT_SYMBOL_GPL(perf_guest_switch_to_kvm_pmi_vector);

Why slice and dice the context switch if it's all in perf?  Just do this in
perf_guest_enter().  

