Return-Path: <linux-kernel+bounces-157668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E88B1445
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A2C1C225D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F0143860;
	Wed, 24 Apr 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiBseNzM"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1B1428F1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989633; cv=none; b=PfTqvIPc9Fh8ET0xMwpqYJWD4ZOsviCnNHyfZOZ+EPIbT3AAmi8cH92mK7PyfqaNvKCj5pizvZUGZTCxRw9dcgWnzMaxeeDcrfPjfQlthBtLXywdcd+MF9ItmQ+/H64nF4a7mGQHuiFKPBq9X7U6LMAvvgQt3/qvgNHSIBQB7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989633; c=relaxed/simple;
	bh=ASuoZZgHctVFrA5qjzXFbczbyWL4m9fk3dUFVVw8qdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFXA9jnWcg2j1biK5N0uzEYs3eMSwmP/or3ya3jJU/DIhYOH3Pi+Afnbgknyba0SrXI5PDQQ46OsOc7mYz4bY7feKrOry6F40340+RSjsCIkc591FTytWDPeHTzD/V/kgVCtij8x4JhZXYoqI7wSRCHCPo9XUVSkVzc80J8kES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiBseNzM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ab00d8a2eso3511277b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713989631; x=1714594431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kE8OuYsfUCESTgdrzuGuZRqCT/StXQ3hLmK/0rboegc=;
        b=LiBseNzMnYZprAfGgh/SUE+C/5LhGzxNCzrJhcu2uBhwRAzUmTOPPaLvKrXolDqHPl
         Xg+ZcooNxX5DCvSxbDN2KfU/Kexemagf7P2ni5GXJeLDav5NSa85dv7YYu/0pQ1j4dOG
         FuToY+slSObJ/MYzBzVNOubcCsFyPKSDcc9fN+tNHhaqCRuGtauAhp0oTVzZwAs16dyV
         lL2bofnk+7B+Ih/7FNFUVpIroxErw9wAJhFBe0UPa5+rPcVx6hRTuKeUlju7qtQV8Jnq
         rAdQGAxY6MwbWYDyQaA2FYIlIoEpT6zps5kIxlSXXpEjzq3GiOIFCEw0Xwqem8Q8xSLd
         eqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989631; x=1714594431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kE8OuYsfUCESTgdrzuGuZRqCT/StXQ3hLmK/0rboegc=;
        b=JuzMYkGd82kuJT4KU2vw7eCXS1G7eylWJwWaFTs7Hh1Mhp+AdkffxTy8JT/YgEqGPe
         Egp7q2TC+FiUCMLumt1rlKlBgn5uQTlGacFw6Kmq1AObow9TuACtyWmIGk9bmsZJwIRC
         q+4gMjMVBEC+JV7D8eJjMy6QyCifNXzKb2mjkIc462/DlmuwLN58MstOc7C9CAQus+ww
         UJe5GvNuMCvxJ6a/r9NpL1dJSjstEj4AUU3ynzUJuRAGGe9Lo/pzPihnu44fndedMy23
         WvA+I+iWO10weGkhGRD1ejlDIU0VFV/T/zO6lChaJM29yelbA2qPrPCQZNwYcnAWvhFn
         ae+Q==
X-Gm-Message-State: AOJu0YxNIZi5hdavvJPkJ3YgRtAyUvUwOnbDS1WcQz9wgrk8U6iKR/uM
	/+AVYGAV/qq0DYVOsI1qCNFIBLBRCzjrxx9shnvMQQKRJPRMJN8RmAoEQkIZXcWjv3AhPJiQAnY
	jMA==
X-Google-Smtp-Source: AGHT+IFwb/d+5gTCSXFtCzoG+k7UNeHOqkw9jquiZ+7SlUexVJagTvBBymY8FJeyqRdGUC/cduQZwjBHeyE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d48c:0:b0:61a:d0d2:b31 with SMTP id
 w134-20020a0dd48c000000b0061ad0d20b31mr692742ywd.3.1713989630884; Wed, 24 Apr
 2024 13:13:50 -0700 (PDT)
Date: Wed, 24 Apr 2024 13:13:49 -0700
In-Reply-To: <ZihZOygvuDs1wIrh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com> <20240409133959.2888018-5-pgonda@google.com>
 <ZihZOygvuDs1wIrh@google.com>
Message-ID: <Ziln_Spd6KtgVqkr@google.com>
Subject: Re: [PATCH 4/6] Add GHCB allocations and helpers
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 23, 2024, Sean Christopherson wrote:
> Oof, and doesn't SNP support effectively *require* version 2?  I.e. shouldn't
> the KVM patch[*] that adds support for the AP reset MSR protocol bump the version?
> The GHCB spec very cleary states that that's v2+.

Ah, the SNP series does bump the max version one patch later, presumably after all
mandatory features for v2 are implemented.

