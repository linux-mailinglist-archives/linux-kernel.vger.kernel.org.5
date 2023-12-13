Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E918A81229C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjLMXKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:10:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BDD0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:10:28 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e19414f714so39479847b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702509027; x=1703113827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUqoDbZM9AopeA8SWQ56D3q7Q5pOcG2dnxXupG6r4AM=;
        b=Ps6YFuZWcYOBgvbAejx+2etW7sQb71fvhn6DU5QSVgdDdRoCp7E4/qn/oWnb/4/q32
         +dCCQp1pBFtMaBanO9n96vbs3G8/NT9JlMw5vq9FaNDGdyr2qRZHDK5xxtXc1X+7Ie/j
         PRRjCvb+EZj3x9ruEH5cvuagLa7nvEhRGDfXxRrUlCI+78JpZbY9A1tExCvvfKRxcBI6
         hkMXGUVETtq/SAE1bwd1uYWwMZDh3TUaOQqJyqUj0ZGcT6g8Xws7thBAP4HdPz61Cdys
         yXtPnXIpj29B+1zO9I55kZvDjXzkZ2b4vSfVIcbfI4UlMYMbpyyKkG+YmtBqACwROnH8
         PCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702509027; x=1703113827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUqoDbZM9AopeA8SWQ56D3q7Q5pOcG2dnxXupG6r4AM=;
        b=LP5MzPGUcDz8dmChWrhTfnf+3+eoIdnH903tadegelqyvkVdh9GlqxPQV2sy7B4A1y
         dfAEv9Jf+Y8Rfbtlc18yXWnAjR2Cl2GWi0db2IYeqxRP2Ns08q+w/Sxk6OatQQ2uTRI3
         us4qbxJWz+hnyZ2ZkQOh3TkiEs+rSe0FzBNH8FzOiAP0WEvnNlo31PKlxN4zeA6bsUQG
         WAsAHSc9Nlol/TIVNe2xqnn0CFGs6j3uOLEUAsTmeU3B4H6DK60drP39XlSnt8LB2iuK
         VB5I4mR9wlNgMTHcGVUe5Uj+2+zyRYqZdWmHv0x9IJJ87TC3aMANMrqPxKwQKe5CAP8z
         19ww==
X-Gm-Message-State: AOJu0Yzbbpy+kJ6YcwMpeVJh6NAr19vHjGR/Y/b9kap1mAxA9Nf1Vte/
        nLAd9lYgXaK/rUM2D/o7/RMCq+uygPM=
X-Google-Smtp-Source: AGHT+IF4eGkuED2YgGkikQHjB/qkyEMf7VDdEnq9on8ks3iMiGrniK1KQ/mlVQ/drqNz1BaE3Btrpi0R9vk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d0e:b0:5d7:9a6c:54aa with SMTP id
 cn14-20020a05690c0d0e00b005d79a6c54aamr98099ywb.5.1702509027129; Wed, 13 Dec
 2023 15:10:27 -0800 (PST)
Date:   Wed, 13 Dec 2023 15:10:25 -0800
In-Reply-To: <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com>
Mime-Version: 1.0
References: <cover.1699936040.git.isaku.yamahata@intel.com>
 <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
 <938efd3cfcb25d828deab0cc0ba797177cc69602.camel@redhat.com>
Message-ID: <ZXo54VNuIqbMsYv-@google.com>
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
> On Mon, 2023-11-13 at 20:35 -0800, isaku.yamahata@intel.com wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > TDX virtualizes the advertised APIC bus frequency to be 25MHz. 
> 
> Can you explain a bit better why TDX needs this? I am not familiar
> with TDX well enough yet to fully understand.

TDX (the module/architecture) hardcodes the core crystal frequency to 25Mhz,
whereas KVM hardcodes the APIC bus frequency to 1Ghz.  And TDX (again, the module)
*unconditionally* enumerates CPUID 0x15 to TDX guests, i.e. _tells_ the guest that
the frequency is 25MHz regardless of what the VMM/hypervisor actually emulates.
And so the guest skips calibrating the APIC timer, which results in the guest
scheduling timer interrupts waaaaaaay too frequently, i.e. the guest ends up
gettings interrupts at 40x the rate it wants.

Upstream KVM's non-TDX behavior is fine, because KVM doesn't advertise support
for CPUID 0x15, i.e. doesn't announce to host userspace that it's safe to expose
CPUID 0x15 to the guest.  Because TDX makes exposing CPUID 0x15 mandatory, KVM
needs to be taught to correctly emulate the guest's APIC bus frequency, a.k.a.
the TDX guest core crystal frequency of 25Mhz.

I halfheartedly floated the idea of "fixing" the TDX module/architecture to either
use 1Ghz as the base frequency (off list), but it definitely isn't a hill worth
dying on since the KVM changes are relatively simple.

https://lore.kernel.org/all/ZSnIKQ4bUavAtBz6@google.com
