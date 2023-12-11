Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34CA80DF34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbjLKW46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLKW45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:56:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DECD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:57:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e1b9b10dc0so4055807b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702335422; x=1702940222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLiTtRRqM+qNBV6tYcuiNPBMTUo4FdzTRXinHk4XXSY=;
        b=jQbXGPOb4aUz9h/DCAaYw7yu4FgckKWiK+UtCid96tFmLgd1DsXM1Nlg70/QJAgWsg
         dMahWtxfn21P0gLevEhrT4stbX+G9LgIJb2xHzz65KsFXxG4LoNvMy4psC8j2UNmT4fj
         pDpbB8+2zOwEUWd4UbKgezZ3mIoTUJzY1QpoCyVK3nxn0HgmAoIfcVCFvIVHy9wWJT1+
         8qOL94SzQGnpyi+G8/RZZnUc/1DtscA5UgcHiyy5RZYsurcyfPlxW5UfrTwLEycq2zTL
         /0ZrNfsidk4ihm5yEwsYfoFAmsgaFUIokvfc5mLHHoWeIuIlUf27vK0h/eR7iFdLbIy8
         Ip+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335422; x=1702940222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLiTtRRqM+qNBV6tYcuiNPBMTUo4FdzTRXinHk4XXSY=;
        b=PFagiumKGnAJVIIW4e2mqqaM3BXvPLwqSS0qNy+g0lbS9kfOaIViHp9s+dEWVY45jS
         tw6VNs+8aJA2nc8Oy3RD88wjLdeEO9TlPSxPk6fc0msWclSXfkzNpbMimSNBtIzxSKwZ
         7Odqb7Y/H/nR0mOyn7Y8x+gBG27oPrymCTci5rpeQ5265I1lH4F4y7PorqNqrl3/jfIz
         WD6PAQnfZNuEMe76BI+ly7Jwi8EBYw+yzHSvg0X0/OIaTLZTHtqTXuQHzwHst/s5bgd9
         9cBmnpwKtCy4wXtQAnpbL/nr2N9Y9FK36Ed6gsr4kYS+aRPobnshtUTrR1Sn/Ge9q6v8
         1BMw==
X-Gm-Message-State: AOJu0YwLFV3ZAVe9xPCVtXzoob5Ek7V6tX7+B7kb00DK4J6OHDL8nwuR
        +eeLNn2uKzUx++pkDi1QCnDgSkwrKpo=
X-Google-Smtp-Source: AGHT+IEhhypj7D/PwqeFaL95W7v5NUceMg/HzzkyowCvBZn3QIeqdswnpmg0GcBg4W9bI7RZryt2AT+W5iM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c01:b0:5d1:104a:acb5 with SMTP id
 cl1-20020a05690c0c0100b005d1104aacb5mr53522ywb.2.1702335422457; Mon, 11 Dec
 2023 14:57:02 -0800 (PST)
Date:   Mon, 11 Dec 2023 14:57:00 -0800
In-Reply-To: <865y16b6cf.wl-maz@kernel.org>
Mime-Version: 1.0
References: <SYBPR01MB687069BFC9744585B4EEF8C49D88A@SYBPR01MB6870.ausprd01.prod.outlook.com>
 <SYBPR01MB6870FDFBB88F879C735198F39D88A@SYBPR01MB6870.ausprd01.prod.outlook.com>
 <865y16b6cf.wl-maz@kernel.org>
Message-ID: <ZXeTvCLURmwzpDkP@google.com>
Subject: Re: [PATCH v3 1/5] KVM: Add arch specific interfaces for sampling
 guest callchains
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Tianyi Liu <i.pear@outlook.com>, pbonzini@redhat.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        mlevitsk@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023, Marc Zyngier wrote:
> On Sun, 10 Dec 2023 08:12:18 +0000, Tianyi Liu <i.pear@outlook.com> wrote:
> > +bool kvm_arch_vcpu_read_virt(struct kvm_vcpu *vcpu, gva_t addr, void *dest, unsigned int length)
> > +{
> > +	/* TODO: implement */
> > +	return false;
> > +}
> 
> I don't do it very often, but the only thing I can say about this is
> *NAK*.
> 
> You have decided to ignore the previous review comments, which is your
> prerogative. However, I absolutely refuse to add half baked and
> *dangerous* stuff to the arm64's version of KVM.
> 
> If you can convince the x86 folks that they absolutely want this, fine
> by me. But this need to be a buy-in interface, not something that is
> required for each and every architecture to have stubs, wrongly
> suggesting that extra work is needed.
> 
> For arm64, the way to go is to have this in userspace. Which is both
> easy to implement and safe. And until we have such a userspace
> implementation as a baseline, I will not consider a kernel
> version.

I too want more justification of why this needs to be handled in the kernel[*].
The usefulness of this is dubious for many modern setups/workloads, and outright
undesirable for some, e.g. many (most?) cloud providers want to make it all but
impossible to access customer data.

[*] https://lore.kernel.org/all/ZSlNsn-f1j2bB8pW@FVFF77S0Q05N.cambridge.arm.com
