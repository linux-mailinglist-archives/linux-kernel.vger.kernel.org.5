Return-Path: <linux-kernel+bounces-149097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786B8A8BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF2281F30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FAD23765;
	Wed, 17 Apr 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DGAuJXJH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3736208D1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380448; cv=none; b=WPQLfyOdXBggNR1GKPpymDI3DtGrD0y6fWZsZXuIutUDNGYAvW0enmVUQare0W2M24NLHNJp51YeVxaOOMYAt2ASWQAGY20HAS5kXQ+AgU3DECISF0DtWjK45yBYmheqgaSY21TIPMUB+H3UmpDOncy/jf6B0ay2R34daU7gqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380448; c=relaxed/simple;
	bh=01o4dHuglQVsTu+PcICGhK6gJNVEOr86+0KoEPkkiwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bVGlXaYEyy5OhB+p5o0KJtZacvefYiAIiIMRmY8HYmYi4JN6qHwyqc9xDz/dZ1gYD3H162K5DlLm2/zaPWBQqZLOJc0v4dblyzsH5hRGbEWHGjznH8/b0OLOgjmQ/33Phi4JYeUeePUcvPq7zFY6kgGLXqyw4ULVsEGZhkn3x6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DGAuJXJH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61afa75cf5aso235707b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713380446; x=1713985246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfxuAXuPWvmyvdr5+9PlGKbmbBIGocadn3UYl5buNro=;
        b=DGAuJXJHt2t0zZ8ltnhwKwfgn14v3+WiMvgNUk98MrvXsIBZ1Gk4XsTE12jXGCqMKH
         N8UUoE5cFCMtkrpBnSpK6dFPgGSOd7IU6rUqhUrj0hr1aGV4s2xtJRNteKHCd5nEG9cP
         r2qEfWb0k1B9iEEqHBMdvRqsZ/5GEIX85pdD2dpUYVVej2TFl3LnkjOPvlfNcQaFdMbl
         nEGOADzQqw6M/E/wBX4E9HnTT4bu0AC+MlWkO87R0E/c7eA+pfVOPMxjrvv2PEZe5dLD
         CdK9xfbVr+EP1Z6yW+R1IQ/KDy/uRtsf0Uwc1+hq8+FE27D1l9xjpyKbpOKM85TXzaoE
         ib7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380446; x=1713985246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfxuAXuPWvmyvdr5+9PlGKbmbBIGocadn3UYl5buNro=;
        b=NqbWvAUN8I9M8qSKBRSL5UHr3yNM1MzBC1WQ4A3ecDfWs7yMu/BDBV8JlaXhtLZ9rJ
         1dqr3ca3JgYHA8S5JMoj4jX2T1HFL7qn0WrubXtGJH9v5iZvEIuuGJvplgmPXv3hAuFS
         QhJcxmR3SyB2xP18TFdFgVHJKTdaian71rLEFqBNu1fiW++BpizuOfECzAYORnIxO3w1
         FmTuiDai7xvu61gPrDIjyePaz1SbbBOSZ9f2sE92GKnSyqpt1k13C6b9U+wmyvRZCr+a
         UtLe6ESTwfN1mGPqQ+j3XMh9Z/kKkUTa+gvGHf9qXzH1AtpHxyFN3yek+lIA4GH2PM3+
         9whg==
X-Forwarded-Encrypted: i=1; AJvYcCWEmjQzJdolNmXMZsKS7/UBzEH5utA0MrcBtasLP83JKbrdJoylAJn/BKyBMQpY5okCjwryt87Rw0DoiX8Iuwyu8ORb1dQRb7cSXy12
X-Gm-Message-State: AOJu0YyTq9Qobvaqqhn2iLRD9jtl1ucVNwQyyGAlIlVX6kYmhDLYEPRl
	EjKp9X2NhjO/iiiumhOquiRiQgVLnEB4hhlVH0RoVKNcrr+2G/RX0TAHCoaMfO5UICc/otdxJFn
	QvQ==
X-Google-Smtp-Source: AGHT+IF1El6IZGCeA7PMlSPFtdTtFo9BlftsZ/Xw0iunvnYRq58iSoQFWMf5DXWl+OqcrZTERay510JNjxo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ccc7:0:b0:618:859e:3f01 with SMTP id
 o190-20020a0dccc7000000b00618859e3f01mr21635ywd.6.1713380445908; Wed, 17 Apr
 2024 12:00:45 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:00:44 -0700
In-Reply-To: <20240416211941.9369-32-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416211941.9369-32-tony.luck@intel.com>
Message-ID: <ZiAcXCQBy3rBFKOF@google.com>
Subject: Re: [PATCH v3 31/74] x86/cpu/vfm: Update arch/x86/kvm/vmx/vmx.c
From: Sean Christopherson <seanjc@google.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

For the scope:

  KVM: VMX:

On Tue, Apr 16, 2024, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

