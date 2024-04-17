Return-Path: <linux-kernel+bounces-147806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D148A79E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336CDB222C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64405EA4;
	Wed, 17 Apr 2024 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNkXE46n"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69C4685
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314080; cv=none; b=sHUWQU8QtI8VAM4HjEfhoVcBm/6N3qWle4AWO+eInwyDQZuU/QDcfLhKsJxTYWOoHzoxFq0DHgGNvhcATvHrqMzr3DxcMcCqSBBpFfwfD/2141vrXIamei5ROUU55HQBca6EhKpdUSHyiFt4tkZgm/DYIed1rGsI/SfQA+ggXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314080; c=relaxed/simple;
	bh=QcQ5CwIdJPBpAiEUOMxmQT8OLzK8+XohcwiHGYdlD08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOqNr4BRYk2WmnvtWognj5qC/udSCnpxZ1gO+X95JBe+7e3ly/+NfM75+B4Id/RchG8BW+t0aDs7qkg4+lZxYNvOI6+t9yCqqnXJJrHLb6czXUx25GQfVPzjuWSzfRz90fp/Wh2V0yeyJewrexBpTEWTHR0FwwilMZDl8ogh2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNkXE46n; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615073c8dfbso101693887b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713314078; x=1713918878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKCPeGd9SYcDB4rlgTO3GZ6PUnpW3Lm5DsYKGNpWRYU=;
        b=uNkXE46nug6U7+Tx0/9dCbzeGNzW6wFtParN2EJbtRfLTzOqXruV8XY6sislZTeJ8g
         KqKVX0Q95gkgsemPW1eYJ2yzdd921yULnRohdUVx8z79E4eWs0F1K+i/jDetHNoxbopi
         G6GUqEed5H/Uiy/XGCEQ68ed/LFfHpjaPD5++8b5jdRkbB7J9/dKfjQH5lomY5fZgPUb
         RhNlknfsozKKTvVxd3L8gkPTbrtXSZ5sp7AfMG9ObIBLNieanHSK//mrSjbbyCFaSaFD
         aaPmag5Y2SK//ddPCCYRCWK7FZMS4uqnmX9bFggfyz8ElZF3yoCNJGi+Z6S03B5SSTiy
         /Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713314078; x=1713918878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKCPeGd9SYcDB4rlgTO3GZ6PUnpW3Lm5DsYKGNpWRYU=;
        b=flmrShwJsoN4sD+l1t1CwDBzFd/MWPBuoVouOAoq6Cz9skSbitBzBWA56fLhktKDY1
         RSHQDqyL0Dkt3CVovdHiXzdwuSQSGJbTbiznvpxStE4dB3cbB+a1a6eCTPREQSZT++i+
         nq0tS766Iw21gz9BqF+o3MzADjMEJc2My8w5mKIo6Vdsbo6U4HHxL8jks14vpGEYGsMm
         6OOyojyOTG0wCxRaFR7/HnsGVHsxUlCe9h0DCXkCvsTd3RrC7V0hlW7X2cUUNnf31q79
         cxzU43PMfpHJSLtGctG83DYJSHRG4zZh7KeHDCXphG0KS5gyGatvLjhOhC3vNnf2DH+I
         f53A==
X-Gm-Message-State: AOJu0Yzp0HHW0KlJY2GRqjVpBP1tINwU5AksCi3R5+d6QgnqNu/zhAFS
	+wuFGIOJ64YlnAAlsEVHr26hztNkOCGNFR5qrMCSQx74knfDzsHE9EMTj0ho3x6NDaSuqI5mZPl
	qyA==
X-Google-Smtp-Source: AGHT+IGEjrPNgrfTQIQLaRwbEsHxol7QnWaKIZ3J4/4PrcaZUAePBGJtWepwBEycSYnoXivT9VAJAYBVrW8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1883:0:b0:dd9:312c:83c8 with SMTP id
 125-20020a251883000000b00dd9312c83c8mr1574843yby.10.1713314078597; Tue, 16
 Apr 2024 17:34:38 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:34:36 -0700
In-Reply-To: <20240405223110.1609888-2-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com> <20240405223110.1609888-2-jacob.jun.pan@linux.intel.com>
Message-ID: <Zh8ZHPUlQk4niS7k@google.com>
Subject: Re: [PATCH v2 01/13] x86/irq: Move posted interrupt descriptor out of
 vmx code
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Paul Luse <paul.e.luse@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, Raj Ashok <ashok.raj@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	maz@kernel.org, Robin Murphy <robin.murphy@arm.com>, jim.harris@samsung.com, 
	a.manzanares@samsung.com, Bjorn Helgaas <helgaas@kernel.org>, guang.zeng@intel.com, 
	robert.hoo.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"

"KVM" in the scope would be nice.

On Fri, Apr 05, 2024, Jacob Pan wrote:
> To prepare native usage of posted interrupt, move PID declaration out of
> VMX code such that they can be shared.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  arch/x86/include/asm/posted_intr.h | 88 ++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/posted_intr.h     | 93 +-----------------------------
>  arch/x86/kvm/vmx/vmx.c             |  1 +
>  arch/x86/kvm/vmx/vmx.h             |  2 +-
>  4 files changed, 91 insertions(+), 93 deletions(-)
>  create mode 100644 arch/x86/include/asm/posted_intr.h

Acked-by: Sean Christopherson <seanjc@google.com>

