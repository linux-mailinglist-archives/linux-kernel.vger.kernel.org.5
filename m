Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835CB79D878
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjILSOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjILSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:14:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C01115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:14:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b50b45481so53740397b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694542467; x=1695147267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snTjjO2+oBHxdApaWLIX6yKy63u0n3dmVw5Yuv2gv3g=;
        b=G8J4xJ8AH2OHybP0amNaiSIDhqKouMZTN+4FZPa0ia9hQGy4goyoHVnPGSdQl23WhT
         mVRRycU7/FFyk9exfrHiCQJ4tXfNdFY+kiLvJz568RzeLVm9l02LoonO9C9ilxndPYE6
         QFN0ksSVH0KrVI3RfIcJM8EUFdb9IJqstQd6tdO+jEEKZLRpnnhGUoEcSo5WctrdDwfC
         XDFVYcnmkVm9NJBq+GDQ/7m2ITGmPM/YzilG52/jFtkvmgv+kH4ylhHzJNsVXZhmpIT8
         KIhyEmVBoBxxQDJSq2ROH4JcWQZohzdwPE1j+1eur9PloZbzXQgdDJdcNPz8oqgPXzj2
         O4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542467; x=1695147267;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snTjjO2+oBHxdApaWLIX6yKy63u0n3dmVw5Yuv2gv3g=;
        b=k6dVDfUoJlyWl1Q9ZjvLsccUobJDmFAawCD6qWduys+5Ixy+TvnKUZw9r7ashQ8qxY
         Zv84AJ3LObNNHZMO/XD7zooT8DKo8c6N39nYF18yejCBVL3eZhJ81LnrASl1RbA/tlkO
         Ra/TrI9DNb2BcI1CsKqpt3s0XGN/i5mvPcBffBaOnzqjiOA7BkWQS+5B2BYasWlGFRUN
         5+r5SFeuxAFGFapR27KNCk9o2C4Do59JFUtCIiH37qCLqEDb5y1eWgiV8pIKJwKX8p0k
         m2GqE0ZeMwih6rerSMpK6pipu57EFKUP0o/N5rh+qaZNJfT+cIx8KATGBETqztKXR7ri
         CSuw==
X-Gm-Message-State: AOJu0Yx3VlElmbcNK/c49seB9Df4CvlArNcEVAy3gk1LU+oKevv8NNd9
        7WoHgJOR0Fw76g9jdLMIqoI7a3hRSlk=
X-Google-Smtp-Source: AGHT+IGGvuLPUOTsIVbbFqNNzgQV362Fk9hWiiR/0vEVh1OByXDPWDvn75UNdoCwdBbtEiJkE3Hm0WgCx+g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d292:0:b0:d7e:752f:baee with SMTP id
 j140-20020a25d292000000b00d7e752fbaeemr2466ybg.10.1694542466862; Tue, 12 Sep
 2023 11:14:26 -0700 (PDT)
Date:   Tue, 12 Sep 2023 18:14:25 +0000
In-Reply-To: <CAGD3tSzxgSmuC8MOt_Wek3rkO4gjT908x0bF2MNYot1W=FBcow@mail.gmail.com>
Mime-Version: 1.0
References: <20230912161518.199484-1-hshan@google.com> <ZQCayNY+8PYvfc40@google.com>
 <CAGD3tSzxgSmuC8MOt_Wek3rkO4gjT908x0bF2MNYot1W=FBcow@mail.gmail.com>
Message-ID: <ZQCqgenuRcB4c6/R@google.com>
Subject: Re: [PATCH] KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.
From:   Sean Christopherson <seanjc@google.com>
To:     Haitao Shan <hshan@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please send mail as plain text, most of the mailing lists reject HTML, and =
in
general HTML makes everyone grumpy.

On Tue, Sep 12, 2023, Haitao Shan wrote:
> On Tue, Sep 12, 2023 at 10:07=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com>
> wrote:
>=20
> > Aha!  And I think the new apicv_pre_state_restore() needs to be invoked
> > even if APICv is not active, because I don't see anything that purges t=
he
> > PIR when APICv is enabled.  VMX's APICv doesn't have many inhibits that=
 can
> > go away, and I highly doubt userspace will restore into a vCPU with pen=
ding
> > posted interrupts, so in practice this is _extremely_ unlikely to be
> > problematic.  But it's still wrong.
> >
> Thanks for sharing what you would like to fix the bug. I will write a v2 =
for
> that.  Actually, I am sorry that I forgot to add RFC to the title, as I
> personally did not think the proposed fix looks clean.

No worries, thanks for taking this on!
