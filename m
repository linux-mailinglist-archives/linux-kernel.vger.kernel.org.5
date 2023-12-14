Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71C813686
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjLNQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjLNQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:41:39 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1601114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:41:45 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5cd5a1ad43aso312537a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702572105; x=1703176905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuDIlHPXc3h0xC5YU4/ai6dB8VlmCAB/+AvZ2ucJ1/U=;
        b=ludcU88/lGdmhVEW+b4J9KNQCqOjUyJndxHEHxyFA2tyw7xi4lao+CAXJmt7bQ5Uhd
         lOGxVGx2ooC/5GZcFYE1Zs3FrouwdoKxnxRe/uTE36XXzmQYvF8QRGMhtQbIRp5Xazb0
         N2JzsbsAoXCydVGACzQ+plMn11/u6Jpbm5xgKqZ2n6FiRzcuJydQ6drjFmaLCxXVDt9b
         pPsBiPmXZvfFw9bg2VyS1O2RBMtKgZnMrXq3TIl4bldw3TMG1lxLaXFtYWkae+wgb99G
         CwItHcYy7RNJ+BdGNBtrmO9C19xpJOUEzpELBiIoON/yqwZTcftbsl9I9oKsIXKtsCVF
         ysaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572105; x=1703176905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuDIlHPXc3h0xC5YU4/ai6dB8VlmCAB/+AvZ2ucJ1/U=;
        b=B0expfFl9tgjjL7mwi6iinu36NMtYI4BXN20u7rjdpdj6vzrb81R1qxQoMSQvovu4A
         OSAmpjxVZaUdh7ryOVyIiXFQlmc0B/lT9rHvyiAbkbu+jRdxGYkgx2DDrWWPRW+Q5ShU
         EeB0tfX1qGMmXdH7FLPOdyft1EMLw3jZC565U2RXrs8ohA2oM8IUHXoZbB5n7/VHZcYX
         AssQu8l9aoYtvZvd3UldoT58KzcHLK/VNhdkXcXkpbm7s/nqBz+gsJDzYSyBHeGqGIQn
         DTa8qoqtjw7UnY+ZcdnHMVwlXfE2oOFcuPkOzAKXUNizjZuIatYrj4XnUgVDoX4WEsc0
         2S3A==
X-Gm-Message-State: AOJu0YzFtMdxXRo3GUC9+JL5UQRtqnlnD8v3UHyLzc+mBEjq/d4Aaeko
        6w8WG7zShFvH0fbCrsyZ3XsRv6hTsos=
X-Google-Smtp-Source: AGHT+IEprhiATuTdUWMrDqAwIvYwY4NpyGfKixHgWQGjoC7m8JjaRWItR9a08wY6L5ZSGKdGQrSv392O7Xo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:418a:0:b0:5ca:4357:347f with SMTP id
 a10-20020a65418a000000b005ca4357347fmr567734pgq.7.1702572105188; Thu, 14 Dec
 2023 08:41:45 -0800 (PST)
Date:   Thu, 14 Dec 2023 08:41:43 -0800
In-Reply-To: <aa7aa5ea5b112a0ec70c6276beb281e19c052f0e.camel@redhat.com>
Mime-Version: 1.0
References: <cover.1699936040.git.isaku.yamahata@intel.com>
 <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
 <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com>
 <ZXo54VNuIqbMsYv-@google.com> <aa7aa5ea5b112a0ec70c6276beb281e19c052f0e.camel@redhat.com>
Message-ID: <ZXswR04H9Tl7xlyj@google.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Make the hardcoded APIC bus frequency vm variable
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Vishal Annapurve <vannapurve@google.com>,
        Jim Mattson <jmattson@google.com>
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

On Thu, Dec 14, 2023, Maxim Levitsky wrote:
> On Wed, 2023-12-13 at 15:10 -0800, Sean Christopherson wrote:
> > Upstream KVM's non-TDX behavior is fine, because KVM doesn't advertise support
> > for CPUID 0x15, i.e. doesn't announce to host userspace that it's safe to expose
> > CPUID 0x15 to the guest.  Because TDX makes exposing CPUID 0x15 mandatory, KVM
> > needs to be taught to correctly emulate the guest's APIC bus frequency, a.k.a.
> > the TDX guest core crystal frequency of 25Mhz.
> 
> I assume that TDX doesn't allow to change the CPUID 0x15 leaf.

Correct.  I meant to call that out below, but left my sentence half-finished.  It
was supposed to say:

  I halfheartedly floated the idea of "fixing" the TDX module/architecture to either
  use 1Ghz as the base frequency or to allow configuring the base frequency
  advertised to the guest.

> > I halfheartedly floated the idea of "fixing" the TDX module/architecture to either
> > use 1Ghz as the base frequency (off list), but it definitely isn't a hill worth
> > dying on since the KVM changes are relatively simple.
> > 
> > https://lore.kernel.org/all/ZSnIKQ4bUavAtBz6@google.com
> > 
> 
> Best regards,
> 	Maxim Levitsky
> 
