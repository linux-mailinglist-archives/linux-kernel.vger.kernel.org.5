Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546B0759707
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGSNfD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGSNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:34:53 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8ED11B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:34:49 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a3c77e0154so4999745b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773688; x=1692365688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hOHfI48cJJvjh3hiXU4UP9h02hFndeaP36jJ0WH2IE=;
        b=Ogboe7xnAGvr+uR9hbRNMCzCTq4RHppsFYYpQ/15Bq74JJ06I9iOrgACExYsMTLGJV
         1oWlgH+61U4ksPWk8efsEZY7ilX1lrgo8OtC1izvymOw0FRZyt7TgJZrp+DVUpHamhF7
         lOOgUoof7MTZ88IVvbH3T/rvA7KBQVMXbzu4+ALCPltFqXkSYpp111zp70DyDOR6cl90
         iaIVHssrfJFZijFU5Dc4OyLWdNcVs2cX2BOxVfuktRIweHsW8JxWwc9zVGrCC9SM6Mmz
         WIVXuuWqMoEozbgLkr8w/bDm4bJUpbkMUswlqMTuldvwZ2dt0B68ScRQ1K06QpThcklY
         EFQg==
X-Gm-Message-State: ABy/qLZxVQcoXyjUQIzf49rafFxLxvZ7lxMIBv6tSQuTy7FCuLccmTrb
        mZmLPEC+lQdORw0xu4gJNbYEsCb6xCz8uw==
X-Google-Smtp-Source: APBJJlGiUtYdsadshTLo4NzZ/FWgs1RqAdsVxofdlIZ956rUo/TATmb8qfZAWcTfER2YuH1ewdTmZA==
X-Received: by 2002:a05:6358:3393:b0:133:e1e:f0b5 with SMTP id i19-20020a056358339300b001330e1ef0b5mr2735554rwd.12.1689773688058;
        Wed, 19 Jul 2023 06:34:48 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id f7-20020a5b0c07000000b00ca6d2ad070csm839270ybq.29.2023.07.19.06.34.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:34:47 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5774098f16eso73635717b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:34:47 -0700 (PDT)
X-Received: by 2002:a0d:d247:0:b0:583:437f:cf8a with SMTP id
 u68-20020a0dd247000000b00583437fcf8amr3088987ywd.24.1689773687000; Wed, 19
 Jul 2023 06:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com> <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
 <CABgObfb_jGgs-yMSsHtHhEStFDp4f072LN7pW+3dSuVhAP87Ag@mail.gmail.com>
 <ZLa/R9tZ0hB0KOXj@redhat.com> <CABgObfZjVrGOSn8iuFeUBOv3NAU_HB-6vtUTCRcSPW=Guua1jQ@mail.gmail.com>
In-Reply-To: <CABgObfZjVrGOSn8iuFeUBOv3NAU_HB-6vtUTCRcSPW=Guua1jQ@mail.gmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Wed, 19 Jul 2023 14:34:34 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnR6DBPxwdbP9jJRLzkryaoz++Nkxx5KV-3RdHL5PXKoqQ@mail.gmail.com>
Message-ID: <CAMw=ZnR6DBPxwdbP9jJRLzkryaoz++Nkxx5KV-3RdHL5PXKoqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 14:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Tue, Jul 18, 2023 at 6:35 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > There's a slight caveat that when parsing sbat shim currently appears
> > to store the generation number in a uint16, so the size is somewhat
> > limited. Probably still just enough bits to encode a kernel version,
> > though changing shim code to uint32 looks easy enough too.
>
> Encoding a kernel version needs a uint32 if you want to make it human
> readable; you need at least 10^6 (9.99.999) for the upstream version.
>
> However a SBAT policy based on kernel versions will not allow stable
> versions, so it's basically unusable.
>
> One possibility would be to encode the major and minor versions as
> different products, so a Fedora package for Linux 6.1.137 would have:
>
> linux.6,1,Linux,https://kernel.org/
> linux.6.1,137,Linux 6.1.y,6.1.137,https://kernel.org/
> linux.6.1.fc38,302,Fedora,6.1.137-302.fc38,https://koji.fedoraproject.org/koji/packageinfo?packageID=8
>
> where old kernel versions can be "prohibited" without consuming too
> much space in the policy, for example
>
> linux.5,255       # block all 5.x kernels.
> linux.6.1,138    # oh no, 6.1.137 had a *really* bad vulnerability
>
> The questions then are
>
> 1) if this satisfies the requirements
>
> 2) if upstream people accept to expose the version in this format in
> the upstream kernel

That doesn't work, because it requires a new line for each new
release, which means the sbat revocation variable and payload have
unbounded growth, and the number one goal of this mechanism was to
avoid exactly that. That's why it's a generation id, and that's why
it's per-product.

Once again: this is not some generic, multi-purpose tracking. This is
not for human consumption. This is not a substitute for a version, or
a bug tracker, or whatever else. This does not inform users of
anything.
This is a machine-targeted mechanism to allow centrally-managed
revocations for the UEFI 3rd party CA + Shim flow in a way that works
for the constrained EFI environment w.r.t size, wear and tear, in
substitution of DBX which is not fit for this purpose.

> > Directly encoding the version number though has implications for
> > revokation wrt stable branches though. My impression is that the
> > generation number was intentionally separate from a version number,
> > so that people could backport particular fixes to a stable branch
> > and then declare it to be the same "generation" as the latest
> > devel branch, or other stable branches which also included the
> > equiv fixes.
>
> Right, but that also requires a central authority that makes up these
> revocation indices. This is unlikely to happen for Linux. :)

It will happen, the only question is how painful it is going to be to
maintain it. The revocation payload is unique and global, and it could
not be otherwise. Just like DBX is published centrally, and just like
Shim signing is done centrally.
