Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24F17B0C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjI0TGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0TGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:06:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51EDE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:05:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c12ae20a5cso193426451fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695841557; x=1696446357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cthrC2AE+hQRI1g23zDyJaz/ao2H94DB6TkDVFhMAT8=;
        b=N2nxCeQN0jS3NFquLLzHVyHRFuYUVcs4cJEIEPzqGvLwi3IIjLaGnoquWzhvFapMgx
         aTevExdi96jlmH0orXSyA+E2xYdvZc4UehVEoc4EYkyW7fAtZz0J50AiXtrriDwR1KW7
         tu69e6K8oFgzmdhkp2jV3P2ZUandmXsvyulKfOtRrowD6AhQgAdUNKP9jdML6T9z+NCF
         K9jaFdxQZaooJN8Vz7ADGfiRHYKn0A1oD0GfHXJsiex6Y4KGTnUX8Pw+BuywA2efXnTU
         swQfOCATm4sVGPLYVYHWLvUv+KgPIxrlZX02CFVuNiiooeF+l5wUdyG3tLh3pvoDR2ID
         wVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841557; x=1696446357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cthrC2AE+hQRI1g23zDyJaz/ao2H94DB6TkDVFhMAT8=;
        b=JHyqtLsdJgisIKmF81Le6A3Eq+wvnQsD1sxYe+kDyzmfcKT5a+cBQlC6aA92oAoGXd
         DXxcld+FTRbaKOGhm947ZddFDMUaWm+naP02lARjuXm3ydHWhWVwybxOT99s+rt/M/ER
         rSy0PVX0zYYa5DrikfvdgLuHYPATAY5rX2XR/J1c719joSwLQZuu0wlubInuNL1yzSdr
         dxxwmIs5bBW3luuemH5iWHOVJOTwHN5HLESvzMyxdB259iMI3UWMu2CsZ32baz343JT1
         q9csqCSRySsVOlo7F7TFpdWKYhcq2G8QkhhFOfSn7mXLmOxBtmFarFlItsnEy0ZaKuHP
         sYhQ==
X-Gm-Message-State: AOJu0YxCPbJO3K0qwUJHRzu/Q+SnHga7DxesQfInXaNJd7w9eyEmK9qg
        j2pucfDQ3Tq4hrWN5+XqGTJJO8vkW/Y0OLrC8/05Bg==
X-Google-Smtp-Source: AGHT+IEG0GkBc5auFmv1wHBXddUXWoWjQW9Z1kvH5V3ktssd5ya+XFoxO3wtAkfETADcwfDgbMgCpIp9vEJoQNv/VyQ=
X-Received: by 2002:a2e:9b94:0:b0:2bf:df8c:4e5e with SMTP id
 z20-20020a2e9b94000000b002bfdf8c4e5emr3021856lji.15.1695841555896; Wed, 27
 Sep 2023 12:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
 <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com> <CA+1=6yfmLXJbZu7Gd7cp_HOAbmHwx54aPgozWKBikWwZSYTOZw@mail.gmail.com>
 <6513e6079a427_91c1e294e@dwillia2-xfh.jf.intel.com.notmuch>
 <CA+1=6yeP6dDiXVQrxMt0AaEF_7S05p4Do67=ysXK-Chfvu-9ow@mail.gmail.com> <CAMkAt6ohEnYwC8yVzye0F4gApvuyktHDP-q8-p7gJnSAyRMR_Q@mail.gmail.com>
In-Reply-To: <CAMkAt6ohEnYwC8yVzye0F4gApvuyktHDP-q8-p7gJnSAyRMR_Q@mail.gmail.com>
From:   Thomas Fossati <thomas.fossati@linaro.org>
Date:   Wed, 27 Sep 2023 21:05:39 +0200
Message-ID: <CA+1=6yczjPCaPsVc+s9_HC-6pNk52VsFviMeqqDWR4v2RFDBjw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
To:     Peter Gonda <pgonda@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-coco@lists.linux.dev,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, 27 Sept 2023 at 16:38, Peter Gonda <pgonda@google.com> wrote:
>
> On Wed, Sep 27, 2023 at 2:25=E2=80=AFAM Thomas Fossati
> <thomas.fossati@linaro.org> wrote:
> >
> > On Wed, 27 Sept 2023 at 10:21, Dan Williams <dan.j.williams@intel.com> =
wrote:
> > > It can be expanded when/if those platforms expand the
> > > size of the supported user data, or another configfs-tsm backend arri=
ves
> > > that needs that capability.
> >
> > Makes sense, thanks.
>
> I'm not familiar with the rats eat spec but I would assume the
> protocol would acquire more than just the nonce in the inblob.
> Probably some combination of claims, nonce, and information about a
> public key?

Looking at existing EAT-based (or EAT-like) serialisations:

Arm CCA has a single, 64 bytes challenge (see =C2=A7A7 of =E2=80=9CRealm Ma=
nagement
Monitor (RMM) Specification=E2=80=9D [1].)

CoVE too, see [2].

Nitro instead is doing something different: GetAttestationDoc() has
optional user-provided public key, custom user data, and a custom
nonce passed in as separate input arguments [3].

So, what @inblob's structure looks like really is a choice of the
attester's vendor.

> Does the specification allow for the data needing to be
> signed by the TSM to be hashed first?

EAT per se is mostly agnostic, it has a flexible and extensible type
system, which can adapt to most attester =E2=80=9Cshapes=E2=80=9D.

Hope this answers your questions.

cheers, t

[1] https://developer.arm.com/documentation/den0137/latest
[2] https://github.com/riscv-non-isa/riscv-ap-tee/blob/main/specification/a=
ttestation.adoc#tvm-challenge-claim
[3] https://github.com/aws/aws-nitro-enclaves-nsm-api/blob/4b851f3006c6fa98=
f23dcffb2cba03b39de9b8af/nsm-lib/src/lib.rs#L218
