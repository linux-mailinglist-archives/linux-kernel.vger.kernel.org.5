Return-Path: <linux-kernel+bounces-27595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B557382F2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA63B23611
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3691C1C6BE;
	Tue, 16 Jan 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZnSJJyY"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793091C6A1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d43b188223so48493215ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705424012; x=1706028812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4S3rhgao3ISdTWXN7ZIdMJxorzZIvyO9B510/Jk1WY=;
        b=pZnSJJyYjWXZCgLHp6VCb4xXT79RlH3wPJUPaeC2Yj0y4FpSmjukTlWFCWJ2wO90Hq
         uO53fY3hRYJe74N6otpPqNHBTbZSWRFMe0Po289ktlOsbLtzruyv3uX+SY0vkaIsYv9g
         /DaGakTaU7MGsmPwhO2Y4koLwX/sDio4qJNuaxzdx6uPMLve3o4ZT83NlpVgk04tTU6L
         qcIKqJHeCX87rXOBDUnxvtva8soPpeEAodn2/sHVxHsTJMT6iWorfV05Muk6zTAechka
         M7JFxdntoPmdRQh8+Ic+p/0mNHm8uff3Abcww49Xqn15lRGVFlf9nU+EdUwaAu52kJrn
         VHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424012; x=1706028812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4S3rhgao3ISdTWXN7ZIdMJxorzZIvyO9B510/Jk1WY=;
        b=uy04JSVKc0+j7ACM00+TIMUnrsTpAA78DXB3Efmz4JZaJ614IYHM8ud+CDkIREcfsN
         vKaail6hvRJUi16sfVTGvS8uiRNwaLg6egH4UIaIXkFXorVjpUbtn5wW/ZnDn/pQeInE
         MsbqCBUQ9Ai8qvNPxm7qZMBbiROqYrbtEnMOfbti8JrwX7OmeT7TO+73U5x/Sn/Ouoy7
         TT8Pjv2p7Fw8oihh2Fx0n3/DgvVf9HAxpAYWj46wb9mz0Z7m9bljtsiwbXDf0AwPdZDw
         MEcQzh+h4gdANonqBzadTeyU4btRGi3CkpC25p5l+hS5rIpaojE2JRDjOTeBDks2OkZC
         pyQQ==
X-Gm-Message-State: AOJu0YxR4plRTMuqcLboKd8LtlXPE/Cngy6otTzjeK9DDZe8wuhDf5Pr
	iFTkEieCHx8vuBQeUjqRRe8v6u03lLXPf8xN/Q==
X-Google-Smtp-Source: AGHT+IHtEmWyRtuf6UeqXkssQ2QCZ+BpuQBzGbMizkf9t9j32UkiO53RcHOpnaXGufKnsQF2/zRpPStlcGg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:a45:b0:1d0:bf46:ad73 with SMTP id
 mn5-20020a1709030a4500b001d0bf46ad73mr33439plb.4.1705424011811; Tue, 16 Jan
 2024 08:53:31 -0800 (PST)
Date: Tue, 16 Jan 2024 08:53:30 -0800
In-Reply-To: <78d43f46d3a0e6368cdcc28a67a102da8599034f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <afc496b886bc46b956ede716d8db6f208e7bab0a.camel@infradead.org>
 <f80753b3-2e68-487c-8304-fe801534748a@gmail.com> <78d43f46d3a0e6368cdcc28a67a102da8599034f.camel@infradead.org>
Message-ID: <Zaa0iitjNOP9B4BZ@google.com>
Subject: Re: [PATCH v3] KVM: x86/xen: improve accuracy of Xen timers
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: paul@xen.org, kvm@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 16, 2024, David Woodhouse wrote:
> Ping?

It's on my list of things to grab for the next cycle, I'm just waiting for -rc1
to start officially applying anything.

