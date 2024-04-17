Return-Path: <linux-kernel+bounces-149303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99BB8A8F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5FB1C2160E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B018612E;
	Wed, 17 Apr 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKUwQxhI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CF85297
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395228; cv=none; b=NbTbrMN+0l4wTYLJp+oyuWMXyCKFEgMF6nWA6tmfGz7fB88DWHQQCeLwTmJxBvUbh9FsTRx/wo+S7qBb/d7dWLhnV5Ks/j/cpjqjpZt+qfnvsM2UJ07bQuQ5n69q7QzymTZlRjy4SaYEsnf2mH6jNSHFF7TiYxZR84ocy6PEs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395228; c=relaxed/simple;
	bh=MAU3e14GXOgI1OPIqUqVpij8Of5M2Ew8TOD3t2RDN9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxwBd2KbZ4ToBuybPf5qkT9uDzhOGIuMyQ5leMBONFvM7DZHsIRFon7Ycwuz6r8Up5IO1Udfb40HW8Kp4uU24QE6I4f+dOiIZ558+aB9oaZfamCapReRsDvcjmovVtJ48EI6kMazmVSgBz6D0FkdkLMzLSPpAilNWz7ei5STDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKUwQxhI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de465caa098so203266276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713395226; x=1714000026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvdJd071q5jVlxwi+Q4Kny8l+l/3LzCxPLWdR3GCjKo=;
        b=oKUwQxhId+CvF6vweJ9F4Qt3Tbc+3w/QaqS5BVymtn5msE5S9tzPnS2Wzm7pdlZ5uV
         HChXIsmkeGJlaZ5FBHTKL7vKJbG5Es3w1Twfy1Dz4fVcjePIXsr9EK06KvXyn1KI8vLo
         egLdISZiEA2qr1NuTDkI4/yGcZI0mIma8fWN8qAGs5dBm+HTt8/MyQtu9MGLmMwy2faR
         KXdXaajXZdoj4aNzzyTmgEYY/sBzq5oelS08UJ4q75CE18xVAOjNAa2FR/4kVIYc38Vq
         mELfwtlOL12oERQZEwaCe99o/+CP392tc6FYp76Gdp/IdiCPHmhHwjRpqnhD/X34oQ0I
         drDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713395226; x=1714000026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvdJd071q5jVlxwi+Q4Kny8l+l/3LzCxPLWdR3GCjKo=;
        b=dVWe+d9MDu1XWu6b6Uujhe0Uhk/LDQehlK8kWNNiozBPrY6TCTcHYfakRI2kAPdPWM
         TpKCneBFaoAdblAOAAElrrYNPgBc7cVcLe2Y7iPDBo2uRvzmT+O4cXwvfQBA/oYrRRsw
         nC8s1TJfr7gI0yDTcvWDzRXyMWivjeZ33UDzxxIjGYIpoXqqaX11Ze02j39R7WNqdksV
         7YJASS3tfRzxZMGCDPxItE1vq7/D+wRNNVmNpJ6w650eB0aLoQ23vLRgFwu0EqnJsb0+
         +Pug5YahphAyUK8ElyrOlKrV2lraYaYZ/bOAxbIZanJe4TGcKJ/cePPYmC2seCMrBtKx
         O6Qw==
X-Gm-Message-State: AOJu0YyvQSeHx+zPL4rFxDusr4qjQQdS36Ofobk5kV/diysoIuA6jTMh
	HENbhDvZe2DhPaoP8FBVhiM2Llotgb9Veh7YGk0gMv4boqvuqqYtHfT9LTjmKyR2OWC2BJMMRJg
	oiA==
X-Google-Smtp-Source: AGHT+IG7dMVVcXlV2OF4ZNDypN7hQwGCXSUdtD9kzUtaTBpSxmDIxyz/p+PxTyTnJEeAdPSutPkt5noRRqI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c711:0:b0:dda:d7cf:5c2c with SMTP id
 w17-20020a25c711000000b00ddad7cf5c2cmr83545ybe.13.1713395225910; Wed, 17 Apr
 2024 16:07:05 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:07:04 -0700
In-Reply-To: <20240416201935.3525739-10-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416201935.3525739-1-pbonzini@redhat.com> <20240416201935.3525739-10-pbonzini@redhat.com>
Message-ID: <ZiBWGHvCGz9ukGnu@google.com>
Subject: Re: [PATCH v2 09/10] KVM: x86/mmu: Use PFERR_GUEST_ENC_MASK to
 indicate fault is private
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Paolo Bonzini wrote:
> SEV-SNP defines PFERR_GUEST_ENC_MASK (bit 34) in page-fault error bits to
> represent the guest page is encrypted.  Use the bit to designate that the
> page fault is private and that it requires looking up memory attributes.
> 
> The vendor kvm page fault handler should set PFERR_GUEST_ENC_MASK bit based
> on their fault information.  It may or may not use the hardware value
> directly or parse the hardware value to set the bit.
> 
> Based on a patch by Isaku Yamahata.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I would also prefer this one be dropped in favor of PFERR_PRIVATE_ACCESS.  Ah,
I assume that's your plan, as you have d8783aeebd40 ("[TO SQUASH] KVM: x86/mmu:
Use synthetic page fault error code to indicate private faults") in kvm-coco-queue.

