Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B941B77D0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbjHORQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbjHORQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:16:21 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5BC19B5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:16:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so20931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692119779; x=1692724579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1WCcY1DTF2SDkL2C38h5/rIUZSGkzG/CsRQNgHvnx78=;
        b=M6Vx4wfJkJ366sFCowkGvQ+/tOWO0fxXKCqskj3hKgFn5l2JkDOB5JczHT5DRghjkp
         DV6VbcYG8D/gxiY83tG+Orw4OM1ZzoyIhFC7w4p9PWtNuqTFtKthCwrFzNqgt6CJ0gWm
         GsHptxsBfryyqd+kX21dJbj76UtP5YksoujiDKi18lAl4vcJhoH0DyG9S3Zq3RcxhOEC
         Yfti0RtdYszrEhnONH7e2kZvYknbFDgCf6y8YcD9RHfP//9dEUcwRJzrjh1PLL/D5Rr/
         VL+sDINBBTQZXBZg1Yvpumg3DuV7AdCL200x/BIOLDjEysi2fZpD6C8LosVbuyIUku1o
         kNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692119779; x=1692724579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WCcY1DTF2SDkL2C38h5/rIUZSGkzG/CsRQNgHvnx78=;
        b=BEM4/mAz1oT8HGaMNEBLC+JytRleg4GEKyBk2ON5mR780oL6A79XNvYtQNqzt52z7N
         7+mQW/8lwDrX+KlHM9+GSu9Fvkdk1BflR4RBXpPRNYs0TcwQux9fRhqyi9ymUs8xokGF
         IxYPj3UoNBpYHjmGnY5rWkq5p+edmaenaS8KiGGT80LjHxQRMXv3QwYkLCnZpbFuP/kO
         1lzIWOAPWC+VkWPxvuDy0FvWhQLnfSHMRDXiT2LvVzZ4IUFwX4IziTSi0Tgy90UQ2ZNc
         swhowaW87GTQWJXIoVlsho8iuvO+WhRMC/S6u1zj9l0v6C64IlNcvVhzS8KpQt232xgQ
         ibNQ==
X-Gm-Message-State: AOJu0Yy2/fjKeHDsn9bXqMkkhjxvvHDIyvDRhH4XheclKM0J4bnDM3a0
        Ajd/3PC0vP3kyfi8GKS0EghFiCmYijZS/+zfCCfJhw==
X-Google-Smtp-Source: AGHT+IFqL0pfdNfEWIZn8u3qSj/0LPOU2mPsKtOZnp4OjF2evlrmW8cqhJ3XupOOj5c2cRH/ZWnXdCm5O18SK7V080k=
X-Received: by 2002:a05:622a:1106:b0:403:e1d1:8b63 with SMTP id
 e6-20020a05622a110600b00403e1d18b63mr11535qty.24.1692119778732; Tue, 15 Aug
 2023 10:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
 <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch> <CAMkAt6q1ZedWBQ+ZLmD5QRKc0jcz2nrdwEAw6g8R2fZ5e2ed_A@mail.gmail.com>
In-Reply-To: <CAMkAt6q1ZedWBQ+ZLmD5QRKc0jcz2nrdwEAw6g8R2fZ5e2ed_A@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 15 Aug 2023 10:16:07 -0700
Message-ID: <CAAH4kHYCofTtdjpxKMLO8CMX6kZjQUG69mbbwerwuW0Pk6up9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
To:     Peter Gonda <pgonda@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-coco@lists.linux.dev, Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Why do we need to be so prescriptive about "boot time" vs "runtime"
> attestations? A user may wish to attest to several requests as Jeremi
> notes. And why should users be forced into using a vTPM interface if
> their usecase doesn't require all the features and complexity of a
> vTPM? Some users may prefer less overall code within their Trusted
> Computer Base (TCB) and a TPM emulate is a significant code base.
>

I agree, and I was a bit too hasty to acquiesce to sysfs due to the
TPM argument that really only applies for SEV-SNP without a whole lot
of extra work for other backends (not to say SVSM isn't itself a whole
lot of extra work).

> It seems like you are just reading the SNP spec, if you read the TDX
> spec you'll see there are RTMRs which can be extended with new data.
> This leads to a different data in the attestation. Similar there are
> REMs in the ARM CCA spec.
>

I'll add a note here that measurement registers are extensible at any
point by ring0, and there should be an API for doing so, the way that
there is for /dev/tpmX.

It could be /dev/teemr or something to unify TDX, COVE, ARM CCA, and
potentially a measurement register protocol extension to SEV-SNP's
SVSM.
I'm not sure how Intel is going to propose abstracting TCG Canonical
Event Log measurements to reuse measurement-to-PCR<X> code points in
the kernel as measurement-to-MR<f(X)>, or whatnot, but each technology
should have that implementation option to extend their own measurement
registers (and event log, potentially).

I (and probably James) object with just saying the PCRs are going to
xyz-measurement-register for simulating that integrity part of a TPM
to get just the quote aspect and not the rest of TPM 2.0 to hide
everything behind the TPM abstraction. It doesn't follow the Tcg spec.

But I repeat myself. If we use any ioctl, we'll end up multiplexing
the input per-technology, and at that point we essentially have
manufacturer-specific devices much to Dan's dismay.

Sysfs will certainly not be okay for measurement register-only
technology, since there's no way to not use a hardware attestation to
securely track measurement changes past "the static boot" (PCRs 0-7).
I don't want to have to rely on enclave-like peer VMs that perform the
TPM behavior.

-- 
-Dionna Glaze, PhD (she/her)
