Return-Path: <linux-kernel+bounces-45562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B184326B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB8E1F22666
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7C139B;
	Wed, 31 Jan 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UV5kZgwq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D299139E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662846; cv=none; b=WFkmnG6Y+yzthNTFZP0GLpZz3QYWJXtGs64jOhNLS1fCjV8LEzGRlZD82Mm/2gcPGhcisnQpgPq5mqk3n3TJtqn/ao5W7HUr8nKmZqlPjSSH1vi+boW6xOzCdFhRhWATnIUQ5ufTS/NZMkbcbQ9Kta55137zfhYtySFYW5xpvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662846; c=relaxed/simple;
	bh=8m5C1gxxrH7lFcMvyPtH0gAVFVKsHtRapWc9S9fULhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YMApLuhtHieEfcxRFIfPwj4cC93UGupXZWRFg6Qf9iN1BFEt8u+4Cv/Wfa7rQ89r9aa2Hkt3dHgQROD3gWme7y0wT6Jv8P0WMqnkyceIZel8M1OE7KGxT0O/8Z58qOuV5/vwFzm64t0m+yLA0ZPS/9F1VZ0tAOIHxZgAuOrG3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UV5kZgwq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60402c8d651so8848107b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706662843; x=1707267643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/6EISmcdKMqUmU1fWbqozYT/7mLbV7Sl1T8e65+Jmc=;
        b=UV5kZgwq1sp8eLPXdWu4KK3eB/35IJg7ilZRmE8c4lZdvAoyW+dhuO8yRwJF1opLA+
         rbJHzNdTLRBpZTCPsUEf4CJxTQHKmtA/2tf/NqyHzOrg0wIMFMHlImzwoEejAxE+euyz
         8/Q48Ty6zjF4IZYz2ceabqxt61Vgmi9+R4nteIUnC2ahmumxDvNFlbXoaUpUjyEODGio
         UiNEVYKhxgnzV6cNd4CmGy9KdP/fy66DTUEtfKGEmi00bcw3FA4ZiVsD2USV6VU5AEgu
         ba7gS2QjTDi0ZVVVndPrtfzNj8j26f8A3R//qXpPPE2QZllqNu1CSUHHuIuDj7R/c5Nb
         uEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662843; x=1707267643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/6EISmcdKMqUmU1fWbqozYT/7mLbV7Sl1T8e65+Jmc=;
        b=fzYOE9C3YmF+vA3Mk8Lzf9WsG6ple2E1mclUwRTjxE/TUAxf/81JSpq75hDZxpc3hS
         HoAVWaCWzAltaict0bx4P7lv9CcpqEwDtYuL/jFr+cA4sg0szsPe6O8ivHYtpEUIh1CW
         QgQwhk4yYN3BLCU/QWNN2msNzQvDRnDa1HOxnU2brtxmkCSLZfYEK+B8gTe0fz/ocXPe
         kiRmt60RXwMCHYhpYL9p2h5EnDv5dybypFe81vu5ujK+uIkjLjXlT+88Go69uEQ0UuYD
         ju3/KGesCHVf8pRTNjBVQ1mecqMLqvVpVv/MODYUe4XYJb7sPqj+8jaWvzZ2pZ9DwGgd
         H62w==
X-Gm-Message-State: AOJu0Yy2dHluZUUkxQd8Oo8FKp5rq07o3GYls40088dPUaTwnP2sjxAN
	uPVuCCsi6v8YjjfI6CRnMuswHhTTrGZG64cdusoeDWhN2rQ2zE9hc+wMSydPdLBMRnrd8Mjp6Cl
	M5A==
X-Google-Smtp-Source: AGHT+IGjHRUOeuyhuy2WoSF7k/k88PYslFLei9Ndx7E/Y0VZPxQqbfcq/jybTgUDEEUnYaPCelSqWeic5ds=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:7996:0:b0:5ff:80cb:23c7 with SMTP id
 u144-20020a817996000000b005ff80cb23c7mr430ywc.1.1706662843535; Tue, 30 Jan
 2024 17:00:43 -0800 (PST)
Date: Tue, 30 Jan 2024 16:59:27 -0800
In-Reply-To: <20240109141121.1619463-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109141121.1619463-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <170666266778.3861845.16453599042139259499.b4-ty@google.com>
Subject: Re: [PATCH 0/5] KVM: selftests: Fix clocksource requirements in tests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="utf-8"

On Tue, 09 Jan 2024 15:11:16 +0100, Vitaly Kuznetsov wrote:
> It was discovered that 'hyperv_clock' fails miserably when the system is
> using an unsupported (by KVM) clocksource, e.g. 'kvm-clock'. The root cause
> of the failure is that 'hyperv_clock' doesn't actually check which clocksource
> is currently in use. Other tests (kvm_clock_test, vmx_nested_tsc_scaling_test)
> have the required check but each test does it on its own.
> 
> Generalize clocksource checking infrastructure, make all three clocksource
> dependent tests run with 'tsc' and 'hyperv_clocksource_tsc_page', and skip
> gracefully when run in an unsupported configuration.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/5] KVM: selftests: Generalize check_clocksource() from kvm_clock_test
      https://github.com/kvm-x86/linux/commit/449d0d6ccf55
[2/5] KVM: selftests: Use generic sys_clocksource_is_tsc() in vmx_nested_tsc_scaling_test
      https://github.com/kvm-x86/linux/commit/a79036441a68
[3/5] KVM: selftests: Run clocksource dependent tests with hyperv_clocksource_tsc_page too
      https://github.com/kvm-x86/linux/commit/436e6e541cb2
[4/5] KVM: selftests: Make hyperv_clock require TSC based system clocksource
      https://github.com/kvm-x86/linux/commit/14fce852a14b
[5/5] KVM: x86: Make gtod_is_based_on_tsc() return 'bool'
      https://github.com/kvm-x86/linux/commit/57cc53712934

--
https://github.com/kvm-x86/linux/tree/next

