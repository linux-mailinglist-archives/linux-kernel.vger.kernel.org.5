Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016E47BEAAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378450AbjJITeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378443AbjJITd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:33:57 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5ED93
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:33:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-58d54f322c6so1889175a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696880035; x=1697484835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIAr8DPfh+qMIaRmwoAlJ+K4B6ZX16dNQ2a3o/4VJ9I=;
        b=XALda4cKKkaYprWGEkpE21aEPAUwgqx52xipa4+ankXckFsHspZjrMmutDqT6M0s9N
         VDy3C4SXxcDjAZMYmRP3eqCCTn04mj3ceBzf1/6dLKnCdf3wbOQAB5+2z5jxE821+drT
         pqVUltva8tUguLuzEYynhQQleeNwVkxueV6vxD7YErx9almeNHcVBMWkm3hCa8b9uCCD
         E4eDpAU8BcqemnmCEMR6eYYzoGujz5j4R2CWkAM16wLuXFv2fdZX+ddWemJ544pg85C0
         v1RV4iZtcvRItTXVdF9zm3Cx7yfDvaLsBKqZWRmxduHhjJeCxXtY7Q2h6npiSG2QE3vt
         oCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880035; x=1697484835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIAr8DPfh+qMIaRmwoAlJ+K4B6ZX16dNQ2a3o/4VJ9I=;
        b=LLu9E8ZfbdieLEM5+x1q8bbceR4b1O2Lx9Qs0nUqcVwGMs/wNAim6fAopSzigSUoIo
         aJvh8xOj+X6VR6H2bG9bqKSBX46KjRyUg79g1i4YwySebmsIp0Wt7fPHf/EWGyUE9wNz
         Sg8oK1/cN0Wso0kONeFc2YlKMPmlHWozRuUtiHG5xcFiGhcaCzlPpf4ZGmkHMxnRB/H0
         yDLXPmzZ6h2a73FYVIx/lfz9oETW1SNJrS7Z+n/HSQlD43hkC0pi+zQIk7RpzO5BFZ5q
         xG8Tas+RYToG2cZRdRa2pfEw5z1VoIUPy8x7ERPS2GqTQ9VBpprCDu16V3J8efwiqpHa
         gu5g==
X-Gm-Message-State: AOJu0YyySXHMUNOWnf66U2VNmbT3Vg5776jff459zZpwisWpDpCPbZx6
        OLD7stMVYt0TVMKVljdEzWt7g6SFSAE=
X-Google-Smtp-Source: AGHT+IE+bCR4ihgMmpiXgbNhSP5Vgu2CEPjeNQ9Yi6y1+8EM0hWz4Lu0bXeDtqwwTuiBXuOI0tlfBWMKDWg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:aa84:b0:279:84c3:4ab4 with SMTP id
 l4-20020a17090aaa8400b0027984c34ab4mr279179pjq.9.1696880035378; Mon, 09 Oct
 2023 12:33:55 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:33:53 -0700
In-Reply-To: <20231009110613.2405ff47@kernel.org>
Mime-Version: 1.0
References: <20231006205415.3501535-1-kuba@kernel.org> <ZSQ7z8gqIemJQXI6@google.com>
 <20231009110613.2405ff47@kernel.org>
Message-ID: <ZSRVoYbCuDXc7aR7@google.com>
Subject: Re: [PATCH] KVM: deprecate KVM_WERROR in favor of general WERROR
From:   Sean Christopherson <seanjc@google.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     pbonzini@redhat.com, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023, Jakub Kicinski wrote:
> On Mon, 9 Oct 2023 10:43:43 -0700 Sean Christopherson wrote:
> > On Fri, Oct 06, 2023, Jakub Kicinski wrote:
> > On a related topic, this is comically stale as WERROR is on by default for both
> > allmodconfig and allyesconfig, which work because they trigger 64-bit builds.
> > And KASAN on x86 is 64-bit only.
> > 
> > Rather than yank out KVM_WERROR entirely, what if we make default=n and trim the
> > depends down to "KVM && EXPERT && !KASAN"?  E.g.
> 
> IMO setting WERROR is a bit perverse. The way I see it WERROR is a
> crutch for people who don't have the time / infra to properly build
> test changes they send to Linus. Or wait for build bots to do their job.

KVM_WERROR reduces the probability of issues in patches being sent to *me*.  The
reality is that most contributors do not have the knowledge and/or resources to
"properly" build test changes without specific guidance on what/how to test, or
what configs to prioritize.

Nor is it realistic to expect that build bots will detect every issue in every
possible configuration in every patch that's posted.

Call -Werror a crutch if you will, but for me it's a crutch that I'm more than
willing to lean on in order to increase the overall quality of KVM x86 submissions.

> We do have sympathy for these folks, we are mostly volunteers after
> all. At the same time someone's under-investment should not be causing
> pain to those of us who _do_ build test stuff carefully.

This is a bit over the top.  Yeah, I need to add W=1 to my build scripts, but that's
not a lack of investment, just an oversight.  Though in this case it likely wouldn't
have made any difference since Paolo grabbed the patches directly and might have
even bypassed linux-next.  But again I would argue that's bad process, not a lack
of investment.

> Rather than tweak stuff I'd prefer if we could agree that local -Werror
> is anti-social :(
> 
> The global WERROR seems to be a good compromise.

I disagree.  WERROR simply doesn't provide the same coverage.  E.g. it can't be
enabled for i386 without tuning FRAME_WARN, which (a) won't be at all obvious to
the average contributor and (b) increasing FRAME_WARN effectively reduces the
test coverage of KVM i386.

For KVM x86, I want the rules for contributing to be clearly documented, and as
simple as possible.  I don't see a sane way to achieve that with WERROR=y.
