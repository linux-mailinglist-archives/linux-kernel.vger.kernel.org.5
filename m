Return-Path: <linux-kernel+bounces-72028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5C85AE07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CDF1F21F23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292354F8B;
	Mon, 19 Feb 2024 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCgw1UP1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4F482FC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379371; cv=none; b=gojcM0hFaBujzyr6jp08FBNBMw585Rzqcwz8VOLGZ8JjtpI1NvCDba/UBnYukDFVKKe0efX+3zNSZTlqzZWZf8Lgk6Cmo5vbnKo+q7IeodSw6EMASkaAnmTDTKUHVyl8Gxhmu4m2H1m2sJBi3Mzo2iYFm42CR7bRtUWiwL29qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379371; c=relaxed/simple;
	bh=KItFpHig7GKB5eVb83kBF+Sj8VfMjfLDxIkJsHCGAAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tU7ZlvNY2w8unwNTClt1dqEmclXkAF9pSVSFUQP8zXKmPcjO+Xx2/tNhPUzwph+JUfz5kShAf2DSj5Ex2l70axQ8JsOApyTxRlZsVq8lCJH/rfVgwJaOpnzDkfVK+33gh0TgqBE5Z1ntvZtKtb4bOI+qmQWIz3hZJ3pqh8vsMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCgw1UP1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2993035cd15so3204162a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708379368; x=1708984168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfULs70pvI7Ceuv9WP6jFUGiLY8ut6R2G7DJK71RQkY=;
        b=NCgw1UP1hH90/FQ/kuw6bS/QgCNpfraT4U5YBUE5OIytm/sgbrey2Pfng72N+ZD8dj
         DN3Y2DwcShM4JtwlsEy/Ffh7XHP7h+hsUytvvibI8QiEmcoI12Cm4GxQ0A5UW214eXHT
         vvz+ifVNxyKQ0bQHrq7tysE6HvM5B7jAQyD+leBK7anLBETDQapw0iC8VDay1swX/owq
         v/oaaNA8Iy8TmEZJOjG6A16OydqPeQCxnby+8hZ9a2+EiR2vmE/rOZTJeq2x3IOtQqFC
         7rngs3f4kqFMB6ax82KRVSsmrx7erjij1DLVt9xClC9MuA/q+A0w8KZw6gXzlwzWF5DS
         1d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708379368; x=1708984168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfULs70pvI7Ceuv9WP6jFUGiLY8ut6R2G7DJK71RQkY=;
        b=rVO6pzgfybfQ1ukO6xwzgFDjUtRIxRBoDokgFzkR3D1xO1fRXos0FZrwZAfbYvg8o4
         T0r6ZAesQnmdjRARGZaOy/vlzQkjD9SYimuRQOng8DPqxh1auxAAeouPTK/lIPCjMkWF
         RFT/uT3hPoV7UbttYPvtqFXpfnx3+WI3r6WT9RCw3Pbnzt+ds/A24ESY5FU1/1jpIUtv
         oY/dttSexPSamMjZCcAmxWoVtTbwxKYpHCBxFhgNavXR0jTJVcULEFYFNa6QWbUG1tc+
         zeya3hvy2Zejad9CbJxlNSctLDiPHGJ34qWZJiXzirv89Cwz1d+BEu+GFN9k6tLAmrEs
         6XEw==
X-Forwarded-Encrypted: i=1; AJvYcCVcXagChBbjrHKwb7nFeZQ9SBhiQCD5GeJq4PbMV2yc/lOXatg2eLGF7yiJv4saGVIuVjOfJz7t1ZrvSiSJaKgwTummQHYNpkese+gt
X-Gm-Message-State: AOJu0YyblDWpi5e/vzVUgQQLAg6Yh+fm/bszMGpW1/2Srmx2jbZIRpw8
	F79MhV8Ja5t8hPQveatdy1jGfXf/zPnt8ofGAxHCx8B2Hc1L0TOAd0Rj2sZvgLWpJ+VgUSEDbq7
	sBA==
X-Google-Smtp-Source: AGHT+IGiLYIaic9FuvOhm9v4VMwaSoQLJExmElo+aZ5wkO5dXcI8ekgu6UFSXYLaILEpuOWNO4GMHTfADQg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1583:b0:299:cda:3178 with SMTP id
 lc3-20020a17090b158300b002990cda3178mr154276pjb.4.1708379367964; Mon, 19 Feb
 2024 13:49:27 -0800 (PST)
Date: Mon, 19 Feb 2024 13:49:26 -0800
In-Reply-To: <20240215152916.1158-10-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215152916.1158-1-paul@xen.org> <20240215152916.1158-10-paul@xen.org>
Message-ID: <ZdPM5tzyHEq4Z8t4@google.com>
Subject: Re: [PATCH v13 09/21] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 15, 2024, Paul Durrant wrote:
> @@ -319,7 +340,16 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
>  
>  int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
>  {
> -	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
> +	unsigned long uhva = gpc->uhva;
> +
> +	/*
> +	 * If the GPA is valid then invalidate the HVA, otherwise
> +	 * __kvm_gpc_refresh() will fail its strict either/or address check.
> +	 */

It's not just to make the strict check happy, though that's obviously the direct
motivation, it's so that there's one root of truth.  The strict check is there to
enforce that behavior and to make it  more clear to readers that it's an either/or
situation.

> +	if (!kvm_is_error_gpa(gpc->gpa))
> +		uhva = KVM_HVA_ERR_BAD;

This would be a good time to use a ternary operator.

	/*
	 * If the GPA is valid then ignore the HVA, as a cache can be GPA-based
	 * or HVA-based, not both.  For GPA-based caches, the HVA will be
	 * recomputed during refresh if necessary.
	 */
	unsigned long uhva = kvm_is_error_gpa(gpc->gpa) ? gpc->uhva :
							  KVM_HVA_ERR_BAD;

