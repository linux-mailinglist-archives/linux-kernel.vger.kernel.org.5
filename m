Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D377BF94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHNSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjHNSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:12:01 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D91BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:12:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-267f1559391so5122276a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692036721; x=1692641521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=suQBuyBTpa1Y/bBNer/FTc8YPXcItgJUPYhrGzVVyIE=;
        b=u+Z2TwuU1JO2bdbYXp/6NZzqfPYs21JT70UjAp5kQjMKOUQuhnsHzmxCOGgsDomWmB
         sms6CllzH/6L9uNX5b2Qt2qQOkuftV7JcUn+u8Um66WzW9uOECxffazWywUPWpCrrMsz
         GMTXXvcVtnBM8Lz1yoRWxFk5kG3tFTStf9Z+S7txPrh7A4LWhhMOi0HMiO0wbbX8omEF
         v4ckzMwerdyD4SYaps1cxR+tCe48l2IIqi3BWRMhbw9sr5++aREFWvM8l1FgL9jGbdOo
         khys8hyaH7PPIK1BQha1q/qLcOq0IptWxfXgR8q1vLhAKhSNqmw+T8VBuoyi8E5WySIW
         9kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036721; x=1692641521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suQBuyBTpa1Y/bBNer/FTc8YPXcItgJUPYhrGzVVyIE=;
        b=fmKTZAxbbpYQWaqAg8P1mXmam2jpQOBKAkp97xaAzEMNK21WzDafAt6+maaDzVTcSd
         FA1SyeSaITd1JZSeLBSq3sFfI3z7UtJt6rUX88HGjw2V4SNF3W2xOzNL6PqjjHCc5CPF
         maXNodmWvo/Q6ZXbm30nxKRmu2jM+Jm21PXnAQFo8HsbeSI+Vb+AzOVPolh4WwRKK+9U
         PXa8ODsem51CYqMebGhxWnVJut8OaF/+GUq2JYv2i4ZflLFlwR0nVWRjqjGLSCwmsqEH
         guJTlewbTKFw7SG0C91KMC4vYMl+6NCzVqxAXvpF6T/y8kSwTqMyZvKX7RVu9qozUU3I
         f1ZQ==
X-Gm-Message-State: AOJu0Yx6Q1aBffRCuc+D+HidDCRQLOEgABhuUhDgHxOSQDzcPWz5zjQ8
        XzDNa0DFpyi7pvUrS1S++5lTY2KPCZQ=
X-Google-Smtp-Source: AGHT+IG18JOXEV2V0Dd+iEfdRE8/UEWygRGwVjf9lOB8DwoMuDyihgfL+6WHR/4OKZTaFCGMbE/TjH40WZ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:8c1:b0:268:553f:1933 with SMTP id
 ds1-20020a17090b08c100b00268553f1933mr2302283pjb.6.1692036720744; Mon, 14 Aug
 2023 11:12:00 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:11:59 -0700
In-Reply-To: <ZM006zd4bpsGBtWF@google.com>
Mime-Version: 1.0
References: <20230804004226.1984505-1-seanjc@google.com> <20230804004226.1984505-3-seanjc@google.com>
 <ZM0rXgKvb912k5BE@linux.dev> <ZM006zd4bpsGBtWF@google.com>
Message-ID: <ZNpub+NpmtSFaf8u@google.com>
Subject: Re: [PATCH 2/4] KVM: selftests: Add helper macros for ioctl()s that
 return file descriptors
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023, Sean Christopherson wrote:
> On Fri, Aug 04, 2023, Oliver Upton wrote:
> > Hi Sean,
> > 
> > On Thu, Aug 03, 2023 at 05:42:24PM -0700, Sean Christopherson wrote:
> > > Add KVM, VM, and vCPU scoped helpers for ioctl()s that return file
> > > descriptors, i.e. deduplicate code for asserting success on ioctls() for
> > > which a positive return value, not just zero, is considered success.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > I appreciate the desire to eliminate duplicate code, but I think the
> > naming just muddies the waters. TBH, when I first read the diff w/o the
> > changelog, I thought you were describing the input fd (i.e. 'kvm_fd',
> > 'vm_fd', 'vcpu_fd'). I don't think explicitly spelling out the condition
> > each time (i.e. ret >= 0) is all that difficult.
> 
> Yeah, but it's not just a desire to dedup code, I also am trying to funnel as
> many "ioctl() succeeded" asserts as possible into common code so that they naturally
> benefit from things like patch 4 (detecting dead/bugged VMs).
> 
> I agree the naming sucks.

The best naming scheme I can come up with is to be super literal:

	kvm_ioctl_non_negative
	vm_ioctl_non_negative
	vcpu_ioctl_non_negative

If that's still too kludgy and no one has a better idea, I'll just scrap this
patch.
