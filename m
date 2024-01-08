Return-Path: <linux-kernel+bounces-19774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201F827330
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1962D285F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7351C23;
	Mon,  8 Jan 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I23rHSrz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB64C63C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d9c7de0620so1317066b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704727873; x=1705332673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVwH1RL2tUEUDKe0d7KFQLzt8tFJlNZHVTEPUbq4Tr8=;
        b=I23rHSrz6sYOW6xFP4ymdxyf9pB/FHS0eyAYShk7dFDmZ/L2gWBTE9/xyRWr+m6nh4
         JUdZMtu8IznQ1Lp3QeDRY1cvu8eWu/mpMrE2zz/buoHxem+/QQEoecL+p/y8B+qRbBbg
         cqoV+OJMSsLrIH8GLevC+3SLrt9+Or6EsAgBTyKE27QFu870+JzPpWeFw5mVKBZz7GWS
         IDd+SektVB/stzqsHMKIPMPqzLvUyB3/gTBr4b7x31FMNGPHUqrcMioiVtyzs8SD3cKG
         4EGVQlc60L6W8gn/OH2AZeO6n72Czmj65mKgbGH6PAv3PdL7omqyHaw3FjN758RONcF4
         6MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727873; x=1705332673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVwH1RL2tUEUDKe0d7KFQLzt8tFJlNZHVTEPUbq4Tr8=;
        b=UJfxfJkC1+nlwW8fLUUFKK/7XxxSwNCMxRu73s2HGrlmR+Wm+zr3v5X6Ht1O4N09rJ
         b3+LbbuTEW6O8lqnLGd1S1mxJ75acBqDXWEz9MvGBFJtt1NcJvXAdxA5l3c0Uz6KfvKd
         gQUAyrysFfsWOCC33Dky8bPA304F1apEt97T9kRgq99x1wTikNMEMzRHOOkVn5PuAdIH
         NudFK8LUi5cX8fmUvVaXN/Ad7vP2xe5sSFtKEA/CQTBSYJkWAWEKLUd9sEGsDEFhoSoP
         zEFH2TJsnIex5gjvlZPYSj00iK6MbvwTCGg8TapVx97ze+Vi3Sp/DWp32urJuh0qxWya
         knAQ==
X-Gm-Message-State: AOJu0YyyaJJH8UWJ7QTaSpvZ/Ga7KCEjR68BOl+EOSu1Occaa9l8cUFD
	+5gEO+nDv3VkJvLWK19ThaIqz74NNgKBguxi5w==
X-Google-Smtp-Source: AGHT+IGn5/q07JNwWlMgGSFZqxloursLKBN2q/lnhLIJj2dqxL54a6Uoanxg9la8tfBTT0f+IFjpkVnm+zU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:acd:b0:6d9:bcaf:5f16 with SMTP id
 c13-20020a056a000acd00b006d9bcaf5f16mr362033pfl.3.1704727873475; Mon, 08 Jan
 2024 07:31:13 -0800 (PST)
Date: Mon, 8 Jan 2024 07:31:12 -0800
In-Reply-To: <20240108125228.115731-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108125228.115731-1-pbonzini@redhat.com>
Message-ID: <ZZwVQCnrg0ZmEP2B@google.com>
Subject: Re: [PATCH] KVM: x86: add missing "depends on KVM"
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 08, 2024, Paolo Bonzini wrote:
> Support for KVM software-protected VMs should not be configurable,
> if KVM is not available at all.
> 
> Fixes: 89ea60c2c7b5 ("KVM: x86: Add support for "protected VMs" that can utilize private memory")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Good job, me.

Reviewed-by: Sean Christopherson <seanjc@google.com>

