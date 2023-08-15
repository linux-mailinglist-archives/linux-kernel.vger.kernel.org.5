Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB00A77CE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbjHOO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbjHOO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:28:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555DB8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:27:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe1455e7feso2930e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692109678; x=1692714478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ9oy81Q2bjddT4WacBoL1TWsIfqzen9WNDb12yo1Yg=;
        b=Y4AIcDyra8RSM6sN57Ubt0uvp0A0BjyLdLE2CoJmaN4ayRU7PPvjBzDsgYRktCr/Vq
         UvNjwgoFHZVsQSqxHaf/Niy0uvYVnFJpVX6rj7bQT/bRDKWdCOujmuGVKb2tERhZsoQ/
         //hA70Nvzu6x2735beUrFRek8pPCbjy9Y/SxILPavBbLoMxeiCHpf0HePwsyiJ7wzB1r
         E0ROIle+HiZtPaAytY+6TdK4rnQkz3b1EXQ8Qc2GMlCUKwOLj9B52DscGvuYFLH2R8Rr
         VpF+5W/SEiDIGg+uhQ9L9LlO0zSlSY1jZwyzO33Iy9SNPXG5aBHlVdze34lWtAsX2XoB
         wzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109678; x=1692714478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZ9oy81Q2bjddT4WacBoL1TWsIfqzen9WNDb12yo1Yg=;
        b=OMjws7hcE08fo42IHeXGfOcc2M5mnOhwpZnBr59DftrPoHOsGawzO8ZpX/7y5dDUnI
         M8rVn9IxYHHuHGOBj13sxZBqo1cq9VBV6Z4T6OWIaw/fgQIVl5+YpEKbP7pR0mnaPbhy
         yByjyoEcAHSkwZnXXWa++9+0ZXDLWSwJ6H33ZdtjjiKhL8OoyBH6j0hUBmtq/hmwyo0p
         5LFVfx64InnhN8EgFys4a8NP0rhhEoztq8Tqq8MusVze1yJD9dHB4lY5I98a8FJs5lmj
         Rsy5OOywb0TJX8OUwwVtFxsuoS/HJFs3ui60fGhdrg26CiBE0yMjlpWRXbhhXZ0hBWD3
         R7fg==
X-Gm-Message-State: AOJu0YwCDRj7+Hk+Tsn5uhLWoKKqTqigAlSVku331dxqP0AstB+Ojh6Y
        HtkFmPDui3a0Ghe67gsjNsx7Q058cilIlHNnpRotGg==
X-Google-Smtp-Source: AGHT+IEUQKoSX/xyep+Pw7cPlYuyRZHbp5+0KjNE1t9dIGvH6RZIr2a4mKmI5IhOZCP1utwAf0/knZ0zm/72aPwJG+w=
X-Received: by 2002:ac2:593a:0:b0:4fe:3fb3:902d with SMTP id
 v26-20020ac2593a000000b004fe3fb3902dmr212771lfi.5.1692109677951; Tue, 15 Aug
 2023 07:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com> <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 15 Aug 2023 08:27:46 -0600
Message-ID: <CAMkAt6q1ZedWBQ+ZLmD5QRKc0jcz2nrdwEAw6g8R2fZ5e2ed_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-coco@lists.linux.dev, Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:12=E2=80=AFAM Dan Williams <dan.j.williams@intel=
.com> wrote:
>
> Jeremi Piotrowski wrote:
> > On 8/14/2023 9:43 AM, Dan Williams wrote:
> > > Changes since v1:
> > > - Switch from Keyring to sysfs (James)
> > >
> > > An attestation report is signed evidence of how a Trusted Virtual
> > > Machine (TVM) was launched and its current state. A verifying party u=
ses
> > > the report to make judgements of the confidentiality and integrity of
> > > that execution environment. Upon successful attestation the verifying
> > > party may, for example, proceed to deploy secrets to the TVM to carry
> > > out a workload. Multiple confidential computing platforms share this
> > > similar flow.
> > >
> > > The approach of adding adding new char devs and new ioctls, for what
> > > amounts to the same logical functionality with minor formatting
> > > differences across vendors [1], is untenable. Common concepts and the
> > > community benefit from common infrastructure.
> > >
> > > Use sysfs for this facility for maintainability compared to ioctl(). =
The
> > > expectation is that this interface is a boot time, configure once, ge=
t
> > > report, and done flow. I.e. not something that receives ongoing
> > > transactions at runtime. However, runtime retrieval is not precluded =
and
> > > a mechanism to detect potential configuration conflicts from
> > > multiple-threads using this interface is included.
> > >
> >
> > I wanted to speak up to say that this does not align with the needs we =
have
> > in the Confidential Containers project. We want to be able to perform a=
ttestation
> > not just once during boot but during the lifecycle of the confidential =
VM. We
> > may need to fetch a fresh attestation report from a trusted agent but a=
lso from
> > arbitrary applications running in containers.
> >
> > The trusted agent might need attestation when launching a new container=
 from an
> > encrypted container image or when a new secret is being added to the VM=
 - both
> > of these events may happen at any time (also when containerized applica=
tions
> > are already executing).
> >
> > Container applications have their own uses for attestation, such as whe=
n they need
> > to fetch keys required to decrypt payloads. We also have things like pe=
rforming
> > attestation when establishing a TLS or ssh connection to provide an att=
ested e2e
> > encrypted communication channel.
>
> ...and you expect that the boot time attestation becomes invalidated
> later at run time such that ongoing round trips to the TSM are needed? I
> am looking at "Table 21. ATTESTATION_REPORT Structure" for example and
> not seeing data there that changes from one request to the next. Runtime
> validation likely looks more like the vTPM use case with PCRs. That will
> leverage the existing / common TPM ABI.

I thought we were dropping the TSM acronym as requested by Jarkko?

Why do we need to be so prescriptive about "boot time" vs "runtime"
attestations? A user may wish to attest to several requests as Jeremi
notes. And why should users be forced into using a vTPM interface if
their usecase doesn't require all the features and complexity of a
vTPM? Some users may prefer less overall code within their Trusted
Computer Base (TCB) and a TPM emulate is a significant code base.

It seems like you are just reading the SNP spec, if you read the TDX
spec you'll see there are RTMRs which can be extended with new data.
This leads to a different data in the attestation. Similar there are
REMs in the ARM CCA spec.

>
> > I don't think sysfs is suitable for such concurrent transactions. Also =
if you think
> > about exposing the sysfs interface to an application in a container, th=
is requires
> > bind mounting rw part of the sysfs tree into the mount namespace - not =
ideal.
>
> sysfs is not suitable for concurrent transactions. The container would
> need to have an alternate path to request that the singleton owner of
> the interface generate new reports, or use the boot time attestation to
> derive per container communication sessions to the attestation agent.
