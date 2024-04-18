Return-Path: <linux-kernel+bounces-150413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C448A9EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248961C22163
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8D16F84E;
	Thu, 18 Apr 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3NzpF91"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793186F065
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454820; cv=none; b=UYZBnHW5NKCy7T3BqF83A3/ds5/VNbCDBTPxVe3UgQhg0jd4UeoyaUsInlletCsfvF8fBms78jtAh39Pfmu1aISvRzUZTuSHNUEBFXgt0cEiGyU2/Iq3kBzfKeNAaUvwVoewS144vfvsyS+vQjhyviAcZQk43dCnhNV2Fko9hcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454820; c=relaxed/simple;
	bh=rZoxkMP572cXD8H7MwmnRT7l2/u/u0aJXcnV7sPJgNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qb3s1ZU/tSlE/QRYyCL/n6x5+kiSiDQX00mbtOw6CeAfvCtexIZhCewVw2gHttiA4smLKS92CIJYUad4ALnZwFnAUbUz948gY/qvoZkRkEbh43/nRBbphv6F9yxY2fHnKm0oeLJ/L7B6K4gYdV8h5irlPQERWlBzQaRV3J6ESHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3NzpF91; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61acc68c1bdso23068857b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713454818; x=1714059618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/3CBX6p3XiGZWIm/Xco22tdx8X1TjRqWPXp8qWEXKo=;
        b=R3NzpF91xqZyAfNoGSnS0JerE/QeI4o+04iXKuWHzSUWSATecMeF2eaUEVUz7y1vZy
         jS/MSbDIxm571YeXrjHN/BxTO2KKfCPK4tGH5FzyY6s0zavuvf0nQXd4b8jn0sEDllGK
         oRmLDySGYSuwQZrXIPD7ZBeoHTTcR6pODbQEUpAxg8WyCM9PvdOO1h+mYhSO/Z9dSPKf
         wrl6r7VeR/pe8nDGWhoLI5bROELHlPuff7A9h4/mm8lIqPEUAhcqIel/HIlor3AVr/qE
         mYa1FNoSrjDwH5aSi25zYmv81nwPn0ZoYPZ5xi76EFQboAuhU/nvV6QElo9WL2I1GEf3
         8sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713454818; x=1714059618;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/3CBX6p3XiGZWIm/Xco22tdx8X1TjRqWPXp8qWEXKo=;
        b=mp1Oc3uSQRDYSHigoJavHV+cqCDS9hb8Z1gix10TxGPFCr9vGgOe6yFm3Y5ShxLdiW
         s/+8xz3olwNevlo9W9TVsupG5C337rjLNSl3hG4FLx/otHqulwDt2Q0oWg0YXy+DCLNQ
         2UCIyYdL1FUzyHkEeqrOB1BZm18PmJNVr1WZwYeajjpmicbuhAR+H1fuaiPJMozsOLa6
         jCXH6yXPlZ9Ijn0j6wUB0oUy2L4Wp8HHWla4iF1M5mwCgkX/PjwbGOFxz5EleNPAB0ce
         iGpaSFQ8lK8nNDg511fr1ccs5n/xpF9pLW6xvR8j+f8sRXcJfaz2baIvnDu0Aw2uZ+wz
         Qe2g==
X-Forwarded-Encrypted: i=1; AJvYcCWgqKM43Arc5yOZtruaY24qQVeAhE7hxAMVU1iE0qr6Sx26DTV/gz7xvYO27uz6pVrbnj5xKtiB8vFCsdzPBN3Ue8c8j98HNxvNnU9m
X-Gm-Message-State: AOJu0YzhTVF7ip++Z1Ih4QiBbuQDMjzzOFWLWFSGA5avzgi0QBKDkCHs
	njxYogf1a0vsVlRuVzTszcrT6ZqyM8MjB/fMyY1Mcy7PbpLo5ZXIuls0qp6+uZiqgnFDe67AmNj
	/Qg==
X-Google-Smtp-Source: AGHT+IFMflIA8Fy/KN5D3SfB3zzGK+sKaqWwXmXJ6gle7EfUrs/CN7CJxa/pJO6PUEK97j0Y9YWzQ7KYt90=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:748e:0:b0:dc6:deca:8122 with SMTP id
 p136-20020a25748e000000b00dc6deca8122mr560803ybc.5.1713454818493; Thu, 18 Apr
 2024 08:40:18 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:40:16 -0700
In-Reply-To: <CABgObfaS7RhUPe_FYS9SCuDzOfFw4X9P8XOhJSspVdzsYeoX2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <CABgObfaS7RhUPe_FYS9SCuDzOfFw4X9P8XOhJSspVdzsYeoX2A@mail.gmail.com>
Message-ID: <ZiE-4EBOdbU0Zn8o@google.com>
Subject: Re: [PATCH 00/16] KVM: x86/mmu: Page fault and MMIO cleanups
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024, Paolo Bonzini wrote:
> On Wed, Feb 28, 2024 at 3:41=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> I have made a little hack for kvm-coco-queue, preserving for now the
> usage of PFERR_GUEST_ENC_MASK in case people were relying on the
> branch, to limit the rebase pain.
>=20
> The remaining parts are split into a "[TO SQUASH] KVM: x86/mmu: Use
> synthetic page fault error code to indicate private faults" commit at
> the end of the branch.

Ahh, I should have read this before reviewing the other patches.  Thanks!

