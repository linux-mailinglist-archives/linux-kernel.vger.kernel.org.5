Return-Path: <linux-kernel+bounces-17377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFDB824C76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C0B1C21B01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E71C3E;
	Fri,  5 Jan 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4zc5J12"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C891860
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ce098b08fdso631852a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 17:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704417681; x=1705022481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVv2sGy3dLp+eFDxdTSVO1rf91g6VvVP2llZrM9fzR0=;
        b=l4zc5J124YTwZxK/36sqV1XxQaAfUUby9Cvi7FwyuKRYDy170HX8JkVq5f/+wdmk+j
         m9XZtQlq6YVH54Qa7aTVnRQzZjCK9GQAEAxhBO7mX+VHAqYTj2rChnUyOqfu/F8xF17Q
         3OYcUOu663dyZaE5CChYZ74b/lu0ZFYNnjuphZML57K2Og+ZXWF4oY1L4Cikfszc0oj/
         2jj9M9eqhxnm9kFpcBZNVNzB3+GXMtlrz3/9huOZsOHiBOPhmB7VeebLfZQB8FJMGmvo
         pkyNqenT/o+AOHh24cvLX8+c8v1hdEvgUjLKOpmiaRizkcZvtPFQcQRHd+AEQ0A5c70n
         RWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704417681; x=1705022481;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kVv2sGy3dLp+eFDxdTSVO1rf91g6VvVP2llZrM9fzR0=;
        b=udois8xtd8+y+WaBvZs/H8nMCx/mRpm5hCHfply7dzWcyq2sVbdcJWo8oT2uRHuBFB
         qpE2+6FcPlEG05oTrTtgxQxEu2Koj0CNniNIRBW43mn54Ssb+vWdNxyw3Rmxz2peO0QQ
         /KSRm17mwJSAuaQzHwk72YdgamZzHrn2BtO8OGBiGFLgAfAmxWQW9ovewHlzVwzP9tdZ
         g/9aRLya9rOCvbsLzUx8SrjR9VuD3osPLEQpeva1LZSNZslfE2UOX89gyv5HGIK8R0YD
         gYKIUFuQLUdYVmDR0gcfVUdU/xF/2dWlValOpt5yEm0cOLys0hrR/1A+e4jtcJwK54it
         T2bA==
X-Gm-Message-State: AOJu0Yz0A38Mftdg1SUPYl3pOaIWeFro9Z7hdLjN29KuJYsX3CTRXe6a
	kt2PBEdUXkQeVhmr1PrJuC9HjsIdf+HqOv/QYA==
X-Google-Smtp-Source: AGHT+IEyfYn1LXZGwuxm2rN/CtmbVELZ3GIZVnhtAWIkeZV2Lqxe+Un+GYDIGnxJ9Bmr8iuAVlU0rnE6YDo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:711:b0:5ce:ab14:dcd1 with SMTP id
 cb17-20020a056a02071100b005ceab14dcd1mr8598pgb.5.1704417680888; Thu, 04 Jan
 2024 17:21:20 -0800 (PST)
Date: Thu, 4 Jan 2024 17:21:19 -0800
In-Reply-To: <B042BACA-839E-4A42-9BAA-AC7E58624250@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2285758.taCxCBeP46@uriel> <ZZV65qJuJ67E_n9O@google.com>
 <1C37C311-CF8A-44EC-89B5-D826EF458708@zytor.com> <2451911.jE0xQCEvom@uriel> <B042BACA-839E-4A42-9BAA-AC7E58624250@zytor.com>
Message-ID: <ZZdZj7p1OcrAzDcQ@google.com>
Subject: Re: x86 SGDT emulation for Wine
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Elizabeth Figura <zfigura@codeweavers.com>, x86@kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, wine-devel@winehq.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024, H. Peter Anvin wrote:
> On January 3, 2024 10:35:28 PM PST, Elizabeth Figura <zfigura@codeweavers=
.com> wrote:
> >That still leaves the question of performance though. If having to exit =
the VM=20
> >that often for performance reasons isn't feasible, then that's still goi=
ng to=20
> >force us to implement from scratch an inordinate amount of kernel/librar=
y code=20
> >inside the VM just to avoid the transition. Or, more likely, conclude th=
at a=20
> >hypervisor just isn't going to work for us.
> >
> >I'm not at all familiar with the arch code, and I'm sure I'm not asking=
=20
> >anything interesting, but is it really impossible to put CPU_ENTRY_AREA_=
RO_IDT=20
> >somewhere that doesn't truncate to NULL, and to put the GDT at a fixed a=
ddress=20
> >as well?
>=20
> Putting the GDT at a fixed address is pretty much a no-go for a variety o=
f
> reasons. As I said, a prctl() to specify the desired return information *=
on
> UMIP-capable hardware* is certainly doable. However, it does not address
> things like fixed selectors that have come up.
>=20
> Note that there is no fundamental reason you cannot run the Unix user spa=
ce
> code inside the VM container, too; you only need to vmexit on an actual
> system call. KVM might be able to assist there by providing a "short-circ=
uit
> mode", allowing a system call vmexit to invoke the system call directly
> rather than having to bounce back to user space =E2=80=93 twice.

Heh, I recommend not re-opening that can of worms[1], though some of the fo=
llow-up
work[2] from the gVisor folks might be useful/relevant?

[1] https://lore.kernel.org/all/20220722230241.1944655-1-avagin@google.com
[2] https://lore.kernel.org/all/20230308073201.3102738-1-avagin@google.com

