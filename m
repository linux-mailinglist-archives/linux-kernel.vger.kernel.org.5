Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14E8011F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378862AbjLARoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:44:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9EAB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:44:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3f951af5aso17271497b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701452675; x=1702057475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ygf4AvzbtFaf9glZ+qouIUJsoe+oZLlrurLDy90Za0=;
        b=ABNNAnoUu/L8gT7V2lI+PUYYdnPRTmItGfcyCwTFEZsPZE2s8d+s4oMtxi/oijUa2o
         5nf3w7LtbXfHxQm69dbxoHEQB5owVIGH3I18CWHHvFCVk2uvnRGipvPmdEvlJyG6wkVj
         IQ/NiWtnJ0d7HtQD46VEQWmhvaHkl9Ks9WF6vMYxjVbZuBSM9wi5PfJum7hdzea0W2u4
         dLTT9PkNKBk4D/HE+6mEMuJuipMaOw4breTOvEsOKEt7tZr6GxKquALfbUWtk4WXNqOm
         r6Mr3zFVergZ8oB/+Oc7lFfixTio1C0JRh8OEI6Mtq+LhiA7eTnqc+Eu2idbnWhdKpMZ
         qtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452675; x=1702057475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ygf4AvzbtFaf9glZ+qouIUJsoe+oZLlrurLDy90Za0=;
        b=d5nZy0hexwT/oz/EfsZW4cScEazCI7BnxqlYA2w1qeskIACY/IBXlF8Bi1oJVcwyFt
         431kCTcRPskrcHg7voSSQ+qNROGlqZpbmvtpK3tVyNKiaKTDb+eApLMtqa8sEPqninpa
         So/dMWcBtNej67Q0ntEitQbXfDp+QFLo/s3w56cs2jwwbhMpBjjB3H850P3bD/F5BwFv
         Eigo4jJjLH13JsN73X1XtFo1TTCw+6TTd0V7TIXSmGA3SuGtRbITHwaQ0y8Y7eF/34YS
         37+pAUERRauFdrG4xBVzE6XEJ2LQdtvU8SuI8Z+JOR3tksCxXoZ4ZmGViNCSroqhbSyT
         VlQQ==
X-Gm-Message-State: AOJu0YwYRiXok+YDv34LM2FWtCgdCQX+mTJT7Ek3UNkYGDIYwCQmGd3G
        qOYTi5z3ETrYRbiMKNm0kj0xeYELg8k=
X-Google-Smtp-Source: AGHT+IGz5rRtf+Aw1a0HRLQSALJFCvVn+N/Vb1N997Lzq8k/kSNFuy6WRIBEoj9el1rhRp1KOeWt0RITkWM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:448b:b0:5d4:35f:4a26 with SMTP id
 gr11-20020a05690c448b00b005d4035f4a26mr101157ywb.4.1701452674798; Fri, 01 Dec
 2023 09:44:34 -0800 (PST)
Date:   Fri, 1 Dec 2023 09:44:33 -0800
In-Reply-To: <a0c99edd584b47ce8f9f8aff86b2a568@amazon.co.uk>
Mime-Version: 1.0
References: <20231201104536.947-1-paul@xen.org> <ZWoNzzYiZtloNQiv@google.com> <a0c99edd584b47ce8f9f8aff86b2a568@amazon.co.uk>
Message-ID: <ZWobgUtVj5xmdJX7@google.com>
Subject: Re: [PATCH 0/2] KVM: xen: update shared_info when long_mode is set
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <pdurrant@amazon.co.uk>
Cc:     Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Dec 01, 2023, Paul Durrant wrote:
> > On Fri, Dec 01, 2023, Paul Durrant wrote:
> > > From: Paul Durrant <pdurrant@amazon.com>
> > >
> > > This series is based on my v9 of my "update shared_info and vcpu_info
> > > handling" series [1] and fixes an issue that was latent before the
> > > "allow shared_info to be mapped by fixed HVA" patch of that series allowed
> > > a VMM to set up shared_info before the VM booted and then leave it alone.
> > 
> > Uh, what?   If this is fixing an existing bug then it really shouldn't take a
> > dependency on a rather large and non-trivial series.  If the bug can only manifest
> > as a result of said series, then the fix absolutely belongs in that series.
> > 
> 
> There's been radio silence on that series for a while so I was unsure of the status.

v9 was posted the day before Thanksgiving, the week after plumbers, and a few
weeks after the merge window closed.  And it's an invasive series to some of KVM's
gnarliest code, i.e. it's not something that can be reviewed in passing.  We're
also entering both the holiday season and the end of the year when people get
sucked into annual reviews and whatnot.

I totally understand that it can be frustrating when upstream moves at a glacial
pace, but deviating from the established best practices is never going to speed
things up, and is almost always going to do the exact oppositie.
