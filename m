Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503D9779CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjHLC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjHLC5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:57:25 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F553581
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:57:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-686e7b27f55so3359573b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691809044; x=1692413844;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tS5bjxGvXHgpjsR89BBAVK24EK+MfHyO8qai22TwsEE=;
        b=0xRjApE/U2RYFS+YWsLHyC/7iP6MlrHOrokf6+FnoBtk43mlqfsrwUv8M/FWPvEMxR
         n/IlPK4ZSgwFLSbugSEe11CEcWK596MYNaTc12vJSoAXiB1Q1S7E8n37GfCZUNiVvLzI
         mRF9H2wv+hFDorBRRf0l7Sw+fQIW7GKXBv+wgFEO59Y6UibZvqkgqZo5NUb1VE42c153
         /A+4DJCLf+ZnVVCqjLqNnGQGAo6FN6HMe3AJ52aiNQVCOQjPj7XO79l+tXRnicRvwlOn
         T6m2ifmiho+Xy1m3EYbG0oKMwPo60tZZE6K5+uLlTIsCqNkCdnZkE3mujYPrz/swJMoL
         SLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691809044; x=1692413844;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tS5bjxGvXHgpjsR89BBAVK24EK+MfHyO8qai22TwsEE=;
        b=LRWYcaQbEztBJJfoVAm6tbue92dR3wLosBKeu9+SispM+Mcaq7WJohEOgh2W6kmgez
         TNnN3Q1vMJZN+dHXobB+OwWBefxQmCUJ1Y7Sn46J1lbE/BN7bWO99J/40XmRrTAjNLdF
         87VoKi1Rx3xGOVCRWe0+9OquXDOK055BAVRu7vZK0nYSYTC1tNGOfKjv5ry7VBUSlwD3
         H0L6qN4DtTYPKoMW0yAQOnEYcPMpWEUiJPYYE7+KPOdDRuhrFwT+9A5EGgfzfek6ceQ9
         TOwQrU3TzOOaYAC4PGP7JgYiqQ6gf9y/f126LwAkfEtpOMBvn3HgNHVZvwBWPKYBtdFJ
         VPxw==
X-Gm-Message-State: AOJu0YwUw+ECiQ5Q9qG6hLz8bW2Cr1R9uSs7kAD+YQBqCgG2XqhYja4l
        stQRfE8gffSJLHV4Hk5UAtMuILj+hH8=
X-Google-Smtp-Source: AGHT+IFUZBQeQ6IXU+PWByB0C9HZCEmzHADTXcVvXMNbSAzt3QPkvaokh4WVr9x/O5cMStF3DhjL4D6etL0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3928:b0:686:df16:f887 with SMTP id
 fh40-20020a056a00392800b00686df16f887mr1611366pfb.6.1691809043752; Fri, 11
 Aug 2023 19:57:23 -0700 (PDT)
Date:   Fri, 11 Aug 2023 19:57:22 -0700
In-Reply-To: <8edc91f9-ce20-9528-a496-5b6e650bb63f@redhat.com>
Mime-Version: 1.0
References: <20230811155255.250835-1-seanjc@google.com> <8edc91f9-ce20-9528-a496-5b6e650bb63f@redhat.com>
Message-ID: <ZNb1EpG1GDzRspPB@google.com>
Subject: Re: [PATCH] x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()
From:   Sean Christopherson <seanjc@google.com>
To:     "Mika =?utf-8?B?UGVudHRpbMOk?=" <mpenttil@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Srikanth Aithal <sraithal@amd.com>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023, Mika Penttil=C3=A4 wrote:
> > @@ -252,11 +252,10 @@ SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_N=
ONE)
> >   	.byte 0x48, 0xb8
> >   SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
> > -	add $8, %_ASM_SP
> > +	lea 8(%_ASM_SP), %_ASM_SP
> >   	ret
> >   	int3
> >   	int3
> > -	int3
> >   	lfence
> >   	call srso_safe_ret
> >   	int3
> >=20
> > base-commit: 25aa0bebba72b318e71fe205bfd1236550cc9534
>=20
> Don't we have the same kind of problems with __x86_return_skl ?

Yep, forcing that path via "retbleed=3Dforce retbleed=3Dstuff spectre_v2=3D=
retpoline,generic"
yields the same failures.  I have no idea how to go about cleanly fixing th=
at.
The logic effectively requires modifying flags, the only thing I can think =
of is
to save/restore flags across the thunk, which seems beyond gross.

Given that no one has complained about this, I think I'd vote to simply dis=
able
KVM if call depth tracking is being used.
